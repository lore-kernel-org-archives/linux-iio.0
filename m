Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A963F9A18;
	Fri, 15 May 2026 18:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778868112; cv=none; b=iZ4Wkx3vQNZYA9HhIuFiIMUEBtd5yEggNMjYaO/2fenrc70EIUFLQgdb2Q3pF8G0UGQEBz9YIMQmOPMSzRTHy98m1fSgY9A6eZ0E5gilyD0/bcDE/13HGQM3+yixxswMAhVYPClp3mDJfsiGezGaIt0TTzsWI2595ip1tXIkpmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778868112; c=relaxed/simple;
	bh=xmYf/YPTmkCZ+t09NgazYb7Z+oQhA12ZG0mDF/i775Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ohrNAJFZlfV8PW2yhdUwHLQqaHfaDEirBXpfTdFQTW0s+N37E2UBvAoXeifJuXsiouu5758Uh8ozv/QpnFURCyAMusnFU6e78A3CUdrg5lFVNCGn2xeowHfHNlg92uh5276zneaCK/BWzQ07IAS6Rta0exCfC0l7j3dAub6gWZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QdX87ovF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QdX87ovF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4ADDC2BCB0;
	Fri, 15 May 2026 18:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778868112;
	bh=xmYf/YPTmkCZ+t09NgazYb7Z+oQhA12ZG0mDF/i775Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QdX87ovFoEmiKJ9zc8biExCL6PGSkEPe2OP7xa/BS8TVlhryP0MHt+trXsHbpH0GK
	 +SATQsLnKAWv3P8XZNERh5m6t7/Dtkhds53boiWIUGFKmUJ51/CWBPscDmH6UF4Pmb
	 srHAdAUgDSlAV3ZMoaSyZfmNHNXWGWBdxqwbO4BzrHbQy7Fw01KlNWTOxXY5Z1dPn1
	 ObI7CPlGuQ0JUVLD4P660EAd/SHJwrfvhUlc1WVbZ7GWtX6TIjAA4xPocYcL9i5uMy
	 qG6juDSGYnxLg4K7mvEJ0PLNgkzgg8Jkalf83V70GgoPRgOaCLPhDAPbZeAtYfp+0i
	 iLDo0mkTBuT1w==
Date: Fri, 15 May 2026 19:01:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Aldo Conte <aldocontelk@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 shuah@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v2 4/5] iio: light: tcs3472: implement wait time and
 sampling frequency
Message-ID: <20260515190143.028e80a2@jic23-huawei>
In-Reply-To: <20260512223215.25596-5-aldocontelk@gmail.com>
References: <20260512223215.25596-1-aldocontelk@gmail.com>
	<20260512223215.25596-5-aldocontelk@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 May 2026 00:32:14 +0200
Aldo Conte <aldocontelk@gmail.com> wrote:

> The TCS3472 has a wait state controlled by the WEN bit in the ENABLE
> register and the WAIT register, with an additional WLONG bit in CONFIG
> that if set multiplies the wait step by 12. The driver previously
> defined TCS3472_WTIME but never used it leaving the TODO comment on
> the top of the source file.
> 
> Implement control of the wait time through IIO_CHAN_INFO_SAMP_FREQ:
> 
>   - Reading sampling_frequency returns the chip's current cycle time,
>     computed as the sum of ATIME, the fixed RGBC initialization time
>     and the wait time (which depends on WEN and WLONG).
> 
>   - Writing sampling_frequency programs WTIME so that the resulting
>     cycle period approximates the requested frequency. If the
>     requested frequency cannot be reached with any
>     non-zero wait time, WEN is disabled and the chip runs
>     back-to-back conversions at the maximum rate allowed by ATIME.
>     If the requested period exceeds the maximum WTIME range, WLONG
>     is enabled to extend the wait step from 2.4 ms to 28.8 ms.

Tidy up wrap of this paragraph. Can go to 75 chars.

