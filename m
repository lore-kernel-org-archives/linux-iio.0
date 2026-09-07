Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1179D373BE7;
	Mon,  7 Sep 2026 01:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788746313; cv=none; b=kfXJAYQl/utyUjQQPpYIIgOM2Zt3Qjj0/0BKq588f35iW9BzKD5div4ntvfAaWv6HHqyntb4VyDm2Ljk3eFOEz5er+2YL9x23RIQp+3f9YkHI81rI83BQeslgwIEehXo7pgk5zRC8e88mTNTseeMih0Ubn7gNHccK2A/kz/WSls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788746313; c=relaxed/simple;
	bh=svZIa92Xa164Ah5E0OhIiEq1XffEvgwBWYqroP3RyWg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K3w3PD8ar+F8vE9GoMDDC+e15hYhJbTAJlYHPgZ8OOXhs5XBjIeSmEH7p6wBwzYZIsTPvnTItn2zVQLN+SNH/1RIlCmOjxjwmgfUqut2JvCC7LW3RvNHLRAR1RY9luUnKco5O7GTDicia8HU0eTxzV0iI6cQzFYPe0ElpLpx8yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UnWG0re5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UnWG0re5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C4E01F00A3A;
	Mon,  7 Sep 2026 01:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788746311;
	bh=FzsMa+B/bp3JLO02AUKhUEhGYtMKY3pM6nOJ+jDP+nw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=UnWG0re504ypvyyaeh1GupyI8P/ZmkWiMnRI0rl9ljHN7R5k4yv2oT4EZYzDDwIrN
	 mlZTKaJUOE1cDV2ERqpnSmH9oxq9QqpOt0r3pHp6GnWp83lfS0pRPOh20+58qG0+hm
	 PDGJvtopsCc91DdCxWDZeU6vsLQM5gkaPXzrmllE3fI24loDwgVmnCxeYDY54VDLaf
	 2F+SocX6RTty6XUthi4YkF3VApqGWrEV8KBlaUM7ryDpOiVNEjo3w7SLi2kYaxOPk/
	 1N5jghpcuiA80ud4Q6oj8gZ1MoYzQT5CTJMumZ/BRgoz4mnWMCKc9fnMLFnB/d0b3s
	 8gU5Y30tbiqDw==
Date: Mon, 7 Sep 2026 02:58:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Javier Carrasco" <javier.carrasco.cruz@gmail.com>
Cc: <sashiko-reviews@lists.linux.dev>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v8 4/4] iio: light: veml6031x00: add support for events
 and trigger
Message-ID: <20260907025826.414c570a@jic23-huawei>
In-Reply-To: <DL4X3IXEI8WK.OOFNRSU7FGRW@gmail.com>
References: <20260901-veml6031x00-v8-0-532cb4f2168a@gmail.com>
	<20260901-veml6031x00-v8-4-532cb4f2168a@gmail.com>
	<20260901132208.EE64C1F000E9@smtp.kernel.org>
	<DL49BADYC1U8.2N2F6YW5ZR5S2@gmail.com>
	<DL4X3IXEI8WK.OOFNRSU7FGRW@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 02 Sep 2026 16:58:09 +0200
"Javier Carrasco" <javier.carrasco.cruz@gmail.com> wrote:

> On Tue Sep 1, 2026 at 10:19 PM CEST, Javier Carrasco wrote:
> > On Tue Sep 1, 2026 at 3:22 PM CEST, sashiko-bot wrote:  
> >> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> >> - [High] Use-After-Free of iio->pollfunc in IRQ handler during device unbind or probe failure.
> >> - [Medium] Unintended I2C read of configuration register when pushing timestamp to buffer
> >> - [Medium] The interrupt_users counter can permanently underflow during error recovery, breaking hardware interrupt control.
> >> --
> >>
> >> commit c87f3d48e1ee614fc184995b816c8f8679a6b774
> >> Author: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> >>
> >> iio: light: veml6031x00: add support for events and trigger
> >>
> >> The device provides a shared interrupt line to notify events and data ready.
> >> Add support for configurations with and without an interrupt line, providing
> >> events and trigger support when an interrupt line is available.
> >>  
> >>> diff --git a/drivers/iio/light/veml6031x00.c b/drivers/iio/light/veml6031x00.c
> >>> index 3d5a27a0baaed..7bd7975eb1a76 100644
> >>> --- a/drivers/iio/light/veml6031x00.c
> >>> +++ b/drivers/iio/light/veml6031x00.c  
> >> [ ... ]  
> >>> +static int __veml6031x00_set_trigger_state(struct veml6031x00_data *data, bool state)
> >>> +	__must_hold(&data->irq_lock)
> >>> +{  
> >> [ ... ]  
> >>> +	data->trig_en = state;
> >>> +
> >>> +	return 0;
> >>> +
> >>> +clear_interrupt:
> >>> +	veml6031x00_set_interrupt(data, !state);
> >>> +
> >>> +	return ret;
> >>> +}  
> >>
> >> [Severity: Medium]
> >> Can data->interrupt_users permanently underflow here during error recovery?
> >>
> >> If an I2C error occurs in __veml6031x00_set_trigger_state() while disabling
> >> the trigger, this error recovery path calls veml6031x00_set_interrupt() to
> >> revert the counter, but fails to update the software state (data->trig_en).
> >>
> >> If a subsequent successful disable happens later, the counter will be
> >> decremented again, potentially underflowing to UINT_MAX and silently skipping
> >> all future hardware writes.
> >>
> >> [ ... ]  
> >
> > That is not true because the error path will *increment* the counter to
> > re-enable the IRQ and keept it consistent with data->trig_en. If an I2C
> > operation fails, the trigger will stay enabled in the device registers,
> > and therefore data-trig_en should stay enabled.
> >
> > I tested it by adding some hacks to force that situation, and what may
> > actually happen is that if *on top* of that failure, the I2C operation
> > in veml6031x00_set_interrupt() also fails, interrupt_users will be
> > decremented (as it should, because the interrupt could not be
> > re-enabled), and *then* a second call to disable the trigger will set
> > interrupt_users to UINT_MAX.
> >
> > Although this is very unlikely, the fix seems to be trivial:
> >
> >  if (state) {
> >  	data->interrupt_users++;
> >  	if (data->interrupt_users > 1)
> >  		return 0;
> >  } else {
> >  	+	if (!data->interrupt_users)
> >  	+		return 0;
> >
> >  	data->interrupt_users--;
> >  	if (data->interrupt_users > 0)
> >  		return 0;
> >  }
> >
> > Note that this fix is not a hack to just get rid of reaching UINT_MAX, it
> > reflects the fact that the previous failed operations lead to a disabled
> > interrupt and an enabled trigger in the hardware, and there is no need
> > to act on the interrupt again when trying to disable the trigger a
> > second time.
> >
> > I will add it for V9 after testing it with some hacks to force that
> > scenario.
> >  
> 
> I am trying to reproduce that scenario with forced errors, and even if
> those two errors happen during the first attempt to disable the trigger,
> it's not really possible to reach interrupt_users = UINT_MAX.
> The 'buffer/enable' attribute is set to 0 by the core even if
> set_trigger_state() returns an error code, and the next time
> 'buffer/enable' is set to 0, nothing really happens because
> set_trigger_state() is not even called.

I can't remember why we do that. Oh well. Seems it is useful here.

> 
> I could still add the check I suggested in V9 and avoid future issues,
> but I don't see how to reproduce this in the current state of the core
> and driver, even forcing those failed I2C operations.

I agree this is worth doing even if we can't trigger it today.

Jonathan

> 
> Best regards,
> Javier

