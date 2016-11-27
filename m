Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42637 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751546AbcK0PlS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 27 Nov 2016 10:41:18 -0500
Subject: Re: [PATCH v2 1/7] MFD: add bindings for stm32 general purpose timer
 driver
To: Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        alexandre.torgue@st.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, thierry.reding@gmail.com,
        linux-pwm@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <1480000463-9625-1-git-send-email-benjamin.gaignard@st.com>
 <1480000463-9625-2-git-send-email-benjamin.gaignard@st.com>
 <2b751c4a-3038-4220-05d8-d745c51a3691@kernel.org>
Cc: fabrice.gasnier@st.com, gerald.baeza@st.com,
        arnaud.pouliquen@st.com, linus.walleij@linaro.org,
        linaro-kernel@lists.linaro.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <b78a21f7-38a1-5a40-b96e-d1c9156aee68@kernel.org>
Date: Sun, 27 Nov 2016 15:41:11 +0000
MIME-Version: 1.0
In-Reply-To: <2b751c4a-3038-4220-05d8-d745c51a3691@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 27/11/16 14:10, Jonathan Cameron wrote:
> On 24/11/16 15:14, Benjamin Gaignard wrote:
>> Add bindings information for stm32 general purpose timer
>>
>> version 2:
>> - rename stm32-mfd-timer to stm32-gptimer
>> - only keep one compatible string
>>
>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
>> ---
>>  .../bindings/mfd/stm32-general-purpose-timer.txt   | 43 ++++++++++++++++++++++
>>  1 file changed, 43 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/mfd/stm32-general-purpose-timer.txt
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/stm32-general-purpose-timer.txt b/Documentation/devicetree/bindings/mfd/stm32-general-purpose-timer.txt
>> new file mode 100644
>> index 0000000..2f10e67
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mfd/stm32-general-purpose-timer.txt
>> @@ -0,0 +1,43 @@
>> +STM32 general purpose timer driver
>> +
>> +Required parameters:
>> +- compatible: must be "st,stm32-gptimer"
>> +
>> +- reg:			Physical base address and length of the controller's
>> +			registers.
>> +- clock-names: 		Set to "clk_int".
>> +- clocks: 		Phandle to the clock used by the timer module.
>> +			For Clk properties, please refer to ../clock/clock-bindings.txt
>> +
>> +Optional parameters:
>> +- resets:		Phandle to the parent reset controller.
>> +			See ..reset/st,stm32-rcc.txt
>> +
>> +Optional subnodes:
>> +- pwm:			See ../pwm/pwm-stm32.txt
>> +- iiotimer:		See ../iio/timer/stm32-iio-timer.txt
> Naming issue here.  Can't mention IIO as that's a linux subsystem and all
> bindings must be independent of OS. 
> 
> Perhaps adc-trigger-timer?
>> +
>> +Example:
>> +	gptimer1: gptimer1@40010000 {
>> +		compatible = "st,stm32-gptimer";
>> +		reg = <0x40010000 0x400>;
>> +		clocks = <&rcc 0 160>;
>> +		clock-names = "clk_int";
>> +
>> +		pwm1@0 {
>> +			compatible = "st,stm32-pwm";
>> +			st,pwm-num-chan = <4>;
>> +			st,breakinput;
>> +			st,complementary;
>> +		};
>> +
>> +		iiotimer1@0 {
>> +			compatible = "st,stm32-iio-timer";
> Again, avoid the use of iio in here (same issue you had with mfd in the previous
> version).
>> +			interrupts = <27>;
>> +			st,input-triggers-names = TIM5_TRGO,
> Docs for these should be introduced before they are used in an example.
> Same for the PWM ones above.  Expand the detail fo the example as you add
> the other elements.

I've just dived into the datasheet for these timers.
http://www.st.com/content/ccc/resource/technical/document/reference_manual/3d/6d/5a/66/b4/99/40/d4/DM00031020.pdf/files/DM00031020.pdf/jcr:content/translations/en.DM00031020.pdf


I think you need a binding that describes the capabilities of each of the timers
explicitly.   Down to the level of whether there is a repetition counter or not.
Each should exists as a separate entity in device tree.

They then have an existence as timers separate to the description of what they
are used for.

Here the only way we are saying they exist is by their use which doesn't feel
right to me.

So I think you need to move back to what you had in the first place.  The key
thing is that ever timer needs describing fully.  They are different enough
that for example the datasheet doesn't even try to describe them in one section.
(it has 4 separate chapters covering different sets of these hardware blocks).
The naming isn't really based on index, we are talking different hardware
that the datasheet authors have decided not to give different names to!

If they'd called them 
advanced timers
generic timers
basic timers 
really basic timers meant for driving the DAC (6 and 7)

We'd all have been quite happy with different compatible strings giving away
what they can do. 

What you have here is far too specific to what you are trying to do with them
right now.

These things are separately capable of timing capture (which is I guess where
the IIO device later comes in).

So my expectation is that we end up potentially instantiating:

1) An MFD to handle the shared elements of the timers.
2) Up to 12ish timers each with separate existence as a device in the driver model
and in device tree.
(nasty corner cases here are using timers as perscalers for other timers - I'd be
tempted to leave that for now)
Note that each of these devices has a different register set I think? Any shared
bits are handled via the mfd above (if we even need that MFD which I'm starting
to doubt looking at the datasheet).

3) Up to N pwms again with there own existence in the device model.  These don't
do much other than wrap the timer and stick it in output mode.
4) Up to N iio triggers - this is basically using the timer as a periodic interrupt
(though without the interrupt having visibility to the kernel) which fires off
sampling on associated ADCs.
5) Up to N iio capture devices for all channels that support timing capture.
Note there is also hardware encoder capture support in these which should be
correctly handled as well.  This comes back to an ancient discussion on the
TI ecap units which have similar capabilities (driver never went anywhere but
I think that was because the author left TI).

Certainly for the IIO devices these should no be bound up into one instance
as you have done here.

Anyhow, I fear that right now this discussion is missing the key ingredient
that the hardware is horrendously variable in it's capabilities and really
is 4-5 different types of hardware that just happen to share a few bits of
their offsets in their register maps.

So after all that I'm almost more confused than I was at the start!

Jonathan


>> +						  TIM2_TRGO,
>> +						  TIM4_TRGO,
>> +						  TIM3_TRGO;
>> +			st,output-triggers-names = TIM1_TRGO;
>> +		};
>> +	};
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

