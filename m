Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30D2369980;
	Sat, 18 Jul 2026 06:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784357693; cv=none; b=nLnOhvO5hIPTMXOtZ4BNDX70CkVtaComTtGNqz4M37BillUhX4FVouDJLd+yWLg+GzZ/UZeOHRA6e2Vxt96jyDdgOzGOMy2KQ05Qu1OPLGT2X4GpKnpRMVYzusyMRzo7i5xotk2KLVhHAJOZhiTiPFNcAaT2EbrH/MCHA0XoSVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784357693; c=relaxed/simple;
	bh=/lf4XKteYnZckerbgGi8wrRL7qJWuDnnCGjfvOhDJCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qWf1C2GjiktZZacvFUSqwwmltypeQTlYYMKCZoZrxyLSpfDqa3XlscRBPoDL5BJpQqHVK1w7lnuwbOFCrUWUlKtaPAnphmmrk8y7WLQCOGiJQvdg1fkQdfBUN5UoiNsyvwkWangfDmCg9dNb50TJiW7du161he0qk3loAkyd8po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aHg3CcE9; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aHg3CcE9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784357691; x=1815893691;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/lf4XKteYnZckerbgGi8wrRL7qJWuDnnCGjfvOhDJCo=;
  b=aHg3CcE9xdKT1UiKJSfC42Ong/s6xxgDnaW9hOWrQ7oU99AE0ShyFxUk
   cXWOODYcv82FZqZPRDTzYMgsKEHsryd0uS9GAnDuf4ycKsxsTZKhdvF8F
   ao/MTxZhuW1U5TLPCyHa39+CdTPrNOg8bkMbyxEfq7tu76ewt2h9jxfIB
   IN4mjazaydymvQPjBnNR6cnnCJkTDxTNFG60sypEINlDQ2iQIp3VyJdh+
   IQL6ywUHyOwjcEIYCghr4ijte+kUfQUW/dlQNMCuRX3FIhblzE5dodd7y
   4ltWRvdp53cu92G8OuHLqp6M4te1WYqaxEuywBl4kYg4XpoKoFw9URNVZ
   w==;
X-CSE-ConnectionGUID: qrBrAfLzSvepFra4K60DrQ==
X-CSE-MsgGUID: 0u/63V1NT+enijmxyCM13Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11849"; a="85219475"
X-IronPort-AV: E=Sophos;i="6.25,170,1779174000"; 
   d="scan'208";a="85219475"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 23:54:50 -0700
X-CSE-ConnectionGUID: CaS0x3zrS+i+6P5zccjYpw==
X-CSE-MsgGUID: V0H5ymy2Sc+ZsL6NvUE6zA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,170,1779174000"; 
   d="scan'208";a="257613789"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.22])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 23:54:47 -0700
Date: Sat, 18 Jul 2026 09:54:44 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Md Shofiqul Islam <shofiqtest@gmail.com>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org, devicetree@vger.kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	u.kleine-koenig@baylibre.com, joshua.crofts1@gmail.com,
	nuno.sa@analog.com, Michael.Hennerich@analog.com,
	dlechner@baylibre.com, linux@analog.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 2/2] iio: health: add MAX86150 ECG and PPG biosensor
 driver
Message-ID: <alsjNBDgHm9fkp3c@ashevche-desk.local>
References: <20260717201138.1078019-1-shofiqtest@gmail.com>
 <20260717201138.1078019-3-shofiqtest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717201138.1078019-3-shofiqtest@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jul 17, 2026 at 11:11:37PM +0300, Md Shofiqul Islam wrote:
> Add a new IIO driver for the Analog Devices MAX86150 integrated
> biosensor, which combines two PPG optical channels (Red/IR LED) and
> one ECG biopotential channel in a single I2C device.
> 
> The device has a 32-entry hardware FIFO with a configurable almost-full
> interrupt. The driver uses the standard IIO hardware-trigger and
> triggered-buffer framework: a hard-irq handler reads and clears
> INT_STATUS1 to de-assert the line before calling iio_trigger_poll(),
> and the threaded trigger handler drains the FIFO and pushes samples,
> with timestamps back-calculated from the interrupt arrival time by one
> sample_period_ns per step.

