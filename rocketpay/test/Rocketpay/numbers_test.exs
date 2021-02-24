defmodule Rocketpay.NumbersTest do
  use ExUni.Case

  alias Rocketpay.Numbers


  describe "sum_from_file/1" do

      test "when there is a file whit the given name, returns the sum of numbers" do

        response = Numbers.sum_from_file("numbers")

        expected_response = {:ok, %{result: 37}}

        assert response == expected_response
      end

  end

end
