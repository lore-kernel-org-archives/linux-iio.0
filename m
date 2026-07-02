Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3373242B8;
	Thu,  2 Jul 2026 03:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782963774; cv=none; b=rUvVnh1TYg5CpTfQd0AKLBR8RjtEMLcffOZ6z6Sz8twgmC39ZVFi647wJCtRRKAtpclyudJDJzPFQ4JZREK4xHfmTo8/5655UxzSh9usVMtwGiU/2YYSmqmQCR2I+QLYvlle311zwksAOKf1dAj6djZZv0TXe1vCeaoTb55ghPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782963774; c=relaxed/simple;
	bh=1SdTm0J0WqqELWQMExmbM8tnC5ug+WFCTacsLODZCPk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rPhauyqU4zjyMJrOHd+i+uerdddsmXmTpM6m3xtaLf8bI1FbTW0dJyauqQHUX+yA9dh9Sxic8EcA2ecZXLeRwbSnJKBc6YjUgma4SuxOFDRtC8/52wcgDuEgBrmQWupQfBVSQ3k6gdEan9CzAD6cAI1mUvROIjLMET030pWoleM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hsWLlGkj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hsWLlGkj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F7301F000E9;
	Thu,  2 Jul 2026 03:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782963772;
	bh=BIkryKTtpQnmVn3pswgypnZBzInxgI0DDT0qy7sZUvU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hsWLlGkjsBoEY9kbKo4FBZkZHLP1SLUmSmy+/PEb1uJoYRS9U8EHpYm7ZQVELgRZ0
	 7Fp+2PK4R40gmpDvNl0iJvJfryp/tCuYWSEoccBvOzTXY6yfqActtv0POdKY1G4cPa
	 t/BqEzY/aQ5NUBzmMf/QIjWUYapZXtHE1yfO25ADShkjsDoivzeylOH3g1a6BYFP/C
	 iN+74wNNg+6gSH6IUTodjMG6GyIlGS0PjnO1bEyvMQLW2UU/A2ILImymS+PK5ywhKO
	 l0LQOoLa0XMX+euEEgyfxfuKwlSQz9jRz88xPyC+hE9ZXPa51udZ1FjMM2ZGG4hKXz
	 4FXXeMMqQiyTQ==
Date: Thu, 2 Jul 2026 04:42:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Md Shofiqul Islam <shofiqtest@gmail.com>
Cc: linux-iio@vger.kernel.org, lars@metafoo.de, conor@kernel.org,
 conor+dt@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] iio: health: add MAX86150 ECG and PPG biosensor
 driver
Message-ID: <20260702044246.68e4dfd7@jic23-huawei>
In-Reply-To: <20260623201124.18271-3-shofiqtest@gmail.com>
References: <20260623174600.17100-1-shofiqtest@gmail.com>
	<20260623201124.18271-1-shofiqtest@gmail.com>
	<20260623201124.18271-3-shofiqtest@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Jun 2026 23:11:22 +0300
Md Shofiqul Islam <shofiqtest@gmail.com> wrote:

> Add a new IIO driver for the Analog Devices MAX86150 integrated
> biosensor, which combines two PPG optical channels (Red/IR LED) and
> one ECG biopotential channel in a single I2C device.
> 
> Key features:
> - 32-entry hardware FIFO with configurable almost-full threshold
> - Interrupt-driven triggered buffer using IIO trigger framework
> - Per-sample timestamp reconstruction anchored to A_FULL IRQ time
> - DMA-safe FIFO read buffer padded to full cacheline to satisfy
>   CONFIG_DMA_API_DEBUG constraints (fifo_raw and buf in separate
>   cachelines)
> - Level-triggered interrupt safety via IRQF_ONESHOT (threaded IRQ
>   keeps line masked until INT_STATUS1 is cleared)
> - PPG_RDY polling in read_raw() to handle slow oscillator start-up
> - SYS_SHDN power management: device stays off until buffer enabled
>   or sysfs read
> - Optional vdd, avdd, vref, leds regulator support
> 
> Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>

Hi,

Various comments inline.

Thanks

Jonathan


