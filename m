Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9EE3CE0AE;
	Fri, 26 Jun 2026 12:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782478485; cv=none; b=i8VBIz724Etms5OTLI0jQuHRqVlhdh5f46iEUP4u8JUgDqLrlvX4nXfvPp4qFeBtE6VcV/WukKBjRM7oQsDEJnGu6VDdx583fQWm/T36acVC2Ggh8PuGakFPUR2FQaYb4e9AH3WsVTw1ypZXo7EFJHp9SLu9I2EYULeLktyjTQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782478485; c=relaxed/simple;
	bh=bA5gZ8nVjmIMUXVdBIALv/ZULDjKZlaMP/awFqfmKX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PEhiHQJMe0b5lkP0d8ykzM2MgcPyOqoeO4dhrEs2HdCfS5AfZplWSLvAyOOovrsUiV8SVv9oPHaHqlKgMJVvO4hzsbM9UpTYoZ/Sfl0Qomijj2NFYAGxJG9NYzGzkRiPho0gT1obcuS4olsxoa/DZ59L6Qr9M4qu4Hjem6f3V9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lKj8Dm1M; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lKj8Dm1M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782478483; x=1814014483;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bA5gZ8nVjmIMUXVdBIALv/ZULDjKZlaMP/awFqfmKX8=;
  b=lKj8Dm1MhES6uC8+lEfv9Jjlea8vUuBFG09KdEbb4yzQPQvHUTDjR26z
   OPc1/aTXDDMAQoNtrO8Q3tJ4ha6u1HlqrF0bL7bSsKqTI7DrUVy9dsVMI
   fSuKBQuMZACpnIHBp08X4oE9apiobDsZL5FHTIG7CkSomvN9ukKYFlOvw
   aaqgwZ3KSWIBCDnyLMeOiiy25VsnERTOX+T1XNQ+p3fuUGGFONA40rYRJ
   bwcBn3e3A9gb4bnNCAZPTjFVx/fk3MVhdYiijbnLxtJlGc4J3dwp3+uIu
   I/PCKLmLMyrea+TbgGUCeNk9YH1Cftp040aEuiAi5qrgFjLVEWkDaeLdl
   A==;
X-CSE-ConnectionGUID: sugU8p6DQom5y6zQFOBnlw==
X-CSE-MsgGUID: 8wP3gkCfSTGGyXE7YocOFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11829"; a="85820865"
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="85820865"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2026 05:54:43 -0700
X-CSE-ConnectionGUID: 6f6lVhqIRT+fSWuMTrVidA==
X-CSE-MsgGUID: Z2kmyNMwSXirbLb7R0twYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="274519403"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.1])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2026 05:54:39 -0700
Date: Fri, 26 Jun 2026 15:54:37 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Chi-Wen Weng <cwweng.linux@gmail.com>
Cc: jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, cwweng@nuvoton.com
Subject: Re: [PATCH 2/2] iio: adc: Add Nuvoton MA35D1 EADC driver
Message-ID: <aj52jaJK3qwvQu2k@ashevche-desk.local>
References: <20260625110638.38438-1-cwweng.linux@gmail.com>
 <20260625110638.38438-3-cwweng.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625110638.38438-3-cwweng.linux@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jun 25, 2026 at 07:06:38PM +0800, Chi-Wen Weng wrote:

> Add an IIO driver for the Nuvoton MA35D1 Enhanced ADC controller.
> 
> The driver supports direct raw reads and triggered buffered capture. The
> controller end-of-conversion interrupt is exposed as the device trigger
> and is used to push samples into the IIO buffer.
> 
> Channels are described by firmware child nodes and can be configured as
> single-ended or differential inputs. Since the differential enable bit is
> global, mixed single-ended and differential buffered scans are rejected.
> 
> DMA support is intentionally not included in this initial upstream driver;
> conversions are handled through the interrupt-driven path.

Nice written driver, some small issues here and there, and I think in a couple
of versions it will stabilize and can be accepted.

...

> +#include <linux/bitfield.h>

> +#include <linux/bits.h>

No need, bitmap.h covers this.

