Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B15146D5A;
	Thu, 10 Sep 2026 02:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789009020; cv=none; b=Z9UBlBNlVXnlnZ7eUgGLpMDg4AzTf+sJggertfAd8iDdKgVzLINtxG09zp9MatIJGU/hgy4Ywyu/JMfOpWMWvIqYNhVOLGfgd0M/PXV+eYRTRNxQyyTjysiX7T9nk/jiKFh7Kx45i4IFxxP2LIS0SV9a2CNHMo4zbW2CxHsBJ+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789009020; c=relaxed/simple;
	bh=vcvKEalG+2tQtjM6udCNDsnuUt2KvEjEd+uzMQX50UQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uYpMjwd9dCs3HsEfsKyB1tTE3omMklpZBBjmkqyNdFO8ejusV7ZybVP0RMlfdMBy739Bt+N491AaMSnw99juIpcEJ0P3AizqBVyDSIrN/rTT2Yg9wquN40yRgQbTTZCsLyMr+8Qx1C+VHXTXMYCvGz961Y3KIOMZfWXQsOmDimo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZwX/VL1+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZwX/VL1+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 139491F000FF;
	Thu, 10 Sep 2026 02:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789009019;
	bh=QmV7q2RmaJxfTJ+mV+lc341aMBTJpVDcoTAnIAr47ak=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ZwX/VL1+ike6G2QlaCWQ1bp/IFj0U0/wQ2295CxgEfRnmuQjZwFNAPIbAXvK3Mjpf
	 nre6KLdPTyMwlY334RawBzzZ4xhuprWjrHBI07Re3QH3FiIFbUlOVhZkJQBwmdbKZi
	 7cfXmHrwqKddQ+fJ/yq1teBXdlazExFuVSDvxD0fRdvhSGChEPihe1eMb1/j6q4I/z
	 kcZ+BI2ACEZqWk3kkq7UyWZSMKx5i9+JFLYYzcIFD7d0g2w+lkRwTRkkRKMv37ANES
	 kiKqFV5kSMg1Yn2I7OJOwSqxI9lISNgtdk48BJ3DzFxoF/TG2fj72Iu8QQNf8tAZeY
	 eCJzRFyLF1L3A==
Date: Thu, 10 Sep 2026 03:56:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Javier Carrasco" <javier.carrasco.cruz@gmail.com>
Cc: <sashiko-reviews@lists.linux.dev>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v8 4/4] iio: light: veml6031x00: add support for events
 and trigger
Message-ID: <20260910035653.6b133652@jic23-hlaptop>
In-Reply-To: <DL992E7Q18ZM.2PAM4UQKPJ1BQ@gmail.com>
References: <20260901-veml6031x00-v8-0-532cb4f2168a@gmail.com>
	<20260901-veml6031x00-v8-4-532cb4f2168a@gmail.com>
	<20260901132208.EE64C1F000E9@smtp.kernel.org>
	<DL49BADYC1U8.2N2F6YW5ZR5S2@gmail.com>
	<DL4X3IXEI8WK.OOFNRSU7FGRW@gmail.com>
	<20260907025826.414c570a@jic23-huawei>
	<DL992E7Q18ZM.2PAM4UQKPJ1BQ@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 07 Sep 2026 19:11:34 +0200
"Javier Carrasco" <javier.carrasco.cruz@gmail.com> wrote:

