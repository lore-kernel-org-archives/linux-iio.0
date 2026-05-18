Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993A03EEAE4;
	Mon, 18 May 2026 13:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779110581; cv=none; b=O8MxAos5JzCy0yIh6KoW7+nCykxc3Ldy3MgcSN3hfwyvL6wi/77WJWoAUSqjQPXBPaZYkBYpGXXK1f8ZdHTnZckxSxmRVzZ0kchaIyMkG6ONg3T1ruU6AT4/QlOjD+qYNmwWafJmSr4tswfa6+ijSJXhD8F4EMxQg6AaYbom5dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779110581; c=relaxed/simple;
	bh=pjNbKx4WluLhseVwoy2U59WbYwUwUaKh0NMmfgxnx2M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y/9yGx/N6Ux7LxtnB00E52wTa/HsGO3dk8fj2gC/nsWdU36FtikLIp/H2wcfwoZS+PWfywAmhkAauMRivg8Yrx/mKqP3tRFTfWoGhd7zPlHREja37RJwCRkDTe3k0Tp4Aq2p0hStXKsmXfx1UYJ0S1u3ieOmjctu2hIFLNaMTck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X1zpVeF5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1zpVeF5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF0E4C2BCB7;
	Mon, 18 May 2026 13:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779110581;
	bh=pjNbKx4WluLhseVwoy2U59WbYwUwUaKh0NMmfgxnx2M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X1zpVeF5k6L8r/HlwwLLYWbgcpZ5oLE/Fsgf9NYWHQmsCuzGa8PjFvC2UMLvHxda/
	 pEy6L8cOQ5Bf8Lk+guVP2DYVdVjpNqULUJ7SJa8m7wk7HrayXvsn7EWsRDARY/h2U0
	 dYltKF5vF3u6Sq4NWRVmevaYcK/v19buQdno3ziGyGvF8V+SxcERp/v6L43sQYVhbs
	 lrI9GA8UNtJqP/1sJE+xzM+KNLPzhO0dcw48omsiZMeiKU6YTPh9T3tG8TT++A5/+f
	 yRrkEHdZdlqooVxxvhrtoNhq9z+/3ppKxC3V9QFdWc8JD6cD0VhMAgDeygCBOUZR8F
	 SNxDOJH84qHKQ==
Date: Mon, 18 May 2026 14:22:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Hardik Phalet <hardik.phalet@pm.me>, gregkh@linuxfoundation.org,
 andy@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 krzk+dt@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
 me@brighamcampbell.com, nuno.sa@analog.com, robh@kernel.org,
 skhan@linuxfoundation.org, Hardik Phalet <hardik.phalet@gmail.com>
Subject: Re: [PATCH v3 0/5] iio: magnetometer: add driver for QST QMC5883P
Message-ID: <20260518142250.6b9f0e6b@jic23-huawei>
In-Reply-To: <166a6262-0ad4-4957-9729-863e2694e81d@baylibre.com>
References: <20260420-qmc5883p-driver-v3-0-da1e97088f8b@pm.me>
	<20260420144534.0e47c06a@jic23-huawei>
	<DIL6ZC7KKYMN.36KGJXKDRGFB0@pm.me>
	<166a6262-0ad4-4957-9729-863e2694e81d@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 17 May 2026 15:28:22 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 5/17/26 2:17 PM, Hardik Phalet wrote:
> > On Mon Apr 20, 2026 at 7:15 PM IST, Jonathan Cameron wrote:  
> >> On Sun, 19 Apr 2026 22:32:09 +0000
> >> Hardik Phalet <hardik.phalet@pm.me> wrote:
> >>  
> >>> This series adds an IIO driver for the QST QMC5883P, a 3-axis
> >>> anisotropic magneto-resistive (AMR) magnetometer with a 16-bit ADC,
> >>> communicating over I2C. To my knowledge there is no existing
> >>> upstream driver for this device (see "Prior-art register-map check"
> >>> below).
> >>>
> >>> The driver supports:
> >>>   - Raw magnetic field readings on X, Y and Z axes
> >>>   - Four full-scale ranges (+/-2 G, +/-8 G, +/-12 G, +/-30 G),
> >>>     selectable via IIO_CHAN_INFO_SCALE
> >>>   - Four output data rates (10, 50, 100, 200 Hz), selectable via
> >>>     IIO_CHAN_INFO_SAMP_FREQ
> >>>   - Four oversampling ratios (1, 2, 4, 8), selectable via
> >>>     IIO_CHAN_INFO_OVERSAMPLING_RATIO  
> >>
> >> I'm suspicious about this one based on a very quick read of the datasheet.
> >> Conventional oversampling would involve running the internal sampling
> >> engine at a multiple of the sampling frequency, and then averaging the
> >> results.  The datasheet describes this as:
> >> "Over sample Rate (OSR1) registers are used to control bandwidth of an
> >>  internal digital filter. Larger OSR value leads to smaller filter bandwidth,
> >>  less in-band noise and higher power consumption. It could be used to reach a
> >>  good balance between noise and power. Four over sample ratios can be selected,
> >>  8,4,2 or 1."
> >>
> >> That sounds like a boxcar filter to me not oversampling (which would be
> >> a combination of box car and reducing the output data rate).
> >>
> >> If possible, can you enable the data ready output and put a scope on it
> >> to see if that changes frequency when OSR or OSR2 are modified.
> >>
> >> Trickier to do would be looking at the noise levels whilst playing with
> >> these filters and see if they at least match with standard filter types.
> >>
> >> If we can't figure these out, then it may be a case of picking something
> >> that works well and hard coding that rather than letting userspace
> >> change things in a fashion that might not match the ABI.  
> > 
> > I could not arrange a oscilloscope. So wrote a small standalone tool that drives
> > the chip directly over /dev/i2c-N (skipping the driver) on a Pi 4 and
> > characterised all three fields in CTRL_1 with timing + noise measurements.
> > Summary:
> > 
> >   Field    Bits     Role per measurement
> >   ODR      [3:2]    output rate, accurate to ~3% of nominal in Normal Mode
> >   OSR1     [5:4]    low-pass filter (bandwidth control), no rate change
> >   OSR2     [7:6]    N-sample averaging, no rate change (real oversampling)
> > 
> > 1. DRDY interval vs each field (median of 500 samples per setting,
> >    ms; SCHED_FIFO, pinned CPU):
> > 
> >    vary ODR (OSR1=1, OSR2=1):
> >      ODR=10 Hz  -> 100.9 ms       ODR=100 Hz -> 10.30 ms
> >      ODR=50 Hz  ->  20.5 ms       ODR=200 Hz ->  5.14 ms
> > 
> >    vary OSR1 (ODR=200 Hz, OSR2=1):
> >      OSR1=1 -> 5.142 ms           OSR1=4 -> 5.139 ms
> >      OSR1=2 -> 5.143 ms           OSR1=8 -> 5.141 ms
> > 
> >    vary OSR2 (ODR=200 Hz, OSR1=1):
> >      OSR2=1 -> 5.142 ms           OSR2=4 -> 5.142 ms
> >      OSR2=2 -> 5.140 ms           OSR2=8 -> 5.141 ms
> > 
> >    ODR is the only knob that changes the rate.
> > 
> > 2. Per-axis noise stddev (2000 samples, sensor still, ratios vs N=1):
> > 
> >    vary OSR1:                   vary OSR2:
> >      OSR1=1 -> 1.000              OSR2=1 -> 1.000
> >      OSR1=2 -> 0.723              OSR2=2 -> 0.706
> >      OSR1=4 -> 0.544              OSR2=4 -> 0.494
> >      OSR1=8 -> 0.416              OSR2=8 -> 0.333
> > 
> >    Reference for N-sample averaging (1/sqrt(N)):
> >      1.000 / 0.707 / 0.500 / 0.354
> > 
> >    OSR2 matches within measurement noise; OSR1 trails the curve,
> >    which is the expected signature of a bandwidth-limiting filter
> >    on non-white input noise.

