Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5320C4B048C;
	Thu,  6 Aug 2026 23:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786060240; cv=none; b=CoF2D85Q2c4oWcEdBU4Co804ptPYD6geCpJI03biztadv8+68zhcfrZfVwKfU9AM3JU91+x4xp28qJSujPeHAB/nxvq6ywVznhP0qVXLNyqQCVHzuHF+Zre7TYtQ7uv9HnAjmf2BVgapS29avCyHrEslV8nQIm/ZjmeVKT7KPVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786060240; c=relaxed/simple;
	bh=kKLOSlFiKcKTHwiRLrLPxhtjlh2a0eF4wg9zelMpFRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=arDH84nW4vZFPLTP6q7UWk5ShkX16LtzdJtBHaWIgSaUL6aCkqwxYh9Ll/D3vodgW7ZtJGTPoYqTWcWu34KcpMnfeQ19DbOUeYLENYbla/R0HmTxvz4fNRScnD8//rlADTM71oxRVDbsFFmT5AH6bnbB8OmLhU3nysnprYOaDmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N4miflwN; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N4miflwN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786060240; x=1817596240;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kKLOSlFiKcKTHwiRLrLPxhtjlh2a0eF4wg9zelMpFRk=;
  b=N4miflwNLxGOYccFB5oFpoJpTfbJ+uz9Rilzy+GptS2HjfYcHzNhZlcQ
   sy1DtWwBgowmUbeSnlODnFTpsdpveXFL5G7jq8fsohEo3O1fqsQBkwS9z
   1UK1kmubAEwsXEwkZgbGVxal0Euib6YTCOne3UpKJV1vGBO6tkXzlu436
   h37KYJylyREvAgjIPV4Gmuauc2/A2lW7LMMtW/1N8pr3bO8f8EvwMFgim
   R+HDN10TIicSXYIg2Ip0ALlroCnz5PLgASs4ULTqD2hqDcRYINiXPruoe
   29UELKUxpLj7cOmDSOUXE8ispnI5gwQIvTBC9YJ08T3cFjCArfqWrj6je
   w==;
X-CSE-ConnectionGUID: /RPLPVmFTfetbDVnuqTT7Q==
X-CSE-MsgGUID: Uit64OzOQiqdreazHM8U2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="86606912"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="86606912"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 16:50:39 -0700
X-CSE-ConnectionGUID: pDQtYCSCRAKL//ir7Y0GPA==
X-CSE-MsgGUID: 0JzKfXPLTkSZA5H5+0xUfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="260964048"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.50])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 16:50:36 -0700
Date: Fri, 7 Aug 2026 02:50:33 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: mdshahid03@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	David Lechner <dlechner@baylibre.com>,
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>
Subject: Re: [PATCH v2] iio: adc: bcm_iproc_adc: Convert probe() to use
 dev_err_probe()
Message-ID: <anUdydEokIvj2pyO@ashevche-desk.local>
References: <20260727034009.5c6b0be9@jic23-huawei>
 <20260730140405.369634-1-mdshahid03@gmail.com>
 <20260730140405.369634-2-mdshahid03@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730140405.369634-2-mdshahid03@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jul 30, 2026 at 07:32:45PM +0530, mdshahid03@gmail.com wrote:

> Replace open-coded probe error handling with dev_err_probe() for
> resource acquisition and initialization failures.
> 
> This simplifies the error paths, avoids repetitive error handling,
> and automatically suppresses duplicate messages when -EPROBE_DEFER is
> returned while preserving the existing error messages.
> 
> Also remove the redundant error message after iproc_adc_enable(),
> allowing the error to be propagated without additional logging.

...

> static int iproc_adc_probe(struct platform_device *pdev)

While at it, consider adding

	struct device *dev = &pdev->dev;

at the top of the function to simplify the below calls.

>  	adc_priv->regmap = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
>  			   "adc-syscon");
> -	if (IS_ERR(adc_priv->regmap)) {
> -		dev_err(&pdev->dev, "failed to get handle for tsc syscon\n");
> -		ret = PTR_ERR(adc_priv->regmap);
> -		return ret;
> -	}
> +	if (IS_ERR(adc_priv->regmap))
> +		return dev_err_probe(&pdev->dev,
> +				     PTR_ERR(adc_priv->regmap),
> +				     "failed to get handle for tsc syscon\n");

		return dev_err_probe(dev, PTR_ERR(adc_priv->regmap),
				     "failed to get handle for tsc syscon\n");

>  	adc_priv->adc_clk = devm_clk_get(&pdev->dev, "tsc_clk");
> -	if (IS_ERR(adc_priv->adc_clk)) {
> -		dev_err(&pdev->dev,
> -			"failed getting clock tsc_clk\n");
> -		ret = PTR_ERR(adc_priv->adc_clk);
> -		return ret;
> -	}
> +	if (IS_ERR(adc_priv->adc_clk))
> +		return dev_err_probe(&pdev->dev,
> +				     PTR_ERR(adc_priv->adc_clk),
> +				     "failed getting clock tsc_clk\n");

And here, and so on...

...

>  	adc_priv->irqno = platform_get_irq(pdev, 0);
>  	if (adc_priv->irqno < 0)
> -		return adc_priv->irqno;
> +		return dev_err_probe(&pdev->dev,
> +				     adc_priv->irqno,
> +				     "failed to get IRQ\n");

This is wrong. The above call print an error.

>  	ret = regmap_clear_bits(adc_priv->regmap, IPROC_REGCTL2,
>  				IPROC_ADC_AUXIN_SCAN_ENA);
> -	if (ret) {
> -		dev_err(&pdev->dev, "failed to write IPROC_REGCTL2 %d\n", ret);
> -		return ret;
> -	}
> +	if (ret)
> +		return dev_err_probe(&pdev->dev,
> +				     ret,
> +				     "failed to write IPROC_REGCTL2\n");

It's a one line still (with the above change):

		return dev_err_probe(dev, ret, "failed to write IPROC_REGCTL2\n");

>  	ret = devm_request_threaded_irq(&pdev->dev, adc_priv->irqno,
>  				iproc_adc_interrupt_handler,
>  				iproc_adc_interrupt_thread,
>  				IRQF_SHARED, "iproc-adc", indio_dev);
> -	if (ret) {
> -		dev_err(&pdev->dev, "request_irq error %d\n", ret);
> -		return ret;
> -	}

> +	if (ret)
> +		return dev_err_probe(&pdev->dev,
> +				     ret,
> +				     "failed to request IRQ\n");

This should be a separate patch to drop the dup message. The IRQ core prints
it.

...

> +		return dev_err_probe(&pdev->dev,
> +				     ret,
> +				     "failed to enable clock\n");

One line.

-- 
With Best Regards,
Andy Shevchenko


