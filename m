Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41339 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751448AbbKNSgP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 14 Nov 2015 13:36:15 -0500
Subject: Re: [PATCH] iio: st_sensors: request any context IRQ
To: Linus Walleij <linus.walleij@linaro.org>, linux-iio@vger.kernel.org
References: <1447333964-10276-1-git-send-email-linus.walleij@linaro.org>
Cc: Denis Ciocca <denis.ciocca@st.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56477F1B.4000508@kernel.org>
Date: Sat, 14 Nov 2015 18:36:11 +0000
MIME-Version: 1.0
In-Reply-To: <1447333964-10276-1-git-send-email-linus.walleij@linaro.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/11/15 13:12, Linus Walleij wrote:
> It really doesn't matter if the poll is triggered from a
> fastpath or threaded IRQ, the IIO core runs its own interrupt
> thread anyway. Sometimes this is connected to a hard IRQ line,
> sometimes to something on an I2C expander that needs to
> run from a thread, so request any context IRQ.
> 
> Cc: Denis Ciocca <denis.ciocca@st.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Hi Linus,

Note first that there is nothing stopping any random device
hanging off the trigger - so we can't make any device specific
assumptions.

>From the start the way it was built up pretty much assumed
we had a real hardware interrupt to drive this.  Interesting
question is does it matter - we jump through hoops to drop
back into interrupt context at times. Perhaps we don't need to
- I can't honestly remember why we did this and it was pre
threaded interrupts so perhaps the assumptions are no longer
valid.

My knowledge of the irq handling is perhaps not
deep enough but I can follow through code ;)  So here goes.

The result of this as you've identified is that we may call the 
function iio_trigger_generic_data_ready_poll from either a thread
context or a interrupt context.

This then calls generic_handle_irq for each of devices hanging
off the trigger and ultimately desc->handle_irq and on
to handle_simple_irq (fun this isn't it ;) This calls onto
handle_irq_event and after a few more jumps ends up at
handle_irq_event_percpu in kernel/irq/handle.c

This calls the top half interrupt just fine an then if it
gets an IRQ_WAKE_THREAD (most of the time)
we call __irq_wake_thread.  So the only remaining question
is there anything that actually requires the thread to be woken
from interrupt context...

Ah, this is where it come unstuck...
__irq_wake_thread explicitly makes the point that it it is running
only on one cpu at a time and in interrupt context.

Now, we could restrict the st_sensors trigger to use by
the device supplying it - we could then operate the
entire trigger always in a state where sleeping is safe
(and run it as a chained irq - entirely in a thread).

We could perhaps do some 'magic' to allow this on the irq
side.  As the interrupt is never threaded anyway (though the
stuff hanging off it almost always is) we could do something
nefarious such as:

Call request_any_context_irq.  If this returns IRQC_IS_HARDIRQ
continue as normal.  If it returns IRQ_C_IS_NESTED we could
note this fact and handle any child interrupts hanging off the
device differently. In the first instance we could refuse
to let any pollfuncs with a top half interrupt bind to the trigger.
The trigger would then call iio_trigger_poll_chained to
call the nested interrupts (fine I think?)

Am I missing something here?  This turned out to be a rather
deeper rabbit hole than I thought it would be when I started!

Jonathan

> ---
>  drivers/iio/common/st_sensors/st_sensors_trigger.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/common/st_sensors/st_sensors_trigger.c b/drivers/iio/common/st_sensors/st_sensors_trigger.c
> index 3c0aa17d753f..e33796cdd607 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_trigger.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_trigger.c
> @@ -32,9 +32,8 @@ int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
>  		goto iio_trigger_alloc_error;
>  	}
>  
> -	err = request_threaded_irq(sdata->get_irq_data_ready(indio_dev),
> +	err = request_any_context_irq(sdata->get_irq_data_ready(indio_dev),
>  			iio_trigger_generic_data_rdy_poll,
> -			NULL,
>  			IRQF_TRIGGER_RISING,
>  			sdata->trig->name,
>  			sdata->trig);
> 

