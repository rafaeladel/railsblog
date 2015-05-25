class ArticlePolicy
	def initialize(user, article)
		@user = user
		@article = article
	end

	def destroy?
		!@user.nil? && (@user.role?(:admin) || @user == @article.user)
	end
end