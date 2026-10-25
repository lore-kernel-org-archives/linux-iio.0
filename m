Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792960072;
	b=ivnhiiKNhcGbcOFzasYY0Z5Dde78nREDooIBD1sLrYPINdgKpy5tMukw7EDq+Rhen9/3
	 SUsg+BzcZ4ygPODu893q+PLOguCptmVLK5cH30jpmEiOCt5cwD2Rv4raRewE1sTZYgUpX
	 xjykq52j6kzFcKnqrQIvUgJqrcQwaUEPxR34zJ2UfeinAujGt9ylIs2gfJPEx57fIBKGv
	 JfcZKVbSg2DVbGVno4gexY/1T0O/NR5xpAPhfO5wG7oMlrqpscMxRYOyYroBi4FPuzhxG
	 30984B5pXHArMLx8n/Wz0nZtXbCFOyipLlVBo9iLqvz8XTrQDnZelULe2suk6iWiwvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792960072;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=DN6PbRBNxad9DcTg5iR4Oy8HtkEcukmwakAHDWPA8T8=;
	b=5qlCxQsuF3PavFR1RVH+nrZ5Pqggjna9Rv+8VeJZe3IqOyHH0TbcnAOzLv0jyhi2BucU
	 KK/I4Mz/YJU6MuxkRz4QiC5ZZt7v2Ko9RAtD8DIx9mP9Kirlyy2/HVip5lKhZAbEL523a
	 ZKsh5lX3/lXZogu+MsT76x66Qdy4Kcld7bUwnCRQ2WBn7/VFi6eOPqRuIiWZqjFY8N3mC
	 y4aEu9uD1l1dV37NWd/1Q+24YMjK5e0FFaYh5twCpp97uGS2F/XZ5NcMbDHi4tV6riKw6
	 PCrg7Xsr67UwEM2SunPSmyv3PdWdDl8pp0fclF8/lhOIp1AQcfJa9s6mRHB0gURddiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OM5UaaSY;
	arc=none smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF23606A31A;
	Sun, 25 Oct 2026 20:27:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6CF23606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OM5UaaSY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792960070; x=1824496070;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=awMLT1oMZkYBF++Hj/2vSzE6fORyJ8L6erONzisvwNc=;
  b=OM5UaaSYES0wncZbMTaES9hKvwboS2f+BWdqz6bsq2rH009VFGEljSv4
   ghis9abRHoET6yPdpyKSTd/82wpLbhDm+jjo8GDYvGCvAwcYTy9I8Hemf
   FLZBsRlrp3+qxT0R2oUaFNV0pETPk8U3WAQyx1Q3HuREVuH9Viksu2VQa
   PNk5kvod0tmGaOUActsxmtVN2ZnM5F8yAQbCDrq+wtrw5za9eznluDnmD
   MYElrIpFyhvBSrIuX5BZJT4l5NdEO41hSKpFhWMkp/oUDLIXelmhwA79q
   nXaRcCTYyeNCrO5mAsJxIFnW1xUQ4cD+yPke0hkm3BJc1hGBwQVX/01IT
   w==;
X-CSE-ConnectionGUID: TzDdQteMQpSIhZ0v0m1o4Q==
X-CSE-MsgGUID: 3IH0oqBxS4SLNQO9HxeF9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1638425"
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="1638425"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2026 13:27:50 -0700
X-CSE-ConnectionGUID: RSd2NqtWSee3gWRFAR2BbQ==
X-CSE-MsgGUID: NUsMokEVRFCm6DQZrick6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="4041488"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.10])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2026 13:27:47 -0700
Date: Sun, 25 Oct 2026 22:27:44 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Stephan Costa Barros <stephanbrrs8@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Krzysztof Kozlowski <krzk@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/6] iio: adc: ti-ads1298: prepare for more chip
 families
