view: linkedin_account {
  extends: [linkedin_ads_config]
  sql_table_name: {{ linkedin_ads_schema._sql }}.linkedin_ads.account_history ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension_group: _fivetran_synced {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}._fivetran_synced ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_time ;;
  }

  dimension: currency {
    type: string
    sql: ${TABLE}.currency ;;
  }

  dimension_group: _date {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.last_modified_time ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: notified_on_campaign_optimization {
    type: yesno
    sql: ${TABLE}.notified_on_campaign_optimization ;;
  }

  dimension: notified_on_creative_approval {
    type: yesno
    sql: ${TABLE}.notified_on_creative_approval ;;
  }

  dimension: notified_on_creative_rejection {
    type: yesno
    sql: ${TABLE}.notified_on_creative_rejection ;;
  }

  dimension: notified_on_end_of_campaign {
    type: yesno
    sql: ${TABLE}.notified_on_end_of_campaign ;;
  }

  dimension: reference {
    type: string
    sql: ${TABLE}.reference ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: total_budget_amount {
    type: number
    sql: ${TABLE}.total_budget_amount ;;
  }

  dimension: total_budget_currency_code {
    type: string
    sql: ${TABLE}.total_budget_currency_code ;;
  }

  dimension: total_budget_ends_at {
    type: number
    sql: ${TABLE}.total_budget_ends_at ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
  }

  dimension: version_tag {
    type: string
    sql: ${TABLE}.version_tag ;;
  }

  measure: count {
    type: count
    drill_fields: [id, name]
  }
}

explore: linkedin_account_join {
  extension: required

  join: account {
    from: linkedin_account
    view_label: "Account"
    sql_on: ${fact.account_id} = ${account.id} AND
      ${fact._date} = ${account._date_date} ;;
    relationship: many_to_one
  }
}
