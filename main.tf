resource "azuread_user" "tf_user_Ala_Alewska" {
  user_principal_name = "Ala_Alewska@${data.azuread_domains.azure_domain.domains.0.domain_name}"
  display_name        = "tf Ala Alewska"
  password            =  var.DEFAULT_AAD_PASSWORD
}


resource "azuread_user" "tf_user_guests" {
	for_each = toset( ["tf_guest1", "tf_guest2", "tf_guest3"] )
  user_principal_name = "${each.key}@${data.azuread_domains.azure_domain.domains.0.domain_name}"
  display_name        = each.key
  password            = var.DEFAULT_AAD_PASSWORD
}


resource "azuread_user" "tf_user_auditors" {
  count = 3
  user_principal_name = "tf_auditor${count.index}@${data.azuread_domains.azure_domain.domains.0.domain_name}"
  display_name        = "tf_auditor${count.index}"
  password            = var.DEFAULT_AAD_PASSWORD
}



output "output_tf_user_guests" {
  value = {
    for k, v in azuread_user.tf_user_guests : k => v.id
  }
}


output "output_tf_user_auditors" {
  value = {
    for k, v in azuread_user.tf_user_auditors : k => v.id
  }
}
data "azuread_domains" "azure_domain" {
  only_initial = true
}
