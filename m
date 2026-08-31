Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E795474F;
	Mon, 31 Aug 2026 00:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788136472; cv=none; b=Jx2qgWK20Y6FhoLtTtSiWdulYt+q/Q/T0fLpqojw/t83IwJzOBMs01t3dEtK+ma4TQ9Al4AUNOZOfaVyqmqd5JKTHNunffTdiJljq05HtZSEVi6hgD3/zlQBw0KJUH98+Y+Dh5ItzJN0KTrNTH8D1FjNvGsf5Q49DSGqr0+kb7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788136472; c=relaxed/simple;
	bh=Tke5RRhMkx2z9Owf+XSmPcsgWzXm10uR9/fbtCkG/sQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AhpbTm7EC7dY+tbBHmtp3rGhv3GRo2adWeCsseyu9YT6iXId6hg5fLeMJHwftyFZAAO0jQjRJGuFhQqlnknisG3iIPUBfzGwAztkjQmITQ/FGgU9wcywuM9R7L7EdN1ID/DYi+um/eMYl7/gyBPwfaG42iHtGUTjfaB2aDdumUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=akFmQt2O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="akFmQt2O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CF011F000E9;
	Mon, 31 Aug 2026 00:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788136471;
	bh=vdyuWGBxj3YiYnZRxx774ND34vHiztWK0k0V7hdpqQo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=akFmQt2OXVzikINqVpW29P4sbgKZ284EJfWtlKhwGZfpjbOGqxWfRQOnwaJmlzFjS
	 Dgw0EA9f6BusFQHerY5VIHaENUu2rN3r+NliphR0n98SjZt3mcgfAYBEQAGI26sz5H
	 VWc4UQtl05UgAktSJ9U1jA5NI2Qrt3zXus7SrWwajfeaYDeH4Q5zTeA4KLmI8ulIGE
	 3UPgPrFx+vdJ4DtRu3ko2rlT5GM0pV2ZgaKvH6wS/juhKRwepHml2DJnlx1DLQqOEQ
	 cEMyODGXfg4ky8/9CCOwb0djx8CvAgiiLppFUVcQJoHn3zO+NqN1kNe/7Y+IN1EUHT
	 Np0jRrdk9jsAQ==
Date: Mon, 31 Aug 2026 01:34:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Esben Haabendal <esben@geanix.com>
Cc: "Joshua Crofts" <joshua.crofts1@gmail.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, "Lars-Peter Clausen" <lars@metafoo.de>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Martin Kepplinger"
 <martink@posteo.de>, "Sean Nyekjaer" <sean@geanix.com>, "David Lechner"
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, "Martin Kepplinger"
 <martin.kepplinger@theobroma-systems.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 7/9] iio: accel: mma8452: Drop unneeded lock acquire
 on read
Message-ID: <20260831013425.7803ce1c@jic23-huawei>
In-Reply-To: <87pkz6mh07.fsf@geanix.com>
References: <20260825-mma8452-open-drain-v6-0-9b252804ee80@geanix.com>
	<20260825-mma8452-open-drain-v6-7-9b252804ee80@geanix.com>
	<UFc9cC1VeohKw6lxQ8uulsfj9wJ_OqGUgGPTUnTX-zssKZ97aEC0Xi9nsAxv-tcf2DP5e85ElFZ8wPgxwG8l3g==@protonmail.internalid>
	<20260825121704.00004ed3@gmail.com>
	<87y0dumiga.fsf@geanix.com>
	<2m3zXurwen7GRVSaBnDu6bY31Gn7dFzO2UEoU4bRNxCGCR86DTyGq-CMmmeEh-U7AcCWC6eBjjFbZSGNltSwWg==@protonmail.internalid>
	<20260825154449.00002f6f@gmail.com>
	<87pkz6mh07.fsf@geanix.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Aug 2026 16:06:32 +0200
Esben Haabendal <esben@geanix.com> wrote:

