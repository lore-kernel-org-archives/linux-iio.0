Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227A73D1AAC;
	Tue, 23 Jun 2026 09:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782206208; cv=none; b=Vx7jzpY5zV9TSwF3ATRPHUpY6oXkMCtHC0ztizXSePTTCFx0WJ+GwSYZxADMV5DSzw6enQjbiA3/GRcwzrvgcYU47VyL/aDPdRy7EQuk5IvocaLBm/k43W9FVNM03AbBp+x1ONZVwLYPBSED/WyacdDyzPlDI+O8MtsjubJe7iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782206208; c=relaxed/simple;
	bh=t2gFaC9cISyx2X0DVaDYFWgNpEQC/93Dagkq4FmN8D8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=piJQ6rJ/XezHMxnQQNUyhu5c3J9OQb1lHUd0d968xrpo+ezN4jg13PHXzTq69v/Tq1Js9q2zxUbsO47xB99kRNn0B4qQJnNWjgO3wC86yiZ9z3CC2Qt9K+1HXRbn8xT32udLJw1VkUErX76E7DHgjcB6Mf0yKTvrkPgGlfI4TbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ToUhdJgf; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ToUhdJgf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782206207; x=1813742207;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=t2gFaC9cISyx2X0DVaDYFWgNpEQC/93Dagkq4FmN8D8=;
  b=ToUhdJgfPymAx8rp67SR2ne8eeCDUmGNXiNSejdKDA8nqknoNa0v88OJ
   aXZUonbkKtLASXD2g9RzeKexDQ3gI7BLUxFiBrOwyo/dNOBmVQ1SYcLUm
   Vwu0AD9ljuOS+j+d3ncXhDQR6QO52QHf0OkuC44fVxLYUAq94PhGx6brF
   Z+MmYvpdmS2P67/UHLyYZ6w5cf0dHu1GlsHF7c1469ni92+alJF6RC+T1
   y6O2F0HNlU1soYnFxZyFneomuodDZEU4NWROfftmuXxHU8Xsa+2VvBCKB
   2Zax3xW59uaIGtvuvVoqZTMb3fbySIJfCgVCtn/r/MmUsi/6R8saZ1O9s
   w==;
X-CSE-ConnectionGUID: pdai4xSXRhGrUSGh7ppEGg==
X-CSE-MsgGUID: ie4bTatDQ6qtl10gSnI/uA==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="83036147"
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="83036147"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 02:16:46 -0700
X-CSE-ConnectionGUID: wfUzUzrgT5+Jg0uOTRfX0g==
X-CSE-MsgGUID: pPtQ3sgxRq+utBGomAS/kA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="245328583"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.7])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 02:16:42 -0700
Date: Tue, 23 Jun 2026 12:16:39 +0300
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
Subject: Re: [PATCH v4 1/3] iio: adc: Fix incorrect reading when datarate
 changed in single mode
Message-ID: <ajpO9zaZbIl3x1uC@ashevche-desk.local>
References: <20260622221550.374235-1-jakubszczudlo40@gmail.com>
 <20260622221550.374235-2-jakubszczudlo40@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622221550.374235-2-jakubszczudlo40@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 23, 2026 at 12:15:48AM +0200, Jakub Szczudlo wrote:
> When device is suspended and it is in single mode then changing
> datarate doesn't make it actual wait for new measurement, so to
> be sure that read after change is correct functions that changes
> datarate and gain will wait for new data.

...

> +/* Timeout based on the minimum sample rate of 8 SPS (7.5s) */
> +#define ADS1100_MAX_DRDY_TIMEOUT_US	7500000

Not sure if the multiplier will look good here

#define ADS1100_MAX_DRDY_TIMEOUT_US	(7500 * USEC_PER_MSEC)

(comment might need an update to use 7500 ms, but see above).

...

> +static bool ads1100_new_data_not_ready(struct ads1100_data *data)
> +{
> +	int ret;
> +	u8 buffer[3];
> +
> +	ret = i2c_master_recv(data->client, (char *)&buffer, sizeof(buffer));
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "I2C read fail: %d\n", ret);
> +		return true;
> +	} else if (ret < 3) {

sizeof()

> +		dev_err(&data->client->dev, "Short I2C read\n");
> +		return true;
> +	}
> +
> +	return FIELD_GET(ADS1100_CFG_ST_BSY, buffer[2]);
> +}

...

> +static int ads1100_poll_data_ready(struct ads1100_data *data)
> +{
> +	int ret;
> +	u8 buffer[3];
> +	bool data_ready;
> +	int datarate = ads1100_data_rate[FIELD_GET(ADS1100_DR_MASK, data->config)];
> +	/* To be sure we wait 5 times more than datarate */
> +	unsigned long wait_time = DIV_ROUND_CLOSEST(MICRO, 5 * datarate);

First of all, reversed xmas tree order can be better (especially
when something is assigned). Second, use units in the variable name,
wait_time_us. And at last, use USEC_PER_SEC instead of MICRO
(this will need time.h to be included if not yet).

> +	/* To be sure that polled value will have value after config change */
> +	ret = i2c_master_recv(data->client, (char *)&buffer, sizeof(buffer));
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "I2C read fail: %d\n", ret);
> +		return ret;
> +	}

> +	return read_poll_timeout(ads1100_new_data_not_ready, data_ready,
> +				 !data_ready, wait_time,
> +				 ADS1100_MAX_DRDY_TIMEOUT_US, false, data);

Why not readx_poll_timeout()? It's a short cut for the one-argument "read"
function.

> +}

...

>  	ads1100_set_config_bits(data, ADS1100_PGA_MASK, ffs(gain) - 1);
>  
> -	return 0;
> +	ret = ads1100_poll_data_ready(data);
> +
> +	return ret;

Is it specifically done due to next patch? But this one is marked as Fix and
will go deep back in the releases. For them this will look unjustified. Just
use

	return ads1100_...;

here.


>  static int ads1100_set_data_rate(struct ads1100_data *data, int chan, int rate)
>  {
>  	unsigned int i;
>  	unsigned int size;
> +	int ret;
>  
>  	size = data->supports_data_rate ? ARRAY_SIZE(ads1100_data_rate) : 1;
>  	for (i = 0; i < size; i++) {
> -		if (ads1100_data_rate[i] == rate)
> -			return ads1100_set_config_bits(data, ADS1100_DR_MASK,
> -						       FIELD_PREP(ADS1100_DR_MASK, i));

> +		if (ads1100_data_rate[i] != rate)
> +			continue;

This will look better if you break here and add a check

	if (i == size)
		return -EINVAL;

	... then your new code...

	return ads1100_...;


> +		PM_RUNTIME_ACQUIRE_AUTOSUSPEND(&data->client->dev, pm);

> +

This blank line is not needed as they are coupled, but I don't know if we have
an agreed style in IIO for this.

> +		ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
> +		if (ret)
> +			return ret;
> +
> +		ret = ads1100_set_config_bits(data, ADS1100_DR_MASK,
> +					      FIELD_PREP(ADS1100_DR_MASK, i));
> +		if (ret)
> +			return ret;

> +		ret = ads1100_poll_data_ready(data);
> +
> +		return ret;

As per above.

>  	}
>  
>  	return -EINVAL;

-- 
With Best Regards,
Andy Shevchenko


