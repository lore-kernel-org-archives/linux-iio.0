Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:49812 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750803AbdEBP7P (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 2 May 2017 11:59:15 -0400
Subject: Re: [PATCH v2 3/4] iio: accel: adxl345: Setup DATA_READY trigger
To: Rob Herring <robh+dt@kernel.org>
Cc: Eva Rachel Retuya <eraretuya@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Daniel Baluta <daniel.baluta@gmail.com>,
        Alison Schofield <amsfield22@gmail.com>,
        Florian Vaussard <florian.vaussard@heig-vd.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1493450577.git.eraretuya@gmail.com>
 <d5c737cf4e5a2d639d09ad95f58ab32e01d0c338.1493450577.git.eraretuya@gmail.com>
 <977684c1-8c87-80ae-fc13-576e30e88384@kernel.org>
 <CAL_JsqJmF7YhVTqC0daEd50DFAJLyfq-rnUv6sZhabTmm56wQw@mail.gmail.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <7cba924d-333c-2bd0-8986-5513f833fe6a@kernel.org>
Date: Tue, 2 May 2017 16:59:12 +0100
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJmF7YhVTqC0daEd50DFAJLyfq-rnUv6sZhabTmm56wQw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/05/17 04:01, Rob Herring wrote:
> On Sun, Apr 30, 2017 at 7:32 PM, Jonathan Cameron <jic23@kernel.org> wrote:
>> On 29/04/17 08:49, Eva Rachel Retuya wrote:
>>> The ADXL345 provides a DATA_READY interrupt function to signal
>>> availability of new data. This interrupt function is latched and can be
>>> cleared by reading the data registers. The polarity is set to active
>>> high by default.
>>>
>>> Support this functionality by setting it up as an IIO trigger.
>>>
>>> In addition, two output pins INT1 and INT2 are available for driving
>>> interrupts. Allow mapping to either pins by specifying the
>>> interrupt-names property in device tree.
>>>
>>> Signed-off-by: Eva Rachel Retuya <eraretuya@gmail.com>
>> Coming together nicely, but a few more bits and pieces inline...
>>
>> One slight worry is that the irq names stuff is to restrictive
>> as we want to direct different interrupts to different pins if
>> both are supported!
> 
> [...]
> 
>>> @@ -199,6 +253,22 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
>>>               dev_err(dev, "Failed to set data range: %d\n", ret);
>>>               return ret;
>>>       }
>>> +     /*
>>> +      * Any bits set to 0 send their respective interrupts to the INT1 pin,
>>> +      * whereas bits set to 1 send their respective interrupts to the INT2
>>> +      * pin. Map all interrupts to the specified pin.
>> This is an interesting comment.  The usual reason for dual interrupt
>> pins is precisely to not map all functions to the same one.  That allows
>> for a saving in querying which interrupt it is by having just the data ready
>> on one pin and just the events on the other...
>>
>> Perhaps the current approach won't support that mode of operation?
>> Clearly we can't merge a binding that enforces them all being the same
>> and then change it later as it'll be incompatible.
>>
>> I'm not quite sure how one should do this sort of stuff in DT though.
>>
>> Rob?
> 
> DT should just describe what is connected which I gather here could be
> either one or both IRQs. We generally distinguish the IRQs with the
> interrupt-names property and then retrieve it as below.
Picking this branch to continue on I'll grab Eva's replay as well.

Eva said:
> I've thought about this before since to me that's the better approach
> than one or the other. I'm in a time crunch before hence I went with
> this way. The input driver does this as well and what I just did is to
> match what it does. If you could point me some drivers for reference,
> I'll gladly analyze those and present something better on the next
> revision.

So taking both of these and having thought about it a bit more in my
current jet lagged state (I hate travelling - particularly with the
added amusement of a flat tyre on the plane).

To my mind we need to describe what interrupts at there as Rob says.
It's all obvious if there is only one interrupt connected (often
the case I suspect as pins are in short supply on many SoCs).

If we allow the binding to specify both pins (using names to do the
matching to which pin they are on the chip), then we could allow
the driver itself to optimize the usage according to what is enabled.
Note though that this can come later - for now we just need to allow
the specification of both interrupts if they are present.

So lets talk about the ideal ;)
Probably makes sense to separate dataready and the events if possible.
Ideal would be to even allow individual events to have there own pins
as long as there are only two available.  So we need a heuristic to
work out what interrupts to put where.  It doesn't work well as a lookup
table (I tried it)

#define ADXL345_OVERRUN = BIT(0)
#define ADXL345_WATERMARK = BIT(1)
#define ADXL345_FREEFALL = BIT(2)
#define ADXL345_INACTIVITY = BIT(3)
#define ADXL345_ACTIVITY = BIT(4)
#define ADXL345_DOUBLE_TAP = BIT(5)
#define ADXL345_SINGLE_TAP = BIT(6)
#define ADXL345_DATA_READY = BIT(7)

So some function that takes the bitmap of what is enabled and
tries to divide it sensibly.

int adxl345_int_heuristic(u8 input, u8 *output)
{
	long bounce;
	switch (hweight8(&input))
	{
	case 0 ... 1:
		*output = input;
		break;
	case 2:
		*output = BIT(ffs(&input)); //this will put one on each interrupt.
		break;
	case 3 ... 7: //now it gets tricky. Perhaps always have dataready and watermark on own interrupt if set?
		
		if (input & (ADXL345_DATA_READY | ADXL345_WATERMARK)) 
			output = input & (ADXL345_DATA_READY | ADXL345_WATERMARK);
		else // taps always on same one etc...
	}
}

Then your interrupt handler will need to look at the incoming and work out if it
needs to read the status register to know what it has. If it doesn't
need to then it doesn't do so.  Be careful to only clear the right
interrupts though in that case as it is always possible both are set.

Anyhow, right now all that needs to be there is the binding to allow two interrupts.
Absolutely fine if for now the driver only uses the first one.

Jonathan
> 
>>> +      */
>>> +     of_irq = of_irq_get_byname(dev->of_node, "INT2");
>>> +     if (of_irq == irq)
>>> +             regval = 0xFF;
>>> +     else
>>> +             regval = 0x00;
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

