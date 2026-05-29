Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A6A383C86;
	Fri, 29 May 2026 17:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780075912; cv=none; b=WxMOXfE+kcvP5PW7Z2+ILUjnNFsDPfR42GG1VqGCqqzShhYL3ImMTG8q4I6lh6Hm/Z6vYvbdigay8GuZgQCafbr3sxEkagLY5CnE+QN6RJ1tmEV60D57RtdTqDdxM80/P+BB0q5dumjl6dcSZuEbMJYU7F5ZA6HZu1g95JL8Ln4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780075912; c=relaxed/simple;
	bh=yvpKqXUXWgwl/CXrubwtUAyBK39CPrhg3hqu0Neyu1U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=St3IX58LVI8tADCC3Lk7hQyfdCWB39KQiF52yVY83SlqyOqHKHyXQWbiXkG8BHpFIV2giE0PUMT3PXGiAzjwkgsK3Qkr/HutEizuQ7GLqMCZBUxcSo8l6aAOs2YOjeYI5NOFST76b5GX5TXaaGh7Yr8kx7E4fZ0JV+nNetrKwxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gETYYk5r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gETYYk5r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFC481F00893;
	Fri, 29 May 2026 17:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780075911;
	bh=y1FIYPPkCwKJ1+MIoSiwDm1jLE4JIC7+J/rfdFnHf1k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gETYYk5rW2y8N7VA1WSZpxxa9AA3xbEgx7MeyItbeWvGW3X2mFxq9ANElQohEhzT5
	 PAdIfkgO5MPMYwZP+Obmx5d/vF3w0EDQqg1LogUpBDd/nLjTGyn6uHlNw6bzFqtHg9
	 80m7xz9Wxtnn5XU3SP92lgUGpP3ejtE7Jhv1sl0cRc98LRqzdHUm3HR5QIvdu03Fdk
	 SidpS4MQOviGg7EghaTsgcKgg5EGNrF+mWzmZhVSu87gPOvUIodoDgKHt6WRNOfDaV
	 rfSVHNkUprQIQnsQcXQc0smfWEg/xrgOe9YeypRLgkyOnW6nC9mvBPsdZ34WhQSgHa
	 uzQt+py9RJgNg==
Date: Fri, 29 May 2026 18:31:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 nuno.sa@analog.com, Michael.Hennerich@analog.com, dlechner@baylibre.com,
 andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 pop.ioan-daniel@analog.com
Subject: Re: [PATCH v2 2/4] iio: adc: ltc2378: Add support for LTC2378-20
 and similar ADCs
Message-ID: <20260529183141.4a8e236b@jic23-huawei>
In-Reply-To: <ahmIbL8sIwXaysff@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1779976379.git.marcelo.schmitt@analog.com>
	<40e1108bc9eaeba486705b54c4c94004f0e7f369.1779976379.git.marcelo.schmitt@analog.com>
	<20260529110205.2f91a1ed@jic23-huawei>
	<ahmIbL8sIwXaysff@debian-BULLSEYE-live-builder-AMD64>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 May 2026 09:37:00 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> On 05/29, Jonathan Cameron wrote:
> > On Thu, 28 May 2026 12:03:52 -0300
> > Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:
> >   
> > > Support for LTC2378-20 and similar analog-to-digital converters.
> > > 
> > > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>  
> >   
> ...
> > >  
> > > +config LTC2378
> > > +	tristate "Analog Devices LTC2378 ADC driver"
> > > +	depends on SPI
> > > +	depends on GPIOLIB || PWM  
> > 
> > Triggered sashiko:
> > https://sashiko.dev/#/patchset/cover.1779976379.git.marcelo.schmitt%40analog.com
> > This dependency is odd enough that I think I'd add a comment on why.
> > Also bring in the dependency on PWM in the patch that needs it not this one.
> > 
> > Will it build without gpiolib? If so I'd prefer that to be a || COMPILE_TEST
> > just to get a little more coverage.
> >   
> The intent was to allow using the ADC with offload PWM triggered setup
> even if the GPIO is not provided/enabled. We would be able to do the buffered
> reads, but the single-shot read would be debatable since we would very likely
> trigger many conversions in between a pwm_enable()/pwm_disable(). In the doubt,
> I left the single-read procedure untouched specially because there's also the
> case where the GPIO is there and so the single-read would work normally.
> 
>      +-------------+         +-------------+
>      |         CNV |<-----+--| GPIO        |
>      |             |      +--| PWM0        |
>      |             |         |             |
>      |             |      +--| PWM1        |
>      |             |      |  +-------------+
>      |             |      +->| TRIGGER     |
>      |             |         |             |
>      |     ADC     |         |    SPI      |
>      |             |         | controller  |
>      |             |         |             |
>      |         SDI |<--------| SDO         |
>      |         SDO |-------->| SDI         |
>      |        SCLK |<--------| SCLK        |
>      +-------------+         +-------------+
> 
> Maybe I'm going too much flexible trying to allow all those combinations?
> Simplest way to avoid what sashiko points as garbage read is to go straight
> 'depends on GPIOLIB' and check the GPIO must always be there.

