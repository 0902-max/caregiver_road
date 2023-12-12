class VocabularyEntriesController < ApplicationController
  before_action :authenticate_user!

  def new
    @vocabulary_note = current_user.vocabulary_notes.find(params[:vocabulary_note_id])
    @vocabulary_entry = @vocabulary_note.vocabulary_entries.new
  end

  def create
    @vocabulary_note = current_user.vocabulary_notes.find(params[:vocabulary_note_id])
    @vocabulary_entry = @vocabulary_note.vocabulary_entries.new(vocabulary_entry_params)
    if @vocabulary_entry.save
      redirect_to vocabulary_note_path(@vocabulary_note), notice: 'Vocabulary entry created successfully.'
    else
      render :new
    end
  end

  private

  def vocabulary_entry_params
    params.require(:vocabulary_entry).permit(:word, :meaning).merge(user_id: current_user.id)
  end
end