> +#include <linux/bitmap.h>
> +#include <linux/clk.h>
> +#include <linux/completion.h>

> +#include <linux/device.h>

No need, covered by platform_device.h.

> +#include <linux/err.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>

> +#include <linux/kernel.h>

No way this header should be in the mere drivers.

> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/mutex.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm.h>
> +#include <linux/property.h>

Also missing some headers, such as types.h.

...

> +#define MA35D1_EADC_TIMEOUT		msecs_to_jiffies(1000)

+ jiffies.h

...

> +static inline u32 ma35d1_adc_read(struct ma35d1_adc *adc, u32 reg)
> +{
> +	return readl(adc->regs + reg);
> +}
> +
> +static inline void ma35d1_adc_write(struct ma35d1_adc *adc, u32 reg, u32 val)
> +{
> +	writel(val, adc->regs + reg);
> +}
> +
> +static void ma35d1_adc_rmw(struct ma35d1_adc *adc, u32 reg, u32 mask, u32 val)

Name it _update() to be aligned with the _read() and _write() above.

> +{
> +	u32 tmp;
> +
> +	tmp = ma35d1_adc_read(adc, reg);
> +	tmp &= ~mask;
> +	tmp |= val;

Correct pattern is to use

	tmp = (tmp & ~mask) | (val & mask);

> +	ma35d1_adc_write(adc, reg, tmp);
> +}

...

> +static void ma35d1_adc_config_sample(struct ma35d1_adc *adc,
> +				     unsigned int sample, unsigned int channel)
> +{
> +	u32 reg = MA35D1_EADC_SCTL(sample);

I don't see the need of this variable, use the value directly.

> +	ma35d1_adc_rmw(adc, reg,
> +		       MA35D1_EADC_SCTL_CHSEL_MASK |
> +		       MA35D1_EADC_SCTL_TRGSEL_MASK,
> +		       FIELD_PREP(MA35D1_EADC_SCTL_CHSEL_MASK, channel) |
> +		       MA35D1_EADC_SCTL_TRGSEL_ADINT0);
> +}

...

> +static irqreturn_t ma35d1_adc_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct ma35d1_adc *adc = iio_priv(indio_dev);

> +	int i;
> +
> +	for (i = 0; i < adc->scan_chancnt; i++)

	for (unsigned int i = 0; i < adc->scan_chancnt; i++)

> +		adc->scan.channels[i] =
> +			ma35d1_adc_read(adc, MA35D1_EADC_DAT(i)) &
> +			MA35D1_EADC_DAT_MASK;
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, &adc->scan, pf->timestamp);
> +	iio_trigger_notify_done(adc->trig);
> +
> +	ma35d1_adc_rmw(adc, MA35D1_EADC_CTL, MA35D1_EADC_CTL_ADCIEN0,
> +		       MA35D1_EADC_CTL_ADCIEN0);
> +	ma35d1_adc_write(adc, MA35D1_EADC_SWTRG, 1);
> +
> +	return IRQ_HANDLED;
> +}

...

> +static int ma35d1_adc_validate_scan(struct iio_dev *indio_dev,
> +				    const unsigned long *scan_mask)
> +{
> +	const struct iio_chan_spec *chan;
> +	bool have_single = false;
> +	bool have_diff = false;
> +	unsigned int count = 0;
> +	unsigned long bit;
> +
> +	for_each_set_bit(bit, scan_mask, indio_dev->masklength) {
> +		chan = &indio_dev->channels[bit];
> +
> +		if (chan->type == IIO_TIMESTAMP)
> +			continue;

> +		count++;

Make it last in the loop, it will be standard pattern. Otherwise it's hard to
read and find. Also it's recommended to split assignment and definition
for better maintenance.

	unsigned int count;
	...
	count = 0;
	for_each_set_bit(bit, scan_mask, indio_dev->masklength) {
		...
		count++;
	}

> +		if (chan->differential)
> +			have_diff = true;
> +		else
> +			have_single = true;
> +	}
> +
> +	if (!count || count > MA35D1_EADC_MAX_SAMPLE_MODULES)
> +		return -EINVAL;

> +	if (have_single && have_diff)
> +		return -EINVAL;

Is it possible IRL?

> +	return 0;
> +}

