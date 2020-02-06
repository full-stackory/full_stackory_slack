defmodule FullStackorySlackWeb.WebhookHelpers do
  # Original copy pasted from https://github.com/code-corps/stripity_stripe/blob/master/test/stripe/webhook_test.exs

  import Plug.Conn

  @secret Application.get_env(:full_stackory_slack, :stripe_http_secret)

  @spec create_request(Plug.Conn.t(), String.t(), map) :: tuple
  def create_request(conn, action, attrs \\ %{}) do
    timestamp = System.system_time(:second)
    payload = generate_payload(action, attrs)

    {payload, timestamp}
    |> generate_signature()
    |> create_signature_header()
    |> set_stripe_sig_header(conn)
    |> conn_and_payload_tuple(payload)
  end

  defp generate_payload(action, attrs) do
    Jason.encode!(%{data: %{object: attrs}, type: action, object: "event"})
  end

  defp generate_signature({payload, timestamp}, secret \\ @secret) do
    {
      :sha256
      |> :crypto.hmac(secret, "#{timestamp}.#{payload}")
      |> Base.encode16(case: :lower),
      timestamp
    }
  end

  defp create_signature_header({signature, timestamp}) do
    "t=#{timestamp},v1=#{signature}"
  end

  # End of copy paste

  defp set_stripe_sig_header(signature, conn) do
    conn
    |> put_req_header("stripe-signature", signature)
    |> put_req_header("content-type", "application/json")
  end

  defp conn_and_payload_tuple(conn, payload), do: {conn, payload}
end
