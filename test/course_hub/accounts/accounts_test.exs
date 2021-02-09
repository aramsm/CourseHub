defmodule CourseHub.AccountsTest do
  use CourseHub.DataCase, async: true

  alias CourseHub.Accounts
  alias CourseHub.Accounts.Account

  @valid_attrs %{name: "Cleber", email: "cleb@email.com", password: "123"}
  @update_attrs %{name: "Kleber"}
  @invalid_attrs %{name: nil}

  setup do
    account = insert(:account)

    %{account: account}
  end

  describe "get_account/1" do
    test "returns the account with given id", %{account: account} do
      result = Accounts.get_account(%{id: account.id})
      assert result.id == account.id
    end

    test "returns the account with given email", %{account: account} do
      result = Accounts.get_account(%{email: account.email})
      assert result.id == account.id
    end

    test "returns nil with invalid id" do
      refute Accounts.get_account(%{id: Ecto.UUID.generate()})
    end

    test "returns nil with invalid email" do
      refute Accounts.get_account(%{email: "invalid"})
    end
  end

  describe "create_account/1" do
    test "creates a account" do
      assert {:ok, %Account{name: name, email: email, password_hash: password_hash}} =
               Accounts.create_account(@valid_attrs)

      assert name == @valid_attrs.name
      assert email == @valid_attrs.email
      assert Bcrypt.verify_pass(@valid_attrs.password, password_hash)
    end

    test "returns error changeset with same email ", %{account: account} do
      assert {:error, %Ecto.Changeset{} = changeset} =
               Accounts.create_account(%{
                 name: @valid_attrs.name,
                 email: account.email,
                 password: "9958"
               })

      assert %{email: ["has already been taken"]} = errors_on(changeset)
    end

    test "returns error changeset with invalid data " do
      assert {:error, %Ecto.Changeset{} = changeset} = Accounts.create_account(%{})

      assert %{email: ["can't be blank"], name: ["can't be blank"], password: ["can't be blank"]} =
               errors_on(changeset)
    end
  end

  describe "update_account/2" do
    test "updates the account", %{account: account} do
      assert {:ok, %Account{name: name}} = Accounts.update_account(account, @update_attrs)
      assert name == @update_attrs.name
    end

    test "returns error changeset with invalid data", %{account: account} do
      assert {:error, %Ecto.Changeset{} = changeset} =
               Accounts.update_account(account, @invalid_attrs)

      assert %{name: ["can't be blank"]} = errors_on(changeset)
    end

    test "returns error changeset with same email", %{account: account} do
      other_account = insert(:account)

      assert {:error, %Ecto.Changeset{} = changeset} =
               Accounts.update_account(other_account, %{email: account.email})

      assert %{email: ["has already been taken"]} = errors_on(changeset)
    end
  end

  describe "sign_in" do
    test "returns ok for valid pass", %{account: account} do
      assert {:ok, _} = Accounts.sign_in(account, "123")
    end

    test "returns error for invalid pass", %{account: account} do
      assert {:error, _} = Accounts.sign_in(account, "321")
    end
  end

  test "change_account/1 returns a account changeset", %{account: account} do
    assert %Ecto.Changeset{} = Accounts.change_account(account)
  end
end
