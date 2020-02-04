view: travel_activity {
  sql_table_name: replica.travel_activity ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}."id" ;;
  }

  dimension: day_id {
    type: number
    sql: ${TABLE}.day_id ;;
  }

#Distance & duration

  dimension: distance_miles {
    type: number
    sql: ${TABLE}.distance_miles ;;
  }

  dimension: distance_miles_tier {
    type: tier
    tiers: [0.5, 1, 2, 4, 8, 16, 32, 64]
    style: classic # the default value, could be excluded
    sql: ${distance_miles} ;;
  }

  measure: average_distance_miles {
    type: average
    value_format: "0.# \" miles\""
    sql: ${distance_miles} ;;
  }

  measure: total_distance_miles {
    type: sum
    value_format: "#,##0 \" miles\""
    sql: ${distance_miles};;
  }

  measure: average_distance_per_traveler_miles {
    type: number
    value_format: "0.##"
    sql: SUM(${distance_miles})/COUNT(DISTINCT(${person_id}));;
  }

  dimension: duration_minutes {
    type: number
    sql: (${TABLE}.duration)/60 ;;
  }

  dimension: duration_mins_tier {
    type: tier
    tiers: [5, 10, 20, 40, 80]
    style: integer # the default value, could be excluded
    sql: ${duration_minutes} ;;
  }

  measure: average_duration_minutes {
    type: average
    value_format: "0 \" mins\""
    sql: ${duration_minutes} ;;
  }
  measure: average_speed_mph {
    type: number
    value_format: "0 \" MPH\""
    sql: (${average_distance_miles}/(${average_duration_minutes}/60)) ;;
  }

#Start place & End place

  dimension: start_place_cell_id {
    type: string
    sql: ${TABLE}.start_place_cell_id ;;
  }

  dimension: start_place_tract_id {
    type: string
    map_layer_name: census_tract    # this is your map layer
    sql: substring(${start_place_cell_id},1,11) ;;
  }
  dimension: start_place_county_id {
    type: string
    sql: substring(${start_place_cell_id},1,5) ;;
  }

  dimension: start_place_county_name {
    type: string
    case: {
      when: {
        sql: ${start_place_county_id} = '17031' ;;
        label: "Cook Co"
      }
      when: {
        sql: ${start_place_county_id} = '17097' ;;
        label: "Lake Co"
      }
      when: {
        sql: ${start_place_county_id} = '17043' ;;
        label: "DuPage Co"
      }
      when: {
        sql: ${start_place_county_id} = '17111' ;;
        label: "McHenry Co"
      }
      when: {
        sql: ${start_place_county_id} = '17089' ;;
        label: "Kane Co"
      }
      when: {
        sql: ${start_place_county_id} = '17093' ;;
        label: "Kendall Co"
      }
      when: {
        sql: ${start_place_county_id} = '17197' ;;
        label: "Will Co"
      }
    }
  }

  dimension: end_place_cell_id {
    type: string
    sql: ${TABLE}.end_place_cell_id ;;
  }

  dimension: end_place_tract_id {
    type: string
    map_layer_name: census_tract    # this is your map layer
    sql: substring(${end_place_cell_id},1,11) ;;
  }

  dimension: end_place_county_id {
    type: string
    sql: substring(${end_place_cell_id},1,5) ;;
  }

  dimension: end_place_county_name {
    type: string
    case: {
      when: {
        sql: ${end_place_county_id} = '17031' ;;
        label: "Cook Co"
      }
      when: {
        sql: ${end_place_county_id} = '17097' ;;
        label: "Lake Co"
      }
      when: {
        sql: ${end_place_county_id} = '17043' ;;
        label: "DuPage Co"
      }
      when: {
        sql: ${end_place_county_id} = '17111' ;;
        label: "McHenry Co"
      }
      when: {
        sql: ${end_place_county_id} = '17089' ;;
        label: "Kane Co"
      }
      when: {
        sql: ${end_place_county_id} = '17093' ;;
        label: "Kendall Co"
      }
      when: {
        sql: ${end_place_county_id} = '17197' ;;
        label: "Will Co"
      }
    }
  }

#Start Time & End Time

  dimension: end_time_hour_local {
    type: string
    sql: toHour(toDateTime(${TABLE}.end_time), 'America/Chicago') ;;
  }

  dimension: start_time_hour_local {
    type: string
    sql: toHour(toDateTime(${TABLE}.start_time), 'America/Chicago') ;;
  }

