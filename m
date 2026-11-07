Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794087124;
	b=yL3Kfig9D9vYKwaSRsHH0r4/tMfQ78XPkRYJoL6DsMM4lXeuQldxR7mVmaSBb6eTa/NB
	 mfGj40W6CF9FmzGRiDrBT3AMtjsTzUgBMxlXfe/R5Nujo9twZVa8UzeVGnGkRemj2f9j+
	 AgFnGZbe0UbONluPJEKYxjHHZp6FZoP1LoXoO7bKvJgWNZWjetBrd7NNPNjfl1J1Ti3KA
	 bMRM6Yo/gnRDaUO9WE63vQUqsQd2Wbh361srflh0FOt5z/tvia5vlXGWPrKnGUEhYp6A/
	 mmJbhbNMbC555u7saKHmWEBogp55v/2AzfveS60KXZ9gLm0vK3maFaTqlr2xu0JqYKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794087124;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=qgiZfVkbT+ltFV+Gs85pEhwixm7z8KILQaRaCe49ats=;
	b=r1XZpSyPmG8ClZw+kprHOgtTd8aAQeBl+1gCx8lRbGsEiYE4GWKueuqZygHna35/E2gx
	 yBNci/OwToirUYLBxXzk1fnKUtiqDU2/glh01tHNHMPLc1HAzINzOvLOkOyrW8r0hNQih
	 /7NANVbYbO27+JeFcbcNhta5L5dTZqBdnldunjL4+XZ/mMD6a3xD8T/xSLIGMKCXTf0gh
	 Mv7li4jBMiWKw82Y2cMGCX5gR3MelE0qK/m/qn68t7/vi2OHJ5Q+SvITREMx9/vjX5yb7
	 /GqI3wElspYtx/QClx62xZJPbd0EHLK1x5vKw4Brn4gySviK3FJgODEsVs4nG/aZarA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fz4M1Fry;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6329C606A326;
	Sat,  7 Nov 2026 21:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fz4M1Fry
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DDB31F0089F;
	Sat,  7 Nov 2026 21:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794087124;
	bh=qgiZfVkbT+ltFV+Gs85pEhwixm7z8KILQaRaCe49ats=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fz4M1FryT3Yseeo0Ckq/XKTVvefg36YFTiOD5nxt3lsHacpBaRxgbsyTwgfDPiU8n
	 Gc/WYWHiEy6jXkWNEwWKAqVydkn+8H2xxy8rI0LGtfze5WpGRUFRIN3H3mhjbfvwG4
	 XltiwX3qN+WAAPj7s7DYSDPXZVcvNrYIkHgvncOSCrghW7XAwqcQaLynHo2MOHA5T8
	 JzB6Pn761qG73w7OH8ltQ6U/yb/O8je4CWp5hDzdlmh+fPmXDDqM7XSMvj4I8hFQdV
	 CNnITmJMUZacXX5dRGZED99KSZM6Y3axEFF6EYbVIJzxrdkBuPKh0ftQP47994c00c
	 C1q7lkxwUCXeA==
Date: Sat, 7 Nov 2026 21:31:56 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Chi-Wen Weng <cwweng.linux@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 cwweng@nuvoton.com
Subject: Re: [PATCH v4 2/2] iio: adc: Add Nuvoton MA35D1 EADC driver
Message-ID: <20261107213156.18e651c4@jic23-hlaptop>
In-Reply-To: <20261104091136.151269-3-cwweng.linux@gmail.com>
References: <20261104091136.151269-1-cwweng.linux@gmail.com>
	<20261104091136.151269-3-cwweng.linux@gmail.com>
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

On Wed,  4 Nov 2026 17:11:36 +0800
Chi-Wen Weng <cwweng.linux@gmail.com> wrote:

> From: Chi-Wen Weng <cwweng@nuvoton.com>
> 
> Add an IIO driver for the Enhanced Analog-to-Digital Converter found on
> Nuvoton MA35D1 SoCs.
> 
> Support single-ended and fixed differential input pairs, direct
> conversion, and triggered buffered capture using sample module 0.
> 
> The hardware supports multiple sample modules, but this initial driver
> uses sample module 0 only and therefore supports one active voltage
> channel per buffered scan.
> 
> Signed-off-by: Chi-Wen Weng <cwweng@nuvoton.com>
Hi Chi-Wen

Mostly I suspect I have overlapped with Andy, but maybe there
are a few additional things in here to tidy up for v5!
Thanks,