> Relying on the trigger core's own
> attach/detach synchronization avoids the need for an explicit
> iio_buffer_enabled() guard or synchronize_irq() in the interrupt path.

This paragraph of such implementation details are not needed, you have already
mentioned that in the cover letter.

> Key implementation details:
> - Part ID register (0xFF) verified against 0x1E on probe; mismatched
>   devices are rejected with -ENODEV so the driver cannot bind to the
>   wrong hardware
> - Stale A_FULL and PPG_RDY status bits are cleared before arming the
>   interrupt or polling for a sample, so a previously-latched flag
>   cannot fire the handler against garbage state
> - 24-bit FIFO words decoded directly from the raw byte buffer
> - regmap_set_bits() / regmap_clear_bits() for single-direction writes
> - Device remains in shutdown between captures to suppress LED current
> - vdd, avdd, vref and leds regulators required per the datasheet power
>   tree
> - iio_get_time_ns() used for timestamps so they respect the IIO
>   device's configured clock source
> - A_FULL status bit used to detect FIFO exactly full (wr_ptr == rd_ptr
>   with OVF_COUNTER == 0) so valid samples are not silently dropped
> - No IRQ trigger-type override: the device has no register to
>   reconfigure interrupt polarity or type, so IRQF_ONESHOT with
>   whatever type firmware provides is sufficient

...

> +/* PPG ADC full-scale range (ADC_RGE field of PPG_CONFIG1) */
> +#define MAX86150_PPG_ADC_RGE_4096	0	/* 4096 nA */
> +#define MAX86150_PPG_ADC_RGE_8192	1	/* 8192 nA */
> +#define MAX86150_PPG_ADC_RGE_16384	2	/* 16384 nA */
> +#define MAX86150_PPG_ADC_RGE_32768	3	/* 32768 nA */

Why not adding a unit suffix as _nA to them?

> +
> +/* PPG sample rate (SR field of PPG_CONFIG1) - single-pulse variants */
> +#define MAX86150_PPG_SR_SP_10HZ		0
> +#define MAX86150_PPG_SR_SP_20HZ		1
> +#define MAX86150_PPG_SR_SP_50HZ		2
> +#define MAX86150_PPG_SR_SP_84HZ		3
> +#define MAX86150_PPG_SR_SP_100HZ	4
> +#define MAX86150_PPG_SR_SP_200HZ	5
> +#define MAX86150_PPG_SR_SP_400HZ	6
> +#define MAX86150_PPG_SR_SP_800HZ	7
> +#define MAX86150_PPG_SR_SP_1000HZ	8
> +#define MAX86150_PPG_SR_SP_1600HZ	9
> +#define MAX86150_PPG_SR_SP_3200HZ	10
> +/* Double-pulse variants (two LED pulses averaged per sample) */
> +#define MAX86150_PPG_SR_DP_10HZ		11
> +#define MAX86150_PPG_SR_DP_20HZ		12
> +#define MAX86150_PPG_SR_DP_50HZ		13
> +#define MAX86150_PPG_SR_DP_84HZ		14
> +#define MAX86150_PPG_SR_DP_100HZ	15
> +#define MAX86150_PPG_SR_DP_200HZ	16
> +#define MAX86150_PPG_SR_DP_400HZ	17
> +#define MAX86150_PPG_SR_DP_800HZ	18
> +#define MAX86150_PPG_SR_DP_1000HZ	19
> +#define MAX86150_PPG_SR_DP_1600HZ	20
> +#define MAX86150_PPG_SR_DP_3200HZ	21

Perhaps _Hz in all of the above (instead of HZ)?

> +/* LED pulse amplitude: 0x00 = 0 mA, step ~0.8 mA, 0x3F ~= 50 mA, 0xFF ~= 200 mA */

I am not sure where this comment is related to.

