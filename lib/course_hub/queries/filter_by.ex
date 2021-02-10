defmodule CourseHub.Queries.FilterBy do
  import Ecto.Query

  def filter_by(query, params \\ nil)

  def filter_by(query, nil), do: query

  def filter_by(query, params) do
    {conditions, query, _params} = walk_filter(true, query, params)

    query
    |> where(^conditions)
  end

  defp walk_filter(conditions, query, %{"kind" => kind} = params) do
    dynamic([schema], schema.kind == ^kind and ^conditions)
    |> walk_filter(query, Map.drop(params, ["kind"]))
  end

  defp walk_filter(conditions, query, %{"level" => level} = params) do
    dynamic([schema], schema.level == ^level and ^conditions)
    |> walk_filter(query, Map.drop(params, ["level"]))
  end

  defp walk_filter(conditions, query, %{"shift" => shift} = params) do
    dynamic([schema], schema.shift == ^shift and ^conditions)
    |> walk_filter(query, Map.drop(params, ["shift"]))
  end

  defp walk_filter(conditions, query, %{"university_name" => university_name} = params) do
    dynamic([schema, u, c], u.name == ^university_name and ^conditions)
    |> walk_filter(query, Map.drop(params, ["university_name"]))
  end

  defp walk_filter(conditions, query, params),
    do: {conditions, query, params}
end
