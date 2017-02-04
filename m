Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58808 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752261AbdBDMOC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 Feb 2017 07:14:02 -0500
Subject: Re: [PATCH 6/7] ASoC: add bindings for STM32 DFSDM driver
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
References: <1485189145-29576-1-git-send-email-arnaud.pouliquen@st.com>
 <1485189145-29576-7-git-send-email-arnaud.pouliquen@st.com>
 <f0f446ea-97a0-8fef-bec5-aefeed42a85a@kernel.org>
 <71612ea0-c9d0-a85e-2d58-72609df57e35@st.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <325ec27f-f13d-c561-d4cf-b50cd9a3eadb@kernel.org>
Date: Sat, 4 Feb 2017 12:13:58 +0000
MIME-Version: 1.0
In-Reply-To: <71612ea0-c9d0-a85e-2d58-72609df57e35@st.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 30/01/17 17:32, Arnaud Pouliquen wrote:
> Hello Johan,
> 
> Please find my comments in-line.
> 
> Regards
> 
> Arnaud
> 
> On 01/29/2017 01:19 PM, Jonathan Cameron wrote:
>> On 23/01/17 16:32, Arnaud Pouliquen wrote:
>>> This patch adds documentation of device tree bindings for the
>>> STM32 DFSDM ASoC driver.
>>>
>>> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
>>> ---
>>>  .../devicetree/bindings/sound/st,sm32-adfsdm.txt   | 84 ++++++++++++++++++++++
>>>  1 file changed, 84 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/sound/st,sm32-adfsdm.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/sound/st,sm32-adfsdm.txt b/Documentation/devicetree/bindings/sound/st,sm32-adfsdm.txt
>>> new file mode 100644
>>> index 0000000..a1d27b8
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/sound/st,sm32-adfsdm.txt
>>> @@ -0,0 +1,84 @@
>>> +STMicroelectronics STM32 ADFSDM ASoC DAI device driver.
>>> +
>>> +STM32 ADFSDM ASoC is a sigma delta audio interface for digital microphone.
>>> +It has to be declared in device-tree as a subnode of the DFSDM mfd node.
>>> +
>>> +It offers possibility to record several mono microphones, with an option to
>>> +synchronize all microphones on a main one (that must be piped to filter 0)
>>> +Audio interface can be exposed through the generic ASoC simple card.
>>> +
>>> +2 Dmics can be connected on one SPI interface instance n.
>>> +Convention is that the DMIC that strobes data on rising edge is connected to the
>>> +corresponding DFSDM channel n; while the Dmic that strobes data on falling edge
>>> +is connected to the channel n-1. Simple card property "bitclock-inversion = <1>"
>>> +is used to specify that microphone strobes data on falling edge.
>>> +
>>> +SPI interface allows to be scheduled by an external SPI clock. To use it
>>> +simple card properties "bitclock-master = <&codec>" and "system-clock-frequency"
>>> +have to be defined in dai-link node.
>>> +
>>> +Required properties:
>>> +- compatible: 	Must be "st,stm32-dfsdm-audio",
>>> +- reg:		Specifies the DFSDM filter instance.
>>> +- interrupts: 	DFSDM filter instance interrupt line.
>>> +- dma:		DMA controller phandle and DMA request line associated to the
>>> +		filter instance ( specified by the field "reg")
>>> +- dma-names: 	must be "rx"
>>> +
>>> +- st,input-id:		Id of the SPI/Manchester interface used.
>>> +- st,dai-filter-order:  SinC filter order from 0 to 5.
>>> +			0: FastSinC
>>> +			[1-5]: order 1 to 5.
>>> +			For audio purpose it is recommended to use order 3 to 5.
>> Interesting for audio you consider it feature of the hardware, but for ADC you
>> consider that this should be userspace controlled.
>> Personally I'd like to see more detail on those filters but if this is convention
>> in Asoc then so be it.
> 
> Configure filter and integrator is quite tricky. Updating filter and
> integrator parameters have impact on sample resolution and output sample
> rate.
> Sample resolution is the peak to peak data value and depends on
> oversampling parameters and filter order.
> 
> Output sample rate depends on SPI input clock frequency oversampling
> parameters and filter order.
> 
> High filter order gives a better resolution and a better filter response
> but allows less dynamic to find the good rate...
> 
> So it is a compromise between resolution, rate and filtering.
> 
> For ADC use case, filter orders 1 to 3 are recommended.
> For audio use case, orders 3 to 5 are recommended.
I'm never against allowing users enough rope to hang themselves
as long as the defaults are sensible :)
> 
> On IIO side i proposed to expose tuning in ABI, to allows application
> fine tuning.
> Need to document it...
> 
> For ASOC it is another story. Application requests a rate and a sample
> format. So filter parameters are computed based on SPI bus clock
> frequency, expected audio sample rate and audio sample format.
> This is done in stm32_adfsdm_get_best_osr in sound/soc/stm/stm32_adfsdm.c.
If there is only ever one sensible answer, fair enough on not being
able to pick and choose.
> 
> Now your comment trig a good point. Perhaps a better option in IIO,
> could be to offer same kind of ABI than ASOC interface:
> - standard oversampling-ratio ABI. based on it filter and integrator
> oversampling ratios will be computed to maximize the resolution.
> - a read only resolution ABI:
> /sys/bus/iio/devices/iio:deviceX/in_adc_x_resolution. That give the
> computed resolution.
Would this be directly exposed in terms of the 'maximum value' that
could come out?  If so we could use the existing range description
callbacks (called _available though that's somewhat missleading in
this case).
> 
> In this case filter order will be part of the DT for IIO and ASoC.
> This would also match with a redesign of the DFSDM driver in IIO...
Sounds to me like it would be sensible to do restrict things somewhat
in the first instance, and perhaps rename them as 'defaults' in the
future if we decide that userspace control does make sense.
Basically do it the first time someone bashes us over the head with
a usecase we aren't supporting well.