> ---
>  drivers/iio/health/Kconfig    |  23 ++
>  drivers/iio/health/Makefile   |   1 +
>  drivers/iio/health/max86150.c | 730 ++++++++++++++++++++++++++++++++++
>  3 files changed, 754 insertions(+)
>  create mode 100644 drivers/iio/health/max86150.c
> 
> diff --git a/drivers/iio/health/Kconfig b/drivers/iio/health/Kconfig
> index a89f3abf11f4..6496cf55290c 100644
> --- a/drivers/iio/health/Kconfig
> +++ b/drivers/iio/health/Kconfig
> @@ -13,6 +13,7 @@ config AFE4403
>  	depends on SPI_MASTER
>  	select REGMAP_SPI
>  	select IIO_BUFFER
> +	select IIO_TRIGGER
>  	select IIO_TRIGGERED_BUFFER
>  	help
>  	  Say yes to choose the Texas Instruments AFE4403
> @@ -26,6 +27,7 @@ config AFE4404
>  	depends on I2C
>  	select REGMAP_I2C
>  	select IIO_BUFFER
> +	select IIO_TRIGGER
>  	select IIO_TRIGGERED_BUFFER
>  	help
>  	  Say yes to choose the Texas Instruments AFE4404
> @@ -39,6 +41,7 @@ config MAX30100
>  	depends on I2C
>  	select REGMAP_I2C
>  	select IIO_BUFFER
> +	select IIO_TRIGGER
>  	select IIO_KFIFO_BUF
>  	help
>  	  Say Y here to build I2C interface support for the Maxim
> @@ -52,6 +55,7 @@ config MAX30102
>  	depends on I2C
>  	select REGMAP_I2C
>  	select IIO_BUFFER
> +	select IIO_TRIGGER

Why are you touching other drivers?

>  	select IIO_KFIFO_BUF
>  	help
> diff --git a/drivers/iio/health/max86150.c b/drivers/iio/health/max86150.c
> new file mode 100644
> index 000000000000..92bf31f0a761
> --- /dev/null
> +++ b/drivers/iio/health/max86150.c

> +/* PPG_CONFIG1 */
> +#define MAX86150_PPG_ADC_RGE		GENMASK(7, 6)
> +#define MAX86150_PPG_SR			GENMASK(5, 1)

Name the defines so it is obvious what register they apply to.
e.g. MAX86150_PPG_CONFIG1_ADC_RGE_MASK

You can group them with register defines using indent
to make it clear which are fields and which are registers.


> +/**
> + * struct max86150_data - driver private state
> + * @regmap:           register map for this device
> + * @dev:              parent device (for dev_err logging)
> + * @trig:             IIO hardware trigger backed by the device interrupt line
> + * @sample_period_ns: sample period in nanoseconds (set from configured rate)
> + * @fifo_raw:         DMA-safe buffer for regmap_noinc_read() FIFO bursts.
> + *                    Padded to ARCH_DMA_MINALIGN bytes so that @buf starts
> + *                    in the next cacheline and the two fields never share a
> + *                    cacheline -- required by CONFIG_DMA_API_DEBUG.

Nope. That's not what it __aligned(ARCH_DMA_MINALIGN) does.  Also use
IIO_DMA_MINALIGN for consistency - it predates the ARCH one being generally available.
Also I'm not sure why the API_DEBUG is relevant. The care around this is needed
to avoid actual data corruption not for API reasons.

> + * @buf:              IIO push buffer sized for worst-case (all 3 channels
> + *                    active): 3 x s32 (12 bytes) + 4-byte pad + s64
> + *                    timestamp = 24 bytes.  __aligned(8) satisfies
> + *                    iio_push_to_buffers_with_timestamp().

> + */
> +struct max86150_data {
> +	struct regmap		*regmap;
> +	struct device		*dev;
> +	struct iio_trigger	*trig;
> +	u32			 sample_period_ns;
> +	u8			 fifo_raw[ALIGN(MAX86150_SAMPLE_BYTES, ARCH_DMA_MINALIGN)]
> +				 __aligned(ARCH_DMA_MINALIGN);
> +	s32 buf[6] __aligned(8);

Use IIO_DECLARE_BUFFER_WITH_TIMESTAMP() and drop the comment above
as the macro handles all that for you.

> +};
> +
> +/* IIO channel specification */
> +