Yes. I'd do that.  Almost no one will build without that anyway.

Does the code remove the single read if the gpio isn't available?
Sounds like it probably should.

> 
> >   
> ...
> > > +static int ltc2378_convert_and_acquire(struct ltc2378_state *st)
> > > +{
> > > +	int ret;
> > > +
> > > +	/* Cause a rising edge of CNV to initiate a new ADC conversion */
> > > +	gpiod_set_value_cansleep(st->cnv_gpio, 1);  
> > 
> > Should we check for errors on setting the gpio?
> >   
> > > +	fsleep(4);
> > > +	ret = spi_sync_transfer(st->spi, &st->xfer, 1);
> > > +	gpiod_set_value_cansleep(st->cnv_gpio, 0);
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +static int ltc2378_channel_single_read(const struct iio_chan_spec *chan,
> > > +				       struct ltc2378_state *st, int *val)
> > > +{
> > > +	const struct iio_scan_type *scan_type = &chan->scan_type;
> > > +	u32 sample;
> > > +	int ret;
> > > +
> > > +	ret = ltc2378_convert_and_acquire(st);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	if (scan_type->realbits > 16)
> > > +		sample = st->scan.data.sample_buf32;  
> > 
> > Sashikio has an interesting theory here that you need a shift. I can't immediately
> > spot why it is wrong.  Given we are clocking in 32bits I assume the first
> > res_bits are valid then we get a bunch of garbage after that. Given it's MSB first
> > the SPI controller should put those in the top bits of the resulting u32 with the
> > garbage at the bottom. So shouldn't we shift them down by 32 - resolution or something
> > like that? + in buffered case provide the relevant shift value (in later patches)
> >   
> The only way I'm seing to get sample_buf32 with ADC data in the MSB is if the
> CPU endianness is BE. Otherwise (LE), the data bits would be put into the lower
> addresses when SPI puts the word in CPU endianness.

We aren't talking addreses here we are talking about handling of a 4 byte s32
(which is also what the sign extend is operating on).

> But, if we do unconditional
> shift, won't that break sign_extend32() for LE CPUs? Well, I'll anyway double
> check the data for all sample_buf16/sample_buf32 buffer/non-buffer use cases.

It's operating on an s32 so say we extend 0xfabc from bit 15

be is 

[0x00] [0x00] [0xfa] [0xbc] =>  [0xff] [0xff] [0xfa] [0xbc]

le

[0xbc] [0xfa] [0x00] [0x00] =>  [0xbc] [0xfa] [0xff] [0xff]

Which are both 0xfffffabc as an s32 (in hex obviously)

Arguement in this case is the value is actually in the top few
bytes so the ones that are 0 in the example above.


> 
> > > +	else
> > > +		sample = st->scan.data.sample_buf16;
> > > +
> > > +	if (scan_type->format == IIO_SCAN_FORMAT_SIGNED_INT)
> > > +		*val = sign_extend32(sample, scan_type->realbits - 1);
> > > +	else
> > > +		*val = sample;
> > > +
> > > +	return 0;
> > > +}
> > > +  
> ...
> 
> > case IIO_CHAN_INFO_RAW: {
> >   
> > > +		IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
> > > +		if (IIO_DEV_ACQUIRE_FAILED(claim))
> > > +			return -EBUSY;
> > > +
> > > +		ret = ltc2378_channel_single_read(chan, st, val);
> > > +		if (ret)
> > > +			return ret;
> > > +
> > > +		return IIO_VAL_INT;
> > > +  
> > }
> > 
> > As that IIO_DEV_ACQUIRE_DIRECT_MODE() is declaring a local variable
> > so there is something go out of scope and result in cleanup.
> > LLVM moans about this, GCC just does the wrong thing which can in theory
> > at least result in an underflow.
> > You'll get build bot warnings on this - bug sashiko caught it.
> >   
> 
> Oops I guess I started mis-squashing commits after a certain number of rebases XD

Happens to us all.  Always do a last sanity check with an LLVM build
(it finds way more than GCC currently!) one patch at a time.

> Will fix this and all other suggestions.
> 
> Thanks

