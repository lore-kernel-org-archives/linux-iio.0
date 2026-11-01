Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793494402;
	b=T1yurlY15p+LeS/ZuP7A+EynXMgB+6ponqLT23ZkRgH1BGiHiastgM6T5i33TpQse6wZ
	 7Mpn92R9M4BBatNsJmi/aOYOH2YkTtsBXqLj/DqIaUMTSM/zfofLxHbUMWWKNDpWvgOUs
	 ltuUHIu8mfS3PX9c7JcdRmUKCUetebHYUwVOQty8PIApXNxUiYsNUGk6B4czfQ0Hx37cU
	 ZO3+DLCK9bLaWVukKnmRkxjJgRYuJlY4YRo6SB2wvNMe+F+cweKllxiAGHxcURt4YNg41
	 DXV0pr4F3oxpVLAKr0MeBw2l1ICEuY7adsb6lR5yv7TqEhq91Mt+WHKrntp2TbC/k7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793494402;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=MJTujPKcKbhM1u5YR6+YPJA992+ZO/LAIERAwqoPwtw=;
	b=uANl3BlUeVTohG+XLnHD2pbaYU1LAcH53HJY6gLDRSE9gLKdolxAKSsbloqnYPpaYvF2
	 O1XeT4NbBQg9dkr3kZzX4M+r7nTwAd0kNQC1mnQcJhwm75hG++Y+dzdoKEvfSIOp1/0QZ
	 NZrExrnFnZu6O2/FxH8BwPVO9M5FSNtdVFvOeQQPvxc7pgh4uxjLwdqPU17rIeHj+WGr6
	 JCAdMzru6HZA1w4f7S+En0e3OIYuJxazirnoP+rj+dWbyYM5lOVoarNb4Nj1oShFKiNkb
	 sggBHJgv8lyTuJcvPSRZ0QMsAfMRGKoNBiLP1X0ugCXnHHCoo0maUJtIf8tKOxSofUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mXzSNyZR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1271A606A31A;
	Sun,  1 Nov 2026 00:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mXzSNyZR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D497C1F00A17;
	Sun,  1 Nov 2026 00:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793494401;
	bh=MJTujPKcKbhM1u5YR6+YPJA992+ZO/LAIERAwqoPwtw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mXzSNyZRTMTr1vG+P2ClHhSGTF81oEo7hbrZhjRVchUc6n0sQ8oPpF0YWWXjnu8Q4
	 GrkL6SnhV9Xd8vfpcp7JVN8InbYaepxxuHvqTCdPXgXcg/npB/FtJ9xz5OfzfKc4vv
	 Vl1QHTK9R7uaOYdJptW+JZY8YBDs8rxBBdE/LNAMvmUssqaEOrKMoIpV8sKP5HxnPH
	 JrJ+ZZfmipNfCksypru+XPlQIqBltZKpU7aG7wWZFKPusLO7pUHh3CZb36JEiSaD1T
	 ThoRqvnLOz/hf4L+zC/nnWhjkf/e24sa9XPamgCy8C6Uzzv6TMtdwnDULX6OcWEEJL
	 I3TUhiasboO3w==
Date: Sun, 1 Nov 2026 00:53:12 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Chi-Wen Weng <cwweng.linux@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 cwweng@nuvoton.com
Subject: Re: [PATCH v3 2/2] iio: adc: Add Nuvoton MA35D1 EADC driver
Message-ID: <20261101005312.1ec5e393@jic23-hlaptop>
In-Reply-To: <20261030031501.130290-3-cwweng.linux@gmail.com>
References: <20261030031501.130290-1-cwweng.linux@gmail.com>
	<20261030031501.130290-3-cwweng.linux@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 30 Oct 2026 11:15:01 +0800
Chi-Wen Weng <cwweng.linux@gmail.com> wrote:

> From: Chi-Wen Weng <cwweng@nuvoton.com>
> 
> Add an IIO driver for the Enhanced Analog-to-Digital Converter (EADC)
> found on Nuvoton MA35D1 SoCs.
> 
> The driver supports direct conversion and externally triggered buffered
> capture using sample module 0. Both single-ended inputs and the four
> fixed differential input pairs are supported.
> 
> Use the internal 1.6 V reference when no external reference supply is
> provided, and report the reference voltage through the IIO scale
> interface.
> 
> Use ADINT0 for conversion completion. Configure the interrupt source
> and end-of-conversion position explicitly, and recover from conversion
> timeouts by resetting the EADC control circuits, synchronizing the IRQ
> and clearing stale conversion state before another conversion is
> started.
> 
> Reset the EADC control circuits during hardware initialization and
> sanitize interrupt, compare and sample-module trigger configuration so
> the driver does not depend on state left by firmware when the external
> reset control is unavailable.
> 
> Provide firmware-node channel translation so DT IIO consumers select
> channels by the logical channel index described by the channel node's
> reg property rather than by the position of the channel in the driver's
> channel array.
> 
> Add clock, optional reset and system sleep handling, and restore the
> controller configuration after resume.
> 
> Signed-off-by: Chi-Wen Weng <cwweng@nuvoton.com>
Hi Chi-Wen

