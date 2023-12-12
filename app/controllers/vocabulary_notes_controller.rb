# app/controllers/vocabulary_notes_controller.rb
class VocabularyNotesController < ApplicationController
  before_action :authenticate_user! # Assuming you are using Devise for authentication

  def index
    @vocabulary_notes = current_user.vocabulary_notes
  end

  def show
    @vocabulary_note = current_user.vocabulary_notes.find(params[:id])
    @vocabulary_entries = @vocabulary_note.vocabulary_entries
  end

  def new
    @vocabulary_note = current_user.vocabulary_notes.new
  end

  def create
    @vocabulary_note = current_user.vocabulary_notes.new(vocabulary_note_params)
    if @vocabulary_note.save
      redirect_to vocabulary_notes_path, notice: 'Vocabulary note created successfully.'
    else
      render :new
    end
  end

  private

  def vocabulary_note_params
    params.require(:vocabulary_note).permit(:title, :description)
  end
end
