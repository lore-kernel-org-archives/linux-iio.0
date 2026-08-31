Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D351E30D3E5;
	Mon, 31 Aug 2026 01:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788138901; cv=none; b=S273Ir6LKTAPuSku6YQHA1xpqry0kwtmyTJkEWTZAfxiQYn0CDW7MrzZygvKiONmZpTVrWF/tgYwS/zpeXrpnOpBSjJMrc+WRaQ4Kh7hTUc2+pb3Mi5rUJ01wkEXUqOyxAHtR7GdGkVQ0G9M36zki2Ihr4r2V2EJcKmCYbbxC6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788138901; c=relaxed/simple;
	bh=DmBSDf4U7eo19BB2STAoE4bg6RtAEFrAw9tGJuB15f8=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=iuiyN9I6qDuBINOTu2MvWSpzbSx3LOS6yRsezDOIXZqQHyZn2BH6/jJ5jZ6ty1LlP4lfoAp7ta9S8TDcNz1q0v7fMA2bavLbVKopLDxBsy+PBYANsCM5vaAGOfDYoaeM5xxulIA3g30UQ1Yb4YkKzXNZHNZZ2gLx4L190xaqYgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iPy8oEOW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iPy8oEOW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59A3E1F00AC4;
	Mon, 31 Aug 2026 01:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788138899;
	bh=VDPaqssUQhqpgM7b1RUi6+s82afEUvVOu4yLsYiiaNw=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=iPy8oEOWTOtGfuQajcYpwiilRS8yX7g3LXCGbCfJWxbm7XhRm38g05QtRdj8ushN0
	 BiE2RMXMduvwpt/oesAvlvCUY28Vuz8SXrsUdAaDfEvGpi1PMbO4qUSV0KGrEyCULi
	 34DMCtyZn5XsfmoRY00NI6QyzqBuDBH7DAMvM178IJM3pDF7q8QISun+QTs713oYRe
	 Hd642qh8boUNLX3YVbgd7HK1y5zy5LRAQa/eJHhgd9KDt0K8SM+nigG9p5MCfi/pOX
	 SHZVVevfeltToLa8KBeZqv+VZDnVPh9UmSaKlhATAo+t6P0sWs+I2P3V8Ggq4X9EgJ
	 FVso7tMjsnQ4w==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v6 5/6] iio: pressure: dps310: add hardware FIFO
 support
From: Jonathan Cameron <jic23@kernel.org>
To: Rupesh Majhi <zoone.rupert@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, Bill Wendling <morbo@google.com>, 
 David Lechner <dlechner@baylibre.com>, Eddie James <eajames@linux.ibm.com>, 
 Joel Stanley <joel@jms.id.au>, Jonathan Cameron <jic23@kernel.org>, 
 Justin Stitt <justinstitt@google.com>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
In-Reply-To: <20260824201203.396651-6-zoone.rupert@gmail.com>
References: <20260824201203.396651-1-zoone.rupert@gmail.com>
 <20260824201203.396651-6-zoone.rupert@gmail.com>
Date: Mon, 31 Aug 2026 02:14:41 +0100
Message-Id: <178813888151.2788519.16547013180884814648.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10109;
 i=jonathan.cameron@oss.qualcomm.com; h=from:subject:message-id;
 bh=DmBSDf4U7eo19BB2STAoE4bg6RtAEFrAw9tGJuB15f8=;
 b=owEBfwKA/ZANAwAKAVSFNJnE9BaIAcsmYgBqlNWQi7AYjX6r18i0UpnIOBSDeo3n+vozV6QUE
 5EI3JB4ibqJAkUEAAEKAC8WIQRuKWazh4QGUpEmgbFUhTSZxPQWiAUCapTVkBEcamljMjNAa2Vy
 bmVsLm9yZwAKCRBUhTSZxPQWiOKWEAChYG74Bfzd1jemjfS+t57RdbXv8incXrDkMXyMWU5d01H
 zbsgqahnlnoi3MHx1v/3+bAJ2CVL0yVdorrAsAelsg43RH/KRFDGaIYtAaMnmB+KMivxvDWkFrN
 WPmArCMGArvA4+y0ZB/rnPeEmOpE6e8loo2H7xbau14MEirRx/AXErqny4SwI0DpqAwXCNofPQe
 btKQc2mEGYDlbLA0t2GjEdJ9xhp+DtacUiqDN7161KRkYjJ5iuxI1f1cH4njOfiwK/KsTzXkmLJ
 5caam1pnqgOQWMgU+07rLuuJLHe+y0iGugYq7SqPoOnH987x4Pe1WeEf890C759nOaseZaHvVCg
 vDeMynzqKXWb7dUWaFLgDDUjm979QXMCY6qx6lDc4CFmLR7h4GNIL9xvlU1z4/xpm/n4Hy+5j5j
 V6pkRXDAFpHgtQ8NJrzeCFlP77sK1UjnzmHyekvnGax1AzKiWLZKBn3CSyymu5SLYOCrFqn5rSE
 i67Q6qMuHzsVvjUc2A9+JuTufuTcMb4RQRrfwbH85ZrbAG4L/WxYF8aJ4N8Xyq8ukwnPkQUpmLl
 8fkbGBFj6WPSsvtH3V5k+AgCTJgmBODLtpAZV6Is5adx6Yi/ud1HCjxTq5Ax0tp9TOIRi4Gg3Mx
 svOu80YHnaDp2AR4ibkxqz3RtSQXvu2GuJojGmA==
