#!/usr/bin/env ruby

# file: alexa_modelmd.rb

# description: Using a WikiMd foramtted document, generates a basic Amazon 
#              Alexa model in XML format, as well as other formats ... soon.


require 'wiki_md'


class AlexaModelMd < WikiMd

  class Intent

    attr_reader :name, :utterances, :code

    def initialize(s)

      doc = Rexle.new("<root>%s</root>" % \
        Kramdown::Document.new(Martile.new(s).to_s).to_html)
      @name = doc.root.element('h2/text()').to_s
      @utterances = doc.root.xpath('ul/li/text()').map(&:to_s)
      @code = doc.root.element('//code/text()').to_s

    end

  end

  def entries()

    r = super()

    r.map do |entry|

      def entry.intents()
        self.body().split(/(?=^## )/).map {|x| Intent.new(x)}
      end

      entry

    end

  end

  def to_xml()

    a = RexleBuilder.build do |xml|

      xml.model do

        xml.summary do
          xml.title @dxsx.dx.title
          xml.invocation @dxsx.dx.invocation
          xml.endpoint @dxsx.dx.endpoint
        end

        xml.entries do 
          entries.each do |entry|

            xml.entry do
              xml.topic entry.heading

              xml.intents do
                entry.intents.each do |intent|

                  xml.intent do

                    xml.name intent.name

                    xml.utterances do
                      intent.utterances.each do |utterance|
                        xml.utterance utterance
                      end
                    end

                    xml.code do              
                      xml.cdata! intent.code
                    end
                  end #/intent
                end
              end #/intents

            end
          end 
        end #/entries

      end #/model
    end

    Rexle.new(a).xml pretty: true

  end

end
