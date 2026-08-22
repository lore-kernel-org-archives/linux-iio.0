Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4483327E05F;
	Sat, 22 Aug 2026 23:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787441613; cv=none; b=gllU8GwATmczogbWi2Cx6K6hmRex33MViAEtE7rkJQZwQdUkF6dkXxd438/xwVEF2CwiwHVzdFegjPxX3qCd5g0dQohekNvP2vtglxUfufgMAXQp52JhW4CFh3G24hwQmfTKBv6UKnr+yyzxt0wkHaJTo7AGl7P2Ivnvgi2Ijhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787441613; c=relaxed/simple;
	bh=LZ50PG04SaGfDj+ehkuuvQhmgEesF11W9CiQ1gYGlPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UuJReN9sp6ZRBnKLPjxsp0qEbV2YNUeQ2Tvit/TsL4rf+0i5OHA4RgwofHWA1JquvRjuzXx93zNnpzBiCvs24+BNstWu3Vjsl0EznGPTYn3J12cCzvkKt7DBqB4Nl4IpfErqHm5O9CHgETEUD5MNEsbr2yCNVwJ7vvbfPi0FEug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JOzwmtov; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JOzwmtov"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98F6B1F000E9;
	Sat, 22 Aug 2026 23:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787441611;
	bh=F1Hrw0jLl4OC6mdJJf2Cks+HGFEr0AAVLzV7TnmCUmE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JOzwmtovTJRrUeOl3kiSoEGdhR992VxX3uQ2q+TiiZsShDK7WyQO061QLLiEe1Vvg
	 5htQED2es/la2Etr4oMlFqCbQTyhNpUMocUoOUEv2y+8sPNp1LzmNWcxkkftL00BBl
	 hMtzhL5ddiX1VFHcFmFa2ica3LzjnB7g13cHjlxnz5u3bmgs65qja3ml7YbgrCEApM
	 p1rme365UPquFLLSojP8LbltxxbHoRl2wObIi1+pTpge7yrFimQI9GMimvW/3A+dUt
	 qPvqxbgtnJfdDjP27k8swpNev5JshEiRg8TdbkRCPjEH/kGjjLRXlFO1I7X01VW48R
	 joPCJAZ1VbaiA==
Date: Sun, 23 Aug 2026 00:33:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rupesh Majhi <zoone.rupert@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Eddie James <eajames@linux.ibm.com>, Joel Stanley
 <joel@jms.id.au>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] iio: pressure: dps310: add hardware FIFO support
Message-ID: <20260823003328.37645f05@jic23-huawei>
In-Reply-To: <20260817170725.1074078-4-zoone.rupert@gmail.com>
References: <20260817170725.1074078-1-zoone.rupert@gmail.com>
	<20260817170725.1074078-4-zoone.rupert@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Aug 2026 20:07:25 +0300
Rupesh Majhi <zoone.rupert@gmail.com> wrote:

