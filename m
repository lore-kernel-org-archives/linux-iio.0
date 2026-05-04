Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA703D75D7
	for <linux-iio@vger.kernel.org>; Mon,  4 May 2026 14:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777904102; cv=none; b=g3XLDlWCBf1SAQUT9UgBC52DKMP5gSWSz2hpPm5Isbwf7Hnwbf1kzJuCoBEBamhojR4QwC0tuUF7vqYJKETEglnKvug9KLTfOOnQpZuROcyKHLjNnQEPicztkEwlVGRVaPBExHc/pd1qSHNHlsM2+TZPI3hpimbq27sYyMncWC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777904102; c=relaxed/simple;
	bh=jpEJAJU/0Yhx0x8jzAYjqFlKzTkxiYX/d+fs66qK+4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SkvDSNEfMdhvqtuQY73GdGCrf3yTBdisIMIdbt0mumRWxEaNsIgOoNaBHziOWs4kyOP2RBuvNWW9RFteAkBgx1gmjRTcQkBK1/rMqCLsK0hnmyy+WVmCAQ++hrsdapjZymUkXCHxHOunSNHhDyCow9x/E1X7Cs+32d1ejCDlaX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FBaQyjxE; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FBaQyjxE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777904101; x=1809440101;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jpEJAJU/0Yhx0x8jzAYjqFlKzTkxiYX/d+fs66qK+4M=;
  b=FBaQyjxEYkE0YTY/ACYMDSLz5vlf1RQDrkhpNlNaEuK+vg8aqfgl4var
   YCn4aSG+9KcZL5GYM7VOTytuCC1v0xl+w5wUO6ocLJVP3O9F8HNqDVUE/
   RJmEDQ4/XNvQVCqA+x5MuEDw/lW5zZBLj3TaaO4s2evjKCzasVmJjzgEB
   j8mRV8xauRQfdM+DFseQIzLNfXd7Ua5dDHPFbAbygpFPlSnwaNl4Ow27a
   sGfdQrQ4+WD7CjbsiN0Q5Nlh85SR/YUvdwqBHyTbj1yyZHYfgvd6V3yrE
   vEu0PcMDGcQ3uzex9rU6Ht+94jXlMGWhKxxKOmK+D6Vba9uNGLsXJo7x4
   A==;
X-CSE-ConnectionGUID: 7czMjum5Swqoz85nlBfUxw==
X-CSE-MsgGUID: SkLY6YacSse3L0yXtzMwtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="77778486"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="77778486"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 07:15:01 -0700
X-CSE-ConnectionGUID: 1oDpYSpnReiDUG+7BCCmEw==
X-CSE-MsgGUID: oSGkLrewQmSzCLIk6pCxxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="258874215"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.198])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 07:14:58 -0700
Date: Mon, 4 May 2026 17:14:56 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Gabriel Braga Lagrotaria <gabrielblo@ime.usp.br>
Cc: andy@kernel.org, dlechner@baylibre.com, javier.carrasco.cruz@gmail.com,
	jic23@kernel.org, nuno.sa@analog.com, ricardo.kojo@ime.usp.br,
	elliancarlos@gmail.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: light: veml6030: Generalize hw_init for
 veml6030 and veml6035
Message-ID: <afip4G46Bkj4iEka@ashevche-desk.local>
References: <20260502234348.131563-1-gabrielblo@ime.usp.br>
 <20260502234348.131563-3-gabrielblo@ime.usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260502234348.131563-3-gabrielblo@ime.usp.br>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, May 02, 2026 at 08:41:04PM -0300, Gabriel Braga Lagrotaria wrote:
> Modify veml6030_hw_init() function to deduplicate the setup logic
> for veml6030_hw_init() and veml6035_hw_init(), and remove
> veml6035_hw_init().
> 
> Additionally, introduce struct veml6030_hw_init_config_desc to store and
> pass the custom configuration values specific to each device variation.

...

> @@ -963,61 +972,21 @@ static int veml6030_regfield_init(struct iio_dev *indio_dev)
>  	return 0;
>  }
>  
> +

I can argue that this is a stray change, but I'm not objecting to having it.

>  /*
>   * Set ALS gain to 1/8, integration time to 100 ms, PSM to mode 2,
>   * persistence to 1 x integration time and the threshold
>   * interrupt disabled by default. First shutdown the sensor,
>   * update registers and then power on the sensor.
>   */

...

> +static const struct veml6030_hw_init_config_desc veml6030_hw_init_config = {
> +	.gain_sel = veml6030_gain_sel,
> +	.gain_sel_size = ARRAY_SIZE(veml6030_gain_sel),
> +	.gain_max_scale_int = 2,
> +	.gain_max_scale_nano = 150400000,
> +	.reg_als_conf_value = 0x1001,
> +};
>  
> -	return ret;
> -}
>  

Now here are two blank lines? One is enough.

...

> @@ -1074,9 +1051,11 @@ static int veml6035_hw_init(struct iio_dev *indio_dev, struct device *dev)
>  		return dev_err_probe(dev, ret,
>  				     "can't clear als interrupt status\n");
>  
> -	return 0;
> +	return ret;
>  }
>  
> +
> +

Ditto.

>  static int veml6030_probe(struct i2c_client *client)
>  {
>  	int ret;
> @@ -1167,6 +1146,7 @@ static int veml6030_runtime_resume(struct device *dev)
>  static DEFINE_RUNTIME_DEV_PM_OPS(veml6030_pm_ops, veml6030_runtime_suspend,
>  				 veml6030_runtime_resume, NULL);
>  
> +

Stray change.

>  static const struct veml6030_chip_desc veml6030_chip = {
>  	.name = "veml6030",
>  	.channels = veml6030_channels,

-- 
With Best Regards,
Andy Shevchenko


