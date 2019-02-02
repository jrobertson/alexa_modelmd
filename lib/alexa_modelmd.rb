#!/usr/bin/env ruby

# file: alexa_modelmd.rb

# description: Using a WikiMd foramtted document, generates a basic Amazon 
#              Alexa model in XML format, as well as other formats ... soon.


require 'wiki_md'


class AlexaModelMd < WikiMd

  class Intent

    attr_reader :name, :utterances, :code

    def initialize(s)

      doc = Rexle.new("<root9>%s</root9>" % \
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
  
  # This generates a plain text file representing the Alexa Model to be 
  # built using the alexa_modelbuilder gem
  #  
  def to_modelb
    Rexslt.new(modelbuilder_xslt(), to_xml()).to_s    
  end
  
  def to_rsf
    Rexslt.new(rsf_xslt(), to_xml(), debug: @debug).to_xml
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
  
  private
  
  def modelbuilder_xslt()
<<EOF
<xsl:stylesheet xmlns:xsl='http://www.w3.org/1999/XSL/Transform' version='1.0'>
<xsl:output method="xml" indent="yes" omit-xml-declaration="yes" />

  <xsl:template match='model'>name: <xsl:value-of select='summary/title' />
invocation: <xsl:value-of select='summary/invocation' />
<xsl:text>
</xsl:text>
      <xsl:apply-templates select='entries/entry' />
endpoint: <xsl:value-of select='summary/endpoint' />

  </xsl:template>

  <xsl:template match='entries/entry'>
# <xsl:value-of select='topic' /><xsl:text>
</xsl:text>
  <xsl:apply-templates select='intents/intent' />
  </xsl:template>

  <xsl:template match='intents/intent'>
<xsl:text>
</xsl:text>
<xsl:value-of select='name' />
  <xsl:apply-templates select='utterances/utterance' />
<xsl:text>
</xsl:text>
  </xsl:template>

  <xsl:template match='utterances/utterance'>
<xsl:text>
  </xsl:text>
  <xsl:value-of select='.' />

  </xsl:template>


</xsl:stylesheet>
EOF
  end
  
  def rsf_xslt()
<<EOF    
<xsl:stylesheet xmlns:xsl='http://www.w3.org/1999/XSL/Transform' version='1.0'>
<xsl:output method="xml" indent="yes" omit-xml-declaration="yes" />

  <xsl:template match='model'>
<xsl:element name='skill'>
<xsl:text>
</xsl:text>
      <xsl:apply-templates select='entries/entry' />
<xsl:text>
</xsl:text>
</xsl:element>
  </xsl:template>

  <xsl:template match='entries/entry'>
<xsl:text>
  </xsl:text>
  <xsl:comment><xsl:text>  </xsl:text><xsl:value-of select='topic' /><xsl:text>  </xsl:text></xsl:comment><xsl:text>
</xsl:text>

  <xsl:apply-templates select='intents/intent' />
  <xsl:text>  </xsl:text><xsl:comment><xsl:text>  // </xsl:text><xsl:value-of select='topic' /><xsl:text>  </xsl:text></xsl:comment><xsl:text>
</xsl:text>

  </xsl:template>

  <xsl:template match='intents/intent'><xsl:text>  </xsl:text>
    <xsl:element name='response'>
   <xsl:attribute name='id'><xsl:value-of select='name' /></xsl:attribute><xsl:text>
    </xsl:text>
    <xsl:element name='script'>
<xsl:text disable-output-escaping="yes">
    &lt;![CDATA[
</xsl:text>
      <xsl:value-of select='code' />
<xsl:text disable-output-escaping="yes">
    ]]&gt;</xsl:text>

<xsl:text>
    </xsl:text>
      </xsl:element>

<xsl:text>
  </xsl:text>
 </xsl:element><xsl:text>
</xsl:text>
  </xsl:template>


</xsl:stylesheet>
EOF
  end
end
