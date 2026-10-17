Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7748C20D4FC;
	Sat, 17 Oct 2026 01:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792201278; cv=none; b=T7prZimxd6NPWvdqww9mMOVTGbCBqICAOhA4iCaBQfKTomH3BEtiy1J9hHWbw/Z4aI6UdVXanMGLrA3NjELjAtaPM43FhA/OBjSsKRzleuPig0qH2Tz7BeCcwxgPLgcGDlZkc9eTHdH4I3h5zDdjPZFhyTQSa5tXSv0zVCoVW/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792201278; c=relaxed/simple;
	bh=d8YKuFuECgbEFarMna+5TzRFyEjgO7KXDjGRubUVCHw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J9BlsrsbRBxPTwudl4DtycsPMJshCyOjVVB7jZQJGGdXbyOtSE2FXPNTuKz1b52SavtBeUhIO2j7OkQH6HHDJUUa7pjT8FUVnYeykqOU8nBqeO/vPSdpre5YuD1X1DxvURWkFtk+obwigrIMaBzZhPKV/cTUpHkzT78M7o5SupY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V4pijvoc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V4pijvoc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23D8B1F000C4;
	Sat, 17 Oct 2026 01:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792201277;
	bh=2IiV3BHRbiogK116TUz5wTJlgLPg6DgQW1IXAihJ6B4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=V4pijvocKGvbHH+lt6d5EUTqv02ZZ1+8MbCmGThVCQpmA/HJnRZ4KM09hdQrwrjjt
	 Wcc1ulN+GRgS2WzTZGPPjaWOpXHEcWForTvusiwaP+2Hk+MIUttudHxXIbi18DorYD
	 RyEJuKCBU/bFAivROeg6bDvN4NmA0KZOr2aTvMM1vGy4slI38juaGjDIsg2F7m1l1f
	 l6SVy2TBjmyXRYz56lyVVswwWhSPGEQOtkXQCpLN7iGHprj4cGGxrXrqaQ0W9VkHQl
	 MiMJuDePzVPvDJXLVPJooB6EnK2OdW1936PXgvdKCTcFQ1DBznm9FrQq6SLwMCiLfV
	 P4Y33lfDhJiQw==
Date: Sat, 17 Oct 2026 02:41:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Cc: radu.sabau@analog.com, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 Alexandru Ardelean <alexandru.ardelean@analog.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 4/6] iio: imu: adis16607: Add FIFO-based
 buffered/triggered capture
Message-ID: <20261017024110.601d9b6c@jic23-hlaptop>
In-Reply-To: <20261015-adis16607-v3-4-f972d4efee85@analog.com>
References: <20261015-adis16607-v3-0-f972d4efee85@analog.com>
	<20261015-adis16607-v3-4-f972d4efee85@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Oct 2026 12:33:01 +0300
Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org> wrote:

> From: Radu Sabau <radu.sabau@analog.com>
> 
> Add buffered capture via the device's hardware FIFO - the only
> capture mode this driver supports. Popping the FIFO uses a dedicated
> command and payload format (FIFO_DATA_CMD, 52 bytes, no checksum),
> handled directly rather than through adislib's generic burst-read
> helpers, which assume one fixed-shape read per trigger rather than a
> variable-count drain loop.
> 
> The watermark-met condition is signaled via DEV_NOK on the device's
> one interrupt pin, which stays asserted (level-triggered) until
> DIAG_STAT is read and cleared - matching adislib's has_fifo contract.
> DEV_NOK fires on any DIAG_STAT flag, not just FIFO_THRESH_MET, so the
> trigger handler checks that specific bit before popping anything.
> DR_GPIO_MASK stays enabled unconditionally: DR pulses drive the FIFO
> controller's internal sample enqueue, independent of pin routing.
> 
> Watermark is configurable via the standard hwfifo_set_watermark
> callback and the usual hwfifo_* sysfs attributes.
> 
> Signed-off-by: Radu Sabau <radu.sabau@analog.com>
Various comments inline.  Biggest one is I don't follow why we
need to stop the fifo (which is a ring buffer given overwrite can't
happen in a fifo!)

Jonathan

