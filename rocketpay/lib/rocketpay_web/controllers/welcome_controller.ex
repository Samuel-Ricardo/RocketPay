defmodule RocketpayWeb.WelcomeController do
  use RocketpayWeb, :controller

  alias Rocketpay.Numbers

  def index(connection, %{"filename" => filename}) do

    filename
      |>Numbers.sum_from_file()
      |>handle_response(connection)
  end

  defp handle_response({:ok, %{result: result}}, conn) do

    conn
      |> put_status(:ok)
      |> json(%{message: "Welcome to rocket API your number is: #{result}"})
  end

  defp handle_response({:error, reason}, conn) do

    conn
      |> put_status(:bad_request)
      |> json(reason)
  end

end
