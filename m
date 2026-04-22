Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CAC22D8DC4;
	Wed, 22 Apr 2026 19:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776886541; cv=none; b=Hb1AMbESWdobD93w9rEKX6F4gnybaI/r2bbl4ETe6YmkcsP8SP6kKNgs78ci3/cWN/DrWbeFu29GVd48zubMorFbOhfrBpRfAOKbESjxgFgTUzU5WZBvCO2mzIvxue1nv+pke4T9yeVgc74SmPaifQ1y+dRZAnSItZZv3Zp9FgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776886541; c=relaxed/simple;
	bh=VHK+5Y3PkxXPnDKsdcCJNjKmCvMxpLrDR25qpd1RFMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NNCaZNpZ3WumISFWsurxx1aRJDB9xlwYtd5lEuE/O3unAaKvWktaf8gCB8v2IO0Z158bHkJDWZ6gFc5lcdUsmwOFIlQonpVKeFteZ5svy+HqvuwR34IBa4wEKfwoGZMuvrmOQiP24X3n38q0YQAm2ddJk3atSs6trtr7CBEbrck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nbU+6JAh; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nbU+6JAh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776886539; x=1808422539;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VHK+5Y3PkxXPnDKsdcCJNjKmCvMxpLrDR25qpd1RFMU=;
  b=nbU+6JAhvJs0eLy/MELifX4Yqiv1ahBkWcG6ciBsx5nfjdaz0HYCSNwF
   kAxkF8Ssqfk1ijmotzjvZnm2Y4mhTvQU2WQM/G6MwYvrOW2mu9MYzo2hl
   bSL9M7/bAx3Ei4mA9+hJ8KEs/ZtSUMsGw7bEhZYTcwr3vp8C8faf4QJaM
   lVkZ5CeKLWLSJC4m1pzmxVWOHbbFoOGKR9nR7Cg2pkVA7chwOw2DMIDw3
   s35fMNT+9g/ExUrw4TNCjA1UafN0cJpXxdRZtmVrVe8UNvC+cEWf8vV0+
   bJSL30bi+5xMz1HcQeJay8sVlR5cQPcCOa0AyBA/tIRp4CuRR5BvJcQn3
   Q==;
X-CSE-ConnectionGUID: +6YA6ZHLT32wmFF16WLktw==
X-CSE-MsgGUID: mG37sBO8QU2jpcHZdRkb+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="77912275"
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; 
   d="scan'208";a="77912275"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 12:35:38 -0700
X-CSE-ConnectionGUID: +QlWKE11SmGjlxmxu9fZ/g==
X-CSE-MsgGUID: F3sLgNQnTZ+xP6EAFG8Gzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; 
   d="scan'208";a="228101656"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.201])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 12:35:36 -0700
Date: Wed, 22 Apr 2026 22:35:33 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, sakari.ailus@linux.intel.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] iio: accel: mma8452: use local struct device
Message-ID: <aekjBaFT8xvM64zh@ashevche-desk.local>
References: <20260422165643.2148195-1-sanjayembedded@gmail.com>
 <20260422165643.2148195-4-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422165643.2148195-4-sanjayembedded@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 22, 2026 at 10:26:40PM +0530, Sanjay Chitroda wrote:

> Introduce a local struct device pointer derived from &client->dev.
> This avoids repeated &client->dev usage and improves readability.

...

> static int mma8452_set_runtime_pm_state(struct i2c_client *client, bool on)
>  {
>  #ifdef CONFIG_PM

So, this seems to be a missed in the PM patch.

>  	int ret;
> +	struct device *dev = &client->dev;

Keep it in reversed xmas tree order.

>  	if (on)
> -		ret = pm_runtime_resume_and_get(&client->dev);
> +		ret = pm_runtime_resume_and_get(dev);
>  	else
> -		ret = pm_runtime_put_autosuspend(&client->dev);
> +		ret = pm_runtime_put_autosuspend(dev);
>  	if (ret < 0) {
> -		dev_err(&client->dev,
> +		dev_err(dev,
>  			"failed to change power state to %d\n", on);
>  
>  		return ret;

>  }

...

>  static int mma8452_probe(struct i2c_client *client)
>  {
>  	struct mma8452_data *data;
> +	struct device *dev = &client->dev;

Same here, reversed xmas tree order.

>  	struct iio_dev *indio_dev;
>  	int ret;

...

>  	data->chip_info = i2c_get_match_data(client);
>  	if (!data->chip_info)
> -		return dev_err_probe(&client->dev, -ENODEV,
> +		return dev_err_probe(dev, -ENODEV,
>  				     "unknown device model\n");

Now it's a single line.

...

>  	ret = regulator_enable(data->vdd_reg);
>  	if (ret) {
> -		dev_err(&client->dev, "failed to enable VDD regulator!\n");
> +		dev_err(dev, "failed to enable VDD regulator!\n");
>  		return ret;

Convert this to dev_err_probe() before doing this patch. In that patch you
introduce temporary dev variable already. Here will use in the other places.

>  	}
>  
>  	ret = regulator_enable(data->vddio_reg);
>  	if (ret) {
> -		dev_err(&client->dev, "failed to enable VDDIO regulator!\n");
> +		dev_err(dev, "failed to enable VDDIO regulator!\n");
>  		goto disable_regulator_vdd;

Ditto.

>  	}

...

> +	pm_runtime_set_autosuspend_delay(dev,
>  					 MMA8452_AUTO_SUSPEND_DELAY_MS);

Now a single line.

-- 
With Best Regards,
Andy Shevchenko


