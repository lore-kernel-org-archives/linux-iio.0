Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:33822 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751478AbcEDHfx (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 4 May 2016 03:35:53 -0400
Subject: Re: [PATCH 3/4] iio: st_sensors: verify interrupt event to status
To: Linus Walleij <linus.walleij@linaro.org>,
	Crestez Dan Leonard <cdleonard@gmail.com>
References: <1458825486-17188-1-git-send-email-linus.walleij@linaro.org>
 <1458825486-17188-3-git-send-email-linus.walleij@linaro.org>
 <5728E6C2.1050901@gmail.com>
 <CACRpkdaLc8frud64VZEuQ=dXGpgk+kBj94otoCCC=-Pvoe09tw@mail.gmail.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Giuseppe Barba <giuseppe.barba@st.com>,
	Denis Ciocca <denis.ciocca@st.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <4e983a0c-88f9-b5bf-3439-15f006736a7d@kernel.org>
Date: Wed, 4 May 2016 08:35:48 +0100
MIME-Version: 1.0
In-Reply-To: <CACRpkdaLc8frud64VZEuQ=dXGpgk+kBj94otoCCC=-Pvoe09tw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/05/16 21:10, Linus Walleij wrote:
> On Tue, May 3, 2016 at 7:58 PM, Crestez Dan Leonard <cdleonard@gmail.com> wrote:
>> On 03/24/2016 03:18 PM, Linus Walleij wrote:
>>> This makes all ST sensor drivers check that they actually have
>>> new data available for the requested channel(s) before claiming
>>> an IRQ, by reading the status register (which is conveniently
>>> the same for all ST sensors) and check that the channel has new
>>> data before proceeding to read it and fill the buffer.
>>>
>>> This way sensors can share an interrupt line: it can be flaged
>>> as shared and then the sensor that did not fire will return
>>> NO_IRQ, and the sensor that fired will handle the IRQ and
>>> return IRQ_HANDLED.
>>>
> (...)
>>> +     /* If we have a status register, check if this IRQ came from us */
>>> +     if (sdata->sensor_settings->drdy_irq.addr_stat_drdy) {
>>> +             u8 status;
>>> +
>>> +             len = sdata->tf->read_byte(&sdata->tb, sdata->dev,
>>> +                        sdata->sensor_settings->drdy_irq.addr_stat_drdy,
>>> +                        &status);
>>> +             if (len < 0)
>>> +                     dev_err(sdata->dev, "could not read channel status\n");
>>> +
>>> +             /*
>>> +              * If this was not caused by any channels on this sensor,
>>> +              * return IRQ_NONE
>>> +              */
>>> +             if (!(status & (u8)indio_dev->active_scan_mask[0]))
>>> +                     return IRQ_NONE;
>>> +     }
>>>
>> This seems to break software trigger mode when the timer frequency is
>> higher that the device polling frequency. In that case it is possible to
>> poll multiple times between updates and the first time this happens
>> further updates hang.
> 
> OK I understand This is a hard IRQ handler for DRDY.
> 
> We need to avoid checking the status register with software triggers.
> I guess it's possible to see in struct iio_dev whether we get called
> from a software trigger?
> 
> Can you give me instructions on how to reproduce the error so I
> can verify that I fix it? I never managed to get software triggers
> to work :(
> 
>> Even with hardware triggers: are you sure this is correct? Shouldn't
>> iio_trigger_notify_done still get called even when there is nothing to do?
> 
> No then the (hardware) IRQ can have come in from some other
> device sharing the line with the peripheral and we need to return
> IRQ_NONE. It's not our interrupt.
Gah, I fouled up reviewing this.  We really need to know if it is our
trigger 'before' we fire off the trigger logic - any number of other
devices can in theory be hanging off a given trigger - none of them will
be able to know if it was a real trigger or not.

So the check should have been in the top level irq handler.  Right
now that is iio_trigger_generic_data_rdy_poll set in st_sensors_trigger.c
but clearly needs to be more specific.

Also, we are clearly going to have to switch to a threaded handler
which will limit what we can hang off this trigger. Maybe for now
we just validate that only st_sensors can be driven by this trigger..
I doubt anyone will notice the additional restriction... If they
do we can probably work around it.

What we need to do is work out how to elegantly fall back to 
not running top halves of triggers if we are coming from threaded
context.

Can think of one 'dubious' way of doing this that might work.
Add a flag to struct iio_poll_func which is 'I've already run'.
Set it in the top half handler (we don't actually have that many
of those) then we can query it in the bottom half if necessary and
then optionally fun the top half in threaded context (where it is
just grabbing a timestamp for example and is safe).

I'm on a long train journey today - depending on whether my battery
holds, I may have a look at this later and see how bad it would be
in terms of churn.

It might finally let us relax some of the restrictions on which
trigger can be used for which device and in a minimally invasive
way.

Jonathan

p.s. We'll need to get this fixed up in some more temporary fashion
for the current cycle though.


> 
> Yours,
> Linus Walleij
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

