class NotesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]

  def index
    @notes = Note.all.includes(:user).order("created_at DESC")
  end

  def show

  end

  def new
      @note = Note.new
      @note.images.new
  end

  def create
    @note = current_user.notes.new(notes_params)
    if @note.save
       respond_to do |format|
          format.html { redirect_to root_path }
          format.json
       end
    else
      flash[:alert] = 'タイトル、本文、カテゴリは必ず入力して下さい'
      redirect_to new_note_path
    end
  end

  def edit
    @note = Note.find(params[:id])
    @note.images.new
  end

  def update
    @note = Note.find(params[:id])
    if @note.update(notes_params)
      redirect_to root_path
    else
      flash[:alert] = 'タイトル、本文、カテゴリは必ず入力して下さい'
      redirect_to edit_note_path
    end
  end

  def destroy
    @note = Note.find(params[:id])
    if @note.user.id == current_user.id
       @note.destroy
       redirect_to root_path
    end
  end

  private
  def notes_params
    params.require(:note).permit(:title, :text, :category, images_attributes: [:image]).merge(user_id: current_user.id)
  end
end