> "Joshua Crofts" <joshua.crofts1@gmail.com> writes:
> 
> > On Tue, 25 Aug 2026 15:35:17 +0200
> > Esben Haabendal <esben@geanix.com> wrote:
> >  
> >> "Joshua Crofts" <joshua.crofts1@gmail.com> writes:
> >>  
> >> > On Tue, 25 Aug 2026 10:27:45 +0200
> >> > Esben Haabendal <esben@geanix.com> wrote:
> >> >  
> >> >> There is no need to acquire data->lock when calling mma8452_read(), and
> >> >> dropping that makes it less likely to end up in an AB-BA deadlock
> >> >> situation.
> >> >>
> >> >> Signed-off-by: Esben Haabendal <esben@geanix.com>
> >> >> ---
> >> >>  drivers/iio/accel/mma8452.c | 2 --
> >> >>  1 file changed, 2 deletions(-)
> >> >>
> >> >> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> >> >> index 7ef1a9a91c31..9ae2c3e60576 100644
> >> >> --- a/drivers/iio/accel/mma8452.c
> >> >> +++ b/drivers/iio/accel/mma8452.c
> >> >> @@ -504,9 +504,7 @@ static int mma8452_read_raw(struct iio_dev *indio_dev,
> >> >>  		if (!iio_device_claim_direct(indio_dev))
> >> >>  			return -EBUSY;
> >> >>
> >> >> -		mutex_lock(&data->lock);
> >> >>  		ret = mma8452_read(data, buffer);
> >> >> -		mutex_unlock(&data->lock);
> >> >>  		iio_device_release_direct(indio_dev);
> >> >>  		if (ret < 0)
> >> >>  			return ret;
> >> >>  
> >> >
> >> > Sashiko has something to say and I tend to agree at the moment:
> >> >
> >> > Could removing this lock expose mma8452_read() to race conditions with PM
> >> > auto-suspend and event configuration?  
> >>
> >> Yes. I tend to agree as well.
> >>  
> >> > mma8452_read() can be interrupted by the PM auto-suspend worker, which puts
> >> > the device in STANDBY and disables regulators while mma8452_drdy() is actively
> >> > polling over I2C. This can lead to I/O timeouts or errors.  
> >>
> >> Yes, and causing pain for other I2C devices on same bus :(
> >>  
> >> > Additionally, concurrent sysfs writes to event configurations invoke
> >> > mma8452_change_config(), which puts the hardware into STANDBY to modify
> >> > registers. The Standby transition flushes the hardware FIFO. If this occurs
> >> > between the mma8452_drdy() check and the i2c_smbus_read_i2c_block_data() in
> >> > mma8452_read(), the block read will fetch flushed or stale data.  
> >>
> >> Argh. Yet another level of trouble.
> >>
> >> Maybe we should extend the use of data->lock instead. Holding it
> >> 1. whenever doing read-modify-write actions
> >> 2. while holding the device in standby mode for changing registers
> >> 3. while doing suspend/resume
> >>
> >> I was just adding support for a open-drain mode irq sharing you know.
> >> While sashiko-bot definitely is catching lots of valid problems, and
> >> fixing them is a good thing, this is starting to feel like I opened
> >> Pandoras box by touching this driver :D
> >>
> >> I will try to wrap up a patch with the above described extended usage of
> >> data->lock, but hope we can find a way to get the irq sharing and open
> >> drain mode support merged, without necessarily having to fixing all and every
> >> possible existing bugs as a pre-condition, but maybe delay some work to
> >> later work.
> >>  
> >
> > If they're pre-existing conditions then it's not required to fix those in the
> > same patch series, you can come back to it another time or someone else can fix
> > those.  
> 
> Great. I have created a local mma8452-next branch where I will continue
> the work on some of these issues.

Great. It is absolutely fine to postpone (or indeed ignore completely) reports
from sashiko that are on preexisting issues.  That even applies when I point
them out or suggest maybe you take a look!  I don't mind folk saying
they are too busy!  I know I am which is why I try to talk others into doing
this stuff ;)

> 
> > Nevertheless this is an issue that will be caused directly by this patch if
> > applied. If your only goal is to add support for open-drain irq sharing, you
> > can probably just drop this for the time being and just focus on that.  
> 
> I will drop this particular patch for this series, and work on a proper
> fix for all these race conditions in my mma8452-next branch.

Excellent!

I'll wait on a fresh shorter version of this series then get that queued
up to give an upstream base for further work.

Thanks,

Jonathan

> 
> /Esben

