defmodule CourseHub.Queries.FilterBy do
  import Ecto.Query

  def filter_by(query, identifier, params \\ nil)

  def filter_by(query, _identifier, nil), do: query

  def filter_by(query, identifier, params) do
    conditions = walk_filter(true, identifier, params)

    query
    |> where(^conditions)
  end

  defp walk_filter(conditions, :courses, %{"kind" => kind} = params) do
    dynamic([schema], schema.kind == ^kind and ^conditions)
    |> walk_filter(:courses, Map.drop(params, ["kind"]))
  end

  defp walk_filter(conditions, :courses, %{"level" => level} = params) do
    dynamic([schema], schema.level == ^level and ^conditions)
    |> walk_filter(:courses, Map.drop(params, ["level"]))
  end

  defp walk_filter(conditions, :courses, %{"shift" => shift} = params) do
    dynamic([schema], schema.shift == ^shift and ^conditions)
    |> walk_filter(:courses, Map.drop(params, ["shift"]))
  end

  defp walk_filter(conditions, :offers, %{"course_name" => course_name} = params) do
    dynamic([schema, u, ca, c], c.name == ^course_name and ^conditions)
    |> walk_filter(:offers, Map.drop(params, ["course_name"]))
  end

  defp walk_filter(conditions, identifier, %{"university_name" => university_name} = params) do
    dynamic([schema, u], u.name == ^university_name and ^conditions)
    |> walk_filter(identifier, Map.drop(params, ["university_name"]))
  end

  defp walk_filter(conditions, identifier, %{"city" => city} = params) do
    dynamic([schema, u, ca], ca.city == ^city and ^conditions)
    |> walk_filter(identifier, Map.drop(params, ["city"]))
  end

  defp walk_filter(conditions, _identifier, _params), do: conditions
end
