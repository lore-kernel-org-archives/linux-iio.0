Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187C638CFE4;
	Mon, 13 Jul 2026 11:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783941444; cv=none; b=N/AD4eshUP1GBEO/Jkp0ylW0aBBHFg60q50LLofQYlvMRNmDhid2T+6UdU89xGXhIvuEC3WpboZzUlBFPIJV1TbYip6loRmLtQ/o+Qpdde7eSWgwedDbMPF/URUS7+77aP7CA7JsO0Xom4mCt0xiuk8ik0ewZnF7rErm1MdkEh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783941444; c=relaxed/simple;
	bh=iHS/mqFD8C2vBjNlpNkajl8s8GppsnHj6jRwqvH5M/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bpUvQiek3kE0/6E0Mog9MQ6/oWyuDU9r0Y+Pc0GBPxuy4SDQNU7Yz0LSDVcwo6dZdYebMUPkYlmWmIArPMSq72uvwEA0Ml2V35VN6XaA2Gjy3aOMSaHRdkaU59oEHvgXefY7SUN+9Bye27HBBRU6o5PXRutTNIO+MCKI0A5XfH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=doLTLB0p; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="doLTLB0p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783941442; x=1815477442;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iHS/mqFD8C2vBjNlpNkajl8s8GppsnHj6jRwqvH5M/k=;
  b=doLTLB0pckypX8Z5lsSyJKyXB/zYN3J10AaxPlFsGlvY1cr3oXa88XCC
   qteXGa3/xTZvEjcxVjx0zKOB3szz/X7a/Nq9aBmv4Vjvlf8vgLRLc4UyA
   2Tgk5UHax1pQU3/JzYmmp1RLnObfaCRJlmDamO9c4EpUA4zzu4dmhPdJv
   qIyPiD1Jww+R/mhfStaUp6I3PuILZN8lXPAYAFcl+sOvA+LCsfL5eqXuR
   GOX5Ml8gVwvQwYGlh/slo0NdvMBIs7d6rtn7EIxOvu9K4vEv3E4a8BOGu
   TPkcPC95YBQvZtZRB+5wTp24xk/NuDsiVXCNyIVMf4zUnO3P3cB4etbu4
   w==;
X-CSE-ConnectionGUID: o0E9j/ZWSjCfc63yOzfuUA==
X-CSE-MsgGUID: jbnN+76CTA6qXqz+oJB+dQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="72071052"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="72071052"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 04:17:21 -0700
X-CSE-ConnectionGUID: EbCMWskkSeq/rP0qgjYf6g==
X-CSE-MsgGUID: aenXfxB+TgKtETWRwtU20w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="260416437"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.88])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 04:17:18 -0700
Date: Mon, 13 Jul 2026 14:17:16 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Chi-Wen Weng <cwweng.linux@gmail.com>
Cc: jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, cwweng@nuvoton.com
Subject: Re: [PATCH v2 2/2] iio: adc: Add Nuvoton MA35D1 EADC driver
Message-ID: <alTJPExu9b3lRtx_@ashevche-desk.local>
References: <20260713081127.115197-1-cwweng.linux@gmail.com>
 <20260713081127.115197-3-cwweng.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713081127.115197-3-cwweng.linux@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jul 13, 2026 at 04:11:27PM +0800, Chi-Wen Weng wrote:

> Add an IIO driver for the Nuvoton MA35D1 Enhanced ADC controller.
> 
> The driver supports interrupt-driven direct raw reads and triggered
> buffered capture paced by an external IIO trigger. Buffered capture is
> limited to a single enabled voltage channel per scan in this initial
> implementation.
> 
> Channels are described by firmware child nodes. Single-ended external
> channels and the fixed hardware differential input pairs are supported.
> The driver reports IIO scale from either an optional external reference
> supply or the internal 1.6 V reference.
> 
> The driver also handles the functional clock and optional reset line.
> DMA support is not used by this initial driver.

...

> +#include <linux/bitfield.h>
> +#include <linux/bitmap.h>

bitmap.h implies bitops.h...

> +#include <linux/bitops.h>

...so you may drop this one.

> +#include <linux/cleanup.h>
> +#include <linux/clk.h>
> +#include <linux/completion.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/jiffies.h>

> +#include <linux/mod_devicetable.h>

Uwe made a series to get rid of this header. The platform_device.h seems
the one which will provide the thing.

> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/reset.h>
> +#include <linux/types.h>

...

> +#define MA35D1_EADC_DAT(n)		(0x00 + (n) * 0x04)
> +#define MA35D1_EADC_CTL			0x50
> +#define MA35D1_EADC_SWTRG		0x54
> +#define MA35D1_EADC_SCTL(n)		(0x80 + (n) * 0x04)
> +#define MA35D1_EADC_INTSRC0		0xd0
> +#define MA35D1_EADC_STATUS2		0xf8
> +#define MA35D1_EADC_SELSMP0		0x140
> +#define MA35D1_EADC_REFADJCTL		0x150

