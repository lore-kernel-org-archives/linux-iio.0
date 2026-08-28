Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760553D649F;
	Fri, 28 Aug 2026 07:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787903623; cv=none; b=F94+UUADk77B9/nRWJ+UO8zSFZesSXS/ShJGun5cnc/soFbT9evu0Fa6oP8+f15a10hBGOME5qsyFQwe6Q/5zI9FiviOj9afAfJPTe+Jfxp2ocVGfp55ELVKw1hWmtdAXwG1f2azK9z8+5kaXffelsBafy7ebqWyW43txBwKgbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787903623; c=relaxed/simple;
	bh=IRcIwXBV51tZ7X/Y6eKfnkluQLF8tNuFssVt6xn9A0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C090+ZpX28BzMxlirBDCg6t3lysCb7c8pJKsiwrnvIlb+V6niFEvgHKvPnZYdDN2G0u+Fzgt5GuFF75wKQwMwVmKGCQhj9xhaoGy3Ao8igvs69++0sLb8NiciDh51AZ1HET/k7B9Yk4dDTbqyQEguTgzLlNOZc1YKEpUzzJGYto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N6dLrYgn; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N6dLrYgn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787903623; x=1819439623;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IRcIwXBV51tZ7X/Y6eKfnkluQLF8tNuFssVt6xn9A0o=;
  b=N6dLrYgngJzlV/vOlaC6y1EP9M4+a3WKDfNkHzgeRqUVS0prWYSd31sv
   LONOuI0Fo/ORPPMiEAssEkmKjR0MMExKuvxKGIWV72sfYsvmqanWeuWpe
   WBGNrWT7qNXxvnOQwEIF+yEweqYC3PV/R6XvBlUfU41T2MSvyau7Fp+VM
   IFvIL0PImVynMxjJrTMtxqD9EnMCtAx/eShE4kFqUGdCQb8FUVQ2lhLnn
   oogU1OXjg1giS36Z039PJ1jngnF+Tw9Qgy+R+e9PwDs6/bJoQKprnkXrX
   6r1LJdON/JqCMWnaUrhJryTbviAXXlRWfME8cEQJIN20RRVXPeCSBrquM
   w==;
X-CSE-ConnectionGUID: V1evqJ3lQwCdiw8XYj7G/A==
X-CSE-MsgGUID: GXGnzQWtRwCOExWFFTiYBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="99570013"
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; 
   d="scan'208";a="99570013"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2026 00:53:42 -0700
X-CSE-ConnectionGUID: JMPHJ93sSdyU2e6TomeyhA==
X-CSE-MsgGUID: 5yDrRcg6Rei3KdDA9G936w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; 
   d="scan'208";a="267499136"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.34])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2026 00:53:39 -0700
Date: Fri, 28 Aug 2026 10:53:37 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <matti.vaittinen@linux.dev>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Mehdi Djait <mehdi.djait.k@gmail.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] iio: light: rohm-bu27034: Fix infinite delay on
 error
Message-ID: <apE-gauHWlJO8-5X@ashevche-desk.local>
References: <cover.1787901813.git.mazziesaccount@gmail.com>
 <7f0d8efb3578cd4f23a7c70fa4a8f7a967c9df8e.1787901813.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f0d8efb3578cd4f23a7c70fa4a8f7a967c9df8e.1787901813.git.mazziesaccount@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Aug 28, 2026 at 10:40:36AM +0300, Matti Vaittinen wrote:

> When reading an integration-time fails, the code will use error code to
> compute the sleep time.
> 
> Fix this by using the smallest integration time as a default if
> reading fails.

...

>  	wait_ms = bu27034_get_int_time(data);
> +
> +	/*
> +	 * If reading the integration time fails, default to the minimum so we
> +	 * don't lose samples. This may waste CPU cycles, but as a hardening
> +	 * against theoretical, once-in-a-blue-moon error, this should be Ok.
> +	 */
> +	if (wait_ms < 0)
> +		wait_ms = BU27034_INT_TIME_US_MIN;
> +
>  	wait_ms /= 1000;

With the above being open coded the _ms feels not right.
I would expect the TIME_MIN to be in MS from the start
(and for the consistency's sake with the below) and having
all this to be written like

	ret = bu27034_get_int_time(data);
	if (ret < 0)
		wait_ms = _MS_MIN;
	else
		wait_ms = ret / USEC_PER_MSEC;

>  	wait_ms -= BU27034_MEAS_WAIT_PREMATURE_MS;

-- 
With Best Regards,
Andy Shevchenko


