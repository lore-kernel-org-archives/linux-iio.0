Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5739E397E8E;
	Tue, 23 Jun 2026 20:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782247929; cv=none; b=FO0+FGLL+/mX+PYNRC2UJ+OyUIvRUGdoihQa2/hcClQby39qrDLxfqYPmG+xJDETGEed/OgjFWDycVtdzIEhpxskwTGnTeglF1aZs3ZRbrKzQHkhEH5ug1UafJyPNe23iY01KV6/Ve1tjIXIOswegBRl8x92a5DH9jpJaS7z9KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782247929; c=relaxed/simple;
	bh=vj+bAFXBaNPf/PssSM32Z7h6RLcnO7P6QhxxGQl7m2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=efelCdm8zwZmqm+OUvryRdpZjMaDMTV7bTDIMKwE8odHTyMxgnu++N+4LeYT0+nh5H2WY1G5064+TsrhXGX1KwcIw0ymWqvYmc6Qo87hN3urwhyZuAhtHYVaef0/E1A4jEvyTBbHOrtS+MsY98IH8d3XJOnkasunloWETjM1tqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d+VeWQFH; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d+VeWQFH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782247928; x=1813783928;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vj+bAFXBaNPf/PssSM32Z7h6RLcnO7P6QhxxGQl7m2k=;
  b=d+VeWQFHnWP60nH+qx7kQlq3Bykn+XeKL830fm5qelra4TvjtAmnzqZo
   A9q0t6WE9ImiiZmr0VtRb966Gyhg5RdnBC1L7rI0/Qpua1KrcGa9hwpGT
   PWCb7As7gSN1ue/MkWJykOf6yeBK+BNASYKOISC4+vbdfjXZHkfYsWlOx
   XwYUAe5fzKqdq5JJcnmHAXI4WD/KV+xnzyIIKHPAiEJvda02u7drOJWp7
   EQ2Z9wW+Jn5ZAX3+c67Wrb3zKf45qSwBh4u3aho3MK5XpcYFGrd328+Dm
   4cnXfS0GuP5Gq+DL4Tfx2S9PKTREI6pzZgteYsycojimK5UMzpIEHxDfn
   w==;
X-CSE-ConnectionGUID: ZKOm6F5iSpKhpW35tJvQ6A==
X-CSE-MsgGUID: /oVlR240SUasqvKGDrTP9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="83192866"
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; 
   d="scan'208";a="83192866"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 13:52:07 -0700
X-CSE-ConnectionGUID: q/keMw+uT3SGofOOKKRIWQ==
X-CSE-MsgGUID: bywInn2oTmWd7Vy34mbboQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; 
   d="scan'208";a="246707841"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.7])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 13:52:03 -0700
Date: Tue, 23 Jun 2026 23:52:01 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Md Shofiqul Islam <shofiqtest@gmail.com>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, lars@metafoo.de,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] iio: health: add MAX86150 ECG and PPG biosensor
 driver
Message-ID: <ajrx8YL63a-avx38@ashevche-desk.local>
References: <20260623155556.13701-1-shofiqtest@gmail.com>
 <20260623174600.17100-1-shofiqtest@gmail.com>
 <20260623174600.17100-3-shofiqtest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623174600.17100-3-shofiqtest@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 23, 2026 at 08:45:59PM +0300, Md Shofiqul Islam wrote:
> The MAX86150 (Maxim/Analog Devices) combines two PPG optical channels
> (Red/IR LED) and one ECG biopotential channel in a single I2C device with
> a 32-entry hardware FIFO.
> 
> Driver features:
>  - Three IIO channels: in_intensityred_raw, in_intensityir_raw,
>    in_voltage0_raw
>  - Triggered buffer path driven by the FIFO almost-full interrupt;
>    set_trigger_state enables/disables the interrupt only while the buffer
>    is active and FIFO is flushed before capture starts
>  - validate_trigger = iio_trigger_validate_own_device prevents
>    incompatible external triggers from being attached
>  - IRQ trigger type taken from irq_get_trigger_type() to honour DT
>    configuration; falls back to falling-edge if unspecified
>  - fifo_raw burst-read buffer is heap-allocated in struct max86150_data
>    and aligned to ARCH_DMA_MINALIGN to satisfy DMA mapping requirements
>    of I2C host controllers that use DMA for burst reads
>  - SYS_SHDN asserted at end of chip_init so LED drivers draw no current
>    when capture is inactive; set_trigger_state() and read_raw() wake and
>    sleep the device on demand
>  - Per-sample timestamps anchored to the A_FULL IRQ capture time: the
>    sample at index (A_FULL_SAMPLES - 1) maps to pf->timestamp, samples
>    accumulated after the IRQ receive future timestamps, eliminating
>    load-dependent jitter
>  - FIFO empty vs exactly-full disambiguation: when wr_ptr == rd_ptr with
>    OVF_COUNTER == 0, the A_FULL status bit distinguishes a pointer
>    wrap-around (full) from a genuinely empty FIFO
>  - devm_regulator_get_enable_optional() for the two optional supplies;
>    -ENODEV is treated as success (supply absent, not an error)
>  - Powerdown devm action disables interrupts and asserts SYS_SHDN

