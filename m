Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D687838F656;
	Thu, 16 Apr 2026 08:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776327894; cv=none; b=GvjUj0dFijoSEb5y4aHO4JVFsss5Zkutbyd5TKpaIYsoJc0vs5hjVbBXOzqvQVmh/aRt3H7Gsbi5ea8gXSm342IAqxwYuc7ylfa7ylaP80hpLIj6aUaOiWDkxre9WRmkASjF1bRCfoQSJRyXXoCOCQnK5mWk5f66mTMzoaT4nc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776327894; c=relaxed/simple;
	bh=6bXNg/5xWgRX2wnL6QmRDi8D7RbugWSd2NYaZKpmIU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R0YxGLYYrRwTb1uk6CfL7oCKgG0wN8dgVVjOme/o/mFkzUEhhD2juMbtk8o6KXtREoz4vb3rgD1quW5mcAbumvW/CEHQOMh4MAKBNRfFdILWVHUtwMbruxU39Cb8pt1RugzN9pA+v0zSs5SViKU13MWxj9bVX4gAos7P9MPSlY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G5Z/KM9I; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G5Z/KM9I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776327893; x=1807863893;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6bXNg/5xWgRX2wnL6QmRDi8D7RbugWSd2NYaZKpmIU8=;
  b=G5Z/KM9I4xTv3yvIHrLby+rXofRD7eDGpySePTassRwGlKJfCneahcUR
   WIziXJ30wo1MMXMUpHieFQUdLpiZR57Pz3RnAYVr/hoeGHDN7zwQFZu8g
   YEoad6DS6s3IT62DWVMKEXqqHI1BwY7N+hE/kUje5Q0NeqKh1KpGED7DK
   CLgnDhrIcUj7EsNBSfXrAEAxrUsvpPY4lyXjr/arq0qeRzhxpw3tERfO0
   6U9LCtqesMd3nNOzgpv5AOgl2nS/UJFNtBvd9j809zvFjGpZHuUAl2Y1t
   YbOLMA+tl52XB4qOcnwAdoypQNgkX9RpF7N7Zd6KCeIy3XPVB/aReA/rh
   w==;
X-CSE-ConnectionGUID: uXlwADNnRtO7m0A2hrG+Qg==
X-CSE-MsgGUID: 3fOJJ3BVQDOQpHSSa53A1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11760"; a="77020811"
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="77020811"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 01:24:52 -0700
X-CSE-ConnectionGUID: ujsh724DT66yz+csU4otpQ==
X-CSE-MsgGUID: Emstls90SiGunK9F3CW2hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="230511774"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.173])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 01:24:50 -0700
Date: Thu, 16 Apr 2026 11:24:47 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: lucas.p.stankus@gmail.com, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: accel: adxl313: Use dev_err_probe
Message-ID: <aeCcz9GgFmig1d7U@ashevche-desk.local>
References: <20260416051631.551250-1-sanjayembedded@gmail.com>
 <20260416051631.551250-4-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416051631.551250-4-sanjayembedded@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Apr 16, 2026 at 10:46:31AM +0530, Sanjay Chitroda wrote:

> dev_err_probe() makes error code handling simpler and handle
> deferred probe nicely (avoid spamming logs).

...

>  	regmap = devm_regmap_init_i2c(client,
>  				      &adxl31x_i2c_regmap_config[chip_data->type]);
> -	if (IS_ERR(regmap)) {
> -		dev_err(&client->dev, "Error initializing i2c regmap: %ld\n",
> -			PTR_ERR(regmap));
> -		return PTR_ERR(regmap);
> -	}
> +	if (IS_ERR(regmap))
> +		return dev_err_probe(&client->dev, PTR_ERR(regmap),
> +				     "Error initializing i2c regmap\n");

Add

	struct device *dev = &client->dev;

to the top of the function and use it here as

	if (IS_ERR(regmap))
		return dev_err_probe(dev, PTR_ERR(regmap), "Error initializing i2c regmap\n");

Note, it's fine to have trailing string literals, even in strict mode
checkpatch won't complain.

...

> -	if (IS_ERR(regmap)) {
> -		dev_err(&spi->dev, "Error initializing spi regmap: %ld\n",
> -			PTR_ERR(regmap));
> -		return PTR_ERR(regmap);
> -	}
> +	if (IS_ERR(regmap))
> +		return dev_err_probe(&spi->dev, PTR_ERR(regmap),
> +				     "Error initializing spi regmap\n");

Same way as in I2C driver.

-- 
With Best Regards,
Andy Shevchenko


