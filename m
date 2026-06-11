Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230FF3195EF;
	Thu, 11 Jun 2026 13:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781182866; cv=none; b=IRO3YadBLpaMrqXAQz+JRIPzfKN6ysxe7l2xYR8ybY/F/JYZCa2S2VKIaIXqvOPv/3a1uO24DXz0aJ5wCBpxCx4HE8vCMVv5UwErf4ceG1rhmfD09kDVYIc3p3bWbh6p3xu1xIxyOa/gcRaNvnmrmdx7JQhu7fAYClfPOKboarA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781182866; c=relaxed/simple;
	bh=FRbN5r0M06L3x5Hwwu4xH54nkOoiKmnZ5wmLIs7+SOw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X2EZme7yus4bImTX1aokqnLVdn4WvL5MtVjBLlSh9U9jDiM4QSVmd30N8SQecAY1Nfc4/qHBN6xHyNRs2buoKdDndHlONgxyNw+ansiKC3+FnWIgCqEn+bJNicnfTScFxEsTm8WJXb8ELCCIxk8hX3gMihTMJLQvYlO0ValXCwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kISN8keH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kISN8keH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02D351F00899;
	Thu, 11 Jun 2026 13:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781182864;
	bh=KD1htdO2Dve0nKZm+I0eE7AN29Fseify1QXjvEQOHm0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kISN8keHZlDOdFLamM+o1UxpDbyNwhF40QArKbmXX0QSOGhJZv8u3tMb0x8DVw1Y8
	 dCKpOiVtuJr1YWZFz4c0b0b0rwRWR4ogVFC9gGRofnfEMyEj0pZG/NOyavL+bz8GWN
	 pIS93ruLID0OoVHWCzLoE43v9VO/AeQUFl9Sksf4F74Bd8Fnv2pw159zXvMHN4LyJa
	 LP0EQqJmqxUPTRb7hS7hv0Mstb3ngyllukNERQRNUUIbkX/Y7tJ2OBgH1JoQkAeOFC
	 Ob3y6Hol/LOIX6ZdpzZNFU+jUww6mmJrbeLx06igXlBp269vtMDb0erYnHZ3CIE9eh
	 0rwnv0avxqy0g==
Date: Thu, 11 Jun 2026 14:00:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nguyen Minh Tien <zizuzacker@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: adc: Add TI ADS1220 driver
Message-ID: <20260611140055.31e74a0e@jic23-huawei>
In-Reply-To: <20260610151342.44274-3-zizuzacker@gmail.com>
References: <20260610151342.44274-1-zizuzacker@gmail.com>
	<20260610151342.44274-3-zizuzacker@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Jun 2026 22:13:42 +0700
Nguyen Minh Tien <zizuzacker@gmail.com> wrote:

> Add an IIO driver for the Texas Instruments ADS1220 24-bit delta-sigma
> SPI ADC. The driver supports single-ended and differential voltage
> channels described as device-tree child nodes, per-channel programmable
> gain (exposed through scale) and data rate (exposed through sampling
> frequency), the internal 2.048V reference, an external reference via a
> regulator, or the analog supply (AVDD) as a ratiometric reference,
> single-shot conversions and a DRDY-interrupt-driven triggered buffer.
> Conversions are gated either on the DRDY interrupt or, when no interrupt
> is wired, on a data-rate-derived delay. Runtime PM powers the device down
> between conversions.
> 
> Signed-off-by: Nguyen Minh Tien <zizuzacker@gmail.com>

https://sashiko.dev/#/patchset/20260610151342.44274-1-zizuzacker%40gmail.com
Has some feedback.  Take a look, but do be aware it is sometimes wrong.
For example, it is common for SPI controllers to use buffers that are
next to each other for DMA.  Maybe it's not the intent of the DMA framework
but in practice it works.

Various comments inline

Thanks,

Jonathan

> ---
>  MAINTAINERS                  |   7 +
>  drivers/iio/adc/Kconfig      |  12 +
>  drivers/iio/adc/Makefile     |   1 +
>  drivers/iio/adc/ti-ads1220.c | 835 +++++++++++++++++++++++++++++++++++
>  4 files changed, 855 insertions(+)
>  create mode 100644 drivers/iio/adc/ti-ads1220.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 396d4e76d..1797af05c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -26661,6 +26661,13 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/iio/adc/ti,ads1119.yaml
>  F:	drivers/iio/adc/ti-ads1119.c
>  
> +TI ADS1220 ADC DRIVER
> +M:	Nguyen Minh Tien <zizuzacker@gmail.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/adc/ti,ads1220.yaml
Bring this in with the first file, so in the binding doc.
> +F:	drivers/iio/adc/ti-ads1220.c
And add this line in this patch.

