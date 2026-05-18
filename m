Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5F1273D76;
	Mon, 18 May 2026 14:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779115827; cv=none; b=YPBOndYqbYfVUA0WXZdTCi0RbfL/I1fejQvY1n/Hp/FnmEVlcZuma+QgWUBfyt9b7YQkiCvdjLRK6Qe5swHG0kECKw5G/RC9NFdzvRnSaIAQTs4G4+wb9iITkTjTSKWb+LDInqjkQ8LD/QgaoF+hxVz7uFq5mJsg7dXSIeoO22s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779115827; c=relaxed/simple;
	bh=AkU1VBeWYq+FJsE+w+HJkSpj0XLUlerI1rFIRbuYp3w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AfIOY6eNKzse+VkQZAvx7X1cwmdG7N+wn55iFstfYFN2KGu+8OO89yms/DStz//vAq9qTcRb2s4kwt/RB8jVlZBjefqsDA9NGUE9kz6TCvmFyX2etzLDyhAnf/NEBVo6WXy4DnA1lv3NPTMyd8M8lbHWDQeJ/5m57AvowWqwW34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HPVoOX3H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HPVoOX3H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AB91C2BCB7;
	Mon, 18 May 2026 14:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779115827;
	bh=AkU1VBeWYq+FJsE+w+HJkSpj0XLUlerI1rFIRbuYp3w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HPVoOX3HO+QF7VWfePQ0uYOZzNrQ1uknWEG8u6G6yJlu7yimUQG2Lp3eviZOfaDqR
	 5tbn1KPnEC/pP+/V1NhKhSEdjv7/7rFv2i3pt48am7UxBmtEFLQgLb/DK0RlefGZBR
	 v0oxBg59dUj6kR0dp47XT52hoiPPgFhtUUucFsCpwx0wPaPe6pNBIiysaOeU5kZg8Y
	 fQ4Z04/0mgAigjHCCK6HyZXYxXQeJLlFZZmyIko1q1t/fwYRLBBzUK6g4M8liSUl4H
	 lwWTE3UQZ3jNBDgqQCOQKCMxfEbtgUp7Ucw2nLAci3CHPNYAV7JBfLR6rNbI2VVayR
	 2ViDRY/H/EmZA==
Date: Mon, 18 May 2026 15:50:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Stepan Ionichev
 <sozdayvek@gmail.com>, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] iio: pressure: rohm-bm1390: notify trigger on all error
 paths
Message-ID: <20260518155018.41192eee@jic23-huawei>
In-Reply-To: <3cb30f12-8b4f-415f-9a1d-823d8ff8c33b@gmail.com>
References: <20260517160801.269-1-sozdayvek@gmail.com>
	<54ee1fba-3209-4192-82c3-674a1ae3ca8f@baylibre.com>
	<3cb30f12-8b4f-415f-9a1d-823d8ff8c33b@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 May 2026 08:21:17 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 17/05/2026 20:12, David Lechner wrote:
> > On 5/17/26 11:08 AM, Stepan Ionichev wrote:  
> >> bm1390_trigger_handler() has three error returns:
> >>
> >> 	if (ret || !status)
> >> 		return IRQ_NONE;          /* status read failed */
> >> 	...
> >> 	if (ret) {
> >> 		dev_warn(...);
> >> 		return IRQ_NONE;          /* pressure read failed */
> >> 	}
> >> 	...
> >> 	if (ret) {
> >> 		dev_warn(...);
> >> 		return IRQ_HANDLED;       /* temp read failed */
> >> 	}
> >>
> >> None of them call iio_trigger_notify_done(). The success path at the
> >> end does, so on a single transient regmap or pressure-read error the
> >> trigger never sees its use_count decremented, and the
> >> !atomic_read(&trig->use_count) guard in iio_trigger_poll_chained()
> >> drops every subsequent dispatch for that trigger. The buffered-data
> >> flow stays wedged until the trigger is detached.  
> 
> I don't really know the intended logic of the use_count, so I'll leave 
> this to those who understand it better. I'll just add some thoughts this 
> invoked.
> 
> I think it is not really nice to require (or trust) drivers to call the 
> "iio_trigger_notify_done()" if the handler fails. Maybe it would be 
> better to do something like:
> 
> void iio_trigger_poll_nested(struct iio_trigger *trig)
> {
>          int i;
> 
>          if (!atomic_read(&trig->use_count)) {
>                  atomic_set(&trig->use_count, 
> CONFIG_IIO_CONSUMERS_PER_TRIGGER);
> 
>                  for (i = 0; i < CONFIG_IIO_CONSUMERS_PER_TRIGGER; i++) {
>                          if (trig->subirqs[i].enabled)
>                                  handle_nested_irq(trig->subirq_base + i);
>                          else
>                                  iio_trigger_notify_done(trig);
>                  }
> 		atomic_set(&trig->use_count, 0); /* Clear the use_count if drivers 
> didn't */

If this worked we could just drop the use_count :)

>          }
> }
> 
> to prevent this class of problems once and for all. But yeah, wiser 
> minds have designed this - so let's hear some other opinions as well :)

