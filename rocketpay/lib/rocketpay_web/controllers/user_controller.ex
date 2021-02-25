defmodule RocketpayWeb.UsersController do
  use RocketpayWeb, :controller

  alias Rocktwpay.Users

  def create (conn, params) do

    params
      |> Rocketpay.create_user()
      |> handle_response(conn)
  end

  defp handle_response ({:ok, %User{} = user}, conn) do

    conn
      |> put_satus(:created) # (201)
      |> render("create.json", user: user)
  end

  defp handle_response({:error, result}, conn) do

    conn
      |> put_status(:bad_request)
      |> put_view(rocketpayWeb.ErrorView)
      |> render("400.json", result: result)
  end
end
