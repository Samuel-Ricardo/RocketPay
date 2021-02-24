defmodule Rocketpay.Numbers do

  def sum_from_file(filename) do

    "#{filename}.csv"
      |>File.read()
      |>handle_file()
  end

  defp handle_file({:ok, numbers}) do

    numbers = numbers

    |> String.split(",")
    |> Enum.map(fn number -> String.to_integer(number) end)
    |> Enum.sum()

    {:ok, %{result: numbers}}

  end
  defp handle_file({:error, _reason}), do: {:error,"Error: Invalid File"}
end

# String./ - para ver todos os metodos no terminal

# h String.split - documentaçao do metodo no terminal