> diff --git a/drivers/iio/adc/ti-ads1220.c b/drivers/iio/adc/ti-ads1220.c
> new file mode 100644
> index 000000000..06bcc8841
> --- /dev/null
> +++ b/drivers/iio/adc/ti-ads1220.c
;
> +
> +/*
> + * Available scales expressed as gain reciprocals (val / val2), matching the
> + * convention used by the sibling ti-ads1119 driver: writing 0.25 selects a
> + * gain of 4. The full list is used for differential channels; single-ended
> + * channels (which force the PGA into bypass) are limited to the first three
> + * entries (gains 1, 2, 4).

This doesn't feel right. I'd expect to see scaling including the reference voltage
so you'll have to compute the array at runtime.  Maybe we have an historical bug
in the ads1119 if it is not having it's read_raw and write_raw match values.

> + */
> +static const int ads1220_scale_avail[] = {
> +	1, 1,
> +	1, 2,
> +	1, 4,
> +	1, 8,
> +	1, 16,
> +	1, 32,
> +	1, 64,
> +	1, 128,
> +};
> +
> +#define ADS1220_SE_SCALE_AVAIL_LEN	(3 * 2)
> +#define ADS1220_SCALE_AVAIL_LEN		ARRAY_SIZE(ads1220_scale_avail)
> +
> +struct ads1220_channel_config {
> +	unsigned int mux;
> +	unsigned int gain;
> +	unsigned int datarate;
> +	bool single_ended;
> +};
> +
> +struct ads1220_state {
> +	struct spi_device *spi;
> +	struct completion completion;
> +	struct iio_trigger *trig;
> +	struct ads1220_channel_config *channels_cfg;
> +	unsigned int num_channels_cfg;
> +	int vref_uV;
> +	unsigned int vref_source;
> +
> +	/*
> +	 * DMA-safe buffers. tx is used for command/register writes, rx for
> +	 * register and conversion-result reads. scan holds one sample plus a
> +	 * timestamp for the triggered buffer.
> +	 */
> +	u8 tx[2] __aligned(IIO_DMA_MINALIGN);
> +	u8 rx[ADS1220_DATA_BYTES];
> +	struct {
> +		s32 sample;
> +		aligned_s64 timestamp;
> +	} scan;

This is accessed other than for DMA.  So if you want it in the structure
move it before the section that has forced alignment.  However, see below
- I think in this case simply using spi_write_then_read() everywhere
will be a useful simplification.

> +};
> +
> +static int ads1220_command(struct ads1220_state *st, u8 cmd)
> +{
> +	st->tx[0] = cmd;
> +
> +	return spi_write(st->spi, st->tx, 1);
> +}
> +
> +static int ads1220_write_reg(struct ads1220_state *st, u8 reg, u8 val)
> +{
> +	st->tx[0] = ADS1220_CMD_WREG_REG(reg);
> +	st->tx[1] = val;
> +
> +	return spi_write(st->spi, st->tx, 2);

Given the buffers are small, you could use spi_write_the_read() with 0 sized
read to avoid need for DMA safe buffers.  I think that would end up
a little simpler and the cost will be tiny.

> +}
> +
> +static int ads1220_read_reg(struct ads1220_state *st, u8 reg, u8 *val)
> +{
> +	int ret;
> +
> +	st->tx[0] = ADS1220_CMD_RREG_REG(reg);
> +
> +	ret = spi_write_then_read(st->spi, st->tx, 1, st->rx, 1);

Can use local variables for the buffers (it bounces the data anyway)
which might be a little simpler to read.

> +	if (ret)
> +		return ret;
> +
> +	*val = st->rx[0];
> +
> +	return 0;
> +}
> +
> +static int ads1220_reset(struct ads1220_state *st)
> +{
> +	int ret;
> +
> +	ret = ads1220_command(st, ADS1220_CMD_RESET);
> +	if (ret)
> +		return ret;
> +
> +	/* Wait at least 50us + 32 x tCLK after RESET before any command. */

Not obvious how this matches value of 100 to fsleep. Please provide
a little more info - such as what rate of tCLK is.

> +	fsleep(100);
> +
> +	return 0;
> +}

