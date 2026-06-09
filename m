Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B787A3EB0F6;
	Tue,  9 Jun 2026 17:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781027677; cv=none; b=otf0HGlmK7bML+tgzKuG58YyjtL46xGeGDbTG0L10dNQxKAMhOhxE8iVhYwfz0V99EuOeTXTpNSwD/rUje9rluMdOD1pvD/Xg5bENQ2ZKByoXAQ3QAT+clKvvLpVdbnEXL3lzBjOiKx84ITbTxUMlQQZ/xxz+ZPEitu40/is04g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781027677; c=relaxed/simple;
	bh=jUNgttoACNVLikiv/lD1B6M4/ARoSBKpd4Bkv6Dd/8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cG5JRRaxkg1/jO5CWjabUXXYnBkVaoH2HLfgBytni5N0aAqAS3xZMLuZeM+G6tGUW2mvug93AG0ykX4JO7C5/g3Ve2BgxbxxHy2c3aVpNEAeYK0ruwDxruou/YcRsRrtJsF9QCknuoIOMOe8rKE3ab/8hnrCvZLgZsQqOzaZe4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kFmlipK7; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kFmlipK7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781027676; x=1812563676;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jUNgttoACNVLikiv/lD1B6M4/ARoSBKpd4Bkv6Dd/8s=;
  b=kFmlipK7eRWa5UR9otiII+Sc4C6cgnTLgFRwC5Am2DAdjNjHNlWv2t7f
   eqYwpj4YypbFt9pDCPjjLJeCwyAZjcCkpHFRY5dM2Zkyw1Ba1Ij4PZeVR
   T+Nty41Zm7HmrjoMknmvKNr+Q2/U1PWIFP6OCIkzJrYcgSB1iskjCbpWi
   mHVCgQ0JLWcg8In5F6L2GLOi55aw81Q/ZJLkJqXkv93ThrAXCT+e60Rzq
   8NpNCesyuIsgNrEEFwK6yd6EKAPqPhFPnScyJHj85mWidAR13BqAyRCdF
   H0pg6104bmle3eRPWqTfC5tyawPPHBgE+nsAHRw8wMA0jPncD/aUepsyE
   w==;
X-CSE-ConnectionGUID: 407QwJevQVuDtBy8WXPW5w==
X-CSE-MsgGUID: QIgH2uVLSgK+DCNGqbGNpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="81653028"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="81653028"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 10:54:35 -0700
X-CSE-ConnectionGUID: jiuUK330RQaGoCSbnFC8Eg==
X-CSE-MsgGUID: h90WRpTYS7qqMgWdr8Mafg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="269611412"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.162])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 10:54:31 -0700
Date: Tue, 9 Jun 2026 20:54:29 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Salih Erim <salih.erim@amd.com>
Cc: jic23@kernel.org, andy@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, conall.ogriofa@amd.com, michal.simek@amd.com,
	linux@roeck-us.net, erimsalih@gmail.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/5] iio: adc: versal-sysmon: add threshold event
 support
Message-ID: <aihTVQIedgsFKeM7@ashevche-desk.local>
References: <20260608183801.1257051-1-salih.erim@amd.com>
 <20260608183801.1257051-5-salih.erim@amd.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608183801.1257051-5-salih.erim@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jun 08, 2026 at 07:38:00PM +0100, Salih Erim wrote:
> Add threshold event support for temperature and supply voltage
> channels.
> 
> Temperature events:
>   - Rising threshold with configurable value
>   - Over-temperature (OT) alarm with separate threshold
>   - Per-channel hysteresis as a millicelsius value
>   - Event direction is IIO_EV_DIR_RISING (hysteresis mode)
> 
> Supply voltage events:
>   - Rising/falling threshold per supply channel
>   - Per-channel alarm enable via alarm configuration registers
> 
> The hardware supports both window and hysteresis alarm modes for
> temperature. This driver uses hysteresis mode, where the upper
> threshold triggers the alarm and the lower threshold clears it
> (re-arm point). The hardware has a single ISR bit per temperature
> channel with no indication of which threshold was crossed, so
> hysteresis mode is the natural fit. The lower threshold register
> is computed internally as (upper - hysteresis).
> 
> Hysteresis is stored in the driver as a millicelsius value,
> initialized from the hardware registers at probe. Writing the
> rising threshold or hysteresis recomputes the lower register.
> ALARM_CONFIG is hard-coded to hysteresis mode during init.
> 
> The interrupt handler masks active threshold interrupts (which are
> level-sensitive) and schedules a delayed worker to poll for condition
> clear before unmasking. When no hardware IRQ is available, event
> channels are not created and interrupt init is skipped, since the
> I2C regmap backend cannot be called from atomic context.
> 
> When disabling a supply channel alarm, the group interrupt remains
> active if any other channel in the same alarm group still has an
> alarm enabled.