> 
>   - The user's last requested frequency is stored in the driver's
>     private data so that subsequent changes to integration_time
>     recompute WTIME and preserve the requested sampling rate as
>     closely as possible.
> 
> Add TCS3472_ENABLE_WEN, TCS3472_ENABLE_RUN and TCS3472_CONFIG_WLONG
> bit definitions. TCS3472_ENABLE_RUN bundles the bits
> (AEN | PON | WEN) that are simultaneously set when the chip is in
> running state and cleared during powerdown, and is used by
> tcs3472_probe(), tcs3472_powerdown() and tcs3472_resume().
> 
> Remove the "TODO: wait time" comment at the top of the file.
> 
> Suggested-by: Andy Shevchenko <andy@kernel.org>
> Signed-off-by: Aldo Conte <aldocontelk@gmail.com>
A few comments inline though many may overlap with what Andy raised.

> ---
> v2:
> ( Suggested-by Andy )
> - Validation also rejects val > 0 with val2 < 0
> - cycle_us uses PSEC_PER_SEC (was USEC_PER_SEC * USEC_PER_SEC),
> - clamp() replaces manual WTIME bounds checks.
> - DIV_ROUND_CLOSEST_ULL() allows to avoid all the castings.
> - CONFIG read-modify-write uses a separate 'config' variable instead of the
>   ret = foo(ret).
> - Multi-line comments now follow kernel style.
> - Added comment explaining why wait_us can be negative.
> - target_freq_uhz uses div_u64() for 32-bit portability.
> - TCS3472_ENABLE_RUN introduced here with AEN | PON | WEN.
> - Test details moved to the cover letter.
> 
>  drivers/iio/light/tcs3472.c | 189 +++++++++++++++++++++++++++++++++---
>  1 file changed, 175 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/iio/light/tcs3472.c b/drivers/iio/light/tcs3472.c
> index 7a6dc8360326..f8f70399a4dc 100644
> --- a/drivers/iio/light/tcs3472.c
> +++ b/drivers/iio/light/tcs3472.c

