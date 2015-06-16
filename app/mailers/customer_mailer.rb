class CustomerMailer < Devise::Mailer

  helper :application # gives access to all helpers defined within `application_helper`.
  default template_path: 'views/users/mailer' # to make sure that your mailer uses the devise views


  #def confirmation_instructions(record, opts={})
  #	devise_mail(record, :confirmation_instructions, opts)
  #end

  def headers_for(action, opts)
    super.merge!({template_path: '/users/mailer'}) # this moves the Devise template path from /views/devise/mailer to /views/mailer/devise
  end

  #def unlock_instructions(record, opts={})
  #	devise_mail(record, :unlock_instructions, opts)
  #end

end
