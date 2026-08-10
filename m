Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D3E3054EF;
	Mon, 10 Aug 2026 13:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786369142; cv=none; b=ml4VrupaGfq1oUNS20YhoCUcocFS0Mp6aHY7Gk6lHaAsjDqRFlIbSNg0FntnizXaMkE1P14XE4IGhdqeoIgegmWMCh1Fc6mhiyBCQJdOGE1P11OfFNiXYTKjuE5WQcEOGItCArveSCZENWMrt0DcJkIomupRKTbKIyZGqOpLkTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786369142; c=relaxed/simple;
	bh=zAqeN1ImvaX4cgQhkN1+Sk2fb046RBHpejjJq8SsIVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K4tsBcNEC65ALflsZDXClnl25gTdm6hTw4zkdiqsK2To0E93jE9dItoqJim7yShyGa/wtqM/YRJQcvAff6ONoj/qZD2Sr23BRdxwnvu6zbSBPaB3MOiMGW4HlKXKkrgxQs8EdAGDoa+nOd7gBuxgnWYmhTlD93rgkYTemlRNniY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XrFkr2f2; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XrFkr2f2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786369139; x=1817905139;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zAqeN1ImvaX4cgQhkN1+Sk2fb046RBHpejjJq8SsIVY=;
  b=XrFkr2f2qBtaxPPnjIti1ZD8WPu27QnrQ1UHh4iL5AA1/KcHT/h7fnrp
   Xh8P0WUE/zNkHj81f8lZlwk209RY7ILf4SJ8UV0nL9vyrKfYFkiW5YCLj
   Pza/GO6YSpbkV8WJjULBjcpGkiBTpHoFkGRyoxahbpqlLgPMeYV3/iyDO
   zeK9LUa60GnFikqAshTdjPJSteyKw5c5WDd0XVOkqjw1ozAgDJlUCsyIF
   Loa33h3ChgsJDMbg1vOH+eNhnDUH0xyUas21lMEtc77LcA3m8/ICrcCJi
   EyyRbgUjfnTqf8WSgQYluG5zQDPkxpdfI4T4R/Mis55PyPVPzS82pcfXo
   g==;
X-CSE-ConnectionGUID: 0k62RVMLQM+0zHKDQm+J/A==
X-CSE-MsgGUID: SQ4VMYlXShCoe11Og3GOlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11870"; a="85849827"
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="85849827"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 06:38:58 -0700
X-CSE-ConnectionGUID: 7a3SBoSKQJab3e9ogT/oUg==
X-CSE-MsgGUID: fIpcTHwVRDyoUd7KEQMFeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="301278589"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.99])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 06:38:56 -0700
Date: Mon, 10 Aug 2026 16:38:53 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/4] iio: light: add support for veml6031x00 ALS series
Message-ID: <annUbQQn2TzzuFNC@ashevche-desk.local>
References: <20260807-veml6031x00-v5-0-e60876fb3640@gmail.com>
 <20260807-veml6031x00-v5-2-e60876fb3640@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807-veml6031x00-v5-2-e60876fb3640@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Aug 07, 2026 at 03:51:53PM +0200, Javier Carrasco wrote:
> These sensors provide two light channels (ALS and IR), I2C communication
> and a multiplexed interrupt line to signal data ready and configurable
> threshold alarms.
> 
> This first implementation provides basic functionality (measurement
> configuration, raw reads and ID validation) and defines the different
> register regions in preparation for extended features in the subsequent
> patches of the series.

Since it's going to be a new version, my comments below.

...

+ array_size.h // ARRAY_SIZE()

> +#include <linux/bitfield.h>

Is this in use?

+ bits.h // BIT()

> +#include <linux/cleanup.h>
> +#include <linux/delay.h>

> +#include <linux/device.h>

Oh, the whole headers hell is loaded just due to dev_get_drvdata() it seems...

> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/limits.h>

I missed probably it, but is it used?

> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/mutex.h>

> +#include <linux/pm.h>

Not really required as pm_runtime.h takes care of.

> +#include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>

+ types.h // bool, __le16, et cetera.

+ asm/byteorder.h // le16_to_cpu() et alia.

...

