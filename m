Return-Path: <SRS0=wu6A=4X=axentia.se=peda@kernel.org>
Subject: Re: [PATCH v2 2/3] iio: adc: at91-sama5d2_adc: add hw trigger and
 buffer support
To: Jonathan Cameron <jic23@kernel.org>, Eugen Hristev
	<eugen.hristev@microchip.com>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@free-electrons.com>, <linux-iio@vger.kernel.org>,
	<lars@metafoo.de>, <linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1493900000-26220-1-git-send-email-eugen.hristev@microchip.com>
 <1493900000-26220-3-git-send-email-eugen.hristev@microchip.com>
 <aeaf25d7-5e05-d854-1ae9-06d224925cad@kernel.org>
 <7fb32b5f-4705-ab23-d9c8-020b03af9ac1@microchip.com>
 <20170511060937.pzam3drvyaci6rnv@rfolt0960.corp.atmel.com>
 <af420704-0df8-184a-4fa2-c7e509a9b15d@kernel.org>
 <b492b8d7-2f94-635e-518d-1e7563acb392@microchip.com>
 <ae4e7987-d34e-0e8b-a975-6506af49a807@kernel.org>
CC: Ludovic Desroches <ludovic.desroches@microchip.com>, Mark Rutland
	<Mark.Rutland@arm.com>, Rob Herring <robh+dt@kernel.org>
From: Peter Rosin <peda@axentia.se>
Message-ID: <395e7e0a-2c04-350c-c880-84d09e98a664@axentia.se>
Date: Wed, 17 May 2017 09:47:52 +0200
MIME-Version: 1.0
In-Reply-To: <ae4e7987-d34e-0e8b-a975-6506af49a807@kernel.org>
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-iio@vger.kernel.org>

On 2017-05-16 20:03, Jonathan Cameron wrote:
> <snip> As we are only left with one area of questions.
>>>>>>>
>>>>>>> +static const struct at91_adc_trigger at91_adc_trigger_list[] = {
>>>>>>> +    {
>>>>>>> +        .name = "external-rising",
>>>>>>> +        .trgmod_value = AT91_SAMA5D2_TRGR_TRGMOD_EXT_TRIG_RISE,
>>>>>>> +    },
>>>>>>> +    {
>>>>>>> +        .name = "external-falling",
>>>>>>> +        .trgmod_value = AT91_SAMA5D2_TRGR_TRGMOD_EXT_TRIG_FALL,
>>>>>>> +    },
>>>>>>> +    {
>>>>>>> +        .name = "external-any",
>>>>>>> +        .trgmod_value = AT91_SAMA5D2_TRGR_TRGMOD_EXT_TRIG_ANY,
>>>>>>> +    },
>>>>>> Hmm. Should this be a userspace configurable option?  Feels rather like
>>>>>> it is an element of the hardware - reflecting the characteristics of
>>>>>> some
>>>>>> hardware device sat on the pin.
>>>>> The user can choose from sysfs which trigger
>>>>> is best suited for the use case, since all
>>>>> three triggers are provided and can be connected to the buffer.
>>>>> It reflects more the triggering capability of the ADC rather than
>>>>> any different hardware device sitting on the pin
>>>>
>>>> I am also in favour of a userspace configurable option. For sure it's
>>>> hardware related but on our board we only provide a trigger pin, we
>>>> don't know which hardware the customer will put on this pin.
>>> hmm. OK I'm persuaded I think.
>>>
>>> Could do this with devicetree overlays or similar.
>>>
>>> So follow up question is whether this is the right interface.
>>> Can all 3 run at once sensibly?  If not are we not looking at a control
>>> parameter for a single trigger?
>>
>> There is a single trigger hardware pin, but can work in one of the three
>> modes. Do you suggest I should change it to a single trigger, but then
>> we need some kind of sysfs entry to control it ?
>>
>> Or perhaps change the trigger to be exclusive to the device/buffer, in
>> which case just one trigger can be used anyway with the current_trigger
>> option in buffer.
>>
>> If somehow more than one trigger would be enabled in the same time,
>> only the last enabled one will work, since I write the corresponding
>> trigger edge configuration value in the ADC register. So in fact these three triggers are mutually exclusive, as enabling one disables the
>> other, however, it's not transparent to the user.
> Ah that definitely suggests to me it should be a sysfs attribute associated
> with the trigger rather than 3 separate triggers.  The interpretation
> of those triggers would require userspace to have some knowledge of what
> is going on, so I don't think we have any problems by requiring it instead
> to know about a sysfs attribute.
>>
>> These kind of different edge triggers used to be in device tree in
>> older at91 driver.
>> I have given it thought and decided to let just the driver know about
>> them. Since they are bound to the ADC IP block and not related to any
>> hardware description of the board or the special connectivity that
>> the driver might be interested about. I mean the driver knows the
>> trigger works this way because it's part of the block, and device tree
>> cannot change this, so the portability of the driver is not affected
>> and related to SoC design only.
> Sort of (I think..)  As I understand it we are still talking about an
> external pin?  A possible usecase for this sort of thing would be
> combining with an external sequencer with an analog mux.  In that
> case only one of the options will make any sense. (this is the
> hardware equivalent of what Peter Rosin's mux subsystem puts
> under software control)
> 
> We might be in one of those interesting cases where a devicetree
> binding should exist for the fixed case, but with the flexibility
> to allow userspace to specify it if and only if it is not specified
> in the device tree.  So if the devicetree in some sense describes
> downstream hardware it is fixed as appropriate.  If it doesn't and
> we are looking at an 'edge of known world' situation then we let
> userspace have control?  Does that make sense?
> 
> I don't suppose we have any idea what this is actually used for
> on real world boards?
> 
> I've pulled in Peter, Mark and Rob as CCs to see if they want to
> comment.

>From what I can tell, this touches the mux code [1] for cases where
you have (some hypothetical) hardware of this style:

    .----.
    |a5d2|
    |    |
    |GPO0|----------.
    |GPO1|--------. |
    |    |        | |
    |    |     .-------.
    |    |     |dg4052a|
    |    |     |       |
    | ADC|-----|X    X0|---- signal X0
    |TRGR|--.  |     X1|---- signal X1
    |    |  |  |     X2|---- signal X2
    |    |  |  |     X3|---- signal X3
    |    |  |  |       |
    |    |  '--|Y    Y0|---- trigger Y0
    |    |     |     Y1|---- trigger Y1
    '----'     |     Y2|---- trigger Y2
               |     Y3|---- trigger Y3
               '-------'

Where signal X0 (when it's selected but the mux) should be sampled as
trigger Y0 is rising and signal X1 (when it's selected) should be
sampled for both edges of trigger Y1. Or something like that...

The iio-mux (patch 7/13 [2]) of course needs to be extended to handle
triggers and buffers before there is any chance the above will work. The
iio-mux currently knows nothing about buffers/triggers (I'm also a novice
in that area and don't have any current need for it).

But, for the iio-mux to possibly handle the above, it needs some way to
switch the trigger (in inkern.c?) when the mux state is changing. And
it then becomes obvious that there needs to be some mechanism other than
device-tree to set the trigger style in the at91 adc driver.

I expect that similar issues are present in other adc drivers that
support triggers, so I don't know if any of this needs to affect the path
taken with the at91 driver at this time?

Cheers,
peda

[1] https://lkml.org/lkml/2017/5/14/160
[2] https://lkml.org/lkml/2017/5/14/163
