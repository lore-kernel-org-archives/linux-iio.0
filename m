Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98BE253B58;
	Mon, 14 Sep 2026 02:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789354793; cv=none; b=VQAWuCCDwkgwYNGgDHd5/0hWCMAKuZpGOvFw3K8eUN0Bhw6teYyVxo3hDUIRBAMpj3WOPQP4BHxzR66VLgvQnMvM0mcDIRgUs5R2A2OQUBM5/7V3gjdVDpG3EYWf4tH7y4gm+oTtuGaDGXDZrJnZ+gdye8KwD3pS54KmFDGerBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789354793; c=relaxed/simple;
	bh=j/vuMr+kvW4xhdZvDUHtBqCkmo5710zjkxCNn7/bAQ8=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=j5yqG58qtKEmrilIkSWWVbzPdENZaYFdECfiZJLBl+U1eIeLGqpl1oFPtxnod+SS2ji0kcJ5ZFHvObLenPTq/6LJT+aZxUCNvyMoEoI68ZlLkivZT+9PdxCiLvEQyZPB03i2W3eqPK4fa5RofcgammCjXOsnjq4iLC/6dYCira0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CQnLsYDr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CQnLsYDr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14CE91F000FF;
	Mon, 14 Sep 2026 02:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789354791;
	bh=ku0UdGsBA5pF/q1icn12RlKu3J/RM6ugjPnqqjVoc7g=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=CQnLsYDrTqfX2NgWh6AtyN677oW42Vf/oMezcW3BQ4Bo2Lz/6QHb9ek97MVCX3l1d
	 H5tJg4O33TPiacwhrNnkgZR9mLg7Fj0oxhmYufSmUi+Ifzaf37z57hH8gDvoBzzGIP
	 AIoXopOvCKHlb+Gqlgeek1xKV5Z1LibZsFMWrVzZL+FuYEDH7XL1NeEWbp7y63T0aI
	 rTFr+khQwqxGHvcxy73Gwkj+sekTv+L72chWJ0XP4qpiHLI0XGJWcuNoc7CNeI6RID
	 YTRODUfWuph6F+Yzl4YLFjGE6Fhz91cqxe7ApVF9dnriaLFzqyjp9va4TzYDAMbnL3
	 psCULE5cVKfLg==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v11 2/2] iio: health: add MAX86150 ECG and PPG
 biosensor driver
From: Jonathan Cameron <jic23@kernel.org>
To: Md Shofiqul Islam <shofiqtest@gmail.com>
Cc: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>, jic23@kernel.org, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, 
 krzk+dt@kernel.org, conor+dt@kernel.org, andriy.shevchenko@intel.com, 
 u.kleine-koenig@baylibre.com, joshua.crofts1@gmail.com, nuno.sa@analog.com, 
 Michael.Hennerich@analog.com, dlechner@baylibre.com, linux@analog.com, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260913104658.230422-3-shofiqtest@gmail.com>
References: <20260913104658.230422-1-shofiqtest@gmail.com>
 <20260913104658.230422-3-shofiqtest@gmail.com>
