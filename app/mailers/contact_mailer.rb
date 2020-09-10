class ContactMailer < ApplicationMailer

  def greeting(user)
    @greeting = "会員登録が完了しました"
    @user = user
    @url = "http://localhost:3000/users/#{@user.id}"
    mail(
     to: @user.email,
     subject:'【Bookers】会員登録が完了しました ',
     form: "no-replay@gmai.com"
     )
  end

end
