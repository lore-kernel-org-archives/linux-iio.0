Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E48421A11;
	Wed, 29 Apr 2026 19:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777489603; cv=none; b=AnoWtlwp0lAvO7a5wCJRE3MX9j+j+KzHAnkN7dDBT7eUjt94pxr2M6rQokSXRVgWgRVU8rnHIh59YvknSX7q8CYp1TrKxatdbZ0NvQQ46oV+8H44awTdLO6X0tsLKsO8lpWAAcZDMGzJSKf1krCwIwY0lhbCR5P3Wqe1nZe+IzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777489603; c=relaxed/simple;
	bh=GMDN2K0Y4EZu2ptxkoVwqpRuW2LviPA0JY4Z8GeVm3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rn9yzlG3BFDeK0c9HYeD63lnHzebyMZtTGwgirgREPb1RFrPXITgCvr9fsLEejK80Bv1bWHwzTaqvFgXJvzxyKM6vjX5pgQjSYeRf6I0yOpHrG72ZKpcOpXDInEk4O7X7bpx7WUvsKjRoA1GbdVJX1icu77D32mOCSHBjI3HF9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MEmgjqQD; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MEmgjqQD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777489600; x=1809025600;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GMDN2K0Y4EZu2ptxkoVwqpRuW2LviPA0JY4Z8GeVm3o=;
  b=MEmgjqQD9e76ddML5A130L0ufzk+s1BPhkrAIO5qMeOL5mogCgKsAVC0
   Cg1Y3TkZxnSPLOLCYbSbUTUDwfey5rjFkBZkeKdzzkx5kBrVasfNF8YUB
   O9RdFhxuU19Dx50spA3NekvUmvh/wTPhSI0whfLlJCXqaTbE/9iaJRIPG
   ty/0Fd3TiPiZasc1Kgeezoxix/0e2vGVnoA9Tdbo2XHUbSfcI9YqZNZV6
   mYg2UJIfIAOu7dNkpyGAFOuSy3F5iFMzGd5Qyj8xeliSnPkDku9jYPMbO
   a6V1sEDhJLBwFeu3m4F2PElMdUNobD03gFUG9fScFK8et7CLXW83Zh0LY
   w==;
X-CSE-ConnectionGUID: Y6E/xDvWT1GslvYgvVVIGA==
X-CSE-MsgGUID: FweczVmRQ1SeIvQ/QRFs/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="89027677"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="89027677"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 12:06:39 -0700
X-CSE-ConnectionGUID: rmyO7wF2QYq9aDn3vV1MCA==
X-CSE-MsgGUID: 8DCq0tlIQdqbTqEthZo9zA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="233326458"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.141])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 12:06:36 -0700
Date: Wed, 29 Apr 2026 22:06:34 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Piyush Patle <piyushpatle228@gmail.com>
Cc: ak@it-klinger.de, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 11/11] iio: adc: hx711: add support for HX710B
Message-ID: <afJWusvDDjuI-m2k@ashevche-desk.local>
References: <20260429054544.123862-1-piyushpatle228@gmail.com>
 <20260429054544.123862-12-piyushpatle228@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429054544.123862-12-piyushpatle228@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 29, 2026 at 11:15:44AM +0530, Piyush Patle wrote:
> Add support for the AVIA HX710B ADC, which shares the HX711 GPIO
> interface but uses trailing PD_SCK pulses to select the active mode.
> 
> Model the HX710B with variant-specific channel tables and IIO info,
> track the active channel across conversions, and use the fixed gain
> value when computing scale.
> 
> Also update the adjacent Kconfig text, file header, and module
> description so the driver text matches the newly supported variant.

...

>  /*
> - * HX711: analog to digital converter for weight sensor module
> + * HX711 and compatible ADCs driver for weight sensor modules

As noticed in previous round, shouldn't we fix weight --> weigh?

>   *
>   * Copyright (c) 2016 Andreas Klinger <ak@it-klinger.de>
>   */

...

>  #include <linux/err.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>

> +#include <linux/types.h>

No, you clearly see the order. Please, preserve it.

>  #include <linux/mod_devicetable.h>
>  #include <linux/platform_device.h>
>  #include <linux/property.h>

...

> + * @fixed_gain: true if the variant has a fixed ADC gain

> +	bool				fixed_gain;

In accordance with the kernel-doc, name the variable "has_fixed_gain".

...

>  	/*
>  	 * triggered buffer
> -	 * 2x32-bit channel + 64-bit naturally aligned timestamp
> +	 * up to 3x32-bit channels + pad + 64-bit naturally aligned timestamp
>  	 */
>  	struct {
> -		u32 channel[2];
> +		u32 channel[3];
> +		u32 pad;
>  		aligned_s64 timestamp;
>  	} buffer;

I think I still doesn't follow if this kind of changes affects ABI or not.
Jonathan, is it usually okay to inject more entries in this structure?

...

> +static int hx711_set_hx710b_channel(struct hx711_data *hx711_data,
> +				    const struct iio_chan_spec *chan)
> +{
> +	int ret;
> +
> +	if (hx711_data->channel_set == (unsigned int)chan->channel)

Why do we need explicit casting?

> +		return 0;
> +
> +	ret = hx711_read(hx711_data, chan->address);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = hx711_wait_for_ready(hx711_data);
> +	if (ret)
> +		return ret;
> +
> +	hx711_data->channel_set = chan->channel;
> +
> +	return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko


