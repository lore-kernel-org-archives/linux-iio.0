Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374FD36494C;
	Sat, 22 Aug 2026 23:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787440760; cv=none; b=O5k2UoTt91Hi7PkJn0nqsibaF864j+G8QrNw9HHcIJfCt78tzXqdxmTlKh62OJvran8Fu5AJx8KNgPPAmDXOWbAJmYZKxe+XMReBxJ4sJ3TXdfvKVtIEfrFxSHyjoLvR3gTXxtYyzHSWx+VlThTQjYKZ/OWtz7uw8xkiT8ri6F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787440760; c=relaxed/simple;
	bh=iTNn/wx8y9kAF/EoPE4gTdq35A64lM5ViD6uD93o6mo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S4epQOY3FWkAJL1b1WXQwKE/gfHjLVTy5h/PStwwlqB5fsnGTnqS7J4pezJbNqg08f0lawTgKDQzmg9Pi/Hw1Xdu9Y7p52eSG83XX/Pk0sAcRzEdOK6mH4nt7suhqfBbP1pXaDq2m5U4tYW3YMidKvH9/n7+J5oU/LyTCcCpIzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MqGFCHpk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MqGFCHpk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37DC61F000E9;
	Sat, 22 Aug 2026 23:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787440759;
	bh=6P+VD6Wr3pBvBk6FazNXOzw+cHrUvsz9Hac2cAAkZsM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=MqGFCHpkRM9VClo3POL4FJAxpWZ4Zb76iuzvA5rXFc7cmNTZyWQ6HcTNT17mIoQJm
	 WgKwjY4mMLJ5mfypgdMZhsRDTZ3mI2CF/GMipQDc+VhBhcXelVpgI41PBOaX35ALAv
	 +0LzCYQMhGgYKFWHWRZZjjkj0rHPjneU9qow9M/eoso9NPxMTv97Cjv8IYKVykLfkv
	 jwNzXBcOTMJsiacla+mzkJbtOhWd1J/kE80H0jw/XTz68QCi9wF3shQ2jWV43Sbkr+
	 nA4fh4xL1TIlTa7wOZb84XE99GCObjkVXyEoaeHIxDVjIpxEs9b9zmHtbV8gt6450b
	 B1jiD2kf5F3jQ==
Date: Sun, 23 Aug 2026 00:19:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rupesh Majhi <zoone.rupert@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Eddie James <eajames@linux.ibm.com>, Joel Stanley
 <joel@jms.id.au>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] iio: pressure: dps310: add triggered buffer
 support
Message-ID: <20260823001914.224aba09@jic23-huawei>
In-Reply-To: <20260817170725.1074078-3-zoone.rupert@gmail.com>
References: <20260817170725.1074078-1-zoone.rupert@gmail.com>
	<20260817170725.1074078-3-zoone.rupert@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Aug 2026 20:07:24 +0300
Rupesh Majhi <zoone.rupert@gmail.com> wrote:

