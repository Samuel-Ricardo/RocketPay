defmodule RocketpayWeb.UsersViewTest do
  use RocketpayWeb.ConnCase, async: true

  import Phoenix.View

  alias Rocketpay.{Account,User}
  alias RocketpayWeb.UsersView

  test "render creae.json" do


    params = %{

      name: "Ricardo",
      password: "1234567890",
      nickname: "Riccardo",
      email: "ricardo@gmail.com",
      age: 23
    }

    {:ok, %User{id: user_id, account: %Account{id: account_id}}} = Rocketpay.create_user(params)

    response = render(UsersView, "creae.json", user: user)

    expected_response = %{

      message: "User Created",
      user: %{
        account: %{
          balance: Decimal.new("0.00"),
          id: account_id
        },
        id: user_id,
        name: "Ricardo",
        nickname: "RIccardo"
      }
    }

    assert expected_response == response

  end

 end