> +static int ads1220_single_conversion(struct ads1220_state *st,
> +				     const struct iio_chan_spec *chan,
> +				     int *val, bool calib_offset)
> +{
> +	struct device *dev = &st->spi->dev;
> +	struct ads1220_channel_config *cfg = &st->channels_cfg[chan->address];
> +	unsigned int mux = cfg->mux;
> +	bool single_ended = cfg->single_ended;
> +	int ret;
> +
> +	if (calib_offset) {
> +		mux = ADS1220_MUX_SHORTED;
> +		single_ended = false;
> +	}
> +
> +	ret = pm_runtime_resume_and_get(dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = ads1220_configure(st, mux, cfg->gain, cfg->datarate,
> +				single_ended, false);
> +	if (ret)
> +		goto out;
> +
> +	if (st->spi->irq)
> +		reinit_completion(&st->completion);
> +
> +	ret = ads1220_command(st, ADS1220_CMD_START);
> +	if (ret)
> +		goto out;
> +
> +	ret = ads1220_read_sample(st, cfg->datarate, val);
> +	if (ret)
> +		goto out;
> +
> +	ret = IIO_VAL_INT;
> +out:
> +	pm_runtime_mark_last_busy(dev);
> +	pm_runtime_put_autosuspend(dev);
> +
> +	return ret;
> +}
> +
> +static int ads1220_read_raw(struct iio_dev *indio_dev,
> +			    const struct iio_chan_spec *chan,
> +			    int *val, int *val2, long mask)
> +{
> +	struct ads1220_state *st = iio_priv(indio_dev);
> +	struct ads1220_channel_config *cfg = &st->channels_cfg[chan->address];
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		if (!iio_device_claim_direct(indio_dev))
> +			return -EBUSY;
> +		ret = ads1220_single_conversion(st, chan, val, false);
> +		iio_device_release_direct(indio_dev);
> +		return ret;
> +	case IIO_CHAN_INFO_OFFSET:
> +		if (!iio_device_claim_direct(indio_dev))
> +			return -EBUSY;
> +		ret = ads1220_single_conversion(st, chan, val, true);

I think a comment on why this shorted channel is appropriate for offset
would be good (and sashiko thinks you have the sign wrong)

> +		iio_device_release_direct(indio_dev);
> +		return ret;
> +	case IIO_CHAN_INFO_SCALE:
> +		/* scale [mV] = vref / (gain * 2^23); gain is a power of two. */
> +		*val = st->vref_uV / MILLI;
> +		*val2 = (chan->scan_type.realbits - 1) + ilog2(cfg->gain);
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*val = cfg->datarate;
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ads1220_read_avail(struct iio_dev *indio_dev,
> +			      const struct iio_chan_spec *chan,
> +			      const int **vals, int *type, int *length,
> +			      long mask)
> +{
> +	struct ads1220_state *st = iio_priv(indio_dev);
> +	struct ads1220_channel_config *cfg = &st->channels_cfg[chan->address];
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		*type = IIO_VAL_FRACTIONAL;
> +		*vals = ads1220_scale_avail;
> +		*length = cfg->single_ended ? ADS1220_SE_SCALE_AVAIL_LEN :
> +					      ADS1220_SCALE_AVAIL_LEN;
> +		return IIO_AVAIL_LIST;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*type = IIO_VAL_INT;
> +		*vals = ads1220_datarates;
> +		*length = ARRAY_SIZE(ads1220_datarates);
> +		return IIO_AVAIL_LIST;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ads1220_write_raw(struct iio_dev *indio_dev,
> +			     const struct iio_chan_spec *chan,
> +			     int val, int val2, long mask)
> +{
> +	struct ads1220_state *st = iio_priv(indio_dev);
> +	struct ads1220_channel_config *cfg = &st->channels_cfg[chan->address];
> +	unsigned int gain;
> +	int i;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		/* The available scales are the gain reciprocals (e.g. 1/4). */
> +		if (val == 0 && val2 == 0)
> +			return -EINVAL;
> +
> +		gain = MICRO / (val * MICRO + val2);
> +		if (!is_power_of_2(gain) || gain > BIT(ADS1220_NUM_GAINS - 1))
> +			return -EINVAL;
> +		if (cfg->single_ended && gain > ADS1220_MAX_SE_GAIN)
> +			return -EINVAL;
> +
> +		cfg->gain = gain;

Sashiko called this out.  The value written here should be the same as the
one we read back from read_raw().  If seems this one isn't taking the reference
voltage into account and should be doing so.

Sadly there is no way to reverse IIO_VAL_FRACTIONAL so to make things easier
you may have to stop using that for the avail and read_raw callbacks and instead
compute the values for IIO_VAL_INT_PLUS_MICRO

> +		return 0;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		for (i = 0; i < ARRAY_SIZE(ads1220_datarates); i++) {
> +			if (ads1220_datarates[i] == val) {
> +				cfg->datarate = val;
> +				return 0;
> +			}
> +		}
> +		return -EINVAL;
> +	default:
> +		return -EINVAL;
> +	}
> +}

> +
> +static int ads1220_buffer_preenable(struct iio_dev *indio_dev)
> +{
> +	struct ads1220_state *st = iio_priv(indio_dev);
> +	struct device *dev = &st->spi->dev;
> +	struct ads1220_channel_config *cfg;
> +	unsigned int index;
> +	int ret;
> +
> +	index = find_first_bit(indio_dev->active_scan_mask,
> +			       iio_get_masklength(indio_dev));
> +	cfg = &st->channels_cfg[index];
> +
> +	ret = pm_runtime_resume_and_get(dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = ads1220_configure(st, cfg->mux, cfg->gain, cfg->datarate,
> +				cfg->single_ended, true);
> +	if (ret)
> +		goto err;
> +
> +	ret = ads1220_command(st, ADS1220_CMD_START);
> +	if (ret)
> +		goto err;
> +
> +	return 0;
> +err:
> +	pm_runtime_mark_last_busy(dev);
> +	pm_runtime_put_autosuspend(dev);
> +	return ret;
> +}
> +
> +static int ads1220_buffer_postdisable(struct iio_dev *indio_dev)
> +{
> +	struct ads1220_state *st = iio_priv(indio_dev);
> +	struct device *dev = &st->spi->dev;
> +
> +	pm_runtime_mark_last_busy(dev);
> +	pm_runtime_put_autosuspend(dev);

Read current kernel implementation of pm_runtime_put_autosuspend()
and consider if this pair of calls makes sense any more (it used to!)

> +
> +	return 0;
> +}
> +
> +static const struct iio_buffer_setup_ops ads1220_buffer_setup_ops = {
> +	.preenable = ads1220_buffer_preenable,
> +	.postdisable = ads1220_buffer_postdisable,
> +	.validate_scan_mask = &iio_validate_scan_mask_onehot,

I haven't really thought this through but is onehot suitable for this
device?  Obvious in simple continuous conversion modes you haven't
a lot of choice, but I think a more complex SPI handling can do
the appropriate channel updates in parallel with capture of the
previous channel.   Fine to leave that until we have a user though!

> +};
> +
> +static const struct iio_trigger_ops ads1220_trigger_ops = {
> +	.validate_device = &iio_trigger_validate_own_device,
> +};

Just to check, can this device be used with other triggers?

> +
> +static int ads1220_map_mux(struct device *dev, u32 ain_pos, u32 ain_neg,
> +			   bool differential, unsigned int *mux,
> +			   bool *single_ended)
> +{
> +	static const u8 diff_mux[ADS1220_MAX_AIN][ADS1220_MAX_AIN] = {
> +		[0][1] = 0x0, [0][2] = 0x1, [0][3] = 0x2,
> +		[1][2] = 0x3, [1][3] = 0x4, [1][0] = 0x6,
> +		[2][3] = 0x5,
> +		[3][2] = 0x7,
> +	};
> +
> +	if (!differential) {
> +		if (ain_pos >= ADS1220_MAX_AIN)
> +			return -EINVAL;
> +		*mux = ADS1220_MUX_SINGLE(ain_pos);
> +		*single_ended = true;
> +		return 0;
> +	}
> +
> +	if (ain_pos >= ADS1220_MAX_AIN || ain_neg >= ADS1220_MAX_AIN)
> +		return -EINVAL;
> +
> +	/* Only the input pairs the multiplexer can route are valid. */
> +	if (ain_pos == ain_neg || (diff_mux[ain_pos][ain_neg] == 0 &&
> +				   !(ain_pos == 0 && ain_neg == 1)))

The check is a little ugly.  Maybe it would be simpler to use MAX_U8 as a
marker and fill the rest of the table above.

> +		return -EINVAL;
> +
> +	*mux = diff_mux[ain_pos][ain_neg];
> +	*single_ended = false;
> +
> +	return 0;
> +}
> +
> +static int ads1220_alloc_channels(struct iio_dev *indio_dev)
> +{
> +	const struct iio_chan_spec ads1220_channel = {
> +		.type = IIO_VOLTAGE,
> +		.indexed = 1,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE) |
> +				      BIT(IIO_CHAN_INFO_OFFSET) |
> +				      BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +		.info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE) |
> +						BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +		.scan_type = {
> +			.sign = 's',
> +			.realbits = ADS1220_DATA_BITS,
> +			.storagebits = 32,
> +			.endianness = IIO_CPU,
> +		},
> +	};
> +	const struct iio_chan_spec ads1220_ts = IIO_CHAN_SOFT_TIMESTAMP(0);

That is now a designated initializer after a recent patch from David, so you
can now avoid the local variable and assign from the macro directly.

> +	struct ads1220_state *st = iio_priv(indio_dev);
> +	struct device *dev = &st->spi->dev;
> +	struct iio_chan_spec *channels, *chan;
> +	unsigned int num_channels, i = 0;

Don't mix assigning and non assigning declarations - they are sometimes hard
to read (though obviously this simple one isn't too bad!)

> +	int ret;
> +
> +	st->num_channels_cfg = device_get_child_node_count(dev);
> +	if (st->num_channels_cfg == 0 ||
> +	    st->num_channels_cfg > ADS1220_MAX_CHANNELS)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Invalid channel count %u (max %u)\n",
> +				     st->num_channels_cfg, ADS1220_MAX_CHANNELS);
> +
> +	st->channels_cfg = devm_kcalloc(dev, st->num_channels_cfg,
> +					sizeof(*st->channels_cfg), GFP_KERNEL);
> +	if (!st->channels_cfg)
> +		return -ENOMEM;
> +
> +	/* One extra channel for the timestamp. */
> +	num_channels = st->num_channels_cfg + 1;
> +	channels = devm_kcalloc(dev, num_channels, sizeof(*channels),
> +				GFP_KERNEL);
> +	if (!channels)
> +		return -ENOMEM;
> +
> +	device_for_each_child_node_scoped(dev, child) {
> +		struct ads1220_channel_config *cfg = &st->channels_cfg[i];
> +		bool differential;
> +		u32 ain[2];
> +
> +		differential = fwnode_property_present(child, "diff-channels");
> +		if (differential)
> +			ret = fwnode_property_read_u32_array(child,
> +							     "diff-channels",
> +							     ain, 2);
> +		else
> +			ret = fwnode_property_read_u32(child, "single-channel",
> +						       &ain[0]);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Failed to read channel property\n");
> +
> +		ret = ads1220_map_mux(dev, ain[0], ain[1], differential,
> +				      &cfg->mux, &cfg->single_ended);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Invalid input combination\n");
> +
> +		cfg->gain = 1;
> +		cfg->datarate = ads1220_datarates[0];
> +
> +		chan = &channels[i];
> +		*chan = ads1220_channel;

I'd use a designated intializer here instead of a const that you copy.
That lets us combine a bunch of stuff into one place.


		channels[i++] = (struct iio_chan_spec) = {
			.type = IIO_VOLTAGE,
			.indexed = 1,
			.differental = differential ? 1 : 0,
			.channel = ain[0],
			.channel2 = ain[1], // just make sure this is set to 0 above.
			.address = i,
			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
					      BIT(IIO_CHAN_INFO_SCALE) |
					      BIT(IIO_CHAN_INFO_OFFSET) |
					      BIT(IIO_CHAN_INFO_SAMP_FREQ),
			.info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE) |
							BIT(IIO_CHAN_INFO_SAMP_FREQ),
			.scan_index = i,
			.scan_type = {
				.sign = 's',
				.realbits = ADS1220_DATA_BITS,
				.storagebits = 32,
				.endianness = IIO_CPU,
			},
		};

> +		chan->channel = ain[0];
> +		chan->address = i;
> +		chan->scan_index = i;
> +		if (differential) {
> +			chan->channel2 = ain[1];
> +			chan->differential = 1;
> +		}
> +
> +		i++;
> +	}
> +
> +	channels[i] = ads1220_ts;
> +	channels[i].scan_index = i;
> +
> +	indio_dev->channels = channels;
> +	indio_dev->num_channels = num_channels;
> +
> +	return 0;
> +}
> +
> +static int ads1220_init(struct ads1220_state *st)
> +{
> +	u8 reg2;
> +	int ret;
> +
> +	ret = ads1220_reset(st);
> +	if (ret)
> +		return ret;
> +
> +	reg2 = FIELD_PREP(ADS1220_CFG2_VREF, st->vref_source);
> +
> +	ret = ads1220_write_reg(st, ADS1220_REG_CONFIG2, reg2);
> +	if (ret)
> +		return ret;
> +
> +	/* DRDY only on the dedicated pin (DRDYM = 0). */
> +	return ads1220_write_reg(st, ADS1220_REG_CONFIG3, 0);

We might want something in the dt binding about the other case
not making sense.  We can't safely do interrupts on an SPI data line
(though some SoCs happen to do the right things to make that work)
so we will in general use another pin tied to that line.  If that
were the case might as well wire it to the separate pin instead.

> +}

