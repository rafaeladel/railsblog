class ArticlePolicy
	def initialize(user, article)
		@user = user
		@article = article
	end

	def destroy?
		@user == @article.user
	end
end