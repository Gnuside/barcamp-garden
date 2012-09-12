class AdminAbility
	include CanCan::Ability

	def initialize(user)
		# FIXME: remove debug
		require 'pp'

		pp user
		if user && user.admin?
			pp 'is admin !', user
			can :access, :rails_admin
			can :manage, :all   
		end
	end
end

