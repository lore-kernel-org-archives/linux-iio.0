Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1911830C177;
	Sat,  3 Oct 2026 19:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791054224; cv=none; b=cOdx0kGFXbope8dCSOpgushvs07PxIVpJTsUTWdanMxzn6OmcFjBvDgliya3ETDUtvesAUZnTafBt9C92isE4qw2Cvxtfwh9mA24ClKNgFunyXXnc6wbPWQRNSmaJis1w+TBRcf/bu4MXWbmoCjAOU5uNS7zcpeg1P7TuPyZxFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791054224; c=relaxed/simple;
	bh=ob0yorwkLKz8aKiSlx+uaiCrDE9CiqMaVN5DDAZ6MUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NllWL0Bmfxtyk8wmQ28jki2UHtJ7ok7y6ivv76Z25/AQeMcEeoSVwKu8TiBMPcej7drtAx6CvVSLLGADYGUsdFP7ehnuowIxqYrws9SzKQdC6wl5xS2CLAerXFCjxAJeNt9CuwkYh7p1YmSfXJKPH5CZegI/UVSjziulH3YcJrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ke3vjD7Q; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ke3vjD7Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791054222; x=1822590222;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ob0yorwkLKz8aKiSlx+uaiCrDE9CiqMaVN5DDAZ6MUo=;
  b=ke3vjD7Qi6cBuTRafYhNEcpV2AydROknOEnCe34QXfKjqwKljPWR1GLU
   tcLLSLjUUd/iyaSA38wMSy8dfcu7fv6El4Vq6rdIyN0zmPtuiSqFTbu64
   2eJgwK+6VY9B9n2gh3tklIumLEDr42sLblKByPYp9WFQ7b2SpD8rWz3gK
   SFqtJbHBOhCjxyis1WU5Bng2XPbEvD1P4dDWibzqM3oiaeBkKClFTvcor
   oaHa6o88YSoVo8CDvrm337N1H4TBf2cNvMv3M574mLDwKRy9W0CCezadf
   omXbbF8mgqEobrgMSlAIJiob3ByVyC6H7xKK+35dPoqfAUG2W17slKD/h
   w==;
X-CSE-ConnectionGUID: VWfvSY5KQVKbXLOix2teeA==
X-CSE-MsgGUID: jZHNir1kQ96L+J38wvZ7aw==
X-IronPort-AV: E=McAfee;i="6800,10657,11924"; a="90917684"
X-IronPort-AV: E=Sophos;i="6.27,138,1787036400"; 
   d="scan'208";a="90917684"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2026 12:03:41 -0700
X-CSE-ConnectionGUID: 9uhu5KoGRguT7ZxPOcfTpA==
X-CSE-MsgGUID: CkmXiU1iQkCHf3k899Fvhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,138,1787036400"; 
   d="scan'208";a="279771010"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.245.78])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2026 12:03:39 -0700
Date: Sat, 3 Oct 2026 22:03:36 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Liu Yufei <lyf98405@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: proximity: Add driver for Vishay VCNL36829
Message-ID: <asFRiC-RniYbQAKH@ashevche-desk.local>
References: <20261003050453.413700-1-lyf98405@gmail.com>
 <20261003050453.413700-3-lyf98405@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261003050453.413700-3-lyf98405@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Oct 03, 2026 at 01:04:53PM +0800, Liu Yufei wrote:

> Add an IIO driver for the Vishay VCNL36829 proximity sensor with
> integrated VCSEL, connected over I2C.
> 
> At probe the driver enables the vdd and vddio supplies, waits for the
> sensor to power up, checks the device ID, configures the VCSEL current
> and photodiodes, and turns the proximity engine on. The sensor is put
> back into shutdown when the device is removed.
> 
> The following attributes are exposed:
>   - in_proximity0_raw
>   - in_proximity_integration_time
>   - in_proximity_integration_time_available

> The datasheet is available at:
> https://www.vishay.com/docs/80580/vcnl36829um.pdf

Make it a Datasheet: tag.

> Assisted-by: Claude:claude-opus-5-5 checkpatch dtschema

Assisted-by: LLM

...

> +#include <linux/i2c.h>

> +#include <linux/mod_devicetable.h>

In the new code we rely on the bus header to provide the ID definitions.

> +#include <linux/iio/iio.h>
> +#include <linux/regmap.h>
> +#include <linux/bitfield.h>
> +#include <linux/module.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/delay.h>

Keep it sorted, also follow the IWYU principle.

...

> +struct vcnl36829_data {
> +	struct i2c_client *client;
> +	struct regmap *regmap;

One can be derived through the other, no need to keep client here.

> +};
> +
> +static const struct regmap_config vcnl36829_regmap_config = {
> +	.name = "vcnl36829_regmap",
> +	.reg_bits = 8,
> +	.val_bits = 16,
> +	.max_register = VCNL36829_DEV_ID,
> +	.val_format_endian = REGMAP_ENDIAN_LITTLE,

No cache?

> +};

...

