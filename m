Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA57D340283;
	Sun, 27 Sep 2026 18:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790533741; cv=none; b=rW7L6zipM7zGQkA64GdvNRrjgR9VDFw8QSB5hc9CoXOJvKMs4b6B4aRPpSlQOEqoaqzBx6bf0BRojas7rZELzhwN1k6jwHM11J0ww0CZkaLqIlXP7XalVX60Mr6MJ3wGKH5pX+2jIxxPH4Ygrv9XUWH+FsYPUx6Dcu+TqhYESHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790533741; c=relaxed/simple;
	bh=5GVMJepg8ESigOUpTmktRKIJd6CMpbx0EWP1B/jPewM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TVdKsizpaoHn7ZbaeM7jiu8MHzwKgx6RKb5qPAvUaAIijLMX1ELqdmb8rh62yz/uuhE10zw/1EzWifpVlHyR+VSkiKfd5ybeoJmnmdRsxlXaQl4HDEkybWPVMVuJhrWgoAujlLthJPhRMX8ohlLhdUyfm2burUOkBHV/73u9owg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QrOa7y4X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QrOa7y4X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5DBB1F000FF;
	Sun, 27 Sep 2026 18:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790533739;
	bh=RHLyMOO1D0eh4OND1MqUWDj8WXGFb23RfmVyEcpgQkE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QrOa7y4XdptyJqMLUYdPguws2PUpNCBVjH39plc5sgNrtG4y0pJuZtpQBwdefzw07
	 Qf9fk8yTdtAmxJi5I466JOsRo57rFRv8vpd9nR1yPPpplplfk/rGXrW7+JaAVcc4Cg
	 mbSkiK4wR6I8EzKNTAD13sGoUdqpAG3cKutLk4YeoUFK/OeqIZMaRyXgWKm3H1pcpv
	 B3KBDuIzVxx84aRiFRiBq7xd65j9CRWqt+bkRnB2H5e/Q10RB9FBZsPS/EE08aJ6TV
	 G0pCqCtgVx7SFbs2a80L0s0Ag7+tYl++82i0JvCo+fA8p8phBStl5Dld3+hkfK7Q3z
	 mVYgokS1qLvig==
Date: Sun, 27 Sep 2026 19:28:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: adc: add driver for the MAX34417
 Four-Channel High Dynamic Range Power Accumulator
Message-ID: <20260927192854.5666b68e@jic23-hlaptop>
In-Reply-To: <7abb65ec-e212-4af9-aedc-0a62ed44d1c1@linaro.org>
References: <20260924-topic-sm8x50-iio-max34417-adc-v2-0-9a0609e72f5c@linaro.org>
	<20260924-topic-sm8x50-iio-max34417-adc-v2-2-9a0609e72f5c@linaro.org>
	<20260925042653.15608e9b@jic23-hlaptop>
	<7abb65ec-e212-4af9-aedc-0a62ed44d1c1@linaro.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Sep 2026 10:46:33 +0200
Neil Armstrong <neil.armstrong@linaro.org> wrote:

> Hi,
> 
> On 9/25/26 05:26, Jonathan Cameron wrote:
> > On Thu, 24 Sep 2026 15:14:16 +0200
> > Neil Armstrong <neil.armstrong@linaro.org> wrote:
> >   
> >> The MAX34417 is a specialized current and voltage monitor used to
> >> determine power consumption of portable systems. The driver support
> >> getting the channels voltage and accumulated average power over an
> >> I2C/SMBUS serial interface.
> >>
> >> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>  
> > 
> > A few comments inline.  For a new driver I'd wait a week before sending an
> > update. Whilst you've gotten quite a few reviews already it is good to make
> > sure any discussion has died down before moving on to the next version.
> > 
> > 
> > Thanks,
> > 
> > Jonathan
> >   
> >> diff --git a/drivers/iio/adc/max34417.c b/drivers/iio/adc/max34417.c
> >> new file mode 100644
> >> index 000000000000..98d961c5ecee
> >> --- /dev/null
> >> +++ b/drivers/iio/adc/max34417.c
> >> @@ -0,0 +1,374 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * IIO driver for Maxim MAX34417 ADC, 4-Channels High Dynamic Range Power Accumulator
> >> + *
> >> + * Datasheet: https://www.analog.com/en/products/max34417.html
> >> + *
> >> + * TODO: Slow Mode, Continuous Accumulate Mode, Park Feature, Bulk Update, Perr_Verr Correction
> >> + */  
> >   
> >> +#define MAX34417_CHANNEL(_index, _v_address, _power_address)	\
> >> +	{							\
> >> +		.type = IIO_VOLTAGE,				\
> >> +		.info_mask_separate	= BIT(IIO_CHAN_INFO_RAW) | \
> >> +					  BIT(IIO_CHAN_INFO_SCALE), \
> >> +		.channel = (_index),				\
> >> +		.address = (_v_address),			\
> >> +		.indexed = 1,					\
> >> +	},							\
> >> +	{							\
> >> +		.type = IIO_POWER,				\  
> > 
> > As below. This smells like it might not be an actual power channel if it
> > is accumulated on a fixed frequency.  It'll be some sort of scaled IIO_ENERGY
> > channel.  If you want to present it as power (which may make sense) then
> > it may need a little maths.  
> 
> So as I understand the ENERGY would need to provide Joules. Which would
> be doable if we take in account the accumulator sample rate (1024sps) from the
> datasheet.
> 
> But this implementation tries to provide an initial support following
> the MAX34417 datasheet which provides calculation for Average Power (page 18),
> this is why I sticked to POWER and IIO_CHAN_INFO_AVERAGE_RAW.

Doing division in driver is a bit nasty but given there are a lot of bits
I suppose that's not too bad.  I'd completely failed to notice the division 
on my first read through :(

So power is fine.

Thanks,

Jonathan

> 
> But you're right, knowing the sample rate we could indeed calculate the energy.
> 
> I can try to do the math, but with manual updates it may no be very accurate so
> the Continuous Accumulate Mode should be implemented to provide
> accurate Energy measurements over time and would be enabled via an
> IIO_CHAN_INFO_ENABLE.

