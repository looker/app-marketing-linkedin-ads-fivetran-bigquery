# Views and Explores for linkedin Ads rolled up stats tables

include: "linkedin_campaign.view"
include: "linkedin_creative.view"

view: linkedin_ad_metrics_base_dimensions {
  extension: required

  dimension: action_clicks {
    type: number
    sql: ${TABLE}.action_clicks ;;
  }

  dimension: ad_unit_clicks {
    type: number
    sql: ${TABLE}.ad_unit_clicks ;;
  }

  dimension: card_clicks {
    type: number
    sql: ${TABLE}.card_clicks ;;
  }

  dimension: card_impressions {
    type: number
    sql: ${TABLE}.card_impressions ;;
  }

  dimension: clicks {
    type: number
    sql: ${TABLE}.clicks ;;
  }

  dimension: comments {
    type: number
    sql: ${TABLE}.comments ;;
  }

  dimension: comments_likes {
    type: number
    sql: ${TABLE}.comments_likes ;;
  }

  dimension: company_page_clicks {
    type: number
    sql: ${TABLE}.company_page_clicks ;;
  }

  dimension: conversion_value_in_local_currency {
    type: number
    sql: ${TABLE}.conversion_value_in_local_currency ;;
  }

  dimension: cost_in_local_currency {
    type: number
    sql: ${TABLE}.cost_in_local_currency ;;
  }

  dimension: cost_in_usd {
    type: number
    sql: ${TABLE}.cost_in_usd ;;
  }

  dimension: external_website_conversions {
    type: number
    sql: ${TABLE}.external_website_conversions ;;
  }

  dimension: external_website_post_click_conversions {
    type: number
    sql: ${TABLE}.external_website_post_click_conversions ;;
  }

  dimension: external_website_post_view_conversions {
    type: number
    sql: ${TABLE}.external_website_post_view_conversions ;;
  }

  dimension: follows {
    type: number
    sql: ${TABLE}.follows ;;
  }

  dimension: impressions {
    type: number
    sql: ${TABLE}.impressions ;;
  }

  dimension: landing_page_clicks {
    type: number
    sql: ${TABLE}.landing_page_clicks ;;
  }

  dimension: likes {
    type: number
    sql: ${TABLE}.likes ;;
  }

  dimension: shares {
    type: number
    sql: ${TABLE}.shares ;;
  }

  dimension: text_url_clicks {
    type: number
    sql: ${TABLE}.text_url_clicks ;;
  }

  dimension: total_engagements {
    type: number
    sql: ${TABLE}.total_engagements ;;
  }

  dimension: video_completions {
    type: number
    sql: ${TABLE}.video_completions ;;
  }

  dimension: video_views {
    type: number
    sql: ${TABLE}.video_views ;;
  }

  dimension: viral_card_clicks {
    type: number
    sql: ${TABLE}.viral_card_clicks ;;
  }

  dimension: viral_card_impressions {
    type: number
    sql: ${TABLE}.viral_card_impressions ;;
  }

  dimension: viral_clicks {
    type: number
    sql: ${TABLE}.viral_clicks ;;
  }

  dimension: viral_comment_likes {
    type: number
    sql: ${TABLE}.viral_comment_likes ;;
  }

  dimension: viral_comments {
    type: number
    sql: ${TABLE}.viral_comments ;;
  }

  dimension: viral_comments_likes {
    type: number
    sql: ${TABLE}.viral_comments_likes ;;
  }

  dimension: viral_company_page_clicks {
    type: number
    sql: ${TABLE}.viral_company_page_clicks ;;
  }

  dimension: viral_extrernal_website_conversions {
    type: number
    sql: ${TABLE}.viral_extrernal_website_conversions ;;
  }

  dimension: viral_extrernal_website_post_click_conversions {
    type: number
    sql: ${TABLE}.viral_extrernal_website_post_click_conversions ;;
  }

  dimension: viral_extrernal_website_post_view_conversions {
    type: number
    sql: ${TABLE}.viral_extrernal_website_post_view_conversions ;;
  }

  dimension: viral_follows {
    type: number
    sql: ${TABLE}.viral_follows ;;
  }

  dimension: viral_impressions {
    type: number
    sql: ${TABLE}.viral_impressions ;;
  }

  dimension: viral_landing_page_clicks {
    type: number
    sql: ${TABLE}.viral_landing_page_clicks ;;
  }

  dimension: viral_likes {
    type: number
    sql: ${TABLE}.viral_likes ;;
  }

  dimension: viral_one_click_leads {
    type: number
    sql: ${TABLE}.viral_one_click_leads ;;
  }

  dimension: viral_shares {
    type: number
    sql: ${TABLE}.viral_shares ;;
  }

  dimension: viral_total_engagements {
    type: number
    sql: ${TABLE}.viral_total_engagements ;;
  }

  dimension: viral_video_completions {
    type: number
    sql: ${TABLE}.viral_video_completions ;;
  }

  dimension: viral_video_views {
    type: number
    sql: ${TABLE}.viral_video_views ;;
  }
}



explore: linkedin_ad_impressions_campaign_adapter {
  from: linkedin_ad_impressions_campaign_adapter
  view_name: fact
  group_label: "Linkedin Ads"
  label: "Linkedin Ads Impressions by Campaign"
  view_label: "Impressions by Campaign"

  join: campaign {
    from: linkedin_campaign
    view_label: "Campaign"
    sql_on: ${fact.campaign_id} = ${campaign.id};;
    relationship: many_to_one
  }
}


view: linkedin_ad_impressions_campaign_adapter {
  extends: [linkedin_ad_impressions_campaign_adapter_base]
  sql_table_name: {{ linkedin_ads_schema._sql }}.ad_analytics_by_campaign ;;
}

view: linkedin_ad_impressions_campaign_adapter_base {
  extends: [linkedin_ads_config, linkedin_ad_metrics_base_dimensions]

  dimension: campaign_id {
    hidden: yes
    type: number
  }

  dimension: campaign_id_string {
    hidden: yes
    sql: CAST(${TABLE}.campaign_id as STRING) ;;
  }

  dimension: _date {
    hidden: yes
    type: date
    sql: ${TABLE}.day ;;
  }
}


explore: linkedin_ad_impressions_ad_adapter {
  from: linkedin_ad_impressions_ad_adapter
  view_name: fact
  group_label: "Linkedin Ads"
  label: "Linkedin Ads Impressions by Ad"
  view_label: "Impressions by Ad"

  join: ad {
    from: linkedin_creative
    view_label: "Ad"
    sql_on:
      ${ad.id} = ${fact.ad_id} ;;
    relationship:  many_to_one
  }

  join: campaign {
    from: linkedin_campaign
    view_label: "Campaign"
    sql_on: ${ad.campaign_id} = ${campaign.id} ;;
    relationship: many_to_one
  }

}

view: linkedin_ad_impressions_ad_adapter {
  extends: [linkedin_ads_config, linkedin_ad_metrics_base_dimensions]
  sql_table_name: {{ linkedin_ads_schema._sql }}.ad_analytics_by_creative ;;

  dimension: ad_id {
    hidden: yes
    type: number
    sql: ${TABLE}.creative_id ;;
  }

  dimension: _date {
    hidden: yes
    type: date
    sql: ${TABLE}.day ;;
  }

  dimension: ad_id_string {
    hidden: yes
    sql: CAST(${TABLE}.creative_id as STRING) ;;
  }

}