Jonathan

> diff --git a/drivers/iio/adc/ma35d1_eadc.c b/drivers/iio/adc/ma35d1_eadc.c
> new file mode 100644
> index 000000000000..b45ad3ef5264
> --- /dev/null
> +++ b/drivers/iio/adc/ma35d1_eadc.c

> +#define MA35D1_EADC_DAT(n)		(0x000 + (n) * 0x004)
> +#define MA35D1_EADC_CTL			0x050
> +#define MA35D1_EADC_SWTRG		0x054
> +#define MA35D1_EADC_SCTL(n)		(0x080 + (n) * 0x004)
> +#define MA35D1_EADC_INTSRC0		0x0d0
> +#define MA35D1_EADC_CMP(n)		(0x0e0 + (n) * 0x004)
> +#define MA35D1_EADC_STATUS2		0x0f8
> +#define MA35D1_EADC_SELSMP0		0x140
> +#define MA35D1_EADC_REFADJCTL		0x150
> +
> +#define MA35D1_EADC_CTL_ADCEN		BIT(0)
> +#define MA35D1_EADC_CTL_EADCRST		BIT(1)
> +#define MA35D1_EADC_CTL_ADCIEN0		BIT(2)
> +#define MA35D1_EADC_CTL_ADCIEN_MASK	GENMASK(5, 2)
> +#define MA35D1_EADC_CTL_DIFFEN		BIT(8)
> +#define MA35D1_EADC_CTL_DMOF		BIT(9)
> +#define MA35D1_EADC_CTL_VREFSEL_MASK	GENMASK(11, 10)
> +#define MA35D1_EADC_CTL_VREFSEL_1V6	FIELD_PREP(MA35D1_EADC_CTL_VREFSEL_MASK, 0)
> +
> +#define MA35D1_EADC_SCTL_CHSEL_MASK	GENMASK(3, 0)
> +#define MA35D1_EADC_SCTL_TRGSEL_MASK	GENMASK(21, 16)
> +#define MA35D1_EADC_SCTL_INTPOS		BIT(22)
> +
> +#define MA35D1_EADC_RESOLUTION		12
> +#define MA35D1_EADC_DIFF_SCALE_BITS	(MA35D1_EADC_RESOLUTION - 1)
> +
> +#define MA35D1_EADC_DAT_RESULT_12BIT	GENMASK(MA35D1_EADC_RESOLUTION - 1, 0)
> +#define MA35D1_EADC_DAT_OV		BIT(16)
> +#define MA35D1_EADC_DAT_VALID		BIT(17)
> +
> +#define MA35D1_EADC_INTSRC0_MASK		GENMASK(8, 0)
> +#define MA35D1_EADC_INTSRC0_SPLIEN0	BIT(0)
I'm a little unclear on this.  The MASK above implies a field
yet, fields don't contain bits.  So what is going on here?
If you need a full register mask, then define all the fields
and build it from those.

> +#define MA35D1_EADC_STATUS2_ADIF0	BIT(0)

I generally prefer to see register addresses, fields and values
all together as it makes it easier to check naming (or datasheet values).
A visual trick that works well is to use some indenting to make it
clear what is what.

#define MA35D1_EADC_STATUS2	0x0f8 /* The register*/
#define   MAX35D1_EADC_STATUS2_FIELD0	GENMASK(X, Y)
#define     MAX35D1_EADC_STATU2_FIELD0_VAL0	0

Obviously the value bit only applies if you need defines
to interpret the field values.  I picked a bad register
to illustrate this with as it doesn't have those :(


> +#define MA35D1_EADC_CMP_EADCMPIE	BIT(1)
> +#define MA35D1_EADC_REFADJCTL_PDREF	BIT(0)
> +#define MA35D1_EADC_SELSMP0_SMPT0_MASK	GENMASK(1, 0)
> +#define MA35D1_EADC_SELSMP_LONG		FIELD_PREP(MA35D1_EADC_SELSMP0_SMPT0_MASK, 3)

> +
> +static int ma35d1_adc_disable_irq(struct ma35d1_adc *adc)
> +{
> +	return regmap_clear_bits(adc->regmap, MA35D1_EADC_CTL, MA35D1_EADC_CTL_ADCIEN0);
> +}

Obviously not used nearly as much, but just for visual pairing
I'd be tempted to add an adc_enable_irq()
helper as well.  