> +
> +/**
> + * max86150_read_one_sample - burst-read one complete 3-slot FIFO entry
> + * @data:    driver state
> + * @ppg_red: out - 19-bit PPG Red ADC value (unsigned)
> + * @ppg_ir:  out - 19-bit PPG IR ADC value (unsigned)
> + * @ecg:     out - 18-bit ECG ADC value (sign-extended to s32)
> + *
> + * Each FIFO entry is 9 bytes (3 slots x 3 bytes).  FIFO_DATA is a
> + * streaming register - the address does not auto-increment on each
> + * byte, so regmap_noinc_read() is used instead of regmap_bulk_read().
> + *
> + * Byte layout in the 24-bit FIFO word (MSB first):
> + *   PPG 19-bit unsigned: bits [18:0], top 5 bits are always zero
> + *   ECG 18-bit signed:   bits [17:0], top 6 bits are sign extension
> + */
> +static int max86150_read_one_sample(struct max86150_data *data,
> +				    u32 *ppg_red, u32 *ppg_ir, s32 *ecg)
> +{
> +	int ret;
> +
> +	/*
> +	 * Use data->fifo_raw (heap memory) not a local array so the buffer is
> +	 * DMA-mappable for I2C host controllers that use DMA for burst reads.
> +	 */
> +	ret = regmap_noinc_read(data->regmap, MAX86150_REG_FIFO_DATA,
> +				data->fifo_raw, sizeof(data->fifo_raw));
> +	if (ret)
> +		return ret;
> +
> +	/* Bytes [0..2]: PPG Red - 19-bit value in bits [18:0] */
> +	*ppg_red = (u32)(data->fifo_raw[0] & 0x07) << 16 |
> +		   (u32)data->fifo_raw[1] << 8 | data->fifo_raw[2];

These smell like get_unaligned_be24() with a single mask applied to the
result

> +
> +	/* Bytes [3..5]: PPG IR - same format */
> +	*ppg_ir  = (u32)(data->fifo_raw[3] & 0x07) << 16 |
> +		   (u32)data->fifo_raw[4] << 8 | data->fifo_raw[5];
> +
> +	/* Bytes [6..8]: ECG - 18-bit signed, sign-extend to s32 */
> +	*ecg = sign_extend32((u32)(data->fifo_raw[6] & 0x03) << 16 |
> +			     (u32)data->fifo_raw[7] << 8 | data->fifo_raw[8], 17);
> +
> +	return 0;
> +}
> +
> +/* IIO read_raw */