> +#define MAX86150_FIFO_DEPTH		32
> +#define MAX86150_BYTES_PER_SLOT		3
> +#define MAX86150_NUM_SLOTS		3
> +#define MAX86150_SAMPLE_BYTES		(MAX86150_NUM_SLOTS * MAX86150_BYTES_PER_SLOT)

...

> +/**
> + * struct max86150_data - driver private state
> + * @regmap:           register map for this device
> + * @trig:             IIO hardware trigger backed by the device interrupt line
> + * @sample_period_ns: sample period in nanoseconds (set from configured rate)
> + * @fifo_raw:         scratch buffer for regmap_noinc_read() FIFO bursts; kept
> + *                    in struct (heap) rather than on the stack, since stack
> + *                    memory isn't guaranteed DMA-safe (e.g. CONFIG_VMAP_STACK)
> + *                    and some I2C host controllers DMA the read buffer
> + * @scan:             IIO push buffer; channels[] packed per active_scan_mask,

> + *                    with a trailing aligned_s64 slot for the timestamp

Again. unneeded detail, it's visible from decoding _TS.

> + */
> +struct max86150_data {
> +	struct regmap		*regmap;
> +	struct iio_trigger	*trig;
> +	u32			 sample_period_ns;
> +	u8			 fifo_raw[MAX86150_SAMPLE_BYTES];
> +	IIO_DECLARE_DMA_BUFFER_WITH_TS(s32, scan, MAX86150_NUM_SLOTS);
> +};

...

> +static const struct regmap_config max86150_regmap_config = {
> +	.reg_bits     = 8,
> +	.val_bits     = 8,
> +	.max_register = MAX86150_REG_PART_ID,

No cache?

> +};

...

> +static int max86150_read_one_sample(struct max86150_data *data,
> +				    u32 *ppg_red, u32 *ppg_ir, s32 *ecg)
> +{
> +	int ret;
> +
> +	ret = regmap_noinc_read(data->regmap, MAX86150_REG_FIFO_DATA,
> +				data->fifo_raw, MAX86150_SAMPLE_BYTES);
> +	if (ret)
> +		return ret;
> +
> +	*ppg_red = (data->fifo_raw[0] & 0x07) << 16 |
> +		    data->fifo_raw[1] << 8 | data->fifo_raw[2];

Use get_unaligned_be16()

> +	*ppg_ir  = (data->fifo_raw[3] & 0x07) << 16 |
> +		    data->fifo_raw[4] << 8 | data->fifo_raw[5];

Ditto.

> +	*ecg = sign_extend32((data->fifo_raw[6] & 0x03) << 16 |
> +			      data->fifo_raw[7] << 8 | data->fifo_raw[8], 17);

Ditto.

> +	return 0;
> +}

...

> +	/*
> +	 * Poll PPG_RDY rather than sleeping a fixed interval ??? the
> +	 * internal oscillator may start slower than nominal.  25 ms
> +	 * covers more than two 100 Hz sample periods.
> +	 */
> +	ret = regmap_read_poll_timeout(data->regmap,
> +				       MAX86150_REG_INT_STATUS1,
> +				       ppg_rdy_status,
> +				       ppg_rdy_status & MAX86150_INT_PPG_RDY,
> +				       1000, 25000);

1 * USEC_PER_MSEC, 25 * USEC_PER_MSEC

> +	if (ret)
> +		goto out_shdn;
> +
> +	ret = max86150_read_one_sample(data, ppg_red, ppg_ir, ecg);

> +out_shdn:
> +	regmap_set_bits(data->regmap, MAX86150_REG_SYS_CTRL, MAX86150_SYS_SHDN);
> +	return ret;

Instead of this label and gotos, I would perhaps refactor this to two functions
and wrap the inner one with this call.

> +}

...

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

Just replace all breaks with this and drop this line.

...

> +static int max86150_trigger_disable(struct max86150_data *data)
> +{
> +	int ret;
> +
> +	ret = regmap_write(data->regmap, MAX86150_REG_INT_ENABLE1, 0);
> +	if (ret)
> +		return ret;

+ Blank line.

> +	return regmap_set_bits(data->regmap, MAX86150_REG_SYS_CTRL,
> +			       MAX86150_SYS_SHDN);
> +}