X-Developer-Key: i=jonathan.cameron@oss.qualcomm.com; a=openpgp;
 fpr=6E2966B387840652912681B154853499C4F41688

> Use the 32 entry FIFO for buffered capture, so a reader wakes once per
> batch of samples instead of once per sample.
> 
> FIFO runs when no trigger is attached and stays off when one is.
> iio_verify_update() already picks the mode, so buffer setup ops just
> branch on iio_device_get_current_mode(), as rohm-bm1390.c does.
> 
> Drain is on a timer because there is no interrupt to use and nothing in
> tree wires the INT pin. hwfifo_flush_to_buffer is not enough on its own:
> iio_buffer_read() sleeps until something is pushed, so a blocking reader
> would hang with samples still sitting in the FIFO. Hook is kept for
> poll() and non-blocking reads.
> 
> Pressure entries drive the scans and reuse last temperature, so the two
> configured rates stay independent. FIFO does not timestamp entries, they
> are estimated from the sample rate.
> 
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>

Various comments inline.  I'd definitely drop the timestamp code from
this patch - maybe more than that.  Need to make it easier to review.
Timestamp + FIFO is hard to get right - see the iterations the invense
handler has gone through.  Even more so when there are no actual
interrupts to provide meaningful information!

>
> diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
> index f122acd72b0c..d05aa05d6222 100644
> --- a/drivers/iio/pressure/dps310.c
> +++ b/drivers/iio/pressure/dps310.c


...

> +
> +static int dps310_fifo_set_enable(struct dps310_data *data, bool enable)
> +	__must_hold(&data->lock)
> +{
> +	return regmap_write_bits(data->regmap, DPS310_CFG_REG, DPS310_FIFO_EN,
> +				 enable ? DPS310_FIFO_EN : 0);
r
egmap_assign_bits

> +}
> +
> +/*
> + * There is no interrupt wired on any in-tree platform and the binding has no
> + * interrupts property, so the FIFO is drained on a timer, at an interval below
> + * the time it takes to fill. See DPS310_FIFO_DEPTH for why late is bad.
> + */

Just as a passing comment.  This is very unusual. Fifos are normally
coupled with interrupts.

> +static int dps310_fifo_interval(struct dps310_data *data, unsigned int *ms)
> +	__must_hold(&data->lock)
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

I'd not mention the full condition. It is of no use other than
detecting overflow (and we have no way to report that).


> +	want_ms = data->watermark * MSEC_PER_SEC /
> +		  (pressure_enabled ? prs_rate : tmp_rate);
> +
> +	*ms = clamp(min(want_ms, fill_ms / 2), DPS310_DRAIN_MIN_MS,
> +		    DPS310_DRAIN_MAX_MS);
> +
> +	return 0;
> +}
> +

...