> +static void veml6031x00_als_shutdown_action(void *data)
> +{
> +	struct veml6031x00_data *veml = data;
> +	int ret;
> +
> +	ret = veml6031x00_set_power_state(veml, false);
> +	if (ret)

> +		dev_err(regmap_get_device(veml->regmap),
> +			"Failed to shut down device: %d\n", ret);

It's only a warning, as there is neither error returning, nor a fallback.

> +}

...

> +static int veml6031x00_regfield_init(struct veml6031x00_data *data)
> +{

	struct device *dev = regmap_get_device(...);

> +	struct regmap_field *rm_field;
> +	struct veml6031x00_rf *rf = &data->rf;
> +
> +	rm_field = devm_regmap_field_alloc(regmap_get_device(data->regmap),
> +					   data->regmap, veml6031x00_rf_gain);

	rm_field = devm_regmap_field_alloc(dev, data->regmap, veml6031x00_rf_gain);

(yes, slightly longer than 80, but I think it's okay, even in the last case
 below).

> +	if (IS_ERR(rm_field))
> +		return PTR_ERR(rm_field);
> +	rf->gain = rm_field;
> +
> +	rm_field = devm_regmap_field_alloc(regmap_get_device(data->regmap),
> +					   data->regmap, veml6031x00_rf_it);
> +	if (IS_ERR(rm_field))
> +		return PTR_ERR(rm_field);
> +	rf->it = rm_field;
> +
> +	rm_field = devm_regmap_field_alloc(regmap_get_device(data->regmap),
> +					   data->regmap, veml6031x00_rf_pd_div4);
> +	if (IS_ERR(rm_field))
> +		return PTR_ERR(rm_field);
> +	rf->pd_div4 = rm_field;
> +
> +	return 0;
> +}

...

> +static int veml6031x00_get_it(struct veml6031x00_data *data, int *val2)
> +{
> +	scoped_guard(mutex, &data->scale_lock)

guard()() will suffice in this case. Yes, will need a blank line, but overall
it's a better choice I think.

> +		return __veml6031x00_get_it(data, val2);
> +}

...

> +static int veml6031x00_set_it(struct iio_dev *iio, int val, int val2)
> +{
> +	struct veml6031x00_data *data = iio_priv(iio);
> +	int ret, gain_sel, new_gain, prev_gain, prev_it;
> +	unsigned int gain_reg, it_idx, pd_div4;

> +	bool in_range;

Can we name it differently? When grepping over the whole tree this will give
a lot of the common in_range() calls...

> +
> +	if (val || !iio_gts_valid_time(&data->gts, val2))
> +		return -EINVAL;
> +
> +	guard(mutex)(&data->scale_lock);
> +
> +	ret = regmap_field_read(data->rf.it, &it_idx);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_field_read(data->rf.gain, &gain_reg);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_field_read(data->rf.pd_div4, &pd_div4);
> +	if (ret)
> +		return ret;
> +
> +	prev_it = iio_gts_find_int_time_by_sel(&data->gts, it_idx);
> +	if (prev_it < 0)
> +		return prev_it;
> +
> +	if (prev_it == val2)
> +		return 0;
> +
> +	prev_gain = iio_gts_find_gain_by_sel(&data->gts, (pd_div4 << 2) | gain_reg);
> +	if (prev_gain < 0)
> +		return prev_gain;
> +
> +	ret = iio_gts_find_new_gain_by_gain_time_min(&data->gts, prev_gain, prev_it,
> +						     val2, &new_gain, &in_range);
> +	if (ret)
> +		return ret;
> +
> +	if (!in_range)
> +		dev_dbg(regmap_get_device(data->regmap), "Optimal gain out of range\n");
> +
> +	ret = iio_gts_find_sel_by_int_time(&data->gts, val2);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = regmap_field_write(data->rf.it, ret);
> +	if (ret)
> +		return ret;
> +
> +	gain_sel = iio_gts_find_sel_by_gain(&data->gts, new_gain);
> +	if (gain_sel < 0)
> +		return gain_sel;
> +
> +	return veml6031x00_write_gain(data, gain_sel);
> +}

...

