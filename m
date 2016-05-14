Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35414 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753838AbcENQQ1 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 14 May 2016 12:16:27 -0400
Subject: Re: [PATCH 3/3] iio: st_sensors: Use level interrupts
To: Crestez Dan Leonard <leonard.crestez@intel.com>,
	linux-iio@vger.kernel.org
References: <3d90f889782a9c8380c3694e55a135ddd6de9bc4.1463164919.git.leonard.crestez@intel.com>
 <6c5cc47895ca35fce84b6b01a3ecf7df928aa197.1463164919.git.leonard.crestez@intel.com>
Cc: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Giuseppe Barba <giuseppe.barba@st.com>,
	Denis Ciocca <denis.ciocca@st.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <36c3afe3-e70d-b933-0d7e-7712205c0b6b@kernel.org>
Date: Sat, 14 May 2016 17:16:21 +0100
MIME-Version: 1.0
In-Reply-To: <6c5cc47895ca35fce84b6b01a3ecf7df928aa197.1463164919.git.leonard.crestez@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 13/05/16 19:43, Crestez Dan Leonard wrote:
> As far as I can tell DRDY for ST sensors behaves as a level rather than
> edge interrupt. Registering for IRQF_TRIGGER_RISING instead of
> IRQF_TRIGGER_HIGH mostly works except when the sampling frequency is
> high enough that new samples come before the new ones are read
> completely. In that case the interrupt line remains high, no more rising
> edges occur and the iio buffer stalls.
> 
> Configuring the interrupt as IRQF_TRIGGER_HIGH makes it work as
> expected. This patch makes it so that st_sensors_trigger interrupt
> request code doesn't mangle the request flags into IRQF_TRIGGER_RISING.
> 
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Giuseppe Barba <giuseppe.barba@st.com>
> Cc: Denis Ciocca <denis.ciocca@st.com>
> Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
> ---
> This is an alternative fix to this patch:
> 	https://www.spinics.net/lists/linux-iio/msg24722.html
> [PATCH 2/2 v6] iio: st_sensors: read surplus samples in trigger.
> 
> It's not clear if all st_sensors behave this way on DRDY. If they do it might
> be better to always request HIGH even if the interrupt is initially configured
> for RISING.
> 
> I tested on MinnowBoard Max which uses pinctrl-baytrail for gpio irqs. I
> initially tested hacking the irq_trig to IRQF_TRIGGER_HIGH with an usb adaptor
> (gpio-dln2) and it didn't work but I think that's because that driver doesn't
> handle persistently high irqs properly.
Hi Leonard / Linus,

I thought my memory was failing me a little when I read Linus' patch description
where he mentioned that we were missing pulsed interrupts. 

Years ago (probably at least 8) I ran into this exact issue with the lis3l02dq and
spent sometime with a scope tracking down the cause (this was way before threaded
interrupt etc were in mainline).  Anyhow, my recollection was that we didn't always
get a gap between the pulses. Hence it was possible to cross reading the registers
with new data coming in for other channels and never see it drop.

Distinctly remember scratching my head over how to deal with this for some time.
The snag I had was that I was working with an intel stargate 2 with a pxa27x which
didn't have any level interrupt support.  Hence I ended up with a cludge that
checked the gpio itself (was easier back then as you could get the gpio from
the IRQ :) and did a bonus read with no processing to hammer it down and get out
of being stuck.

