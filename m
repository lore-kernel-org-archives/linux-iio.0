Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793703621;
	b=w6I1lNbilwxHlIEZCeV5dBfuk34xI86FUHtfou2nVs1rx19cMqbmYKsfa+kguj6Q2f13
	 9N+KHK/40ro2OrkRC1U6U9Oq7eTCsqO3Ay0dBYxjmIwuWthWtMi75RUrPtWt8SEHZbECP
	 Z8QOQqMXs8r1SpcdbzGJvFwQi9wc+md3uZYQrxHeJmpL26zS00rnZRKHxVLDMagV89NCG
	 TOs3iDh2E2cFfZW3ObNr6wFv0+PbEs7hmtDRSk0JhF9NHthGCnbyzyLvMSZpbO/my3SVI
	 NyOtcmZgE1D5gIwP/DnhXfjrM79LJAXBp3NkhvKEsKIDslQY2b9AnHSDkV0LaW61UEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793703621;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=ZHaluVN4QVG6zZ01mYkAS1E2kQ0Rb60RdvEd/xq8+1s=;
	b=DCUB+YOdHTZnmc0vtZ/m+nL7VL/6IdbOdSSQivtuGR8aID93OeSwZ7cIFcNK060RCYHu
	 l8SWisMXGTTWLpI2bCQOvXrjUHiMmlaTojkiUniCZh2R2u48E+pEGXt7xQN/K0ft0ETeo
	 GbtxTAj/tdrF92s2+HC+Kjo31FW/dzzknlgUNSKRi6Ffqj3xQTcc+kZVtBvjK3uxf5xtF
	 M6aPAVkGYD8ySsC9j02V41TzlP1qEtfJETmkhqqHBisSLUI47CIAPw6pHsj8+wjeJnWYz
	 mzsCPiYmyR0hy5q+oDXHpfES5e69ZHtaiAzbwYBu3KVW2+gn8+33cntnIeHQ0AUze2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fUgFd3BU;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0F4606C5C8;
	Tue,  3 Nov 2026 11:00:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E0F4606C5C8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fUgFd3BU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793703620; x=1825239620;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=A48PNQFXuCWaAUzwsonKXEuzgeRg37aflgFlNnBvsgY=;
  b=fUgFd3BUWplT3n4FZm1ip2TgRk/hmlylWrOQ9Fh5Sz/2K3mS8AsTEhAA
   ddOjgnwB1x/mgW3zbmIrKoyiqpPXG9ekTCCr8Dofiz9oyDEV4dyq8Ymhw
   dvksHjEf28b9Fh/IeCynA3D+pAECs98C/1YETZl7Ds3T1YJIOVE6OvoJM
   0PHsNazXXys+vCjeBhciYTjz0Qr9PMK4L71Hp3DfMrYSdRyrxYgOCwyZ1
   BZyxhuDe578hABeMmPEqmDXvixjkQBqtWR3jIgKWuFOT2bTPx7DXlGJuP
   1t+N8uyd4n6wcC37g5zpQU+rI29LwgEGioPvcf690PDE7yKtzldiaEOTT
   A==;
X-CSE-ConnectionGUID: twrRqcOkSMusX5VjdTAgSg==
X-CSE-MsgGUID: K9qbNdnzSXybLzxMaJKJwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2301516"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2301516"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 03:00:19 -0800
X-CSE-ConnectionGUID: aQt+PnvgRQqhUUS7EoIt/A==
X-CSE-MsgGUID: ba8yQ2UHSCKJc0G0pnuv0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6238759"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 03:00:16 -0800
Date: Tue, 3 Nov 2026 13:00:13 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Chi-Wen Weng <cwweng.linux@gmail.com>
Cc: jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, cwweng@nuvoton.com
Subject: Re: [PATCH v3 2/2] iio: adc: Add Nuvoton MA35D1 EADC driver
Message-ID: <aum-vUx5oFSocGc1@ashevche-desk.local>
References: <20261030031501.130290-1-cwweng.linux@gmail.com>
 <20261030031501.130290-3-cwweng.linux@gmail.com>
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
In-Reply-To: <20261030031501.130290-3-cwweng.linux@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 30, 2026 at 11:15:01AM +0800, Chi-Wen Weng wrote:

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

...

> +static const struct regmap_config ma35d1_adc_regmap_config = {
> +	.reg_bits = 32,
> +	.val_bits = 32,
> +	.reg_stride = 4,
> +	.max_register = MA35D1_EADC_REFADJCTL,

> +	.cache_type = REGCACHE_NONE,

This has to be justified. If it's indeed necessary, explain in the comment
above why cache is disabled.

> +};

...

> +static int ma35d1_adc_reset_control(struct ma35d1_adc *adc)
> +{
> +	struct regmap *map = adc->regmap;
> +	unsigned int val;
> +	int ret;
> +
> +	ret = regmap_set_bits(map, MA35D1_EADC_CTL, MA35D1_EADC_CTL_EADCRST);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_read_poll_timeout(map, MA35D1_EADC_CTL, val,
> +					!(val & MA35D1_EADC_CTL_EADCRST),
> +					1, USEC_PER_MSEC);

Use numbers with multipliers, id est 1 * USEC_PER_MSEC.

> +}

...

> +	/* Drain an interrupt which may already have been latched by the GIC. */
> +	synchronize_irq(adc->irq);
> +
> +	err = regmap_write(map, MA35D1_EADC_STATUS2,
> +			   MA35D1_EADC_STATUS2_ADIF0);