...

>  endmenu
>  
> +

Single blank line is enough.

> +config MAX86150

...

IWYU, please! (The list of missing headers below may not be comprehensive.)

+ array_size.h

> +#include <linux/bitfield.h>

+ bitops.h // GENMASK(), sign_extend32()

> +#include <linux/delay.h>

+ dev_printk.h // dev_err_probe()
+ device/devres.h // devm_add_action_or_reset()

+ err.h // IS_ERR(), -ENOMEM, ...

> +#include <linux/i2c.h>
> +#include <linux/irq.h>

> +#include <linux/iio/buffer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>

Can we move this group out...

> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>

+ types.h // uXX, sXX

> +

...to be here?

...

> +/* Scan element indices */
> +enum max86150_scan_idx {
> +	MAX86150_IDX_PPG_RED = 0,
> +	MAX86150_IDX_PPG_IR  = 1,
> +	MAX86150_IDX_ECG     = 2,
> +	MAX86150_IDX_TS,

Why no value for TS? Or why values for the rest? I assume it's HW/SW cases?

> +};

> +/**
> + * struct max86150_data - driver private state
> + * @regmap:           register map for this device
> + * @dev:              parent device (for dev_err logging)
> + * @trig:             IIO hardware trigger backed by the device interrupt line
> + * @sample_period_ns: sample period in nanoseconds (set from configured rate)
> + * @fifo_raw:         DMA-safe buffer for regmap_noinc_read() FIFO bursts;
> + *                    must be in struct (heap) not on the stack to satisfy
> + *                    DMA mapping requirements of some I2C host controllers
> + * @buf:              IIO push buffer sized for worst-case (all 3 channels
> + *                    active): 3 x s32 (12 bytes) + 4-byte pad + s64
> + *                    timestamp = 24 bytes.  __aligned(8) satisfies
> + *                    iio_push_to_buffers_with_timestamp().
> + */
> +struct max86150_data {
> +	struct regmap		*regmap;
> +	struct device		*dev;

Is regmap device and dev is the same? If so, drop one and derive the other.

> +	struct iio_trigger	*trig;
> +	u32			 sample_period_ns;

> +	u8			 fifo_raw[MAX86150_SAMPLE_BYTES] __aligned(ARCH_DMA_MINALIGN);
> +	s32 buf[6] __aligned(8);

We have a macro for these. (For alignment.)

> +};

...

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

Casting to u32 makes a little sense. Why?

> +	/* Bytes [3..5]: PPG IR - same format */
> +	*ppg_ir  = (u32)(data->fifo_raw[3] & 0x07) << 16 |
> +		   (u32)data->fifo_raw[4] << 8 | data->fifo_raw[5];
> +
> +	/* Bytes [6..8]: ECG - 18-bit signed, sign-extend to s32 */
> +	*ecg = sign_extend32((u32)(data->fifo_raw[6] & 0x03) << 16 |
> +			     (u32)data->fifo_raw[7] << 8 | data->fifo_raw[8], 17);

Ditto for all these...

> +	return 0;
> +}

...

> +static int max86150_read_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int *val, int *val2, long mask)
> +{
> +	struct max86150_data *data = iio_priv(indio_dev);
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

No, use regular pattern, id est

		if (ret)
			return ret;

Ditto for other cases like this.


> +		}
> +
> +		/* Wait for one complete sample period at 100 Hz (<= 10 ms) */
> +		usleep_range(11000, 13000);
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

...

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

_set_bits(), but why no check?

> +		return ret;
> +	}
> +
> +	ret = regmap_update_bits(data->regmap, MAX86150_REG_SYS_CTRL,
> +				 MAX86150_SYS_SHDN, 0);
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
> +		regmap_update_bits(data->regmap, MAX86150_REG_SYS_CTRL,
> +				   MAX86150_SYS_SHDN, MAX86150_SYS_SHDN);
> +	return ret;

Ditto.

...

Also why not to split to trigger_enable and trigger_disable?

_trigger_enable(max86150_data *data)

_trigger_disable(...)


_set_trigger_state()

	if (enable)
		return _trigger_enable()

	return trigger_disable();

> +}

...

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
> +	int ret, n_avail, i, j;

Usually it's not a good idea to mix ret with other variables that not
semantically related. Also, why those are signed?

