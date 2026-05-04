Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCE939D6E7;
	Mon,  4 May 2026 11:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777893047; cv=none; b=CUPR6FDnsCT2V4pzZj62/MVGRTvWnOONvkkdXCK2Ip0pVpXlFJiHHAfmpCqao85QiD1f98kWNZRMY7e/Cd7VEqPl8nNokFdbax8n/Un0ayMo39EbNghgXhBE3acYvmyVdkUHkO2nCWiRvNZJ0aAEC3vmsF8pobkyqqiVbsNH/qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777893047; c=relaxed/simple;
	bh=BtfPN4oy+FFGUBYnOzCFcHvM6cXEC9ZSvs9DGSXE8yg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QUTCnqT7RspzeZsZyjc8FIHrEq4vN/s0wCCpR4jOckGzuVNIf7hpbNmVvJdeqZLLj0JDm5t/MTX59iyTgYcGh16659o8HAIjHpmNuiZt4gGwEqy8nNDJ2A7ms0c5YM2U91U1w4pEgVa7QlKmPd1NRPPKq9Z5dT7741q+xG2fA2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YU488up5; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YU488up5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777893046; x=1809429046;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BtfPN4oy+FFGUBYnOzCFcHvM6cXEC9ZSvs9DGSXE8yg=;
  b=YU488up5zfIFXp705yIfMCkQ5QGdTIrRd6o7ySrJSwkaV5KCXObOf6g4
   56jVlcwqObwFnV5AwI36CHe51MSE+NyeKxQLZh46YTtBrL3ozRV7ek/4/
   zy1hmRKok8OQ0p6eiBWvJggvCJg1ofoWVbIb5XRcd/7lUYRpMiRW/I9Qa
   gzTSOBxoHqXmF4pFwHDnQJ1DMn8bWTAsGc78odIZ9fNnbQj9EL3sSkI5q
   RbOsWnUKTjxXEP6z0blPwrlJ/S7Vo+3jQ0uMf/1TCuxGSzVoaIHjzsxrn
   SUQSbFf7VL+CvYjv4Jor1Qid/nvtwhklNx2nVWMmpjCpvbnDXZE4g3Zgh
   g==;
X-CSE-ConnectionGUID: HCC3PYk4QcSxSC6RCJ2Qwg==
X-CSE-MsgGUID: HdVQbIgFTOyO1QrtWFCJoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11775"; a="89332282"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="89332282"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 04:10:46 -0700
X-CSE-ConnectionGUID: sD+x6jiURTqFXBzDNiyU+w==
X-CSE-MsgGUID: eByOlG5MSwSxbL7CNh1QBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="230896469"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.78])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 04:10:44 -0700
Date: Mon, 4 May 2026 14:10:42 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: joshua.crofts1@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 07/17] iio: magnetometer: ak8975: pass conversion
 timeouts as arguments
Message-ID: <afh-smyJoL7xRiqZ@ashevche-desk.local>
References: <20260504-magnetometer-fixes-v4-0-a291c2a7c71a@gmail.com>
 <20260504-magnetometer-fixes-v4-7-a291c2a7c71a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504-magnetometer-fixes-v4-7-a291c2a7c71a@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, May 04, 2026 at 11:48:19AM +0200, Joshua Crofts via B4 Relay wrote:

> Since we have switched to using macros from iopoll.h it's better to
> use poll and timeout values supplied as parameters to the helper
> functions. Also added local variables for poll and timeout values
> to prevent magic number use.
> 
> Besides that, fix the home grown and obviously wrong in some cases the
> jiffy-based timeout.

...

> -static int wait_conversion_complete_gpio(struct ak8975_data *data)
> +static int wait_conversion_complete_gpio(struct ak8975_data *data, int poll_ms,
> +					 int timeout_ms)

Logical split is preferred:

static int wait_conversion_complete_gpio(struct ak8975_data *data,
					 int poll_ms, int timeout_ms)

OTOH, why are they signed? Maybe

static int wait_conversion_complete_gpio(struct ak8975_data *data,
					 unsigned int poll_ms,
					 unsigned int timeout_ms)

(but please, double check that there is no possibility to have a negative
 values there)?

> +				 poll_ms * USEC_PER_MSEC,
> +				 timeout_ms * USEC_PER_MSEC);
>  	if (ret)
>  		return ret;

...

> +	int irq_timeout_ms = 100;
> +	int timeout_ms = 500;
> +	int poll_ms = 10;

Hmm... I don't think we need those, esp. taking into account the difference in
the timeout_ms for different cases.

...

>  	/* Wait for the conversion to complete. */
>  	if (data->eoc_irq)
> -		ret = wait_conversion_complete_interrupt(data);
> +		ret = wait_conversion_complete_interrupt(data, irq_timeout_ms);

		ret = wait_conversion_complete_interrupt(data, 100);

>  	else if (data->eoc_gpiod)
> -		ret = wait_conversion_complete_gpio(data);
> +		ret = wait_conversion_complete_gpio(data, poll_ms, timeout_ms);

		ret = wait_conversion_complete_gpio(data, 10, 500);

>  	else
> -		ret = wait_conversion_complete_polled(data);
> +		ret = wait_conversion_complete_polled(data, poll_ms, timeout_ms);

		ret = wait_conversion_complete_polled(data, 10, 500);

-- 
With Best Regards,
Andy Shevchenko


