Rails.configuration.stripe = {
  publishable_key:'pk_test_51O1kcoBYTyCXur6XfqW8OqOcgv1KHIEIj2m7IEV2r99RJvAFqLvPdLZQDqVJ66yyUshAoiCyFBufiTTYN74FiKHE00134iSSR2',
  secret_key:      'sk_test_51O1kcoBYTyCXur6X4GdrGK54WiyUxDj0VsRJvETiUGnL8hWjpQqZwh7HDnogr20W1fuwEIkQ01AjGXTQKIpk7PAg00qDOeVKPC'
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