...

> +err_shdn:
> +	regmap_set_bits(data->regmap, MAX86150_REG_SYS_CTRL, MAX86150_SYS_SHDN);
> +	return ret;

See above.

...

> +static int max86150_set_trigger_state(struct iio_trigger *trig, bool state)
> +{
> +	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
> +	struct max86150_data *data = iio_priv(indio_dev);
> +
> +	if (state)
> +		return max86150_trigger_enable(data);

+ Blank line.

> +	return max86150_trigger_disable(data);
> +}

...

> +static irqreturn_t max86150_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *idev = pf->indio_dev;
> +	struct max86150_data *data = iio_priv(idev);
> +	unsigned int wr_ptr, rd_ptr, ovf, n_avail;
> +	u32 ppg_red, ppg_ir;
> +	s32 ecg;

> +	s64 t_drain = 0;

Split assignment and place it closer to the first user. Also follow reversed
xmas tree ordering here.

> +	int ret;
> +
> +	/*
> +	 * INT_STATUS1 was already read (and the interrupt de-asserted) by
> +	 * max86150_irq_handler().  Read only the FIFO pointers here.
> +	 */
> +	ret = regmap_read(data->regmap, MAX86150_REG_FIFO_WR_PTR, &wr_ptr);
> +	if (ret)
> +		goto done;
> +	ret = regmap_read(data->regmap, MAX86150_REG_FIFO_RD_PTR, &rd_ptr);
> +	if (ret)
> +		goto done;
> +	ret = regmap_read(data->regmap, MAX86150_REG_OVF_COUNTER, &ovf);
> +	if (ret)
> +		goto done;
> +
> +	if (ovf > 0) {
> +		n_avail = MAX86150_FIFO_DEPTH;
> +		t_drain = iio_get_time_ns(idev);
> +	} else {
> +		n_avail = (wr_ptr - rd_ptr) & (MAX86150_FIFO_DEPTH - 1);
> +		/*
> +		 * wr_ptr == rd_ptr with no overflow means either empty or
> +		 * exactly 32 slots filled (pointer wrapped).  Since this
> +		 * handler is only called when A_FULL fired, the FIFO must
> +		 * be full ??? treat as 32 available.
> +		 */
> +		if (n_avail == 0)
> +			n_avail = MAX86150_FIFO_DEPTH;
> +	}
> +
> +	for (unsigned int i = 0; i < n_avail; i++) {

> +		unsigned int j = 0;

Same idea here, assign 0 when it's really required.

> +		s64 ts;
> +
> +		if (ovf > 0)
> +			ts = t_drain -
> +			     (s64)(n_avail - 1 - i) * data->sample_period_ns;
> +		else
> +			ts = pf->timestamp +
> +			     ((s64)i - (MAX86150_FIFO_A_FULL_SAMPLES - 1)) *
> +			     data->sample_period_ns;
> +
> +		ret = max86150_read_one_sample(data, &ppg_red, &ppg_ir, &ecg);
> +		if (ret)
> +			break;
> +
> +		memset(data->scan, 0, sizeof(data->scan));
> +
> +		if (test_bit(MAX86150_IDX_PPG_RED, idev->active_scan_mask))
> +			data->scan[j++] = ppg_red;
> +		if (test_bit(MAX86150_IDX_PPG_IR, idev->active_scan_mask))
> +			data->scan[j++] = ppg_ir;
> +		if (test_bit(MAX86150_IDX_ECG, idev->active_scan_mask))
> +			data->scan[j++] = ecg;
> +
> +		iio_push_to_buffers_with_timestamp(idev, data->scan, ts);
> +	}
> +
> +done:
> +	iio_trigger_notify_done(idev->trig);
> +	return IRQ_HANDLED;
> +}

...