Message-ID: <at5mQNfPsoQFyraj@ashevche-desk.local>
References: <20261024231335.280955-1-stephanbrrs8@gmail.com>
 <20261024231335.280955-5-stephanbrrs8@gmail.com>
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
In-Reply-To: <20261024231335.280955-5-stephanbrrs8@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Oct 24, 2026 at 08:13:33PM -0300, Stephan Costa Barros wrote:
> The ADS1299 has the register map of the ADS129x, with other gains, data
> rates, reference and ID layout. To support it in this driver, collect
> what differs between families in a chip info structure, given as match
> data. The private structure has carried an unused chip_info pointer
> since the driver was added.
> 
> The chip info holds:
> - the regmap configuration and the PGA gain table;
> - the data rate rules: the base shift, whether CONFIG1 has an HR bit,
>   and the oversampling ratio at DR = 0;
> - the internal reference, whether CONFIG3 has the VREF_4V bit, and the
>   reserved bits of CONFIG3 that must be written as 1;
> - a callback that checks the ID register and sets the channel count and
>   the name, as the ID layouts differ; bit 3 alone tells them apart.

...

> +#define ADS1298_VREF_4V_MV			4000

_mV

...

> +/* What differs between the chip families the driver supports */
> +struct ads1298_chip_info {
> +	/* Checks the ID register, and sets the channel count and the name */
> +	int (*parse_id)(struct iio_dev *indio_dev, unsigned int id);
> +	const struct regmap_config *regmap_config;
> +	/* PGA gain for each value of the GAIN field of CHnSET */
> +	const u8 *gains;
> +	unsigned int num_gains;
> +	/*
> +	 * The data rate is f_CLK >> (dr_shift + DR). With an HR bit in
> +	 * CONFIG1, dr_shift is that of the high-resolution mode, and the
> +	 * low-power mode shifts one more.
> +	 */
> +	unsigned int dr_shift;
> +	bool has_hr;
> +	/* Oversampling ratio at DR = 0 */
> +	unsigned int osr_base;
> +	/* Internal reference, in millivolts */
> +	unsigned int vref_mv;

_mV

> +	/* CONFIG3 has the VREF_4V bit, which selects a 4 V internal reference */
> +	bool has_vref_4v;
> +	/* Reserved bits of CONFIG3 that must be written as 1 */
> +	unsigned int config3_reserved;
> +};

Run `pahole` and act accordingly.

...

>  		*val = ret / MILLI; /* Convert to millivolts */

At some point this should use (MICRO / MILLI) instead of MILLI.

...

>  		ret = regmap_read(priv->regmap, ADS1298_REG_CONFIG3, &regval);
>  		if (ret)
>  			return ret;
>  
>  		/* Reference in millivolts */
> -		*val = regval & ADS1298_MASK_CONFIG3_VREF_4V ? 4000 : 2400;
> +		*val = regval & ADS1298_MASK_CONFIG3_VREF_4V ?
> +		       ADS1298_VREF_4V_MV : info->vref_mv;

Can't we assign the default and always use info->vref_mV here?

...

> +	priv->chip_info = spi_get_device_match_data(spi);
> +	if (!priv->chip_info)
> +		return -ENODEV;

-ENODATA

...

> -	priv->regmap = devm_regmap_init(dev, NULL, priv, &ads1298_regmap_config);
> +	priv->regmap = devm_regmap_init(dev, NULL, priv,
> +					priv->chip_info->regmap_config);

Leave it a single line.

>  	if (IS_ERR(priv->regmap))

...

>  static const struct spi_device_id ads1298_id[] = {
> -	{ .name = "ads1298" },
> +	{ .name = "ads1298", .driver_data = (kernel_ulong_t)&ads1298_chip_info },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(spi, ads1298_id);
>  
>  static const struct of_device_id ads1298_of_table[] = {
> -	{ .compatible = "ti,ads1298" },
> +	{ .compatible = "ti,ads1298", .data = &ads1298_chip_info },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, ads1298_of_table);

I think this patch is overloaded. You need to split it to a series (to make
chip_info a separate preparatory change, for example).

-- 
With Best Regards,
Andy Shevchenko