> @@ -135,6 +159,100 @@ static int tcs3472_req_data(struct tcs3472_data *data)
>  	return 0;
>  }
>  
> +static int tcs3472_set_sampling_freq(struct tcs3472_data *data,
> +				     int val, int val2)
> +{
> +	unsigned int atime_us;
> +	unsigned int init_us = 2400;
> +	u64 cycle_us;
> +	s64 wait_us;
> +	int wtime;
> +	bool wlong = false;
> +	u8 config;
> +	int ret;
> +
> +	if (val < 0 || val2 < 0 || (val == 0 && val2 == 0))
> +		return -EINVAL;
> +
> +	guard(mutex)(&data->lock);
> +
> +	atime_us = (256 - data->atime) * 2400;
> +	cycle_us = div_u64((u64)PSEC_PER_SEC,

Sashiko points out truncation on these. as the divisor is 32 bit
Probably div64_u64()
https://sashiko.dev/#/patchset/20260512223215.25596-1-aldocontelk%40gmail.com

Check for other instances of this.
> +			   (u64)val * USEC_PER_SEC + val2);
> +
> +	/*
> +	 * wait_us can be negative or smaller than the minimum wait step
> +	 * (2400 us) when the requested frequency is too high to be reached.
> +	 * In that case, disable WEN so that the chip can perform back-to-back
> +	 * conversions at the maximum rate permitted by the current ATIME.
> +	 */
> +	wait_us = (s64)cycle_us - init_us - atime_us;
> +
> +	if (wait_us < 2400) {
> +		if (data->enable & TCS3472_ENABLE_WEN) {
> +			data->enable &= ~TCS3472_ENABLE_WEN;
In resume you unconditionally use ENABLE_RUN

Seems broken if you have previously passed through this path

> +			ret = i2c_smbus_write_byte_data(data->client,
> +							TCS3472_ENABLE,
> +							data->enable);
> +			if (ret < 0)
> +				return ret;
> +		}
> +
> +		data->target_freq_hz = val;
> +		data->target_freq_uhz = val2;
> +		return 0;
> +	}
> +
> +	/*
> +	 * Wait state is needed: make sure WEN is active before
> +	 * programming WTIME (and possibly WLONG).

Wrap to 80 when no strong reason to do differently.

> +	 */
> +	if (!(data->enable & TCS3472_ENABLE_WEN)) {
> +		data->enable |= TCS3472_ENABLE_WEN;
> +		ret = i2c_smbus_write_byte_data(data->client,
> +						TCS3472_ENABLE,
> +						data->enable);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	wtime = 256 - DIV_ROUND_CLOSEST_ULL(wait_us, 2400);
> +	if (wtime < 0) {
> +		wlong = true;
> +		wtime = 256 - DIV_ROUND_CLOSEST_ULL(wait_us, 28800);
> +	}
> +	wtime = clamp(wtime, 0, 255);
> +
> +	if (wlong != data->wlong) {
All this dancing to avoid writes would be better replaced with
regmap + regcache but that's a much bigger job.

> +		ret = i2c_smbus_read_byte_data(data->client, TCS3472_CONFIG);
> +		if (ret < 0)
> +			return ret;
> +
> +		config = ret;
> +		if (wlong)
> +			config |= TCS3472_CONFIG_WLONG;
> +		else
> +			config &= ~TCS3472_CONFIG_WLONG;
> +
> +		ret = i2c_smbus_write_byte_data(data->client, TCS3472_CONFIG,
> +						config);
> +		if (ret < 0)
> +			return ret;
> +
> +		data->wlong = wlong;
> +	}
> +
> +	ret = i2c_smbus_write_byte_data(data->client, TCS3472_WTIME, wtime);
> +	if (ret < 0)
> +		return ret;
> +
> +	data->wtime = wtime;
> +	data->target_freq_hz = val;
> +	data->target_freq_uhz = val2;
> +
> +	return 0;
> +}
> +
>  static int tcs3472_read_raw(struct iio_dev *indio_dev,
>  			   struct iio_chan_spec const *chan,
>  			   int *val, int *val2, long mask)
> @@ -165,6 +283,14 @@ static int tcs3472_read_raw(struct iio_dev *indio_dev,
>  		*val = 0;
>  		*val2 = (256 - data->atime) * 2400;
>  		return IIO_VAL_INT_PLUS_MICRO;
> +	case IIO_CHAN_INFO_SAMP_FREQ: {
> +		unsigned int cycle_us = tcs3472_cycle_time_us(data);
> +
> +		*val = USEC_PER_SEC / cycle_us;
> +		*val2 = div_u64((u64)(USEC_PER_SEC % cycle_us) * USEC_PER_SEC,
> +				cycle_us);
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	}
>  	}
>  	return -EINVAL;
>  }
> @@ -175,6 +301,7 @@ static int tcs3472_write_raw(struct iio_dev *indio_dev,
>  {
>  	struct tcs3472_data *data = iio_priv(indio_dev);
>  	int i;
> +	int ret;
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_CALIBSCALE:
> @@ -194,15 +321,29 @@ static int tcs3472_write_raw(struct iio_dev *indio_dev,
>  		if (val != 0)
>  			return -EINVAL;
>  		for (i = 0; i < 256; i++) {
> -			if (val2 == (256 - i) * 2400) {
> -				data->atime = i;
> -				return i2c_smbus_write_byte_data(
> -					data->client, TCS3472_ATIME,
> -					data->atime);
> -			}
> -
> +			if (val2 != (256 - i) * 2400)
> +				continue;
> +
> +			data->atime = i;
> +			ret = i2c_smbus_write_byte_data(data->client,
> +							TCS3472_ATIME,
> +							data->atime);
> +			if (ret < 0)
> +				return ret;
> +
> +			/*
> +			 * ATIME just changed, so the cycle time changed too.
> +			 * Re-run the sampling frequency logic to recompute
> +			 * WTIME and preserve the user's last requested
> +			 * frequency.
> +			 */
> +			return tcs3472_set_sampling_freq(data,
> +							 data->target_freq_hz,
> +							 data->target_freq_uhz);
>  		}
>  		return -EINVAL;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		return tcs3472_set_sampling_freq(data, val, val2);
>  	}
>  	return -EINVAL;
>  }
> @@ -429,13 +570,12 @@ static const struct iio_info tcs3472_info = {
>  
>  static int tcs3472_powerdown(struct tcs3472_data *data)
>  {
> -	u8 enable_mask = TCS3472_ENABLE_AEN | TCS3472_ENABLE_PON;
>  	u8 value;
>  	int ret;
>  
>  	guard(mutex)(&data->lock);
>  
> -	value = data->enable & ~enable_mask;
> +	value = data->enable & ~TCS3472_ENABLE_RUN;
>  
>  	ret = i2c_smbus_write_byte_data(data->client, TCS3472_ENABLE, value);
>  	if (ret)
> @@ -456,6 +596,7 @@ static int tcs3472_probe(struct i2c_client *client)
>  	struct device *dev = &client->dev;
>  	struct tcs3472_data *data;
>  	struct iio_dev *indio_dev;
> +	unsigned int cycle_us;
>  	int ret;
>  
>  	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> @@ -494,6 +635,16 @@ static int tcs3472_probe(struct i2c_client *client)
>  		return ret;
>  	data->atime = ret;
>  
> +	ret = i2c_smbus_read_byte_data(data->client, TCS3472_WTIME);
> +	if (ret < 0)
> +		return ret;
> +	data->wtime = ret;
> +
> +	ret = i2c_smbus_read_byte_data(data->client, TCS3472_CONFIG);
> +	if (ret < 0)
> +		return ret;
> +	data->wlong = !!(ret & TCS3472_CONFIG_WLONG);

!! is kind of frowned upon though it is common in older kernel code.
Linus once got quite grumpy about it being tricky to read ;)

? 1 : 0; probably given driver isn't using FIELD_GET()/_PREP()


> +
>  	ret = i2c_smbus_read_word_data(data->client, TCS3472_AILT);
>  	if (ret < 0)
>  		return ret;
> @@ -515,13 +666,24 @@ static int tcs3472_probe(struct i2c_client *client)
>  		return ret;
>  
>  	/* enable device */
> -	data->enable = ret | TCS3472_ENABLE_PON | TCS3472_ENABLE_AEN;
> +	data->enable = ret | TCS3472_ENABLE_RUN;
>  	data->enable &= ~TCS3472_ENABLE_AIEN;
>  	ret = i2c_smbus_write_byte_data(data->client, TCS3472_ENABLE,
>  		data->enable);
>  	if (ret < 0)
>  		return ret;
>  
> +	/*
> +	 * Initialize target frequency from the chip's current state so
> +	 * that subsequent integration_time changes via IIO_CHAN_INFO_INT_TIME
> +	 * can preserve a meaningful sampling rate, even before userspace
> +	 * writes sampling_frequency for the first time.
Slightly odd wrap. Go to 80 chars for comments.

	 * Initialize target frequency from the chip's current state so that
	 * subsequent integration_time changes via IIO_CHAN_INFO_INT_TIME can
	 * preserve a meaningful sampling rate, even before userspace writes
	 * sampling_frequency for the first time.

It's one of those things where it doesn't really matter what the standard is
as long as we keep to it as visual consistency is always good for readability.
> +	 */
> +	cycle_us = tcs3472_cycle_time_us(data);
> +	data->target_freq_hz = USEC_PER_SEC / cycle_us;
> +	data->target_freq_uhz = div_u64((u64)(USEC_PER_SEC % cycle_us) *
> +					USEC_PER_SEC, cycle_us);

I see Andy already queried the maths here. I was about to do the same
as I'm failing to follow it.

> +
>  	ret = devm_add_action_or_reset(dev, tcs3472_powerdown_action, data);
>  	if (ret)
>  		return ret;