I've mused about similar myself. The problem is the iio_trigger_notify_done()
at least in theory doesn't have to be anywhere near the interrupt handler.

It normally is, but there is potential for some other delaying action to be
fired - e.g. using an hrtimer to fire off an action that then starts sampling
and waits for an interrupt to finish the sampling.  The iio_trigger_notify_done()
call belongs in that interrupt handler - which is no anywhere near here.

Can't find an example right now, but they existed when I wrote that complex
mess in the first place.

Like many things in IIO we may have designed it for a case that went away
in the meantime.  The silliest one of those is that (last time I checked) there
are no top half / thread combinations for pollfuncs where the top half
does anything beyond grabbing a timestamp.  So ultimately we could replace
the top half handler parameter with a bool to say if the timestamp is useful.

> 
> >>
> >> The IRQ_HANDLED return on the temperature path additionally leaves
> >> the temp branch's last partial state in &data->buf.temp without
> >> pushing the sample, which is the existing intended behaviour; only
> >> the missing notify_done() needs fixing.
> >>
> >> Funnel all returns through a single 'done' label that calls
> >> iio_trigger_notify_done() before returning the saved irqreturn_t.
> >>
> >> Fixes: 81ca5979b6ed ("iio: pressure: Support ROHM BU1390")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
> >> ---
> >>   drivers/iio/pressure/rohm-bm1390.c | 15 ++++++++++-----
> >>   1 file changed, 10 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/iio/pressure/rohm-bm1390.c b/drivers/iio/pressure/rohm-bm1390.c
> >> index 08146ca0f..c18352399 100644
> >> --- a/drivers/iio/pressure/rohm-bm1390.c
> >> +++ b/drivers/iio/pressure/rohm-bm1390.c
> >> @@ -626,12 +626,15 @@ static irqreturn_t bm1390_trigger_handler(int irq, void *p)
> >>   	struct iio_poll_func *pf = p;
> >>   	struct iio_dev *idev = pf->indio_dev;
> >>   	struct bm1390_data *data = iio_priv(idev);
> >> +	irqreturn_t result = IRQ_HANDLED;
> >>   	int ret, status;
> >>   
> >>   	/* DRDY is acked by reading status reg */
> >>   	ret = regmap_read(data->regmap, BM1390_REG_STATUS, &status);
> >> -	if (ret || !status)
> >> -		return IRQ_NONE;
> >> +	if (ret || !status) {
> >> +		result = IRQ_NONE;  
> > 
> > IRQ_NONE means that the interrupt wasn't handled, so it won't be cleared
> > and the handler will likely just run again immediately. So it probably
> > isn't the right thing to be returning in the first place.  
> 
> This is exactly why IRQ-none is returned, and what it is used for. If 
> the problem with bus-access / device persists, the kernel will (after 
> XXXX fails indicated by IRQ_NONE - don't remember exact numbers) disable 
> the IRQ from the host side, and emit the, ass-saving, "nobody cared" -print.
> 
> This is (in my opinion) the only RightThing(tm). (Especially so, if the 
> device is accessed from the fast handler, and is system is single-core). 
> There is a tremendous difference when debugging a system which just 
> hangs in IRQ loop forever (and you can't get no contact to it), and when 
> debugging a system which, after a relatively short hang-up, let's you 
> see the magic "nobody cared" -print telling a misbehaving IRQ was disabled.
> 
> Furthermore, if the status register read failure was a temporary one, 
> then we should be getting new IRQ as soon as the handler exists. This 
> should then successfully handle the IRQ.

I see this as a bit more nuanced. Depends on what fails. If we detect
no interrupt then it makes sense. For other cases it's is tricky to
figure out the right option.  Some errors are fine as we know they don't
affect the interrupt being cleared (if we even need to clear it).

So generally I've left that analysis and decision up to individual driver
authors.


> 
> Yours,
> 	-- Matti
> 

