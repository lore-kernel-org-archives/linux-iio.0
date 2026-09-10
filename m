Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867653A9620;
	Thu, 10 Sep 2026 06:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789021006; cv=none; b=Z1qvphuSayEbNzJ7/N4JJQvsdy4VJ2e1T2hGwpdr23McKe30Mk4UZH0PGY1wn/Ur71ASKuv76j7FCAEo2LqAlUDD6KIOdaI6uskN34gtKj79wMgirOrAbq+Dp3njOW1CDQRQjGtSTpd8WW0Au+QSb8dGsvDoIH5N+HsyPX7GBK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789021006; c=relaxed/simple;
	bh=zT7qID2iUvPep5sG5ztpyVK3IWq3vpMN1lQ0gwC0RK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dYroLlvr/c6O/YY4UCh1B0NcQtThy3E4WVLvORMRq8djb/XIjSHWGn//w8OdcX7mgWr3seTxtkued61oPNPDxVZbY9bT3vEPHWuRfdhuYis9g4BlZgQ5Y69k4ljWQY4+aVbq3ItUOWf02V1N5/+NdoKnKK+cepaLvKo5Duf63zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kCCkdbHi; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kCCkdbHi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789020999; x=1820556999;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zT7qID2iUvPep5sG5ztpyVK3IWq3vpMN1lQ0gwC0RK4=;
  b=kCCkdbHit7ga1XJg6ZnoUMfxW4X/QHDCKahuv8n8gpUrnH/o7K5WkS7K
   LMaiKdg5b+BUM8lZid3SYyVzrqvJSWclY0dK4Lm7unQW1kVQhmD9aEkMI
   nsqqsJ0suUODoqL6y+aXHYCK8guSjZRnSKDHmDJJY30h+87SqGWctODEJ
   XLt0WxJX1RSZCqRFuAY0oWt/ssfScEemEu+zs7fi0AsS7hAvciC/ihWye
   s2r+ddTq7AUr7RbX9P+2xfSec8CNsgJE78sxYkUL7aubSJL8DevMyyeoM
   j0j5UGQ25EpzBxnZUH4pQHrMbPMgGQVORfeu+ByoQPnRp6PqJ9CAP+UCX
   w==;
X-CSE-ConnectionGUID: 0XSJyvWjTISkbceDawnqxg==
X-CSE-MsgGUID: uTlQl6p0RPSXJNfXW+8ecg==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="106831396"
X-IronPort-AV: E=Sophos;i="6.25,271,1779174000"; 
   d="scan'208";a="106831396"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 23:16:35 -0700
X-CSE-ConnectionGUID: m3BPGyf1SSC9cEObun3LLg==
X-CSE-MsgGUID: QpyLLo3HSkWpKv9nxGUMIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,271,1779174000"; 
   d="scan'208";a="309790789"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.177])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 23:16:33 -0700
Date: Thu, 10 Sep 2026 09:16:29 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ariana Lazar <ariana.lazar@microchip.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 08/10] iio: dac: mcp47feb02: refactor MCP47FEB02 I2C
 driver into two modules
Message-ID: <aqJLPT_pIH2pbZaB@ashevche-desk.local>
References: <20260909-mcp47feb02_refactor-v5-0-8b67bcab93d1@microchip.com>
 <20260909-mcp47feb02_refactor-v5-8-8b67bcab93d1@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909-mcp47feb02_refactor-v5-8-8b67bcab93d1@microchip.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Sep 09, 2026 at 05:18:51PM +0300, Ariana Lazar wrote:
> Prepare the driver for the bus-specific code by refactoring into separate
> files. The renamed file will contain the common DAC functionality shared by
> the MCP47FxBy1/2/4/8 I2C and MCP48FxBy1/2/4/8 SPI drivers. The MCP47FEB02
> driver was refactored into two modules: mcp47feb02-core.c and
> mcp47feb02-i2c.c in order to prepare the support for SPI MCP48FxBy1/2/4/8
> DAC family on top of the current implementation.

...

> +static int mcp47feb02_i2c_probe(struct i2c_client *client)
> +{
> +	const struct mcp47feb02_features *chip_features;
> +	struct device *dev = &client->dev;
> +	struct regmap *regmap;
> +
> +	chip_features = i2c_get_match_data(client);
> +	if (!chip_features)
> +		return dev_err_probe(dev, -ENODEV, "No I2C device found\n");

Consider adding a patch that replaces ENODEV with ENODATA as we started doing
in the other drivers. This will help to distinguish the source of the error.
Also fix the error message accordingly. It's not about device.

> +	if (chip_features->have_eeprom)
> +		regmap = devm_regmap_init_i2c(client, &mcp47feb02_regmap_config);
> +	else
> +		regmap = devm_regmap_init_i2c(client, &mcp47fvb02_regmap_config);
> +
> +	if (IS_ERR(regmap))
> +		return dev_err_probe(dev, PTR_ERR(regmap), "Error initializing I2C regmap\n");
> +
> +	return mcp47feb02_common_probe(chip_features, regmap);
> +}

...

> +#ifndef __DRIVERS_IIO_DAC_MCP47FEB02_H__
> +#define __DRIVERS_IIO_DAC_MCP47FEB02_H__
> +
> +#include <linux/pm.h>

+ regmap.h for struct regmap_config.

> +#include <linux/types.h>

> +#endif /* __DRIVERS_IIO_DAC_MCP47FEB02_H__ */

-- 
With Best Regards,
Andy Shevchenko