>  /* Self-test registers and masks */
>  #define ADIS16607_REG_SELF_TEST_DATA(x)	((x) + 0x23)
>  #define ADIS16607_SNSR_SELF_TEST_MASK	BIT(6)
> @@ -84,6 +108,9 @@ struct adis16607 {
>  	struct adis adis;
>  	unsigned long clk_freq;	/* millihertz */
>  	u64 sample_period_ns;
> +	u16 fifo_watermark;
> +	/* Scratch buffer used for FIFO pop operations, see adis16607_fifo_pop() */
> +	u8 *fifo_buf;

As below. I'm not seeing why you don't just put the fifo in here
rather than via a separate allocatoin.

>  	/* IIO buffer for reordered data - sized for max channels */
>  	u8 data[64] __aligned(IIO_DMA_MINALIGN);
>  };
> @@ -224,6 +251,352 @@ static const struct adis_ops adis16607_ops = {
>  	.reset = adis16607_reset,
>  };
>  
> +/*
> + * FIFO/burst data offsets for each channel (in bytes from the data start,
> + * i.e. after the 4-byte command prefix).
> + * Each 32-bit inertial channel occupies 4 bytes (MSW + LSW), TEMP is 2 bytes.
> + *
> + * FIFO data layout (52 bytes, DATA_CNTR enabled, no checksum):
> + *   Offset 0-3:   ACCEL_X  (32-bit: MSW, LSW)
> + *   Offset 4-7:   ACCEL_Y
> + *   Offset 8-11:  ACCEL_Z
> + *   Offset 12-15: GYRO_X
> + *   Offset 16-19: GYRO_Y
> + *   Offset 20-23: GYRO_Z
> + *   Offset 24-27: DELTVEL_X
> + *   Offset 28-31: DELTVEL_Y
> + *   Offset 32-35: DELTVEL_Z
> + *   Offset 36-39: DELTANG_X
> + *   Offset 40-43: DELTANG_Y
> + *   Offset 44-47: DELTANG_Z
> + *   Offset 48-49: TEMP (16-bit)
> + *   Offset 50-51: DATA_CNTR (16-bit)
> + *
> + * Each 32-bit value encodes 24-bit sensor data as:
> + *   value_24bit = (MSW << 8) | (LSW >> 8)
> + */
> +static const u8 adis16607_burst_offsets[] = {
> +	[ADIS16607_SCAN_ACCEL_X] = 0,
> +	[ADIS16607_SCAN_ACCEL_Y] = 4,
> +	[ADIS16607_SCAN_ACCEL_Z] = 8,
> +	[ADIS16607_SCAN_GYRO_X] = 12,
> +	[ADIS16607_SCAN_GYRO_Y] = 16,
> +	[ADIS16607_SCAN_GYRO_Z] = 20,
> +	[ADIS16607_SCAN_DELTVEL_X] = 24,
> +	[ADIS16607_SCAN_DELTVEL_Y] = 28,
> +	[ADIS16607_SCAN_DELTVEL_Z] = 32,
> +	[ADIS16607_SCAN_DELTANG_X] = 36,
> +	[ADIS16607_SCAN_DELTANG_Y] = 40,
> +	[ADIS16607_SCAN_DELTANG_Z] = 44,
> +	[ADIS16607_SCAN_TEMP] = 48,
> +};
> +
> +static void adis16607_fifo_buf_cleanup(void *arg)
> +{
> +	struct adis16607 *st = arg;
> +
> +	kfree(st->fifo_buf);
> +}
> +
> +/*
> + * Sets up the scratch buffer used for FIFO pop operations (see
> + * adis16607_fifo_pop()). The 32-bit burst mode and DATA_CNTR config bits
> + * are enabled once during startup (adis16607_post_reset_setup()), not
> + * here, since they don't depend on scan_mask.
> + */
> +static int adis16607_update_scan_mode(struct iio_dev *indio_dev,
> +				      const unsigned long *scan_mask)
> +{
> +	struct adis16607 *st = iio_priv(indio_dev);
> +	unsigned int burst_len = ADIS16607_BURST_CMD_SIZE + ADIS16607_FIFO_DATA_LEN;

You lost me.  That's fixed length, so why this dance?  Just put
it in the iio_priv() which is allocated on stack anyway.

> +
> +	kfree(st->fifo_buf);
> +
> +	st->fifo_buf = kzalloc(burst_len, GFP_KERNEL);
> +	if (!st->fifo_buf)
> +		return -ENOMEM;
> +
> +	return 0;
> +}

> +
> +/*
> + * Trigger handler - reads samples from the device FIFO. Triggered by the
> + * DEV_NOK interrupt, which fires on any DIAG_STAT flag, not just
> + * FIFO_THRESH_MET - the DIAG_STAT read below both checks which flag(s)
> + * raised the interrupt and clears the latched status, and must happen
> + * before any FIFO pop, or we'd pop for nothing on an unrelated flag.
> + */
> +static irqreturn_t adis16607_trigger_handler(int irq, void *p)

