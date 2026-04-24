Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2A235E956
	for <linux-iio@vger.kernel.org>; Fri, 24 Apr 2026 09:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777023224; cv=none; b=EZPcaJeWj6ZjH5OZ+YnlB+ia0FW6NPBBFPznC9E6VqQxcJTSWO30noWl9lg4IQN8d+Icm0vEKAo7sUg6CmRLkNATL5nz9oCPo/uOeK3eoRO/Sz8+AQkDjPBbIiDgqC13FbEugcGFoLNfThJG45hnHCpPE4jCcjr6AuNdaiTMbB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777023224; c=relaxed/simple;
	bh=koaKDgsWiBnGQZilWX+GASF+cBneVtBvaDlWJPQOpas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qA4bS14yQyXqubrWnCGrE7LKPnvICMh0NSqUvVzxG7LOq3jLaaLq9sNwGTWlwVWBtBbV3uVmgPR9rtf5wXU1dPy0TezMCMLIz9HqzFWnCno1gYUM2iGzXDwU+aZNgn3in6ms/8PmEVBNsY9X0uUKK/eGNYCshqDJ7/cn9mGXles=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CsF8jLcb; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CsF8jLcb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777023223; x=1808559223;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=koaKDgsWiBnGQZilWX+GASF+cBneVtBvaDlWJPQOpas=;
  b=CsF8jLcbqnPiUr5baTMB0+6U38TMuNkH58Dqoc6hxuQTmwWHsB8NwGyg
   gc2egl+tfUN4hfZsnvXw+qan8/bB8A18MYDtNDnJ6MY2JSRJh5QDt1wSJ
   cLIZ9U7SDJjKuAJpPx7Stp/LVyiwzIYNUPhj96V2pR+nUDmukc9G3sLwb
   181U/dTDF/pREy1EupOPSzuebAAQYxmDw6+P5nXv4XDcsq5rQuliDe65D
   /5UW3sfT0kSdE31tgmhLfU6vHSDNpLlMQcx18Vb6T27VhnJjrTA5xnNA4
   CLpVwBaOwmY2shbA1OWH4PYb2L/vY20SVqu88CYEt6qNB9XOrkS1AkEqX
   w==;
X-CSE-ConnectionGUID: QSouWmW8TZusUgv92w7udQ==
X-CSE-MsgGUID: NcFxAj3aT8CVPFbECPLakg==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="88699825"
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="88699825"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 02:33:43 -0700
X-CSE-ConnectionGUID: BgGAu6gIRDeJPb5gj7ze+g==
X-CSE-MsgGUID: BSHs+S5CSCWC97KmOaTrCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="234701809"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.71])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 02:33:41 -0700
Date: Fri, 24 Apr 2026 12:33:38 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: rafasales@usp.br
Cc: andy@kernel.org, dlechner@baylibre.com, jic23@kernel.org,
	nuno.sa@analog.com, "Gustavo C. Arakaki" <gustavo.arakaki@usp.br>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 2/3] iio: light: ltr501: use automatic cleanup of locks
Message-ID: <aes48q3Sv1RiyzsQ@ashevche-desk.local>
References: <20260422231305.677778-1-rafasales@usp.br>
 <20260422231305.677778-3-rafasales@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422231305.677778-3-rafasales@usp.br>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 22, 2026 at 08:12:56PM -0300, rafasales@usp.br wrote:
> 
> Replace `mutex_lock()` and `mutex_unlock()` calls with guards
> to reduce boilerplate and allow for simpler code blocks.

...

> -	mutex_lock(&data->lock_als);
> -	ret = regmap_field_write(data->reg_als_rate, i);
> -	mutex_unlock(&data->lock_als);
> -
> -	return ret;
> +	guard(mutex)(&data->lock_als);

+ blank line.

We usually consider guard()() as not semantically linked to any code above
or below.

> +	return regmap_field_write(data->reg_als_rate, i);

Ditto for the same cases below.

...

> +		scoped_guard(mutex, &data->lock_als) {
> +			ret = regmap_field_write(data->reg_als_prst, new_val);
> +		}

Read Coding Style, please. The {} are not used for single statement bodies.

> +

This is an opposite to the above, the conditional is semantically coupled with
previous code, no blank line is needed.

>  		if (ret >= 0)
>  			data->als_period = period;

Ditto for the rest.

...

> +			scoped_guard(mutex, &data->lock_als)
> +				ret = ltr501_read_als(data, buf);

You see, even inside one patch there is an inconsistency. That's not good.
(Note, this piece is correct nevertheless by style).

>  			if (ret < 0)
>  				return ret;

...

>  		switch (dir) {
> +		case IIO_EV_DIR_RISING: {
> +			guard(mutex)(&data->lock_als);
> +			return regmap_bulk_write(data->regmap,
> +						 LTR501_ALS_THRESH_UP,
> +						 &val, 2);
> +			}
> +		case IIO_EV_DIR_FALLING: {
> +			guard(mutex)(&data->lock_als);
> +			return regmap_bulk_write(data->regmap,
> +						 LTR501_ALS_THRESH_LOW,
> +						 &val, 2);
> +			}
>  		default:
>  			return -EINVAL;
>  		}

Can you check if instead of doing like that, you can simply move guard()()
level up and make all this simpler? Same Q to the rest of similar code.

-- 
With Best Regards,
Andy Shevchenko