> +
> +static int ads1220_probe(struct spi_device *spi)
> +{
> +	struct device *dev = &spi->dev;
> +	struct iio_dev *indio_dev;
> +	struct ads1220_state *st;
> +	int avdd_uV;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +	st->spi = spi;
> +	spi_set_drvdata(spi, indio_dev);
> +
> +	/* The ADS1220 uses SPI mode 1 (CPOL = 0, CPHA = 1). */
> +	spi->mode |= SPI_CPHA;
> +	spi->bits_per_word = 8;

Fairly sure that 8 is the default, so no point in setting it here.

> +	ret = spi_setup(spi);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "SPI setup failed\n");
> +
> +	indio_dev->name = "ads1220";
> +	indio_dev->info = &ads1220_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	ret = devm_regulator_get_enable(dev, "dvdd");
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to enable dvdd\n");
> +
> +	avdd_uV = devm_regulator_get_enable_read_voltage(dev, "avdd");
> +	if (avdd_uV < 0)
> +		return dev_err_probe(dev, avdd_uV, "Failed to get avdd\n");
Prefer
	ret = devm_regulator_get_enable_read_voltage(dev, "avdd");
	if (ret < 0)
		return dev_err..
	avdd_uV = ret;

Mostly because we don't need to check avdd_uV is signed and general principle
of avoiding reading it.

