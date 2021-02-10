defmodule CourseHub.Test.Support.Factories do
  use ExMachina.Ecto, repo: CourseHub.Repo

  alias CourseHub.Accounts.Account
  alias CourseHub.Financials.Offer
  alias CourseHub.Universities.{Campus, Course, University}

  def account_factory do
    %Account{
      name: Faker.Person.name(),
      email: Faker.Internet.email(),
      password_hash: Bcrypt.hash_pwd_salt("123")
    }
  end

  def university_factory do
    %University{
      name: Faker.Company.name(),
      score: Faker.random_uniform(),
      logo_url: Faker.Internet.url()
    }
  end

  def campus_factory do
    %Campus{
      name: Faker.Address.street_name(),
      city: Faker.Address.city(),
      university: build(:university)
    }
  end

  def course_factory do
    [name, kind] =
      sequence(:name, [["Math", "exacts"], ["Biology", "biologics"], ["Law", "humanities"]])

    %Course{
      name: name,
      shift: sequence(:shift, ["morning", "evening", "night", "fulltime"]),
      level: sequence(:level, ["1", "2", "3"]),
      kind: kind
    }
  end

  def offer_factory do
    price = Faker.Commerce.price()

    %Offer{
      full_price: price,
      enrollment_semester: sequence(:enrollment_semester, ["1", "2"]),
      discount_percentage: 0.1,
      price_with_discount: price - price * 0.1,
      enabled: true,
      start_date: Faker.Date.between(~D[2010-01-01], ~D[2046-12-23]),
      course: build(:course)
    }
  end
end