A trigger handler that is associated with a fifo is usually a bad
idea.  We often only use fifos if there is no trigger associated
because the meaning of one trigger ever scan is lost so they
become just a pointless intermediate layer.  Not sure if we can
do that here.

> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct adis16607 *st = iio_priv(indio_dev);
> +	u8 fifo_sample[ADIS16607_FIFO_DATA_LEN];
> +	u16 diag_stat, word_cnt, sample_cnt, threshold;
> +	s64 timestamp;
> +	int ret, i;
> +
> +	mutex_lock(&st->adis.state_lock);
> +
> +	/* Check if FIFO threshold is met */
> +	ret = __adis_read_reg_16(&st->adis, ADIS16607_REG_DIAG_STAT, &diag_stat);
> +	if (ret)
> +		goto unlock;
> +
> +	if (!(diag_stat & ADIS16607_FIFO_THR_MET_MASK))
> +		goto unlock;
> +
> +	/*
> +	 * Disable the FIFO before draining: FIFO_THR_MET means it's at the
> +	 * configured threshold, and leaving it enabled while we pop would
> +	 * let incoming samples overwrite ones not yet read. No new samples
It will overwrite without overflowing?  That's odd if true. If it's the
overflow case that was true before you started popping so no reason to
care about it more in this case.  We generally don't disable fifos for
this reason. The description in the datasheet suggests this is a ring buffer
rather than a fifo as a fifo never overwrites of you'd not be getting
the 'first in' but such is the world of datasheets.

Does it at least guarantee no value tearing so worst that happens is we
get skips of old data if we read to slow?

Overall other than the overwrite not being controllable, this sounds
like most other fifos.  We get an overflow if we don't read fast enough.
In that case and only that case we should flush (though I'm not sure
we do it even then when we have overwriting as only option).

In short, I'm not seeing the special bit of this implementation that makes
data loss inevitable. Perhaps some spec pointers and quotes would convince
me?

> +	 * are enqueued while disabled, so nothing arrives between here and
> +	 * the flush below - some sample-periods' worth of data not being
> +	 * captured during this window is inherent to this device's FIFO
> +	 * design (it has no secondary buffer), not something the driver can
> +	 * avoid.
> +	 */
> +	ret = __adis_write_reg_16(&st->adis, ADIS16607_REG_USER_FIFO_CFG, 0);
> +	if (ret)
> +		goto unlock;
> +
> +	/* Read FIFO word count */
> +	ret = __adis_read_reg_16(&st->adis, ADIS16607_REG_FIFO_WORD_CNT, &word_cnt);
> +	if (ret)
> +		goto reenable_fifo;
> +
> +	/* Calculate number of complete samples */
> +	sample_cnt = word_cnt / ADIS16607_FIFO_WORDS_PER_SAMPLE;
> +	if (!sample_cnt)
> +		goto reenable_fifo;
> +
> +	/*
> +	 * pf->timestamp is the IRQ-fire time, i.e. when the newest (last
> +	 * enqueued) sample tipped the FIFO over watermark. The FIFO pops
> +	 * oldest-first, so back-date the first popped sample's timestamp by
> +	 * the batch duration - the loop then counts back up to pf->timestamp
> +	 * for the newest sample, instead of projecting past it.
> +	 */
> +	timestamp = pf->timestamp - (s64)(sample_cnt - 1) * st->sample_period_ns;
> +
> +	/* Pop and process each sample */
> +	for (i = 0; i < sample_cnt; i++) {
> +		ret = adis16607_fifo_pop(st, fifo_sample);
> +		if (ret)
> +			goto reenable_fifo;
> +
> +		adis16607_fifo_push_sample(indio_dev, fifo_sample, timestamp);
> +		timestamp += st->sample_period_ns;
> +	}
> +
> +reenable_fifo:
> +	/* Flush FIFO before re-enabling */

This is also bothering me. The aim of the fifo is smoothly capture
everything.  We should only end up flushing if an overflow has
definitely happened.

