defmodule CourseHub.Test.Support.Factories do
  use ExMachina.Ecto, repo: CourseHub.Repo

  def account_factory do
    %CourseHub.Accounts.Account{
      name: "Jhon Doe",
      email: "jhon@email.com",
      password_hash: Bcrypt.hash_pwd_salt("123")
    }
  end
end
