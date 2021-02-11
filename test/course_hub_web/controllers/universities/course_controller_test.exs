defmodule CourseHubWeb.Universities.CourseControllerTest do
  use CourseHubWeb.ConnCase, async: true

  @courses_uri "api/v1/courses"

  describe "courses/2" do
    setup %{conn: conn} do
      account = insert(:account)
      {:ok, token, _} = CourseHubWeb.Guardian.encode_and_sign(account)

      auth_conn = put_req_header(conn, "authorization", "Bearer #{token}")

      %{auth_conn: auth_conn}
    end

    test "returns the data structure", %{auth_conn: conn} do
      conn = get(conn, @courses_uri)

      assert %{
               "status" => "ok",
               "data" => [
                 %{
                   "kind" => _,
                   "level" => _,
                   "name" => _,
                   "shift" => _,
                   "university" => %{
                     "logo_url" => _,
                     "name" => _,
                     "score" => _
                   },
                   "campus" => %{
                     "city" => _,
                     "name" => _
                   }
                 }
                 | _
               ]
             } = json_response(conn, 200)
    end

    test "returns courses", %{auth_conn: conn} do
      conn = get(conn, @courses_uri)

      assert %{"status" => "ok", "data" => courses} = json_response(conn, 200)
      assert Enum.count(courses) == 6
    end

    test "works with offset and limit", %{auth_conn: conn} do
      insert_list(4, :course)
      [course, _] = insert_list(2, :course, name: "Test")
      conn = get(conn, @courses_uri, %{"offset" => 10, "limit" => 1})

      assert %{"status" => "ok", "data" => [result]} = json_response(conn, 200)

      assert result["name"] == course.name
    end

    test "filters by kind", %{auth_conn: conn} do
      conn = get(conn, @courses_uri, %{"kind" => "humanities"})

      assert %{"status" => "ok", "data" => courses} = json_response(conn, 200)
      refute Enum.any?(courses, &(&1["kind"] != "humanities"))
    end

    test "filters by university_name", %{auth_conn: conn} do
      conn = get(conn, @courses_uri, %{"university_name" => "C"})

      assert %{"status" => "ok", "data" => courses} = json_response(conn, 200)
      refute Enum.any?(courses, &(&1["university"]["name"] != "C"))
    end

    test "filters by level", %{auth_conn: conn} do
      conn = get(conn, @courses_uri, %{"level" => "1"})

      assert %{"status" => "ok", "data" => courses} = json_response(conn, 200)
      refute Enum.any?(courses, &(&1["level"] != "1"))
    end

    test "filters by city", %{auth_conn: conn} do
      conn = get(conn, @courses_uri, %{"city" => "Small City"})

      assert %{"status" => "ok", "data" => courses} = json_response(conn, 200)
      refute Enum.any?(courses, &(&1["campus"]["city"] != "Small City"))
    end

    test "filters by shift", %{auth_conn: conn} do
      conn = get(conn, @courses_uri, %{"shift" => "morning"})

      assert %{"status" => "ok", "data" => courses} = json_response(conn, 200)
      refute Enum.any?(courses, &(&1["shift"] != "morning"))
    end

    test "returns unauthenticated", %{conn: conn} do
      conn = get(conn, @courses_uri)

      assert %{"message" => "unauthenticated"} = json_response(conn, 401)
    end
  end
end
