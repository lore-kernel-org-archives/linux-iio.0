Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CC228DC4;
	Tue, 10 Feb 2026 15:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770735614; cv=none; b=sSsH6SDPwa4W8hJ77rIvEPTv8cle/boH+Neq9sR/iIK7PhU9mrGHWcGjs0yJBM2pXD+/ro1cGpLshvDqcZIEsEoriSd0JkZfjurHDcowdsXrK507ULX7NFeJYxUVTOzqgaAe/9VjLvhBm0yuNwKsdHYLqlgj6p8+gNJzHXVNh5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770735614; c=relaxed/simple;
	bh=5fxG3AN5kBshZOmolvQD2/FQYXT5f0YL+r915QIR30U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pWSkrx+raE21fsGop//kFpscSdIOZeUtiAek3TIGv89y9v4HEIMHHrksotEG/78l59ZW4uuB8AVIsgbj7Wgy5BUyoPrhBfqUryq0Q9YUwdvbYKCXATLobXEigifhfwYB+IU0EurR1oyhdM6Qg07epRCKKRojaK5ZDCiKF5qX36Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H/SpxpiD; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H/SpxpiD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770735612; x=1802271612;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5fxG3AN5kBshZOmolvQD2/FQYXT5f0YL+r915QIR30U=;
  b=H/SpxpiDzIdxalEvlN5D5fbMRpPlwYvtILQAU4qXXlFn3Dfw/Sq8MFEs
   goAx9ftSsbEH+wUDfJl/GQq+UUKM6sjiTM4ucEh3g+AG9tIxyxjZEcdq5
   etZAklHgi3PuLHWQZ7QSGb/aQmc4Xad+3YQ7uhf0tW8PK2WHA9u5redDv
   GdTTpHJTQdk/FytGjPjCfqHwudBRtD+BqvrcAU0xYoUciN/d6ZrfXHONA
   /VkddshZMt/nV4T50D/q6Tq8fZSs8HVnnr9p24k2GoDv7+aAEVUpYfIdg
   tdSDBEWTjSxg7AMoKIztQ+3jJCxCZPkwixl90B8RAKCjyQVa261mB6i1/
   Q==;
X-CSE-ConnectionGUID: lxKK5nqWS3eqqOsAuH5oNA==
X-CSE-MsgGUID: u0NVKiE2Rtmcv7FlReuIYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="75488965"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="75488965"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2026 07:00:12 -0800
X-CSE-ConnectionGUID: U3jk4mctSAKorE5ReEzO9w==
X-CSE-MsgGUID: n48koewPRRuroLH6AcmlfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="211430915"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.39])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2026 07:00:10 -0800
Date: Tue, 10 Feb 2026 17:00:07 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Tomas Melin <tomas.melin@vaisala.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 5/6] iio: adc: ad9467: simplify device pointer in probe
Message-ID: <aYtH96TZ7Wwcd1QZ@smile.fi.intel.com>
References: <20260210-b4-ad9467-optional-backend-v7-0-7a590ffe02df@vaisala.com>
 <20260210-b4-ad9467-optional-backend-v7-5-7a590ffe02df@vaisala.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210-b4-ad9467-optional-backend-v7-5-7a590ffe02df@vaisala.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Feb 10, 2026 at 10:53:38AM +0000, Tomas Melin wrote:
> Create alias for the device pointer to simplify referencing
> and keeping syntax and column width shorter.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

Some nit-picks in case it will be a new version or Jonathan will be keen to
tweak it.

...

> -	st->pwrdown_gpio = devm_gpiod_get_optional(&spi->dev, "powerdown",
> +	st->pwrdown_gpio = devm_gpiod_get_optional(dev, "powerdown",
>  						   GPIOD_OUT_LOW);

I would dare to make it a single line.

>  	if (IS_ERR(st->pwrdown_gpio))
>  		return PTR_ERR(st->pwrdown_gpio);

...

> -		dev_err(&spi->dev, "Mismatch CHIP_ID, got 0x%X, expected 0x%X\n",
> -			id, st->info->id);
> +		dev_err(dev, "Mismatch CHIP_ID, got 0x%X, expected 0x%X\n", id,

> +			st->info->id);

I would not touch the second line as it makes a logical split.

-- 
With Best Regards,
Andy Shevchenko