> On Mon Sep 7, 2026 at 3:58 AM CEST, Jonathan Cameron wrote:
> > On Wed, 02 Sep 2026 16:58:09 +0200
> > "Javier Carrasco" <javier.carrasco.cruz@gmail.com> wrote:
> >  
> >> On Tue Sep 1, 2026 at 10:19 PM CEST, Javier Carrasco wrote:  
> >> > On Tue Sep 1, 2026 at 3:22 PM CEST, sashiko-bot wrote:  
> >> >> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> >> >> - [High] Use-After-Free of iio->pollfunc in IRQ handler during device unbind or probe failure.
> >> >> - [Medium] Unintended I2C read of configuration register when pushing timestamp to buffer
> >> >> - [Medium] The interrupt_users counter can permanently underflow during error recovery, breaking hardware interrupt control.
> >> >> --
> >> >>
> >> >> commit c87f3d48e1ee614fc184995b816c8f8679a6b774
> >> >> Author: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> >> >>
> >> >> iio: light: veml6031x00: add support for events and trigger
> >> >>
> >> >> The device provides a shared interrupt line to notify events and data ready.
> >> >> Add support for configurations with and without an interrupt line, providing
> >> >> events and trigger support when an interrupt line is available.
> >> >>  
> >> >>> diff --git a/drivers/iio/light/veml6031x00.c b/drivers/iio/light/veml6031x00.c
> >> >>> index 3d5a27a0baaed..7bd7975eb1a76 100644
> >> >>> --- a/drivers/iio/light/veml6031x00.c
> >> >>> +++ b/drivers/iio/light/veml6031x00.c  
> >> >> [ ... ]  
> >> >>> +static int __veml6031x00_set_trigger_state(struct veml6031x00_data *data, bool state)
> >> >>> +	__must_hold(&data->irq_lock)
> >> >>> +{  
> >> >> [ ... ]  
> >> >>> +	data->trig_en = state;
> >> >>> +
> >> >>> +	return 0;
> >> >>> +
> >> >>> +clear_interrupt:
> >> >>> +	veml6031x00_set_interrupt(data, !state);
> >> >>> +
> >> >>> +	return ret;
> >> >>> +}  
> >> >>
> >> >> [Severity: Medium]
> >> >> Can data->interrupt_users permanently underflow here during error recovery?
> >> >>
> >> >> If an I2C error occurs in __veml6031x00_set_trigger_state() while disabling
> >> >> the trigger, this error recovery path calls veml6031x00_set_interrupt() to
> >> >> revert the counter, but fails to update the software state (data->trig_en).
> >> >>
> >> >> If a subsequent successful disable happens later, the counter will be
> >> >> decremented again, potentially underflowing to UINT_MAX and silently skipping
> >> >> all future hardware writes.
> >> >>
> >> >> [ ... ]  
> >> >
> >> > That is not true because the error path will *increment* the counter to
> >> > re-enable the IRQ and keept it consistent with data->trig_en. If an I2C
> >> > operation fails, the trigger will stay enabled in the device registers,
> >> > and therefore data-trig_en should stay enabled.
> >> >
> >> > I tested it by adding some hacks to force that situation, and what may
> >> > actually happen is that if *on top* of that failure, the I2C operation
> >> > in veml6031x00_set_interrupt() also fails, interrupt_users will be
> >> > decremented (as it should, because the interrupt could not be
> >> > re-enabled), and *then* a second call to disable the trigger will set
> >> > interrupt_users to UINT_MAX.
> >> >
> >> > Although this is very unlikely, the fix seems to be trivial:
> >> >
> >> >  if (state) {
> >> >  	data->interrupt_users++;
> >> >  	if (data->interrupt_users > 1)
> >> >  		return 0;
> >> >  } else {
> >> >  	+	if (!data->interrupt_users)
> >> >  	+		return 0;
> >> >
> >> >  	data->interrupt_users--;
> >> >  	if (data->interrupt_users > 0)
> >> >  		return 0;
> >> >  }
> >> >
> >> > Note that this fix is not a hack to just get rid of reaching UINT_MAX, it
> >> > reflects the fact that the previous failed operations lead to a disabled
> >> > interrupt and an enabled trigger in the hardware, and there is no need
> >> > to act on the interrupt again when trying to disable the trigger a
> >> > second time.
> >> >
> >> > I will add it for V9 after testing it with some hacks to force that
> >> > scenario.
> >> >  
> >>
> >> I am trying to reproduce that scenario with forced errors, and even if
> >> those two errors happen during the first attempt to disable the trigger,
> >> it's not really possible to reach interrupt_users = UINT_MAX.
> >> The 'buffer/enable' attribute is set to 0 by the core even if
> >> set_trigger_state() returns an error code, and the next time
> >> 'buffer/enable' is set to 0, nothing really happens because
> >> set_trigger_state() is not even called.  
> >
> > I can't remember why we do that. Oh well. Seems it is useful here.
> >  
> 
> I instrumented some more code, including iio_trigger_attach/detach_poll_func()
> and current_trigger_store(). When set_trigger_state(false) fails
> (which I forced), iio_trigger_detach_poll_func() returns without releasing
> the pollfunc IRQ from the trigger pool, but iio_disable_buffers()
> continues disabling the buffer.
> 
> The next buffer enable adds another consumer to the pool without calling
> set_trigger_state(true), since the trigger is already in use. The following
> buffer disable removes that new consumer without calling set_trigger_state(false),
> since there is still one consumer left in the pool.

