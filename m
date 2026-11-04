Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793793025;
	b=jY1BANcDQ5unXrXfmLysTeiK6LuBpnrmCmomcPIGp4YR6S0xkHI1aNJTGxaN+v4cnH+5
	 pw7Qs5B2WX5bLjFmflpg85SHiiq2/29Ys12YR2xmx0j0w6XPZRxao8EM3kLM7FHv0SOid
	 odvM5yhQzScNyKR6RWGujYGKLCPRoNhWKNxdGQllIPe8lJmCy1otsWOFYblp4xDZ2wN6N
	 iG/AyUMu9cUzN0zhWpmYWyff6WqSem3GvQ/qhf7b8biHJEpJI5bDSoAuX0eGtdk5W+hZr
	 C9swywLAaEGZqVT5SyZRzz0kTM68Nhar47X9yzyDXlKdvc557pgPSIu2bT3IdPLWvyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793793025;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=d5OejrVGsomYty+i3ZRzaeZMrk9/8f7YEpZV3hplRGU=;
	b=n+xNKtP0yG8mN7eFe1Xddo67xXRYlLBBCKffDGjNRqmF9Y1ECT7yj3K5+RSSDSzfZqwV
	 j+be2KFYOBh7vkhkNs0dCX1ry5xf5v8GmokvtyG3KxAQmpdW1PYwnHP8hD59isGp/EWYp
	 AvefjAU3TglMJ4v91WCA99wMaPQ5EePQErRPN399516/ImuTHVhAorbmHXeQL9YXT9DLQ
	 ZfPXh6672wmbXsIltof7VcgSbRQiiS7JdLtZGaBhDey7sG4CpX7moSVjw8dcWU35tZwAM
	 mgqbsBXMH/Fleu1zZn2EqDWP6b+xjwWVM/uV0vcX1ZYnMwcBrj7p7F2+8OH4lcOJYXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IdtIy1k5;
	arc=none smtp.remote-ip=192.198.163.17
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467C2606A329;
	Wed,  4 Nov 2026 11:50:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 467C2606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IdtIy1k5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793793023; x=1825329023;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xcmnKuYaN43ljFcSwJ9+DlplQK/ScAcS9ZuYXiL1cQE=;
  b=IdtIy1k5MH4TQyWFaKBX3bEmoz5t0zspyu+QHiFo69Bk7iySJrF3gkhs
   Y/8iCTv6CRfaP5ivhWbOKg47nnAF0u4iL90Ftt5suWjvRQCa8PPbd+Z4O
   pHmiFOKrV9UMo3NDeBhFTGSSgza7SUud5UYx+i3FiE8TNZfeRaXL4vn0Z
   QdXZmFJY8Mg3FfdzhMDQDZDhhVPkw2m9p9yUt0uM2ffvQtOZrjAu+u1If
   P/j2Ur91ylcDq3GrW0pDDtMrXr3gCPSXRd1EpuNGZp2yUa4IoFG90CPH3
   qxnddO7/KboTNuEzFdXcu2mlKrlaKdJuSjZDjfyUikOX1Ihqn97yKkmIj
   w==;
X-CSE-ConnectionGUID: jMFsEiJ9T3+0gCrl6ls3RQ==
X-CSE-MsgGUID: O2oAy790QGukbjKVZP2BUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2550900"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2550900"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 03:50:23 -0800
X-CSE-ConnectionGUID: A81cgGfxSCKoADnHFuRfKg==
X-CSE-MsgGUID: yptMbd2vTjiP98KUKtDuow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="6841666"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.24])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 03:50:19 -0800
Date: Wed, 4 Nov 2026 13:50:17 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Chi-Wen Weng <cwweng.linux@gmail.com>
Cc: jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, cwweng@nuvoton.com
Subject: Re: [PATCH v4 2/2] iio: adc: Add Nuvoton MA35D1 EADC driver
Message-ID: <ausb-YqIJM0mI65Y@ashevche-desk.local>
References: <20261104091136.151269-1-cwweng.linux@gmail.com>
 <20261104091136.151269-3-cwweng.linux@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104091136.151269-3-cwweng.linux@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 04, 2026 at 05:11:36PM +0800, Chi-Wen Weng wrote:

> Add an IIO driver for the Enhanced Analog-to-Digital Converter found on
> Nuvoton MA35D1 SoCs.
> 
> Support single-ended and fixed differential input pairs, direct
> conversion, and triggered buffered capture using sample module 0.
> 
> The hardware supports multiple sample modules, but this initial driver
> uses sample module 0 only and therefore supports one active voltage
> channel per buffered scan.

...

> +struct ma35d1_adc {
> +	struct regmap *regmap;
> +	struct clk *clk;
> +	struct reset_control *rst;
> +	struct completion completion;
> +	/* Protect conversion state and register accesses from PM transitions. */
> +	struct mutex lock;
> +	const struct iio_chan_spec *scan_chan;
> +	unsigned int vref_mV;
> +	int irq;
> +	bool clk_enabled;
> +	bool external_vref;
> +	bool suspended;
> +};

Now when it has optimal layout it's better to regroup the fields with some ties.

struct ma35d1_adc {
	struct regmap *regmap;
	struct clk *clk;
	struct reset_control *rst;
	struct completion completion;
	/* Protect conversion state and register accesses from PM transitions. */
	struct mutex lock;
	const struct iio_chan_spec *scan_chan;
	int irq;
	unsigned int vref_mV;
	bool external_vref;
	bool clk_enabled;
	bool suspended;
};

...

> +static const struct regmap_config ma35d1_adc_regmap_config = {
> +	.reg_bits = 32,
> +	.val_bits = 32,
> +	.reg_stride = 4,
> +	.max_register = MA35D1_EADC_REFADJCTL,

Add a comment why no cache is enabled.

> +};

