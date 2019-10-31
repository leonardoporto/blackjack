defmodule Cards do
  @moduledoc """
    Providers methods for creating and handling a deck of cards
  """

  @doc """
    Returns a list of strings representing a deck of playing cards
  """
  def create_deck do
    values = ["A", "2", "3", "4", "5", "6", "7", "8", "9", "T", "J", "Q", "K"]
    suits = ["D", "C", "H", "S"]
    # solution - final
    for suit <- suits, value <- values do
      "#{value}#{suit}"
    end
  end

  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
    Determies whether a deck contains a given card

    ## Examples

        iex> deck = Cards.create_deck
        iex> Cards.contains?(deck, "6S")
        true

  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
    Divides a deck into a hand and the remainder of the deck.
    The `hand_size` argument indicates how many cards should
    be in the hand.

  ## Examples

        iex> deck = Cards.create_deck
        iex> {hand, _deck} = Cards.deal(deck, 2)
        iex> hand
        ["AD","2D"]

  """
  def deal(deck, size) do
    Enum.split(deck, size)
  end

  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _reason} -> "File not exists"
    end
  end

  def hand(hand_size) do
    Cards.create_deck()
    |> Cards.shuffle()
    |> Cards.deal(hand_size)
  end
end