> +static int dps310_fifo_push_scan(struct dps310_data *data, s32 temp_raw,
> +				 s32 pressure_raw, s64 timestamp)
> +	__must_hold(&data->lock)
> +{
> +	struct iio_dev *iio = data->iio;
> +	struct dps310_scan scan = { };

As before I'd have the structure locally here. I really want to be
able to see what it looks like.  Don't worry about the small amount
of duplication this will entail.

> +	int i = 0;
> +	int rc;
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
> +		rc = dps310_calculate_temp(data, &scan.channels[i]);
> +		if (rc)
> +			return rc;
> +
> +		i++;
> +	}
> +
> +	if (test_bit(DPS310_SCAN_PRESSURE, iio->active_scan_mask)) {
> +		rc = dps310_calculate_pressure(data, &scan.channels[i]);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	iio_push_to_buffers_with_ts(iio, &scan, sizeof(scan), timestamp);
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
> + * Returns the number of scans pushed.
> + */
> +static int dps310_fifo_drain(struct dps310_data *data, s64 now,
> +			     unsigned int max_scans)
> +	__must_hold(&data->lock)
> +{
> +	bool pressure_enabled = test_bit(DPS310_SCAN_PRESSURE,
> +					 data->iio->active_scan_mask);
> +	bool temp_valid = data->fifo_temp_valid;
> +	bool is_pressure[DPS310_FIFO_DEPTH];
> +	s32 raw[DPS310_FIFO_DEPTH];
> +	unsigned int i, n = 0, scans = 0, pushed = 0;
> +	s64 interval, first;
> +	int rc, rate;
> +
> +	/*
> +	 * Empty the hardware first and compensate afterwards, so the time spent
> +	 * in the polynomial is not time the FIFO spends filling.

This seems backwards.  We are aiming that thie fifo does fill (with
new data) whilst doing the maths.

> +	 *
> +	 * Pressure entries drive the scans and reuse the most recent
> +	 * temperature, so the two rates stay independent; entries arriving
> +	 * before any temperature cannot be compensated and are dropped. With
> +	 * only the temperature channel enabled there is nothing to pair with
> +	 * and temperature drives the scans itself.

Dropping data rather defeats the point of the fifo.  Can we avoid it
by holding them locally until we will definitely have seen a useable
temperature?

> +	 */
> +	for (i = 0; i < DPS310_FIFO_DEPTH; i++) {
> +		rc = dps310_fifo_read_entry(data, &raw[n], &is_pressure[n]);
> +		if (rc < 0)
> +			return rc;
> +		if (!rc)
> +			break;
> +
> +		if (!is_pressure[n]) {
> +			temp_valid = true;
> +			if (!pressure_enabled)
> +				scans++;
> +		} else if (pressure_enabled && temp_valid) {
> +			scans++;
> +		}
> +		n++;
> +
> +		if (max_scans && scans >= max_scans)
> +			break;
> +	}
> +
> +	if (!scans)
> +		return 0;
> +
> +	/*
> +	 * FIFO entries carry no timestamps. They are synthesised by working
> +	 * back from the drain with the configured period of whichever
> +	 * measurement drives the scans, so the spacing matches the sampling
> +	 * frequency the user asked for instead of varying with how much each
> +	 * drain happened to collect. These are estimates, not hardware
> +	 * timestamps.
> +	 */

Do this as a follow up patch if at all.  Fifo timestamp estimation is very
hard to get right.  We often just don't provide timestamps for this
reason.

For initial patch just reject starting the buffer if timestamps are
set to be captured.



> +	rc = pressure_enabled ? dps310_get_pres_samp_freq(data, &rate) :
> +				dps310_get_temp_samp_freq(data, &rate);
> +	if (rc)
> +		return rc;
> +
> +	interval = div_s64(NSEC_PER_SEC, rate);
> +	first = now - (s64)(scans - 1) * interval;
> +
> +	/*
> +	 * A batch must not start before the previous one ended, or the buffer
> +	 * would carry timestamps that go backwards. If this drain collected
> +	 * more than the configured rate accounts for, spread it across the
> +	 * window since the last sample instead.
> +	 */
> +	if (data->fifo_timestamp && first <= data->fifo_timestamp) {
> +		interval = max_t(s64, div_s64(now - data->fifo_timestamp, scans), 1);
> +		first = data->fifo_timestamp + interval;
> +	}
> +
> +	for (i = 0; i < n; i++) {
> +		s64 timestamp;
> +
> +		if (!is_pressure[i]) {
> +			data->fifo_temp_raw = raw[i];
> +			data->fifo_temp_valid = true;
> +
> +			if (pressure_enabled)
> +				continue;
> +		} else if (!pressure_enabled || !data->fifo_temp_valid) {
> +			continue;
> +		}
> +
> +		timestamp = first + (s64)pushed * interval;
> +
> +		rc = dps310_fifo_push_scan(data,
> +					   is_pressure[i] ? data->fifo_temp_raw
> +							  : raw[i],
> +					   is_pressure[i] ? raw[i] : 0,
> +					   timestamp);
> +		if (rc)
> +			return rc;
> +
> +		data->fifo_timestamp = timestamp;
> +		pushed++;
> +	}
> +
> +	return pushed;
> +}
> +

>  
>  static int dps310_probe(struct i2c_client *client)
> @@ -1018,13 +1392,22 @@ static int dps310_probe(struct i2c_client *client)
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

Hmm.  One of thes is set automatically (hence why it wasn't here
before).  I suppose there is some value in making the list explicit
here for documentation purposes rather thn just adding the other bits.
I'd talk less about what a particular core function does and rather
refer to the 'IIO core' or something like that.  Avoids it becoming
wrong if we change the function name or implementation in future.

-- 
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