...

> +static int ma35d1_adc_hw_init(struct ma35d1_adc *adc)
> +{
> +	struct regmap *map = adc->regmap;

> +	unsigned int i;

Not used outside the loops, just declare inside respective for:s.

> +}

...

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

Use room on the previous line(s).

> +	ret = regmap_update_bits(map, MA35D1_EADC_SCTL(0), mask,
> +				 FIELD_PREP(MA35D1_EADC_SCTL_CHSEL_MASK,
> +					    chan->channel));
> +	if (ret)
> +		return ret;
> +
> +	return regmap_update_bits(map, MA35D1_EADC_INTSRC0,
> +				  MA35D1_EADC_INTSRC0_MASK,
> +				  MA35D1_EADC_INTSRC0_SPLIEN0);
> +}

...

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

Make it a single (yes, a bit longer) line.

> +	if (!timeout) {
> +		ma35d1_adc_abort_conversion(adc);
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
> +
> +	return ret;
> +}

...

> +static irqreturn_t ma35d1_adc_isr(int irq, void *data)
> +{
> +	struct iio_dev *indio_dev = data;
> +	struct ma35d1_adc *adc = iio_priv(indio_dev);
> +	struct regmap *map = adc->regmap;
> +	unsigned int status;
> +	int ret;
> +
> +	ret = regmap_read(map, MA35D1_EADC_STATUS2, &status);
> +	if (ret)
> +		return IRQ_NONE;
> +
> +	if (!(status & MA35D1_EADC_STATUS2_ADIF0))
> +		return IRQ_NONE;

regmap_test_bits() ? It will hide status OTOH. Up to you.

> +	ret = regmap_write(map, MA35D1_EADC_STATUS2, MA35D1_EADC_STATUS2_ADIF0);
> +	if (ret)
> +		dev_err_ratelimited(regmap_get_device(map),
> +				    "failed to clear ADC interrupt status: %d\n", ret);
> +
> +	complete(&adc->completion);
> +
> +	return IRQ_HANDLED;
> +}

...

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

Broken indentation.

> +		return IIO_VAL_FRACTIONAL_LOG2;
> +	default:
> +		return -EINVAL;
> +	}
> +}

...

> +static int ma35d1_adc_update_scan_mode(struct iio_dev *indio_dev,
> +				       const unsigned long *scan_mask)
> +{
> +	struct ma35d1_adc *adc = iio_priv(indio_dev);
> +	int bit;

> +	adc->scan_chan = NULL;

Should we update this even in case of wrong channel type?

> +	iio_for_each_active_channel(indio_dev, bit) {
> +		const struct iio_chan_spec *chan = &indio_dev->channels[bit];
> +
> +		if (chan->type != IIO_VOLTAGE)
> +			return -EINVAL;
> +
> +		adc->scan_chan = chan;
> +	}
> +
> +	if (!adc->scan_chan)
> +		return -EINVAL;
> +
> +	return 0;
> +}

...

> +	return regmap_write(adc->regmap, MA35D1_EADC_STATUS2,
> +			    MA35D1_EADC_STATUS2_ADIF0);

	struct regmap *map = adc->regmap;
	...
	return regmap_write(map, MA35D1_EADC_STATUS2, MA35D1_EADC_STATUS2_ADIF0);

*yes, it's 81 characters long.

...

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

> +			u32 inputs[2];

No need, move this above instead of vinn and vinp. Or use custom data:

		struct {
			u32 p;
			u32 n;
		} vin;

if you want to have distinct names.


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

...

> +static int ma35d1_adc_init_vref(struct ma35d1_adc *adc, struct device *dev)
> +{
> +	int ret;
> +
> +	ret = devm_regulator_get_enable_read_voltage(dev, "vref");
> +	if (ret == -ENODEV) {
> +		adc->vref_mV = MA35D1_EADC_INTERNAL_VREF_mV;

> +		return 0;

Can be deduplicated. See below how.

> +	}
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "failed to get VREF supply\n");
> +
> +	if (!ret)
> +		return dev_err_probe(dev, -EINVAL, "invalid VREF voltage\n");
> +
> +	adc->external_vref = true;
> +	adc->vref_mV = ret / (MICRO / MILLI);

	if (ret == -ENODEV) {
		adc->vref_mV = MA35D1_EADC_INTERNAL_VREF_mV;
	} else if (ret < 0) {
		return dev_err_probe(dev, ret, "failed to get VREF supply\n");
	} else {
		adc->external_vref = true;
		adc->vref_mV = ret / (MICRO / MILLI);
	}


> +	return 0;
> +}

...

> +	adc->clk = devm_clk_get(dev, NULL);
> +	if (IS_ERR(adc->clk))
> +		return dev_err_probe(dev, PTR_ERR(adc->clk),
> +				     "failed to get ADC clock\n");
> +
> +	ret = clk_prepare_enable(adc->clk);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to enable ADC clock\n");

> +	adc->clk_enabled = true;

Repeats what __clk_is_enabled() provides.

> +	ret = devm_add_action_or_reset(dev, ma35d1_adc_clk_disable_action, adc);
> +	if (ret)
> +		return ret;

...

> +static int ma35d1_adc_resume(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct ma35d1_adc *adc = iio_priv(indio_dev);
> +	int ret;

> +	mutex_lock(&adc->lock);

What's wrong with guard()()? Yes, for resume triggering support this needs to
be wrapped. Same Q to other explicit mutex_lock() use cases.

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
> +
> +static DEFINE_SIMPLE_DEV_PM_OPS(ma35d1_adc_pm_ops,
> +				ma35d1_adc_suspend, ma35d1_adc_resume);

-- 
With Best Regards,
Andy Shevchenko


