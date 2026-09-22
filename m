Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0654E28507D;
	Tue, 22 Sep 2026 00:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790036340; cv=none; b=em3VGMOX07xS4qPwygohMeos/Sz4ZbD7WiPgD0O35nCxEtHTAsLPuad0Kf1+62L+/C9QhFp3lUBHTff6tqzgYT5aettNHBQbXQqjeyzn84ADQIFshBXcKQ/2U2zhl2f6DYeJUSMRt8FrbDnEWFOL5Dy3QOjpEWhKduGqTA9/4E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790036340; c=relaxed/simple;
	bh=0ok40EBi53GTDKxaAMVdjD3yFb6BG/LqnGiB/ursM/8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X6wtjhLELEu71Eewh5Q93bBmoR896tZ4OU7xoA3paSlHnu9XdVMkkE/1+ljQKW2N1W6HeDedAz4GFqL9cWZ8feqgORhd/0KylBv8fSFgIEPGiLNa2lntqtrHgMhOUFf353X60F+Zq5vlI2F+BpE03hoV8qFk3v0ifwGSaryWVl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WN+5uap4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WN+5uap4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 563B21F000FF;
	Tue, 22 Sep 2026 00:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790036338;
	bh=pKuNliyFNITCCSN/73/6eM3KfsIlkN3P1gcnfOIb6UE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WN+5uap4lpBT8LbJu6VyCGPDGy4ZMVXKXdmc82RA/r2uf7mGg0/SDj13l5NbtRNdg
	 cntOMCp3TuApd8gm6wfV1T66n4V6wqtdBvEyYj/XJODQjDuO1vT3cy3wPIikqu5jpp
	 JPfEn+aZcD60uj/nspWb6KsQjzJQsImNSTNXPf04f0HOTSMzjSpYHlWw1+/ayz0YAE
	 4frRoCjPQ/2bIsZg11Y2hc2PyrSIZz0ATyuwqEfGlBioCms2qTue+YOgrOEV/pnQ+v
	 P4sfJFGs9avHjG7fspSVwW3EBPgbfwzVhfZLG/EUYnPkCGPdPyIlM4FEWg99pJFuix
	 8ZtsT5ASsB7lQ==
Date: Tue, 22 Sep 2026 01:18:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Esben Haabendal <esben@geanix.com>
Cc: <sashiko-reviews@lists.linux.dev>, <robh@kernel.org>,
 <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
 <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v9 10/10] iio: accel: mma8452: Support interrupt sharing
Message-ID: <20260922011854.1c09ca7b@jic23-hlaptop>
In-Reply-To: <87bj9r9ng0.fsf@geanix.com>
References: <20260916-mma8452-open-drain-v9-0-0dd24fa2f3d7@geanix.com>
	<20260916-mma8452-open-drain-v9-10-0dd24fa2f3d7@geanix.com>
	<l9LG3al0xmawstyXcDwD8OhOBMwn13q6oz0NvCPy4kL0lA4DX5biMlUWcvt9Wwu1AiyugOvUZgQfnFJ4dvuvbA==@protonmail.internalid>
	<20260916083119.03A8F1F000FF@smtp.kernel.org>
	<87se38754p.fsf@geanix.com>
	<DCSg94lOVof3xt7nVMHqUJ4g_0LHFg9-B1_SPzr6YW6Q76JvKW9Wi7VQHgO2chZTHzFjCa--kqtVp7lZLsx5Qw==@protonmail.internalid>
	<20260921015115.4c7d79f3@jic23-hlaptop>
	<87bj9r9ng0.fsf@geanix.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Sep 2026 07:35:11 +0200
Esben Haabendal <esben@geanix.com> wrote:

> "Jonathan Cameron" <jic23@kernel.org> writes:
> 
> > On Thu, 17 Sep 2026 08:40:06 +0200
> > Esben Haabendal <esben@geanix.com> wrote:
> >  
> >> <sashiko-bot@kernel.org> writes:
> >>  
> >> > Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> >> > - [Critical] iio: accel: mma8452: Interrupt storm livelock when IRQ fires during RPM_SUSPENDING
> >> > - [High] iio: accel: mma8452: Invalid I2C access during system suspend due to mishandled -EINVAL
> >> > - [Medium] iio: accel: mma8452: Race condition in probe error path due to pm_runtime_disable() before free_irq()
> >> > --
> >> >  
> > So far we haven't enabled sashiko emails to the linux-iio list
> > (will probably move to that fairly soon) so fun side effect is this
> > reply was shouting into the void - except that b4 picks it up.
> >
> > +CC linux-iio. I'm too lazy to add everyone by hand who was on original thread.
> >
> > Key here is looks like you already plan a v10.  
> 
> Yes, sashiko-bot clearly catches a lot of valid problems. Also flags
> some things that is not valid. And for a patch series with many
> versions, like this one, these invalid findings keeps getting repeated.
> 
> Are there some guidelines how to handle this? Is it enough to write a
> reply to the list(s) explaining why the finding is invalid on the first
> report by sashiko-bot, or do we have to repeat every time that
> sashiko-bot repeats the rebuted finding?