> +static int veml6031x00_get_scale(struct veml6031x00_data *data, int *val,
> +				 int *val2)
> +{
> +	int gain, it, gain_reg, pd_div4, it_reg, ret, sel;
> +
> +	scoped_guard(mutex, &data->scale_lock) {
> +		ret = regmap_field_read(data->rf.gain, &gain_reg);
> +		if (ret)
> +			return ret;
> +
> +		ret = regmap_field_read(data->rf.pd_div4, &pd_div4);
> +		if (ret)
> +			return ret;

> +		sel = (pd_div4 << 2) | gain_reg;

This magic happens a few times, perhaps some macros to define?

#define DIV4_GAIN_TO_SEL(div4, gain)
#define DIV4_FROM_SEL(sel)
#define GAIN_FROM_SEL(sel)

?

> +		gain = iio_gts_find_gain_by_sel(&data->gts, sel);
> +		if (gain < 0)
> +			return gain;
> +
> +		ret = regmap_field_read(data->rf.it, &it_reg);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	it = iio_gts_find_int_time_by_sel(&data->gts, it_reg);
> +	if (it < 0)
> +		return it;
> +
> +	ret = iio_gts_get_scale(&data->gts, gain, it, val, val2);
> +	if (ret)
> +		return ret;
> +
> +	return IIO_VAL_INT_PLUS_NANO;
> +}

> +	int addr, it_usec, ret;
> +	__le16 regval;
> +
> +	switch (type) {
> +	case IIO_LIGHT:
> +		addr = VEML6031X00_REG_ALS_L;
> +		break;
> +	case IIO_INTENSITY:
> +		addr = VEML6031X00_REG_IR_L;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	guard(mutex)(&data->scale_lock);
> +
> +	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(regmap_get_device(data->regmap), pm);
> +	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
> +	if (ret)
> +		return ret;
> +
> +	ret = __veml6031x00_get_it(data, &it_usec);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* integration time + 10% to ensure completion */
> +	fsleep(it_usec + (it_usec / 10));
> +
> +	ret = regmap_bulk_read(data->regmap, addr, &regval, sizeof(regval));
> +	if (ret)
> +		return ret;
> +
> +	*val = le16_to_cpu(regval);
> +
> +	return IIO_VAL_INT;
> +}

...

> +static int veml6031x00_read_raw(struct iio_dev *iio,
> +				struct iio_chan_spec const *chan, int *val,
> +				int *val2, long mask)

Split logically

static int veml6031x00_read_raw(struct iio_dev *iio,
				struct iio_chan_spec const *chan,
				int *val, int *val2, long mask)

...

> +static int veml6031x00_validate_part_id(struct veml6031x00_data *data)
> +{

	struct device *dev = ...;

> +	int part_id, ret;
> +	__le16 regval;
> +
> +	ret = regmap_bulk_read(data->regmap, VEML6031X00_REG_ID_L, &regval,
> +			       sizeof(regval));
> +	if (ret)
> +		return dev_err_probe(regmap_get_device(data->regmap), ret,
> +				     "Failed to read ID\n");
> +
> +	part_id = le16_to_cpu(regval);
> +	if (part_id != data->chip->part_id)
> +		dev_info(regmap_get_device(data->regmap), "Unknown ID %04x\n", part_id);
> +
> +	return 0;
> +}

...

> +static int veml6031x00_hw_init(struct iio_dev *iio)
> +{

As per above, and check the rest of the code for the same opportunity.

> +	struct veml6031x00_data *data = iio_priv(iio);
> +	int ret;
> +
> +	/* Max resolution = 6.9632 lx/cnt for gain = 0.125 and IT = 3.125ms */
> +	ret = devm_iio_init_iio_gts(regmap_get_device(data->regmap), 6, 963200000,
> +				    veml6031x00_gain_sel,
> +				    ARRAY_SIZE(veml6031x00_gain_sel),
> +				    veml6031x00_it_sel,
> +				    ARRAY_SIZE(veml6031x00_it_sel),
> +				    &data->gts);
> +	if (ret)
> +		return dev_err_probe(regmap_get_device(data->regmap), ret,
> +				     "failed to init IIO GTS\n");
> +
> +	return 0;
> +}

...

> +static int veml6031x00_probe(struct i2c_client *i2c)

Ditto.


-- 
With Best Regards,
Andy Shevchenko


