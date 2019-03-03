module Admin
  class PlayersController < ApplicationController
    authorize_resource

    def index
      @players = Player.search(params, admin_players_path)
      render :player_results
    end

    def show
      @player = Player.includes(results: [:opponent]).find(params[:id])
      @tournament = @player.tournament
      extra
    end

    def edit
      @player = Player.find(params[:id])
      @tournament = @player.tournament
    end

    def update
      @player = Player.find(params[:id])
      @tournament = @player.tournament
      update_from_id(params) unless params[:player]
      @player.update_attributes(player_params)
    end

    def destroy
      @player = Player.includes(results: [:opponent]).find(params[:id])
      @tournament = @player.tournament
      if @player.deletable?
        @tournament.remove(@player)
        redirect_to [:admin, @tournament], notice: "Deleted player #{@player.name}"
      else
        # Shouldn't happen because a delete button should not be provided.
        extra
        flash.now[:alert] = "Players that have at least one opponent can't be deleted"
        render "show"
      end
    end

    def autofix
      @player = Player.includes(results: [:opponent]).find(params[:id])
      @player.autofix
      redirect_to_next_step(@player, "Autofixed player #{@player.name}")
    end

    def nextstep
      @player = Player.includes(results: [:opponent]).find(params[:id])
      redirect_to_next_step(@player, "")
    end

    private

    # Redirects to the appropriate place depending on the status of a player
    # This can be to the show page for the player
    def redirect_to_next_step(player, notice)
      if player.status_ok?(true)
        next_player_in_error = player.tournament.find_first_player_with_errors
        if next_player_in_error
          redirect_to [:admin, next_player_in_error], notice: notice
        else
          redirect_to [:admin, player.tournament], notice: notice
        end
      else
        redirect_to [:admin, player], notice: "Not all problems fixed on this page, please fix and try again"
      end
    end

    def update_from_id(params)
      hash = ActiveSupport::HashWithIndifferentAccess.new
      keys = [:first_name, :last_name, :fed, :title, :gender]
      allow_null = [:first_name, :last_name]
      if params[:icu_id] && ip = IcuPlayer.find_by_id(params[:icu_id])
        hash[:icu_id] = params[:icu_id]
        keys.each { |k| v = ip.send(k); hash[k] = v if (v.present? || allow_null.include?(k)) }
        hash[:dob] = ip.dob if ip.dob.present?
        hash[:fide_id] = ip.fide_player.id if ip.fide_player
      elsif params[:fide_id] && fp = FidePlayer.find_by_id(params[:fide_id])
        hash[:fide_id] = params[:fide_id]
        keys.each { |k| v = fp.send(k); hash[k] = v if (v.present? || allow_null.include?(k))}
        hash[:fide_rating] = fp.rating unless @player.fide_rating
      end
      params[:player] = hash
    end

    def extra
      if @tournament.players.size > 2
        # Note that player.find_by_num started going into an infinte loop here after the upgrate to rails 3.1.
        @prev = @tournament.players.where("num = ?", @player.num - 1).first || @tournament.players.order("num").last
        @next = @tournament.players.where("num = ?", @player.num + 1).first || @tournament.players.order("num").first
      end
    end

    def player_params
      params.require(:player).permit(:first_name, :last_name, :icu_id, :fide_id, :fed, :title, :gender, :dob, :icu_rating, :fide_rating)
    end
  end
end