> +	/*
> +	 * Reading INT_STATUS1 clears the interrupt.  Do this before touching
> +	 * the FIFO so the pin is de-asserted while we drain samples.
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
> +	} else {
> +		n_avail = (wr_ptr - rd_ptr) & (MAX86150_FIFO_DEPTH - 1);
> +		if (n_avail == 0 && (status & MAX86150_INT_A_FULL))
> +			n_avail = MAX86150_FIFO_DEPTH;
> +	}
> +
> +	/*
> +	 * Anchor timestamps to the A_FULL IRQ capture time: sample index
> +	 * (MAX86150_A_FULL_SAMPLES - 1) corresponds to pf->timestamp.
> +	 * Samples that accumulated between the IRQ and handler execution
> +	 * receive timestamps in the future relative to the IRQ, eliminating
> +	 * load-dependent jitter in multi-sample drains.
> +	 */
> +	for (i = 0; i < n_avail; i++) {

	for (unsigned int i = 0; i < n_avail; i++) {

> +		s64 ts = pf->timestamp +
> +			 (s64)(i - (MAX86150_A_FULL_SAMPLES - 1)) *
> +			 data->sample_period_ns;

This is unmaintainable. Split definition and assignment. Also, do you really
need a casting? I.o.w. isn't pf->timestamp already an s64?

> +		ret = max86150_read_one_sample(data, &ppg_red, &ppg_ir, &ecg);
> +		if (ret)
> +			break;
> +
> +		/*
> +		 * Zero the entire buffer before packing so padding bytes
> +		 * between enabled channels do not leak previous sample data
> +		 * to userspace when fewer than 3 channels are active.
> +		 */
> +		memset(data->buf, 0, sizeof(data->buf));
> +
> +		/*
> +		 * Pack only active channels at consecutive positions [0..j-1].
> +		 * iio_push_to_buffers_with_timestamp() uses scan_bytes (which
> +		 * accounts for the active channel count) to place the timestamp,
> +		 * so static indexing would misplace it when fewer than 3
> +		 * channels are enabled.
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
> +	}
> +
> +done:
> +	iio_trigger_notify_done(idev->trig);
> +	return IRQ_HANDLED;
> +}
> +
> +/* Chip initialisation / teardown */
> +
> +static void max86150_powerdown(void *arg)
> +{
> +	struct max86150_data *data = arg;
> +
> +	regmap_write(data->regmap, MAX86150_REG_INT_ENABLE1, 0);
> +	regmap_write(data->regmap, MAX86150_REG_SYS_CTRL, MAX86150_SYS_SHDN);
> +}

...

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

fsleep(). Also need a reference to datasheet section, table, et cetera.

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

	10 * NSEC_PER_MSEC

from time.h.

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

...

> +/* Probe */

These comments bring no value, please, drop all of a such.

...

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

> +	data->dev = &client->dev;

A duplication. You have regmap with the same device.

> +	/*
> +	 * Enable power supplies before any I2C access.  Both supplies are
> +	 * optional in the device tree; use _optional variant so probing
> +	 * succeeds on boards that power the device from fixed rails with no
> +	 * DT regulator node.
> +	 */
> +	ret = devm_regulator_get_enable_optional(&client->dev, "vdd");
> +	if (ret && ret != -ENODEV)
> +		return dev_err_probe(&client->dev, ret,

Add

	struct device *dev = &client->dev;

to the top of the function and use everywhere.

> +				     "Failed to get/enable vdd supply\n");
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
> +
> +	/*
> +	 * If the device tree provides an interrupt, set up a hardware
> +	 * trigger so userspace can use the FIFO almost-full signal to
> +	 * drive capture without polling.
> +	 */
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

Why? Do we need to support broken DT?

> +		 */
> +		irq_trig = irq_get_trigger_type(client->irq);

> +		if (!irq_trig)
> +			irq_trig = IRQF_TRIGGER_FALLING;

Simply drop this.

> +		ret = devm_request_irq(&client->dev, client->irq,
> +				       iio_trigger_generic_data_rdy_poll,
> +				       irq_trig,
> +				       "max86150", data->trig);
> +		if (ret)

> +			return dev_err_probe(&client->dev, ret,
> +					     "Cannot request IRQ %d\n",
> +					     client->irq);

No dup messages.

> +
> +		ret = devm_iio_trigger_register(&client->dev, data->trig);
> +		if (ret)
> +			return dev_err_probe(&client->dev, ret,
> +					     "Cannot register trigger\n");
> +	}
> +
> +	ret = devm_iio_triggered_buffer_setup(&client->dev, indio_dev,
> +					      iio_pollfunc_store_time,
> +					      max86150_trigger_handler,
> +					      NULL);
> +	if (ret)
> +		return dev_err_probe(&client->dev, ret,
> +				     "Cannot setup triggered buffer\n");

So, it seems this message won't ever be printed. Drop it.

> +	return devm_iio_device_register(&client->dev, indio_dev);
> +}

-- 
With Best Regards,
Andy Shevchenko