> +static int vcnl36829_write_raw(struct iio_dev *indio_dev,
> +			       struct iio_chan_spec const *chan, int val,
> +			       int val2, long mask)
> +{
> +	struct vcnl36829_data *data = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_INT_TIME:
> +		if (val != 0)
> +			return -EINVAL;
> +		if (val2 >= 25 && val2 <= 375 && val2 % 25 == 0)
> +			return regmap_update_bits(data->regmap,
> +					VCNL36829_PS_CONF2,
> +					VCNL36829_PS_IT_MSK,
> +					FIELD_PREP(VCNL36829_PS_IT_MSK, val2 / 25));

Compiler might utilise some specific assembler instructions on some CPUs
to do % and / at once. To make it happen we can hint compiler with locating
these two operations next to each other. Also use standard pattern to check
for an error first and correct indentation.

		int ival = val2 / 25;
		int fval = val2 % 25;
		...
		if (val != 0)
			return -EINVAL;
		if (ival < 1 && ival > 15)
			return -EINVAL;
		if (fval != 0)
			return -EINVAL;

		return regmap_update_bits(data->regmap, VCNL36829_PS_CONF2,
					  VCNL36829_PS_IT_MSK,
					  FIELD_PREP(VCNL36829_PS_IT_MSK, ival));

> +		return -EINVAL;
> +	default:
> +		return -EINVAL;
> +	}
> +}

...

> +static int vcnl36829_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct vcnl36829_data *data;
> +	struct iio_dev *indio_dev;
> +	struct regmap *regmap;
> +
> +	int ret;
> +	unsigned int reg;

No blank lines in the definition block, also keep it in reversed xmas tree
order.

> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
> +		return dev_err_probe(dev, -EOPNOTSUPP,
> +				     "I2C adapter doesn't support plain I2C\n");
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	regmap = devm_regmap_init_i2c(client, &vcnl36829_regmap_config);
> +	if (IS_ERR(regmap))
> +		return dev_err_probe(dev, PTR_ERR(regmap),
> +				     "Regmap setup failed\n");
> +
> +	data = iio_priv(indio_dev);

> +	i2c_set_clientdata(client, indio_dev);

Is this being used?

> +	data->client = client;
> +	data->regmap = regmap;
> +
> +	indio_dev->name = "vcnl36829";
> +	indio_dev->info = &vcnl36829_info;
> +	indio_dev->channels = vcnl36829_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(vcnl36829_channels);
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	ret = devm_regulator_get_enable(dev, "vdd");
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to enable vdd\n");
> +
> +	ret = devm_regulator_get_enable(dev, "vddio");
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to enable vddio\n");

The following sleep needs a comment with a reference to the specific section
and/or table in the datasheet.

> +	fsleep(3000);

3 * USEC_PER_MSEC

(will require time.h to be included)


> +	ret = regmap_read(regmap, VCNL36829_DEV_ID, &reg);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to read device ID\n");
> +	if ((reg & 0xFF) != VCNL36829_DEV_ID_VAL)

> +		return dev_err_probe(dev, -ENODEV,
> +				     "Unknown device ID 0x%x\n", reg);

Don't we simply warn and continue in this case?

> +	ret = regmap_update_bits(regmap, VCNL36829_PS_CONF2,
> +				 VCNL36829_PS_IT_MSK,
> +				 FIELD_PREP(VCNL36829_PS_IT_MSK, VCNL36829_PS_INT_TIME_25));
> +	if (ret)

> +		return dev_err_probe(dev, ret,
> +				     "Could not configure PS_IT\n");

It's perfectly a single line.

> +
> +	ret = regmap_update_bits(regmap, VCNL36829_PS_CONF3,
> +				 VCNL36829_PS_CURRENT_EN_MSK |
> +				 VCNL36829_PS_CURRENT_MSK |
> +				 VCNL36829_PD1_EN_MSK |
> +				 VCNL36829_PD2_EN_MSK |
> +				 VCNL36829_PD3_EN_MSK,
> +				 FIELD_PREP(VCNL36829_PS_CURRENT_EN_MSK, 1) |
> +				 FIELD_PREP(VCNL36829_PS_CURRENT_MSK, VCNL36829_PS_CURRENT_18MA) |
> +				 FIELD_PREP(VCNL36829_PD1_EN_MSK, 1) |
> +				 FIELD_PREP(VCNL36829_PD2_EN_MSK, 1) |
> +				 FIELD_PREP(VCNL36829_PD3_EN_MSK, 1));
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Could not configure VCSEL/PD\n");
> +
> +	ret = regmap_write(regmap, VCNL36829_PS_CONF5, VCNL36829_PS_CONF5_INIT);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Could not set PS_CONF5\n");
> +
> +	ret = regmap_update_bits(regmap, VCNL36829_PS_CONF1,
> +				 VCNL36829_PS_ON_MSK | VCNL36829_PS_SD_MSK,
> +				 FIELD_PREP(VCNL36829_PS_ON_MSK, 1) |
> +				 FIELD_PREP(VCNL36829_PS_SD_MSK, 0));
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Could not set initial config\n");
> +
> +	ret = devm_add_action_or_reset(dev, vcnl36829_shutdown_action, data);
> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}

-- 
With Best Regards,
Andy Shevchenko