So do you get two hits on each trigger? Definitely bad as they can be in threads
running at the same time and we assume that doesn't happen in most drivers.

> 
> So after the first failed disable, subsequent buffer enable/disable cycles do
> not call set_trigger_state() and the original consumer remains in the pool.
> That leaves the buffer/enable attribute in a meaningless state: it gets
> updated from the userspace perspective, but nothing really happens behind
> the scenes.
> 
> Is that intended? Maybe there are historical reasons for it, or maybe there
> was no cleaner way to operate after an error in set_trigger_state(), or
> maybe this should not work like that.

I'd go with "probably not the intended result" as if it were I 'think'
I'd have left a comment.

That's not to say I have an immediate answer to how to resolve it.
If you still have your test set up, can you try just carrying on and
not returning after the set_trigger_state(trig, false) fails - making
sure that your injected failure leaves the trigger actually enabled
and still firing.  That might leave us in a recoverable state as
next set_triggers_state(trig, true) should work as normal. In meantime
we will have a bunch of irqs firing but resulting in nothing happening.

Not great and may well leave some drivers stuck because they are
tightly couple trigger / data readback and need that to happen to
not get wedged.  Those should have the validate callbacks set but
will still be stuck.  In theory we could make all triggers that
have this property do a clear in the reenable but that is a bit
nasty as we would probably want it conditional so each driver would
need a 'have I already cleared this' flag set in their buffer
read and cleared in the reenable.

Thanks for digging into this btw!

Jonathan




> 
> This is what it looks like after I instrumented the code:
> 
> # All good, the trigger was disabled, and now it gets enabled:
> echo 1 > buffer/enable
> [   50.590395] IIO trigger veml6031x00-drdy0: attach: before: pool users=0
> [   50.596562] IIO trigger veml6031x00-drdy0: attach: pf->irq=188
> [   50.602537] IIO trigger veml6031x00-drdy0: attach: after get_irq: pool users=1
> [   50.622654] IIO trigger veml6031x00-drdy0: attach: set_trigger_state(1) returned 0
> 
> # Forced failure in veml6031x00_set_trigger_state(false):
> echo 0 > buffer/enable
> [   64.608971] IIO trigger veml6031x00-drdy0: detach: before: pool users=1
> [   64.615267] IIO trigger veml6031x00-drdy0: detach: pf->irq=188
> [   64.657138] IIO trigger veml6031x00-drdy0: detach: set_trigger_state(0) returned -13
> [   64.664968] IIO trigger veml6031x00-drdy0: detach: callback failed: pool users=1
> 
> # From now on, set_trigger_state() will not be called:
> echo 1 > buffer/enable
> [  104.047282] IIO trigger veml6031x00-drdy0: attach: before: pool users=1
> [  104.053494] IIO trigger veml6031x00-drdy0: attach: pf->irq=189
> [  104.059502] IIO trigger veml6031x00-drdy0: attach: after get_irq: pool users=2
> [  104.067023] IIO trigger veml6031x00-drdy0: attach: NOT calling set_trigger_state(1), notinuse=0
> 
> echo 0 > buffer/enable
> [  117.354867] IIO trigger veml6031x00-drdy0: detach: before: pool users=2
> [  117.361070] IIO trigger veml6031x00-drdy0: detach: pf->irq=189
> [  117.366975] IIO trigger veml6031x00-drdy0: detach: NOT calling set_trigger_state(0), no_other_users=0
> [  117.376297] IIO trigger veml6031x00-drdy0: detach: after put_irq: pool users=1
> 
> Best regards,
> Javier

