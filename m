Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470B02609E3;
	Mon, 21 Sep 2026 00:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789951882; cv=none; b=aEvOlcvupAkmKF6a32OddHLj4VuQhAob0eWyBQsOl+8u77oIdjxMq8u7HqjoBX4xuWlRDkljBO1jijGqWbgTESV2Tiskw9/ZRYhajwOyIwmIGvNSOE5j5WRPLLW6CLaUDA+7OpSboeHxD2bUT843GAdo5TNRXmO+SXJONfqcqJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789951882; c=relaxed/simple;
	bh=xBVPP30Qd88Mjx0anf7NopthBhUjLAYlzZSIhYIJS4g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OUySO6zyxmChMw+iJIVW3DSvNAj1R2SIqO+2l7f9VOSBBhAFq7oWkmxUxXb8aDKeDKFL9r7jDA+KonQU7GmkJMoumz2/d4LqKvQCrlrME2fZxF2LoX1r4o+9zezKmtjXU+fPp23PI90hucTBp4yKA+nHhTs37bkSsWcJo8IHNu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e8wlr91w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e8wlr91w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 778091F000FF;
	Mon, 21 Sep 2026 00:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789951881;
	bh=9MKTC97GLVskK1uTEv9NjIqRIxXcd/YxASMsy5EdwqI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=e8wlr91wEUYce0MYE73QVzkKdFc1Or9D/aJERDrn9a8qsEhHjdoVsAGEsHsl55xCJ
	 JMOW8xAMiFy9hy/Eu6m0I50hDTL1wEq3TGuIBrwgOE16foJEMmUXXq8fV+f5VeYSVR
	 E8G6P399W/sp95rZuYFYCw4n2uGVAv1QsZLQnS/N8cWBFoOxPG3QnLVSoSmAXHSSsG
	 cjKh80ajlh0H2qYql8EKZvWukEqiU9LLhFwEv8X3FiQ5OkfDzcsxrkH4hWibxuLsWq
	 Vcq3I/7adca9OgsVJIcYIGOIXn9c7D6E3IkGKHD2bFF97sXI1/7XCMEGveDT+jxbwB
	 7IcXrQhnceCJQ==
Date: Mon, 21 Sep 2026 01:51:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Esben Haabendal <esben@geanix.com>
Cc: <sashiko-reviews@lists.linux.dev>, <robh@kernel.org>,
 <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH v9 10/10] iio: accel: mma8452: Support interrupt sharing
Message-ID: <20260921015115.4c7d79f3@jic23-hlaptop>
In-Reply-To: <87se38754p.fsf@geanix.com>
References: <20260916-mma8452-open-drain-v9-0-0dd24fa2f3d7@geanix.com>
	<20260916-mma8452-open-drain-v9-10-0dd24fa2f3d7@geanix.com>
	<l9LG3al0xmawstyXcDwD8OhOBMwn13q6oz0NvCPy4kL0lA4DX5biMlUWcvt9Wwu1AiyugOvUZgQfnFJ4dvuvbA==@protonmail.internalid>
	<20260916083119.03A8F1F000FF@smtp.kernel.org>
	<87se38754p.fsf@geanix.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Sep 2026 08:40:06 +0200
Esben Haabendal <esben@geanix.com> wrote:

> <sashiko-bot@kernel.org> writes:
> 
> > Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> > - [Critical] iio: accel: mma8452: Interrupt storm livelock when IRQ fires during RPM_SUSPENDING
> > - [High] iio: accel: mma8452: Invalid I2C access during system suspend due to mishandled -EINVAL
> > - [Medium] iio: accel: mma8452: Race condition in probe error path due to pm_runtime_disable() before free_irq()
> > --
> >
So far we haven't enabled sashiko emails to the linux-iio list
(will probably move to that fairly soon) so fun side effect is this
reply was shouting into the void - except that b4 picks it up.

+CC linux-iio. I'm too lazy to add everyone by hand who was on original thread.

Key here is looks like you already plan a v10.