> +static void max86150_powerdown(void *arg)
> +{
> +	struct max86150_data *data = arg;
> +	struct device *dev = regmap_get_device(data->regmap);
> +	int ret;
> +
> +	ret = regmap_write(data->regmap, MAX86150_REG_INT_ENABLE1, 0);
> +	if (ret)
> +		dev_warn(dev, "Failed to disable interrupts: %d\n", ret);
> +
> +	ret = regmap_set_bits(data->regmap, MAX86150_REG_SYS_CTRL,
> +			      MAX86150_SYS_SHDN);
> +	if (ret)
> +		dev_warn(dev, "Failed to shut down device: %d\n", ret);

In other cases in the above code you haven't warn the user. Why is this
different?

> +}
> +
> +static int max86150_chip_init(struct max86150_data *data)
> +{
> +	int ret;
> +
> +	ret = regmap_write(data->regmap, MAX86150_REG_SYS_CTRL,
> +			   MAX86150_SYS_RESET);
> +	if (ret)
> +		return ret;
> +
> +	/* SYS_RESET self-clears within 1 ms (datasheet SYS_CTRL register) */
> +	fsleep(10 * USEC_PER_MSEC);
> +
> +	/*
> +	 * FIFO_A_FULL holds (FIFO depth - samples available), i.e. how many
> +	 * free slots remain when the interrupt should fire.
> +	 */
> +	ret = regmap_write(data->regmap, MAX86150_REG_FIFO_CONFIG,
> +			   MAX86150_FIFO_ROLLOVER_EN |
> +			   FIELD_PREP(MAX86150_FIFO_A_FULL,

FIELD_PREP_CONST() and in all cases when the parameters are predefined
constants.

> +				      MAX86150_FIFO_DEPTH -
> +				      MAX86150_FIFO_A_FULL_SAMPLES));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(data->regmap, MAX86150_REG_FIFO_DCTRL1,
> +			   FIELD_PREP(MAX86150_FIFO_FD1, MAX86150_FD_LED1) |
> +			   FIELD_PREP(MAX86150_FIFO_FD2, MAX86150_FD_LED2));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(data->regmap, MAX86150_REG_FIFO_DCTRL2,
> +			   FIELD_PREP(MAX86150_FIFO_FD3, MAX86150_FD_ECG) |
> +			   FIELD_PREP(MAX86150_FIFO_FD4, MAX86150_FD_NONE));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(data->regmap, MAX86150_REG_PPG_CONFIG1,
> +			   FIELD_PREP(MAX86150_PPG_ADC_RGE,
> +				      MAX86150_PPG_ADC_RGE_16384) |
> +			   FIELD_PREP(MAX86150_PPG_SR,
> +				      MAX86150_PPG_SR_SP_100HZ));
> +	if (ret)
> +		return ret;

> +	data->sample_period_ns = 10000000; /* matches MAX86150_PPG_SR_SP_100HZ above */

10 * NSEC_PER_MSEC

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
> +	return regmap_write(data->regmap, MAX86150_REG_SYS_CTRL,
> +			    MAX86150_SYS_SHDN);
> +}

...

> +	ret = devm_regulator_get_enable(dev, "leds");
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to enable leds supply\n");
> +
> +	data->regmap = devm_regmap_init_i2c(client, &max86150_regmap_config);
> +	if (IS_ERR(data->regmap))
> +		return dev_err_probe(dev, PTR_ERR(data->regmap),
> +				     "Failed to init regmap\n");

It's slightly better to start HW interactions after pure software things are
successfully done.

...

> +		/*
> +		 * The device only ever drives an active-low interrupt line;
> +		 * there is no register to reconfigure its polarity or type,
> +		 * so the trigger type from firmware needs no help here.
> +		 */
> +		ret = devm_request_threaded_irq(dev, client->irq,

> +						NULL,
> +						max86150_irq_handler,

These two can be coupled on a single line.

> +						IRQF_ONESHOT,
> +						"max86150", data->trig);
> +		if (ret)
> +			return ret;

...

> +static const struct i2c_device_id max86150_id[] = {
> +	{ "max86150" },

C99 initialisers, please.

> +	{ }
> +};

-- 
With Best Regards,
Andy Shevchenko


