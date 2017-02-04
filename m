Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58770 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752858AbdBDMJh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 Feb 2017 07:09:37 -0500
Subject: Re: [PATCH 3/7] IIO: add bindings for STM32 DFSDM ADC driver
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
 <1485189145-29576-4-git-send-email-arnaud.pouliquen@st.com>
 <fa6b541d-2818-afa7-82fa-eb19806e9f4d@kernel.org>
 <36426523-c59f-4010-b341-acb60ebdcbb5@kernel.org>
 <d9747aa9-e3c2-f280-7dca-8862e8e74e6e@st.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <701672ca-9888-7d86-d41a-d457b1739b9a@kernel.org>
Date: Sat, 4 Feb 2017 12:09:33 +0000
MIME-Version: 1.0
In-Reply-To: <d9747aa9-e3c2-f280-7dca-8862e8e74e6e@st.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 31/01/17 14:10, Arnaud Pouliquen wrote:
> Hi Jonathan,
> 
> On 01/29/2017 01:42 PM, Jonathan Cameron wrote:
>> On 29/01/17 11:58, Jonathan Cameron wrote:
>>> On 23/01/17 16:32, Arnaud Pouliquen wrote:
>>>> This patch adds documentation of device tree bindings for the
>>>> STM32 DFSDM ADC.
>>>>
>>>> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
>>> Trivial bits inline.
>>>> ---
>>>>  .../bindings/iio/adc/st,stm32-dfsdm-adc.txt        | 60 ++++++++++++++++++++++
>>>>  1 file changed, 60 insertions(+)
>>>>  create mode 100644 Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.txt 
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.txt  b/Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.txt 
>>>> new file mode 100644
>>>> index 0000000..c156bcb
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.txt 	
>>>> @@ -0,0 +1,60 @@
>>>> +STMicroelectronics STM32 DFSDM ADC device driver
>>>> +
>>>> +STM32 DFSDM ADC is a sigma delta analog-to-digital converter.
>>>> +It has to be declared in device-tree as a subnode of the DFSDM mfd node.
>>>> +
>>>> +It has several multiplexed input channels. Conversions can be performed
>>>> +in single, scan or discontinuous mode. Conversions can be launched in software
>>>> +or using hardware triggers.
>>>> +Each instance of the driver uses one filter instance handle by the DFSDM mfd
>>>> +driver.
>>>> +
>>>> +DFSDM also offers extra features:
>>>> +-The analog watchdog feature allows the application to detect if the
>>>> + input voltage goes beyond the user-defined, higher or lower thresholds.
>>>> +-The short circuit detection allows allows the application to detect if the
>>>> + input is in CC.
>>>> +-The clock absence detection allows application to detect if SPI input is clocked.
>>>> +
>>>> +Required properties:
>>>> +- compatible:	Must be "st,stm32-dfsdm-adc".
>>>> +- reg:		Specifies the DFSDM filter instance.
>>>> +- #io-channel-cells = <1>: See the IIO bindings section "IIO consumers".
>>>> +- st,adc-channels:	List of single-ended channels muxed for this ADC.
>>>> +- st,adc-channel-names:	List of single-ended channels Name.
>>>> +
>>>> +Optional properties:
>>>> +- st,adc-channel-types:	Single-ended channel input type. Default value is 0.
>>>> +			- 0: SPI with data on rising edge (default)
>>>> +			- 1: SPI with data on falling edge
>>> This is an element that can be described without magic numbers so I'd
>>> prefer that you do so.
>>>
>>> Also spell check edage -> edge.
>>>
>>>> +			- 2: manchester codec, rising edage = logic 0
>>>> +			- 3: manchester codec, rising edage = logic 1
>>>> +- st,adc-channel-clk-src: Conversion clock source. default value is 1.
>>>> +			  - 0: External SPI clocl (CLKIN x)
>>>> +			  - 1: internal SPI clock (CLKOUT) (default)
>>>> +			  - 2: internal SPI clock divided by 2 (falling edge).
>>>> +			  - 2: internal SPI clock divided by 2 (rising edge).
>>> 3?
>>>> +- st,adc-alt-channel: 	  must be defined if Two ADCs are connected on same SPI
>>>> +			  input.
>>>> +			  If not set channel n is connected to SPI input n.
>>>> +			  If set channel n is connected to SPI input n + 1.
>>> ? Two data inputs with shared clock?
>>>> +
>>>> +Example:
>>>> +	dfsdm: dfsdm@4400D000 {
>> I'd like to actually see the ADCs on the end of these explicitly
>> described as well.  It's entirely possible we'll have something
>> that isn't simply a dumb sigma delta modulator that will need
>> it's own driver.
>>
>> In some senses what we actually have here is a data bus so we
>> should be able to describe things on it in that fashion
>> rather than just describing the data that is in coming.
>> Our boundary of knowledge isn't at the edge of this device!
>>
>> A quick example google fed me would be the gain control on a
>> maxim ds8102.
>>
>> Tricky bit here will be defining this nice and generally when we
>> currently only have the one piece of hardware to do it with ;)
>>
>> That's what makes kernel development fun!
>>
> 
> What you describe here seems similar to audio codecs device defined in
> ASoC. An Audio codec is an external chip that is connected to SoC
> through an audio bus.
> ASoC allows to bind this codec with the SOC DAI (digital Audio Interface).
Yes, that was exactly what I was thinking of.  Was a while back but
I once mainlined a codec so had this at the back of my mind.
> 
> FYI we should have this kind of feature to support on STM32 uin second step:
> DSFDM input can also process stm32 ADC output through an hardware pipe
> (stm32-adc IIO driver that has been recently integrated in kernel).
> Internally, to pipe the ADC with DFSDM, we use an extension of inkern
> interface that is very similar with the one mentioned by Lars:
> 
> https://github.com/analogdevicesinc/linux/blob/xcomm_zynq/drivers
> /iio/buffer/hw_consumer.c
> 
> Don't know if this is what Lars has in mind... but a solution could be
> to define a new type of IIO that would be something like
> "postprocessing" or "filter". This new iio device type could be piped to
> a frontend IIO device to export a new one (through hw_consumer.c interface).
> In this case for simple device like PDM audio microphone that does not
> required control a kind of dummy frontend device could be defined...
That could work.  We already have stacked IIO devices - only difference
here is that we can't actually see the data flowing between the levels
of stack (or pipeline).

J
> 
> Regards
> Arnaud
> 
>>>> +		iio_dfsdm0: iio-dfsdm@0 {
>>>> +			compatible = "st,stm32-dfsdm-adc";
>>>> +			#io-channel-cells = <1>;
>>>> +			reg = <0>;
>>>> +			st,adc-channels = <1>;
>>>> +			st,adc-channel-names = "in0";
>>>> +		};
>>>> +		iio_dfsdm1: iio-dfsdm@1 {
>>>> +			compatible = "st,stm32-dfsdm-adc";
>>>> +			#io-channel-cells = <1>;
>>>> +			reg = <1>;
>>>> +			st,adc-channels = <1>;
>>>> +			st,adc-channel-names = "in1";
>>>> +			st,adc-channel-types = <1>;
>>>> +			st,adc-alt-channel = <1>;
>>>> +		};
>>>> +	};
>>>>
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