> The DPS310 has a 32 entry FIFO, shared between the pressure and
> temperature streams, which the driver has never used. Enable it for
> buffered capture so a reader is woken once per batch of samples rather
> than once per sample.
> 
> The FIFO is used when no external trigger is attached, and left disabled
> in favor of the trigger when one is. That selection needs no policy of
> its own: iio_verify_update() already picks INDIO_BUFFER_TRIGGERED when a
> trigger is present and INDIO_BUFFER_SOFTWARE when it is not, so both
> modes are advertised and the buffer setup ops branch on
> iio_device_get_current_mode(). This follows
> drivers/iio/pressure/rohm-bm1390.c.
> 
> The drain is timer driven rather than interrupt driven. The binding has
> no interrupts property and no in-tree device tree wires the INT pin, so
> there is no interrupt to use. hwfifo_flush_to_buffer alone is not enough
> either: iio_buffer_read() sleeps on rb->pollq with no timeout and only a
> push wakes it, so a blocking reader would hang with samples sitting in
> the hardware. The flush hook is still provided so poll() and
> non-blocking readers can pull early. It stops at the read rather than
> after it when the caller limits the count, because entries leave the
> hardware as they are read and any collected past the limit would have to
> be discarded.
> 
> Because the hardware stops recording when the FIFO is full instead of
> overwriting, a late drain loses the newest samples rather than the
> oldest, so the interval is kept below half the time the FIFO takes to
> fill. The DPS310 has no configurable hardware watermark, only a
> FIFO-full condition, so the value passed to hwfifo_set_watermark() is
> taken as the number of scans the user is prepared to wait for and bounds
> the interval from the other side.
> 
> Entries carry no timestamps. They are synthesised by working back from
> the drain at the configured sample period, anchored so that a batch
> never starts before the previous one ended. Where a drain collected more
> than the configured rate accounts for, the batch is spread across the
> window instead so the timestamps stay monotonic. These are estimates,
> not hardware timestamps.
> 
> Every entry is read through the pressure registers whichever measurement
> produced it, with the type tagged in the LSB and 0x800000 returned once
> the FIFO is empty. Pressure entries drive the scans and reuse the most
> recent temperature entry for compensation, which keeps the two
> configured rates independent; pressure entries arriving before any
> temperature cannot be compensated and are dropped. With only the
> temperature channel enabled there is nothing to pair with, so
> temperature drives the scans itself, and both the drain and the
> watermark-to-interval conversion follow whichever rate is driving.
> 
> The file header still claimed only a single temperature read was
> supported, which this patch is the last word against, so it goes too.
> 
> Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
Hi Rupesh
Various comments inline.

thanks

Jonathan

> ---
>  drivers/iio/pressure/dps310.c | 413 +++++++++++++++++++++++++++++++++-
>  1 file changed, 404 insertions(+), 9 deletions(-)
> 

>  
>  enum dps310_scan_index {
> @@ -962,6 +990,344 @@ static int dps310_fill_scan(struct iio_dev *iio, u8 *buffer)
>  	return 0;
>  }
>  
> +/* Called with lock held */
> +static int dps310_fifo_hw_flush(struct dps310_data *data)
> +{
> +	return regmap_write(data->regmap, DPS310_RESET, DPS310_FIFO_FLUSH);
> +}
> +
> +/* Called with lock held */

Get rid of all documentation that calls out simply that expectation
is that a lock is held.

