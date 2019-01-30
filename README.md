# Introducing the alexa_modelmd gem

    require 'alexa_modelmd'

    wm = AlexaModelMd.new 'leo.md'
    puts wm.to_xml

The above example takes a kind of Markdown file containing an Amazon Alexa model using headings, lists etc. and returns an XML representation. 

file: leo.md

<pre>
<?dynarex schema="sections[title, invocation, endpoint]/section(x)" format_mask="[!x]"?>
title: leo
invocation: leo
endpoint: http://a2.jamesrobertson.eu/do/leo/ask
--#
# Radio

## RadioPlay

* play the radio
* to play radio

    radio.play
    'I am now playing the radio.'

+ radio

# Journey

## JourneyOutbound

* I'm leaving now
* bye

`rsc.sps.notice 'jamesio: leaving'
'Okay, bye!`

## JourneyInbound

* I have arrived
* I'm back

`rsc.sps.notice 'jamesio: arrived'
'Welcome back!`


+ Journey inbound outbound
</pre>

Output XML:

<pre>&lt;?xml version='1.0' encoding='UTF-8'?&gt;
&lt;model&gt;
  &lt;summary&gt;
    &lt;title&gt;leo&lt;/title&gt;
    &lt;invocation&gt;leo&lt;/invocation&gt;
    &lt;endpoint&gt;http://a2.jamesrobertson.eu/do/leo/ask&lt;/endpoint&gt;
  &lt;/summary&gt;
  &lt;entries&gt;
    &lt;entry&gt;
      &lt;topic&gt;Radio&lt;/topic&gt;
      &lt;intents&gt;
        &lt;intent&gt;
          &lt;name&gt;RadioPlay&lt;/name&gt;
          &lt;utterances&gt;
            &lt;utterance&gt;play the radio&lt;/utterance&gt;
            &lt;utterance&gt;to play the radio&lt;/utterance&gt;
          &lt;/utterances&gt;
          &lt;code&gt;&lt;![CDATA[
radio.play
'I am now playing the radio.'
]]&gt;&lt;/code&gt;
        &lt;/intent&gt;
      &lt;/intents&gt;
    &lt;/entry&gt;
    &lt;entry&gt;
      &lt;topic&gt;Journey&lt;/topic&gt;
      &lt;intents&gt;
        &lt;intent&gt;
          &lt;name&gt;JourneyOutbound&lt;/name&gt;
          &lt;utterances&gt;
            &lt;utterance&gt;I’m leaving now&lt;/utterance&gt;
            &lt;utterance&gt;bye&lt;/utterance&gt;
          &lt;/utterances&gt;
          &lt;code&gt;&lt;![CDATA[rsc.sps.notice 'jamesio: leaving'
'Okay, bye!]]&gt;&lt;/code&gt;
        &lt;/intent&gt;
        &lt;intent&gt;
          &lt;name&gt;JourneyInbound&lt;/name&gt;
          &lt;utterances&gt;
            &lt;utterance&gt;I have arrived&lt;/utterance&gt;
            &lt;utterance&gt;I’m back&lt;/utterance&gt;
          &lt;/utterances&gt;
          &lt;code&gt;&lt;![CDATA[rsc.sps.notice 'jamesio: arrived'
'Welcome back!]]&gt;&lt;/code&gt;
        &lt;/intent&gt;
      &lt;/intents&gt;
    &lt;/entry&gt;
  &lt;/entries&gt;
&lt;/model&gt;
</pre>

## Resources

* alexa_modelmd https://rubygems.org/gems/alexa_modelmd

alexa wikimd amazon bot model builder