Date: Mon, 14 Sep 2026 03:59:34 +0100
Message-Id: <178935477415.496856.13726907933383299203.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=14617;
 i=jonathan.cameron@oss.qualcomm.com; h=from:subject:message-id;
 bh=j/vuMr+kvW4xhdZvDUHtBqCkmo5710zjkxCNn7/bAQ8=;
 b=owEBfwKA/ZANAwAKAVSFNJnE9BaIAcsmYgBqp2MYSrKAPtxnXSeUceR/usmshBcCLsnXa+xq2
 fXdRx2LuJGJAkUEAAEKAC8WIQRuKWazh4QGUpEmgbFUhTSZxPQWiAUCaqdjGBEcamljMjNAa2Vy
 bmVsLm9yZwAKCRBUhTSZxPQWiEq+D/917FaSh76Y8gfMsSNw9zztH0uyRq3xcvSsqG0GKBe1FNe
 1vYbbId7dK3jC9wVqbMYTKM6r5eOg0rG/+oGUHQ9bP4mJSt/HnKM/S3caICqre9FOMKyFQvJIUO
 U+RRS42B6k5VLbVGn6O1rhSHsrEd12dwRKd/p3WTMdZv3G5Lqh0GIJXOmcasq21/vx86a+YCqN0
 BYoJn0T401s4jxkytS40aYkGPqrqKGM8IUGxlGShfPdql9/0Tqq/c23Du/OcJUI5JF2XJJyYj4l
 3GXLvk7VLJu1NUCUCOkbRNfwB1sCMvKKdHMkjUFLcgboaaUaJq15Bg00+C2SpEymAO5U8alTQsS
 slPxgHpISBWDooyG9aCJf9vKjLgiqWtAWRHkTriQrlESb1RAsEWX1Ck8HblmVglVdPGfjMSTaB3
 bfdc2D37hSINzGjoTgzchtAyC4p5Bfwjcg+oP7qUnbCpf8slx/nsVplW0JJhZn80/dpw1Y4n+2o
 WBrDGg6Lar6l2sF2Mkg43ZmvQhF08NXcJmmpIAgJ2GoIDKXxvLcZInWflS/dPPdHP4neF4hYfa1
 FHqYUJkyaqHr7e4w07kl/ekwv/bTdhgswF+e88bH/wFvggSsBdFK+k0xzNcg3Syvw3teytWUGR9
 WxORz0kRWGNpNxDT6cOGT66kn3YlLqd5RF+nZxg==
X-Developer-Key: i=jonathan.cameron@oss.qualcomm.com; a=openpgp;
 fpr=6E2966B387840652912681B154853499C4F41688

> Add a new IIO driver for the Analog Devices MAX86150 integrated
> biosensor, which combines two PPG optical channels (Red/IR LED) and
> one ECG biopotential channel behind a 32-entry hardware FIFO in a
> single I2C device.
> 
> The driver registers a kfifo buffer directly, matching max30102.c in
> this directory, rather than using the trigger framework: enabling the
> buffer powers the chip up and arms the FIFO almost-full interrupt, and
> a single threaded IRQ handler drains the FIFO and pushes samples
> straight to the buffer. A part-ID check on probe rejects mismatched
> hardware before chip_init() writes any configuration blind.
> 
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Suggested-by: Joshua Crofts <joshua.crofts1@gmail.com>

These are only appropriate markings in a patch that is doing just
what was suggested, don't apply them to a whole driver.

> Assisted-by: Claude:claude-sonnet-5
> Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>

End of day with me, so this isn't the most thorough of reviews, but
a few things inline to sort out.

Thanks,

Jonathan


> diff --git a/drivers/iio/health/max86150.c b/drivers/iio/health/max86150.c
> new file mode 100644
> index 000000000000..9829edaed32b
> --- /dev/null
> +++ b/drivers/iio/health/max86150.c
> @@ -0,0 +1,658 @@



> +/**
> + * struct max86150_data - driver private state
> + * @regmap:           register map for this device
> + * @sample_period_ns: sample period in nanoseconds (set from configured rate)
> + * @fifo_raw:         scratch buffer for regmap_noinc_read() FIFO bursts; kept
> + *                    in struct (heap) rather than on the stack, since stack
> + *                    memory isn't guaranteed DMA-safe (e.g. CONFIG_VMAP_STACK)
> + *                    and some I2C host controllers DMA the read buffer
> + * @scan:             IIO push buffer; channels[] packed per active_scan_mask
> + */
> +struct max86150_data {
> +	struct regmap		*regmap;
> +	u32			 sample_period_ns;
> +	u8			 fifo_raw[MAX86150_SAMPLE_BYTES];
> +	IIO_DECLARE_DMA_BUFFER_WITH_TS(s32, scan, MAX86150_NUM_SLOTS);

Why does this sneed to be dma safe?

> +};


