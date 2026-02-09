Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDED83783DF;
	Mon,  9 Feb 2026 13:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770644098; cv=none; b=LhTrq6tA7h9WM4Z/PcoEoBqHWsi/CofD/Q79sGZS2sSP0gFLMPBDcnPo1kPduCzQtbKTFt4mnFC8gZE5XxkN9ZgmgLPoJXQEylvVIg8+ShA/gUFaM/Wal5SKmJJB9jC0VO0u0b5LLq2UYDsB3/o59NtWb6XwuOFwVUM5OJJOdz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770644098; c=relaxed/simple;
	bh=4NVGnLCvihM8RpL+U4Wly/yeYMKYk2N8eJygjiUGons=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p7puwrOsVAD/oQ0IgWqVZP8WaCi/trfXMLF8cqCO8VmNpE2anrPwtIOftsnhF+zecNctqfcDPvuiEhPa8XuV419ul0EczXpvY687f5lF0vyT82ZFAiBfrFu4gm0Kg73e4n0JqAXrBRONvjKirhhYddgYVPHBiARud4ZtHn7ERGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pz9m+Ucx; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pz9m+Ucx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770644098; x=1802180098;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4NVGnLCvihM8RpL+U4Wly/yeYMKYk2N8eJygjiUGons=;
  b=Pz9m+UcxAQtK4Cb6PzrdZVW8dsUwOKMOVQ2m9wv8L/eEqo4yqh7g8uFr
   80tZanEivnaq4q/1koCV9h1ImQHh9m0N/NhDI0Gc4GAIpLH0GQ7fYHT0W
   AJgtcDnVI/RSBaAGSq7J/avTquDTDoO1u/8Vs/xKw+reEYRnBPp6V17Sw
   ErbLoAFwD34+0uqSAAojow++00JbPgOoh3Z3NwEgLvTzBbdLfEPa/s/JM
   EycmZsvZGE6y9C7hpBxpGhxnWhHujIKMhrU9cW0ZBdTaVFNU+lnH4YJ6N
   434YdlHPv2/nns6yhwinT3bv98Dpk8bKjz3c+xrdqD3xyGyHD5HrfXRLR
   Q==;
X-CSE-ConnectionGUID: Oq5yvRdhTZCgjle6kUPODQ==
X-CSE-MsgGUID: cGa2V4BxRliBVUrka8FyvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="71648011"
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; 
   d="scan'208";a="71648011"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 05:34:57 -0800
X-CSE-ConnectionGUID: L0jSf1SrQhKNfR16h0W90g==
X-CSE-MsgGUID: mF5LSICLTEmYHIer0wcz3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; 
   d="scan'208";a="211200382"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.128])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 05:34:55 -0800
Date: Mon, 9 Feb 2026 15:34:53 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Linus Walleij <linusw@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: gyro: mpu3050-core: fix pm_runtime error
 handling
Message-ID: <aYnifcPT5SL7blZT@smile.fi.intel.com>
References: <cover.1770636034.git.antoniu.miclaus@analog.com>
 <0309164453650011ec4d72276c8386edf1bbb88d.1770636034.git.antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0309164453650011ec4d72276c8386edf1bbb88d.1770636034.git.antoniu.miclaus@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Feb 09, 2026 at 02:02:16PM +0200, Antoniu Miclaus wrote:
> pm_runtime_get_sync() does not check its return value, allowing the
> driver to access hardware that may fail to resume. Use

Try to make lines more filled, this can be achieved by moving "the":

  pm_runtime_get_sync() does not check its return value, allowing
  the driver to access hardware that may fail to resume. Use

> pm_runtime_resume_and_get() which propagates errors and avoids
> incrementing the usage count on failure.
> 
> In preenable, add pm_runtime_put_autosuspend() on set_8khz_samplerate()
> failure since postdisable does not run when preenable fails.

...

>  static int mpu3050_buffer_preenable(struct iio_dev *indio_dev)
>  {
>  	struct mpu3050 *mpu3050 = iio_priv(indio_dev);
> +	int ret;
>  
> -	pm_runtime_get_sync(mpu3050->dev);
> +	ret = pm_runtime_resume_and_get(mpu3050->dev);
> +	if (ret)
> +		return ret;
>  
>  	/* Unless we have OUR trigger active, run at full speed */
> -	if (!mpu3050->hw_irq_trigger)
> -		return mpu3050_set_8khz_samplerate(mpu3050);
> +	if (!mpu3050->hw_irq_trigger) {
> +		ret = mpu3050_set_8khz_samplerate(mpu3050);
> +		if (ret)
> +			pm_runtime_put_autosuspend(mpu3050->dev);

> +		return ret;
> +	}
>  
>  	return 0;

These 4 LoCs can be replaced with

	return ret;

>  }

-- 
With Best Regards,
Andy Shevchenko