Various comments inline.

Thanks,

Jonathan

> diff --git a/drivers/iio/adc/ma35d1_eadc.c b/drivers/iio/adc/ma35d1_eadc.c
> new file mode 100644
> index 000000000000..9b6c38a66a66
> --- /dev/null
> +++ b/drivers/iio/adc/ma35d1_eadc.c


> +
> +static int ma35d1_adc_disable_irq(struct ma35d1_adc *adc)
> +{
> +	return regmap_clear_bits(adc->regmap, MA35D1_EADC_CTL, MA35D1_EADC_CTL_ADCIEN0);
> +}
> +
> +static int ma35d1_adc_setup_reference(struct ma35d1_adc *adc)
> +{
> +	struct regmap *map = adc->regmap;
> +	int ret;
> +
> +	/*
> +	 * MA35D1 TRM EADC reference control: PDREF selects the external VREF
> +	 * pin. With the internal reference selected, VREFSEL = 0 selects 1.6 V.
> +	 */
> +	if (adc->vref) {

With change below to use the read_voltage function this would then be
using a flag set there.

> +		ret = regmap_set_bits(map, MA35D1_EADC_REFADJCTL,
> +				      MA35D1_EADC_REFADJCTL_PDREF);
> +		if (ret)
> +			return ret;
> +	} else {
> +		ret = regmap_clear_bits(map, MA35D1_EADC_REFADJCTL,
> +					MA35D1_EADC_REFADJCTL_PDREF);
> +		if (ret)
> +			return ret;
> +
> +		ret = regmap_update_bits(map, MA35D1_EADC_CTL,
> +					 MA35D1_EADC_CTL_VREFSEL_MASK,
> +					 MA35D1_EADC_CTL_VREFSEL_1V6);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	fsleep(MA35D1_EADC_REF_STABLE_US);
> +
> +	return 0;
> +}


> +static int ma35d1_adc_abort_conversion(struct ma35d1_adc *adc)
> +{
> +	struct regmap *map = adc->regmap;
> +	int ret;
> +	int err;
> +
> +	ret = ma35d1_adc_disable_irq(adc);
> +
> +	/*
> +	 * Reset the EADC control circuits to terminate a conversion which may
> +	 * still be in progress. EADCRST is cleared automatically by hardware
> +	 * when the reset completes and the EADC register values are preserved.
> +	 */
> +	err = ma35d1_adc_reset_control(adc);
> +	if (!ret)
> +		ret = err;
Why not just set ret directly for this one?
> +
> +	/* Drain an interrupt which may already have been latched by the GIC. */
> +	synchronize_irq(adc->irq);
> +
> +	err = regmap_write(map, MA35D1_EADC_STATUS2,
> +			   MA35D1_EADC_STATUS2_ADIF0);
I don't mind going slightly over 80 chars. I would do so for the line above.

> +	if (!ret)
> +		ret = err;
> +
> +	reinit_completion(&adc->completion);
Why?  It is reinit at start of read conversion - why else do we need to 
do it?  Add a comment

> +
> +	return ret;
> +}
> +
> +static int ma35d1_adc_read_conversion(struct ma35d1_adc *adc,
> +				      const struct iio_chan_spec *chan, u16 *raw)
> +{
> +	struct regmap *map = adc->regmap;
> +	unsigned int val;
> +	long timeout;
> +	int ret;
> +
> +	reinit_completion(&adc->completion);
> +
> +	ret = regmap_write(map, MA35D1_EADC_STATUS2, MA35D1_EADC_STATUS2_ADIF0);
> +	if (ret)
> +		return ret;
> +
> +	ret = ma35d1_adc_config_channel(adc, chan);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_set_bits(map, MA35D1_EADC_CTL, MA35D1_EADC_CTL_ADCIEN0);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(map, MA35D1_EADC_SWTRG, BIT(0));
> +	if (ret)
> +		goto disable_irq;
> +
> +	timeout = wait_for_completion_timeout(&adc->completion,
> +					      MA35D1_EADC_TIMEOUT);
> +	if (!timeout) {
> +		ret = ma35d1_adc_abort_conversion(adc);
> +		return ret ?: -ETIMEDOUT;

Timed out first, so I think that should be the return value
even if the abort then failed.  Maybe an error print is
more appropriate for a failed abort so we don't loose
that extra info.

> +	}
> +
> +	ret = ma35d1_adc_disable_irq(adc);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(map, MA35D1_EADC_DAT(0), &val);
> +	if (ret)
> +		return ret;
> +
> +	if (!(val & MA35D1_EADC_DAT_VALID))
> +		return -EIO;
> +
> +	if (val & MA35D1_EADC_DAT_OV)
> +		return -EOVERFLOW;
> +
> +	*raw = FIELD_GET(MA35D1_EADC_DAT_RESULT_MASK, val);

As below - I don't follow why we'd get 16 bits when I think
all paths throw away everything above the 12th.

> +
> +	return 0;
> +
> +disable_irq:
> +	ma35d1_adc_disable_irq(adc);
> +
> +	return ret;
> +}
> +
> +static irqreturn_t ma35d1_adc_isr(int irq, void *data)
> +{
> +	struct iio_dev *indio_dev = data;
> +	struct ma35d1_adc *adc = iio_priv(indio_dev);
> +	unsigned int status;
> +	int ret;
> +
> +	ret = regmap_read(adc->regmap, MA35D1_EADC_STATUS2, &status);
> +	if (ret || !(status & MA35D1_EADC_STATUS2_ADIF0))
> +		return IRQ_NONE;
> +
> +	regmap_write(adc->regmap, MA35D1_EADC_STATUS2,
> +		     MA35D1_EADC_STATUS2_ADIF0);
> +	complete(&adc->completion);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int ma35d1_adc_sign_extend(u16 raw)
> +{
> +	return sign_extend32(raw & MA35D1_EADC_DAT_RESULT_12BIT, 11);

If the result is always 12 bits, why is read_conversion returning 16?

> +}
> +
> +static int ma35d1_adc_read_raw(struct iio_dev *indio_dev,
> +			       const struct iio_chan_spec *chan,
> +			       int *val, int *val2, long mask)
> +{
> +	struct ma35d1_adc *adc = iio_priv(indio_dev);
> +	u16 raw;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW: {
> +		IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
> +

No blank line here.  We want the acquire and the error check tightly
coupled visually.

> +		if (IIO_DEV_ACQUIRE_FAILED(claim))
> +			return -EBUSY;
> +
> +		guard(mutex)(&adc->lock);
> +		if (adc->suspended)
> +			return -EBUSY;
> +
> +		ret = ma35d1_adc_read_conversion(adc, chan, &raw);
> +		if (ret)
> +			return ret;
> +
> +		if (chan->differential)
> +			*val = ma35d1_adc_sign_extend(raw);
> +		else
> +			*val = raw & MA35D1_EADC_DAT_RESULT_12BIT;
> +
> +		return IIO_VAL_INT;
> +	}
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = adc->vref_mV;
> +		/* Differential mode has a VREF / 2048 LSB; single-ended uses /4096. */
> +		*val2 = chan->differential ? 11 : 12;
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ma35d1_adc_update_scan_mode(struct iio_dev *indio_dev,
> +				       const unsigned long *scan_mask)
> +{
> +	struct ma35d1_adc *adc = iio_priv(indio_dev);
> +	const struct iio_chan_spec *scan_chan = NULL;
> +	unsigned long bit;
> +
> +	for_each_set_bit(bit, scan_mask, iio_get_masklength(indio_dev)) {
	iio_for_each_active_channel()

> +		const struct iio_chan_spec *chan = &indio_dev->channels[bit];
> +
> +		if (chan->type == IIO_TIMESTAMP)
> +			continue;
> +
> +		if (chan->type != IIO_VOLTAGE || scan_chan)
> +			return -EINVAL;
> +
> +		scan_chan = chan;

This only makes sense if there is only one channel enabled.
The driver needs to ensure that is the case (there is a standard
validation callback for this).

> +	}
> +
> +	if (!scan_chan)
> +		return -EINVAL;
> +
> +	adc->scan_chan = scan_chan;
> +
> +	return 0;
> +}

> +
> +static irqreturn_t ma35d1_adc_trigger_handler(int irq, void *p)
This looks like the device only supports onehot channels (one at a time)
That's fine but then you should have the callbacks or available_channels
set to indicate that.

> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct ma35d1_adc *adc = iio_priv(indio_dev);
> +	IIO_DECLARE_BUFFER_WITH_TS(u16, scan, 1) = { };
Where the timestamp location is fixed (if present) I prefer 
	struct {
		u16 channel;
		aligned_s64 timestamp;
	} scan;

as it makes it easier to understand the layout. The macro
is for the case where different numbers of channels can be enabled
and there are enough of them to have the timestamp moving around
depending on what is enabled.

> +	u16 raw;
> +	int ret;
> +
> +	mutex_lock(&adc->lock);
> +
> +	if (!adc->suspended && adc->scan_chan) {
> +		ret = ma35d1_adc_read_conversion(adc, adc->scan_chan, &raw);
> +		if (!ret) {
> +			scan[0] = raw & MA35D1_EADC_DAT_RESULT_12BIT;
> +			iio_push_to_buffers_with_ts(indio_dev, scan, sizeof(scan),
> +						    pf->timestamp);
> +		}
> +	}
> +
> +	mutex_unlock(&adc->lock);
> +
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}

> +
> +static int ma35d1_adc_fwnode_xlate(struct iio_dev *indio_dev,
> +				   const struct fwnode_reference_args *iiospec)
> +{
> +	unsigned int i;
> +
> +	if (iiospec->nargs != 1)
> +		return -EINVAL;
> +
> +	for (i = 0; i < indio_dev->num_channels; i++) {

	for (unsigned int i = 0; ..

> +		const struct iio_chan_spec *chan = &indio_dev->channels[i];
> +
> +		if (chan->type == IIO_VOLTAGE &&
> +		    chan->channel == iiospec->args[0])
> +			return i;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static const struct iio_info ma35d1_adc_info = {
> +	.read_raw = ma35d1_adc_read_raw,
> +	.update_scan_mode = ma35d1_adc_update_scan_mode,
> +	.fwnode_xlate = ma35d1_adc_fwnode_xlate,
> +};
> +
> +static void ma35d1_adc_init_channel(struct iio_chan_spec *chan, u32 index,

As below.  Given C provides nice ways to set lots of structure elements
helpers use those, rather than a fill the values in helper.

> +				    u32 vinp, u32 vinn,
> +				    unsigned int scan_index,
> +				    bool differential)
> +{
> +	chan->type = IIO_VOLTAGE;
> +	chan->indexed = 1;
> +	chan->channel = index;
> +	chan->address = vinp;
> +	chan->scan_index = scan_index;
> +	chan->info_mask_separate =
> +		BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE);
> +	chan->scan_type.format = differential ? IIO_SCAN_FORMAT_SIGNED_INT :
> +					      IIO_SCAN_FORMAT_UNSIGNED_INT;
> +	chan->scan_type.realbits = 12;
> +	chan->scan_type.storagebits = 16;
> +	chan->scan_type.endianness = IIO_CPU;
> +
> +	if (differential) {
> +		chan->differential = 1;
> +		chan->channel2 = vinn;
> +	}
> +}
> +
> +static int ma35d1_adc_parse_channels(struct iio_dev *indio_dev,
> +				     struct device *dev)
> +{
> +	DECLARE_BITMAP(used_regs, MA35D1_EADC_MAX_EXT_CHANNELS);
> +	struct iio_chan_spec *channels;
> +	unsigned int scan_index;
> +	int num_channels;
> +	int ret;
> +
> +	bitmap_zero(used_regs, MA35D1_EADC_MAX_EXT_CHANNELS);
> +
> +	num_channels = device_get_child_node_count(dev);
> +	if (!num_channels)
> +		return dev_err_probe(dev, -ENOENT, "no ADC channels configured\n");
> +
> +	if (num_channels > MA35D1_EADC_MAX_EXT_CHANNELS)
> +		return dev_err_probe(dev, -EINVAL, "too many ADC channels\n");
> +
> +	channels = devm_kcalloc(dev, size_add(num_channels, 1),
> +				sizeof(*channels), GFP_KERNEL);
> +	if (!channels)
> +		return -ENOMEM;
> +
> +	scan_index = 0;
> +	device_for_each_child_node_scoped(dev, child) {
> +		bool differential;
> +		u32 reg;
> +		u32 vinp;
> +		u32 vinn;

Can combine these related u32s on oneline.

> +
> +		ret = fwnode_property_read_u32(child, "reg", &reg);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "missing channel reg property\n");
> +
> +		if (reg >= MA35D1_EADC_MAX_EXT_CHANNELS)
> +			return dev_err_probe(dev, -EINVAL,
> +					     "invalid ADC channel index %u\n", reg);
> +
> +		if (test_and_set_bit(reg, used_regs))
> +			return dev_err_probe(dev, -EINVAL,
> +					     "duplicate ADC channel index %u\n", reg);
> +
> +		if (fwnode_property_present(child, "single-channel")) {
> +			ret = fwnode_property_read_u32(child, "single-channel",
> +						       &vinp);
> +			if (ret)
> +				return dev_err_probe(dev, ret,
> +						     "invalid single-channel for index %u\n",
> +						     reg);
> +
> +			if (vinp >= MA35D1_EADC_MAX_EXT_CHANNELS)
> +				return dev_err_probe(dev, -EINVAL,
> +						     "invalid ADC input %u\n", vinp);
> +
> +			vinn = 0;
> +			differential = false;
> +		} else {

This will change to match my requests for the binding so I won't look too closely
at it in this revision.

> +			if (reg >= 4)
> +				return dev_err_probe(dev, -EINVAL,
> +						     "invalid differential pair %u\n", reg);
> +
> +			vinp = reg;
> +			vinn = reg + 4;
> +			differential = true;
> +		}
> +
> +		ma35d1_adc_init_channel(&channels[scan_index], reg, vinp, vinn,
> +					scan_index, differential);
get rid of this and fill the structure in directly in the two different
paths above - so have a single ended copy of this and the slightly
different one for the differential channels. Bit of duplication
but simpler code by putting it all in one place.

			channels[scan_index] = (struct iio_chan_spec) {
				.type = IIO_VOLTAGE,
				.indexed = 1,
				.channel = index,
				.address = vinp,
				.scan_index = scan_index,
				.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
						      BIT(IIO_CHAN_INFO_SCALE);
				.scan_type = {
					.format = IIO_SCAN_FORMAT_UNSIGNED_INT,
					.realbits = 12,
					.storagebits = 16,
					.endianness = IIO_CPU,;
			};
		
> +		scan_index++;

> +	}
> +
> +	channels[scan_index] = IIO_CHAN_SOFT_TIMESTAMP(scan_index);

> +
> +	indio_dev->channels = channels;
> +	indio_dev->num_channels = scan_index + 1;
> +
> +	return 0;
> +}
> +
> +static int ma35d1_adc_init_vref(struct ma35d1_adc *adc, struct device *dev)
> +{
> +	int ret;
> +
> +	adc->vref = devm_regulator_get_optional(dev, "vref");
> +	ret = PTR_ERR_OR_ZERO(adc->vref);
> +	if (ret == -ENODEV) {
> +		adc->vref = NULL;
> +		adc->vref_mV = MA35D1_EADC_INTERNAL_VREF_mV;
> +		return 0;
> +	}
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to get VREF supply\n");
> +
> +	ret = regulator_enable(adc->vref);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to enable VREF supply\n");
> +
> +	ret = devm_add_action_or_reset(dev, ma35d1_adc_vref_disable, adc->vref);
> +	if (ret)
> +		return ret;
> +
> +	ret = regulator_get_voltage(adc->vref);

There are plenty of examples of how to use devm_regulator_get_enable_read_voltage()
with optional regulators in tree.  Follow one of those and this code will be a lot
shorter.

> +	if (ret <= 0)
> +		return dev_err_probe(dev, ret ?: -EINVAL,
> +				     "failed to get VREF voltage\n");
> +
> +	adc->vref_mV = ret / (MICRO / MILLI);
> +
> +	return 0;
> +}

> +static int ma35d1_adc_suspend(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct ma35d1_adc *adc = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = iio_device_suspend_triggering(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	mutex_lock(&adc->lock);
> +
> +	ret = ma35d1_adc_disable_irq(adc);
> +	if (ret)
> +		goto resume_triggering;
> +
> +	synchronize_irq(adc->irq);
> +
> +	ret = regmap_clear_bits(adc->regmap, MA35D1_EADC_CTL,
> +				MA35D1_EADC_CTL_ADCEN);
> +	if (ret)

If this fails, for consistency I think you should probably
reenable the irq.  If not add a comment on your thinking for
why.

 
> +		goto resume_triggering;
> +
> +	adc->suspended = true;
> +	clk_disable_unprepare(adc->clk);
> +	mutex_unlock(&adc->lock);
> +
> +	return 0;
> +
> +resume_triggering:
> +	mutex_unlock(&adc->lock);
> +	iio_device_resume_triggering(indio_dev);
> +
> +	return ret;
> +}
> +