Please, make all register offsets fixed width, exempli gratia

define MA35D1_EADC_STATUS2		0x0f8

...

> +#define MA35D1_EADC_INTSRC0_SPLIEN(n)	BIT(n)

Useless? Can't BIT() be used directly? (Note, I don't know
if it's good or bad suggestion, wanting to understand a bit more.)

...

> +#define MA35D1_EADC_MAX_EXT_CHANNELS	8
> +#define MA35D1_EADC_INTERNAL_VREF_MV	1600

_mV (yes, as per SI).

> +#define MA35D1_EADC_TIMEOUT		msecs_to_jiffies(1000)
> +#define MA35D1_EADC_RESET_DELAY_US	10
> +#define MA35D1_EADC_REF_STABLE_US	1000

(1 * USEC_PER_MSEC) ?
If go this way, include time.h for the multiplier definition.

...

> +struct ma35d1_adc {
> +	struct regmap *regmap;
> +	struct clk *clk;
> +	struct reset_control *rst;
> +	struct regulator *vref;
> +	struct completion completion;
> +	/* Protects conversion state and register accesses from PM transitions. */
> +	struct mutex lock;
> +	const struct iio_chan_spec *scan_chan;
> +	unsigned int vref_mv;

_mV

> +	int irq;
> +	bool suspended;
> +};

...

> +static const struct regmap_config ma35d1_adc_regmap_config = {
> +	.reg_bits = 32,
> +	.val_bits = 32,
> +	.reg_stride = 4,
> +	.max_register = MA35D1_EADC_REFADJCTL,

No cache?

> +};

...

> +static bool ma35d1_adc_valid_diff_pair(unsigned int vinp, unsigned int vinn)
> +{
> +	return (vinp == 0 && vinn == 4) ||
> +	       (vinp == 1 && vinn == 5) ||
> +	       (vinp == 2 && vinn == 6) ||
> +	       (vinp == 3 && vinn == 7);

Wondering if this is just

	return (vinp >= 0 && vinp < 4 && (vinn == vinp + 4));

But I'm fine with the original, perhaps compiler may optimise that.

> +}

...

> +static int ma35d1_adc_set_bits(struct ma35d1_adc *adc, unsigned int reg,
> +			       unsigned int bits)
> +{
> +	return regmap_set_bits(adc->regmap, reg, bits);
> +}
> +
> +static int ma35d1_adc_clear_bits(struct ma35d1_adc *adc, unsigned int reg,
> +				 unsigned int bits)
> +{
> +	return regmap_clear_bits(adc->regmap, reg, bits);
> +}

What's the point in these wrappers?

...

> +static int ma35d1_adc_disable_irq(struct ma35d1_adc *adc)
> +{
> +	return ma35d1_adc_clear_bits(adc, MA35D1_EADC_CTL,
> +				     MA35D1_EADC_CTL_ADCIEN0);

I would make it one line (*yes, 84 characters).

> +}

...

> +static int ma35d1_adc_setup_reference(struct ma35d1_adc *adc)
> +{
> +	int ret;
> +
> +	if (adc->vref) {
> +		ret = regmap_set_bits(adc->regmap, MA35D1_EADC_REFADJCTL,
> +				      MA35D1_EADC_REFADJCTL_PDREF);
> +		if (ret)
> +			return ret;
> +	} else {
> +		ret = regmap_clear_bits(adc->regmap, MA35D1_EADC_REFADJCTL,
> +					MA35D1_EADC_REFADJCTL_PDREF);
> +		if (ret)
> +			return ret;
> +
> +		ret = regmap_update_bits(adc->regmap, MA35D1_EADC_CTL,
> +					 MA35D1_EADC_CTL_VREFSEL_MASK,
> +					 MA35D1_EADC_CTL_VREFSEL_1V6);
> +		if (ret)
> +			return ret;
> +	}

Add a short comment with reference to a datasheet table/section/et cetera.

> +	fsleep(MA35D1_EADC_REF_STABLE_US);
> +
> +	return 0;
> +}

...

> +static int ma35d1_adc_hw_init(struct ma35d1_adc *adc)
> +{
> +	int ret;
> +
> +	ret = ma35d1_adc_disable_irq(adc);
> +	if (ret)
> +		return ret;
> +
> +	ret = ma35d1_adc_setup_reference(adc);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_update_bits(adc->regmap, MA35D1_EADC_SELSMP0,
> +				 MA35D1_EADC_SELSMP0_SMPT0_MASK,
> +				 MA35D1_EADC_SELSMP_LONG);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(adc->regmap, MA35D1_EADC_STATUS2,
> +			   MA35D1_EADC_STATUS2_ADIF0);

With

	static regmap *map = adc->regmap;

this becomes

	ret = regmap_write(map, MA35D1_EADC_STATUS2, MA35D1_EADC_STATUS2_ADIF0);

exactly one line. Apply this trick everywhere and it might help reduce
amount of LoC.

> +	if (ret)
> +		return ret;
> +
> +	return ma35d1_adc_set_bits(adc, MA35D1_EADC_CTL, MA35D1_EADC_CTL_ADCEN);
> +}