> +	ret = __adis_write_reg_16(&st->adis, ADIS16607_REG_USER_FIFO_CFG,
> +				  ADIS16607_FIFO_FLUSH_MASK);
> +	if (ret)
> +		dev_warn_ratelimited(&st->adis.spi->dev,
> +				     "failed to flush FIFO: %d\n", ret);
> +
> +	/* Re-enable FIFO with watermark threshold */
> +	threshold = st->fifo_watermark * ADIS16607_FIFO_WORDS_PER_SAMPLE;
> +	ret = __adis_write_reg_16(&st->adis, ADIS16607_REG_USER_FIFO_CFG,
> +				  threshold & ADIS16607_FIFO_THR_MASK);
> +	if (ret)
> +		dev_warn_ratelimited(&st->adis.spi->dev,
> +				     "failed to re-enable FIFO: %d\n", ret);
> +
> +unlock:
> +	mutex_unlock(&st->adis.state_lock);
> +	iio_trigger_notify_done(indio_dev->trig);
> +	return IRQ_HANDLED;
> +}

> +
> +static int adis16607_buffer_postenable(struct iio_dev *indio_dev)
> +{
> +	struct adis16607 *st = iio_priv(indio_dev);
> +	struct adis *adis = &st->adis;
> +	u16 threshold;
> +	int ret;
> +
> +	mutex_lock(&adis->state_lock);
> +
> +	/* Flush FIFO to start clean */
> +	ret = __adis_write_reg_16(adis, ADIS16607_REG_USER_FIFO_CFG,
> +				  ADIS16607_FIFO_FLUSH_MASK);
> +	if (ret)
> +		goto unlock;
> +
> +	/* Enable FIFO with watermark threshold (in word count) */
> +	threshold = st->fifo_watermark * ADIS16607_FIFO_WORDS_PER_SAMPLE;
> +	ret = __adis_write_reg_16(adis, ADIS16607_REG_USER_FIFO_CFG,
> +				  threshold & ADIS16607_FIFO_THR_MASK);
> +
> +unlock:

As below. Then you can use direct returns on error.


> +	mutex_unlock(&adis->state_lock);
> +	return ret;
> +}
> +
> +static int adis16607_buffer_postdisable(struct iio_dev *indio_dev)
> +{
> +	struct adis16607 *st = iio_priv(indio_dev);
> +	struct adis *adis = &st->adis;
> +	int ret;
> +
> +	mutex_lock(&adis->state_lock);

Use the auto lock helper.

> +
> +	/* Disable FIFO */
> +	ret = __adis_write_reg_16(adis, ADIS16607_REG_USER_FIFO_CFG, 0);
> +
> +	mutex_unlock(&adis->state_lock);
> +	return ret;
> +}
> +
> +static const struct iio_buffer_setup_ops adis16607_buffer_ops = {
> +	.postenable = adis16607_buffer_postenable,
> +	.postdisable = adis16607_buffer_postdisable,
> +};
> +
> +static int adis16607_set_watermark(struct iio_dev *indio_dev, unsigned int val)
> +{
> +	struct adis16607 *st = iio_priv(indio_dev);
> +
> +	val = clamp_t(unsigned int, val, 1, ADIS16607_MAX_FIFO_WM);

Is the type forcing needed?  i.e. why not clamp()?

> +	st->fifo_watermark = val;
> +
> +	return 0;
> +}

> @@ -798,6 +1197,8 @@ static int adis16607_probe(struct spi_device *spi)
>  	indio_dev->info = &adis16607_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
> +	st->fifo_watermark = ADIS16607_MAX_FIFO_WM;
> +
>  	st->adis.ops = &adis16607_ops;
>  
>  	ret = devm_regulator_get_enable(dev, "vdd");
> @@ -816,6 +1217,21 @@ static int adis16607_probe(struct spi_device *spi)
>  	if (ret)
>  		return ret;
>  
> +	/*
> +	 * Register fifo_buf cleanup before buffer/trigger setup so that on
> +	 * devm teardown (LIFO order) the IRQ handler is removed first, then
> +	 * fifo_buf is freed, avoiding a use-after-free in the handler.
> +	 */
> +	ret = devm_add_action_or_reset(dev, adis16607_fifo_buf_cleanup, st);

See above. I think this will go away when you don't allocate
the buffer in update_scan_mode().

> +	if (ret)
> +		return ret;
> +
> +	ret = devm_adis_setup_buffer_and_trigger_with_attrs(&st->adis, indio_dev,
> +		adis16607_trigger_handler, &adis16607_buffer_ops,
> +		adis16607_fifo_attributes);

Whilst it's a long line, align these after the (

> +	if (ret)
> +		return ret;
> +
>  	ret = devm_iio_device_register(dev, indio_dev);
>  	if (ret)
>  		return ret;
> 

