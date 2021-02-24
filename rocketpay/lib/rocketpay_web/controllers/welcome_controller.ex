defmodule RocketpayWeb.WelcomeController do
  use RocketpayWeb, :controller

  alias Rocketpay.Numbers

  def index(connection, %{"filename" => filename}) do

    filename
      |>Numbers.sum_from_file()
      |>handle_response()

  end

end
