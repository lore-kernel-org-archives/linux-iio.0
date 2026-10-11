Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893503EA97A;
	Sun, 11 Oct 2026 12:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791722582; cv=none; b=RrJSSGHhNCnaINcI8Bhq1ko5yJ5gW8zqkSrkHWhwJfhMVlH/Qw6pM2N5FyVAa3WQSr8Du2agcoanyqInfIfEZnV5+aGev+bFF47dHWrKqaplIYvx/Llsr+J+dYYs2HhyofAJDs4+R7YQizPPeouUC953WCsWmwuXSie2hJ7i9+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791722582; c=relaxed/simple;
	bh=+TMrCZE48uV+/iDSom/yo+Isurr1VrtXfpYso39/n7E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sp9J+36vQwpLvcGLk1A9IvTZU4Zpz0S5IJEK1/KneBWreFOmMOsB0zjE01XGJs/xDO2P3+niaOLPNEK+u/k8EwMY1V//e+GGVXDEawB8j8LeiHSYKENXEYPWfxPCHb6l2TPTJ5BrieBfT6xUT1GM7I4z3q/H3SKLeAYqtYWHz48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fODHIKlK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fODHIKlK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 421821F0089B;
	Sun, 11 Oct 2026 12:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791722579;
	bh=9EcFXwo8AKKvEcQSAeHDkJYQiJ3AS4jTyK7YrDwyvd8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fODHIKlKmg6c6HF45tok43R+th9ONXd9wGU7O6F9j/tjrbezfr2ZnGb+moVFGqUyv
	 kOQBp5Du12h7syCINKSenLsSEHYcUR6twQplyqxYCyk2nv1SvNu5W05jSbwvXNi0h0
	 M+v8+KOvbFc4Afyp5f10aKQiTFDfNxXzWnV4fCTEKUJzBxBLFrIkT3gMDeZGsSD5rS
	 KY0b3wBfW+gntba9Eomo8Ld5cdeCYtHiSx+10oiooBDm0ifmQhg3oa26g4bVHo1dPJ
	 Oy8xUqPyizmPhVy4QrmdCTtqspk9XDkFndUsuV8C+xbAELz/JAuehNA+dCFU34UrtD
	 pMM0LQVkxjXYg==
Date: Sun, 11 Oct 2026 13:41:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Esben Haabendal <esben@geanix.com>
Cc: "Andy Shevchenko" <andriy.shevchenko@intel.com>, "Lars-Peter Clausen"
 <lars@metafoo.de>, "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Martin
 Kepplinger" <martink@posteo.de>, "Sean Nyekjaer" <sean@geanix.com>, "David
 Lechner" <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>, "Martin
 Kepplinger" <martin.kepplinger@theobroma-systems.com>, "Christoph Muellner"
 <christoph.muellner@theobroma-systems.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 10/10] iio: accel: mma8452: Support interrupt
 sharing
Message-ID: <20261011134146.3ae020a1@jic23-hlaptop>
In-Reply-To: <87mrt1vfz6.fsf@geanix.com>
References: <20260928-mma8452-open-drain-v10-0-b906fb408386@geanix.com>
	<20260928-mma8452-open-drain-v10-10-b906fb408386@geanix.com>
	<CNQ6_DVFGgC82FTU2GwM8v4KY2d4DUOo_b1XhhyOnysR6eWGJEsgFHlNLylYvkM6dWR3mhcGGFNDuN7qwCO1YA==@protonmail.internalid>
	<aroytGH8u-gGFYvq@ashevche-desk.local>
	<87mrt1vfz6.fsf@geanix.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Sep 2026 12:15:57 +0200
Esben Haabendal <esben@geanix.com> wrote:

