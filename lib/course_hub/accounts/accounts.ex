defmodule CourseHub.Accounts do
  @moduledoc """
  The Accounts context.
  """

  use CourseHub, :context

  alias CourseHub.Accounts.Account

  @doc """
  Gets a single account.

  Returns `nil` if the Account does not exist.

  ## Examples

      iex> get_account(%{id: id})
      %Account{}

      iex> get_account(%{id: "321"})
      nil

  """
  def get_account(%{id: id}), do: Repo.get(Account, id)
  def get_account(%{email: email}), do: Repo.get_by(Account, email: email)
  def get_account(_), do: nil

  @doc """
  Creates a account.

  ## Examples

      iex> create_account(%{field: value})
      {:ok, %Account{}}

      iex> create_account(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_account(params \\ %{}) do
    %Account{}
    |> Account.changeset(params)
    |> Repo.insert()
  end

  @doc """
  Updates a account.

  ## Examples

      iex> update_account(account, %{field: new_value})
      {:ok, %Account{}}

      iex> update_account(account, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_account(%Account{} = account, params) do
    account
    |> Account.update_changeset(params)
    |> Repo.update()
  end

  @doc """
  Logs the account in the system
  """

  def sign_in(%Account{} = account, password) do
    Bcrypt.check_pass(account, password)
    |> case do
      {:ok, _} -> {:ok, true}
      _ -> {:error, false}
    end
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking account changes.

  ## Examples

      iex> change_account(account)
      %Ecto.Changeset{data: %Account{}}

  """
  def change_account(%Account{} = account, params \\ %{}) do
    Account.changeset(account, params)
  end
end