...

> +static int ma35d1_adc_config_channel(struct ma35d1_adc *adc,
> +				     const struct iio_chan_spec *chan)
> +{
> +	unsigned int ctl;
> +	int ret;
> +
> +	ctl = chan->differential ? MA35D1_EADC_CTL_DIFFEN |
> +					  MA35D1_EADC_CTL_DMOF : 0;
> +
> +	ret = regmap_update_bits(adc->regmap, MA35D1_EADC_CTL,
> +				 MA35D1_EADC_CTL_DIFFEN |
> +				 MA35D1_EADC_CTL_DMOF, ctl);
> +	if (ret)
> +		return ret;

regmap_assign_bits()

> +	ret = regmap_update_bits(adc->regmap, MA35D1_EADC_SCTL(0),
> +				 MA35D1_EADC_SCTL_CHSEL_MASK |
> +				 MA35D1_EADC_SCTL_TRGSEL_MASK,
> +				 FIELD_PREP(MA35D1_EADC_SCTL_CHSEL_MASK,
> +					    chan->channel));
> +	if (ret)
> +		return ret;
> +
> +	return regmap_update_bits(adc->regmap, MA35D1_EADC_INTSRC0,
> +				  MA35D1_EADC_INTSRC0_SPLIEN(0),
> +				  MA35D1_EADC_INTSRC0_SPLIEN(0));
> +}

...

> +static int ma35d1_adc_update_scan_mode(struct iio_dev *indio_dev,
> +				       const unsigned long *scan_mask)
> +{
> +	struct ma35d1_adc *adc = iio_priv(indio_dev);
> +	const struct iio_chan_spec *scan_chan = NULL;
> +	unsigned long bit;
> +	unsigned int count;
> +
> +	count = 0;
> +	for_each_set_bit(bit, scan_mask, indio_dev->masklength) {
> +		scan_chan = &indio_dev->channels[bit];
> +		count++;
> +	}
> +
> +	if (count != 1 || scan_chan->type != IIO_VOLTAGE)
> +		return -EINVAL;


This is interesting check. First of all, it checks if the only a single bit is
set in the whole mask, then it checks the type of the *last* listed channel.
The latter seems fragile to me, as it depends on ordering (yes, the limitation
to a single enabled channel helps).

With that being said, the both checks can be unrolled to the find_next_bit().

	/* Find the first enabled channel to scan */
	bit = find_next_bit(scan_mask, indio_dev->masklength, 0);
	if (bit >= indio_dev->masklength)
		return -EINVAL;

	/* Check that the type of the channel is what we are looking for */
	scan_chan = &indio_dev->channels[bit];
	if (scan_chan->type != IIO_VOLTAGE)
		return -EINVAL;

	/* Check that this is the only enabled channel */
	bit = find_next_bit(scan_mask, indio_dev->masklength, bit);
	if (bit < indio_dev->masklength)
		return -EINVAL;

Not sure that this will generate less code, though. So up to you.
One also might argue that the original code is easier to understand.

> +	adc->scan_chan = scan_chan;
> +
> +	return 0;
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
> +	guard(mutex)(&adc->lock);
> +	if (adc->suspended || !adc->scan_chan)
> +		goto done;

This is usually leads to a mess in the compiler. This is written in the top of
cleanup.h that goto should be avoided while using guard()() or similar macros.

> +	ret = ma35d1_adc_read_conversion(adc, adc->scan_chan, &raw);
> +	if (ret)
> +		goto done;
> +
> +	scan[0] = raw & MA35D1_EADC_DAT_RESULT_12BIT;
> +	iio_push_to_buffers_with_timestamp(indio_dev, scan, pf->timestamp);
> +
> +done:
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}

...

> +static void ma35d1_adc_init_channel(struct iio_chan_spec *chan, u32 vinp,
> +				    u32 vinn, unsigned int scan_index,
> +				    bool differential)
> +{
> +	chan->type = IIO_VOLTAGE;
> +	chan->indexed = 1;
> +	chan->channel = vinp;
> +	chan->scan_index = scan_index;
> +	chan->info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +					 BIT(IIO_CHAN_INFO_SCALE);

Broken indentation, better to have

	chan->info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE);

OR

	chan->info_mask_separate =
		BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE);

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

...

