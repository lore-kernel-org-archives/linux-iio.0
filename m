Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795702842;
	b=mwmSmA1xGC6kb7zPSngY9jEznkROafXip0F/yVy4rPzlQj1E1U52OKNUmD9JzI63hXto
	 VMV0CgVsnGMaXZln293c24THU21o6//qh4flOPXQBNIF28gP9J3EA9sVktdCoDe0fSo2Y
	 CYjWN/sNPvR8FQ1/3dNpI7ArLszx3v2tsYnJjsbwiTRybPMrhv/lASiVkI3/zkWn+Mwsx
	 rLBUtwrGWOtcJqZGMzAStOyARFGtPPMII28Lx2ppuw4OVrBRe7W6vJqzf+MurK3Fnsip/
	 1Fxbuxhm0GGl1ndjc8fEkTtq5IXnzO/afdQ3mERpSTPLuYOGL+VJ8kYTU1vsb63reog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795702842;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=hVqWDpkrRMuAndnDnhhjmf+Wfu5DBaUbLM5+gDgB7vI=;
	b=0HUhO3YrtbtH9stGYsyM1fmqIax72otTxgBmQydpA5dPSK82de4usqiT3Ro3xlC2xCTd
	 ZdinGGoWeFrAhrN0th66RVJ3P78zT6YVXWSvf9rG5xq6CHyUO0JiCGZCc/gzhstcxdSgI
	 CGfu21bIMhs7M0MGjwWZ/VI61O6z6xQn7US21N7jKwYjqUQtphiAM3VA84fzrQxTolUVV
	 euI8Sd2fdAmaP9dlXZ+PzmYVKSiQn/Ye2Dj5uHdLEqJtvMEV/gKGx54mrFOddNIvUYE4j
	 3Btg05KFDChb7hZkY9b6mwtWDbq9sjwp0D7dNDWuJICqXTYpDTOmFGEt20pzh9wDwyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MV0fU99o;
	arc=none smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58698606A31C;
	Thu, 26 Nov 2026 14:20:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58698606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MV0fU99o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795702842; x=1827238842;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4IfPtfotXa0k6AjefeK9B8zQzqGXUrlT/drqTYhZLPs=;
  b=MV0fU99oKBmUeBg3WXQ+C/ou6h0TPdmD35+qZazV38Y2orXyZb0NBm9Q
   ufavV8GAxKToJSFvbSEgs/QSH3PW3CqJpLT1aQ8G+/iK5NKSRIvObYDYS
   7WIvJ+eBsstUMBFgxEJiEK8gdSYwKQeQNqIew8zi7DH+QrkQ7qL3O8igy
   YjEx3ObvEBqxxfPodzG6BxsvVVjJU9f1cUdk0sg3aFUg/ToK+1+a39VtM
   Yts/0rnBFtwoSS78tNuOIzMy6D7n69rDsitFRMr1tSo/tPv4a/Oy+WgoM
   XWjX++hqa/gdgkSMsAtDbcijTeNyQlFpVXhkKmedp75laUU5p2CJmR05n
   w==;
X-CSE-ConnectionGUID: BjvUO6WUQhGfj3RlS+k3wQ==
X-CSE-MsgGUID: ih4bZ318RMGdwSagGtYi0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4504981"
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="4504981"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2026 06:20:41 -0800
X-CSE-ConnectionGUID: 4C1iud5/Qty4C9W9y03/+A==
X-CSE-MsgGUID: DBECi6YJS4+TKp7nh4agTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="12188387"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.208])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2026 06:20:37 -0800
Date: Thu, 26 Nov 2026 16:20:35 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: robertijtsma@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: light: add ams OSRAM TCS3430 XYZ and ambient
 light sensor driver
Message-ID: <awhAMzB83rSV9UUZ@ashevche-desk.local>
References: <20261126-iio-tcs3430-v2-0-6c5329d20919@gmail.com>
 <20261126-iio-tcs3430-v2-2-6c5329d20919@gmail.com>
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
In-Reply-To: <20261126-iio-tcs3430-v2-2-6c5329d20919@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 26, 2026 at 09:11:48AM +0100, Robert Ijtsma via B4 Relay wrote:

> Add an IIO driver for the ams OSRAM TCS3430 ambient light and CIE 1931
> XYZ tristimulus color sensor (found at I2C address 0x39 on devices such
> as the Microsoft Surface Pro X).
> 
> The driver exposes:
> - Illuminance (photopic Y channel) with raw counts and lux scale
> - Modified intensity channels for X, Y, Z, and IR1
> - Selectable scale and integration time via the IIO GTS helper across
>   1x/4x/16x/64x/128x gain and 50.04/100.08/200.16/400.32 ms integration
>   time settings
> - Regulator management and system sleep suspend/resume support
> 
> Tested on Microsoft Surface Pro X SQ2 (SC8180X).