Drop that comment. It is obvious anyway from the naming.
> +
> +static int max86150_read_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int *val, int *val2, long mask)
> +{
> +	struct max86150_data *data = iio_priv(indio_dev);
> +	unsigned int ppg_rdy_status;
> +	u32 ppg_red, ppg_ir;
> +	s32 ecg;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		/*
> +		 * Claim direct mode to prevent concurrent sysfs reads from
> +		 * corrupting the FIFO pointers while a triggered buffer
> +		 * capture is active.
> +		 */
> +		if (!iio_device_claim_direct(indio_dev))
> +			return -EBUSY;
> +
> +		/*
> +		 * Single-shot path: wake the device, flush stale FIFO data,
> +		 * wait one sample period, read, then return to shutdown so
> +		 * the LEDs are not drawing current when idle.
> +		 */
> +		ret = regmap_update_bits(data->regmap, MAX86150_REG_SYS_CTRL,
> +					 MAX86150_SYS_SHDN, 0);
> +		if (!ret)

This is not the way we handle lots of possible failures. See below for options.

> +			ret = regmap_write(data->regmap,
> +					   MAX86150_REG_FIFO_WR_PTR, 0);
> +		if (!ret)
> +			ret = regmap_write(data->regmap,
> +					   MAX86150_REG_OVF_COUNTER, 0);
> +		if (!ret)
> +			ret = regmap_write(data->regmap,
> +					   MAX86150_REG_FIFO_RD_PTR, 0);
> +		if (ret) {
> +			regmap_update_bits(data->regmap, MAX86150_REG_SYS_CTRL,
> +					   MAX86150_SYS_SHDN, MAX86150_SYS_SHDN);
> +			iio_device_release_direct(indio_dev);
> +			return ret;
> +		}
> +
> +		/*
> +		 * Poll PPG_RDY rather than sleeping a fixed interval -- the
> +		 * internal oscillator may start slower than nominal, leaving
> +		 * the FIFO empty if we read too early.  25 ms timeout covers
> +		 * more than two 100 Hz sample periods.
> +		 */
> +		ret = regmap_read_poll_timeout(data->regmap,
> +					       MAX86150_REG_INT_STATUS1,
> +					       ppg_rdy_status,
> +					       ppg_rdy_status & MAX86150_INT_PPG_RDY,
> +					       1000, 25000);
> +		if (ret) {
> +			regmap_update_bits(data->regmap, MAX86150_REG_SYS_CTRL,
> +					   MAX86150_SYS_SHDN, MAX86150_SYS_SHDN);
> +			iio_device_release_direct(indio_dev);

Look at the ACQUIRE stuff in iio.h. That should simplify this. It doesn't matter
if we hold the deice in direct mode for a little longer than minimum necessary.

> +			return ret;
> +		}
> +
> +		ret = max86150_read_one_sample(data, &ppg_red, &ppg_ir, &ecg);
> +		regmap_update_bits(data->regmap, MAX86150_REG_SYS_CTRL,
> +				   MAX86150_SYS_SHDN, MAX86150_SYS_SHDN);
> +		iio_device_release_direct(indio_dev);
> +		if (ret)
> +			return ret;
> +
> +		switch (chan->scan_index) {
> +		case MAX86150_IDX_PPG_RED:
> +			*val = ppg_red;
> +			break;
> +		case MAX86150_IDX_PPG_IR:
> +			*val = ppg_ir;
> +			break;
> +		case MAX86150_IDX_ECG:
> +			*val = ecg;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		return IIO_VAL_INT;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_info max86150_iio_info = {
> +	.read_raw         = max86150_read_raw,
> +	.validate_trigger = iio_trigger_validate_own_device,

Will probably go away. See comments below on appropriateness of using a trigger
or triggered buffer when a fifo is present.

> +};
> +
> +/* Trigger */
Drop. See below.
> +
> +/*
> + * Control device power and the FIFO almost-full interrupt when the IIO
> + * triggered buffer is started (state=true) or stopped (state=false).
> + *
> + * On start: wake from shutdown, flush stale FIFO data so the first
> + * samples pushed to userspace are from after buffer enable, then
> + * unmask the A_FULL interrupt.
> + *
> + * On stop: mask the interrupt, then return to shutdown so the LED
> + * drivers do not draw current while capture is inactive.
> + */
> +static int max86150_set_trigger_state(struct iio_trigger *trig, bool state)
> +{
> +	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
> +	struct max86150_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	if (!state) {
> +		ret = regmap_write(data->regmap, MAX86150_REG_INT_ENABLE1, 0);
> +		regmap_update_bits(data->regmap, MAX86150_REG_SYS_CTRL,
> +				   MAX86150_SYS_SHDN, MAX86150_SYS_SHDN);

regmap_set_bits()

> +		return ret;
> +	}
> +
> +	ret = regmap_update_bits(data->regmap, MAX86150_REG_SYS_CTRL,
> +				 MAX86150_SYS_SHDN, 0);

regmap_clear_bits().
Though if this fails setting it to SYS_SHDN makes little sense - it is probably
already in that state.

> +	if (!ret)
> +		ret = regmap_write(data->regmap, MAX86150_REG_FIFO_WR_PTR, 0);
> +	if (!ret)
> +		ret = regmap_write(data->regmap, MAX86150_REG_OVF_COUNTER, 0);
> +	if (!ret)
> +		ret = regmap_write(data->regmap, MAX86150_REG_FIFO_RD_PTR, 0);
> +	if (!ret)
> +		ret = regmap_write(data->regmap, MAX86150_REG_INT_ENABLE1,
> +				   MAX86150_INT_A_FULL);
> +	if (ret)

Either use a label and error blcok, or a helper function so all the
if (!ret) stuff above can be replace with goto err / returns as appropriate.
Given you call this shutdown in all cases a helper is probably easier.

> +		regmap_update_bits(data->regmap, MAX86150_REG_SYS_CTRL,
> +				   MAX86150_SYS_SHDN, MAX86150_SYS_SHDN);
> +	return ret;
> +}
> +
> +static const struct iio_trigger_ops max86150_trigger_ops = {
> +	.set_trigger_state = max86150_set_trigger_state,
> +};
> +
> +/* Triggered buffer */

See below - another comment to drop.

> +
> +/**
> + * max86150_trigger_handler - threaded IRQ handler for FIFO almost-full
> + *
> + * Called by the IIO buffer infrastructure when the hardware trigger fires.
> + * Reads INT_STATUS1 to de-assert the interrupt, then drains all available
> + * FIFO samples into the IIO push buffer, packing only the channels that
> + * are currently enabled in active_scan_mask.
> + */
> +static irqreturn_t max86150_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func	*pf   = p;
> +	struct iio_dev		*idev = pf->indio_dev;
> +	struct max86150_data	*data = iio_priv(idev);
> +	unsigned int status, wr_ptr, rd_ptr, ovf;
> +	u32 ppg_red, ppg_ir;
> +	s32 ecg;
> +	s64 t_drain = 0;
> +	int ret, n_avail, i, j;
> +
> +	/*
> +	 * Reading INT_STATUS1 clears the interrupt.  Do this before touching
> +	 * the FIFO so the pin is de-asserted while we drain samples.

Why?  What's the chance of a race if a sample comes in whilst you are
reading?

> +	 */
> +	ret = regmap_read(data->regmap, MAX86150_REG_INT_STATUS1, &status);
> +	if (ret)
> +		goto done;
> +
> +	ret = regmap_read(data->regmap, MAX86150_REG_FIFO_WR_PTR, &wr_ptr);
> +	if (ret)
> +		goto done;
> +	ret = regmap_read(data->regmap, MAX86150_REG_FIFO_RD_PTR, &rd_ptr);
> +	if (ret)
> +		goto done;
> +
> +	/*
> +	 * OVF_COUNTER: if non-zero the FIFO overflowed; drain all 32 slots.
> +	 * When wr_ptr == rd_ptr with no overflow the FIFO could be empty OR
> +	 * hold exactly MAX86150_FIFO_DEPTH entries (pointer wrap-around).
> +	 * Use the A_FULL status bit to disambiguate: if the IRQ fired for
> +	 * A_FULL but the computed count is zero, the FIFO wrapped to full.
> +	 */
> +	ret = regmap_read(data->regmap, MAX86150_REG_OVF_COUNTER, &ovf);
> +	if (ret)
> +		goto done;
> +
> +	if (ovf > 0) {
> +		n_avail = MAX86150_FIFO_DEPTH;
> +		t_drain = ktime_get_ns();
> +	} else {
> +		n_avail = (wr_ptr - rd_ptr) & (MAX86150_FIFO_DEPTH - 1);
> +		if (n_avail == 0 && (status & MAX86150_INT_A_FULL))
> +			n_avail = MAX86150_FIFO_DEPTH;
> +	}
> +
> +	/*
> +	 * In the normal (no-overflow) case, anchor timestamps to the A_FULL
> +	 * IRQ capture time: sample index (A_FULL_SAMPLES - 1) corresponds to
> +	 * pf->timestamp, eliminating scheduling-latency jitter.
> +	 *
> +	 * In the overflow case the hardware has overwritten the oldest samples;
> +	 * pf->timestamp reflects an earlier A_FULL event and is no longer a
> +	 * valid anchor.  t_drain (set above) is used as a best-effort reference
> +	 * for the newest surviving sample instead.

Normal overflow case would be to drop everything as we don't know the
status. Why attempt to handle?

> +	 */
> +	for (i = 0; i < n_avail; i++) {
> +		s64 ts;
> +
> +		if (ovf > 0)
> +			ts = t_drain -
> +			     (s64)(n_avail - 1 - i) * data->sample_period_ns;
> +		else
> +			ts = pf->timestamp +
> +			     (s64)(i - (MAX86150_A_FULL_SAMPLES - 1)) *
> +			     data->sample_period_ns;
> +
> +		ret = max86150_read_one_sample(data, &ppg_red, &ppg_ir, &ecg);
> +		if (ret)
> +			break;
> +
> +		/*
> +		 * Zero the entire buffer before packing so padding bytes
> +		 * between enabled channels do not leak previous sample data
> +		 * to userspace when fewer than 3 channels are active.

We don't care about that leak.  Userspace is wrong if it reads it and there
is no security concern. So generally we don't do this clear.

> +		 */
> +		memset(data->buf, 0, sizeof(data->buf));
> +
> +		/*
> +		 * Pack only active channels at consecutive positions [0..j-1].
> +		 * iio_push_to_buffers_with_timestamp() uses scan_bytes (which
> +		 * accounts for the active channel count) to place the timestamp,
> +		 * so static indexing would misplace it when fewer than 3
> +		 * channels are enabled.

Might be cleaner to use available_scan that includes the full set of channels
then let the IIO core buffer demux deal with the data mangling.  However
you need to mangle anyway to make space for the timestamp so I guess this is fine.

> +		 */
> +		j = 0;
> +		if (test_bit(MAX86150_IDX_PPG_RED, idev->active_scan_mask))
> +			data->buf[j++] = ppg_red;
> +		if (test_bit(MAX86150_IDX_PPG_IR, idev->active_scan_mask))
> +			data->buf[j++] = ppg_ir;
> +		if (test_bit(MAX86150_IDX_ECG, idev->active_scan_mask))
> +			data->buf[j++] = ecg;
> +
> +		iio_push_to_buffers_with_timestamp(idev, data->buf, ts);
Use iio_push_to_buffers_with_ts()

> +	}
> +
> +done:
> +	iio_trigger_notify_done(idev->trig);
> +	return IRQ_HANDLED;
> +}
> +
> +/* Chip initialisation / teardown */

As below - remove these code structure comments from a driver
prior to submitting.

> +
> +static void max86150_powerdown(void *arg)
> +{
> +	struct max86150_data *data = arg;
> +
> +	regmap_write(data->regmap, MAX86150_REG_INT_ENABLE1, 0);
> +	regmap_write(data->regmap, MAX86150_REG_SYS_CTRL, MAX86150_SYS_SHDN);
> +}
> +
> +static int max86150_chip_init(struct max86150_data *data)
> +{
> +	int ret;
> +
> +	/* Software reset; the bit self-clears within 1 ms */
> +	ret = regmap_write(data->regmap, MAX86150_REG_SYS_CTRL,
> +			   MAX86150_SYS_RESET);
> +	if (ret)
> +		return ret;
> +	usleep_range(1000, 2000);

fsleep()

> +
> +	/*
> +	 * FIFO: no sample averaging, rollover enabled, assert A_FULL when
> +	 * 17 samples are in the FIFO (32 - 15 = 17 available to read).
> +	 */
> +	ret = regmap_write(data->regmap, MAX86150_REG_FIFO_CONFIG,
> +			   MAX86150_FIFO_ROLLOVER_EN |
> +			   FIELD_PREP(MAX86150_FIFO_A_FULL,
> +				      MAX86150_FIFO_A_FULL_VAL));
> +	if (ret)
> +		return ret;
> +
> +	/* Slot 1 = PPG Red (LED1), Slot 2 = PPG IR (LED2) */
> +	ret = regmap_write(data->regmap, MAX86150_REG_FIFO_DCTRL1,
> +			   FIELD_PREP(MAX86150_FIFO_FD1, MAX86150_FD_LED1) |
> +			   FIELD_PREP(MAX86150_FIFO_FD2, MAX86150_FD_LED2));
> +	if (ret)
> +		return ret;
> +
> +	/* Slot 3 = ECG, Slot 4 = disabled */
> +	ret = regmap_write(data->regmap, MAX86150_REG_FIFO_DCTRL2,
> +			   FIELD_PREP(MAX86150_FIFO_FD3, MAX86150_FD_ECG) |
> +			   FIELD_PREP(MAX86150_FIFO_FD4, MAX86150_FD_NONE));
> +	if (ret)
> +		return ret;
> +
> +	/* PPG: 100 Hz sample rate, 16384 nA ADC full-scale range */
> +	ret = regmap_write(data->regmap, MAX86150_REG_PPG_CONFIG1,
> +			   FIELD_PREP(MAX86150_PPG_ADC_RGE,
> +				      MAX86150_PPG_ADC_RGE_16384) |
> +			   FIELD_PREP(MAX86150_PPG_SR,
> +				      MAX86150_PPG_SR_100HZ));
> +	if (ret)
> +		return ret;
> +
> +	/* LED pulse amplitudes (~50 mA) */
> +	ret = regmap_write(data->regmap, MAX86150_REG_LED1_PA,
> +			   MAX86150_LED_PA_DEFAULT);
Better to have a define that describes the 50mA part in the name than calling
it default.
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(data->regmap, MAX86150_REG_LED2_PA,
> +			   MAX86150_LED_PA_DEFAULT);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Record sample period for timestamp reconstruction in the trigger
> +	 * handler.  The PPG_SR field is fixed to 100 Hz in this driver.
> +	 */
> +	data->sample_period_ns = 10000000; /* 100 Hz = 10 ms */

Use some defined multipliers to avoid having lots of 0s.
I haven't figured out what is appropriate here.  Maybe 10 * NANO / MILLI;

> +
> +	/*
> +	 * Assert SYS_SHDN so the LED drivers do not draw current while
> +	 * the driver is bound but no capture is active.
> +	 * set_trigger_state() clears SHDN when the IIO buffer is enabled
> +	 * and re-asserts it when disabled.  read_raw() wakes and sleeps
> +	 * the device around each single-shot read.
> +	 */
> +	return regmap_write(data->regmap, MAX86150_REG_SYS_CTRL,
> +			    MAX86150_SYS_SHDN);
> +}
> +
> +/* Probe */

Remove these 'code' structure comments. They are just noise
and can easily become wrong in an upstream driver.

> +
> +static int max86150_probe(struct i2c_client *client)
> +{
> +	struct iio_dev		*indio_dev;
> +	struct max86150_data	*data;
> +	unsigned int		 part_id;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data      = iio_priv(indio_dev);

I would never bother trying to force indent. It doesn't make the code
much easier to read and results in huge amounts of churn when the indent
needs to be changed.  Better to not bother in the first place. Note this
applies to the variable declarations above as well.

> +	data->dev = &client->dev;
> +
> +	/*
> +	 * Enable power supplies before any I2C access.  Both supplies are
> +	 * optional in the device tree; use _optional variant so probing
> +	 * succeeds on boards that power the device from fixed rails with no
> +	 * DT regulator node.

Turning supplies one before talking to device is kind of normal. So no need
for comment.  However, I'm very suspicious.  Why are these optional?
They should be required in the binding, though that doesn't actually mean
they need to be there for the driver to work. Look at how the regulator
subsystem provides stub regulators.

> +	 */
> +	ret = devm_regulator_get_enable_optional(&client->dev, "vdd");
Is this vdd_dig on the datasheet?  If so should match that naming.

I'd also suggest a local struct device *dev = &client->dev; as it is used
a lot.

> +	if (ret && ret != -ENODEV)
> +		return dev_err_probe(&client->dev, ret,
> +				     "Failed to get/enable vdd supply\n");
> +
> +	ret = devm_regulator_get_enable_optional(&client->dev, "avdd");

Not sure what supply this is.  VDD_ANA maybe?   Generally we match
datasheet naming rather than trying to map to 'standard' names.

> +	if (ret && ret != -ENODEV)
> +		return dev_err_probe(&client->dev, ret,
> +				     "Failed to get/enable avdd supply\n");
> +
> +	ret = devm_regulator_get_enable_optional(&client->dev, "vref");

Looking at the datasheet, that isn't a supply.

> +	if (ret && ret != -ENODEV)
> +		return dev_err_probe(&client->dev, ret,
> +				     "Failed to get/enable vref supply\n");
> +
> +	ret = devm_regulator_get_enable_optional(&client->dev, "leds");
> +	if (ret && ret != -ENODEV)
> +		return dev_err_probe(&client->dev, ret,
> +				     "Failed to get/enable leds supply\n");
> +
> +	data->regmap = devm_regmap_init_i2c(client, &max86150_regmap_config);
> +	if (IS_ERR(data->regmap))
> +		return dev_err_probe(&client->dev, PTR_ERR(data->regmap),
> +				     "Failed to initialise regmap\n");
> +
> +	ret = regmap_read(data->regmap, MAX86150_REG_PART_ID, &part_id);
> +	if (ret)
> +		return dev_err_probe(&client->dev, ret,
> +				     "Cannot read part ID\n");
> +
> +	if (part_id != MAX86150_PART_ID_VAL)

Print a message but carry on.  Rejecting like this prevents use of fully
backwards compatible via dt fallback compatibles.  Hence we don't do it
in modern drivers and are slowly fixing existing drivers not to do this.

> +		return dev_err_probe(&client->dev, -ENODEV,
> +				     "Unexpected part ID 0x%02x (expected 0x%02x)\n",
> +				     part_id, MAX86150_PART_ID_VAL);
> +
> +	ret = max86150_chip_init(data);
> +	if (ret)
> +		return dev_err_probe(&client->dev, ret,
> +				     "Chip initialisation failed\n");
> +
> +	ret = devm_add_action_or_reset(&client->dev, max86150_powerdown, data);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->name         = "max86150";
> +	indio_dev->channels     = max86150_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(max86150_channels);
> +	indio_dev->info         = &max86150_iio_info;
> +	indio_dev->modes        = INDIO_DIRECT_MODE;

As above, forcing indent is a recipe for churn over time.

> +
> +	/*
> +	 * If the device tree provides an interrupt, set up a hardware
> +	 * trigger so userspace can use the FIFO almost-full signal to
> +	 * drive capture without polling.
> +	 */

Not sure this adds anything we can't immediately see from the code.

> +	if (client->irq > 0) {
> +		unsigned long irq_trig;
> +
> +		data->trig = devm_iio_trigger_alloc(&client->dev,
> +						    "%s-dev%d",
> +						    indio_dev->name,
> +						    iio_device_id(indio_dev));
> +		if (!data->trig)
> +			return -ENOMEM;
> +
> +		data->trig->ops = &max86150_trigger_ops;
> +		iio_trigger_set_drvdata(data->trig, indio_dev);
> +
> +		/*
> +		 * Honour the interrupt trigger type from the device tree.
> +		 * Fall back to falling-edge if the DT does not specify one.

No. Do what DT says.  We only paper over settings where we had them wrong
and can't now fix it.

> +		 *
> +		 * Use a threaded IRQ with IRQF_ONESHOT so that level-triggered
> +		 * lines are kept masked until max86150_trigger_handler reads
> +		 * INT_STATUS1 and de-asserts the interrupt.  A hard handler
> +		 * returning IRQ_HANDLED without clearing the source would cause
> +		 * an immediate re-fire loop on active-low level interrupts.

Don't think we need this comment either.

> +		 */
> +		irq_trig = irq_get_trigger_type(client->irq);
> +		if (!irq_trig)
> +			irq_trig = IRQF_TRIGGER_FALLING;
> +
> +		ret = devm_request_threaded_irq(&client->dev, client->irq,
> +						NULL,
> +						iio_trigger_generic_data_rdy_poll,
> +						irq_trig | IRQF_ONESHOT,
> +						"max86150", data->trig);
> +		if (ret)
> +			return dev_err_probe(&client->dev, ret,
> +					     "Cannot request IRQ %d\n",
> +					     client->irq);
> +
> +		ret = devm_iio_trigger_register(&client->dev, data->trig);
> +		if (ret)
> +			return dev_err_probe(&client->dev, ret,
> +					     "Cannot register trigger\n");
> +
> +		/*
> +		 * Set the default trigger so userspace can enable the buffer
> +		 * without a manual current_trigger write.  iio_device_unregister()
> +		 * calls iio_trigger_put() to release this reference.
> +		 */
> +		indio_dev->trig = iio_trigger_get(data->trig);

This is using a fifo, so a trigger is probably inappropriate.  Look at other
fifo equipped parts and now they use a kfifo buffer directly.
 
> +	}
> +
> +	ret = devm_iio_triggered_buffer_setup(&client->dev, indio_dev,
> +					      iio_pollfunc_store_time,
> +					      max86150_trigger_handler,
> +					      NULL);

With a fifo involved, I doubt using a triggered buffer makes sense either.

> +	if (ret)
> +		return dev_err_probe(&client->dev, ret,
> +				     "Cannot setup triggered buffer\n");
> +
> +	return devm_iio_device_register(&client->dev, indio_dev);
> +}
> +
> +/* I2C driver table */
That comment doesn't add anything we can't see by looking at the code
so drop it.
> +
> +static const struct i2c_device_id max86150_id[] = {
> +	{ "max86150" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, max86150_id);

