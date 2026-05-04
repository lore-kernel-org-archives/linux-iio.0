Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B455218EB1;
	Mon,  4 May 2026 10:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777891974; cv=none; b=IXHVqt9U3749uEkAjaB3kuufs3v2NwGqMK0laE5Y4dS2KyVjqw0DoVVXY7QaTEnxGR4IBuRVva4Ng3A9u2wnW9WTEHO+6z5umEflqJVIZnzym76pzwvqcvlgAK6sIW40HPt8OTyaPmYXmoZBWmBkXQo6LS2n8ucn7r9Qpd/hJOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777891974; c=relaxed/simple;
	bh=H83wWvb8r1OwPeK+HkT6KMMQu1YqDmM4kTsU7K/rqds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qS24wZYfbUB/s3W6iDc53PRW/XquqcO1LDCNo4eeZNWFdElEzhRPfLcd7Cc/11P2auJ4JvtSLSWBwKMNVNGmIj/P3RR7gGO1vvgmVVrVNhy+PBJwrL6u3Bp59GrTa3YLJwT14NgArx0R9vHm/VbG2n26pMUeYHse42wHnJXvbog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=boT3sbgv; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="boT3sbgv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777891973; x=1809427973;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=H83wWvb8r1OwPeK+HkT6KMMQu1YqDmM4kTsU7K/rqds=;
  b=boT3sbgvuZL7y4YuYw3K0hBUx2ObNjdFeFBR40gxs8rLm3PYQ5T2avmT
   jnDvKJFA8rD6ML8EzZNH5Xg3NKfGOIZ2VI3P4Mq5vewNKf4yaj9x6Tw3f
   E05NX/w/P8I1fZa/gvs8F0Od0qSedSZp2Mmc0Hlb/cDVdj+Zm0js3ojKO
   oilWPc+OeQiAPHZ68M9tVoZehbKxfYEzYlKWYdRaY4jnoZJ+egATr5FOD
   t7SyhiWekUJIXb7UYCxaLh2Rhkv8i8QFDKn7P76G6wNlKnJbReoaoXmfU
   gvMUe/KDf754eVA+w53jZpXhxI5zCO9Z7UxjkH3ZNV2xpFSM+qIPy2rFU
   g==;
X-CSE-ConnectionGUID: KN5eAlc7QBCpvN9gTjxaJQ==
X-CSE-MsgGUID: rA0lYldaRGuQQ5xmm53emw==
X-IronPort-AV: E=McAfee;i="6800,10657,11775"; a="77905728"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="77905728"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 03:52:52 -0700
X-CSE-ConnectionGUID: iYZJiUY5RZC30VOZn1fvDw==
X-CSE-MsgGUID: 65uP3/auRi6XCW9CrcdDrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="239790932"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.78])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 03:52:48 -0700
Date: Mon, 4 May 2026 13:52:46 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Salih Erim <salih.erim@amd.com>
Cc: jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, git@amd.com, nuno.sa@analog.com,
	andy@kernel.org, dlechner@baylibre.com, michal.simek@amd.com,
	conall.ogriofa@amd.com, erimsalih@gmail.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] iio: adc: versal-sysmon: add threshold event
 support
Message-ID: <afh6fgnRy1KQRkTl@ashevche-desk.local>
References: <20260502111951.538488-1-salih.erim@amd.com>
 <20260502111951.538488-5-salih.erim@amd.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260502111951.538488-5-salih.erim@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, May 02, 2026 at 12:19:50PM +0100, Salih Erim wrote:
> Add threshold event support for temperature and supply voltage
> channels.
> 
> Temperature events:
>   - Rising/falling threshold with configurable values
>   - Over-temperature (OT) alarm with separate thresholds
>   - Per-channel hysteresis configuration
> 
> Supply voltage events:
>   - Rising/falling threshold per supply channel
>   - Per-channel alarm enable via alarm configuration registers
> 
> The interrupt handler masks active threshold interrupts (which are
> level-sensitive) and schedules a delayed worker to poll for condition
> clear before unmasking. When no hardware IRQ is available (irq <= 0),
> event channels are not created and interrupt init is skipped, since
> the I2C regmap backend cannot be called from atomic context.
> 
> When disabling a supply channel alarm, the group interrupt remains
> active if any other channel in the same alarm group still has an
> alarm enabled.
> 
> Named constants replace magic numbers for hysteresis bit positions
> (SYSMON_OT_HYST_BIT, SYSMON_TEMP_HYST_BIT) and alarm register width
> (SYSMON_ALARM_BITS_PER_REG).
> 
> Hysteresis values are validated to single-bit range (0 or 1) before
> writing to the hardware register.

...

>  #include <linux/bitfield.h>
>  #include <linux/bits.h>
>  #include <linux/cleanup.h>