However, given it's fairly common to not be able to read a voltage from a regulator
you may want to only do this (rather than simply enabling it) if you need
it for a channel reference.

> +
> +	/*
> +	 * Reference source, in priority order:
> +	 *  - external reference on REFP0/REFN0 if a "vref" regulator is given;
> +	 *  - the analog supply (AVDD) for ratiometric single-supply setups if
> +	 *    "ti,vref-avdd" is set - no extra pins, full 0..AVDD input range;
> +	 *  - otherwise the internal 2.048V reference.
> +	 */
> +	st->vref_uV = devm_regulator_get_enable_read_voltage(dev, "vref");
> +	if (st->vref_uV >= 0) {
> +		st->vref_source = ADS1220_VREF_REFP0_REFN0;
> +	} else if (st->vref_uV != -ENODEV) {
> +		return dev_err_probe(dev, st->vref_uV, "Failed to get vref\n");
> +	} else if (device_property_read_bool(dev, "ti,vref-avdd")) {

As above, I'd only get the voltage on avdd here.

> +		st->vref_source = ADS1220_VREF_AVDD;
> +		st->vref_uV = avdd_uV;
> +	} else {
> +		st->vref_source = ADS1220_VREF_INTERNAL;
> +		st->vref_uV = ADS1220_INTERNAL_VREF_uV;
> +	}

> +
> +static int ads1220_runtime_resume(struct device *dev)
> +{
> +	/*
> +	 * A START/SYNC command wakes the analog parts from power-down; it is
> +	 * issued by the conversion path, so there is nothing to do here beyond
> +	 * letting the device settle after the supplies are active again.

This isn't manipulating the supplies so why do we need to wait for them?

> +	 */
> +	fsleep(100);
> +
> +	return 0;
> +}
> +
> +static DEFINE_RUNTIME_DEV_PM_OPS(ads1220_pm_ops, ads1220_runtime_suspend,
> +				 ads1220_runtime_resume, NULL);
> +
> +static const struct spi_device_id ads1220_id[] = {
> +	{ "ads1220" },

Please use a name initializer here.  We are cleaning up this across
IIO at the moment as it makes things easier to read and possible enables
more interesting spi_device_id structures in future.

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(spi, ads1220_id);