Nice data.

> > 
> > So to my understanding, OSR2 is true oversampling. OSR1 is a filter. 

Oversampling might also be tied to an integration period which would
reduce as oversampling goes up, somewhat undoing the noise improvements.
So it might be worse than an averaging.  Without introducing
some dynamic motion it's going to be hard to figure this out. Maybe stick
the thing on a pendulum or if you happen to have one a record deck?
(assuming you can wire it!)
Anything to be able to repeat something that will vary the signal.
That should let you separate box car across a fixed sampling rate
from oversampling.
 
> 
> The datasheet says that power consumption changes based on OSR1,
> so that makes me think that OSR1 is really oversampling since it
> would take more energy to do more conversions in the same amount
> of time. (Note 1 on table 2.1)
Is it possible it's a sampling / resampling ADC or similar so the
actual resolution is dropping? That saves some power.  Mind you
puttting that in a place called OSR1 would be odd ;)

Or as you suggest it's actually triggering burst conversion and averaging.
So datarate fixed but actual sampling time is much lower so it can
do lots of samples without the effective sampling rate changing.
> 
> Another chip by the same mfg that looks like it has the same OSR1/
> OSR2 has a bit more info in the same table [1]. It looks like OSR2
> affects the sensitivity (and calls OSR2 a low pass filter instead
> of "down sampling rate").
> 
> [1] https://www.qstcorp.com/upload/pdf/202601/CF382A94E1424763B3DE87DC967757FC.pdf

Ah ok. Good detective work.  Though it would be far from the first datasheet
to confuse oversampling with straight forward filtering.
> 
> > 
> > v4 plan, pending your input on (c):
> > 
> >   (a) Add an OSR2 regmap_field and expose it as
> >       IIO_CHAN_INFO_OVERSAMPLING_RATIO with values {1, 2, 4, 8}.
> >   (b) Drop the OVERSAMPLING_RATIO mapping on OSR1.
> >   (c) For OSR1, two options:
> >         i)  expose as IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY.
> >             The public datasheet does not give cutoff frequencies,
> >             so I'd have to either characterise them empirically and
> >             document them in the driver, or use placeholder values
> >             derived from the OSR1 setting alone (which feels wrong).
> >         ii) hard-code OSR1=1 in chip_init and not expose it. Loses
> >             the noise-vs-bandwidth tradeoff but keeps the ABI clean.
> >       Slight preference for (ii) unless you'd rather see the filter
> >       knob exposed.  
> 
> It sounds like we already figured out that OSR2 is just a moving average
> so might as well implement IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY.

Maybe... We might have to just go for best guess and document it clearly.

Jonathan

> 
> >   (d) Keep ODR mapped to IIO_CHAN_INFO_SAMP_FREQ as in v3.
> > 
> > One other finding worth mentioning: the datasheet's setup examples
> > (sec 7.1, 7.2, 7.3) all write 0x06 to register 0x29 before entering
> > an active mode, with the comment "Define the sign for X Y and Z axis".
> > This register is not listed in the documented register map but the
> > write is required for axes Y and Z to come out with the documented
> > orientation. v4 will add this write to chip_init().
> > 
> > If you have other measurements you'd like to see before v4, happy to
> > run them.
> >   
> >>  
> >>>   - Runtime PM with a 2 s autosuspend delay
> >>>   - System suspend/resume delegated to the runtime callbacks  
> > 
> > Best regards,
> > Hardik  
> 
> 

