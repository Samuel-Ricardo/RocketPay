defmodule Rocketpay.Users.CreateTest  do
  use Rocketpay.DataCase

  alias Rocketpay.User
  alias Rocketpay.User.Create

  describe "call/1" do

    test "when all params are valid, returns an user" do

      params = %{

        name: "Ricardo",
        password: "1234567890",
        nickname: "Riccardo",
        email: "ricardo@gmail.com",
        age: 23
      }

      {:ok, %User{id: user_id}} = Create.call(params)
      user = Repo.get(User, user_id)

      assert %User{name: "Ricardo", nickname: "Riccardo", email: "ricardo@gmail.com", age: 23, id: ^user_id} = user
    end

    test "when params are in valid, returns an error" do

      params = %{

        name: "Ricardo",
        password: "1234",
        nickname: "Riccardo",
        email: "ricardo@gmail.com",
        age: 16
      }

      {:error, changeset} = Create.call(params)


      assert errors_on(changeset) == erros_on(changeset)
    end

  end
end
