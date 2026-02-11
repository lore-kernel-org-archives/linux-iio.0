Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E9A2459ED;
	Wed, 11 Feb 2026 08:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770799182; cv=none; b=fjH28m5d+cpeQzy7M1ZIeUDRsmcOasYcACv8abBXJhBzovC3idmQMYygdlnhzNiEAzzGLiSbYpr4YrgFbOeoEWjZB+JoOK+p20V0EOUectWmCEFVHMXFCjkxaSIX8HUoqXIGumz/GarTIGLisghuPLBm1W6G6/AORvy7Rr1VZcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770799182; c=relaxed/simple;
	bh=+DTc/0sbDMRy+rdbWy797QxwUyLWQOSSVJ+cab/X3rs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ghD3GbpS53Z4XpJwhX8+4wQg06YXLiRtFJPzoc0J5Yh0+/5E0dEAhOgw8AIXuEpJpPmq1kVoYn3glULMLkdTsb60uFuVpc+LOBrOkaYBPTLt3ZwtmrZG/Bm76PTyvGvY9bomgfNeslpyJQTj2PoYi7rV0DxHb4RmdgW1noOkU1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xr7JsQWF; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xr7JsQWF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770799181; x=1802335181;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+DTc/0sbDMRy+rdbWy797QxwUyLWQOSSVJ+cab/X3rs=;
  b=Xr7JsQWF8+WiNL+I4q7WXy20moyERnGXWl2RVdieWCV0BGeXObEAU6Os
   /37mKwM4swormgcWXNalZU22ORcW0Mf+ACtnklBLP7TwMGI086R2m5PfI
   pUxb6vlRxog4vwhonmXez9FyvZfet7GgPDD2K8pffZ779FBIKuimu/0vo
   nSgQpuRRQtJ6W42ZSpKTacNd0Qdaz9k0fdRkSFbh+QcyXnoocQHSZdSQE
   QROMEVFBD03vF7j8KQCm87DxmSjd5pG/pCfXnqH6RD80AIL41wmA/9Es1
   9xMn4zkMNbI0MN7xbIOXEjloir8Un7AgnvEt8WHsrA+oQb90WcFtuuKO8
   A==;
X-CSE-ConnectionGUID: 1UTUkg/LR0+qoXOpzZWKng==
X-CSE-MsgGUID: LsUi4UzfSd2xICzJ47YHMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="71928583"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="71928583"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2026 00:39:41 -0800
X-CSE-ConnectionGUID: cmFnpB+vSa+cyiJcAFaGaQ==
X-CSE-MsgGUID: xaG57M9yTWKpXApAAATkKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="212007665"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.220])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2026 00:39:38 -0800
Date: Wed, 11 Feb 2026 10:39:35 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Neel Bullywon <neelb2403@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/3] iio: magnetometer: bmc150_magn: use automated
 cleanup for mutex
Message-ID: <aYxARz8CXoLRQtBC@smile.fi.intel.com>
References: <20260210233945.40975-1-neelb2403@gmail.com>
 <20260210233945.40975-2-neelb2403@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210233945.40975-2-neelb2403@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Feb 10, 2026 at 06:39:43PM -0500, Neel Bullywon wrote:
> Use guard() and scoped_guard() to replace manual mutex lock/unlock
> calls. This simplifies error handling and ensures RAII-style cleanup.
> 
> scoped_guard() is used in read_raw IIO_CHAN_INFO_RAW case for a
> multi-statement mutex-protected block, as well as in remove,
> runtime_suspend, and suspend where a short mutex-protected scope
> is needed for a single function call.
> 
> guard() is used in write_raw and trig_reen where the mutex scope
> extends to the end of the function or case block. Case blocks in
> write_raw are wrapped in braces to ensure clear scope for the
> cleanup guards.
> 
> The trigger_handler function is left unchanged as mixing guard()
> with goto error paths can be fragile.

...

>  #include <linux/module.h>
>  #include <linux/i2c.h>
> +#include <linux/cleanup.h>
>  #include <linux/interrupt.h>
>  #include <linux/delay.h>
>  #include <linux/slab.h>

With a given context I would place the new one just before the delay.h.


...

>  	case IIO_CHAN_INFO_RAW:
>  		if (iio_buffer_enabled(indio_dev))
>  			return -EBUSY;
> -		mutex_lock(&data->mutex);
> -
> -		ret = bmc150_magn_set_power_state(data, true);
> -		if (ret < 0) {
> -			mutex_unlock(&data->mutex);
> -			return ret;
> -		}
> +		scoped_guard(mutex, &data->mutex) {
> +			ret = bmc150_magn_set_power_state(data, true);
> +			if (ret < 0)
> +				return ret;
>  
> -		ret = bmc150_magn_read_xyz(data, values);
> -		if (ret < 0) {
> -			bmc150_magn_set_power_state(data, false);
> -			mutex_unlock(&data->mutex);
> -			return ret;
> -		}
> -		*val = values[chan->scan_index];
> +			ret = bmc150_magn_read_xyz(data, values);
> +			if (ret < 0) {
> +				bmc150_magn_set_power_state(data, false);
> +				return ret;
> +			}
> +			*val = values[chan->scan_index];
>  
> -		ret = bmc150_magn_set_power_state(data, false);
> -		if (ret < 0) {
> -			mutex_unlock(&data->mutex);
> -			return ret;
> +			ret = bmc150_magn_set_power_state(data, false);
> +			if (ret < 0)
> +				return ret;
>  		}
> -
> -		mutex_unlock(&data->mutex);
>  		return IIO_VAL_INT;

Actually looking again at this, I think we may use guard()(), but move the {}
to the whole case:

	case IIO_CHAN_INFO_RAW: {
		if (iio_buffer_enabled(indio_dev))
			return -EBUSY;

		guard(mutex)(&data->mutex);
		...
	}

This will make the change much more cleaner.

...

>  		case IIO_MOD_Z:
> +			{
> +				guard(mutex)(&data->mutex);

Why do you change only one case?! If the comment is given, it applies
to all similar places. But see also above.

-- 
With Best Regards,
Andy Shevchenko


