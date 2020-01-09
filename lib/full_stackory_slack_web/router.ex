defmodule FullStackorySlackWeb.Router do
  use FullStackorySlackWeb, :router
  alias FullStackorySlackWeb.Plugs.StripePlug

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :stripe_api do
    plug :accepts, ["json"]
    plug StripePlug
  end

  scope "/", FullStackorySlackWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/stripe", FullStackorySlackWeb.Stripe do
    pipe_through :stripe_api

    post "/customer", CustomerController, :create
    post "/invoice", InvoiceController, :create
    post "/subscription", SubscriptionController, :create
    post "/plan", PlanController, :create
  end
end
