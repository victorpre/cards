defmodule Cards do
  @moduledoc """
  Documentation for Cards.

  Provides methods for creating and handling a deck of cards.
  """

  @doc """
    Returns a list of strings representing a deck of playing cards.
  """
  def create_deck do
    values = ["A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "Q", "J", "K"]
    suits  = ["Spades", "Clubs", "Hearts", "Diamonds"]

    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end
  end

  @doc """
    Shuffles a list of strings representing playing cards
  """
  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
   Checks if a string representing a playing card is contained inside a deck of playing cards.

  ## Examples

      iex> deck = Cards.create_deck
      iex> Cards.contains?(deck, "A of Spades")
      true
  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
    Divides a deck into a hand and the remainder of the deck.
    The `hand_size` argument indicates how may cards should be
    in the hand.

  ## Examples

      iex> deck = Cards.create_deck
      iex> {hand, deck} = Cards.deal(deck, 1)
      iex> hand
      ["A of Spades"]
  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  def create_hand(hand_size) do
    Cards.create_deck
    |> Cards.shuffle #first argument is deck
    |> Cards.deal(hand_size) #first argument is deck
  end

  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _reason} -> "File does not exist."
    end
  end
end
