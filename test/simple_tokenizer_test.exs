defmodule SimpleTokenizerTest do
  use ExUnit.Case
  #doctest SimpleTokenizer

  @text """
    Optimus Prime is a Cybertronian, an extraterrestrial species of sentient
    self-configuring modular robotic lifeforms (e.g.: cars and other objects),
    a synergistic blend of biological evolution and technological engineering.
    In almost every version of the mythos, Optimus is the leader of the Autobots,
    a faction of Transformers who are rivals of the Decepticons, another faction.
    He is defined by his strong moral character and is almost always portrayed
    as the primary hero of the story, opposing the Decepticon leader Megatron.
    """

  @token [
    43453, 5183, 533, 320, 5830, 19057, 1800, 267, 550, 29082, 18597, 515,
    30217, 6330, 539, 19042, 621, 1322, 268, 616, 31513, 22437, 23975, 2666,
    5161, 263, 324, 269, 326, 15811, 3346, 537, 1010, 13770, 2361, 320, 22283,
    707, 1561, 10780, 539, 18821, 8902, 537, 23068, 5273, 269, 530, 2671, 1505,
    3273, 539, 518, 20322, 1299, 267, 43453, 533, 518, 3236, 539, 518, 3917,
    13721, 267, 320, 14629, 539, 17843, 822, 631, 15135, 539, 518, 33529, 890,
    708, 267, 1380, 14629, 269, 797, 533, 15278, 638, 787, 2389, 11246, 4009,
    537, 533, 2671, 1466, 36093, 601, 518, 5814, 3756, 539, 518, 1134, 267,
    24376, 518, 33529, 45996, 3236, 35581, 3372, 269
  ]

  setup_all do
    SimpleTokenizer.init
    :ok
  end
  
  test "encode a word" do
    assert [5830, 19057, 1800] ==
           SimpleTokenizer.encode("cybertronian")
  end

  test "encode a utf-8 word" do
    assert [4813, 30294, 107, 3909, 230, 4813, 484] ==
           SimpleTokenizer.encode("おはよう")
  end

  test "encode short text" do
    assert [4813, 30294, 107, 3909, 230, 4813, 484, 5830, 19057, 1800] ==
           SimpleTokenizer.encode("おはよう cybertronian")
  end

  test "cached word" do
    assert [49406] == SimpleTokenizer.encode("<|startoftext|>")
    assert [49407] == SimpleTokenizer.encode("<|endoftext|>")
  end
  
  test "encode long text" do
    assert @token == SimpleTokenizer.encode(@text)
  end
end
