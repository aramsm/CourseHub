defmodule CourseHubWeb.Accounts.AccountControllerTest do
  use CourseHubWeb.ConnCase, async: true

  @sign_in_uri "api/v1/sign_in"

  describe "sign_in/2" do
    setup %{conn: conn} do
      insert(:account, name: "Test", email: "test@mail.com", password: "123")

      %{conn: conn}
    end

    test "returns 200 when account is authenticated", %{conn: conn} do
      conn = post(conn, @sign_in_uri, %{"email" => "test@mail.com", "password" => "123"})

      assert %{"status" => "ok", "data" => %{"name" => "Test", "token" => token}} =
               json_response(conn, 200)
    end

    test "returns 401 when account is unauthenticated", %{conn: conn} do
      conn = post(conn, @sign_in_uri, %{"email" => "test@mail.com", "password" => "321"})

      assert %{"status" => "unauthenticated"} = json_response(conn, 401)
    end

    test "returns 404 when account is invalid", %{conn: conn} do
      conn = post(conn, @sign_in_uri, %{"email" => "invalid@mail.com", "password" => "123"})

      assert %{"status" => "invalid account"} = json_response(conn, 404)
    end
  end
end