> +#include <linux/iio/events.h>
>  #include <linux/iio/iio.h>

It's better from the start make it as a separate group of headers...

> +#include <linux/interrupt.h>
> +#include <linux/limits.h>
>  #include <linux/module.h>
>  #include <linux/property.h>
>  #include <linux/regmap.h>
>  

...like here (after blank line!)

...those linux/iio/*...
+blank line.

>  #include "versal-sysmon.h"

Also follow IWYU.

...

>  static void sysmon_q8p7_to_millicelsius(int raw_data, int *val)
>  {
>  	*val = ((s16)raw_data * SYSMON_MILLI) >> SYSMON_FRACTIONAL_SHIFT;
>  }
>  
> +static void sysmon_millicelsius_to_q8p7(u32 *raw_data, int val)
> +{
> +	*raw_data = (u16)((val * (int)BIT(SYSMON_FRACTIONAL_SHIFT)) / SYSMON_MILLI);
> +}

Too many explicit castings... Think how to reduce amount of them. Also this
SYSMON_MILLI shouldn't be defined.

Besides that it's inconsistent to use right-shift in one case and BIT() in
the other.

...

> +static void sysmon_supply_processedtoraw(int val, u32 reg_val, u32 *raw_data)
> +{
> +	int exponent = FIELD_GET(SYSMON_MODE_MASK, reg_val);
> +	int format = FIELD_GET(SYSMON_FMT_MASK, reg_val);
> +	int scale, tmp;
> +
> +	scale = BIT(SYSMON_SUPPLY_MANTISSA_BITS - exponent);
> +	tmp = (val * scale) / SYSMON_MILLI;
> +
> +	if (format)
> +		tmp = clamp(tmp, (int)S16_MIN, (int)S16_MAX);
> +	else
> +		tmp = clamp(tmp, 0, (int)U16_MAX);

No, the use of clamp() assumes it should not have explicit casts.

> +	*raw_data = tmp & U16_MAX;

Why?! The previous clamp() guarantees that, no?

> +}

...

> +static int sysmon_read_alarm_config(struct sysmon *sysmon,
> +				    unsigned long address)
> +{
> +	u32 shift = address % SYSMON_ALARM_BITS_PER_REG;
> +	u32 offset = SYSMON_ALARM_OFFSET(address);
> +	unsigned int reg_val;
> +	int ret;
> +
> +	ret = regmap_read(sysmon->regmap, offset, &reg_val);
> +	if (ret)
> +		return ret;
> +
> +	return reg_val & BIT(shift);

This won't work in case shift becomes 31. Because the returned value will be
considered by the callers as negative error code.

> +}

...

> +static int sysmon_write_alarm_config(struct sysmon *sysmon,
> +				     unsigned long address, u32 val)
> +{
> +	u32 shift = address % SYSMON_ALARM_BITS_PER_REG;
> +	u32 offset = SYSMON_ALARM_OFFSET(address);
> +
> +	return regmap_update_bits(sysmon->regmap, offset,
> +				  BIT(shift), val << shift);

Looks like regmap_set_bits().

> +}

...

> +static int sysmon_read_event_config(struct iio_dev *indio_dev,
> +				    const struct iio_chan_spec *chan,
> +				    enum iio_event_type type,
> +				    enum iio_event_direction dir)
> +{
> +	u32 alarm_event_mask = sysmon_get_event_mask(chan->address);
> +	struct sysmon *sysmon = iio_priv(indio_dev);
> +	unsigned int imr;
> +	int config_value;
> +	int ret;
> +
> +	ret = regmap_read(sysmon->regmap, SYSMON_IMR, &imr);
> +	if (ret)
> +		return ret;

+ blank line and a comment why imr is negated.

> +	imr = ~imr;
> +
> +	if (chan->type == IIO_VOLTAGE) {
> +		config_value = sysmon_read_alarm_config(sysmon, chan->address);
> +		if (config_value < 0)
> +			return config_value;
> +		return config_value && (imr & alarm_event_mask);
> +	}
> +
> +	return !!(imr & alarm_event_mask);
> +}

...

> +static int sysmon_write_event_config(struct iio_dev *indio_dev,
> +				     const struct iio_chan_spec *chan,
> +				     enum iio_event_type type,
> +				     enum iio_event_direction dir, bool state)
> +{
> +	u32 offset = SYSMON_ALARM_OFFSET(chan->address);
> +	u32 ier = sysmon_get_event_mask(chan->address);
> +	struct sysmon *sysmon = iio_priv(indio_dev);
> +	unsigned int alarm_config;
> +	int ret;
> +
> +	guard(mutex)(&sysmon->lock);

> +	guard(spinlock_irqsave)(&sysmon->irq_lock);

This is wrong (imagine I²C driver calling this...).

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
> +		else
> +			return regmap_write(sysmon->regmap, SYSMON_IDR, ier);
> +	} else if (chan->type == IIO_TEMP) {
> +		if (state) {
> +			ret = regmap_write(sysmon->regmap, SYSMON_IER, ier);
> +			if (ret)
> +				return ret;
> +			sysmon->temp_mask &= ~ier;
> +		} else {
> +			ret = regmap_write(sysmon->regmap, SYSMON_IDR, ier);
> +			if (ret)
> +				return ret;
> +			sysmon->temp_mask |= ier;
> +		}
> +	}
> +
> +	return 0;
> +}

...

> +static int sysmon_read_event_value(struct iio_dev *indio_dev,
> +				   const struct iio_chan_spec *chan,
> +				   enum iio_event_type type,
> +				   enum iio_event_direction dir,
> +				   enum iio_event_info info, int *val,
> +				   int *val2)

Logical split, please (move int val to the next line, or int val2 to the
previous).

> +{
> +	struct sysmon *sysmon = iio_priv(indio_dev);
> +	unsigned int reg_val;
> +	u32 mask, shift;
> +	int offset;
> +	int ret;
> +
> +	guard(mutex)(&sysmon->lock);
> +
> +	if (chan->type == IIO_TEMP) {
> +		if (info == IIO_EV_INFO_VALUE) {
> +			offset = sysmon_temp_thresh_offset(chan->address, dir);
> +			if (offset < 0)
> +				return offset;
> +			ret = regmap_read(sysmon->regmap, offset, &reg_val);
> +			if (ret)
> +				return ret;
> +			sysmon_q8p7_to_millicelsius(reg_val, val);
> +			return IIO_VAL_INT;
> +		}
> +		if (info == IIO_EV_INFO_HYSTERESIS) {
> +			mask = (chan->address == SYSMON_ADDR_OT_EVENT) ?
> +				SYSMON_OT_HYST_BIT : SYSMON_TEMP_HYST_BIT;

No need to calculate mask if regmap_read() fails.

> +			shift = (chan->address == SYSMON_ADDR_OT_EVENT) ? 0 : 1;

Ditto.

> +			ret = regmap_read(sysmon->regmap, SYSMON_TEMP_EV_CFG,
> +					  &reg_val);
> +			if (ret)
> +				return ret;
> +			*val = (reg_val & mask) >> shift;
> +			return IIO_VAL_INT;
> +		}

> +	} else if (chan->type == IIO_VOLTAGE) {

Redundant 'else'.

> +		offset = sysmon_supply_thresh_offset(chan->address, dir);
> +		if (offset < 0)
> +			return offset;
> +		ret = regmap_read(sysmon->regmap, offset, &reg_val);
> +		if (ret)
> +			return ret;
> +		sysmon_supply_rawtoprocessed(reg_val, val);
> +		return IIO_VAL_INT;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int sysmon_write_event_value(struct iio_dev *indio_dev,
> +				    const struct iio_chan_spec *chan,
> +				    enum iio_event_type type,
> +				    enum iio_event_direction dir,
> +				    enum iio_event_info info, int val, int val2)
> +{
> +	struct sysmon *sysmon = iio_priv(indio_dev);
> +	unsigned int reg_val;
> +	u32 mask, shift;
> +	u32 raw_val;
> +	int offset;
> +	int ret;
> +
> +	guard(mutex)(&sysmon->lock);
> +
> +	if (chan->type == IIO_TEMP) {
> +		if (info == IIO_EV_INFO_VALUE) {
> +			offset = sysmon_temp_thresh_offset(chan->address, dir);
> +			if (offset < 0)
> +				return offset;
> +			sysmon_millicelsius_to_q8p7(&raw_val, val);
> +			return regmap_write(sysmon->regmap, offset, raw_val);
> +		}
> +		if (info == IIO_EV_INFO_HYSTERESIS) {
> +			mask = (chan->address == SYSMON_ADDR_OT_EVENT) ?
> +				SYSMON_OT_HYST_BIT : SYSMON_TEMP_HYST_BIT;
> +			shift = (chan->address == SYSMON_ADDR_OT_EVENT) ? 0 : 1;

Similar comments as per above.

> +			if (val & ~1)

BIT(0), but still magic.

> +				return -EINVAL;
> +			return regmap_update_bits(sysmon->regmap,
> +						  SYSMON_TEMP_EV_CFG,
> +						  mask, val << shift);

Also seems like a regmap_set_bits(). and instead of that ugly ternary just make
it if-else or similar.

> +		}
> +	} else if (chan->type == IIO_VOLTAGE) {

Redundant 'else'.

> +		offset = sysmon_supply_thresh_offset(chan->address, dir);
> +		if (offset < 0)
> +			return offset;
> +		ret = regmap_read(sysmon->regmap, offset, &reg_val);
> +		if (ret)
> +			return ret;
> +		sysmon_supply_processedtoraw(val, reg_val, &raw_val);
> +		return regmap_write(sysmon->regmap, offset, raw_val);
> +	}
> +
> +	return -EINVAL;
> +}

...

> +static void sysmon_push_event(struct iio_dev *indio_dev, u32 address)
> +{
> +	const struct iio_chan_spec *chan;

> +	unsigned int i;

Seems not used outside of the loop, hence...

> +	for (i = 0; i < indio_dev->num_channels; i++) {

	for (unsigned int i = 0; i < indio_dev->num_channels; i++) {

> +		if (indio_dev->channels[i].address != address)
> +			continue;
> +
> +		chan = &indio_dev->channels[i];
> +		iio_push_event(indio_dev,
> +			       IIO_UNMOD_EVENT_CODE(chan->type,
> +						    chan->channel,
> +						    IIO_EV_TYPE_THRESH,
> +						    IIO_EV_DIR_EITHER),
> +			       iio_get_time_ns(indio_dev));
> +	}
> +}

...

> +static void sysmon_handle_event(struct iio_dev *indio_dev, u32 event)
> +{

Why no checks for error from IO accessors in this function?

> +	u32 alarm_flag_offset = SYSMON_ALARM_FLAG + (event * SYSMON_REG_STRIDE);
> +	u32 alarm_reg_offset = SYSMON_ALARM_REG + (event * SYSMON_REG_STRIDE);
> +	struct sysmon *sysmon = iio_priv(indio_dev);
> +	unsigned long alarm_flag_reg;
> +	unsigned int reg_val;
> +	u32 address, bit;
> +
> +	switch (event) {
> +	case SYSMON_BIT_TEMP:
> +		sysmon_push_event(indio_dev, SYSMON_ADDR_TEMP_EVENT);
> +		regmap_write(sysmon->regmap, SYSMON_IDR, BIT(SYSMON_BIT_TEMP));
> +		sysmon->masked_temp |= BIT(SYSMON_BIT_TEMP);
> +		break;
> +
> +	case SYSMON_BIT_OT:
> +		sysmon_push_event(indio_dev, SYSMON_ADDR_OT_EVENT);
> +		regmap_write(sysmon->regmap, SYSMON_IDR, BIT(SYSMON_BIT_OT));
> +		sysmon->masked_temp |= BIT(SYSMON_BIT_OT);
> +		break;
> +
> +	case SYSMON_BIT_ALARM0:
> +	case SYSMON_BIT_ALARM1:
> +	case SYSMON_BIT_ALARM2:
> +	case SYSMON_BIT_ALARM3:
> +	case SYSMON_BIT_ALARM4:
> +		regmap_read(sysmon->regmap, alarm_flag_offset, &reg_val);
> +		alarm_flag_reg = (unsigned long)reg_val;
> +
> +		for_each_set_bit(bit, &alarm_flag_reg,
> +				 SYSMON_ALARM_BITS_PER_REG) {
> +			address = bit + (SYSMON_ALARM_BITS_PER_REG * event);
> +			sysmon_push_event(indio_dev, address);
> +			regmap_update_bits(sysmon->regmap, alarm_reg_offset,
> +					   BIT(bit), 0);
> +		}
> +		regmap_write(sysmon->regmap, alarm_flag_offset, alarm_flag_reg);
> +		break;
> +
> +	default:
> +		break;
> +	}
> +}

...

> +	return isr ? IRQ_HANDLED : IRQ_NONE;

There is a macro for this. IIRC IRQ_RETVAL().

...

> +static int sysmon_init_interrupt(struct sysmon *sysmon)
> +{
> +	unsigned int imr;
> +	int ret;
> +
> +	/* Events not supported without IRQ (e.g. I2C path) */
> +	if (sysmon->irq <= 0)

When can '=' happen?

> +		return 0;
> +
> +	INIT_DELAYED_WORK(&sysmon->sysmon_unmask_work, sysmon_unmask_worker);
> +
> +	ret = regmap_read(sysmon->regmap, SYSMON_IMR, &imr);
> +	if (ret)
> +		return ret;
> +	sysmon->temp_mask = imr & SYSMON_TEMP_INTR_MASK;
> +
> +	ret = devm_add_action_or_reset(sysmon->dev, sysmon_cancel_work,
> +				       sysmon);
> +	if (ret)
> +		return ret;

Don't we have include/linux/devm-helpers.h?

> +	return devm_request_irq(sysmon->dev, sysmon->irq,
> +				sysmon_iio_irq, 0, "sysmon-irq",
> +				sysmon->indio_dev);
> +}

-- 
With Best Regards,
Andy Shevchenko


