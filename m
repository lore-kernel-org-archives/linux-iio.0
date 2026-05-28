Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC7D37B007;
	Thu, 28 May 2026 13:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779973329; cv=none; b=VX2Sq082a5EvYdGsrSGLINJr9Tm92AW13RQebJUa6LBFZHZOH7fG8Wps8GFIJAXdhDi+Na9m+rCVHbYJyDD07wA/1wZrPnCY2Cn03vvyL9x+QUFtSTmi+/TbvtwnWpptjZKCCtX3WtLfbV+otZQkaCXEsRzqKKZ18UcDddFEDlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779973329; c=relaxed/simple;
	bh=+RH3A9wqjc/9H5xLRNcWcgS6ZkQf9QdB4m8rdA2EMos=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BTQM4E5Ruqz22K1MtC6gFxDAfi+Xri+frQIVtXD/BzfDWeY1Rrc2yh4u/OOVWyFUFJPLxCBjoyZhBkglRaVB5vrQvx3iktlUIFbfDbSYPYWQAnIh2kEWAYYFNFeJN80lgA49EFEhWbleabRkQ4FlBLtZME8aByXYvuXWT0wD9dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rm6wy+D/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rm6wy+D/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 364911F000E9;
	Thu, 28 May 2026 13:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779973327;
	bh=gOdAyu4BiynnFgp0hqE62o5px9tgrY0YIgkHhd5BYWw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Rm6wy+D/xQxlwVQ+odw5kdVEtu6wMTK63/O3MHee7e8btAyMM7f65ezkQwwOM4nH/
	 oNX4hLON+OBEJuzwuT7cmlNH60bvv02ZtE+BqAWrF56RJqnHWGawmcjGCpQgeCB3PJ
	 JxOKE66lt38vPWa+t9q3dramP/Rt1DIC0MBHqWo11AE9swDTvkVlOZI/SeThlZ6nGV
	 qleiugwjQ0tiU6sPggpcI0RuDNNSEP3w8jvGwlODlRXN6j3x0k6Am2CEcm2rAfh1qS
	 MQaSFNNFDRRZfU5Xbz3xAPnE17EqFtduVnFX6d0Hiil0wpLCcUoiVmxGNod2UrTABK
	 AoLMD/xSJW41w==
Date: Thu, 28 May 2026 14:01:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Salih Erim <salih.erim@amd.com>
Cc: Andy Shevchenko <andy@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Conall O'Griofa <conall.ogriofa@amd.com>,
 Michal Simek <michal.simek@amd.com>, Guenter Roeck <linux@roeck-us.net>,
 Salih Erim <erimsalih@gmail.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/5] iio: adc: versal-sysmon: add threshold event
 support
Message-ID: <20260528140156.5cab0eda@jic23-huawei>
In-Reply-To: <20260527114211.174288-5-salih.erim@amd.com>
References: <20260527114211.174288-1-salih.erim@amd.com>
	<20260527114211.174288-5-salih.erim@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 May 2026 12:42:10 +0100
Salih Erim <salih.erim@amd.com> wrote:

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
> 
> Signed-off-by: Salih Erim <salih.erim@amd.com>
Hi Salih

Main thing in here is related to earlier question on _PROCESSED + _RAW.
I can't see a reason to have _RAW.

Various minor things inline. In many case they apply in other places I haven't
called out so look for repeats

Jonathan