> +static struct iio_chan_spec
> +ma35d1_adc_timestamp_channel(unsigned int scan_index)
> +{
> +	struct iio_chan_spec chan = IIO_CHAN_SOFT_TIMESTAMP(scan_index);
> +
> +	return chan;
> +}

Useless wrapper. Just put _SOFT_TIMESTAMP() in place.

...

> +static int ma35d1_adc_parse_channels(struct iio_dev *indio_dev,
> +				     struct device *dev)
> +{
> +	DECLARE_BITMAP(used_channels, MA35D1_EADC_MAX_EXT_CHANNELS);
> +	struct iio_chan_spec *channels;
> +	unsigned int scan_index;
> +	int num_channels;
> +	int ret;
> +
> +	bitmap_zero(used_channels, MA35D1_EADC_MAX_EXT_CHANNELS);
> +
> +	num_channels = device_get_child_node_count(dev);
> +	if (!num_channels)
> +		return dev_err_probe(dev, -ENODATA,
> +				     "no ADC channels configured\n");

I would return -ENOENT, as it's usual error code for 0 count in counting APIs
in the kernel. Also you can put it on a single line.

> +	if (num_channels > MA35D1_EADC_MAX_EXT_CHANNELS)
> +		return dev_err_probe(dev, -EINVAL, "too many ADC channels\n");
> +
> +	channels = devm_kcalloc(dev, num_channels + 1, sizeof(*channels), GFP_KERNEL);

size_add() ?

> +	if (!channels)
> +		return -ENOMEM;
> +
> +	scan_index = 0;
> +	device_for_each_child_node_scoped(dev, child) {
> +		u32 diff[2];
> +		u32 reg;
> +		u32 vinn;
> +		bool differential;
> +
> +		ret = fwnode_property_read_u32(child, "reg", &reg);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "missing channel reg property\n");
> +
> +		if (reg >= MA35D1_EADC_MAX_EXT_CHANNELS)
> +			return dev_err_probe(dev, -EINVAL,
> +					     "invalid ADC channel %u\n", reg);
> +
> +		if (test_and_set_bit(reg, used_channels))
> +			return dev_err_probe(dev, -EINVAL,
> +					     "duplicate ADC channel %u\n", reg);

> +		differential = false;
> +		vinn = 0;

Make it an 'else' branch.

> +		if (fwnode_property_present(child, "diff-channels")) {
> +			ret = fwnode_property_read_u32_array(child, "diff-channels", diff,
> +							     ARRAY_SIZE(diff));
> +			if (ret)
> +				return dev_err_probe(dev, ret,
> +						     "invalid diff-channels for channel %u\n",
> +						     reg);
> +
> +			if (diff[0] != reg ||
> +			    !ma35d1_adc_valid_diff_pair(diff[0], diff[1]))
> +				return dev_err_probe(dev, -EINVAL,
> +						     "invalid differential ADC channel %u-%u\n",
> +						     diff[0], diff[1]);
> +
> +			if (test_and_set_bit(diff[1], used_channels))
> +				return dev_err_probe(dev, -EINVAL,
> +						     "ADC channel %u already used\n",
> +						     diff[1]);
> +
> +			vinn = diff[1];
> +			differential = true;
> +		}
> +
> +		ma35d1_adc_init_channel(&channels[scan_index], reg, vinn,
> +					scan_index, differential);
> +		scan_index++;
> +	}
> +
> +	channels[scan_index] = ma35d1_adc_timestamp_channel(scan_index);
> +
> +	indio_dev->channels = channels;
> +	indio_dev->num_channels = scan_index + 1;
> +	indio_dev->masklength = indio_dev->num_channels;
> +
> +	return 0;
> +}

...

> +static int ma35d1_adc_init_vref(struct ma35d1_adc *adc, struct device *dev)
> +{
> +	int ret;

> +	adc->vref = devm_regulator_get_optional(dev, "vref");
> +	if (IS_ERR(adc->vref)) {
> +		if (PTR_ERR(adc->vref) != -ENODEV)
> +			return dev_err_probe(dev, PTR_ERR(adc->vref),
> +					     "failed to get VREF supply\n");
> +
> +		adc->vref = NULL;
> +		adc->vref_mv = MA35D1_EADC_INTERNAL_VREF_MV;
> +
> +		return 0;
> +	}

It can be unnested:


	if (PTR_ERR(adc->vref) == -ENODEV) {
		adc->vref = NULL;
		adc->vref_mV = MA35D1_EADC_INTERNAL_VREF_mV;
		return 0;
	}
	if (IS_ERR(adc->vref))
		return dev_err_probe(dev, PTR_ERR(adc->vref),
				     "failed to get VREF supply\n");

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
> +		return dev_err_probe(dev, ret ?: -EINVAL,
> +				     "failed to get VREF voltage\n");

> +	adc->vref_mv = ret / 1000;

(MICRO / MILLI)

instead of plain 1000.

> +	return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko


