defmodule CourseHubWeb.Financials.OfferControllerTest do
  use CourseHubWeb.ConnCase, async: true

  @offers_uri "api/v1/offers"

  describe "offers/2" do
    setup %{conn: conn} do
      account = insert(:account)
      {:ok, token, _} = CourseHubWeb.Guardian.encode_and_sign(account)

      auth_conn = put_req_header(conn, "authorization", "Bearer #{token}")

      %{auth_conn: auth_conn}
    end

    test "returns the data structure", %{auth_conn: conn} do
      conn = get(conn, @offers_uri)

      assert %{
               "status" => "ok",
               "data" => [
                 %{
                   "campus" => %{
                     "city" => _,
                     "name" => _
                   },
                   "course" => %{
                     "kind" => _,
                     "level" => _,
                     "name" => _,
                     "shift" => _
                   },
                   "discount_percentage" => _,
                   "enabled" => true,
                   "enrollment_semester" => _,
                   "full_price" => _,
                   "price_with_discount" => _,
                   "start_date" => _,
                   "university" => %{
                     "logo_url" => _,
                     "name" => _,
                     "score" => _
                   }
                 }
                 | _
               ]
             } = json_response(conn, 200)
    end

    test "returns offers", %{auth_conn: conn} do
      conn = get(conn, @offers_uri)

      assert %{"status" => "ok", "data" => offers} = json_response(conn, 200)
      assert Enum.count(offers) == 6
    end

    test "does not return disabled offers", %{auth_conn: conn} do
      insert(:offer, enabled: false)
      conn = get(conn, @offers_uri)

      assert %{"status" => "ok", "data" => results} = json_response(conn, 200)

      refute Enum.any?(results, &(&1["enabled"] == false))
    end

    test "works with offset and limit", %{auth_conn: conn} do
      insert_list(4, :offer)
      [offer, _] = insert_list(2, :offer, full_price: 10_000_000.73)
      conn = get(conn, @offers_uri, %{"offset" => 10, "limit" => 1})

      assert %{"status" => "ok", "data" => [result]} = json_response(conn, 200)

      assert result["full_price"] == offer.full_price
    end

    test "filters by city", %{auth_conn: conn} do
      conn = get(conn, @offers_uri, %{"city" => "Small City"})

      assert %{"status" => "ok", "data" => [offer]} = json_response(conn, 200)
      assert offer["campus"]["city"] == "Small City"
    end

    test "filters by university_name", %{auth_conn: conn} do
      conn = get(conn, @offers_uri, %{"university_name" => "C"})

      assert %{"status" => "ok", "data" => [offer]} = json_response(conn, 200)
      assert offer["university"]["name"] == "C"
    end

    test "filters by course_name", %{auth_conn: conn} do
      conn = get(conn, @offers_uri, %{"course_name" => "Math"})

      assert %{"status" => "ok", "data" => [offer]} = json_response(conn, 200)
      assert offer["course"]["name"] == "Math"
    end

    test "orders ascending by price_with_discount", %{auth_conn: conn} do
      conn =
        get(conn, @offers_uri, %{"asc" => "price_with_discount", "offset" => 0, "limit" => 3})

      assert %{"status" => "ok", "data" => [o1, o2, o3]} = json_response(conn, 200)

      assert o1["price_with_discount"] < o2["price_with_discount"]
      assert o2["price_with_discount"] < o3["price_with_discount"]
    end

    test "orders descending by price_with_discount", %{auth_conn: conn} do
      conn =
        get(conn, @offers_uri, %{"desc" => "price_with_discount", "offset" => 0, "limit" => 3})

      assert %{"status" => "ok", "data" => [o1, o2, o3]} = json_response(conn, 200)

      assert o1["price_with_discount"] > o2["price_with_discount"]
      assert o2["price_with_discount"] > o3["price_with_discount"]
    end

    test "returns unauthenticated", %{conn: conn} do
      conn = get(conn, @offers_uri)

      assert %{"message" => "unauthenticated"} = json_response(conn, 401)
    end
  end
end