> +static bool max86150_volatile_reg(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case MAX86150_REG_INT_STATUS1:
> +	case MAX86150_REG_INT_STATUS2:
> +	case MAX86150_REG_FIFO_WR_PTR:
> +	case MAX86150_REG_OVF_COUNTER:
> +	case MAX86150_REG_FIFO_RD_PTR:
> +	case MAX86150_REG_FIFO_DATA:
> +		return true;
> +	default:
> +		return false;
> +	}


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
> +	*ppg_red = get_unaligned_be24(&data->fifo_raw[0]) & GENMASK(18, 0);
> +	*ppg_ir  = get_unaligned_be24(&data->fifo_raw[3]) & GENMASK(18, 0);
> +	*ecg = sign_extend32(get_unaligned_be24(&data->fifo_raw[6]) & GENMASK(17, 0), 17);

It helps readability a little to have a blank line before simple
sucess returns like this one.

> +	return 0;
> +}
> +
> +/* Does the actual work for max86150_do_read_raw(); see that function for the shutdown wrapping. */
> +static int max86150_read_raw_locked(struct max86150_data *data,

What is locked?  Direct mode is claimed and under the hood that includes
a lock but that is an implementation detail.
I was expecting to see a local lock in the caller but there isn't one.

> +				    u32 *ppg_red, u32 *ppg_ir, s32 *ecg)
> +{
There are 3 layers of wrapping going on here. That seems excesive.

> +	unsigned int ppg_rdy_status;
> +	int ret;
> +
> +	ret = regmap_clear_bits(data->regmap, MAX86150_REG_SYS_CTRL,
> +				MAX86150_SYS_SHDN);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(data->regmap, MAX86150_REG_FIFO_WR_PTR, 0);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(data->regmap, MAX86150_REG_OVF_COUNTER, 0);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(data->regmap, MAX86150_REG_FIFO_RD_PTR, 0);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Clear stale PPG_RDY from a previous session; reading
> +	 * INT_STATUS1 de-asserts any pending flags so the poll
> +	 * below waits for a genuinely new sample.
> +	 */
> +	ret = regmap_read(data->regmap, MAX86150_REG_INT_STATUS1,
> +			  &ppg_rdy_status);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Poll PPG_RDY rather than sleeping a fixed interval — the
> +	 * internal oscillator may start slower than nominal.  25 ms
> +	 * covers more than two 100 Hz sample periods.
> +	 */
> +	ret = regmap_read_poll_timeout(data->regmap,
> +				       MAX86150_REG_INT_STATUS1,
> +				       ppg_rdy_status,
> +				       ppg_rdy_status & MAX86150_INT_PPG_RDY,
> +				       USEC_PER_MSEC, 25 * USEC_PER_MSEC);
> +	if (ret)
> +		return ret;
> +
> +	return max86150_read_one_sample(data, ppg_red, ppg_ir, ecg);
> +}
> + *
> + * Take the device out of shutdown, reset the FIFO pointers, wait for the
> + * first PPG sample, and read it back.  Always returns the device to
> + * shutdown before returning, whether or not the read succeeded.
> + */
This comment isn't needed as the code is fairly obvious.
> + static int max86150_do_read_raw(struct max86150_data *data,
> +				u32 *ppg_red, u32 *ppg_ir, s32 *ecg)
> +{
> +	int ret;
> +
> +	ret = max86150_read_raw_locked(data, ppg_red, ppg_ir, ecg);
> +	regmap_set_bits(data->regmap, MAX86150_REG_SYS_CTRL, MAX86150_SYS_SHDN);
> +	return ret;

We've ended up with too many layers of wrappers. Just have this
code in the max86150_read_raw() instead of having this one.

> +}
> +


> +
> +static int max86150_buffer_predisable(struct iio_dev *indio_dev)
> +{
> +	struct max86150_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = regmap_write(data->regmap, MAX86150_REG_INT_ENABLE1, 0);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_set_bits(data->regmap, MAX86150_REG_SYS_CTRL,
> +			       MAX86150_SYS_SHDN);

Sashiko calls out that there maybe a race between an ongoing threaded
handler and this. Given the threaded hander requires use of
active_scan_masks that is a race that should be closed. The suggestion
to disable irqs is a bad one. Instead we may need to synchronize irqs
after this code has ensured we should see no new ones.
That should close the race I think

> +}



