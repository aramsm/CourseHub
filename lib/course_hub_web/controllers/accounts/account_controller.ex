defmodule CourseHubWeb.Accounts.AccountController do
  use CourseHubWeb, :controller

  alias CourseHub.Accounts

  def sign_in(conn, %{"email" => email, "password" => pass}) do
    Accounts.get_account(%{email: email})
    |> case do
      nil ->
        conn
        |> put_status(404)
        |> json(%{status: "invalid account"})

      account ->
        Accounts.sign_in(account, pass)
        |> case do
          {:ok, _} ->
            {:ok, token, _} = CourseHubWeb.Guardian.encode_and_sign(account)

            conn
            |> put_resp_header("token", token)
            |> render("sign_in.json", %{account: account, token: token})

          {:error, _} ->
            conn
            |> put_status(401)
            |> json(%{status: "unauthenticated"})
        end
    end
  end
end
