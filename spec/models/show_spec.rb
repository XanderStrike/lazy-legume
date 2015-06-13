require 'rails_helper'

RSpec.describe Show, type: :model do
  describe 'hooks' do
    it 'destroys all episodes when destroyed' do
      show = create(:show)
      create_list(:episode, 5, show: show)
      expect { show.destroy }.to change { Episode.count }.by(-5)
    end

    it 'destroys all rules when destroyed' do
      show = create(:show)
      create_list(:rule, 5, show: show)
      expect { show.destroy }.to change { Rule.count }.by(-5)
    end
  end

  describe '.cast_list' do
    it 'parses the shitty stringified list and returns the first five' do
      show = create(:show, actors: ["Emilia Clarke", "Peter Dinklage", "Kit Harington", "Nikolaj Coster-Waldau", "Lena Headey", "Sophie Turner", "Maisie Williams", "Gwendoline Christie", "Aidan Gillen", "Iain Glen", "Charles Dance", "Jerome Flynn", "Alfie Allen", "Isaac Hempstead-Wright", "Natalie Dormer", "John Bradley", "Conleth Hill", "Michelle Fairley", "Julian Glover", "Diana Rigg", "Ian McElhinney", "Ed Skrein", "Jonathan Pryce", "Alexander Siddig", "Nathalie Emmanuel", "Liam Cunningham", "Tom Wlaschiha", "Iwan Rheon", "Jacob Anderson", "Gemma Whelan", "Mark Addy", "Indira Varma", "Michiel Huisman", "Nonso Anozie", "Nell Tiger Free"].to_s)
      expect(show.cast_list).to eq('Emilia Clarke, Peter Dinklage, Kit Harington, Nikolaj Coster-Waldau, Lena Headey, Sophie Turner')
    end
  end

  describe '.genre_list' do
    it 'parses the genre list' do
      show = create(:show, genre: ["Adventure", "Drama", "Fantasy", "Variety"].to_s)
      expect(show.genre_list).to eq('Adventure<br>Drama<br>Fantasy<br>Variety')
    end
  end

  describe '.poster_path' do
    it 'applies the poster path to the tvdb url' do
      show = create(:show, poster: 'test.jpg')
      expect(show.poster_path).to eq('http://thetvdb.com/banners/test.jpg')
    end
  end
end