> +/*
> + * Threaded IRQ handler (primary=NULL): clears INT_STATUS1 to de-assert the
> + * line, then drains every sample currently in the FIFO and pushes each one
> + * straight to the buffer.  No trigger indirection -- enabling/disabling the
> + * buffer is what arms/disarms the interrupt, via
> + * max86150_buffer_postenable()/_predisable() above.  Matches the direct
> + * kfifo pattern max30102.c uses in this same directory.

What does this comment print us?  Very little that I can see that
we can't see from the code.  It is all standard stuff for a fifo
equiped part.

> + */
> +static irqreturn_t max86150_irq_handler(int irq, void *private)
> +{
> +	struct iio_dev *indio_dev = private;
> +	struct max86150_data *data;
> +	s64 irq_time;
> +	unsigned int status, wr_ptr, rd_ptr, ovf, n_avail;
> +	u32 ppg_red, ppg_ir;
> +	s32 ecg;
> +	int ret;
> +
> +	data = iio_priv(indio_dev);
> +	irq_time = iio_get_time_ns(indio_dev);
> +
> +	ret = regmap_read(data->regmap, MAX86150_REG_INT_STATUS1, &status);
> +	if (ret || !(status & MAX86150_INT_A_FULL))
> +		return IRQ_NONE;
> +
> +	ret = regmap_read(data->regmap, MAX86150_REG_FIFO_WR_PTR, &wr_ptr);
> +	if (ret)
> +		return IRQ_HANDLED;
> +	ret = regmap_read(data->regmap, MAX86150_REG_FIFO_RD_PTR, &rd_ptr);
> +	if (ret)
> +		return IRQ_HANDLED;
> +	ret = regmap_read(data->regmap, MAX86150_REG_OVF_COUNTER, &ovf);
> +	if (ret)
> +		return IRQ_HANDLED;
> +
> +	if (ovf > 0) {
> +		n_avail = MAX86150_FIFO_DEPTH;
> +	} else {
> +		n_avail = (wr_ptr - rd_ptr) & (MAX86150_FIFO_DEPTH - 1);
> +		/*
> +		 * wr_ptr == rd_ptr with no overflow means either empty or
> +		 * exactly 32 slots filled (pointer wrapped).  Since this
> +		 * handler only runs when A_FULL fired, the FIFO must be
> +		 * full — treat as 32 available.
> +		 */
> +		if (n_avail == 0)
> +			n_avail = MAX86150_FIFO_DEPTH;
> +	}
> +
> +	for (unsigned int i = 0; i < n_avail; i++) {
> +		unsigned int j;
> +		s64 ts;
> +
> +		if (ovf > 0)
> +			ts = irq_time -
> +			     (s64)(n_avail - 1 - i) * data->sample_period_ns;
> +		else
> +			ts = irq_time +
> +			     ((s64)i - (MAX86150_FIFO_A_FULL_SAMPLES - 1)) *
> +			     data->sample_period_ns;
> +
> +		ret = max86150_read_one_sample(data, &ppg_red, &ppg_ir, &ecg);
> +		if (ret)
> +			break;
> +
> +		memset(data->scan, 0, sizeof(data->scan));
> +		j = 0;
> +
> +		if (test_bit(MAX86150_IDX_PPG_RED, indio_dev->active_scan_mask))

These accesses to the active_scan_index are the thing that sashiko
called out as problematic if the handling is still running as we
exit buffered mode.

I'm also not sure they are useful. If you have to read all the
channels back from the device anyway, the core support for demuxing
data if you set available_scan_mask is probably a better way to handle
this.

> +			data->scan[j++] = ppg_red;
> +		if (test_bit(MAX86150_IDX_PPG_IR, indio_dev->active_scan_mask))
> +			data->scan[j++] = ppg_ir;
> +		if (test_bit(MAX86150_IDX_ECG, indio_dev->active_scan_mask))
> +			data->scan[j++] = ecg;
> +
> +		iio_push_to_buffers_with_timestamp(indio_dev, data->scan, ts);

Use the newer _with_ts() variant. This one is going away once we've
finished converting drivers over.

> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +/*
> + * This is a devm_add_action_or_reset() callback, so it can't return an
> + * error like the rest of this driver does -- dev_warn() is the only way
> + * left to surface a failed cleanup write here.

No need for the comment.  If anyone actually thinks they can add the
returns they'll rapidly figure it out!

> + */
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

So why wait 10?  We don't generally add margins as we get a bit extra
anyway from the surounding calls and datasheets tend to be
conservative.

> +	fsleep(10 * USEC_PER_MSEC);
> +
> +	/*
> +	 * FIFO_A_FULL holds (FIFO depth - samples available), i.e. how many
> +	 * free slots remain when the interrupt should fire.
> +	 */
> +	ret = regmap_write(data->regmap, MAX86150_REG_FIFO_CONFIG,
> +			   MAX86150_FIFO_ROLLOVER_EN |
> +			   FIELD_PREP_CONST(MAX86150_FIFO_A_FULL,
> +					    MAX86150_FIFO_DEPTH -
> +					    MAX86150_FIFO_A_FULL_SAMPLES));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(data->regmap, MAX86150_REG_FIFO_DCTRL1,
> +			   FIELD_PREP_CONST(MAX86150_FIFO_FD1, MAX86150_FD_LED1) |
> +			   FIELD_PREP_CONST(MAX86150_FIFO_FD2, MAX86150_FD_LED2));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(data->regmap, MAX86150_REG_FIFO_DCTRL2,
> +			   FIELD_PREP_CONST(MAX86150_FIFO_FD3, MAX86150_FD_ECG) |
> +			   FIELD_PREP_CONST(MAX86150_FIFO_FD4, MAX86150_FD_NONE));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(data->regmap, MAX86150_REG_PPG_CONFIG1,
> +			   FIELD_PREP_CONST(MAX86150_PPG_ADC_RGE,
> +					    MAX86150_PPG_ADC_RGE_16384_NA) |
> +			   FIELD_PREP_CONST(MAX86150_PPG_SR,
> +					    MAX86150_PPG_SR_SP_100_HZ));
> +	if (ret)
> +		return ret;
> +
> +	/* matches MAX86150_PPG_SR_SP_100_HZ above */
> +	data->sample_period_ns = NSEC_PER_SEC / 100;
> +
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


> +static int max86150_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct iio_dev *indio_dev;
> +	struct max86150_data *data;
> +	unsigned int part_id;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +
> +	data->regmap = devm_regmap_init_i2c(client, &max86150_regmap_config);
> +	if (IS_ERR(data->regmap))
> +		return dev_err_probe(dev, PTR_ERR(data->regmap),
> +				     "Failed to init regmap\n");
> +
> +	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(max86150_supply_names),
> +					     max86150_supply_names);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to enable supplies\n");
> +
> +	ret = regmap_read(data->regmap, MAX86150_REG_PART_ID, &part_id);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Cannot read part ID\n");
> +
> +	/*
> +	 * Deliberately fatal, not a dev_warn()+continue: chip_init() below
> +	 * writes FIFO/PPG/LED configuration blind, with no readback. A
> +	 * mismatched part ID means either the wrong device is on this
> +	 * address or the bus itself is faulty, and letting chip_init()
> +	 * write to that is a worse default than refusing to bind.

This doesn't align with the current thinking on device tree fallback
compatible handling.

If the firmware is wrong then people get to keep the pieces and
so we should at most print an informational message and then
carry on anyway.  A missmatched ID can also mean a future compatible
part that has a different ID.

Thankfully people are very careful with firmwares when there is
any chance of the bad form of smoke emerging!

-- 
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
