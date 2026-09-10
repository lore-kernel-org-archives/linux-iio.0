Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE96313540;
	Thu, 10 Sep 2026 06:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789021079; cv=none; b=QfO70FKGNrvz37ewRh6FKjdCn04jWxmv/7xUSVCp5gIZ9PpIyWGq8uQQ/+7Mlb4JXt2I6+NXoPNctW7xr4HQoLOWvNS789TO4ju5YD+93mQe0F0wUojSP2e9NW9qZY11OBUSMGC2hKNiVRO2SyaGiUKRL3Df6QXIix7NR0DqNwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789021079; c=relaxed/simple;
	bh=lX2H6tJzjDaEqrU3m0VAa0Q9dPhG+eO0bVV+azleiVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RWbfC0djJTG7KeqxY5BFsNqkWw1PS5hDXyxXszABjj6xC+unp75PZIy6RwqL1D/xD4GKXJEcvasNlEgbPLTyoHYzHsEmqcCQt+uiqUTPY+H5+BJHjrFk6b9IubMbKTR70TWTfKHuevkDpx7UDF6D4ph6T+73gMhIaIyhPVMogYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lxl/r3YK; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lxl/r3YK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789021075; x=1820557075;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lX2H6tJzjDaEqrU3m0VAa0Q9dPhG+eO0bVV+azleiVE=;
  b=lxl/r3YKYO3RinUSrcoqZcqpaNpAAD/QDYxZy+gJAm+H24zsjWEobY/6
   Zf3basgE8YUZcXLp3zky4nD7ZgcAR6Rh7yB3ShMaiBD88Ng0z2AnQOC4x
   0D0AhBVBypKmgnsh7U6Y7bTL4YpgbUxKe6cgIwmbnwWsskp/TgrH7ap6+
   gX2JKoqRwW358+/QV8aNHVE/78/6H2MVt9d7y9sRTVq5bNEHCB2AHaLQh
   VgQcFpYNNYDhu63YJNID3+7yAn4DeDM4YLMY7ftac8DG9Xf/MQfdXjROX
   WrI/2cFbuC+M23rIc3k/KHqDtCkF9/k9ez1S1F9ctaPOGoVB5pArvg8kT
   g==;
X-CSE-ConnectionGUID: CNN/rpthT8+yvthM7R5hUg==
X-CSE-MsgGUID: tlJV2wTMQgm5kwq6EK3LWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="88608868"
X-IronPort-AV: E=Sophos;i="6.25,271,1779174000"; 
   d="scan'208";a="88608868"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 23:17:43 -0700
X-CSE-ConnectionGUID: epmyjWNyRYSN9lZUigs0JQ==
X-CSE-MsgGUID: yLwiR/QkQIqi7FgNCAuYyQ==
X-ExtLoop1: 1
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.177])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 23:17:39 -0700
Date: Thu, 10 Sep 2026 09:17:36 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ariana Lazar <ariana.lazar@microchip.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 10/10] iio: dac: add support for Microchip MCP48FEB02
Message-ID: <aqJLgJqyvKmHXDLe@ashevche-desk.local>
References: <20260909-mcp47feb02_refactor-v5-0-8b67bcab93d1@microchip.com>
 <20260909-mcp47feb02_refactor-v5-10-8b67bcab93d1@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909-mcp47feb02_refactor-v5-10-8b67bcab93d1@microchip.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Sep 09, 2026 at 05:18:53PM +0300, Ariana Lazar wrote:
> This is the IIO driver for Microchip MCP48FxBy1/2/4/8 series of buffered
> voltage output Digital-to-Analog Converters with nonvolatile or volatile
> memory and an SPI Interface.
> 
> The families support up to 8 output channels.
> 
> The devices can be 8-bit, 10-bit and 12-bit.

...

> +static int mcp47feb02_spi_probe(struct spi_device *spi)
> +{
> +	const struct mcp47feb02_features *chip_features;
> +	struct device *dev = &spi->dev;
> +	struct regmap *regmap;
> +
> +	chip_features = spi_get_device_match_data(spi);
> +	if (!chip_features)
> +		return dev_err_probe(dev, -ENODEV, "No SPI device found\n");

-ENODATA and fix the message accordingly.

> +	if (chip_features->have_eeprom)
> +		regmap = devm_regmap_init_spi(spi, &mcp47feb02_regmap_config);
> +	else
> +		regmap = devm_regmap_init_spi(spi, &mcp47fvb02_regmap_config);
> +
> +	if (IS_ERR(regmap))
> +		return dev_err_probe(dev, PTR_ERR(regmap), "Error initializing SPI regmap\n");
> +
> +	return mcp47feb02_common_probe(chip_features, regmap);
> +}

-- 
With Best Regards,
Andy Shevchenko