> +static int dps310_fifo_set_enable(struct dps310_data *data, bool enable)
> +{
> +	return regmap_write_bits(data->regmap, DPS310_CFG_REG, DPS310_FIFO_EN,
> +				 enable ? DPS310_FIFO_EN : 0);
> +}
> +
> +/*
> + * There is no interrupt wired on any in-tree platform and the binding has no
> + * interrupts property, so the FIFO is drained on a timer. The interval has to
> + * stay below the time the FIFO takes to fill, because the hardware stops
> + * recording when full instead of overwriting: draining late loses the newest
> + * samples rather than the oldest.
> + *
> + * Called with lock held.
> + */
> +static int dps310_fifo_interval(struct dps310_data *data, unsigned int *ms)
> +{
> +	bool pressure_enabled = test_bit(DPS310_SCAN_PRESSURE,
> +					 data->iio->active_scan_mask);
> +	unsigned int fill_ms, want_ms;
> +	int rc, prs_rate, tmp_rate;
> +
> +	rc = dps310_get_pres_samp_freq(data, &prs_rate);
> +	if (rc)
> +		return rc;
> +
> +	rc = dps310_get_temp_samp_freq(data, &tmp_rate);
> +	if (rc)
> +		return rc;
> +
> +	/* Both streams share the same entries, so they fill it together. */
> +	fill_ms = MSEC_PER_SEC * DPS310_FIFO_DEPTH / (prs_rate + tmp_rate);
> +
> +	/*
> +	 * The DPS310 has no configurable hardware watermark, only a FIFO-full
> +	 * condition, so the watermark is taken as the number of scans the user
> +	 * is prepared to wait for and drives the drain interval instead. Scans
> +	 * come at the rate of whichever measurement drives them, which is not
> +	 * the pressure rate when only the temperature channel is enabled.
> +	 */
> +	want_ms = data->watermark * MSEC_PER_SEC /
> +		  (pressure_enabled ? prs_rate : tmp_rate);
> +
> +	*ms = clamp_t(unsigned int, min(want_ms, fill_ms / 2),

Not immediately obvious to me why clamp() doesn't work.

> +		      DPS310_DRAIN_MIN_MS, DPS310_DRAIN_MAX_MS);
> +
> +	return 0;
> +}
> +
> +/*
> + * Read a single FIFO entry. Returns 1 if a sample was read, 0 once the FIFO is
> + * empty, or a negative error. Called with lock held.
> + */
> +static int dps310_fifo_read_entry(struct dps310_data *data, s32 *value,
> +				  bool *is_pressure)
> +{
> +	u8 val[3];
> +	s32 raw;
> +	int rc;
> +
> +	/*
> +	 * Every entry is read through the pressure registers regardless of
> +	 * which measurement produced it, with the type tagged in the LSB.
> +	 */
> +	rc = regmap_bulk_read(data->regmap, DPS310_PRS_BASE, val, sizeof(val));
> +	if (rc < 0)
> +		return rc;
> +
> +	raw = (val[0] << 16) | (val[1] << 8) | val[2];

get_unaligned_be24() ?

> +	if (raw == DPS310_FIFO_EMPTY_VAL)
> +		return 0;
> +
> +	*is_pressure = raw & DPS310_FIFO_TAG_PRS;
> +	*value = sign_extend32(raw, 23);
> +
> +	return 1;
> +}
> +
> +/* Called with lock held */
> +static int dps310_fifo_push_scan(struct dps310_data *data, s32 temp_raw,
> +				 s32 pressure_raw, s64 timestamp)
> +{
> +	struct iio_dev *iio = data->iio;
> +	u8 buffer[16] __aligned(8) = { };
Given this is a 16 byte buffer the possible timestamp position is fixed
however many channels are enabled. So you can use a structure

	strut scan {
		s32 channels[2];
		aligned_s64 ts;
	};

This should simplify the code below by allowing direct assignments where appropriate
rather than memcpys.

> +	int pos = 0, rc;
> +	s32 value;
> +
> +	/*
> +	 * The compensation helpers read the cached raw values. Sysfs reads take
> +	 * the direct-mode claim, so they cannot be looking at these while a
> +	 * buffered capture is running.
> +	 */
> +	data->temp_raw = temp_raw;
> +	data->pressure_raw = pressure_raw;
> +
> +	if (test_bit(DPS310_SCAN_TEMP, iio->active_scan_mask)) {
> +		rc = dps310_calculate_temp(data, &value);
> +		if (rc)
> +			return rc;
> +
> +		memcpy(&buffer[pos], &value, sizeof(value));
> +		pos += sizeof(value);
> +	}
> +
> +	if (test_bit(DPS310_SCAN_PRESSURE, iio->active_scan_mask)) {
> +		rc = dps310_calculate_pressure(data, &value);
> +		if (rc)
> +			return rc;
> +
> +		memcpy(&buffer[pos], &value, sizeof(value));
> +	}
> +
> +	iio_push_to_buffers_with_ts(iio, buffer, sizeof(buffer), timestamp);
> +
> +	return 0;
> +}
> +
> +/*
> + * Drain the FIFO and push the samples it held, stopping once max_scans scans
> + * are in hand or draining everything when max_scans is zero. Stopping at the
> + * read rather than after it matters: entries leave the hardware as they are
> + * read, so any collected beyond the caller's limit would have to be discarded.
> + *
> + * Returns the number of scans pushed. Called with lock held.

As before - use __must_lock() markings if you want to document necessary locks.

> + */
> +static int dps310_fifo_drain(struct dps310_data *data, s64 now,
> +			     unsigned int max_scans)
> +{

...

> +
> +static int dps310_hwfifo_set_watermark(struct iio_dev *iio, unsigned int val)
> +{
> +	struct dps310_data *data = iio_priv(iio);
> +
> +	data->watermark = clamp_t(unsigned int, val, 1, DPS310_FIFO_DEPTH);

Is the _t needed?

> +
> +	return 0;
> +}
> +
> +static int dps310_hwfifo_flush(struct iio_dev *iio, unsigned int count)
> +{
> +	struct dps310_data *data = iio_priv(iio);
> +	int rc;
> +
> +	/*
> +	 * With a trigger attached the FIFO is left disabled, and the pressure
> +	 * registers then hold the latest measurement rather than queued entries
> +	 * with an empty marker to stop on. There is nothing to drain.
> +	 */
> +	if (iio_device_get_current_mode(iio) != INDIO_BUFFER_SOFTWARE)
> +		return 0;
> +
> +	scoped_guard(mutex, &data->lock)

	guard(mutex)(&data->lock);

	return dps310_fifo_drain();

> +		rc = dps310_fifo_drain(data, iio_get_time_ns(iio), count);
> +
> +	return rc;
> +}

>  static int dps310_probe(struct i2c_client *client)
> @@ -1021,13 +1400,22 @@ static int dps310_probe(struct i2c_client *client)
>  
>  	data = iio_priv(iio);
>  	data->client = client;
> +	data->iio = iio;
> +	data->watermark = 1;
>  	mutex_init(&data->lock);
> +	INIT_DELAYED_WORK(&data->fifo_work, dps310_fifo_work);
>  
>  	iio->name = id->name;
>  	iio->channels = dps310_channels;
>  	iio->num_channels = ARRAY_SIZE(dps310_channels);
>  	iio->info = &dps310_info;
> -	iio->modes = INDIO_DIRECT_MODE;
> +	/*
> +	 * Both buffer modes are advertised so that iio_verify_update() picks
> +	 * INDIO_BUFFER_TRIGGERED when a trigger is attached and falls back to
> +	 * INDIO_BUFFER_SOFTWARE, which the FIFO path uses, when one is not.
> +	 */
> +	iio->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_TRIGGERED |
> +		     INDIO_BUFFER_SOFTWARE;
>  
>  	data->regmap = devm_regmap_init_i2c(client, &dps310_regmap_config);
>  	if (IS_ERR(data->regmap))
> @@ -1043,12 +1431,19 @@ static int dps310_probe(struct i2c_client *client)
>  		return rc;
>  
>  	/*
> -	 * The device measures continuously in background mode, so a capture is
> -	 * just a read of the latest results and no buffer setup ops are needed.
> +	 * The device measures continuously in background mode, so a triggered
> +	 * capture is just a read of the latest results. The setup ops start and
> +	 * stop the FIFO drain when no trigger is attached.
>  	 */
>  	rc = devm_iio_triggered_buffer_setup(&client->dev, iio,
>  					     iio_pollfunc_store_time,
> -					     dps310_trigger_handler, NULL);
> +					     dps310_trigger_handler,
> +					     &dps310_buffer_setup_ops);
> +	if (rc)
> +		return rc;
> +
> +	rc = devm_add_action_or_reset(&client->dev, dps310_cancel_fifo_work,
> +				      data);

There was already a lot of use of client->dev in here and this introduces some
more.  I think a precursor patch adding a local struct device *dev = &client->dev;
and using it through all the calls in probe would help shorten some lines etc
and generally aid readability.

>  	if (rc)
>  		return rc;
>  