#Income

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

  dimension: household_income__area_median_percent{
    type: string
    sql: multiIf (((${household_size} == 1 AND ${household_income_usd} <= 31200)
    OR (${household_size} == 2 AND ${household_income_usd} <= 35650)
    OR (${household_size} == 3 AND ${household_income_usd} <= 44100)
    OR (${household_size} == 4 AND ${household_income_usd} <= 44550)
    OR (${household_size} == 5 AND ${household_income_usd} <= 48150)
    OR (${household_size} == 6 AND ${household_income_usd} <= 51700)
    OR (${household_size} == 7 AND ${household_income_usd} <= 55250)
    OR (${household_size} == 8 AND ${household_income_usd} <= 58850)
    OR (${household_size} == 9 AND ${household_income_usd} <= 44550*1.4)
    OR (${household_size} == 10 AND ${household_income_usd} <= 44550*1.48)), 'Under 50%',
    ((${household_size} == 1 AND ${household_income_usd} > 31200 AND ${household_income_usd} <= 49950) OR
    (${household_size} == 2 AND ${household_income_usd} > 35650 AND ${household_income_usd} <= 57050) OR
    (${household_size} == 3 AND ${household_income_usd} > 44100 AND ${household_income_usd} <= 64200) OR
    (${household_size} == 4 AND ${household_income_usd} > 44550 AND ${household_income_usd} <= 71300) OR
    (${household_size} == 5 AND ${household_income_usd} > 48150 AND ${household_income_usd} <= 77050) OR
    (${household_size} == 6 AND ${household_income_usd} > 51700 AND ${household_income_usd} <= 82750) OR
    (${household_size} == 7 AND ${household_income_usd} > 55250 AND ${household_income_usd} <= 88450) OR
    (${household_size} == 8 AND ${household_income_usd} > 58850 AND ${household_income_usd} <= 94150) OR
    (${household_size} == 9 AND ${household_income_usd} > 44550*1.4 AND ${household_income_usd} <= 71300*1.4) OR
    (${household_size} == 10 AND ${household_income_usd} > 44550*1.48 AND ${household_income_usd} <= 71300*1.8)),'50%-80%',
    ((${household_size} == 1 AND ${household_income_usd} > 49950 AND ${household_income_usd} <= 62400) OR
    (${household_size} == 2 AND ${household_income_usd} > 57050 AND ${household_income_usd} <= 71300) OR
    (${household_size} == 3 AND ${household_income_usd} > 64200 AND ${household_income_usd} <= 80200) OR
    (${household_size} == 4 AND ${household_income_usd} > 71300 AND ${household_income_usd} <= 89100) OR
    (${household_size} == 5 AND ${household_income_usd} > 77050 AND ${household_income_usd} <= 96300) OR
    (${household_size} == 6 AND ${household_income_usd} > 82750 AND ${household_income_usd} <= 103400) OR
    (${household_size} == 7 AND ${household_income_usd} > 88450 AND ${household_income_usd} <= 110500) OR
    (${household_size} == 8 AND ${household_income_usd} > 94150 AND ${household_income_usd} <= 117700) OR
    (${household_size} == 9 AND ${household_income_usd} > 71300*1.4 AND ${household_income_usd} <= 89100*1.4) OR
    (${household_size} == 10 AND ${household_income_usd} > 71300*1.48 AND ${household_income_usd} <= 89100*1.8)),'80%-100%',
    ((${household_size} == 1 AND ${household_income_usd} > 62400 AND ${household_income_usd} <= 87360) OR
    (${household_size} == 2 AND ${household_income_usd} > 71300 AND ${household_income_usd} <= 99820) OR
    (${household_size} == 3 AND ${household_income_usd} > 80200 AND ${household_income_usd} <= 112280) OR
    (${household_size} == 4 AND ${household_income_usd} > 89100 AND ${household_income_usd} <= 124740) OR
    (${household_size} == 5 AND ${household_income_usd} > 96300 AND ${household_income_usd} <= 134820) OR
    (${household_size} == 6 AND ${household_income_usd} > 103400 AND ${household_income_usd} <= 144760) OR
    (${household_size} == 7 AND ${household_income_usd} > 110500 AND ${household_income_usd} <= 154700) OR
    (${household_size} == 8 AND ${household_income_usd} > 117700 AND ${household_income_usd} <= 164780) OR
    (${household_size} == 9 AND ${household_income_usd} > 89100*1.4 AND ${household_income_usd} <= 124740*1.4) OR
    (${household_size} == 10 AND ${household_income_usd} > 89100*1.48 AND ${household_income_usd} <= 124740*1.8)),'100%-140%',
    ((${household_size} == 1 AND ${household_income_usd} > 87360) OR
    (${household_size} == 2 AND ${household_income_usd} > 99820) OR
    (${household_size} == 3 AND ${household_income_usd} > 112280) OR
    (${household_size} == 4 AND ${household_income_usd} > 124740) OR
    (${household_size} == 5 AND ${household_income_usd} > 134820) OR
    (${household_size} == 6 AND ${household_income_usd} > 144760) OR
    (${household_size} == 7 AND ${household_income_usd} > 154700) OR
    (${household_size} == 8 AND ${household_income_usd} > 164780) OR
    (${household_size} == 9 AND ${household_income_usd} > 124740*1.4) OR
    (${household_size} == 10 AND ${household_income_usd} > 124740*1.48)),'Over 140%',
    (${household_size} >= 11),'10+ Household','Unknown');;
  }