...

> +static int ma35d1_adc_buffer_postenable(struct iio_dev *indio_dev)
> +{
> +	struct ma35d1_adc *adc = iio_priv(indio_dev);
> +	int i;
> +
> +	if (!adc->scan_chancnt)
> +		return -EINVAL;
> +
> +	ma35d1_adc_write(adc, MA35D1_EADC_STATUS2, MA35D1_EADC_STATUS2_ADIF0);
> +	ma35d1_adc_rmw(adc, MA35D1_EADC_INTSRC0,
> +		       MA35D1_EADC_INTSRC0_ADINT0,
> +		       MA35D1_EADC_INTSRC0_ADINT0);
> +	ma35d1_adc_rmw(adc, MA35D1_EADC_REFADJCTL,
> +		       MA35D1_EADC_REFADJCTL_EXT_VREF,
> +		       MA35D1_EADC_REFADJCTL_EXT_VREF);
> +	ma35d1_adc_rmw(adc, MA35D1_EADC_SELSMP0, GENMASK(1, 0), 3);
> +	ma35d1_adc_set_diff(adc, adc->scan_differential);
> +	for (i = 0; i < adc->scan_chancnt; i++)

	for (unsigned int i = 0; i < adc->scan_chancnt; i++)

> +		ma35d1_adc_rmw(adc, MA35D1_EADC_SCTL(i),
> +			       MA35D1_EADC_SCTL_TRGDLY_MASK,
> +			       MA35D1_EADC_SCTL_TRGDLY_MASK);
> +
> +	ma35d1_adc_rmw(adc, MA35D1_EADC_CTL, MA35D1_EADC_CTL_ADCIEN0,
> +		       MA35D1_EADC_CTL_ADCIEN0);
> +	ma35d1_adc_write(adc, MA35D1_EADC_SWTRG, 1);
> +
> +	return 0;
> +}
> +
> +static int ma35d1_adc_buffer_predisable(struct iio_dev *indio_dev)
> +{
> +	struct ma35d1_adc *adc = iio_priv(indio_dev);
> +	int i;
> +
> +	ma35d1_adc_disable_irq(adc);
> +	for (i = 0; i < adc->scan_chancnt; i++)
> +		ma35d1_adc_rmw(adc, MA35D1_EADC_SCTL(i),
> +			       MA35D1_EADC_SCTL_TRGSEL_MASK, 0);

Ditto.

Also looking to the cases of setting 0s, I would rather have a helper
_set_bits() / _clear_bits() in conjunction with _update().

> +	return 0;
> +}

...

> +static void ma35d1_adc_init_channel(struct ma35d1_adc *adc,
> +				    struct iio_chan_spec *chan, u32 vinp,
> +				    u32 vinn, int scan_index, bool differential)
> +{
> +	char *name = adc->chan_name[vinp];
> +
> +	chan->type = IIO_VOLTAGE;
> +	chan->indexed = 1;
> +	chan->channel = vinp;
> +	chan->address = vinp;
> +	chan->scan_index = scan_index;
> +	chan->info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
> +	chan->scan_type.sign = 'u';
> +	chan->scan_type.realbits = 12;
> +	chan->scan_type.storagebits = 16;
> +	chan->scan_type.endianness = IIO_CPU;
> +
> +	if (differential) {
> +		chan->differential = 1;
> +		chan->channel2 = vinn;

> +		snprintf(name, MA35D1_EADC_CHAN_NAME_LEN, "in%d-in%d", vinp,
> +			 vinn);

Can compiler prove the buffer size is enough?

> +	} else {
> +		snprintf(name, MA35D1_EADC_CHAN_NAME_LEN, "in%d", vinp);
> +	}
> +
> +	chan->datasheet_name = name;

Why not use devm_kasprintf() instead?

> +}

...

