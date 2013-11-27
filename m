Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53777 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751012Ab3K0ISD (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 27 Nov 2013 03:18:03 -0500
In-Reply-To: <9848F2DB572E5649BA045B288BE08FBE01898D6F@039-SN2MPN1-023.039d.mgd.msft.net>
References: <1385463394-11157-1-git-send-email-B38611@freescale.com> <1385463394-11157-4-git-send-email-B38611@freescale.com> <20131126140926.GA5402@e106331-lin.cambridge.arm.com> <9848F2DB572E5649BA045B288BE08FBE01898D6F@039-SN2MPN1-023.039d.mgd.msft.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: RE: [PATCH v3 3/3] Documentation: add the binding file for Freescale vf610 ADC driver
From: Jonathan Cameron <jic23@kernel.org>
Date: Wed, 27 Nov 2013 08:09:35 +0000
To: Fugang Duan <fugang.duan@freescale.com>,
	Mark Rutland <mark.rutland@arm.com>
CC: "sachin.kamat@linaro.org" <sachin.kamat@linaro.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"shawn.guo@linaro.org" <shawn.guo@linaro.org>,
	Frank Li <Frank.Li@freescale.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Message-ID: <56212a87-d3e7-4ef7-8198-0cb059b98979@email.android.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



Fugang Duan <fugang.duan@freescale.com> wrote:
>From: Mark Rutland [mailto:mark.rutland@arm.com]
>Data: Tuesday, November 26, 2013 10:09 PM
>
>>To: Duan Fugang-B38611
>>Cc: jic23@kernel.org; sachin.kamat@linaro.org;
>devicetree@vger.kernel.org;
>>shawn.guo@linaro.org; Li Frank-B20596; linux-iio@vger.kernel.org
>>Subject: Re: [PATCH v3 3/3] Documentation: add the binding file for
>Freescale
>>vf610 ADC driver
>>
>>On Tue, Nov 26, 2013 at 10:56:34AM +0000, Fugang Duan wrote:
>>> The patch adds the binding file for Freescale vf610 ADC driver.
>>>
>>> Signed-off-by: Fugang Duan <B38611@freescale.com>
>>> ---
>>>  .../devicetree/bindings/iio/adc/vf610-adc.txt      |   57
>>++++++++++++++++++++
>>>  1 files changed, 57 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/iio/adc/vf610-adc.txt
>>> b/Documentation/devicetree/bindings/iio/adc/vf610-adc.txt
>>> new file mode 100644
>>> index 0000000..4101516
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/iio/adc/vf610-adc.txt
>>> @@ -0,0 +1,57 @@
>>> +Freescale vf610 Analog to Digital Converter bindings
>>> +
>>> +The devicetree bindings are for the new ADC driver written for
>>> +vf610/i.MX6slx and upward SoCs from Freescale.
>>> +
>>> +Required properties:
>>> +- compatible: Should be "fsl,vf610-adc"
>>
>>s/be/contain/
>>
>>> +- reg: Offset and length of the register set for the device
>>> +- interrupts: Should contain the interrupt for the device
>>> +- clocks: The clocks needed by the ADC controller
>>
>>How many? Which ones?
>>
>>> +- clock-names: the name of the clocks
>>
>>Either define the set of names, or don't use clock-names. It's useless
>if it
>>doesn't tell you anything.
>>
>>> +
>>> +Optional properties:
>>> +- fsl,adc-io-pinctl: Enable field for the I/O port control of MCU
>pins used
>>as analog inputs.
>>> +- fsl,adc-vref: ADC refrence voltage value, unit is uV.
>>
>>Can you not query the regulator to figure this out?
>
>This is optional, some board design have no fixed regulator, just
>supply fixed voltage from MCU digital power which
>Cannot handled by the module.
Fixed regulators are used when things either supplied by an actual fixed reg or when
 directly connected to another supply. It does not have to correspond to a bit of real
 hardware though that MCU digital power is coming from somewhere!

Hence this definitely wants to be a regulator 
>
>>
>>> +- fsl,adc-clk-div: Current clock divider value, such as 1,2,4,8,16
>and so on.
>>
>>Could you elaborate on this? What's it used for and why is it needed?
>
>Exp: ADC clock source is ipg bus clock, the clk divider can control the
>ADC sample speed while other setting don't change:
>	The sample speed that clock divider is equal to 1 is twice  than the
>divider is equal to 2.
>
>Anyway, it can control sample speed by user. 
If left in device tree then this might be best implemented as a very simple clock.
I would prefer it to be controlled from user space as sampling_frequency.
>
>>
>>> +- fsl,adc-res: ADC conversion mode selection, such as 8 for 8-bit,
>10 for
>>10-bit, 12 for 12-bit mode.
>>
>>This sounds like something that could be changed at runtime. Why does
>this need
>>to be configured in the DT?
>>
>>> +- fsl,adc-sam-time: ADC sample time duration, number of ADC clocks,
>>> +such as 2, 4, 6, 8, 12, 16, 20, 24
>>
>>Likewise.
>>
>>Please don't poinltessly abbreviate, "sample" is much better than
>"sam"
>>here...
>>
>>> +- fsl,adc-aver-sam-sel: Determines how many ADC conversions will be
>averaged
>>to create the ADC average result.
>>> +			The Optional value is 4, 8, 16, 32.
>>
>>Likewise.
>
>
>For above ADC configuration, ADC conversion mode, sample time duration,
>hardware average sample selection, and so on.
>All of them can changed at runtime. The only method is to introduce the
>ioctl interface for user to change them at runtime.
>How about you think ?  
No it is not. Like all similar controls these
Should be via sysfs attributes created via
The standard channel structures in IIO.
Sample duration might be integration_time
 or sampling_frequency depending on its exact semantics. Averaging is a form of low pass filter and should be specified as such.

If it is not already in the abi then propose something new.

The only one here that I can see an issue with doing that way is the resolution. So far it hasn't actually made sense to make this controllable..
Couple of questions on that.
1. What effect on speed of sampling does changing this have? Note that we probably do not care about this if using sysfs reading.
2. What other disadvantages are there to always running in 12 bit mode?

I have no problem with adding write support for the type of buffer elements though it would require some IIO core infrastructure.
However I do want a well described reason to bother with the added complexity.

>
>>
>>> +- fsl,adc-hw-aver-en: Bool type to decide enable hardware average
>function.
>>
>>When would you wnat this and when wouldn't you?
>>
>>Similarly, "averages" is far clearer than "aver".
>
>Ok, I see. Thanks.
>>
>>> +- fsl,adc-low-power-mode: Bool type to decide enable ADC low power
>mode.
>>
>>Similarly?
This one is interesting. What effects does it have in this device? Sometimes it is a
 sampling frequency restriction... 
>>
>>> +- fsl,adc-high-speed-conv: Bool type to decide enable ADC high
>speed mode.
>>
>>Similarly?
>>
>>> +- vref: The regulator to support ADC refrence voltage.
>>
>>s/vref/vref-supply/
>>
>>Thanks,
>>Mark.
>
>Thanks for your review.
>Summary, there have many comments why don't let some ADC configuration
>change at runtime.
>The driver still don't add ioctl interface for user to configurate the
>ADC setting. So the setting are got from DT.
>
>Do you have one good method to change the configuration at runtime ?
See above :)

In short...Add relevant bits to info_mask_* in all the iio_Chan_spec structures then put the
 relevant handling in the read_raw and write_raw iio_info callbacks.
>
>Thanks,
>Andy
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
