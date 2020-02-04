view: person {
  sql_table_name: replica.person ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}."id" ;;
  }

  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
  }

  dimension: age_tier {
    type: tier
    tiers: [5, 12, 18, 35, 50, 66]
    style: integer # the default value, could be excluded
    sql: ${age} ;;
  }

  dimension: commute_mode_id {
    type: number
    sql: ${TABLE}.commute_mode_id ;;
  }

  dimension: employment_id {
    type: number
    sql: ${TABLE}.employment_id ;;
  }

  dimension: employment_label {
    type: string
    case: {
      when: {
        sql: ${employment_id} = 0 ;;
        label: "Unknown"
      }
      when: {
        sql: ${employment_id} = 1 ;;
        label: "Employment"
      }
      when: {
        sql: ${employment_id} = 2 ;;
        label: "Unemployment"
      }
      when: {
        sql: ${employment_id} = 3 ;;
        label: "Not in Labor Force"
      }
    }
  }

  dimension: household_id {
    type: string
    sql: ${TABLE}.household_id ;;
  }

  dimension: household_income_bucket_id {
    type: number
    sql: ${TABLE}.household_income_bucket_id ;;
  }

  dimension: household_income_usd {
    type: number
    sql: ${TABLE}.household_income_usd ;;
  }

  dimension: household_income_tier {
    type: tier
    tiers: [15000, 25000, 50000, 75000, 100000, 150000, 200000]
    style: integer # the default value, could be excluded
    sql: ${household_income_usd} ;;
  }

  dimension: household_num_vehicles_id {
    type: number
    sql: ${TABLE}.household_num_vehicles_id ;;
  }

  dimension: household_num_vehicles_label {
    type: string
    case: {
      when: {
        sql: ${household_num_vehicles_id} = 0 ;;
        label: "Unknown"
      }
      when: {
        sql: ${household_num_vehicles_id} = 1 ;;
        label: "One vehicle"
      }
      when: {
        sql: ${household_num_vehicles_id} = 2 ;;
        label: "Two vehicles"
      }
      when: {
        sql: ${household_num_vehicles_id} = 3 ;;
        label: "Three or more vehicles"
      }
      when: {
        sql: ${household_num_vehicles_id} = 4 ;;
        label: "No vehicles"
      }
    }
  }

  dimension: household_size {
    type: number
    sql: ${TABLE}.household_size ;;
  }

  dimension: household_size_tier {
    type: tier
    tiers: [1, 2, 3, 4, 5, 6, 7, 8]
    style: integer # the default value, could be excluded
    sql: ${household_size} ;;
  }

  dimension: housing_unit_cell_id {
    type: string
    sql: ${TABLE}.housing_unit_cell_id ;;
  }

  dimension: income_bucket_id {
    type: number
    sql: ${TABLE}.income_bucket_id ;;
  }

  dimension: income_usd {
    type: number
    sql: ${TABLE}.income_usd ;;
  }

  dimension: office_unit_cell_id {
    type: string
    sql: ${TABLE}.office_unit_cell_id ;;
  }

  dimension: race_ethnicity_id {
    type: number
    sql: ${TABLE}.race_ethnicity_id ;;
  }

  dimension: race_ethnicity_label {
    type: string
    case: {
      when: {
        sql: ${race_ethnicity_id} = 0 ;;
        label: "Hispanic or Latino, Any race"
      }
      when: {
        sql: ${race_ethnicity_id} = 1 ;;
        label: "Black Non-hispanic/Latino"
      }
      when: {
        sql: ${race_ethnicity_id} = 2 ;;
        label: "White Non-hispanic/Latino"
      }
      when: {
        sql: ${race_ethnicity_id} = 3 ;;
        label: "Asian Non-hispanic/Latino"
      }
      when: {
        sql: ${race_ethnicity_id} = 4 ;;
        label: "Two or More Races Non-hispanic/Latino"
      }
      when: {
        sql: ${race_ethnicity_id} = 5 ;;
        label: "American Indian or Alaska Native Non-hispanic/Latino"
      }
      when: {
        sql: ${race_ethnicity_id} = 6 ;;
        label: "Native Hawaiian or Other Pacific Islander Non-hispanic/Latino"
      }
      when: {
        sql: ${race_ethnicity_id} = 7 ;;
        label: "Other Non-hispanic/Latino"
      }
      when: {
        sql: ${race_ethnicity_id} = 8 ;;
        label: "Unknown"
      }
    }
  }

  dimension: region_id {
    type: number
    sql: ${TABLE}.region_id ;;
  }

  dimension: residency_id {
    type: number
    sql: ${TABLE}.residency_id ;;
  }

  dimension: residency_id_label {
    type: string
    case: {
      when: {
        sql: ${residency_id} = 0 ;;
        label: "Other"
      }
      when: {
        sql: ${residency_id} = 1 ;;
        label: "Core"
      }
      when: {
        sql: ${residency_id} = 2 ;;
        label: "Donut"
      }
      when: {
        sql: ${residency_id} = 3 ;;
        label: "Visitor"
      }
    }
  }

  dimension: sex_id {
    type: number
    sql: ${TABLE}.sex_id ;;
  }

  dimension: year {
    type: number
    sql: ${TABLE}.year ;;
  }

  measure: person_count_distinct {
    type: count_distinct
    sql: ${id} ;;
    drill_fields: [id, travel_activity.count, travel_segment.count]
  }

  measure: household_count_distinct {
    type: count_distinct
    sql: ${household_id} ;;
    drill_fields: [household_id, travel_activity.count, travel_segment.count]
  }

  measure: average_age {
    type: average
    sql: ${age} ;;
  }

  measure: median_household_income {
    type: median
    sql: ${household_income_usd} ;;
    value_format_name: usd_0

  }
}
