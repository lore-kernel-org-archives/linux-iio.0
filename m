Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAAE431A3E;
	Mon, 10 Aug 2026 16:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786381111; cv=none; b=lLOnXNgDneKImmqKHVqhYKfGPYADKDA6mVgdwmV75LY321YSloailV2iB8O8WLlqHJIMVa+RCIJqTOjDRfhd0DRAH5jpONcNGC60Fo0lWAJDahGimsW1WbCt6AENr+ftpreE7Q3NOhAtaf9fMO/H7Et+4PG5+EPqv7ZGUfVKOgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786381111; c=relaxed/simple;
	bh=EdmODO+K8FY1/Ukkl4ewZeDwc8sjwFVCQZUjor0bOQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W4gOfjCVhDH8uCDydAc2JBHSAhKFuvdAx+UIANhvXUJRfAbIG+Z+qAIJ+sZYKDbqQHibBJuLw178JdTWasGg9+pXvCD1QnfxGwdZZ7wDimTn3ojLyXKlUsqwynxSCwd78+wBrV0U1PQFVcDjpBmYqZazj8bXXOf/WK+HSzOTPxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FXZR3S4i; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FXZR3S4i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786381110; x=1817917110;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EdmODO+K8FY1/Ukkl4ewZeDwc8sjwFVCQZUjor0bOQU=;
  b=FXZR3S4i13xbqqiTyqrYOQ1+JZLkufTVVSch1lOl7NywOZUJ8xff8PXK
   w7l1cQYVo/dFX3rdCIpXJ0nONJ2RS8RfZlH9pThNXj9k34RbUy0Z0hYrm
   HAlTdNKVX0O1vs5aVKwfhu+El73Y6fB68AlM+fMiDncggFXyONway/HdC
   WeRBhbW97S1HsHr5aIGV/0DIHp0Viv7vj/NQ2XMM5VWnLeBMxiVtSjzNl
   +TapVqv8suucC7k297uLRvPqnSyPWvr51BUmAphHG89HbrTE/eTNvNLul
   KMw9E9a7R67Qpm3JVt5JtqpBs+3H+3jhdkb19JZcKt2n82L/CxXIcwSuF
   w==;
X-CSE-ConnectionGUID: 5Sq9GzGBRu2PUEeqjBpNIA==
X-CSE-MsgGUID: N7EEE/S3T1SYn34JAWtmJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="104294094"
X-IronPort-AV: E=Sophos;i="6.25,216,1779174000"; 
   d="scan'208";a="104294094"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 09:58:26 -0700
X-CSE-ConnectionGUID: V8VOidKtSz+yDdfOwNZuGw==
X-CSE-MsgGUID: 9+1VXaZXSC21N3EzgfuuGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,216,1779174000"; 
   d="scan'208";a="301324218"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.99])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 09:58:22 -0700
Date: Mon, 10 Aug 2026 19:58:19 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v4 2/3] iio: proximity: add driver for Sharp GP2AP070S
 proximity sensor
Message-ID: <anoDKzl84lO58GbQ@ashevche-desk.local>
References: <20260807-gp2ap070s-v4-0-74f6a67b6272@disroot.org>
 <20260807-gp2ap070s-v4-2-74f6a67b6272@disroot.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807-gp2ap070s-v4-2-74f6a67b6272@disroot.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Aug 07, 2026 at 01:18:42AM +0530, Kaustabh Chakraborty wrote:
> The GP2AP070S is a proximity sensor designed and manufactured by Sharp
> Corporation. This sensor is used in mobile devices, including, but not
> limited to - the Samsung Galaxy J6.
> 
> The driver has been adopted from Samsung's downstream kernel
> implementation [1]. Due to the lack of public documentation about the
> schematics of this device. The downstream driver acts as the secondary
> source of information. Driver clarity has also been improved with the
> help of the GP2AP* drivers in iio/light.

...

> +#include <linux/array_size.h>
> +#include <linux/bitfield.h>

+ bits.h // BIT() et alia

> +#include <linux/delay.h>

+ dev_printk.h
+ device/devres.h

> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>

+ sysfs.h // sysfs_emit()

> +#include <linux/types.h>
> +#include <linux/units.h>

+ asm/byteorder.h // le16_to_cpu()

> +#include <linux/iio/events.h>
> +#include <linux/iio/iio.h>

> +#include <linux/iio/types.h>

I believe there is an agreement that iio.h implies types.h in iio/.

...

> +#define GP2AP070S_REG_PS_THD_LO_LE16	0x88
> +#define GP2AP070S_REG_PS_THD_HI_LE16	0x8a
> +#define GP2AP070S_REG_D0_LE16		0x90