> +static int ma35d1_adc_parse_channels(struct iio_dev *indio_dev,
> +				     struct device *dev)
> +{
> +	struct ma35d1_adc *adc = iio_priv(indio_dev);
> +	DECLARE_BITMAP(used_channels, MA35D1_EADC_MAX_CHANNELS);
> +	struct fwnode_handle *child;
> +	struct iio_chan_spec *channels;
> +	int num_channels;
> +	int scan_index = 0;
> +	int ret;
> +
> +	bitmap_zero(used_channels, MA35D1_EADC_MAX_CHANNELS);
> +
> +	num_channels = device_get_child_node_count(dev);
> +	if (!num_channels)
> +		return dev_err_probe(dev, -ENODATA,
> +				     "no ADC channels configured\n");
> +
> +	if (num_channels > MA35D1_EADC_MAX_CHANNELS)

Perhaps >= ?

> +		return dev_err_probe(dev, -EINVAL, "too many ADC channels\n");
> +
> +	channels = devm_kcalloc(dev, num_channels + 1, sizeof(*channels),
> +				GFP_KERNEL);
> +	if (!channels)
> +		return -ENOMEM;
> +
> +	device_for_each_child_node(dev, child) {

Use _scoped() variant.

> +		u32 diff[2];
> +		u32 reg;
> +		bool differential = false;
> +
> +		ret = fwnode_property_read_u32(child, "reg", &reg);
> +		if (ret) {
> +			fwnode_handle_put(child);
> +			return dev_err_probe(dev, ret,
> +					     "missing channel reg property\n");
> +		}
> +
> +		if (reg >= MA35D1_EADC_MAX_CHANNELS) {
> +			fwnode_handle_put(child);
> +			return dev_err_probe(dev, -EINVAL,
> +					     "invalid ADC channel %u\n", reg);
> +		}
> +
> +		if (test_and_set_bit(reg, used_channels)) {
> +			fwnode_handle_put(child);
> +			return dev_err_probe(dev, -EINVAL,
> +					     "duplicate ADC channel %u\n", reg);
> +		}
> +
> +		if (fwnode_property_present(child, "diff-channels")) {
> +			ret = fwnode_property_read_u32_array(child,
> +							     "diff-channels",
> +							     diff,
> +							     ARRAY_SIZE(diff));
> +			if (ret) {
> +				fwnode_handle_put(child);
> +				return dev_err_probe(dev, ret,
> +						     "invalid diff-channels for channel %u\n",
> +						     reg);
> +			}
> +
> +			if (diff[0] != reg ||
> +			    diff[1] >= MA35D1_EADC_MAX_CHANNELS ||
> +			    diff[0] == diff[1]) {
> +				fwnode_handle_put(child);
> +				return dev_err_probe(dev, -EINVAL,
> +						     "invalid differential ADC channel %u-%u\n",
> +						     diff[0], diff[1]);
> +			}
> +
> +			if (test_and_set_bit(diff[1], used_channels)) {
> +				fwnode_handle_put(child);
> +				return dev_err_probe(dev, -EINVAL,
> +						     "ADC channel %u already used\n",
> +						     diff[1]);
> +			}
> +
> +			differential = true;
> +		}
> +
> +		ma35d1_adc_init_channel(adc, &channels[scan_index], reg,
> +					differential ? diff[1] : 0,
> +					scan_index, differential);
> +		scan_index++;
> +	}
> +
> +	channels[scan_index] = (struct iio_chan_spec)
> +		IIO_CHAN_SOFT_TIMESTAMP(scan_index);
> +
> +	indio_dev->channels = channels;
> +	indio_dev->num_channels = scan_index + 1;
> +	indio_dev->masklength = indio_dev->num_channels;
> +
> +	return 0;
> +}

...

> +	ret = devm_request_irq(dev, irq, ma35d1_adc_isr, 0, dev_name(dev),
> +			       indio_dev);

Make it a single line, here it's fine.

> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to request IRQ %d\n", irq);

Remove duplicate error message.

...

> +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
> +					      iio_pollfunc_store_time,
> +					      ma35d1_adc_trigger_handler,
> +					      &ma35d1_adc_buffer_ops);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "failed to setup triggered buffer\n");

So, it seems this is very rarely can be not -ENOMEM, and hence it's 99.99% dead
code, just

		return ret;

-- 
With Best Regards,
Andy Shevchenko


