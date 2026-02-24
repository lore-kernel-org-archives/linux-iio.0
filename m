Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4283022652D;
	Tue, 24 Feb 2026 14:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771942517; cv=none; b=RpVscmdC5eFI4J013Vi0DA1+3BypE7x+0lTWh51djIVWL/c9C+ye3JpwXPdAMtoMcpe8Ad68DzsGPA58XXo0IoHwYrUAmEs6YyUVVsFBOMW+gtj0EBHU9ckg9xGCUC1NvgVPCF9BzFZ4vWxTcCEJ5zLx5sz9eO+6WRpW73u7Fac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771942517; c=relaxed/simple;
	bh=i6K68vL157C+mg55+2Wav9+cEYsejjAMFNBohRSLtA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bIxOyn8Foy+Lkb2akyJnMYAH+U5wGliDl/yFTlzAXHRJj1NLGlZyIjPKQPMVH7SRATyJgIKe5NNJJ+38M0stNeBqm2DE9yQhvb0H8vzyQ5yN/X3JSx4NhfPSveGb7nGPtiHajSHyG9E1fdZhdpzGfrvNLI1w/YB6UOU7J/v7fQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WVzd/o73; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WVzd/o73"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771942516; x=1803478516;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=i6K68vL157C+mg55+2Wav9+cEYsejjAMFNBohRSLtA8=;
  b=WVzd/o73C/NR/m/2ELOiXMJqZjnZHjV7aKmX0FoPg305RmTDpnRW/aYf
   /nuk9vn9VK5MTIl4t8z6GafDlfNZPfJLdT5PSGBCz2f2aB31qOCwH5mlw
   aJMWuE2gWupjZZMrWEOq5GboWeDXXqGNMdvPfNTZe7595C5lfPOWCPxqp
   ItzbIq6SYxT0N7PpGN3SjBMojJt+F2xtFYq9niHLorGMOt/9+k7oTeW98
   FDaNzhn/6yN1YOrdpHEC8R7sF3CEZhaWHdaCJQYZ/cu1hvVVmoZgVlkfm
   +vxc5CKZvflcxRvGZslQ9YI/T8Xz0qKHbMZ+DdjWHm8ulZpvSed1vCriq
   Q==;
X-CSE-ConnectionGUID: NdEvIuT6QOqo3qiXogyxMQ==
X-CSE-MsgGUID: eAFn87GdSZSiYVfWDsCQkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="72831329"
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="72831329"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 06:15:15 -0800
X-CSE-ConnectionGUID: r5Qwc0rSSHWwaq8vJxg8GQ==
X-CSE-MsgGUID: 8IchkQbTQjGTPe8BmMycnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="246488659"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.146])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 06:15:13 -0800
Date: Tue, 24 Feb 2026 16:15:11 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Cc: jic23@kernel.org, antoniu.miclaus@analog.com, lars@metafoo.de,
	Michael.Hennerich@analog.com, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: fix typos found by codespell
Message-ID: <aZ2yb8YFih2UuIAy@smile.fi.intel.com>
References: <20260224111744.55378-2-giorgitchankvetadze1997@gmail.com>
 <20260224122230.67426-1-giorgitchankvetadze1997@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224122230.67426-1-giorgitchankvetadze1997@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Feb 24, 2026 at 04:22:30PM +0400, Giorgi Tchankvetadze wrote:
> Fix various spelling mistakes in comments and error messages
> across drivers/iio/adc/, found by running codespell.

Thanks, my comments below.

...

> v2: expand to fix all typos across drivers/iio/adc/ (Andy)

Do create a new email thread for each new version.
Use proper versioning: `git format-patch -v<N> ...`
<N> = 2 this should be.

...

>  
> -	/* dummy read: restore default CH0 settin */
> +	/* dummy read: restore default CH0 setting */
>  	return spi_sync(st->spi, &st->msg[AD7887_CH0]);

Please, check the code and perhaps choose a plural form (depending on what is
there in the given register).

...

>  #define AD7923_PM_MODE_AS	(1)		/* auto shutdown */
>  #define AD7923_PM_MODE_FS	(2)		/* full shutdown */
>  #define AD7923_PM_MODE_OPS	(3)		/* normal operation */
> -#define AD7923_SEQUENCE_OFF	(0)		/* no sequence fonction */
> +#define AD7923_SEQUENCE_OFF	(0)		/* no sequence function */
>  #define AD7923_SEQUENCE_PROTECT	(2)		/* no interrupt write cycle */
>  #define AD7923_SEQUENCE_ON	(3)		/* continuous sequence */
>  
> @@ -39,7 +39,7 @@
>  #define AD7923_CHANNEL_WRITE(channel)	((channel) << 6) /* write channel */
>  #define AD7923_SEQUENCE_WRITE(sequence)	((((sequence) & 1) << 3) \
>  					+ (((sequence) & 2) << 9))
> -						/* write sequence fonction */
> +						/* write sequence function */

Nothing is unveiling that the author of that code is French-speaking :-)

...

>   * @chip_info:		chip specific data
>   * @spi:		SPI device structure
> - * @vref_mv:		voltage reference value in miliVolts
> + * @vref_mv:		voltage reference value in milliVolts

millivolts

With units there is a good article on how to spell them in different occasions.

...

Have you run it against Kconfig in the same folder (and subfolders if exists)?

-- 
With Best Regards,
Andy Shevchenko