> Add triggered buffer support so pressure and temperature can be captured
> into a buffer instead of only through one-shot sysfs reads. The device
> measures continuously in background mode, so a capture is just a read of
> the latest results and no buffer setup ops are needed.
> 
> Pressure has to be computed from the raw register value with the
> compensation polynomial in section 4.9.1 of the datasheet, which also
> needs a temperature reading. To keep full resolution in the buffer
> without disagreeing with the unit the existing processed attribute
> reports, add raw and scale attributes for pressure, raw in Pa and scale
> 1/1000 to convert to kPa. The channel definition carries a comment
> explaining why it is done this way here and why it should not be copied
> into other drivers.
> 
> Temperature is already a full resolution value in its base unit of
> millidegrees Celsius, so it stays a processed channel.
> 
> Either channel can be enabled on its own. Temperature is always sampled
> because the pressure compensation needs it, but only the enabled channels
> are pushed to the buffer.
> 
> The raw read helpers are split into variants that expect the lock to be
> held, so the trigger handler takes the lock once per scan instead of once
> per value. That also lets dps310_calculate_pressure() drop its
> mutex_trylock() dance, as the temperature refresh now always happens
> under the caller's lock instead of only when the lock happened to be
> free.
> 
> Sysfs sample reads and reconfiguration return -EBUSY while the buffer is
> enabled, since they share the capture path's values and configuration.
> 
> Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
> ---
>  drivers/iio/pressure/Kconfig  |   2 +
>  drivers/iio/pressure/dps310.c | 305 ++++++++++++++++++++++++++--------
>  2 files changed, 242 insertions(+), 65 deletions(-)
> 
> diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
> index 838a8340c4c0..cef8b90b9ae7 100644
> --- a/drivers/iio/pressure/Kconfig
> +++ b/drivers/iio/pressure/Kconfig
> @@ -112,6 +112,8 @@ config DPS310
>  	tristate "Infineon DPS310 pressure and temperature sensor"
>  	depends on I2C
>  	select REGMAP_I2C
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
>  	help
>  	  Support for the Infineon DPS310 digital barometric pressure sensor.
>  	  It can be accessed over I2C bus.
> diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
> index 68382960382f..0d6e65766469 100644
> --- a/drivers/iio/pressure/dps310.c
> +++ b/drivers/iio/pressure/dps310.c


>  	{
>  		.type = IIO_PRESSURE,
> +		/*
> +		 * Pressure is only meaningful once the raw register value has
> +		 * been run through the compensation polynomial in section 4.9.1
> +		 * of the datasheet, which needs a temperature reading as well.
> +		 * So what is reported as _raw here is already compensated, in
> +		 * Pa, and _scale converts it to the kPa the ABI asks for. The
> +		 * _processed attribute reports the same value and predates
> +		 * buffer support, so it has to stay.
> +		 *
> +		 * Please do not copy this pattern into other drivers. A raw

Drop the Please! 
		 * Do not copy ...

> +		 * attribute that is not the raw register value is only
> +		 * tolerable here because the alternative is either losing
> +		 * resolution in the buffer or breaking existing users of
> +		 * _processed.
> +		 */
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) |
>  			BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> -			BIT(IIO_CHAN_INFO_PROCESSED),
> +			BIT(IIO_CHAN_INFO_PROCESSED) |
> +			BIT(IIO_CHAN_INFO_RAW) |
> +			BIT(IIO_CHAN_INFO_SCALE),
> +		.scan_index = DPS310_SCAN_PRESSURE,
> +		.scan_type = {
> +			.sign = 's',
> +			.realbits = 32,
> +			.storagebits = 32,
> +			.endianness = IIO_CPU,
> +		},
>  	},
> +	IIO_CHAN_SOFT_TIMESTAMP(2),
>  };
>  
>  /* To be called after checking the COEF_RDY bit in MEAS_CFG */
> @@ -463,7 +503,8 @@ static int dps310_ready(struct dps310_data *data, int ready_bit, int timeout)
>  	return 0;
>  }
>  
> -static int dps310_read_pres_raw(struct dps310_data *data)
> +/* Called with lock held */

Use the sparse markings to make it clear and testable - thus not needing the
comment. __must_hold(&data->lock) 



> +static int dps310_read_pres_raw_locked(struct dps310_data *data)
>  {
>  	int rc;
>  	int rate;
> @@ -471,30 +512,25 @@ static int dps310_read_pres_raw(struct dps310_data *data)
>  	s32 raw;
>  	u8 val[3];
>  
> -	if (mutex_lock_interruptible(&data->lock))
> -		return -EINTR;
> -
>  	rc = dps310_get_pres_samp_freq(data, &rate);
>  	if (rc)
> -		goto done;
> +		return rc;
>  
>  	timeout = DPS310_POLL_TIMEOUT_US(rate);
>  
>  	/* Poll for sensor readiness; base the timeout upon the sample rate. */
>  	rc = dps310_ready(data, DPS310_PRS_RDY, timeout);
>  	if (rc)
> -		goto done;
> +		return rc;
>  
>  	rc = regmap_bulk_read(data->regmap, DPS310_PRS_BASE, val, sizeof(val));
>  	if (rc < 0)
> -		goto done;
> +		return rc;
>  
>  	raw = (val[0] << 16) | (val[1] << 8) | val[2];

Can we take the opportunity to make this get_unaligned_be24() which 
I think ends up as the same thing?

>  	data->pressure_raw = sign_extend32(raw, 23);
>  
> -done:
> -	mutex_unlock(&data->lock);
> -	return rc;
> +	return 0;
>  }
>  
>  /* Called with lock held */
> @@ -514,31 +550,45 @@ static int dps310_read_temp_ready(struct dps310_data *data)
>  	return 0;
>  }
>  
> -static int dps310_read_temp_raw(struct dps310_data *data)
> +/* Called with lock held */