#Number of vehicles

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

#Household Size

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

#Trip purpose

  dimension: next_activity_type_id {
    type: number
    sql: ${TABLE}.next_activity_type_id ;;
  }

 dimension: purpose_label {
    type: string
    case: {
      when: {
        sql: ${next_activity_type_id} = 0 ;;
        label: "Other"
      }
      when: {
        sql: ${next_activity_type_id} = 1 ;;
        label: "Home"
      }
      when: {
        sql: ${next_activity_type_id} = 2 ;;
        label: "Work"
      }
      when: {
        sql: ${next_activity_type_id} = 3 ;;
        label: "School"
      }
      when: {
        sql: ${next_activity_type_id} = 4 ;;
        label: "Eat"
      }
      when: {
        sql: ${next_activity_type_id} = 5 ;;
        label: "Shop"
      }
      when: {
        sql: ${next_activity_type_id} = 6 ;;
        label: "Social"
      }
      when: {
        sql: ${next_activity_type_id} = 7 ;;
        label: "Recreation"
      }
      when: {
        sql: ${next_activity_type_id} = 8 ;;
        label: "Errands"
      }
      when: {
        sql: ${next_activity_type_id} = 9 ;;
        label: "Travel"
      }
      when: {
        sql: ${next_activity_type_id} = 10 ;;
        label: "Pass-through"
      }
      when: {
        sql: ${next_activity_type_id} = 11 ;;
        label: "Facilitate (drop-off etc.)"
      }
      when: {
        sql: ${next_activity_type_id} = 12 ;;
        label: "Lodging"
      }
      when: {
        sql: ${next_activity_type_id} = 13 ;;
        label: "Region arrival"
      }
      when: {
        sql: ${next_activity_type_id} = 14 ;;
        label: "Region departure"
      }
      when: {
        sql: ${next_activity_type_id} = 15 ;;
        label: "Commercial"
      }
    }
  }

#Age
  dimension: person_age {
    type: number
    sql: ${TABLE}.person_age ;;
  }

  dimension: person_age_bucket_id {
    type: number
    sql: ${TABLE}.person_age_bucket_id ;;
  }

  dimension: person_age_tier {
    type: tier
    tiers: [5, 12, 18, 35, 50, 65]
    style: integer # the default value, could be excluded
    sql: ${person.age} ;;
  }

#Employment & commuting
  dimension: person_commute_mode_id {
    type: number
    sql: ${TABLE}.person_commute_mode_id ;;
  }

  dimension: person_employment_id {
    type: number
    sql: ${TABLE}.person_employment_id ;;
  }

  dimension: employment_label {
    type: string
    case: {
      when: {
        sql: ${person_employment_id} = 0 ;;
        label: "Unknown"
      }
      when: {
        sql: ${person_employment_id} = 1 ;;
        label: "Employment"
      }
      when: {
        sql: ${person_employment_id} = 2 ;;
        label: "Unemployment"
      }
      when: {
        sql: ${person_employment_id} = 3 ;;
        label: "Not in Labor Force"
      }
    }
  }

