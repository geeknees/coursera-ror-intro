#Implement all parts of this assignment within (this) module2_assignment2.rb file

#Implement a class called LineAnalyzer.
class LineAnalyzer
  #Implement the following read-only attributes in the LineAnalyzer class.
  #* highest_wf_count - a number with maximum number of occurrences for a single word (calculated)
  #* highest_wf_words - an array of words with the maximum number of occurrences (calculated)
  #* content          - the string analyzed (provided)
  #* line_number      - the line number analyzed (provided)
  attr_accessor :highest_wf_count, :highest_wf_words, :content, :line_number

  #Add the following methods in the LineAnalyzer class.
  #* initialize() - taking a line of text (content) and a line number
  #* calculate_word_frequency() - calculates result
  def initialize(content,line_number)
      self.content = content
      self.line_number = line_number
      calculate_word_frequency
  end

  #Implement the initialize() method to:
  #* take in a line of text and line number
  #* initialize the content and line_number attributes
  #* call the calculate_word_frequency() method.

  #Implement the calculate_word_frequency() method to:
  #* calculate the maximum number of times a single word appears within
  #  provided content and store that in the highest_wf_count attribute.
  #* identify the words that were used the maximum number of times and
  #  store that in the highest_wf_words attribute.

  def calculate_word_frequency
      self.highest_wf_words = Array.new
      words=content.downcase.split(' ')
      frequencies={}
      self.highest_wf_count=0
      words.each {|word|
        if frequencies.has_key?(word)
          frequencies[word] += 1
        else
          frequencies[word] = 1
        end
        if frequencies[word]>self.highest_wf_count
          self.highest_wf_words = Array.new
          self.highest_wf_words.push(word)
          self.highest_wf_count=frequencies[word]
        elsif frequencies[word]==highest_wf_count
          self.highest_wf_words.push(word)
        end
      }
  end
end

#  Implement a class called Solution.
class Solution

  # Implement the following read-only attributes in the Solution class.
  #* analyzers - an array of LineAnalyzer objects for each line in the file
  #* highest_count_across_lines - a number with the maximum value for highest_wf_words attribute in the analyzers array.
  #* highest_count_words_across_lines - a filtered array of LineAnalyzer objects with the highest_wf_words attribute
  #  equal to the highest_count_across_lines determined previously.
  attr_accessor :analyzers, :highest_count_across_lines , :highest_count_words_across_lines

  # Implement the following methods in the Solution class.
  #* analyze_file() - processes 'test.txt' intro an array of LineAnalyzers and stores them in analyzers.
  #* calculate_line_with_highest_frequency() - determines the highest_count_across_lines and
  #  highest_count_words_across_lines attribute values
  #* print_highest_word_frequency_across_lines() - prints the values of LineAnalyzer objects in
  #  highest_count_words_across_lines in the specified format
  def initialize
      self.analyzers = Array.new
  end

  def analyze_file()
    self.analyzers = Array.new
    file='test.txt'
    counter=0
    File.readlines(file).each { |line|
      analyzers.push(LineAnalyzer.new(line,counter))
      counter=counter+1
    }
  end

  def calculate_line_with_highest_frequency()
    self.highest_count_across_lines=0
    self.highest_count_words_across_lines=Array.new
    analyzers.each { |analyzer|
      if analyzer.highest_wf_count>self.highest_count_across_lines
          self.highest_count_words_across_lines = Array.new
          #analyzer.highest_wf_words.each { |item| self.highest_count_words_across_lines.push(item) }
          self.highest_count_words_across_lines.push(analyzer)
          self.highest_count_across_lines=analyzer.highest_wf_count
      elsif analyzer.highest_wf_count==self.highest_count_across_lines
          #analyzer.highest_wf_words.each { |item| self.highest_count_words_across_lines.push(item) }
          self.highest_count_words_across_lines.push(analyzer)
      end
    }
  end

  def print_highest_word_frequency_across_lines()
    puts "The following words have the highest word frequency per line:"
    self.highest_count_words_across_lines.each do |highest_per_line|
      puts "#{highest_per_line.highest_wf_words} (appears in line #{highest_per_line.line_number})"
    end
  end

  # Implement the analyze_file() method() to:
  #* Read the 'test.txt' file in lines
  #* Create an array of LineAnalyzers for each line in the file

  # Implement the calculate_line_with_highest_frequency() method to:
  #* calculate the maximum value for highest_wf_count contained by the LineAnalyzer objects in analyzers array
  #  and stores this result in the highest_count_across_lines attribute.
  #* identifies the LineAnalyzer objects in the analyzers array that have highest_wf_count equal to highest_count_across_lines
  #  attribute value determined previously and stores them in highest_count_words_across_lines.

  #Implement the print_highest_word_frequency_across_lines() method to
  #* print the values of objects in highest_count_words_across_lines in the specified format
end