> 
>>> +
>>> +Optional properties:
>>> + - st,dai0-synchronized: Set to 1 to synchronize DAI with DFSDM instance 0.
>>> +
>>> +Exemple of a card with 2 Dmics synchronized and connected on SPI interface 1.
>> Example.
>>> +
>>> +	dfsdm: dfsdm@4400D000 {
>>> +		dai_dfsdm0: dfsdm-audio@0 {
>>> +			compatible = "st,stm32-dfsdm-audio";
>>> +			#sound-dai-cells = <0>;
>>> +			reg = <0>;
>>> +			dmas = <&dmamux1 101 0x400 0x00>;
>>> +			dma-names = "rx";
>>> +			st,input-id = <0>;
>>> +			st,dai-filter-order = <5>;
>>> +		};
>>> +		dai_dfsdm1: dfsdm-audio@1 {
>>> +			compatible = "st,stm32-dfsdm-audio";
>>> +			#sound-dai-cells = <0>;
>>> +			reg = <0>;
>>> +			dmas = <&dmamux1 102 0x400 0x00>;
>>> +			dma-names = "rx";
>>> +			st,input-id = <0>;
>>> +			st,dai0-synchronized = <1>;
>>> +			st,dai-filter-order = <5>;
>>> +		};
>>> +	};
>>> +	sound_dfsdm_pdm {
>>> +		compatible = "simple-audio-card";
>>> +		simple-audio-card,name = "dfsdm_pdm";
>>> +		status = "okay";
>>> +
>>> +		dfsdm0_mic0: simple-audio-card,dai-link@0 {
>>> +			format = "pdm";
>>> +			cpu {
>>> +				sound-dai = <&dai_dfsdm0>;
>>> +			};
>>> +			dmic0_codec: codec {
>>> +				sound-dai = <&dmic0>;
>>> +			};
>>> +		};
>>> +		dfsdm0_mic1: simple-audio-card,dai-link@1 {
>>> +			format = "pdm";
>>> +			bitclock-inversion = <1>;
>>> +			cpu {
>>> +				sound-dai = <&dai_dfsdm1>;
>>> +			};
>>> +			codec {
>>> +				sound-dai = <&dmic1>;
>>> +			};
>>> +		};
>>> +	};
>>>
>> Jonathan
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