> "Andy Shevchenko" <andriy.shevchenko@intel.com> writes:
> 
> > On Mon, Sep 28, 2026 at 10:26:26AM +0200, Esben Haabendal wrote:  
> >> Adding support for sharing interrupt line with other device requires the
> >> interrupt handler to handle runtime PM suspension properly, ignoring the
> >> irq if the device is suspended (maybe even off). And while at it, we use
> >> the PM reference to ensure we do not get suspended while processing an irq.
> >>
> >> In order to prevent the chip from raising irq while suspended (that is when
> >> using fixed regulator, where suspend just means setting the device in
> >> STANDBY mode), we disable all interrupt sources by clearing CTRL_REG4, and
> >> then restores the value again when resuming.
> >>
> >> The scoped_guard in mma8452_runtime_suspend() is changed to a plain
> >> mutex_lock() instead, both to prevent mixing guards and goto, but also to
> >> ensure that we stay in STANDBY mode while writing to CTRL_REG4 and all the
> >> way up to disabling the device as much as possible.
> >>
> >> With that in place, it is safe to add the IRQF_SHARED flag.
> >>
> >> Keep in mind that the device by default is using push-pull for the irq pin,
> >> which might require additional hardware design to allow interrupt sharing.  
> >
> > ...
> >  
> >> +	pm_status = pm_runtime_get_if_active(dev);
> >> +	if (pm_status == 0)
> >> +		/* device is powered down */
> >> +		return IRQ_NONE;  
> >  
> >> +	if (IS_ENABLED(CONFIG_PM) && pm_status < 0)
> >> +		/* runtime PM was disabled, possibly suspending */
> >> +		return IRQ_HANDLED;  
> >
> > This is very interesting part. I bet this will be the first driver using this.
> > A big question "why?"  
> 
> Because as I understood it, I needed to add this for the patch to be
> accepted [1]. It is definitely possible that I have misunderstood that.
> 
> The technical reason I believe is that during system suspend,
> pm_runtime_force_suspend() disabled runtime PM, and if a shared
> interrupt durings this, pm_runtime_get_if_active returns -EINVAL, and we
> could therefore end up doing I2C reads on unpowered hardware.
> 
> Per that reasoning, we probably should be doing this in other drivers as
> well.

I suspect that the combination of a shared interrupt and runtime pm
is moderately rare and even when it is there are drivers doing their
own tracking to avoid this sort of corner case.

There are a lot of these nasty corners in runtime pm :(

This seems like a reasonable solution to me, but given
all the discussion on this version was around this patch I'm going
to pick up 1-9 to but ask you to send a new version of this one to
make sure we get maximum eyes on it.  Please include the PM maintainer
as well in the +CC in case we have this all wrong!

> 
> >> +	/*
> >> +	 * pm_status is now 1 or -EINVAL (with CONFIG_PM not enabled). If
> >> +	 * pm_status==1, runtime PM is enabled and device is RPM_ACTIVE. If
> >> +	 * pm_status==-EINVAL, runtime PM is build-time disabled (i.e. CONFIG_PM
> >> +	 * not enabled), and we can/must assume device is active.
> >> +	 */
> >> +
> >>  	src = i2c_smbus_read_byte_data(data->client, MMA8452_INT_SRC);
> >>  	if (src < 0)
> >> -		return IRQ_NONE;
> >> +		goto out_runtime_put;
> >>
> >>  	if (!(src & (data->chip_info->enabled_events | MMA8452_INT_DRDY)))
> >> -		return IRQ_NONE;
> >> +		goto out_runtime_put;
> >>
> >>  	if (src & MMA8452_INT_DRDY) {
> >>  		iio_trigger_poll_nested(indio_dev->trig);
> >> @@ -1120,6 +1139,10 @@ static irqreturn_t mma8452_interrupt(int irq, void *p)
> >>  		ret = IRQ_HANDLED;
> >>  	}
> >>
> >> +out_runtime_put:
> >> +	if (pm_status > 0)
> >> +		pm_runtime_put_autosuspend(dev);
> >> +
> >>  	return ret;
> >>  }  
> >
> > ...
> >  
> >> +	pm_runtime_enable(dev);
> >> +	pm_runtime_set_autosuspend_delay(dev, MMA8452_AUTO_SUSPEND_DELAY_MS);
> >> +	pm_runtime_use_autosuspend(dev);  
> >
> > I don't see the respective _dont_use_autosuspend() call anywhere.  
> 
> Ah. I was not aware it was attached to a usage counter as well. I will
> add a pm_runtime_dont_use_autosuspend() to the runtime_suspend: error handling.
> 
> > ...
> >
> > I am wondering how many of the above possible scenarios you were able
> > to test.  
> 
> Not enough. I haven't done any additional instrumentation to cause all
> the various error conditions that is handled here in _probe().
> 
> > ...
> >
> > P.S.  I bet you can now make a presentation "PM runtime in Linux and
> > why it is so hard."  
> 
> LOL. I am getting there, yes. I have definitely learned a lot about how
> runtime PM works. Especially since I was mostly starting from scratch on
> that.
> 
> But i fear it would easily end up being quite a chaotic presentation :)

:)

I've vaguely be wondering if we need a bunch of self test + examples
to poke all the more crazy corners of runtime pm.  That way we can
at least be sure that if we do finally understand it we aren't going
to get any regressions.

J
> 
> /Esben

