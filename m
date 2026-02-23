Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967CA2405EB;
	Mon, 23 Feb 2026 13:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771854916; cv=none; b=UkN5UL2QiYcecrOlqHVf4RaayZmJDX9Jtq3AWBudyjLkppaCCuM2DeEAPspbWfiQyR7Z/ncZK+cVzwdS0uv4DpbvvOc+mvmJAVwFEZTCMSTIhwk++RaAYnw+w82g1ZnUYU6UC4tanpg5XCefj5m3FPsBeuCaejTtmqH4muhZ/Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771854916; c=relaxed/simple;
	bh=9BenQr1m5POVZo0WuX1l2AQrTXMWBoxCqU9oA1QCCms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JbfUtYS35Q+JWaoR7c4J+s/fRbaHiNGnuyrrhoYuyBlkSX2xHTkEVImMDu0XJMf8zVaU5opMqBcPhqa9LB9vcJ2Ya+RtHgy2gXzOQvtIrCHMuhATcmTveJPH0Mf3/RH07fU5xmR/XI98nH9VljWB8Bb68ltnTQuk/eXprVEjqpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m5+unQKp; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m5+unQKp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771854916; x=1803390916;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9BenQr1m5POVZo0WuX1l2AQrTXMWBoxCqU9oA1QCCms=;
  b=m5+unQKpU2nKB0r4n8ln12smHjVq8qYqz2TD5dEe6hUlISXPdiqmaLZS
   NOfkh6f1axYeagvDhBYVlNRL9IIjhncDMOcYWHpUO6YQvtSOUcmqq7MWW
   2J/pBEo6iQeiOb3xINmBugzOzaIVSGeI5xxfOyECSSSPCqz0r9lgq098c
   xd/CRENRck5SzkdccFA27ToU0SSVc5exA7doKl2ZIwVo7MX7g2XcqWy+7
   jSw/k4AitveHSHXy7jeIFht2KzlI2z1oXrROw9ll8Sazf6giTv0cRbXXd
   G24EEG43PC7XU8xNwIuS8z0Zg/2pmKKstq286p96wgm7Jr4tWXMiV/Mo2
   g==;
X-CSE-ConnectionGUID: KM/4abIUQpqWPI2TuoD+1Q==
X-CSE-MsgGUID: a1SMhCV/T8aQCEYQLivtgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11709"; a="72948596"
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="72948596"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 05:55:15 -0800
X-CSE-ConnectionGUID: SlWnDD42TuOJjelQ9Zfd8Q==
X-CSE-MsgGUID: BACJI0iqRs6zMSIojTH9+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="215712176"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.222])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 05:55:12 -0800
Date: Mon, 23 Feb 2026 15:55:10 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/12] iio: frequency: admv1014: introduce struct
 device variable
Message-ID: <aZxcPt5W3figzBel@smile.fi.intel.com>
References: <20260223131418.55414-1-antoniu.miclaus@analog.com>
 <20260223131418.55414-4-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223131418.55414-4-antoniu.miclaus@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Feb 23, 2026 at 03:13:54PM +0200, Antoniu Miclaus wrote:
> Add struct device *dev local variable to simplify repeated &spi->dev
> dereferences. Where spi is no longer needed beyond &spi->dev, replace
> struct spi_device *spi with struct device *dev = &st->spi->dev.
> 
> No functional change.

...

>  static int admv1014_init(struct admv1014_state *st)
>  {
>  	unsigned int chip_id, enable_reg, enable_reg_msk;
> -	struct spi_device *spi = st->spi;
> +	struct device *dev = &st->spi->dev;
>  	int ret;
>  
>  	ret = regulator_bulk_enable(ADMV1014_NUM_REGULATORS, st->regulators);
>  	if (ret) {
> -		dev_err(&spi->dev, "Failed to enable regulators");
> +		dev_err(dev, "Failed to enable regulators");
>  		return ret;

This should be translated to dev_err_probe(). Since devm_*() is used in this
function it's assumed it's only run from ->probe() stage, and hence error
messages may be converted to use dev_err_probe().

>  	}

...

>  	if (ret) {
> -		dev_err(&spi->dev, "ADMV1014 SPI software reset failed.\n");
> +		dev_err(dev, "ADMV1014 SPI software reset failed.\n");
>  		return ret;
>  	}

Ditto.

...

>  	if (ret) {
> -		dev_err(&spi->dev, "ADMV1014 SPI software reset disable failed.\n");
> +		dev_err(dev, "ADMV1014 SPI software reset disable failed.\n");
>  		return ret;
>  	}

>  	ret = __admv1014_spi_write(st, ADMV1014_REG_VVA_TEMP_COMP, 0x727C);
>  	if (ret) {
> -		dev_err(&spi->dev, "Writing default Temperature Compensation value failed.\n");
> +		dev_err(dev, "Writing default Temperature Compensation value failed.\n");
>  		return ret;
>  	}

Ditto.

...


>  	chip_id = FIELD_GET(ADMV1014_CHIP_ID_MSK, chip_id);
>  	if (chip_id != ADMV1014_CHIP_ID) {
> -		dev_err(&spi->dev, "Invalid Chip ID.\n");
> +		dev_err(dev, "Invalid Chip ID.\n");
>  		return -EINVAL;
>  	}

Ditto.

...

>  	if (ret) {
> -		dev_err(&spi->dev, "Writing Quad SE Mode failed.\n");
> +		dev_err(dev, "Writing Quad SE Mode failed.\n");
>  		return ret;
>  	}
>  
>  	ret = admv1014_update_quad_filters(st);
>  	if (ret) {
> -		dev_err(&spi->dev, "Update Quad Filters failed.\n");
> +		dev_err(dev, "Update Quad Filters failed.\n");
>  		return ret;
>  	}
>  
>  	ret = admv1014_update_vcm_settings(st);
>  	if (ret) {
> -		dev_err(&spi->dev, "Update VCM Settings failed.\n");
> +		dev_err(dev, "Update VCM Settings failed.\n");
>  		return ret;
>  	}

Ditto.

...

> static int admv1014_properties_parse(struct admv1014_state *st)

> -	ret = devm_regulator_bulk_get(&st->spi->dev, ADMV1014_NUM_REGULATORS,
> +	ret = devm_regulator_bulk_get(dev, ADMV1014_NUM_REGULATORS,
>  				      st->regulators);
>  	if (ret) {
> -		dev_err(&spi->dev, "Failed to request regulators");
> +		dev_err(dev, "Failed to request regulators");
>  		return ret;
>  	}

Same here.

-- 
With Best Regards,
Andy Shevchenko


