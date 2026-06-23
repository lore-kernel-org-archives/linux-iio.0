Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1BF35AC37;
	Tue, 23 Jun 2026 09:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782206631; cv=none; b=RwL4g9mXdjfNI5tzTOJmHxPKFz4jag3RucG43SNiaLGdYH8H1FLXmPY1dhuRoCb6QqiP+WML/+WuNj4Z6eiow6M7O4IALJllXiZSO+SjA705oVPrP5+ix5tdLchtcrqoRgclOf/E4mkMFWyv7ORGlMyQOjfqw7ZJW8O0DkzKBmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782206631; c=relaxed/simple;
	bh=b7SBBkP92LoyGbJLJKjRg0pPH7QL1Sqs0ECoJC5aqVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NeJXHWuEx8PAuZkU4j9ZuCFK+pMq7Rh81wTubzkdc1LwiCjo8xCMqHSsmWhvkxjPLd6PWNepadFPiSvA56ZinLQAknX82qy+C8fZfefWUiu6+Gew9UoDF9P7KCRYVnR5iBjRLo+KZkExegxzeilL7aGVunLD5bYLSaunclPioJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HyigetTA; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HyigetTA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782206630; x=1813742630;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=b7SBBkP92LoyGbJLJKjRg0pPH7QL1Sqs0ECoJC5aqVI=;
  b=HyigetTAhATejm0t6ofGWrrEqrv6t0qsdxfWvLxCZxPWjG2APhYeXway
   K9jqivUQu6SxGnT31p9/uo7vH3FGwqGBVK09mpGHPtZA+/jZi2p0cbWDZ
   NjNOMQ/bz25ivA9ICAErSV7EidG/RFTF2cLdQm3QzoYXwSjaIIGVMZah9
   NB4KszAyCjFtX4Y+ytwCNfj+En5iti7nUFNKvX06WfCVG9J43LENU0zy+
   zXimpTxlc4djgBuyUAs/mGusAUctkbCiqRM2YCUjGXdQLq3u8lnizwU9d
   3/jVKTRXyq9o2dpxXdWRO/qaQIfg+D8H2OFP0JY0HD8gKQEdpamlduBFP
   Q==;
X-CSE-ConnectionGUID: UplY0aglQuiyn1apwXJu+A==
X-CSE-MsgGUID: hBYzL4uTQjaSuNpBEy214w==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="108487708"
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="108487708"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 02:23:50 -0700
X-CSE-ConnectionGUID: K6aslf0ARWG1BThGLFGx/g==
X-CSE-MsgGUID: Rk95TOcdRIaQHTNg1aeXvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="254568117"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.7])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 02:23:45 -0700
Date: Tue, 23 Jun 2026 12:23:43 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jakub Szczudlo <jakubszczudlo40@gmail.com>
Cc: linux-iio@vger.kernel.org, andy@kernel.org, antoniu.miclaus@analog.com,
	conor+dt@kernel.org, devicetree@vger.kernel.org,
	dlechner@baylibre.com, duje@dujemihanovic.xyz, jic23@kernel.org,
	jishnu.prakash@oss.qualcomm.com, jorge.marques@analog.com,
	joshua.crofts1@gmail.com, krzk+dt@kernel.org, linusw@kernel.org,
	linux-kernel@vger.kernel.org, marcelo.schmitt@analog.com,
	mazziesaccount@gmail.com, mike.looijmans@topic.nl,
	nuno.sa@analog.com, robh@kernel.org, sakari.ailus@linux.intel.com,
	wens@kernel.org
Subject: Re: [PATCH v4 3/3] iio: adc: Add ti-ads1110 support to ti-ads1100
 driver
Message-ID: <ajpQn8EVOx3ssxG6@ashevche-desk.local>
References: <20260622221550.374235-1-jakubszczudlo40@gmail.com>
 <20260622221550.374235-4-jakubszczudlo40@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622221550.374235-4-jakubszczudlo40@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 23, 2026 at 12:15:50AM +0200, Jakub Szczudlo wrote:
> Add ADS1110 support that have faster datarate than ADS1100, it also uses
> internal voltage reference of 2.048V for measurement.

...

>  config TI_ADS1100
> -	tristate "Texas Instruments ADS1100 and ADS1000 ADC"
> +	tristate "Texas Instruments ADS1100 and similar single channel I2C ADC"
>  	depends on I2C
>  	help
> -	  If you say yes here you get support for Texas Instruments ADS1100 and
> -	  ADS1000 ADC chips.
> +	  If you say yes here you get support TI ADS1100 and similar single
> +	  channel I2C Analog to Digital Converters.

User won't know what similar are really supported. The rule of thumb is to add
the list of supported here as

	  - ADS1000 (...perhaps some very short spec info...)
	  - ADS1100 (...perhaps some very short spec info...)


>  	  This driver can also be built as a module. If so, the module will be
>  	  called ti-ads1100.

...

> +static int ads1100_get_vref_milivolts(struct ads1100_data *data)
> +{
> +	if (data->ads_config->has_internal_vref_only)
> +		return ADS1110_INTERNAL_REF_mV;
> +
> +	return regulator_get_voltage(data->reg_vdd) / MILLI;

For now we used "(MICRO / MILLI)" instead of "MILLI", to show the unit
conversion.

> +}

...

>  	if (ret < 0) {
>  		dev_err(&data->client->dev, "I2C read fail: %d\n", ret);
>  		return ret;

> +	} else if (ret < 2) {

Redundant 'else'.

> +		dev_err(&data->client->dev, "Short I2C read\n");
> +		return -EIO;
>  	}

...

> -	microvolts = regulator_get_voltage(data->reg_vdd);
> +	microvolts = ads1100_get_vref_milivolts(data) * (MICRO / MILLI);

See above, here you correctly used the existing pattern, the above is
inconsistent and needs to be addressed.

...

> +	model = i2c_get_match_data(client);
> +	if (!model)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Can't get device data from firmware\n");
> +
> +	data->ads_config = (struct ads1100_config *)model;

You can't drop const like this. If you need to apply modification,
use devm_kmemdup(). Otherwise it won't work correctly if you have two different
sensors of the same driver in the system.

-- 
With Best Regards,
Andy Shevchenko