> +
> +static int ma35d1_adc_config_channel(struct ma35d1_adc *adc,
> +				     const struct iio_chan_spec *chan)
> +{
> +	struct regmap *map = adc->regmap;
> +	unsigned int mask;
> +	int ret;
> +
> +	mask = MA35D1_EADC_CTL_DIFFEN | MA35D1_EADC_CTL_DMOF;
> +	ret = regmap_assign_bits(map, MA35D1_EADC_CTL, mask, chan->differential);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * INTPOS = 0 generates ADIF0 at end of conversion. TRGSEL = 0 disables
> +	 * the hardware trigger; conversions are started through SWTRG0.
> +	 */
> +	mask = MA35D1_EADC_SCTL_CHSEL_MASK |
> +	       MA35D1_EADC_SCTL_TRGSEL_MASK |
> +	       MA35D1_EADC_SCTL_INTPOS;
> +	ret = regmap_update_bits(map, MA35D1_EADC_SCTL(0), mask,
> +				 FIELD_PREP(MA35D1_EADC_SCTL_CHSEL_MASK,
> +					    chan->channel));
> +	if (ret)
> +		return ret;
> +
> +	return regmap_update_bits(map, MA35D1_EADC_INTSRC0,
> +				  MA35D1_EADC_INTSRC0_MASK,
> +				  MA35D1_EADC_INTSRC0_SPLIEN0);

This code was the reason I looked more closely at what that _MASK
was above.  Normally when we use regmap_update_bits() it is
to set a value in a field.  It wasn't clear there was a field
here.  I'd expect this to look more like the SCTL handling just
above where the mask includes all the specific fields that make
up that GENMASK(8, 0)


> +}
> +
> +static void ma35d1_adc_abort_conversion(struct ma35d1_adc *adc)
> +{
> +	struct regmap *map = adc->regmap;
> +	struct device *dev = regmap_get_device(map);
> +	int ret;
> +
> +	ret = ma35d1_adc_disable_irq(adc);
> +	if (ret)
> +		dev_err(dev, "failed to disable ADC interrupt: %d\n", ret);
> +
> +	/*
> +	 * Reset the EADC control circuits to terminate a conversion which may
> +	 * still be in progress. EADCRST is cleared automatically by hardware
> +	 * when the reset completes and the EADC register values are preserved.
> +	 */
> +	ret = ma35d1_adc_reset_control(adc);
> +	if (ret)
> +		dev_err(dev, "failed to reset timed out conversion: %d\n", ret);
> +
> +	/* Drain an interrupt which may already have been latched by the GIC. */
> +	synchronize_irq(adc->irq);
> +
> +	ret = regmap_write(map, MA35D1_EADC_STATUS2, MA35D1_EADC_STATUS2_ADIF0);
> +	if (ret)
> +		dev_err(dev, "failed to clear ADC interrupt status: %d\n", ret);
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
That handling is only used here. I'd pull the code up here.
> +
> +	timeout = wait_for_completion_timeout(&adc->completion,
> +					      MA35D1_EADC_TIMEOUT);
> +	if (!timeout) {
> +		ma35d1_adc_abort_conversion(adc);

However, I'm not sure if the disable irq should be here?
It is in side there so maybe add a comment just to avoid confusion
as I guess the careful ordering of the abort_conversion function
matters.

> +		return -ETIMEDOUT;
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
> +	*raw = FIELD_GET(MA35D1_EADC_DAT_RESULT_12BIT, val);
> +
> +	return 0;
> +
> +disable_irq:
> +	ma35d1_adc_disable_irq(adc);

See above. I suggest adding an _enable_irq() helper. The reason for
that was this code as I couldn't immediately spot what this paired
with.  There are also few places where this is relevant. At least
one seems to leave it on (the abort_conversion one)


> +
> +	return ret;
> +}

> +
> +static int ma35d1_adc_sign_extend(u16 raw)
> +{
> +	return sign_extend32(raw, MA35D1_EADC_DIFF_SCALE_BITS);
> +}
Is there enough value in this helper to make it worth
the reader having to go see what it does?

Marginal I think. If this was to avoid a long line, don't worry
too much about it as only ever so slightly over 80 chars.

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
> +		if (IIO_DEV_ACQUIRE_FAILED(claim))
> +			return -EBUSY;
> +
> +		guard(mutex)(&adc->lock);
> +
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
> +			*val = raw;
> +
> +		return IIO_VAL_INT;
> +	}
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = adc->vref_mV;
> +		/* Differential mode has a VREF / 2048 LSB; single-ended uses /4096. */
> +		*val2 = chan->differential ? MA35D1_EADC_DIFF_SCALE_BITS :
> +					       MA35D1_EADC_RESOLUTION;
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
> +	int bit;
> +
> +	adc->scan_chan = NULL;
> +	iio_for_each_active_channel(indio_dev, bit) {
> +		const struct iio_chan_spec *chan = &indio_dev->channels[bit];
> +
> +		if (chan->type != IIO_VOLTAGE)
> +			return -EINVAL;
> +
> +		adc->scan_chan = chan;

This seems to hint you can be other than onehot.  I think not,
so just break out of the loop here.

> +	}
> +
> +	if (!adc->scan_chan)
> +		return -EINVAL;
> +
> +	return 0;
> +}