>  drivers/iio/adc/versal-sysmon-core.c | 655 ++++++++++++++++++++++++++-
>  drivers/iio/adc/versal-sysmon.h      |  48 +-
>  2 files changed, 697 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/adc/versal-sysmon-core.c b/drivers/iio/adc/versal-sysmon-core.c
> index ebe052f6982..04977c9c887 100644
> --- a/drivers/iio/adc/versal-sysmon-core.c
> +++ b/drivers/iio/adc/versal-sysmon-core.c
> @@ -11,6 +11,8 @@
>  #include <linux/bitops.h>
>  #include <linux/cleanup.h>
>  #include <linux/device.h>
> +#include <linux/devm-helpers.h>
> +#include <linux/interrupt.h>
>  #include <linux/module.h>
>  #include <linux/property.h>
>  #include <linux/regmap.h>
> @@ -18,10 +20,19 @@
>  #include <linux/sysfs.h>
>  #include <linux/units.h>
>  
> +#include <linux/iio/events.h>
>  #include <linux/iio/iio.h>
>  
>  #include "versal-sysmon.h"
>  
> +/* OT and TEMP hysteresis mode bits in SYSMON_TEMP_EV_CFG */
> +#define SYSMON_OT_HYST_MASK		BIT(0)
> +#define SYSMON_TEMP_HYST_MASK		BIT(1)
> +
> +/* Compute alarm register offset from a channel address */
> +#define SYSMON_ALARM_OFFSET(addr) \
> +	(SYSMON_ALARM_REG + ((addr) / SYSMON_ALARM_BITS_PER_REG) * SYSMON_REG_STRIDE)
> +
>  /*
>   * Both RAW and PROCESSED are exposed: RAW is needed for event thresholds
>   * (which operate in hardware register format), PROCESSED gives userspace
> @@ -44,6 +55,62 @@
>  	.datasheet_name = _name,				\
>  }
>  
> +#define SYSMON_CHAN_TEMP_EVENT(_chan, _address, _name, _events) {\
> +	.type = IIO_TEMP,					\
> +	.indexed = 1,						\

Why do you needs separate channel for events?  Can't we add the event
spec to existing channels? For the constant ones you may need to
have two arrays to pick between depending on whether the irq is available or not.


> +	.address = _address,					\
> +	.channel = _chan,					\
> +	.event_spec = _events,					\
> +	.num_event_specs = ARRAY_SIZE(_events),			\
> +	.scan_type = {						\
> +		.sign = 's',					\
> +		.realbits = 15,					\
> +		.storagebits = 16,				\
> +		.endianness = IIO_CPU,				\
> +	},							\
> +	.datasheet_name = _name,				\
> +}
> +
	*raw_data = (u16)tmp;
> +}

> +
> +/*
> + * Recompute the lower threshold register from upper threshold and
> + * cached hysteresis. Called when either upper threshold or hysteresis
> + * is written.
> + */
> +static int sysmon_update_temp_lower(struct sysmon *sysmon, int address)
> +{
> +	unsigned int upper_reg;
> +	int upper_mc, lower_mc, hysteresis;
> +	u32 raw_val;
> +	int upper_off, lower_off, ret;
> +
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
> +	sysmon_q8p7_to_millicelsius(upper_reg, &upper_mc);
> +
> +	lower_mc = upper_mc - hysteresis;
> +	sysmon_millicelsius_to_q8p7(&raw_val, lower_mc);

So all the manipulation is in the units of _PROCESSED. Hence
I'd drop _RAW.

> +
> +	return regmap_write(sysmon->regmap, lower_off, raw_val);
> +}
> +
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
I'd add a blank line here.
> +			ret = regmap_read(sysmon->regmap, offset, &reg_val);
> +			if (ret)
> +				return ret;
here
> +			sysmon_q8p7_to_millicelsius(reg_val, val);
and here

Generally keep block of call + error check for one thing separate from code
before and after.  Slightly nicer to read.

Lots of other places this applies but it's a very minor thing.

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
> +			sysmon_millicelsius_to_q8p7(&raw_val, val);
> +			ret = regmap_write(sysmon->regmap, offset, raw_val);
> +			if (ret)
> +				return ret;
> +			/* Recompute lower = upper - hysteresis */
> +			return sysmon_update_temp_lower(sysmon,
> +							chan->address);

Under 80 chars on one line.  Check for cases of this and feel free to go a bit
over if it helps readability.

> +			return sysmon_update_temp_lower(sysmon, chan->address);