Linus' checking the data ready register and firing another trigger was the
equivalent of this (back then we didn't have the two polling methods).
You can still see my hack in staging/iio/accel/lis3l02dq_ring.c in try_reenable.
Note the tryreenable was an attempt to bring sanity checking whether we need
a repeat poll into one place and push the repeat polling into the core - which
only works if all drivers hanging off the trigger can work fine with threaded
interrupts only.

Right now I think the try_reenable stuff has been broken for a long time...
It will call iio_trigger_poll
from a thread (typically).  Obviously missed this one when we converted over to
threaded interrupts (hmm)  Need to audit if that can ever be called from interrupt
context (to avoid making things worse!)
If that was fixed then we could use it for Linus's reread but it suffers the same
issue with no limit on the number of times it can go around (so that would want
fixing as well!)

This patch doesn't make things worse as I read it - except in the case where
no interrupt type is specified...  In that case it will try to make it high
which may not be supported.  Note that (if I'd merged the lis3l02dq driver in
as I've been meaning too for a long time) this would just have broken my boards..
(can we check if the interrupt supports it and fall back to the original default
if not? - it's even more comic on my board as IIRC the interrupt is shared via
a discrete NAND gate with a tsl2561 so everything is flipped as well)

The other question is how many users have one of these hooked up to an irq that
doesn't support level interrupts (such as my pxa27x - which I fire up every few
months - or your gpio-dln2 adapter).

If so I guess we aren't making things any worse for them but the issue you had
still exists + I still can't port my lis3l02dq driver over...  I wonder if we
ultimately end up having to support both fixes (though the one I did originally
and Linus effectively reinvented is hideous :)  If level interrupts are specified
then yours is great and simple, if we edge interrupts are specified we have
to play games to fake a level interrupt. Note that way back when I asked if anyone
had any generic code for doing exactly this and got the answer 'It's too fiddly'
IIRC - and I don't think anyone has ever taken it on since...

I'm also inclined on this fix in general to send it the slow route (next merge
window) rather than rushing it through.  It's invasive and it's not as though
we are looking at a regression here.

The other fix is a totally different matter and I'll pick that up shortly.

So in conclusion, in the first instance I'm keener on your solution which I think
is the technically correct one.  However, I fear we have enough crazy hardware
types who have this wired up to an in appropriate interrupt controller, that we
need not to make things worse than they are.  We also have the potential to make
them better perhaps by including the guts of Linus' suggestion as well (when not
in level interrupt mode).

Jonathan


> 
>  drivers/iio/common/st_sensors/st_sensors_trigger.c | 26 ++++++++++++----------
>  1 file changed, 14 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iio/common/st_sensors/st_sensors_trigger.c b/drivers/iio/common/st_sensors/st_sensors_trigger.c
> index 7c2e6ab..ffd6edb 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_trigger.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_trigger.c
> @@ -99,13 +99,16 @@ int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
>  	 * If the IRQ is triggered on falling edge, we need to mark the
>  	 * interrupt as active low, if the hardware supports this.
>  	 */
> -	if (irq_trig == IRQF_TRIGGER_FALLING) {
> +	if (irq_trig == IRQF_TRIGGER_FALLING || irq_trig == IRQF_TRIGGER_LOW) {
>  		if (!sdata->sensor_settings->drdy_irq.addr_ihl) {
>  			dev_err(&indio_dev->dev,
> -				"falling edge specified for IRQ but hardware "
> -				"only support rising edge, will request "
> -				"rising edge\n");
> -			irq_trig = IRQF_TRIGGER_RISING;
> +				"active low specified for IRQ but hardware "
> +				"only support active high, will request "
> +				"active high\n");
> +			if (irq_trig == IRQF_TRIGGER_FALLING)
> +				irq_trig = IRQF_TRIGGER_RISING;
> +			else if (irq_trig == IRQF_TRIGGER_LOW)
> +				irq_trig = IRQF_TRIGGER_HIGH;
>  		} else {
>  			/* Set up INT active low i.e. falling edge */
>  			err = st_sensors_write_data_with_mask(indio_dev,
> @@ -114,18 +117,17 @@ int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
>  			if (err < 0)
>  				goto iio_trigger_free;
>  			dev_info(&indio_dev->dev,
> -				 "interrupts on the falling edge\n");
> +				 "interrupts are active low\n");
>  		}
> -	} else if (irq_trig == IRQF_TRIGGER_RISING) {
> +	} else if (irq_trig == IRQF_TRIGGER_RISING || irq_trig == IRQF_TRIGGER_HIGH) {
>  		dev_info(&indio_dev->dev,
> -			 "interrupts on the rising edge\n");
> +			 "interrupts are active high\n");
>  
>  	} else {
>  		dev_err(&indio_dev->dev,
> -		"unsupported IRQ trigger specified (%lx), only "
> -			"rising and falling edges supported, enforce "
> -			"rising edge\n", irq_trig);
> -		irq_trig = IRQF_TRIGGER_RISING;
> +			"unsupported IRQ trigger specified (%lx) "
> +			"enforce level high\n", irq_trig);
> +		irq_trig = IRQF_TRIGGER_HIGH;
>  	}
>  
>  	/*
> 

