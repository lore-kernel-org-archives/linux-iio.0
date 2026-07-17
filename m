Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707122ECE93;
	Fri, 17 Jul 2026 08:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784277304; cv=none; b=Reoe2lBu3YVQHGnveKzR5PvAgEdnX6AFmJY939f9//dSWyw88GCzO8XZ9+ccBmGbs8GK8JBeiz9708E3W6DwHCmywnJpxr405XHS8bTYVGFX9vyhcgbJXCEiAROTZeUwPLeCW4rDKwvBR9MX5q32ThmjL3eXL0W6d9y7gW0yXaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784277304; c=relaxed/simple;
	bh=IkFJVO7mUypK8q7u3LdpcVVXXuRqY7GTWedgAL8Kptc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hC+blS5ycOFJ5L5uatxk99jAGMNsyF7yOVrCqxMGRM2OtenUinpAzFyVOnVtyCkXiiryZQ88rEU1SEnMhlRU7hIKO8zwttUFPL+Ui+pPqERGJXVHn0FnoxI7NwaKSVKyOOkHfyRCF5VNptEkLX1kzkHaYmJ1NzEebKAARRUPNXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JUnGNJjW; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JUnGNJjW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784277302; x=1815813302;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IkFJVO7mUypK8q7u3LdpcVVXXuRqY7GTWedgAL8Kptc=;
  b=JUnGNJjW8PEPetXlN0GYpNeUYNT/PmxRx1PUAmNPgj37HB9hLTCj6DAM
   2lAyp4ZVHiCoqYaKUUid9q0PFmsyd1yhhh6g666cwswzankHHNCM7dx0D
   EHrDHiHn8uqS+RsJx6aiclXEa5QBfFWET8+7WuANLDSxgX7LSC6yX/ncu
   4UXt76K4KSlWckzfID+H3+LIxG8R9wbIFhgSsAyf2m4wvA/noQ7WD1atm
   MdcmHcPSAy5LYCzLTml5UkJyw5YmWDjbM9E6JKMSOnwZXhQStr6qK0Fj4
   y2x/HtC3zLmAvvTmkTX4l42qAWXq0X0xhlWAt5VVeQ7v+HN4TM0k2kKpg
   A==;
X-CSE-ConnectionGUID: 9jn17Y4ISkCgdNZZa7XCnw==
X-CSE-MsgGUID: /ZY7sz8HRk2nyTJ7pGLm5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="102372069"
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="102372069"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 01:35:02 -0700
X-CSE-ConnectionGUID: 8XcibiwkSCSXzaTIHV0fjg==
X-CSE-MsgGUID: egDqgIkdROupWIS94OQv9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="258725561"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.143])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 01:34:58 -0700
Date: Fri, 17 Jul 2026 11:34:56 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Petar Stepanovic <pstepanovic@axiado.com>
Cc: Akhila Kavi <akavi@axiado.com>,
	Prasad Bolisetty <pbolisetty@axiado.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Harshit Shah <hshah@axiado.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] iio: adc: add Axiado SARADC driver
Message-ID: <alnpMFK6_ZkdWlLi@ashevche-desk.local>
References: <20260716-axiado-ax3000-ax3005-saradc-v4-0-810527a9d27f@axiado.com>
 <20260716-axiado-ax3000-ax3005-saradc-v4-2-810527a9d27f@axiado.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260716-axiado-ax3000-ax3005-saradc-v4-2-810527a9d27f@axiado.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jul 16, 2026 at 10:53:02PM -0700, Petar Stepanovic wrote:
> Add support for the SARADC controller found on Axiado AX3000 and
> AX3005 SoCs.
> 
> The driver supports single-shot voltage reads through the IIO
> subsystem. The number of available input channels is selected from
> the SoC match data, allowing AX3000 and AX3005 variants to use the
> same driver.

...

Please, follow IWYU principle.

> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/clk.h>
> +#include <linux/cleanup.h>
> +#include <linux/delay.h>

> +#include <linux/device.h>

You can omit this since you have platform_device.h.

> +#include <linux/err.h>
> +#include <linux/io.h>

+ math.h

> +#include <linux/mod_devicetable.h>

No to this header in a new code, Uwe did some rework recently.

> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>

+ types.h // uXX

> +#include <linux/units.h>

...

> +/* Register offsets */
> +#define AX_SARADC_GLOBAL_CTRL_REG 0x0004
> +#define AX_SARADC_MANUAL_CTRL_REG 0x0008
> +#define AX_SARADC_DOUT_REG 0x001C

Be consistent, use tabs to indent values of the offsets.

...

> +/* GLOBAL_CTRL register values */
> +#define AX_SARADC_GLOBAL_CTRL_SAMPLE_16	\
> +	FIELD_PREP(AX_SARADC_GLOBAL_CTRL_SAMPLE_MASK, 0)
> +
> +#define AX_SARADC_GLOBAL_CTRL_MODE_MANUAL	\
> +	FIELD_PREP(AX_SARADC_GLOBAL_CTRL_MODE_MASK, 1)

FIELD_PREP_CONST() in both cases.

