defmodule SplitIntegersList do
  @moduledoc"""
  This module only has one function, for more info take a look to
  SplitList.build_lists/2
  """
  
    @doc"""
      This function recieves an integer and a keyword list with
      :positive, :negative and :zero as keys and a an empty list for each one.
      
      ## TODO add examples for doctest
    """
    @spec build_lists(integer(), Keyword.t()) :: Keyword.t()
    def build_lists(num, keyword_list \\ [positive: [], negative: [], zero: []]) do

      case parse_num(num) do
        {:positive, value} -> update_keyword_list(keyword_list, :positive, value)
        {:negative, value} -> update_keyword_list(keyword_list, :negative, value)
        {:zero, value} -> update_keyword_list(keyword_list, :zero, value)
        _ -> "NaN"
      end
    end
    
    @spec update_keyword_list(Keyword.t(), atom(), integer()) :: Keyword.t()
    defp update_keyword_list(keyword_list, key, new_value) do
        updated_list = keyword_list
          |> Keyword.get(key)
          |> Kernel.++([new_value])
        
        Keyword.put(keyword_list, key, updated_list)
    end
    
    @spec parse_num(integer()) :: {:positive | :negative | :zero, integer()} | nil
    defp parse_num(num) when num > 0, do: {:positive, num}
    
    defp parse_num(num) when num < 0, do: {:negative, num}
    
    defp parse_num(num) when num == 0, do: {:zero, num}
    
    defp parse_num(_num), do: nil

end

nums = [1,-22,0,3,0,4,-5,3]

result = Enum.reduce(nums, [positive: [], negative: [], zero: []], &SplitIntegersList.build_lists(&1, &2))
IO.inspect(result)
# [positive: [1, 3, 4, 3], negative: [-22, -5], zero: [0, 0]]
