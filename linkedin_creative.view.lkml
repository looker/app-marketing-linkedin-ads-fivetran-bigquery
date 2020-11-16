view: linkedin_creative {
  extends: [linkedin_ads_config]
  derived_table: {
    sql:
    (
    SELECT creative_history.* FROM `{{ ad.linkedin_ads_schema._sql }}.creative_history` as creative_history
    INNER JOIN (
    SELECT
    id, max(last_modified_time) as max_fivetran_synced
    FROM `{{ ad.linkedin_ads_schema._sql }}.creative_history`
    GROUP BY id) max_creative_history
    ON max_creative_history.id = creative_history.id
    AND max_creative_history.max_fivetran_synced = creative_history.last_modified_time
    ) ;;
  }

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

  dimension: activity {
    type: string
    sql: ${TABLE}.activity ;;
  }

  dimension: call_to_action {
    type: string
    sql: ${TABLE}.call_to_action ;;
  }

  dimension: call_to_action_label_type {
    type: string
    sql: ${TABLE}.call_to_action_label_type ;;
  }

  dimension: call_to_action_target {
    type: string
    sql: ${TABLE}.call_to_action_target ;;
  }

  dimension: campaign_id {
    type: number
    sql: ${TABLE}.campaign_id ;;
  }

  dimension: click_uri {
    type: string
    sql: ${TABLE}.click_uri ;;
  }

  dimension: company_name {
    type: string
    sql: ${TABLE}.company_name ;;
  }

  dimension: content {
    type: string
    sql: ${TABLE}.content ;;
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

  dimension: custom_background {
    type: string
    sql: ${TABLE}.custom_background ;;
  }

  dimension: description {
    type: string
    sql: ${TABLE}.description ;;
  }

  dimension: direct_sponsored_content {
    type: yesno
    sql: ${TABLE}.direct_sponsored_content ;;
  }

  dimension: duration_micro {
    type: number
    sql: ${TABLE}.duration_micro ;;
  }

  dimension: forum_name {
    type: string
    sql: ${TABLE}.forum_name ;;
  }

  dimension: headline {
    type: string
    sql: ${TABLE}.headline ;;
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

  dimension: logo {
    type: string
    sql: ${TABLE}.logo ;;
  }

  dimension: media_asset {
    type: string
    sql: ${TABLE}.media_asset ;;
  }

  dimension: organization {
    type: string
    sql: ${TABLE}.organization ;;
  }

  dimension: organization_logo {
    type: string
    sql: ${TABLE}.organization_logo ;;
  }

  dimension: organization_name {
    type: string
    sql: ${TABLE}.organization_name ;;
  }

  dimension: reference {
    type: string
    sql: ${TABLE}.reference ;;
  }

  dimension: review_status {
    type: string
    sql: ${TABLE}.review_status ;;
  }

  dimension: share {
    type: string
    sql: ${TABLE}.share ;;
  }

  dimension: show_member_profile_photo {
    type: yesno
    sql: ${TABLE}.show_member_profile_photo ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: text {
    type: string
    sql: ${TABLE}.text_ad_text ;;
  }

  dimension: title {
    type: string
    sql: ${TABLE}.text_ad_title ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
  }

  dimension: user_generated_content_post {
    type: string
    sql: ${TABLE}.user_generated_content_post ;;
  }

  dimension: version_tag {
    type: string
    sql: ${TABLE}.version_tag ;;
  }

  measure: count {
    type: count
    drill_fields: [id, organization_name, forum_name, company_name]
  }
}
