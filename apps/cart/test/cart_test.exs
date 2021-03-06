defmodule CartTest do
  use ExUnit.Case
  doctest Cart

  test "creating a cart creates an empty cart" do
    assert Cart.new == %{current: [], events: []}
  end

  test "Cart.add should return a new cart with the item added to :current" do
    cart = Cart.new |> Cart.add("orange") |> Cart.add("apple")

    assert %{
      current: ["apple", "orange"],
      events: _
    } = cart
  end

  test "Cart.add should return a new cart with a new event prepended" do
    cart = Cart.new |> Cart.add("orange") |> Cart.add("apple")

    assert %{
      current: _,
      events: [
        {"apple", :add, _},
        {"orange", :add, _}
      ]
    } = cart
  end

  test "Cart.remove should return a new cart without the most recent added item that matches" do
    cart = %{
      current: ["apple", "orange"],
      events: []
    } |> Cart.remove("orange")

    assert %{
      current: ["apple"],
      events: _
    } = cart
  end

  test "Cart.remove should return a new cart with a new event prepended" do
    cart = %{
      current: ["apple", "orange"],
      events: [
        {"orange", :add, Timex.Time.now}
      ]
    } |> Cart.remove("orange")

    assert %{
      current: _,
      events: [
        {"orange", :remove, _},
        {"orange", :add, _}
      ]
    } = cart
  end

  @tag :skip
  test "events should contain timestamps" do
  end
end
