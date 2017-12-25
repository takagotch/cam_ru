module NativeCampingRoutes

	extend self

	def R(url)
		routes_lookup = routes

		klass = Class.new
		meta  = class << klass; self; end
		meta.send(:define_method, :inherited) do |base|
		  raise "Already defined" if route_lookup[url]
		  routes_lookup[url] = base
		end
		klass
	end
	

	def routes
		@routes ||= {}
	end

	def process(url, params={})
		routes[url].new.get(params)
	end
end

module NativeCampingRoutes
	class Deposits < R '/deposits'
		def get(params)
			puts "deposits #{params[:name]}"
		end
	end

	class Withdrawal < R '/withdrawal'
		def get(params)
			puts "withdrawal #{params[:name]}"
		end
	end
end

NativeCampingRoutes.process('/deposits',  :name => "deposit_account")
NativeCampingRoutes.process('withdrawal', :name => "withdraw_account")

