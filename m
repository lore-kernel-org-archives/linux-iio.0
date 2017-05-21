Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37015 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750824AbdEUL7C (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 21 May 2017 07:59:02 -0400
Subject: Re: [PATCH v2 2/3] iio: adc: at91-sama5d2_adc: add hw trigger and
 buffer support
To: Eugen Hristev <eugen.hristev@microchip.com>,
        Peter Rosin <peda@axentia.se>, nicolas.ferre@microchip.com,
        alexandre.belloni@free-electrons.com, linux-iio@vger.kernel.org,
        lars@metafoo.de, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
References: <1493900000-26220-1-git-send-email-eugen.hristev@microchip.com>
 <1493900000-26220-3-git-send-email-eugen.hristev@microchip.com>
 <aeaf25d7-5e05-d854-1ae9-06d224925cad@kernel.org>
 <7fb32b5f-4705-ab23-d9c8-020b03af9ac1@microchip.com>
 <20170511060937.pzam3drvyaci6rnv@rfolt0960.corp.atmel.com>
 <af420704-0df8-184a-4fa2-c7e509a9b15d@kernel.org>
 <b492b8d7-2f94-635e-518d-1e7563acb392@microchip.com>
 <ae4e7987-d34e-0e8b-a975-6506af49a807@kernel.org>
 <395e7e0a-2c04-350c-c880-84d09e98a664@axentia.se>
 <de3dfa02-dfb4-f407-525f-1abeaf9cfa12@microchip.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <89fdb60f-f127-8681-4104-03e59a005de4@kernel.org>
Date: Sun, 21 May 2017 12:58:57 +0100
MIME-Version: 1.0
In-Reply-To: <de3dfa02-dfb4-f407-525f-1abeaf9cfa12@microchip.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 17/05/17 12:35, Eugen Hristev wrote:
> 
> 
> On 17.05.2017 10:47, Peter Rosin wrote:
>> On 2017-05-16 20:03, Jonathan Cameron wrote:
>>> <snip> As we are only left with one area of questions.
>>>>>>>>>
>>>>>>>>> +static const struct at91_adc_trigger at91_adc_trigger_list[] = {
>>>>>>>>> +    {
>>>>>>>>> +        .name = "external-rising",
>>>>>>>>> +        .trgmod_value = AT91_SAMA5D2_TRGR_TRGMOD_EXT_TRIG_RISE,
>>>>>>>>> +    },
>>>>>>>>> +    {
>>>>>>>>> +        .name = "external-falling",
>>>>>>>>> +        .trgmod_value = AT91_SAMA5D2_TRGR_TRGMOD_EXT_TRIG_FALL,
>>>>>>>>> +    },
>>>>>>>>> +    {
>>>>>>>>> +        .name = "external-any",
>>>>>>>>> +        .trgmod_value = AT91_SAMA5D2_TRGR_TRGMOD_EXT_TRIG_ANY,
>>>>>>>>> +    },
>>>>>>>> Hmm. Should this be a userspace configurable option?  Feels rather like
>>>>>>>> it is an element of the hardware - reflecting the characteristics of
>>>>>>>> some
>>>>>>>> hardware device sat on the pin.
>>>>>>> The user can choose from sysfs which trigger
>>>>>>> is best suited for the use case, since all
>>>>>>> three triggers are provided and can be connected to the buffer.
>>>>>>> It reflects more the triggering capability of the ADC rather than
>>>>>>> any different hardware device sitting on the pin
>>>>>>
>>>>>> I am also in favour of a userspace configurable option. For sure it's
>>>>>> hardware related but on our board we only provide a trigger pin, we
>>>>>> don't know which hardware the customer will put on this pin.
>>>>> hmm. OK I'm persuaded I think.
>>>>>
>>>>> Could do this with devicetree overlays or similar.
>>>>>
>>>>> So follow up question is whether this is the right interface.
>>>>> Can all 3 run at once sensibly?  If not are we not looking at a control
>>>>> parameter for a single trigger?
>>>>
>>>> There is a single trigger hardware pin, but can work in one of the three
>>>> modes. Do you suggest I should change it to a single trigger, but then
>>>> we need some kind of sysfs entry to control it ?
>>>>
>>>> Or perhaps change the trigger to be exclusive to the device/buffer, in
>>>> which case just one trigger can be used anyway with the current_trigger
>>>> option in buffer.
>>>>
>>>> If somehow more than one trigger would be enabled in the same time,
>>>> only the last enabled one will work, since I write the corresponding
>>>> trigger edge configuration value in the ADC register. So in fact these three triggers are mutually exclusive, as enabling one disables the
>>>> other, however, it's not transparent to the user.
>>> Ah that definitely suggests to me it should be a sysfs attribute associated
>>> with the trigger rather than 3 separate triggers.  The interpretation
>>> of those triggers would require userspace to have some knowledge of what
>>> is going on, so I don't think we have any problems by requiring it instead
>>> to know about a sysfs attribute.
>>>>
>>>> These kind of different edge triggers used to be in device tree in
>>>> older at91 driver.
>>>> I have given it thought and decided to let just the driver know about
>>>> them. Since they are bound to the ADC IP block and not related to any
>>>> hardware description of the board or the special connectivity that
>>>> the driver might be interested about. I mean the driver knows the
>>>> trigger works this way because it's part of the block, and device tree
>>>> cannot change this, so the portability of the driver is not affected
>>>> and related to SoC design only.
>>> Sort of (I think..)  As I understand it we are still talking about an
>>> external pin?  A possible usecase for this sort of thing would be
>>> combining with an external sequencer with an analog mux.  In that
>>> case only one of the options will make any sense. (this is the
>>> hardware equivalent of what Peter Rosin's mux subsystem puts
>>> under software control)
> The ADTRG is a pin directly connected to the SoC. Since we have
> multiple analog channels as input, the mux would be useful if the use
> case would imply many more inputs, and then some overload on userspace
> to differentiate between the muxed values since the conversion will
> happen on the same channel...
This is done by having the channels represented at the end
point - i.e. userspace sees a device representing the inputs to the mux.
The question of how it works is of no interest to userspace at all.

> The ADTRG will simply tell the SoC when to do the conversion, with
> respect to the charging delay which is a few clock cycles. So the
> ADTRG is a digital input and depending on which signal we connect,
> and which type of edge we want to catch, we can configure it
> via the three triggers (or change to a single parametrized trigger).
> The ADC block inside the SoC can also be connected to the PWM signal,
> and that trigger is yet to be implemented in the driver (I will do it
> in a future patch). So the ADTRG can be connected to an external PWM,
> or some kind of signal that is already resemblant with which kind of
> conversion speed or intervals between conversions that we want to have
> on the analog channels.
Sure, but in all these cases it is a feature of the board so arguably
the configuration should a devicetree question rather than a userspace
one.  The unknown edge case (wired out to a terminal) is the only one
where it should be in the domain of userspace.

Particularly interesting is tht there is an internal pwm option.  If
that's the case, why would anyone want to use an external one unless it
is also associated with some other element of external circuitry?
That external circuitry puts constraints on what makes sense for
which edges to use and those constraints should be in the device tree.
>>>
>>> We might be in one of those interesting cases where a devicetree
>>> binding should exist for the fixed case, but with the flexibility
>>> to allow userspace to specify it if and only if it is not specified
>>> in the device tree.  So if the devicetree in some sense describes
>>> downstream hardware it is fixed as appropriate.  If it doesn't and
>>> we are looking at an 'edge of known world' situation then we let
>>> userspace have control?  Does that make sense?
> I considered that the ADTRG can work in the three possible ways, so
> depending on the need, the application in userspace can decide how to
> configure it.
> Having it in devicetree doesn't make much difference for
> the driver. Instead of automagically knowing that ADTRG has three
> different edge configurations, it will read the device tree and in the
> end, the configuration should reach userspace one way or the other.
Typically userspace shouldn't care what the configuration is if we
are talking hardware setup...

> So the devicetree is cleaner and not bloated with extra unneeded
> information that the driver should already know.
> One other option would be to have some kind of default edge type in
> device tree and the driver will work with that. However, changing the
> edge type would require a restart, and limits the functionality.
> Another option is to have the driver use only one type of edge, which
> again limits the functionality.
> So that's why I thought to let userspace configure the edge type,
> and not put it in devicetree since we can't have other types. (unless
> someone might have a strange reason to make unavailable some of the
> possible edge configurations)
I think we definitely want at least the default in devicetree.

For the vast majority of cases this is a feature of board wiring and
nothing more.  It's not an application decision.  There will be a right
option depending on the external circuitry.
>>>
>>> I don't suppose we have any idea what this is actually used for
>>> on real world boards?
>>>
>>> I've pulled in Peter, Mark and Rob as CCs to see if they want to
>>> comment.
>>
>> From what I can tell, this touches the mux code [1] for cases where
>> you have (some hypothetical) hardware of this style:
>>
>>     .----.
>>     |a5d2|
>>     |    |
>>     |GPO0|----------.
>>     |GPO1|--------. |
>>     |    |        | |
>>     |    |     .-------.
>>     |    |     |dg4052a|
>>     |    |     |       |
>>     | ADC|-----|X    X0|---- signal X0
>>     |TRGR|--.  |     X1|---- signal X1
>>     |    |  |  |     X2|---- signal X2
>>     |    |  |  |     X3|---- signal X3
>>     |    |  |  |       |
>>     |    |  '--|Y    Y0|---- trigger Y0
>>     |    |     |     Y1|---- trigger Y1
>>     '----'     |     Y2|---- trigger Y2
>>                |     Y3|---- trigger Y3
>>                '-------'
>>
>> Where signal X0 (when it's selected but the mux) should be sampled as
>> trigger Y0 is rising and signal X1 (when it's selected) should be
>> sampled for both edges of trigger Y1. Or something like that...
> In this case one would need to enable the rising edge trigger,
> do the conversion for X0, then disable and enable the both-edge
> trigger, and read conversion for Y1. Or, one can use the both-edge
> trigger all the time and just ignore the conversion on the falling
> edge for X0. (All this considering the rise-fall time is less than
> conversion time of course)
I'm going to count this one as too hideous to contemplate, but yes
in theory that could be the case.  In that case the mux code would
indeed need to know what the heck is going on to be able to do it.

So in that case the devicetree description of the weird triggering would
have to be represented on the other side of the mux.
I.e. it's a characteristic of the channels being sampled, rather
than the ADC.  We are rapidly heading into the area of 'sound card'
drivers - where the complexity is too high to handle with a generic
framework, but instead one wraps up the generic framework in a
container driver that can know all the magic needed to make the whole
system of complex connections work.
>>
>> The iio-mux (patch 7/13 [2]) of course needs to be extended to handle
>> triggers and buffers before there is any chance the above will work. The
>> iio-mux currently knows nothing about buffers/triggers (I'm also a novice
>> in that area and don't have any current need for it).
>>
>> But, for the iio-mux to possibly handle the above, it needs some way to
>> switch the trigger (in inkern.c?) when the mux state is changing. And
>> it then becomes obvious that there needs to be some mechanism other than
>> device-tree to set the trigger style in the at91 adc driver.
> For the ADC IP block, the trigger changing is just a matter of a
> write to a register. We could have something like a callback for the
> trigger ops that could do that in theory. The driver could provide
> something like a trigger_style enum to the subsystem and the callback
> could pass back one of the possible configurations. Then the trigger
> could auto-adjust to the new type of edge needed, without disabling
> and reenabling the trigger.
>>
>> I expect that similar issues are present in other adc drivers that
>> support triggers, so I don't know if any of this needs to affect the path
>> taken with the at91 driver at this time?
> At this time we want to implement the support for the hardware trigger
> pin that we have on the SoC, and the corresponding buffer management,
> and in the future to support more of the hardware features for this
> block.
For now I'm favouring the devicetree option to specify the edges but
as optional.  So if it isn't a characteristic of the board layout it
is permissible to leave it to userspace to configure.  Whether userspace
is locked out from configuring it or not could be a second devicetree
attribute perhaps?

Jonathan
> 
> Regards,
> Eugen
>>
>> Cheers,
>> peda
>>
>> [1] https://lkml.org/lkml/2017/5/14/160
>> [2] https://lkml.org/lkml/2017/5/14/163
>>