No need to repeat.  One reply as you say and then add a note either
under the --- cut mark in the commit description or in the
cover letter.


> 
> >> > commit bf19c63685f6fff116a3a5358196fd66dff6090a
> >> > Author: Esben Haabendal <esben@geanix.com>
> >> >
> >> > iio: accel: mma8452: Support interrupt sharing
> >> >
> >> > This commit adds support for shared interrupts to the mma8452 driver. It
> >> > modifies the interrupt handler to check the runtime PM status and ignores
> >> > the interrupt if the device is suspended. It also updates the runtime
> >> > suspend and resume paths to properly disable and restore interrupt sources.
> >> >  
> >> >> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> >> >> index 5aea6bf3312af..2a980c0c2e03a 100644
> >> >> --- a/drivers/iio/accel/mma8452.c
> >> >> +++ b/drivers/iio/accel/mma8452.c  
> >> >
> >> > [ ... ]
> >> >  
> >> >> @@ -1086,15 +1088,28 @@ static irqreturn_t mma8452_interrupt(int irq, void *p)
> >> >>  {
> >> >>  	struct iio_dev *indio_dev = p;
> >> >>  	struct mma8452_data *data = iio_priv(indio_dev);
> >> >> +	struct device *dev = &data->client->dev;
> >> >>  	irqreturn_t ret = IRQ_NONE;
> >> >> +	int pm_status;
> >> >>  	int src;
> >> >>
> >> >> +	pm_status = pm_runtime_get_if_active(dev);
> >> >> +	if (pm_status == 0)
> >> >> +		return IRQ_NONE; /* device is powered down */  
> >> >
> >> > [Severity: Critical]
> >> > If the device asserts its level-triggered interrupt when the PM core is
> >> > transitioning the device to RPM_SUSPENDING (e.g., when the autosuspend
> >> > timer expires), pm_runtime_get_if_active() will return 0.
> >> >
> >> > Does returning IRQ_NONE without clearing the hardware interrupt here cause
> >> > a permanent interrupt storm? Since the IRQ line is shared and unmasked upon
> >> > return, the still-asserted hardware interrupt might immediately re-trigger
> >> > the handler, potentially starving the worker thread that executes
> >> > mma8452_runtime_suspend() and hard-locking the system.  
> >>
> >> This should be handled by the disable of all interrupt sources (clearing
> >> CTRL_REG4) in mma8452_runtime_suspend().
> >>  
> >> > [Severity: High]
> >> > During system suspend, pm_runtime_force_suspend() disables runtime PM,
> >> > which increments the disable depth. If a shared interrupt fires during this
> >> > window, pm_runtime_get_if_active() returns -EINVAL.
> >> >
> >> > Since this check only catches pm_status == 0, does this allow the handler
> >> > to proceed and perform I2C reads on unpowered hardware? Per subsystem
> >> > guidelines, should this check for pm_status <= 0 instead?  
> >>
> >> If we bail out on pm_status <= 0, the driver would not work on systems
> >> with CONFIG_PM not enabled.
> >>
> >> In order to handle the difference betwen the different reasons for
> >> -EINVAL, it would seem like we would need some #ifdef CONFIG_PM in here.
> >> Do we really want to do that?  
> >
> > That if_enabled() function is a pain.  Definitely not ifdef but
> > how about
> >
> >  if (IS_ENABLED(CONFIG_PM) && ret < 0) or something like that?  
> 
> That should work. Now, in this case, do we want to report IRQ_HANDLED or
> IRQ_NONE? We obviosly did not really handle it, but we also don't know
> if the irq was for this device.

We never get consensus on this but I tend to go with IRQ_HANDLED when
we don't know it wasn't ours.

Jonathan

> 

