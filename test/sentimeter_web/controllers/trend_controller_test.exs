defmodule SentimeterWeb.TrendControllerTest do
  use SentimeterWeb.ConnCase

  alias Sentimeter.Trends

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  def fixture(:trend) do
    {:ok, trend} = Trends.create_trend(@create_attrs)
    trend
  end

  describe "index" do
    test "lists all trends", %{conn: conn} do
      conn = get(conn, Routes.trend_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Trends"
    end
  end

  describe "new trend" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.trend_path(conn, :new))
      assert html_response(conn, 200) =~ "New Trend"
    end
  end

  describe "create trend" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.trend_path(conn, :create), trend: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.trend_path(conn, :show, id)

      conn = get(conn, Routes.trend_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Trend"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.trend_path(conn, :create), trend: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Trend"
    end
  end

  describe "edit trend" do
    setup [:create_trend]

    test "renders form for editing chosen trend", %{conn: conn, trend: trend} do
      conn = get(conn, Routes.trend_path(conn, :edit, trend))
      assert html_response(conn, 200) =~ "Edit Trend"
    end
  end

  describe "update trend" do
    setup [:create_trend]

    test "redirects when data is valid", %{conn: conn, trend: trend} do
      conn = put(conn, Routes.trend_path(conn, :update, trend), trend: @update_attrs)
      assert redirected_to(conn) == Routes.trend_path(conn, :show, trend)

      conn = get(conn, Routes.trend_path(conn, :show, trend))
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, trend: trend} do
      conn = put(conn, Routes.trend_path(conn, :update, trend), trend: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Trend"
    end
  end

  describe "delete trend" do
    setup [:create_trend]

    test "deletes chosen trend", %{conn: conn, trend: trend} do
      conn = delete(conn, Routes.trend_path(conn, :delete, trend))
      assert redirected_to(conn) == Routes.trend_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.trend_path(conn, :show, trend))
      end
    end
  end

  defp create_trend(_) do
    trend = fixture(:trend)
    {:ok, trend: trend}
  end
end