> +
> +static int ma35d1_adc_parse_channels(struct iio_dev *indio_dev,
> +				     struct device *dev)
> +{
> +	DECLARE_BITMAP(used_single_inputs, MA35D1_EADC_MAX_EXT_CHANNELS);
> +	DECLARE_BITMAP(used_diff_pairs, MA35D1_EADC_NUM_DIFF_PAIRS);
> +	DECLARE_BITMAP(used_regs, MA35D1_EADC_MAX_EXT_CHANNELS);
> +	struct iio_chan_spec *channels;
> +	unsigned int scan_index;
> +	int num_channels;
> +	int ret;
> +
> +	bitmap_zero(used_single_inputs, MA35D1_EADC_MAX_EXT_CHANNELS);
> +	bitmap_zero(used_diff_pairs, MA35D1_EADC_NUM_DIFF_PAIRS);
> +	bitmap_zero(used_regs, MA35D1_EADC_MAX_EXT_CHANNELS);
> +
> +	num_channels = device_get_child_node_count(dev);
> +	if (!num_channels)
> +		return dev_err_probe(dev, -ENOENT, "no ADC channels configured\n");
> +
> +	if (num_channels > MA35D1_EADC_MAX_EXT_CHANNELS)
> +		return dev_err_probe(dev, -ENOSPC, "too many ADC channels\n");
> +
> +	channels = devm_kcalloc(dev, size_add(num_channels, 1),
> +				sizeof(*channels), GFP_KERNEL);
> +	if (!channels)
> +		return -ENOMEM;
> +
> +	scan_index = 0;
> +	device_for_each_child_node_scoped(dev, child) {
> +		bool has_diff, has_single;
> +		u32 reg, vinp, vinn;
> +
> +		ret = fwnode_property_read_u32(child, "reg", &reg);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "missing channel reg property\n");
> +
> +		if (reg >= MA35D1_EADC_MAX_EXT_CHANNELS)
> +			return dev_err_probe(dev, -ENOSPC,
> +					     "invalid ADC channel index %u\n", reg);
> +
> +		if (test_and_set_bit(reg, used_regs))
> +			return dev_err_probe(dev, -EEXIST,
> +					     "duplicate ADC channel index %u\n", reg);
> +
> +		has_single = fwnode_property_present(child, "single-channel");
> +		has_diff = fwnode_property_present(child, "diff-channels");
> +		if (has_single && has_diff)
> +			return dev_err_probe(dev, -EINVAL,
> +					     "channel %u has conflicting input properties\n",
> +					     reg);
> +
> +		if (has_diff) {

The indent is getting a bit large, perhaps a pair of helpers to cover
differential vs single would make this more readable?

> +			u32 inputs[2];
> +
> +			ret = fwnode_property_read_u32_array(child, "diff-channels",
> +							     inputs, ARRAY_SIZE(inputs));
> +			if (ret)
> +				return dev_err_probe(dev, ret,
> +						     "invalid diff-channels for index %u\n",
> +						     reg);
> +
> +			vinp = inputs[0];
> +			vinn = inputs[1];
> +			if (vinp >= 4 || vinn != vinp + 4)
> +				return dev_err_probe(dev, -ECHRNG,
> +						     "invalid differential inputs %u-%u\n",
> +						     vinp, vinn);
> +
> +			if (test_and_set_bit(vinp, used_diff_pairs))
> +				return dev_err_probe(dev, -EEXIST,
> +						     "duplicate differential inputs %u-%u\n",
> +						     vinp, vinn);
> +
> +			channels[scan_index] = (struct iio_chan_spec) {
> +				.type = IIO_VOLTAGE,
> +				.indexed = 1,
> +				.differential = 1,
> +				.channel = vinp,
> +				.channel2 = vinn,
> +				.address = reg,
> +				.scan_index = scan_index,
> +				.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +						      BIT(IIO_CHAN_INFO_SCALE),
> +				.scan_type = {
> +					.format = IIO_SCAN_FORMAT_SIGNED_INT,
> +					.realbits = MA35D1_EADC_RESOLUTION,
> +					.storagebits = 16,
> +					.endianness = IIO_CPU,
> +				},
> +			};
> +		} else {
> +			if (has_single) {
> +				ret = fwnode_property_read_u32(child, "single-channel",
> +							       &vinp);
> +				if (ret)
> +					return dev_err_probe(dev, ret,
> +							     "invalid single-channel for index %u\n",
> +							     reg);
> +			} else {
> +				vinp = reg;
> +			}
> +
> +			if (vinp >= MA35D1_EADC_MAX_EXT_CHANNELS)
> +				return dev_err_probe(dev, -ECHRNG,
> +						     "invalid ADC input %u\n", vinp);
> +
> +			if (test_and_set_bit(vinp, used_single_inputs))
> +				return dev_err_probe(dev, -EEXIST,
> +						     "duplicate ADC input %u\n", vinp);
> +
> +			channels[scan_index] = (struct iio_chan_spec) {
> +				.type = IIO_VOLTAGE,
> +				.indexed = 1,
> +				.channel = vinp,
> +				.address = reg,
> +				.scan_index = scan_index,
> +				.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +						      BIT(IIO_CHAN_INFO_SCALE),
> +				.scan_type = {
> +					.format = IIO_SCAN_FORMAT_UNSIGNED_INT,
> +					.realbits = MA35D1_EADC_RESOLUTION,
> +					.storagebits = 16,
> +					.endianness = IIO_CPU,
> +				},
> +			};
> +		}
> +
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

> +static int ma35d1_adc_suspend(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct ma35d1_adc *adc = iio_priv(indio_dev);
> +	struct regmap *map = adc->regmap;
> +	int ret;
> +
> +	ret = iio_device_suspend_triggering(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	mutex_lock(&adc->lock);
This one is trickier than the case below.  A simple refactor
to pull out everything from here onwards though and you can do

	ret = iio_device_suspend_triggering(indio_dev);
	if (ret)
		return ret;

	ret = whateverhelper();
	if (ret)
		iio_device_resume_triggering(indio_dev)	

	return ret;

I see Andy raised this as well, but wanted to add a few more
breadcrumbs on how I'd suggest improving the code to meet
his suggestion.

> +
> +	ret = ma35d1_adc_disable_irq(adc);
> +	if (ret)
> +		goto resume_triggering;
> +
> +	synchronize_irq(adc->irq);
> +
> +	ret = regmap_clear_bits(map, MA35D1_EADC_CTL, MA35D1_EADC_CTL_ADCEN);
> +	if (ret) {
> +		/*
> +		 * ADCIEN0 is enabled only while a conversion is active. Holding
> +		 * adc->lock here guarantees that no conversion is in progress, so
> +		 * leave it disabled. The next conversion enables it again.
> +		 */
> +		goto resume_triggering;
> +	}
> +
> +	adc->suspended = true;
> +	clk_disable_unprepare(adc->clk);
> +	adc->clk_enabled = false;
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
> +static int ma35d1_adc_resume(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct ma35d1_adc *adc = iio_priv(indio_dev);
> +	int ret;
> +
> +	mutex_lock(&adc->lock);

scoped_guard() or a suitable helper will simplify the
code flow here.

> +
> +	ret = clk_prepare_enable(adc->clk);
> +	if (ret)
> +		goto unlock;
> +
> +	adc->clk_enabled = true;
> +	ret = ma35d1_adc_hw_init(adc);
> +	if (ret) {
> +		clk_disable_unprepare(adc->clk);
> +		adc->clk_enabled = false;
> +		goto unlock;
> +	}
> +
> +	adc->suspended = false;
> +	mutex_unlock(&adc->lock);
> +
> +	return iio_device_resume_triggering(indio_dev);
> +
> +unlock:
> +	mutex_unlock(&adc->lock);
> +
> +	return ret;
> +}