...

> +#define SYSMON_CHAN_TEMP_EVENT(_chan, _address, _name, _events) {\

Just move { to be on the separate line, it will make the macro look better.

#define SYSMON_CHAN_TEMP_EVENT(_chan, _address, _name, _events)	\
{								\

> +	.type = IIO_TEMP,					\
> +	.indexed = 1,						\
> +	.address = _address,					\
> +	.channel = _chan,					\
> +	.event_spec = _events,					\
> +	.num_event_specs = ARRAY_SIZE(_events),			\
> +	.datasheet_name = _name,				\
> +}

...

> +static int sysmon_write_event_config(struct iio_dev *indio_dev,
> +				     const struct iio_chan_spec *chan,
> +				     enum iio_event_type type,
> +				     enum iio_event_direction dir,
> +				     bool state)
> +{
> +	u32 offset = SYSMON_ALARM_OFFSET(chan->address);
> +	u32 ier = sysmon_get_event_mask(chan->address);
> +	struct sysmon *sysmon = iio_priv(indio_dev);
> +	unsigned int alarm_config;
> +	int ret;
> +
> +	guard(mutex)(&sysmon->lock);
> +
> +	if (chan->type == IIO_VOLTAGE) {
> +		ret = sysmon_write_alarm_config(sysmon, chan->address, state);
> +		if (ret)
> +			return ret;
> +
> +		ret = regmap_read(sysmon->regmap, offset, &alarm_config);
> +		if (ret)
> +			return ret;
> +
> +		if (alarm_config)
> +			return regmap_write(sysmon->regmap, SYSMON_IER, ier);
> +
> +		return regmap_write(sysmon->regmap, SYSMON_IDR, ier);

> +	}
> +
> +	if (chan->type == IIO_TEMP) {

Still same problem you promised to address. Please, go back to the previous
thread and check again what has been addressed and what's not.

> +		if (state) {
> +			ret = regmap_write(sysmon->regmap, SYSMON_IER, ier);
> +			if (ret)
> +				return ret;
> +
> +			scoped_guard(spinlock_irq, &sysmon->irq_lock)
> +				sysmon->temp_mask &= ~ier;
> +		} else {
> +			ret = regmap_write(sysmon->regmap, SYSMON_IDR, ier);
> +			if (ret)
> +				return ret;
> +
> +			scoped_guard(spinlock_irq, &sysmon->irq_lock)
> +				sysmon->temp_mask |= ier;
> +		}
> +	}
> +
> +	return 0;
> +}

...

> +static int sysmon_update_temp_lower(struct sysmon *sysmon, int address)
> +{
> +	unsigned int upper_reg;
> +	int upper_mc, lower_mc, hysteresis;
> +	u32 raw_val;
> +	int upper_off, lower_off, ret;

Keep in reversed xmas tree order.

> +	upper_off = sysmon_temp_thresh_offset(address, IIO_EV_DIR_RISING);
> +	if (upper_off < 0)
> +		return upper_off;
> +	lower_off = sysmon_temp_thresh_offset(address, IIO_EV_DIR_FALLING);
> +	if (lower_off < 0)
> +		return lower_off;
> +
> +	if (address == SYSMON_ADDR_OT_EVENT)
> +		hysteresis = sysmon->ot_hysteresis;
> +	else
> +		hysteresis = sysmon->temp_hysteresis;
> +
> +	ret = regmap_read(sysmon->regmap, upper_off, &upper_reg);
> +	if (ret)
> +		return ret;
> +
> +	sysmon_q8p7_to_millicelsius(upper_reg, &upper_mc);
> +
> +	lower_mc = upper_mc - hysteresis;
> +	sysmon_millicelsius_to_q8p7(&raw_val, lower_mc);
> +
> +	return regmap_write(sysmon->regmap, lower_off, raw_val);
> +}

...

> +static int sysmon_read_event_value(struct iio_dev *indio_dev,
> +				   const struct iio_chan_spec *chan,
> +				   enum iio_event_type type,
> +				   enum iio_event_direction dir,
> +				   enum iio_event_info info,
> +				   int *val, int *val2)
> +{
> +	struct sysmon *sysmon = iio_priv(indio_dev);
> +	unsigned int reg_val;
> +	int offset;
> +	int ret;
> +
> +	guard(mutex)(&sysmon->lock);
> +
> +	if (chan->type == IIO_TEMP) {
> +		if (info == IIO_EV_INFO_VALUE) {
> +			/* Only rising threshold is exposed */
> +			offset = sysmon_temp_thresh_offset(chan->address,
> +							   IIO_EV_DIR_RISING);
> +			if (offset < 0)
> +				return offset;
> +
> +			ret = regmap_read(sysmon->regmap, offset, &reg_val);
> +			if (ret)
> +				return ret;
> +
> +			sysmon_q8p7_to_millicelsius(reg_val, val);
> +
> +			return IIO_VAL_INT;
> +		}
> +		if (info == IIO_EV_INFO_HYSTERESIS) {
> +			if (chan->address == SYSMON_ADDR_OT_EVENT)
> +				*val = sysmon->ot_hysteresis;
> +			else
> +				*val = sysmon->temp_hysteresis;
> +			return IIO_VAL_INT;
> +		}

> +	}
> +
> +	if (chan->type == IIO_VOLTAGE) {

Again, same issue. Are you sure you sent the new version?

> +		offset = sysmon_supply_thresh_offset(chan->address, dir);
> +		if (offset < 0)
> +			return offset;
> +
> +		ret = regmap_read(sysmon->regmap, offset, &reg_val);
> +		if (ret)
> +			return ret;
> +
> +		sysmon_supply_rawtoprocessed(reg_val, val);
> +
> +		return IIO_VAL_INT;
> +	}
> +
> +	return -EINVAL;
> +}

...

> +static int sysmon_write_event_value(struct iio_dev *indio_dev,
> +				    const struct iio_chan_spec *chan,
> +				    enum iio_event_type type,
> +				    enum iio_event_direction dir,
> +				    enum iio_event_info info,
> +				    int val, int val2)
> +{
> +	struct sysmon *sysmon = iio_priv(indio_dev);
> +	unsigned int reg_val;
> +	u32 raw_val;
> +	int offset;
> +	int ret;
> +
> +	guard(mutex)(&sysmon->lock);
> +
> +	if (chan->type == IIO_TEMP) {
> +		if (info == IIO_EV_INFO_VALUE) {
> +			/* Only rising threshold is exposed */
> +			offset = sysmon_temp_thresh_offset(chan->address,
> +							   IIO_EV_DIR_RISING);
> +			if (offset < 0)
> +				return offset;
> +
> +			sysmon_millicelsius_to_q8p7(&raw_val, val);
> +
> +			ret = regmap_write(sysmon->regmap, offset, raw_val);
> +			if (ret)
> +				return ret;
> +
> +			/* Recompute lower = upper - hysteresis */
> +			return sysmon_update_temp_lower(sysmon, chan->address);

> +		}
> +		if (info == IIO_EV_INFO_HYSTERESIS) {

Ditto.

> +			if (val < 0)
> +				return -EINVAL;
> +
> +			if (chan->address == SYSMON_ADDR_OT_EVENT)
> +				sysmon->ot_hysteresis = val;
> +			else
> +				sysmon->temp_hysteresis = val;
> +
> +			return sysmon_update_temp_lower(sysmon, chan->address);
> +		}

> +	}
> +
> +	if (chan->type == IIO_VOLTAGE) {

Ditto.

> +		offset = sysmon_supply_thresh_offset(chan->address, dir);
> +		if (offset < 0)
> +			return offset;
> +
> +		ret = regmap_read(sysmon->regmap, offset, &reg_val);
> +		if (ret)
> +			return ret;
> +
> +		sysmon_supply_processedtoraw(val, reg_val, &raw_val);
> +
> +		return regmap_write(sysmon->regmap, offset, raw_val);
> +	}
> +
> +	return -EINVAL;
> +}

...

> +/*
> + * Versal threshold interrupts are level-sensitive. Active threshold
> + * interrupts are masked in the handler and polled via delayed work
> + * until the condition clears, then unmasked.
> + */
> +static void sysmon_unmask_worker(struct work_struct *work)
> +{
> +	struct sysmon *sysmon =
> +		container_of(work, struct sysmon, sysmon_unmask_work.work);
> +	unsigned int isr;
> +
> +	/*
> +	 * regmap errors are not checked here because the worker and IRQ
> +	 * handler cannot propagate errors. The MMIO regmap uses fast_io
> +	 * with direct readl/writel which cannot fail.

OK (but they can fail on HW level to the point of bus errors or so :).

> +	 */
> +	spin_lock_irq(&sysmon->irq_lock);
> +	regmap_read(sysmon->regmap, SYSMON_ISR, &isr);
> +	regmap_write(sysmon->regmap, SYSMON_ISR, isr);
> +	sysmon_unmask_temp(sysmon, isr);
> +	spin_unlock_irq(&sysmon->irq_lock);
> +
> +	if (sysmon->masked_temp)
> +		schedule_delayed_work(&sysmon->sysmon_unmask_work,
> +				      msecs_to_jiffies(SYSMON_UNMASK_WORK_DELAY_MS));
> +	else
> +		regmap_write(sysmon->regmap, SYSMON_STATUS_RESET, 1);
> +}

...

> +static int sysmon_init_interrupt(struct sysmon *sysmon,
> +				 struct device *dev,
> +				 struct iio_dev *indio_dev,
> +				 int irq)
> +{
> +	unsigned int imr;
> +	int ret;
> +
> +	/* Events not supported without IRQ (e.g. I2C path) */
> +	if (!irq)
> +		return 0;
> +
> +	ret = devm_delayed_work_autocancel(dev, &sysmon->sysmon_unmask_work,
> +					   sysmon_unmask_worker);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(sysmon->regmap, SYSMON_IMR, &imr);
> +	if (ret)
> +		return ret;
> +	sysmon->temp_mask = imr & SYSMON_TEMP_INTR_MASK;
> +
> +	return devm_request_irq(dev, irq, sysmon_iio_irq, 0,
> +				"sysmon-irq", indio_dev);

I would do that on a single line, but it's 86 characters long, so up to
Jonathan.

> +}

...

> +static int sysmon_init_hysteresis(struct sysmon *sysmon, unsigned int address,
> +				  int *hysteresis)
> +{
> +	unsigned int upper_reg, lower_reg;
> +	int upper_mc, lower_mc;
> +	int upper_off, lower_off;

Reversed xmas tree order.

> +	int ret;
> +
> +	upper_off = sysmon_temp_thresh_offset(address, IIO_EV_DIR_RISING);
> +	if (upper_off < 0)
> +		return upper_off;
> +	lower_off = sysmon_temp_thresh_offset(address, IIO_EV_DIR_FALLING);
> +	if (lower_off < 0)
> +		return lower_off;
> +
> +	ret = regmap_read(sysmon->regmap, upper_off, &upper_reg);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(sysmon->regmap, lower_off, &lower_reg);
> +	if (ret)
> +		return ret;
> +
> +	sysmon_q8p7_to_millicelsius(upper_reg, &upper_mc);
> +	sysmon_q8p7_to_millicelsius(lower_reg, &lower_mc);
> +	*hysteresis = upper_mc - lower_mc;
> +
> +	return 0;
> +}

...

>  	sysmon_channels = devm_kcalloc(dev,
> -				       size_add(size_add(ARRAY_SIZE(temp_channels),
> +				       size_add(size_add(num_static,
>  						  num_supply), num_temp),
>  				       sizeof(*sysmon_channels), GFP_KERNEL);

Same comment as per previous patch.

>  	if (!sysmon_channels)
>  		return -ENOMEM;

...

> --- a/drivers/iio/adc/versal-sysmon.h
> +++ b/drivers/iio/adc/versal-sysmon.h

>  #include <linux/bits.h>
>  #include <linux/mutex.h>
> +#include <linux/spinlock_types.h>

> +#include <linux/types.h>

Same comment as per previous round. Really, please double check what you missed
to address.

> +#include <linux/workqueue.h>

-- 
With Best Regards,
Andy Shevchenko


