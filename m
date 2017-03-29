Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:39429 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932308AbdC2Mpn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 29 Mar 2017 08:45:43 -0400
Subject: Re: [PATCH v3 10/11] ASoC: add bindings for stm32 DFSDM filter
To: Rob Herring <robh@kernel.org>
References: <1489759704-30217-1-git-send-email-arnaud.pouliquen@st.com>
 <1489759704-30217-11-git-send-email-arnaud.pouliquen@st.com>
 <20170324145208.6tj5swol5du5lkyc@rob-hp-laptop>
CC: Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "kernel@stlinux.com" <kernel@stlinux.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Olivier MOYSAN <olivier.moysan@st.com>
From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Message-ID: <473f36db-0c0e-00d2-3610-c24bf3f1d541@st.com>
Date: Wed, 29 Mar 2017 14:42:38 +0200
MIME-Version: 1.0
In-Reply-To: <20170324145208.6tj5swol5du5lkyc@rob-hp-laptop>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello Rob,

Sorry for this dirty/crappy patch...
Please find answers below

Thanks

Arnaud


On 03/24/2017 03:52 PM, Rob Herring wrote:
> On Fri, Mar 17, 2017 at 03:08:23PM +0100, Arnaud Pouliquen wrote:
>> Add bindings that describes audio settings to support
>> Digital Filter for pulse density modulation(PDM) microphone.
>>
>> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
>> ---
>> V2->V3:
>>    Fixes based on V2 comments
>>
>>  .../devicetree/bindings/sound/st,stm32-adfsdm.txt  | 41 ++++++++++++++++++++++
>>  1 file changed, 41 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/sound/st,stm32-adfsdm.txt
>>
>> diff --git a/Documentation/devicetree/bindings/sound/st,stm32-adfsdm.txt b/Documentation/devicetree/bindings/sound/st,stm32-adfsdm.txt
>> new file mode 100644
>> index 0000000..ab610bc
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/sound/st,stm32-adfsdm.txt
>> @@ -0,0 +1,40 @@
>> +STMicroelectronics audio DFSDM DT bindings
>> +
>> +This driver supports audio PDM microphone capture through Digital Filter format
>> +Sigma Delta modulators (DFSDM).
>> +
>> +Required properties:
>> +  - compatible: "st,stm32h7-adfsdm".
>> +
>> +  - #sound-dai-cells : Must be equal to 0
>> +
>> +  - io-channels : phandle to iio dfsdm instance node.
>> +
>> +
>> +Example of a simple sound card using audio DFSDM node.
>> +
>> +	dmic0: dmic_@0 {
> 
> Drop the '_' and unit address.
> 
>> +		compatible = "dmic-codec";
>> +		#sound-dai-cells = <0>;
>> +	};
>> +
>> +	asoc-pdm@0 {
> 
> asoc is a Linux term. Drop the unit address.
> 
>> +		compatible = "st,stm32h7-adfsdm";
> 
> Is this a separate block from the ADC? A drawing of the h/w blocks and 
> connections would help.
I don't know how to explain it...So don't hesitate is still not clear.
On DFSDM we can connect 2 ADC types:
- Generic Sigma delta(SD) ADC for analog to digital conversion
- Digital microphones for audio capture.

In both cases, an SPI or Manchester bus is used to transfer 1-bit stream
 to DFSDM.
1) In case of SD ADC, The link is described in IIO declaration using
"io-channels" property ( [04/11] IIO: add DT bindings for stm32 DFSDM
filter)
2) For audio purpose, the link is done by the simple or the graph card
So this device exposes the Digital audio interface (DAI) associated to
the DFSDM ADC.
Link between the DFSDM DAI and the DFSDM IIO device is done through the
"io-channels" property.

> 
>> +		#sound-dai-cells = <0>;
>> +		io-channels = <&dfsdm_adc0 0>;
>> +	};
>> +
>> +	sound_dfsdm_pdm {
> 
> sound-card {
> 
>> + 		compatible = "simple-audio-card";
>> + 		simple-audio-card,name = "dfsdm_pdm";
>> +
>> + 		dfsdm0_mic0: simple-audio-card,dai-link@0 {
> 
> I'd suggest moving to the graph card.
yes should be in V4
> 
>> + 			format = "pdm";
>> + 			cpu {
>> + 				sound-dai = <&asoc_pdm1>;
> 
> This phandle doesn't point to anything.
> 
>> + 			};
>> + 			dmic0_codec: codec {
>> + 				sound-dai = <&dmic0>;
>> + 			};
>> + 		};
>> +	};
>> \ No newline at end of file
> 
> ^^^
> 
>> -- 
>> 1.9.1
>>