> > commit bf19c63685f6fff116a3a5358196fd66dff6090a
> > Author: Esben Haabendal <esben@geanix.com>
> >
> > iio: accel: mma8452: Support interrupt sharing
> >
> > This commit adds support for shared interrupts to the mma8452 driver. It
> > modifies the interrupt handler to check the runtime PM status and ignores
> > the interrupt if the device is suspended. It also updates the runtime
> > suspend and resume paths to properly disable and restore interrupt sources.
> >  
> >> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> >> index 5aea6bf3312af..2a980c0c2e03a 100644
> >> --- a/drivers/iio/accel/mma8452.c
> >> +++ b/drivers/iio/accel/mma8452.c  
> >
> > [ ... ]
> >  
> >> @@ -1086,15 +1088,28 @@ static irqreturn_t mma8452_interrupt(int irq, void *p)
> >>  {
> >>  	struct iio_dev *indio_dev = p;
> >>  	struct mma8452_data *data = iio_priv(indio_dev);
> >> +	struct device *dev = &data->client->dev;
> >>  	irqreturn_t ret = IRQ_NONE;
> >> +	int pm_status;
> >>  	int src;
> >>
> >> +	pm_status = pm_runtime_get_if_active(dev);
> >> +	if (pm_status == 0)
> >> +		return IRQ_NONE; /* device is powered down */  
> >
> > [Severity: Critical]
> > If the device asserts its level-triggered interrupt when the PM core is
> > transitioning the device to RPM_SUSPENDING (e.g., when the autosuspend
> > timer expires), pm_runtime_get_if_active() will return 0.
> >
> > Does returning IRQ_NONE without clearing the hardware interrupt here cause
> > a permanent interrupt storm? Since the IRQ line is shared and unmasked upon
> > return, the still-asserted hardware interrupt might immediately re-trigger
> > the handler, potentially starving the worker thread that executes
> > mma8452_runtime_suspend() and hard-locking the system.  
> 
> This should be handled by the disable of all interrupt sources (clearing
> CTRL_REG4) in mma8452_runtime_suspend().
> 
> > [Severity: High]
> > During system suspend, pm_runtime_force_suspend() disables runtime PM,
> > which increments the disable depth. If a shared interrupt fires during this
> > window, pm_runtime_get_if_active() returns -EINVAL.
> >
> > Since this check only catches pm_status == 0, does this allow the handler
> > to proceed and perform I2C reads on unpowered hardware? Per subsystem
> > guidelines, should this check for pm_status <= 0 instead?  
> 
> If we bail out on pm_status <= 0, the driver would not work on systems
> with CONFIG_PM not enabled.
> 
> In order to handle the difference betwen the different reasons for
> -EINVAL, it would seem like we would need some #ifdef CONFIG_PM in here.
> Do we really want to do that?

That if_enabled() function is a pain.  Definitely not ifdef but
how about

 if (IS_ENABLED(CONFIG_PM) && ret < 0) or something like that?

> 
> >> +
> >> +	/*
> >> +	 * pm_status is now 1 or -EINVAL. If pm_status==1, runtime PM is enabled
> >> +	 * and device is RPM_ACTIVE. If pm_status==-EINVAL, runtime PM is
> >> +	 * disabled (e.g. CONFIG_PM not enabled), and we can/must assume device
> >> +	 * is active.
> >> +	 */
> >> +
> >>  	src = i2c_smbus_read_byte_data(data->client, MMA8452_INT_SRC);  
> >
> > [ ... ]
> >  
> >> @@ -1771,11 +1790,12 @@ static void mma8452_remove(struct i2c_client *client)
> >>
> >>  	iio_device_unregister(indio_dev);
> >>
> >> -	pm_runtime_disable(dev);
> >> -	pm_runtime_set_suspended(dev);
> >> -
> >>  	if (client->irq)
> >>  		free_irq(client->irq, indio_dev);
> >> +	/* No irq will fire beyond this point */
> >> +
> >> +	pm_runtime_disable(dev);
> >> +	pm_runtime_set_suspended(dev);  
> >
> > [Severity: Medium]
> > This correctly fixes the race in mma8452_remove() by moving free_irq()
> > before pm_runtime_disable(), but does the same race still exist in the
> > mma8452_probe() error path?
> >
> > If mma8452_probe() fails after pm_runtime_enable(), it jumps to the
> > runtime_suspend label:
> >
> >   mma8452_probe() {
> >       /* ... */
> >   runtime_suspend:
> >       pm_runtime_disable(dev);
> >       pm_runtime_set_suspended(dev);
> >
> >   free_irq:
> >       if (client->irq)
> >           free_irq(client->irq, indio_dev);
> >       /* ... */
> >   }
> >
> > If a shared interrupt fires between pm_runtime_disable() and free_irq(),
> > could the handler attempt to access unpowered hardware?  
> 
> I will apply the same reordering in mma8452_probe().

Sounds good to me

Jonathan

> 
> /Esben