...

> +config TCS3430
> +	tristate "ams OSRAM TCS3430 ambient light and XYZ color sensor"

Make this, top comment in the driver and MODULE_DESCRIPTION() text to be very
similar if not the same.

> +	depends on I2C
> +	select IIO_GTS_HELPER
> +	select REGMAP_I2C
> +	help
> +	  If you say yes here you get support for the ams OSRAM TCS3430
> +	  ambient light and CIE 1931 XYZ tristimulus color sensor.
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called tcs3430.

...

> +#include <linux/array_size.h>
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/cleanup.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/pm.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/types.h>

...

> +static const struct regmap_config tcs3430_regmap_config = {
> +	.name = "tcs3430",
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = TCS3430_REG_INTENAB,

No cache? Why?

> +};

...

With

	struct regmap *map = data->regmap;

at the top of the function helps with this...

> +	ret = regmap_write(data->regmap, TCS3430_REG_CFG3,
> +			   TCS3430_CFG3_DEFAULT);

...to become this.

	ret = regmap_write(map, TCS3430_REG_CFG3, TCS3430_CFG3_DEFAULT);

> +	if (ret)
> +		return ret;

You may use this trick elsewhere to achieve better readability.

...

> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW: {
> +		__le16 raw;
> +
> +		guard(mutex)(&data->lock);

+ Blank line to make guard()() visible at a glance. Ditto for all such cases.

> +		ret = regmap_bulk_read(data->regmap, chan->address, &raw,
> +				       sizeof(raw));
> +		if (ret)
> +			return ret;
> +		*val = le16_to_cpu(raw);
> +		return IIO_VAL_INT;
> +	}

...

> +static int tcs3430_set_scale(struct tcs3430_data *data, int val, int val2)
> +{
> +	int gain_sel, time_sel, ret;
> +	bool keep_time = false;
> +
> +	ret = iio_gts_find_gain_sel_for_scale_using_time(&data->gts, data->atime,
> +							 val, val2, &gain_sel);
> +	if (!ret) {

Why non-standard pattern?

> +		keep_time = true;
> +		time_sel = data->atime;
> +	} else {
> +		ret = iio_gts_find_gain_time_sel_for_scale(&data->gts, val, val2,
> +							   &gain_sel, &time_sel);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (!keep_time) {
> +		ret = tcs3430_apply_itime(data, time_sel);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return tcs3430_apply_gain(data, gain_sel);
> +}

...

> +static int tcs3430_set_itime(struct tcs3430_data *data, int val, int val2)
> +{
> +	struct device *dev = regmap_get_device(data->regmap);
> +	int prev_gain, prev_time, new_gain, gain_sel, time_sel, ret;
> +	bool in_range;

Better to rename to avoid confusion with generic in_range() helper.

> +
> +	if (val || !iio_gts_valid_time(&data->gts, val2))
> +		return -EINVAL;
> +
> +	prev_time = iio_gts_find_int_time_by_sel(&data->gts, data->atime);
> +	if (prev_time < 0)
> +		return prev_time;
> +	if (prev_time == val2)
> +		return 0;
> +
> +	prev_gain = iio_gts_find_gain_by_sel(&data->gts, data->gain_sel);
> +	if (prev_gain < 0)
> +		return prev_gain;
> +
> +	ret = iio_gts_find_new_gain_by_gain_time_min(&data->gts, prev_gain,
> +						     prev_time, val2,
> +						     &new_gain, &in_range);
> +	if (ret)
> +		return ret;
> +	if (!in_range)

> +		dev_dbg(dev, "optimal gain out of range for integration time %d\n",
> +			val2);

I would make it a single line despite the length.

> +
> +	time_sel = iio_gts_find_sel_by_int_time(&data->gts, val2);
> +	if (time_sel < 0)
> +		return time_sel;
> +
> +	gain_sel = iio_gts_find_sel_by_gain(&data->gts, new_gain);
> +	if (gain_sel < 0)
> +		return gain_sel;
> +
> +	ret = tcs3430_apply_itime(data, time_sel);
> +	if (ret)
> +		return ret;
> +
> +	return tcs3430_apply_gain(data, gain_sel);
> +}

...

> +static DEFINE_SIMPLE_DEV_PM_OPS(tcs3430_pm_ops, tcs3430_suspend,
> +				tcs3430_resume);

A single line

static DEFINE_SIMPLE_DEV_PM_OPS(tcs3430_pm_ops, tcs3430_suspend, tcs3430_resume);

or wrap on a logical borders

static DEFINE_SIMPLE_DEV_PM_OPS(tcs3430_pm_ops,
				tcs3430_suspend, tcs3430_resume);

But the above is only 81 character long.

-- 
With Best Regards,
Andy Shevchenko