All those _LE16 do not add any value, we see that from the use of them.

> +#define GP2AP070S_REG_MAX		(GP2AP070S_REG_D0_LE16 + 1)

...

> +struct gp2ap070s_drvdata {
> +	struct regmap *regmap;
> +	struct mutex mutex;

Lock should have a comment explaining the data it protects.

> +	u32 near_level;
> +};

...

> +static const struct regmap_config gp2ap070s_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.volatile_reg = gp2ap070s_regmap_volatile,
> +	.max_register = GP2AP070S_REG_MAX,
> +	.cache_type = REGCACHE_FLAT,

Oh, registers are from 0x80 to 0x91, why FLAT and not MAPLE?

> +};

...

> +static int gp2ap070s_iio_read_raw(struct iio_dev *indio_dev,
> +				  struct iio_chan_spec const *chan, int *val,
> +				  int *val2, long mask)

Split logically here and everywhere else.

static int gp2ap070s_iio_read_raw(struct iio_dev *indio_dev,
				  struct iio_chan_spec const *chan,
				  int *val, int *val2, long mask)

...

> +static int gp2ap070s_iio_read_event_value(struct iio_dev *indio_dev,
> +					  const struct iio_chan_spec *chan,
> +					  enum iio_event_type type,
> +					  enum iio_event_direction dir,
> +					  enum iio_event_info info, int *val,
> +					  int *val2)

Ditto.

> +{
> +	struct gp2ap070s_drvdata *drvdata = iio_priv(indio_dev);
> +	__le16 value;
> +	int ret;
> +
> +	if (type != IIO_EV_TYPE_THRESH || info != IIO_EV_INFO_VALUE)
> +		return -EINVAL;
> +
> +	guard(mutex)(&drvdata->mutex);
> +
> +	switch (dir) {
> +	case IIO_EV_DIR_RISING:
> +		ret = regmap_bulk_read(drvdata->regmap,
> +				       GP2AP070S_REG_PS_THD_HI_LE16, &value,
> +				       sizeof(value));

Ditto.

(With above comment about LE16 this will become

		ret = regmap_bulk_read(drvdata->regmap, GP2AP070S_REG_PS_THD_HI,
				       &value, sizeof(value));

which is one line shorter.)

> +		if (ret)
> +			return ret;
> +
> +		*val = le16_to_cpu(value);
> +		return IIO_VAL_INT;
> +	case IIO_EV_DIR_FALLING:
> +		ret = regmap_bulk_read(drvdata->regmap,
> +				       GP2AP070S_REG_PS_THD_LO_LE16, &value,
> +				       sizeof(value));

Ditto.

> +		if (ret)
> +			return ret;
> +
> +		*val = le16_to_cpu(value);
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}

> +static int gp2ap070s_iio_write_event_value(struct iio_dev *indio_dev,
> +					   const struct iio_chan_spec *chan,
> +					   enum iio_event_type type,
> +					   enum iio_event_direction dir,
> +					   enum iio_event_info info, int val,
> +					   int val2)

Same as per above function.

...

> +		/* Ensure hi_threshold > lo_threshold */
> +		threshold_other = le16_to_cpu(value);
> +		if (threshold_other <= val)
> +			return -EINVAL;
> +
> +		value = cpu_to_le16(val);
> +		ret = regmap_bulk_write(drvdata->regmap,
> +					GP2AP070S_REG_PS_THD_LO_LE16, &value,
> +					sizeof(value));
> +		if (ret)
> +			return ret;
> +
> +		return 0;

		return regmap_bulk_write(...);

...

> +	ret = regmap_write_bits(drvdata->regmap, GP2AP070S_REG_PS2,
> +				GP2AP070S_PS2_IOUT | GP2AP070S_PS2_SUM32,
> +				FIELD_PREP_CONST(GP2AP070S_PS2_IOUT,
> +						 GP2AP070S_PS2_IOUT_89mA) |

> +				GP2AP070S_PS2_SUM32);

What's the point to have dup constant to be ORed?

> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to set current output\n");

...

> +	fsleep(10 * (MICRO / MILLI));

What's is this multiplier for? I think you wanted USEC_PER_MSEC from time.h.
Also add a comment with the reference to the datasheet (or other means) of why
this value has been chosen.

...

> +	if (device_property_present(dev, "proximity-near-level")) {
> +		ret = device_property_read_u32(dev, "proximity-near-level",
> +					       &drvdata->near_level);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Failed to get value for proximity-near-level\n");
> +	}

Any default to be applied?

-- 
With Best Regards,
Andy Shevchenko