As above.  Same for all the other cases where you have a comment
saying a lock must be held.

> +static int dps310_read_temp_raw_locked(struct dps310_data *data)

...


> +/*
> + * Sample the pressure and compensate it. Shared by the raw and processed
> + * attributes, which report the same value in different units, and takes the
> + * lock once for the whole sequence.
> + */
> +static int dps310_read_pressure_value(struct dps310_data *data, int *val)
> +{
> +	int rc;
> +
> +	ACQUIRE(mutex_intr, lock)(&data->lock);
> +	if (ACQUIRE_ERR(mutex_intr, &lock))
> +		return -EINTR;
> +
> +	rc = dps310_read_pres_raw_locked(data);
> +	if (rc)
> +		return rc;
> +
> +	dps310_refresh_temp_locked(data);
> +
> +	return dps310_calculate_pressure(data, val);

A lot of this seems to be rework that you could pull out ahead of
the stuff that adds buffered support.  That might be worth doing
to create two simpler and easier to review patches.

> +}
> +
> +static irqreturn_t dps310_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *iio = pf->indio_dev;
> +	struct dps310_data *data = iio_priv(iio);
> +	/*
> +	 * Either channel can be enabled on its own, so the offset of the second
> +	 * value depends on the scan mask and the layout cannot be described
> +	 * with a structure. Sized for both 32-bit channels plus the timestamp.
> +	 */
> +	u8 buffer[16] __aligned(8) = { };
> +	int rc = 0;
> +
> +	scoped_guard(mutex, &data->lock)
It isn't necessary to use guard/scoped_guard() for all locks in a driver
if they actually hurt readability.  I think that is the case here.

	mutex_lock(&data->lock);
	rc = dps310...
	mutex_unlock(&data->lock);
	ir (rc)
		goto err;

	iio_push_to_buffers_with_ts();

err:
	iio_trigger_notify_done();
	
	return IRQ_HANDLED;

Is (to my eyes) easier to read.


> +		rc = dps310_fill_scan(iio, buffer);
> +
> +	if (!rc)
> +		iio_push_to_buffers_with_ts(iio, buffer, sizeof(buffer),
> +					    pf->timestamp);
> +
> +	iio_trigger_notify_done(iio->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
>  static void dps310_reset(void *action_data)
>  {
>  	struct dps310_data *data = action_data;
> @@ -877,6 +1042,16 @@ static int dps310_probe(struct i2c_client *client)
>  	if (rc)
>  		return rc;
>  
> +	/*
> +	 * The device measures continuously in background mode, so a capture is
> +	 * just a read of the latest results and no buffer setup ops are needed.
> +	 */
> +	rc = devm_iio_triggered_buffer_setup(&client->dev, iio,
> +					     iio_pollfunc_store_time,

Given you are driving this from a trigger that isn't aligned with actual data acquisition
there is no point in using iio_pollfunc_store_time().  You can just grab a timestamp
directly in dps310_trigger_handler.  That has the added advantage of making this
compatible with triggers that use iio_poll_trigger_nested().

> +					     dps310_trigger_handler, NULL);
> +	if (rc)
> +		return rc;
> +
>  	rc = devm_iio_device_register(&client->dev, iio);
>  	if (rc)
>  		return rc;

