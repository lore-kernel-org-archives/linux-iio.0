Return-Path: <bigeasy@linutronix.de>
Message-ID: <521EFD22.8010005@linutronix.de>
Date: Thu, 29 Aug 2013 09:49:54 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
MIME-Version: 1.0
To: Zubair Lutfullah : <zubair.lutfullah@gmail.com>
CC: jic23@cam.ac.uk, lee.jones@linaro.org, linux-iio@vger.kernel.org,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 gregkh@linuxfoundation.org
Subject: Re: [PATCH 2/2] iio: ti_am335x_adc: Add continuous sampling support
References: <1377470724-15710-1-git-send-email-zubair.lutfullah@gmail.com> <1377470724-15710-3-git-send-email-zubair.lutfullah@gmail.com> <20130828130124.GC14111@linutronix.de> <20130828184320.GB3777@gmail.com>
In-Reply-To: <20130828184320.GB3777@gmail.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On 08/28/2013 08:43 PM, Zubair Lutfullah : wrote:
> On Wed, Aug 28, 2013 at 03:01:24PM +0200, Sebastian Andrzej Siewior wrote:
>> * Zubair Lutfullah | 2013-08-25 23:45:24 [+0100]:
>>
>> I am mostly happy with it. There are just two things I pointed out.
>> Besides that, it looks good from my side.
> Sign-off?

Acked-by if anything. For that you should fix the things I pointed out.

>>> +static irqreturn_t tiadc_irq(int irq, void *private)
>>> +{
> ...
>>> +	/* If any IRQ flags left, return none. So TSC can handle its IRQs */
>>> +	status = tiadc_readl(adc_dev, REG_IRQSTATUS);
>>> +	if (status == false)
>>> +		return IRQ_HANDLED;
>>> +	else
>>> +		return IRQ_NONE;
>>
>> As I said in 1/2 of this series, you shouldn't do this. Both handlers of a
>> shared line are invoked once an interrupt is detected.
>>
>> …
> I somehow missed sending these patches to Dmitry.. 
> I'll do it next series.
> 
> He originally suggested this way.
> An alternative was to handle irqs in mfd core which would 
> seriously complicate code and patches..
> 
> Whenever I change the handlers to the way you suggest.
> i.e. Handle what each irq handler does and return IRQ_HANDLED
> if the irq handler handled nothing then return IRQ_NONE.
> 
> The driver hangs when I'm brutal while touching the TSC and 
> continuously sampling the ADC. Not always. But happens.
> 
> When I check /proc/interrupts the hardware irqs seem to be firing.
> But for some reason the whole thing messes up..

In that case it is likely that the irqs are not acked properly and
therefore fired again. So you should check that.

If you look at handle_irq_event_percpu() in kernel/irq/handle.c. That
is the function that invokes your handler. It looks the following in
short:

	do {
		res = action->handler(irq, action->dev_id);
		retval |= res;
		action = action->next;
	} while (action);
	note_interrupt(irq, desc, retval);

As you see all registered handlers are invoked no matter of the return
code. The common return code is pass over to note_interrupt() which will
disable the irq line if IRQ_NONE is returned too many times.

It is possible that the read of REG_IRQSTATUS will ACK those and
therefore it does not fire anymore. I don't have the manual next to me
right now, so please check how the interrupt is acked by reading the
status register or by writing a bit to the status register etc.
_If_ the status bit is auto-cleared on read but the interrupt is not
acked and remains acktive then you won't see it in the "other" handler,
do nothing but the source will remain active.
This might match your description. In that case I suggest to register
that interrupt in the MFD part let TSC & ADC register via the mfd part.
The MFD part would read the status register and pass it to the two
handlers so it not lost.

In any case: please check what is really going on. This workaround you
have now does not look good.

> Thanks
> ZubairLK


Sebastian
