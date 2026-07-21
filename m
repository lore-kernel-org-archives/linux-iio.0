Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D69C3B892B;
	Tue, 21 Jul 2026 20:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784666889; cv=none; b=At3X80wWjliksu0/P28XS6Rob9iRHwgHWTYNDRlysexI+4DBl0C/W0WXVubAbl5taYOsqrvY/91MgmE0RTUIxj3Qe7hzsmJTl7f8uczCcoWGfvk7GTP3Jp0aKuAnR2riI0tqcRAobTJw6FH/FaJqn52iLxfddZ1Zd6wOImGewCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784666889; c=relaxed/simple;
	bh=F44MWsyJNrtq5d1LRpRdtiPK0VARkH9Hdld3SG35hkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PtCwzvBmZb7aoQFr+1AnHVywQi21sHGda4tnC2uQXzzRdHAeQIx4NDtF9pQGv7nWkmc0zvVJuCtmkgwHy77RaXWkyGRKjpX0o5v0ibDSpIpHmrSSChuPnZipS+22WYdYTl2/k9wUtxmfbjPPDSbKGcjOnSVfH7PYjd9lUFsG2Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AgmfS5Uc; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AgmfS5Uc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784666885; x=1816202885;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=F44MWsyJNrtq5d1LRpRdtiPK0VARkH9Hdld3SG35hkA=;
  b=AgmfS5UcLOfR5+MKkDmBP2Wrx9tBuMHXE/gMZyaF+DXMxhAvtWVaYyL7
   zPxwUN+dIElFVa+dSzSqx5AWagIAbeNKdLIGna6/GD7lo9ho/1czIDSaE
   R7NlJlIYUxcyWsl7lBFWhsKSHPZpuF3GP4kQOGRTl7seBbZ6uJHTZXbtI
   w6ogLWD+i48XAsCXhR8K7BP8b6t3I/DlXHOVwz1lh5NPEzsk3qOukrkOq
   l2+Uuu3161CPXTAyHwtMH16DaBLt8Us8m07CnRnb4K+w6xeFdSf2m3XJZ
   CI6Se0i5NxTkWjX6cOXYYefAVCzF7X/+j6phV9wroQ+L2aH+7HL9955CW
   w==;
X-CSE-ConnectionGUID: y4jqncDPR7Kxqk4CPzie4w==
X-CSE-MsgGUID: I+O1/GYFQDObEYOC/7PTpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11853"; a="110831500"
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="110831500"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 13:48:03 -0700
X-CSE-ConnectionGUID: Jdzn6qTvTtmhxF01INy0lg==
X-CSE-MsgGUID: hw9Qu8yWTd2PyjhNxnlugw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="282390557"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.67])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 13:48:01 -0700
Date: Tue, 21 Jul 2026 23:47:58 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: dac: mcp47a1: add support for new device
Message-ID: <al_a_pbITuYMg0KH@ashevche-desk.local>
References: <20260721-mcp47a1-add-support-v1-0-da045a2567e3@gmail.com>
 <20260721-mcp47a1-add-support-v1-2-da045a2567e3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721-mcp47a1-add-support-v1-2-da045a2567e3@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jul 21, 2026 at 08:24:39PM +0200, Joshua Crofts wrote:
> The Microchip MCP47A1 is a 6-bit volatile Digital-to-Analog converted
> which communicates via I2C.

...

> +#include <linux/array_size.h>
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/types.h>
> +#include <linux/units.h>


> +struct mcp47a1_data {
> +	struct regmap *regmap;
> +	int vref_mv;

_mV

...

> +static const struct regmap_config mcp47a1_regmap_config = {
> +	.name = "mcp47a1",
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = MCP47A1_CMD_CODE,
> +};

No cache?

...

> +static int mcp47a1_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct mcp47a1_data *data;
> +	struct iio_dev *indio_dev;
> +	int reg_val;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);

> +	i2c_set_clientdata(client, indio_dev);

Is it used?

> +	data->regmap = devm_regmap_init_i2c(client, &mcp47a1_regmap_config);
> +	if (IS_ERR(data->regmap))
> +		return dev_err_probe(dev, PTR_ERR(data->regmap),
> +				     "Failed to initialize regmap\n");
> +
> +	ret = devm_regulator_get_enable(dev, "vdd");
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to enable regulator\n");
> +
> +	ret = devm_regulator_get_enable_read_voltage(dev, "vref");
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Failed to read vref\n");
> +
> +	data->vref_mv = ret / MILLI;

(MICRO / MILLI)

> +	/*
> +	 * This is a volatile DAC which doesn't have an ID register, instead
> +	 * the value register is set to 0x20 every Power-on-Reset (table 4-1).
> +	 * Any other read value at startup could indicate that the device is
> +	 * damaged etc.
> +	 */
> +	ret = regmap_read(data->regmap, MCP47A1_CMD_CODE, &reg_val);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to read register on startup\n");
> +
> +	if (reg_val != 0x20)
> +		dev_info(dev, "Read value 0x%02x at startup\n", reg_val);
> +
> +	indio_dev->name = "mcp47a1";
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &mcp47a1_info;
> +	indio_dev->channels = mcp47a1_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(mcp47a1_channels);
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}

-- 
With Best Regards,
Andy Shevchenko


