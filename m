Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB12841B362;
	Thu, 27 Aug 2026 19:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787858934; cv=none; b=HQxJf3zqk5lnxnBa/zBr5w+RToXDFHN0jzEwWW25nJp50VwBmfuYhZfXEiThFnb1m/jsYoNtbds3E1CzP7Wsj/s1BBIPuELBVUWY6OCSWyWqv3jANeaiQcULy8zXO8ZeJKlLdp/B94E9QKy5rd2vCFg0/+2jWaQMbLW8n853OHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787858934; c=relaxed/simple;
	bh=G3S+OwHemyvuSDnBVz1pEn6/N7PHr63E7ozV78jh9To=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LgxLS64iNThBRLF8GAGHw4BpV8WwputlAGdkZYV9jLH5da00vHfOmPEPkqUF/Sidvsc/64rNQ9gnEiCakWyN5uzs6tet8IhspLTzH9XYgyB6I9gSU2ahZeObYL/U6dCSo051uZiSVzBfm+Ujcom0ox+xvGKmB/PP/fcSPNcSxGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W40nMLFt; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W40nMLFt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787858933; x=1819394933;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=G3S+OwHemyvuSDnBVz1pEn6/N7PHr63E7ozV78jh9To=;
  b=W40nMLFtzNqRIACfMNhoJs0f5Kb5aGUXsRF2dXDNIyrNnDKZMPwAKvEC
   IJxGmGGs4pCZu6tjATEMGrtY2kw4IoDk1F4VheG41E9Fs800v/v8e/D8b
   aMrJWr1ujLR/FsRv0DyhLdqkgG2nUKw/s41rgw2OwFtLx+DbXXBTEfxwH
   48yhA7rG1f6tskkyz2aoK4SXoybOtypyR8ZvTN/KDDd8PDmaxysqAQUEH
   nqzSwIoEa3Oz0/T3mD75CyEjB9hV9AQppUFpzI5ewT4aOj6WN/cn4vIg1
   S2WyWVaQODWUoiGcdDaUbr7fXrJaV7fIjMyZvso7D6DZyKBJK7fsa5PQr
   A==;
X-CSE-ConnectionGUID: 8nR9qa43QRO2NHVQ3rrcTg==
X-CSE-MsgGUID: BFmXTqP4QsC4ONSkvev0jw==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="92226816"
X-IronPort-AV: E=Sophos;i="6.25,247,1779174000"; 
   d="scan'208";a="92226816"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 12:28:49 -0700
X-CSE-ConnectionGUID: w5f7ByJuR9md6FUAClWBQA==
X-CSE-MsgGUID: kBhuMN3LSNi81H/FQPEFGA==
X-ExtLoop1: 1
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.125])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 12:28:47 -0700
Date: Thu, 27 Aug 2026 22:28:45 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Archit Anant <architanant5@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, andy@kernel.org,
	nuno.sa@analog.com, u.kleine-koenig@baylibre.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 6/8] iio: adc: ti-ads1015: Convert to managed resources
Message-ID: <apCP7TkGVZ3I4jFO@ashevche-desk.local>
References: <20260827172100.39176-1-architanant5@gmail.com>
 <20260827172100.39176-7-architanant5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827172100.39176-7-architanant5@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Aug 27, 2026 at 10:50:58PM +0530, Archit Anant wrote:
> Use managed resource helpers for the mutex and runtime PM setup.
> 
> Replace mutex_init() with devm_mutex_init() and replace the separate
> pm_runtime_set_active() and devm_pm_runtime_enable() calls with
> devm_pm_runtime_set_active_enabled().
> 
> This simplifies resource management and ensures resources are
> automatically cleaned up on probe failure and device removal.

...

>  	data = iio_priv(indio_dev);
>  	i2c_set_clientdata(client, indio_dev);
>  
> -	mutex_init(&data->lock);
> +	ret = devm_mutex_init(dev, &data->lock);
> +	if (ret)
> +		return ret;

This part is good and maybe introduced in a separate commit (depends on the
resolution for the below).

...

> -	ret = pm_runtime_set_active(dev);
> -	if (ret)
> -		return ret;
>  	pm_runtime_set_autosuspend_delay(dev, ADS1015_SLEEP_DELAY_MS);
>  	pm_runtime_use_autosuspend(dev);
> -	ret = devm_pm_runtime_enable(dev);
> +	ret = devm_pm_runtime_set_active_enabled(dev);
>  	if (ret)
>  		return ret;

This should be done with care. There were some changes lately that actually
moved from devm_*() back to regular calls due to some races in runtime PM.

-- 
With Best Regards,
Andy Shevchenko


