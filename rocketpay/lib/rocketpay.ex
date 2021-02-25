defmodule Rocketpay do

  alias Rocketpay.Users.Create, as: Usercreate

  defdelegate create_user(params), to: UserCreate, as: :call

end
