Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E9136D51D;
	Mon, 29 Jun 2026 15:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782745362; cv=none; b=dnNwZSm2/KXzlWMlsVfNLSc03NT63pCiZEVq6z10stOwDThFH0F3lWrKWrt61TtsJpSYnNl1wk9NK8gv+FYSIpu7WzemmD+J5Qkd7YyfUwoVwc0B5WC9VcJBGn9kdgG9RKBtSCE3p5YtE/1A37mWHp7IK7IX8tWB8fXUlDbIyxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782745362; c=relaxed/simple;
	bh=X4FpkWQK9k+WZsnvlkXHMQmZXAaREh0Yd1dNNItTpME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SIcJBx4hjyxK/oFwK4JC3UfOqmLo1caR3F8eO6ruePFDsGBK9zAhd2bGvfTR6Q17f+jc6z7AexAR9Y2uCjodvAm2pegQvwoCUHNXmVt0ksBJXo6YJ/UmBtdez9Z6U+Keo/sVD2cMmE//56vfX0AqjqcWsvCAIjEx5fE7eTcp1v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JLtjyCQu; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JLtjyCQu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782745360; x=1814281360;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=X4FpkWQK9k+WZsnvlkXHMQmZXAaREh0Yd1dNNItTpME=;
  b=JLtjyCQuIdi+d81ynKkUUejRxqxfzERCSkH3N8Tgdx1nTW/AmFJ3z43L
   RVmMGvJMoqNj5sA/v3bYNAy3VBtwCi9+ApZAapSKVXycI1kQkE+4IF1zU
   7vlLpg7bRgh8b3cmX+IB7M4kP0AMHE0tX9sC1i9Bw5eaJWRdx62JN0/gE
   zpgzyLEKIqKxJ71oaq1toGfngZiN9XPJ3ZBceqdV4GNHu4Kaoujl63lb7
   F/S1p6yepYqmgHfzDmvzEmvvGNl1/okYimMywXfO+O33ElzX5dXV7f9go
   lEb8Bp6oihwcrDAxsEKMBFcvtOxZJPBp2gFPLI2UUHGA/eMzNx0htfdgk
   g==;
X-CSE-ConnectionGUID: 3+C43byMTi2LCFP2wiAmGQ==
X-CSE-MsgGUID: rcX+peX8SdaLBIPfPvOQrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="82433631"
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="82433631"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 08:02:39 -0700
X-CSE-ConnectionGUID: HnM/y5VpS1K9K+0xcZSOXw==
X-CSE-MsgGUID: l5ktsAwuR3KyTDFBDLEkOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="250920748"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.207])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 08:02:34 -0700
Date: Mon, 29 Jun 2026 18:02:31 +0300
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
Subject: Re: [PATCH v5 1/3] iio: adc: Fix incorrect reading when datarate
 changed in single mode
Message-ID: <akKJBy3xQYv1xnFe@ashevche-desk.local>
References: <20260628194341.66752-1-jakubszczudlo40@gmail.com>
 <20260628194341.66752-2-jakubszczudlo40@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260628194341.66752-2-jakubszczudlo40@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Jun 28, 2026 at 09:43:39PM +0200, Jakub Szczudlo wrote:
> When device is suspended and it is in single mode then changing
> datarate doesn't make it actual wait for new measurement, so to
> be sure that read after change is correct functions that changes
> datarate and gain will wait for new data.

...

> +static int ads1100_poll_data_ready(struct ads1100_data *data)
> +{
> +	int data_rate_hz = ads1100_data_rate[FIELD_GET(ADS1100_DR_MASK, data->config)];

I would use proper SI units here, id est _Hz.

> +	/* To be sure we wait 5 times more than data rate */
> +	unsigned long wait_time_us = DIV_ROUND_CLOSEST(USEC_PER_SEC, 5 * data_rate_hz);

Not sure if it's less readable than in case of split assignments. Perhaps I
would take that.

> +	bool data_ready;
> +	u8 buffer[3];
> +	int ret;

	unsigned long wait_time_us;
	int data_rate_Hz;
	bool data_ready;
	u8 buffer[3];
	int ret;

	data_rate_Hz = ads1100_data_rate[FIELD_GET(ADS1100_DR_MASK, data->config)];

	/* To be sure we wait 5 times more than data rate */
	wait_time_us = DIV_ROUND_CLOSEST(USEC_PER_SEC, 5 * data_rate_Hz);


> +	/* To be sure that polled value will have value after config change */
> +	ret = i2c_master_recv(data->client, buffer, sizeof(buffer));
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "I2C read fail: %d\n", ret);
> +		return ret;
> +	}

> +	return readx_poll_timeout(ads1100_new_data_not_ready, data,
> +				 data_ready, data_ready != 0, wait_time_us,
> +				 ADS1100_MAX_DRDY_TIMEOUT_US);

Split logically

				 data_ready, data_ready != 0,
				 wait_time_us, ADS1100_MAX_DRDY_TIMEOUT_US);

> +}

...

>  static int ads1100_set_data_rate(struct ads1100_data *data, int chan, int rate)
>  {
>  	unsigned int i;
>  	unsigned int size;
> +	int ret;
>  
>  	size = data->supports_data_rate ? ARRAY_SIZE(ads1100_data_rate) : 1;

>  	for (i = 0; i < size; i++) {

Hmm... While at it, perhaps

	for (unsigned int i = 0; i < size; i++) {

but it's fine to leave as is.

> -		if (ads1100_data_rate[i] == rate)
> -			return ads1100_set_config_bits(data, ADS1100_DR_MASK,
> -						       FIELD_PREP(ADS1100_DR_MASK, i));
> +		if (i == size)
> +			return -EINVAL;
> +
> +		PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(&data->client->dev, pm);
> +		ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
> +		if (ret)
> +			return ret;
> +
> +		ret = ads1100_set_config_bits(data, ADS1100_DR_MASK,
> +					      FIELD_PREP(ADS1100_DR_MASK, i));
> +		if (ret)
> +			return ret;
> +
> +		return ads1100_poll_data_ready(data);
>  	}
>  
>  	return -EINVAL;

-- 
With Best Regards,
Andy Shevchenko


