class UsersController < ApplicationController

    def tags
        @user = User.find(params[:id])
        @tags = given_tags
        if request.patch?
            @user.tag_list = params[:user][:tag_list]
            @user.save
            redirect_to owner_maps_path(@user), notice: 'Tags were successfully updated.'
        end
    end

    private
    def given_tags
        %w[bars beaches beauty cafes cinemas  education fashion halal hikes hobby kosher lgbtq museums miscellaneous nature nightlife parks pet-friendly religious restaurants scenic sightseeing tradition vegan vegetarian wildlife yoga zen]
    end
end
