class PeopleController < ApplicationController
	def index
		p "in index"
		@people = Person.all
		respond_to do |format|
			format.html
			format.csv {send_data @people.to_csv}
		end
	end	

	def import
		Person.import(params[:file])
		redirect_to root_url, notice: "Import successful"
	end

	private

  def person_params
    params.require(:person).permit(:id, :name, :email, :phone)
  end
end
