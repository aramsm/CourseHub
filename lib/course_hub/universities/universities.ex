defmodule CourseHub.Universities do
  use CourseHub, :context

  alias CourseHub.Queries.FilterBy
  alias CourseHub.Universities.{Campus, Course, University}

  ##########
  # Campus #
  ##########

  @spec create_campus(params :: map()) :: {:ok, Campus.t()} | {:error, Ecto.Changeset.t()}
  def create_campus(params) do
    %Campus{}
    |> Campus.changeset(params)
    |> Repo.insert()
  end

  @spec update_campus(campus :: Campus.t(), params :: map()) ::
          {:ok, Campus.t()} | {:error, Ecto.Changeset.t()}
  def update_campus(%Campus{} = campus, params) do
    campus
    |> Campus.changeset(params)
    |> Repo.update()
  end

  @spec delete_campus(campus :: Campus.t()) :: {:ok, Campus.t()} | {:error, Ecto.Changeset.t()}
  def delete_campus(%Campus{} = campus) do
    campus
    |> Campus.changeset()
    |> Repo.delete()
  end

  ##########
  # Course #
  ##########

  @spec get_course(id :: binary) :: Course.t()
  def get_course(id) when is_binary(id) do
    Repo.get(Course, id)
  end

  @spec get_courses(params :: map()) :: List.t()
  def get_courses(params \\ %{}) do
    limit = Map.get(params, "limit", 10)
    offset = Map.get(params, "offset", 0)

    Course
    |> join(:inner, [schema], u in assoc(schema, :university))
    |> join(:inner, [schema, u], c in assoc(schema, :campus))
    |> FilterBy.filter_by(:courses, params)
    |> select([schema, u, c], [schema, u, c])
    |> limit(^limit)
    |> offset(^offset)
    |> Repo.all()
  end

  @spec create_course(params :: map()) :: {:ok, Course.t()} | {:error, Ecto.Changeset.t()}
  def create_course(params) do
    %Course{}
    |> Course.changeset(params)
    |> Repo.insert()
  end

  @spec update_course(course :: Course.t(), params :: map()) ::
          {:ok, Course.t()} | {:error, Ecto.Changeset.t()}
  def update_course(%Course{} = course, params) do
    course
    |> Course.changeset(params)
    |> Repo.update()
  end

  @spec delete_course(course :: Course.t()) :: {:ok, Course.t()} | {:error, Ecto.Changeset.t()}
  def delete_course(%Course{} = course) do
    course
    |> Course.changeset()
    |> Repo.delete()
  end

  ##############
  # University #
  ##############

  @spec create_university(params :: map()) :: {:ok, University.t()} | {:error, Ecto.Changeset.t()}
  def create_university(params) do
    %University{}
    |> University.changeset(params)
    |> Repo.insert()
  end

  @spec update_university(university :: University.t(), params :: map()) ::
          {:ok, University.t()} | {:error, Ecto.Changeset.t()}
  def update_university(%University{} = university, params) do
    university
    |> University.changeset(params)
    |> Repo.update()
  end

  @spec delete_university(university :: University.t()) ::
          {:ok, University.t()} | {:error, Ecto.Changeset.t()}
  def delete_university(%University{} = university) do
    university
    |> University.changeset()
    |> Repo.delete()
  end
end
