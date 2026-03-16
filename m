Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D79C279336;
	Mon, 16 Mar 2026 14:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773671134; cv=none; b=LY/dciU4A+AmRMhslRkoA6wyH+91dSNXGRIqhV4ZQI0dcRHtfkbTrWmxXsdmRw+NsB3ZEzVCEOeDJ+HgDg9Nl7S3RYQPJwXMyNKAHyZ/SJxv0HlsbmJJOqDmjVZptA0o6SUG4seDOVutLSAcnvbiBqPS4NYSzB6SrIYhaWQZ9xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773671134; c=relaxed/simple;
	bh=BSgg6KtHp+XdA95gnl1/Q020tGtHqDxyhgpg7ceAYDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fnoj0VTyPpfBy9dV2ISGCbLegmlihUvIBNzJSiSziCXafdXsRMfgFh1EMeUREuy5m6mgSbQVITqD3feOxUAdqxzXJCaeTLL7r85Pq2oW3xRp+tYp/p2xnNZa1CkRlLduwuFsinpusACJFlbP2NNvmncMudC24Hyf7BERcQcGJXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VOp1ac9l; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VOp1ac9l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773671132; x=1805207132;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BSgg6KtHp+XdA95gnl1/Q020tGtHqDxyhgpg7ceAYDE=;
  b=VOp1ac9lKUCGpTh3PtBE2kqa4UxmypVDTfhp9sur0fg5043PFJ7NhAdk
   RGAqmS1pKYfWT49PXECNBPHlprBTm0IAEQyNEX9Igu6dqqtqZKY7RQhs9
   6sFgaHSgbN2xJD9BA0D9iZBeSqLXhzut2AES+aEVjfrPXcfHQzI2EUXpT
   VO5Zo18QqgYVd+fX0nTcaubKAD/WlMDKCs+df7Is+8zPYIwyfKMJp+dgj
   kYuAJWyNaYdKlptIRCaB075WhH0NnEHTzkYGuSmEe5gNtMYykAF9VnYWE
   39O06WUzKMB0VagldJ7gOp74+7mq3/TumzYPnEtO/5j/CmOrmvAKKneWy
   g==;
X-CSE-ConnectionGUID: BFNtt2MZQ76aod4cVZNaVw==
X-CSE-MsgGUID: ISD8jVJQSoCbSVK3+tR8JA==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="73869882"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="73869882"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 07:25:32 -0700
X-CSE-ConnectionGUID: 9dSGBVBxSU+QgCbE+j0MPQ==
X-CSE-MsgGUID: ekmacsyCTWuQio6UChNBFw==
X-ExtLoop1: 1
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.237])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 07:25:29 -0700
Date: Mon, 16 Mar 2026 16:25:26 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	morris_mao@aspeedtech.com
Subject: Re: [PATCH v2 2/3] iio: adc: Enable multiple consecutive channels
 based on model data
Message-ID: <abgS1lOoEO1RTe9X@ashevche-desk.local>
References: <20260316-adc-v2-0-21475a217b09@aspeedtech.com>
 <20260316-adc-v2-2-21475a217b09@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316-adc-v2-2-21475a217b09@aspeedtech.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Mar 16, 2026 at 11:00:47AM +0800, Billy Tsai wrote:
> Add helpers to generate channel masks and enable multiple ADC channels
> according to the device model's channel count.

...

> +

(1)

> +/*
> + * Enable multiple consecutive channels starting from channel 0.
> + * This creates a bitmask for channels 0 to (num_channels - 1).
> + * For example: num_channels=3 creates mask 0x0007 (channels 0,1,2)
> + */
> +static inline u32 aspeed_adc_channels_mask(unsigned int num_channels)
> +{
> +	if (num_channels == 0)
> +		return 0;

> +	if (num_channels >= 16)
> +		return GENMASK(15, 0);
> +	return GENMASK(num_channels - 1, 0);

This entire function can be folded into

	return BIT(min(num_channels, 16U)) - 1;

Or

	if (num_channels > 16)
		return GENMASK(15, 0);

	return BIT(num_channels) - 1;

> +}

> +/*
> + * Helper function to enable multiple channels in the control register
> + */
> +static inline u32 aspeed_adc_enable_channels(unsigned int num_channels)
> +{
> +	return FIELD_PREP(ASPEED_ADC_CTRL_CHANNEL, aspeed_adc_channels_mask(num_channels));
> +}

> +

One of these (see 1 above) new blank lines should be rather added in the previous patch.

>  /* Battery sensing is typically on the last channel */
>  #define ASPEED_ADC_BATTERY_CHANNEL		7

...

>  	/* Start all channels in normal mode. */
> -	adc_engine_control_reg_val =
> -		readl(data->base + ASPEED_REG_ENGINE_CONTROL);
> -	adc_engine_control_reg_val |= ASPEED_ADC_CTRL_CHANNEL;
> +	adc_engine_control_reg_val = readl(data->base + ASPEED_REG_ENGINE_CONTROL);

> +	adc_engine_control_reg_val |=
> +		aspeed_adc_enable_channels(aspeed_adc_get_active_channels(data));

Why not FIELD_MODIFY()?

>  	writel(adc_engine_control_reg_val,
>  	       data->base + ASPEED_REG_ENGINE_CONTROL);

-- 
With Best Regards,
Andy Shevchenko