#Home & Work location

  dimension: person_housing_unit_cell_id {
    type: string
    sql: ${TABLE}.person_housing_unit_cell_id ;;
  }

  dimension: person_housing_unit_tract_id {
    type: string
    map_layer_name: census_tract    # this is your map layer
    sql: substring(${person_housing_unit_cell_id},1,11) ;;
  }

  dimension: person_housing_unit_county_id {
    type: string
    sql: substring(${person_housing_unit_cell_id},1,5) ;;
  }

  dimension: person_housing_unit_county_name {
    type: string
    case: {
      when: {
        sql: ${person_housing_unit_county_id} = '17031' ;;
        label: "Cook Co"
      }
      when: {
        sql: ${person_housing_unit_county_id} = '17097' ;;
        label: "Lake Co"
      }
      when: {
        sql: ${person_housing_unit_county_id} = '17043' ;;
        label: "DuPage Co"
      }
      when: {
        sql: ${person_housing_unit_county_id} = '17111' ;;
        label: "McHenry Co"
      }
      when: {
        sql: ${person_housing_unit_county_id} = '17089' ;;
        label: "Kane Co"
      }
      when: {
        sql: ${person_housing_unit_county_id} = '17093' ;;
        label: "Kendall Co"
      }
      when: {
        sql: ${person_housing_unit_county_id} = '17197' ;;
        label: "Will Co"
      }
    }
  }

  dimension: person_office_unit_cell_id {
    type: string
    sql: ${TABLE}.person_office_unit_cell_id ;;
  }

  dimension: person_office_unit_tract_id {
    type: string
    map_layer_name: census_tract    # this is your map layer
    sql: substring(${person_office_unit_cell_id},1,11) ;;
  }

  dimension: person_office_unit_county_id {
    type: string
    sql: substring(${end_place_cell_id},1,5) ;;
  }

  dimension: person_office_unit_county_name {
    type: string
    case: {
      when: {
        sql: ${person_office_unit_county_id} = '17031' ;;
        label: "Cook Co"
      }
      when: {
        sql: ${person_office_unit_county_id} = '17097' ;;
        label: "Lake Co"
      }
      when: {
        sql: ${person_office_unit_county_id} = '17043' ;;
        label: "DuPage Co"
      }
      when: {
        sql: ${person_office_unit_county_id} = '17111' ;;
        label: "McHenry Co"
      }
      when: {
        sql: ${person_office_unit_county_id} = '17089' ;;
        label: "Kane Co"
      }
      when: {
        sql: ${person_office_unit_county_id} = '17093' ;;
        label: "Kendall Co"
      }
      when: {
        sql: ${person_office_unit_county_id} = '17197' ;;
        label: "Will Co"
      }
    }
  }

  dimension: person_id {
    type: string
    # hidden: yes
    sql: ${TABLE}.person_id ;;
  }

  dimension: person_income_bucket_id {
    type: number
    sql: ${TABLE}.person_income_bucket_id ;;
  }

  dimension: person_income_usd {
    type: number
    sql: ${TABLE}.person_income_usd ;;
  }

  dimension: person_race_ethnicity_id {
    type: number
    sql: ${TABLE}.person_race_ethnicity_id ;;
  }

  dimension: race_ethnicity_label {
    type: string
    case: {
      when: {
        sql: ${person_race_ethnicity_id} = 0 ;;
        label: "Hispanic or Latino, Any race"
      }
      when: {
        sql: ${person_race_ethnicity_id} = 1 ;;
        label: "Black Non-hispanic/Latino"
      }
      when: {
        sql: ${person_race_ethnicity_id} = 2 ;;
        label: "White Non-hispanic/Latino"
      }
      when: {
        sql: ${person_race_ethnicity_id} = 3 ;;
        label: "Asian Non-hispanic/Latino"
      }
      when: {
        sql: ${person_race_ethnicity_id} = 4 ;;
        label: "Two or More Races Non-hispanic/Latino"
      }
      when: {
        sql: ${person_race_ethnicity_id} = 5 ;;
        label: "American Indian or Alaska Native Non-hispanic/Latino"
      }
      when: {
        sql: ${person_race_ethnicity_id} = 6 ;;
        label: "Native Hawaiian or Other Pacific Islander Non-hispanic/Latino"
      }
      when: {
        sql: ${person_race_ethnicity_id} = 7 ;;
        label: "Other Non-hispanic/Latino"
      }
      when: {
        sql: ${person_race_ethnicity_id} = 8 ;;
        label: "Unknown"
      }
    }
  }

  dimension: person_residency_id {
    type: number
    sql: ${TABLE}.person_residency_id ;;
  }

  dimension: residency_id_label {
    type: string
    case: {
      when: {
        sql: ${person_residency_id} = 0 ;;
        label: "Other"
      }
      when: {
        sql: ${person_residency_id} = 1 ;;
        label: "Core"
      }
      when: {
        sql: ${person_residency_id} = 2 ;;
        label: "Donut"
      }
      when: {
        sql: ${person_residency_id} = 3 ;;
        label: "Visitor"
      }
    }
  }

  dimension: person_sex_id {
    type: number
    sql: ${TABLE}.person_sex_id ;;
  }

  dimension: previous_activity_type_id {
    type: number
    sql: ${TABLE}.previous_activity_type_id ;;
  }

  dimension: previous_activity_type_label {
    type: string
    case: {
      when: {
        sql: ${previous_activity_type_id} = 0 ;;
        label: "Other"
      }
      when: {
        sql: ${previous_activity_type_id} = 1 ;;
        label: "Home"
      }
      when: {
        sql: ${previous_activity_type_id} = 2 ;;
        label: "Work"
      }
      when: {
        sql: ${previous_activity_type_id} = 3 ;;
        label: "School"
      }
      when: {
        sql: ${previous_activity_type_id} = 4 ;;
        label: "Eat"
      }
      when: {
        sql: ${previous_activity_type_id} = 5 ;;
        label: "Shop"
      }
      when: {
        sql: ${previous_activity_type_id} = 6 ;;
        label: "Social"
      }
      when: {
        sql: ${previous_activity_type_id} = 7 ;;
        label: "Recreation"
      }
      when: {
        sql: ${previous_activity_type_id} = 8 ;;
        label: "Errands"
      }
      when: {
        sql: ${previous_activity_type_id} = 9 ;;
        label: "Travel"
      }
      when: {
        sql: ${previous_activity_type_id} = 10 ;;
        label: "Pass-through"
      }
      when: {
        sql: ${previous_activity_type_id} = 11 ;;
        label: "Facilitate (drop-off etc.)"
      }
      when: {
        sql: ${previous_activity_type_id} = 12 ;;
        label: "Lodging"
      }
      when: {
        sql: ${previous_activity_type_id} = 13 ;;
        label: "Region arrival"
      }
      when: {
        sql: ${previous_activity_type_id} = 14 ;;
        label: "Region departure"
      }
      when: {
        sql: ${previous_activity_type_id} = 15 ;;
        label: "Commercial"
      }
    }
  }

  dimension: primary_travel_mode_id {
    type: number
    sql: ${TABLE}.primary_travel_mode_id ;;
  }

  dimension: primary_mode_label {
    type: string
    case: {
      when: {
        sql: ${primary_travel_mode_id} = 0 ;;
        label: "Other"
      }
      when: {
        sql: ${primary_travel_mode_id} = 1 ;;
        label: "Walking"
      }
      when: {
        sql: ${primary_travel_mode_id} = 2 ;;
        label: "Biking"
      }
      when: {
        sql: ${primary_travel_mode_id} = 3 ;;
        label: "Public transit"
      }
      when: {
        sql: ${primary_travel_mode_id} = 4 ;;
        label: "Private transit"
      }
      when: {
        sql: ${primary_travel_mode_id} = 5 ;;
        label: "Taxi/TNC"
      }
      when: {
        sql: ${primary_travel_mode_id} = 6 ;;
        label: "Driving"
      }
      when: {
        sql: ${primary_travel_mode_id} = 7 ;;
        label: "Auto passenger"
      }
      when: {
        sql: ${primary_travel_mode_id} = 8 ;;
        label: "Commercial"
      }
    }
  }

  dimension: region_id {
    type: number
    sql: ${person.region_id} ;;
  }

#People & households

  dimension: household_id {
    type: string
    sql: ${TABLE}.household_id ;;
  }

  measure: count {
    type: count
    drill_fields: [id, person.id]
  }

  measure: person_count_distinct {
    type: count_distinct
    sql: ${person_id} ;;
  }

  measure: mode_share_driving {
    type: number
    value_format: "0.##"
    sql: (SUM(IF(${primary_travel_mode_id} == 6, 1, 0))/${count})*100;;
  }
  measure: mode_share_transit {
    type: number
    value_format: "0.##"
    sql: (SUM(IF(${primary_travel_mode_id} == 3, 1, 0))/${count})*100;;
  }


}