It's perfectly a single line precisely with 80 characters in it.

> +	if (!ret)
> +		ret = err;
> +
> +	reinit_completion(&adc->completion);

...

> +static irqreturn_t ma35d1_adc_isr(int irq, void *data)
> +{
> +	struct iio_dev *indio_dev = data;
> +	struct ma35d1_adc *adc = iio_priv(indio_dev);
> +	unsigned int status;
> +	int ret;

> +	ret = regmap_read(adc->regmap, MA35D1_EADC_STATUS2, &status);
> +	if (ret || !(status & MA35D1_EADC_STATUS2_ADIF0))
> +		return IRQ_NONE;

Split this to two conditions, it will be better to maintain in a long term.

> +	regmap_write(adc->regmap, MA35D1_EADC_STATUS2,
> +		     MA35D1_EADC_STATUS2_ADIF0);

Use local variable and make this a single line.
Btw, no return check here because...?

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
> +
> +		if (IIO_DEV_ACQUIRE_FAILED(claim))
> +			return -EBUSY;
> +
> +		guard(mutex)(&adc->lock);

+ blank line. Make guard()() to be visible in the code at a glance.

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

Perhaps make two definitions? 11 already second time appears in the code.

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
> +	const struct iio_chan_spec *scan_chan = NULL;
> +	unsigned long bit;
> +
> +	for_each_set_bit(bit, scan_mask, iio_get_masklength(indio_dev)) {
> +		const struct iio_chan_spec *chan = &indio_dev->channels[bit];

IIRC we have a for_each macro for this.

> +
> +		if (chan->type == IIO_TIMESTAMP)
> +			continue;
> +
> +		if (chan->type != IIO_VOLTAGE || scan_chan)
> +			return -EINVAL;
> +
> +		scan_chan = chan;
> +	}
> +
> +	if (!scan_chan)
> +		return -EINVAL;
> +
> +	adc->scan_chan = scan_chan;
> +
> +	return 0;
> +}

...

> +static int ma35d1_adc_buffer_postenable(struct iio_dev *indio_dev)
> +{
> +	struct ma35d1_adc *adc = iio_priv(indio_dev);
> +
> +	guard(mutex)(&adc->lock);
> +
> +	if (adc->suspended)
> +		return -EBUSY;
> +
> +	return adc->scan_chan ? 0 : -EINVAL;

Unroll to if return; return. As it's done just in above function.

> +}

...

> +static irqreturn_t ma35d1_adc_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct ma35d1_adc *adc = iio_priv(indio_dev);
> +	IIO_DECLARE_BUFFER_WITH_TS(u16, scan, 1) = { };
> +	u16 raw;
> +	int ret;
> +
> +	mutex_lock(&adc->lock);

Use guard()(). This might require to split the content into the helper
function.

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

...

> +static int ma35d1_adc_fwnode_xlate(struct iio_dev *indio_dev,
> +				   const struct fwnode_reference_args *iiospec)
> +{
> +	unsigned int i;

Not used outside the loop.

> +	if (iiospec->nargs != 1)
> +		return -EINVAL;
> +
> +	for (i = 0; i < indio_dev->num_channels; i++) {

	for (unsigned int i = 0; i < indio_dev->num_channels; i++) {


> +		const struct iio_chan_spec *chan = &indio_dev->channels[i];
> +
> +		if (chan->type == IIO_VOLTAGE &&
> +		    chan->channel == iiospec->args[0])
> +			return i;
> +	}
> +
> +	return -EINVAL;
> +}

...

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

-ENOSPC

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
> +
> +		ret = fwnode_property_read_u32(child, "reg", &reg);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "missing channel reg property\n");
> +
> +		if (reg >= MA35D1_EADC_MAX_EXT_CHANNELS)
> +			return dev_err_probe(dev, -EINVAL,

-ENOSPC

> +					     "invalid ADC channel index %u\n", reg);
> +
> +		if (test_and_set_bit(reg, used_regs))
> +			return dev_err_probe(dev, -EINVAL,
> +					     "duplicate ADC channel index %u\n", reg);

-EEXIST

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

-ECHRNG

> +			vinn = 0;
> +			differential = false;
> +		} else {
> +			if (reg >= 4)
> +				return dev_err_probe(dev, -EINVAL,

Ditto.

> +						     "invalid differential pair %u\n", reg);
> +
> +			vinp = reg;
> +			vinn = reg + 4;
> +			differential = true;
> +		}
> +
> +		ma35d1_adc_init_channel(&channels[scan_index], reg, vinp, vinn,
> +					scan_index, differential);
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
> +	if (ret <= 0)

Too many nested branches. Unroll it

> +		return dev_err_probe(dev, ret ?: -EINVAL,
> +				     "failed to get VREF voltage\n");

	if (ret < 0)
		return dev_err_probe(dev, ret, "failed to get VREF voltage\n");
	if (ret == 0)
		return dev_err_probe(dev, -EINVAL, "wrong VREF voltage\n");

> +	adc->vref_mV = ret / (MICRO / MILLI);
> +
> +	return 0;
> +}

...

> +static int ma35d1_adc_suspend(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct ma35d1_adc *adc = iio_priv(indio_dev);

	struct regmap *map = adc->regmap;

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

	ret = regmap_clear_bits(map, MA35D1_EADC_CTL, MA35D1_EADC_CTL_ADCEN);

> +	if (ret)
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

-- 
With Best Regards,
Andy Shevchenko