> +		}
> +		if (info == IIO_EV_INFO_HYSTERESIS) {
> +			if (val < 0)
> +				return -EINVAL;
> +			if (chan->address == SYSMON_ADDR_OT_EVENT)
> +				sysmon->ot_hysteresis = val;
> +			else
> +				sysmon->temp_hysteresis = val;
> +			return sysmon_update_temp_lower(sysmon,
> +							chan->address);

As above.

> +		}
> +	}
> +
> +	if (chan->type == IIO_VOLTAGE) {
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

> +static int sysmon_handle_event(struct iio_dev *indio_dev, u32 event)
> +{
> +	u32 alarm_flag_offset = SYSMON_ALARM_FLAG + (event * SYSMON_REG_STRIDE);
> +	u32 alarm_reg_offset = SYSMON_ALARM_REG + (event * SYSMON_REG_STRIDE);
> +	struct sysmon *sysmon = iio_priv(indio_dev);
> +	unsigned long alarm_flag_reg;
> +	unsigned int reg_val;
> +	u32 address, bit;
> +	int ret;
> +
> +	switch (event) {
> +	case SYSMON_BIT_TEMP:
> +		sysmon_push_event(indio_dev, SYSMON_ADDR_TEMP_EVENT);
> +		ret = regmap_write(sysmon->regmap, SYSMON_IDR,
> +				   BIT(SYSMON_BIT_TEMP));
> +		if (ret)
> +			return ret;
> +		sysmon->masked_temp |= BIT(SYSMON_BIT_TEMP);
> +		break;
> +
> +	case SYSMON_BIT_OT:
> +		sysmon_push_event(indio_dev, SYSMON_ADDR_OT_EVENT);
> +		ret = regmap_write(sysmon->regmap, SYSMON_IDR,
> +				   BIT(SYSMON_BIT_OT));
> +		if (ret)
> +			return ret;
> +		sysmon->masked_temp |= BIT(SYSMON_BIT_OT);
> +		break;
> +
> +	case SYSMON_BIT_ALARM0:
> +	case SYSMON_BIT_ALARM1:
> +	case SYSMON_BIT_ALARM2:
> +	case SYSMON_BIT_ALARM3:
> +	case SYSMON_BIT_ALARM4:
> +		ret = regmap_read(sysmon->regmap, alarm_flag_offset, &reg_val);
> +		if (ret)
> +			return ret;
> +		alarm_flag_reg = reg_val;
> +
> +		for_each_set_bit(bit, &alarm_flag_reg,
> +				 SYSMON_ALARM_BITS_PER_REG) {
> +			address = bit + (SYSMON_ALARM_BITS_PER_REG * event);
> +			sysmon_push_event(indio_dev, address);
> +			ret = regmap_update_bits(sysmon->regmap,
> +						 alarm_reg_offset,
> +						 BIT(bit), 0);
> +			if (ret)
> +				return ret;
> +		}
> +		ret = regmap_write(sysmon->regmap, alarm_flag_offset,
> +				   alarm_flag_reg);
> +		if (ret)
> +			return ret;
> +		break;
		return regmap_write();
> +
> +	default:
> +		break;

Why is this not an error?

> +	}
> +
> +	return 0;
Might as well return early in the various paths.
> +}
...

> +static irqreturn_t sysmon_iio_irq(int irq, void *data)
> +{
> +	struct iio_dev *indio_dev = data;
> +	struct sysmon *sysmon;
> +	unsigned int isr, imr;
> +
> +	sysmon = iio_priv(indio_dev);
> +	spin_lock(&sysmon->irq_lock);

guard() here would eman you can just return if (!isr)

> +
> +	regmap_read(sysmon->regmap, SYSMON_ISR, &isr);
> +	regmap_read(sysmon->regmap, SYSMON_IMR, &imr);
> +
> +	isr &= ~imr;
> +	regmap_write(sysmon->regmap, SYSMON_ISR, isr);
> +
> +	if (isr) {
> +		sysmon_handle_events(indio_dev, isr);
> +		schedule_delayed_work(&sysmon->sysmon_unmask_work,
> +				      msecs_to_jiffies(SYSMON_UNMASK_WORK_DELAY_MS));
> +	}
> +
> +	spin_unlock(&sysmon->irq_lock);
> +
> +	return IRQ_RETVAL(isr);
> +}
