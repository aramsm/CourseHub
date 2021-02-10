# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     CourseHub.Repo.insert!(%CourseHub.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias CourseHub.{Accounts, Financials, Universities}

{:ok, uni_a} = Universities.create_university(%{name: "A", score: 9.0})
{:ok, uni_b} = Universities.create_university(%{name: "B", score: 6.7})

{:ok, uni_c} =
  Universities.create_university(%{
    name: "C",
    score: 8.3,
    logo_url: "https://gradeup.com.br/wp-content/uploads/2018/03/Dundee-University-logo.png"
  })

{:ok, campus_a_1} =
  Universities.create_campus(%{name: "Campus A1", city: "Big City", university_id: uni_a.id})

{:ok, campus_a_2} =
  Universities.create_campus(%{name: "Campus A2", city: "Big City", university_id: uni_a.id})

{:ok, campus_b_1} =
  Universities.create_campus(%{name: "Campus B1", city: "Small City", university_id: uni_b.id})

{:ok, campus_b_2} =
  Universities.create_campus(%{name: "Campus B2", city: "Big City", university_id: uni_b.id})

{:ok, campus_c_1} =
  Universities.create_campus(%{name: "Campus C1", city: "Big City", university_id: uni_c.id})

{:ok, course_a_1} =
  Universities.create_course(%{
    name: "Economics 1",
    kind: "humanities",
    level: "1",
    shift: "morning",
    university_id: uni_a.id,
    campus_id: campus_a_1.id
  })

{:ok, course_a_2} =
  Universities.create_course(%{
    name: "Math",
    kind: "exacts",
    level: "1",
    shift: "evening",
    university_id: uni_a.id,
    campus_id: campus_a_2.id
  })

{:ok, course_a_3} =
  Universities.create_course(%{
    name: "Economics 2",
    kind: "humanities",
    level: "2",
    shift: "night",
    university_id: uni_a.id,
    campus_id: campus_a_1.id
  })

{:ok, course_b_1} =
  Universities.create_course(%{
    name: "Mammals 1",
    kind: "biologics",
    level: "1",
    shift: "fulltime",
    university_id: uni_b.id,
    campus_id: campus_b_1.id
  })

{:ok, course_b_2} =
  Universities.create_course(%{
    name: "Mammals 2",
    kind: "biologics",
    level: "2",
    shift: "night",
    university_id: uni_b.id,
    campus_id: campus_b_2.id
  })

{:ok, course_c_1} =
  Universities.create_course(%{
    name: "Korean 1",
    kind: "languages",
    level: "1",
    shift: "fulltime",
    university_id: uni_c.id,
    campus_id: campus_c_1.id
  })

Financials.create_offer(%{
  full_price: 60.00,
  price_with_discount: 54.00,
  discount_percentage: 0.1,
  start_date: "04/01/2021",
  enrollment_semester: "1",
  enabled: true,
  course_id: course_a_1.id
})

Financials.create_offer(%{
  full_price: 70.21,
  price_with_discount: 63.00,
  discount_percentage: 0.1,
  start_date: "02/08/2021",
  enrollment_semester: "2",
  enabled: true,
  course_id: course_a_2.id
})

Financials.create_offer(%{
  full_price: 69.90,
  price_with_discount: 62.94,
  discount_percentage: 0.1,
  start_date: "04/01/2021",
  enrollment_semester: "1",
  enabled: true,
  course_id: course_a_3.id
})

Financials.create_offer(%{
  full_price: 120.00,
  price_with_discount: 108.00,
  discount_percentage: 0.1,
  start_date: "04/01/2021",
  enrollment_semester: "1",
  enabled: true,
  course_id: course_b_1.id
})

Financials.create_offer(%{
  full_price: 269.00,
  price_with_discount: 242.10,
  discount_percentage: 0.1,
  start_date: "02/08/2021",
  enrollment_semester: "2",
  enabled: true,
  course_id: course_b_2.id
})

Financials.create_offer(%{
  full_price: 119.99,
  price_with_discount: 107.99,
  discount_percentage: 0.1,
  start_date: "04/01/2021",
  enrollment_semester: "1",
  enabled: true,
  course_id: course_c_1.id
})

Financials.create_offer(%{
  full_price: 130.00,
  price_with_discount: 117.00,
  discount_percentage: 0.1,
  start_date: "04/01/2021",
  enrollment_semester: "1",
  enabled: false,
  course_id: course_c_1.id
})

Accounts.create_account(%{name: "Seed Studant", email: "study@email.com", password: "123456"})
