defmodule CourseHub.Accounts.Account do
  @doc """
  Account schema
  """
  use CourseHub, :schema

  @type t :: %__MODULE__{email: String.t(), name: String.t(), password_hash: String.t()}

  schema "accounts" do
    field(:email, :string)
    field(:name, :string)
    field(:password_hash, :string)
    field(:password, :string, virtual: true)

    timestamps()
  end

  @required_fields ~w(email name password)a
  @all_fields @required_fields
  def changeset(account, params) do
    account
    |> cast(params, @all_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:email)
    |> put_password()
  end

  defp put_password(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    put_change(changeset, :password_hash, Bcrypt.hash_pwd_salt(password))
  end

  defp put_password(changeset), do: changeset
end