...

> +#define AX_SARADC_MANUAL_CTRL_EN(ch)	\
> +	(AX_SARADC_MANUAL_CTRL_ENABLE |	\
> +	FIELD_PREP(AX_SARADC_MANUAL_CTRL_CH_SEL_MASK, ch))

Missing parentheses for ch. Also wrong indentation of the second line, missing
one space.

...

> +#define AX_RESOLUTION_BITS 10
> +#define AX_SARADC_CONV_CYCLES 13
> +#define AX_SARADC_CONV_DELAY_MARGIN_US 10

Again, be consistent, use tabs to indent values.

...

> +struct axiado_saradc {
> +	struct regmap *regmap;
> +	struct clk *clk;

Makes no sense to keep it here, your code takes the rate and uses that,
I do not see how clk is being used right now. Perhaps you have plans
for power management? But then add it when it's needed and being used.

> +	struct mutex lock; /* Serializes ADC conversions. */
> +	unsigned long clk_rate;
> +	int vref_uV;
> +};
> +
> +static const struct regmap_config axiado_saradc_regmap_config = {
> +	.reg_bits = 32,
> +	.val_bits = 32,
> +	.reg_stride = 4,
> +	.max_register = AX_SARADC_DOUT_REG,

No cache?

> +};
> +
> +

Single blank line is enough.

...

> +static int axiado_saradc_conversion(struct axiado_saradc *info,
> +				    struct iio_chan_spec const *chan, int *val)
> +{
> +	unsigned long usecs;
> +	unsigned int regval;
> +	int stop_ret;
> +	int ret;
> +
> +	guard(mutex)(&info->lock);
> +
> +	/* Select the channel to be used and trigger conversion */
> +	ret = regmap_write(info->regmap, AX_SARADC_MANUAL_CTRL_REG,
> +			   AX_SARADC_MANUAL_CTRL_EN(chan->channel));
> +	if (ret)
> +		return ret;
> +
> +

Ditto.

> +	/* Hardware requires 13 conversion cycles at clk_rate */
> +	usecs = DIV_ROUND_UP(AX_SARADC_CONV_CYCLES * USEC_PER_SEC,
> +			     info->clk_rate);
> +	fsleep(usecs + AX_SARADC_CONV_DELAY_MARGIN_US);

> +	ret = regmap_read(info->regmap, AX_SARADC_DOUT_REG, &regval);
> +
> +	/* Stop manual conversion */
> +	stop_ret = regmap_write(info->regmap, AX_SARADC_MANUAL_CTRL_REG, 0);
> +
> +	if (ret)
> +		return ret;
> +	if (stop_ret)
> +		return stop_ret;

Why do we care about stop error? Isn't it the best effort we can do?

> +	*val = regval & GENMASK(AX_RESOLUTION_BITS - 1, 0);

Is device responding always in native endianess?

> +	return 0;
> +}

...

> +static int axiado_saradc_read_raw(struct iio_dev *indio_dev,
> +				  struct iio_chan_spec const *chan, int *val,
> +				  int *val2, long mask)

Split logically:

static int axiado_saradc_read_raw(struct iio_dev *indio_dev,
				  struct iio_chan_spec const *chan,
				  int *val, int *val2, long mask)

...

> +static void axiado_saradc_disable(void *data)
> +{
> +	struct axiado_saradc *info = data;
> +
> +	regmap_write(info->regmap, AX_SARADC_GLOBAL_CTRL_REG,
> +		     AX_SARADC_GLOBAL_CTRL_PD);
> +}

Supply regmap instead of info and make this simpler

static void axiado_saradc_disable(void *map)
{
	regmap_write(map, AX_SARADC_GLOBAL_CTRL_REG, AX_SARADC_GLOBAL_CTRL_PD);
}

...

> +	regval = FIELD_PREP(AX_SARADC_GLOBAL_CTRL_CH_EN_MASK,
> +			    GENMASK(soc_data->num_channels - 1, 0)) |
> +		 AX_SARADC_GLOBAL_CTRL_SAMPLE_16 |
> +		 AX_SARADC_GLOBAL_CTRL_MODE_MANUAL |
> +		 AX_SARADC_GLOBAL_CTRL_ENABLE;

This is not used in the below call, move it closer to its user.

> +	ret = regmap_write(info->regmap, AX_SARADC_GLOBAL_CTRL_REG,
> +			   AX_SARADC_GLOBAL_CTRL_PD);

With

	struct regmap *map;

at the top, this and other will be shorter and easier to follow.
And I would dare to use a single line:

	ret = regmap_write(map, AX_SARADC_GLOBAL_CTRL_REG, AX_SARADC_GLOBAL_CTRL_PD);

> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(info->regmap, AX_SARADC_GLOBAL_CTRL_REG, regval);
> +	if (ret)
> +		return ret;

> +	ret = devm_add_action_or_reset(dev, axiado_saradc_disable, info);

	ret = devm_add_action_or_reset(dev, axiado_saradc_disable, map);

> +	if (ret)
> +		return ret;

-- 
With Best Regards,
Andy Shevchenko


