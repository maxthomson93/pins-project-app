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
        %w[food, nightlife, nature, culture, wellness, lifestyle]
    end
end
