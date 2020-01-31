connection: "clickhouse"

#include: "/views/*.view.lkml"                # include all views in the views/ folder in this project
#include: "/**/view.lkml"                   # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard
include: "*.view.lkml"
# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#
# explore: order_items {
#   join: orders {
#     relationship: many_to_one
#     sql_on: ${orders.id} = ${order_items.order_id} ;;
#   }
#
#   join: users {
#     relationship: many_to_one
#     sql_on: ${users.id} = ${orders.user_id} ;;
#   }
# }

explore: person {
  label: "Person and Travel Activity Data"
  join: travel_activity {
    sql_on: ${person.id} = ${travel_activity.person_id} ;;
    relationship: one_to_many
  }
}

explore: travel_activity {
  join: travel_segment {
    sql_on: ${travel_activity.id} = ${travel_segment.activity_id} ;;
    relationship: one_to_many
  }
}

explore: travel_segment {
}
