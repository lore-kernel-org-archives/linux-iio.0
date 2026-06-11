Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEFB36CE1C;
	Thu, 11 Jun 2026 07:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781164188; cv=none; b=f/4GxC+6cFmPi3Xt52JXyme/vVWlvlPfnZXz0SERaW4YZA+yvRrjuFNvdb2At48BDKk1o26R3PY/HghUp6dbtEI3kPmWLnyVitN7sx43zGIXhWheTwepaeIfCT/5vD1LK1eEhiyx+I3dhJEO6/ne3OPwQGjA/3V0JEFK3l3Sz4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781164188; c=relaxed/simple;
	bh=K5X9+pmxCxTI6gxbp/ASC2g7N87EzDwCesA1chssCo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f284ttRNmdYJ0qPB4rwblv2x5bKlVXF1nMThzPbh9yE8v+ASWk/Aj9334hZUiirB9iTfHc288vaWiWkpBRcUXc6J3n+KR4dZLht+ubpJq6G38pW1trHlBEqasY81eqaRAwQRYfOmfCnnEVHISW/A7iMX7EI1FKx5TZ0Ne6GsP98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NdyGeSYJ; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NdyGeSYJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781164187; x=1812700187;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=K5X9+pmxCxTI6gxbp/ASC2g7N87EzDwCesA1chssCo0=;
  b=NdyGeSYJyGyXhPLT1LWITls/Oigyj65SeJK1ELB6Z0WiiwT+IA3+qO58
   tUeaDoH4U/gGZbCyT55DAApJF0Wk7ysd2TOPoVKYdzdRXASEZkyuMuUQe
   WUukjXPyfxSURy8E1KxbFkCibNvDMB49vw8/41/rtc+keHE9KYfyBMcKW
   FwUbjFQ2xog4ij0Xn0Nfkk8zKdXW1+srG3KuPsKXRc11qQz7PDISYPCU1
   DvjI/jxkQtupKBTjQAAlfkrOR/lLR3Zm0oXY5nJAz6yUQLJLmHtAEvD3+
   0neDwNPqCBVl1o2ZltPX/FGM+I+pk4g5fKjlV8AGVjk3QdQcEAWRuH9yd
   A==;
X-CSE-ConnectionGUID: rHGBog9JT5W1kFBEHz+DXQ==
X-CSE-MsgGUID: TI8z2ZBdSfS8j8x7taGyrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="93078706"
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; 
   d="scan'208";a="93078706"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 00:49:47 -0700
X-CSE-ConnectionGUID: 9gmyUkDjQM6Ss/UD92v01g==
X-CSE-MsgGUID: 97pEHKhtS8OvqbJzmqJh+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; 
   d="scan'208";a="251503107"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.123])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 00:49:43 -0700
Date: Thu, 11 Jun 2026 10:49:41 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-iio@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com,
	dlechner@baylibre.com, jic23@kernel.org,
	jean-baptiste.maneyrol@tdk.com, linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org, heiko@sntech.de, conor+dt@kernel.org,
	krzk+dt@kernel.org, robh@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V11 4/9] iio: imu: inv_icm42607: Add I2C and SPI For
 icm42607
Message-ID: <aipolU1W3QNXdd5b@ashevche-desk.local>
References: <20260610175455.19006-1-macroalpha82@gmail.com>
 <20260610175455.19006-5-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610175455.19006-5-macroalpha82@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 10, 2026 at 12:54:48PM -0500, Chris Morgan wrote:

> Add I2C and SPI driver support for InvenSense ICM-42607 devices.
> Add necessary Kconfig and Makefile to allow building of (incomplete)
> driver.

...

>  drivers/iio/imu/Kconfig                       |   1 +
>  drivers/iio/imu/Makefile                      |   1 +
>  drivers/iio/imu/inv_icm42607/Kconfig          |  30 +++++
>  drivers/iio/imu/inv_icm42607/Makefile         |  10 ++

These should be part of the previous patch.

...

> +config INV_ICM42607
> +	tristate

To make it compilable w.o. SPI/I2C make this as

	tristate "Inven... Core driver" if COMPILE_TEST


> +	select IIO_BUFFER
> +	select IIO_INV_SENSORS_TIMESTAMP

...

> +obj-$(CONFIG_INV_ICM42607_I2C) += inv-icm42607-i2c.o
> +inv-icm42607-i2c-y += inv_icm42607_i2c.o
> +
> +obj-$(CONFIG_INV_ICM42607_SPI) += inv-icm42607-spi.o
> +inv-icm42607-spi-y += inv_icm42607_spi.o

Add each of them in a separate patch.

...

> +#include <linux/device.h>

Why?
And a lot of missing headers (bitfield.h, dev_printk.h, mod_devicetable.h, err.h)

> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>

...

> +static int inv_icm42607_probe(struct i2c_client *client)
> +{
> +	const struct inv_icm42607_hw *hw;
> +	struct regmap *regmap;
> +
> +	hw = i2c_get_match_data(client);
> +	if (!hw)
> +		return dev_err_probe(&client->dev, -ENODEV,
> +				     "Failed to get i2c data\n");

Add

	struct device *dev = &client->dev;

and modify this and other eligible pieces accordingly.

		return dev_err_probe(dev, -ENODEV, "Failed to get i2c data\n");

> +	regmap = devm_regmap_init_i2c(client, &inv_icm42607_regmap_config);
> +	if (IS_ERR(regmap))
> +		return dev_err_probe(&client->dev, PTR_ERR(regmap),
> +				     "Failed to register i2c regmap %ld\n",

Do not duplicate a printing of an error code.

> +				     PTR_ERR(regmap));

		return dev_err_probe(dev, PTR_ERR(regmap),
				     "Failed to register i2c regmap\n");

> +	return inv_icm42607_core_probe(regmap, hw, inv_icm42607_i2c_bus_setup);
> +}
> +

...

> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_spi.c

As per above.

-- 
With Best Regards,
Andy Shevchenko


