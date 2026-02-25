Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D4F1BD035;
	Wed, 25 Feb 2026 16:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772036111; cv=none; b=F3Gkj9ddbblNwA1aQ0EL1RvkxmiqsdnQaCwTC0bVNZAtQOUUjfAQrz6BURaL4WrHc7euptE1KmRL8EbAK3nyxrAdoxoL1IuUZ/ulz+QIJALy/SZFyBMTX7kd0EpOsrwdLcdubw0z3GKLLUUIDjAzuvhztvB5qW8ork1HBu5SPbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772036111; c=relaxed/simple;
	bh=GT2zKiX0auJZXEiHl1p8CzoSE3b8inw+pAaSWF0GAcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J0DwLwyC+08FzFpengy+7dr8/FQ93M99fa/Xk23GNvRTGfjh8JZk53XwXk3VgslEr4htAvsaorNZuF2aphTU7itPO9EpT9KxL9ngEXWUZif2se8AtRuYaUptW8J4myDZkQBYUSCEEUTPlPm087+fGWo9oSwXCAT4jQ8awMZfyf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eyPOL5Fl; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eyPOL5Fl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772036110; x=1803572110;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GT2zKiX0auJZXEiHl1p8CzoSE3b8inw+pAaSWF0GAcE=;
  b=eyPOL5Fl6fM/dRZo05ydqwtlQnuALZk88Zpmpr+a8RJqoQpvR7NGCSrs
   Q7o5SdG9bokl09qJPVUDVwdA6hOFs9VhoMs4jVcrrjX22XhO8APxFdSGP
   grhClXkNQDQV8YcKKoO7HZ4zqdTfISvHMEv12m3rpN5NnbaVvk9wu+YsE
   iJGFZ+e5Jl98hN6vjPE90jNwxHM3gubw3omFXoFOvOw0zB0W7PJh6eJTQ
   C3vg8OcWsxT8iWrSdDvG/uFK9wA7HO3CVZ7xf7dwaoqlrpCAeU4/kqy5J
   krFc2at48Yv4re/c8J1emRK6C9SyQqTCMHqVS751Ceh4zrHSJlwP9y9wx
   w==;
X-CSE-ConnectionGUID: V9Gf+VIqQCOT4I970vQmDQ==
X-CSE-MsgGUID: odLx5dxFQ46pk9bw0ayKrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="75685130"
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="75685130"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 08:15:09 -0800
X-CSE-ConnectionGUID: iFp2uRRUQyWXzY5M4KxPcw==
X-CSE-MsgGUID: FEcC9zYRS3ey7+tMU/c2sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="216161341"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.71])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 08:15:07 -0800
Date: Wed, 25 Feb 2026 18:15:04 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/6] iio: use dev_err_probe in probe path for ADI
 drivers
Message-ID: <aZ8gCD3YXvrNscQo@smile.fi.intel.com>
References: <20260225150615.274078-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225150615.274078-1-antoniu.miclaus@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Feb 25, 2026 at 05:05:46PM +0200, Antoniu Miclaus wrote:
> Use dev_err_probe() consistently in the probe path of several ADI IIO
> drivers. This simplifies error handling and ensures proper logging of
> deferred probes.
> 
> Each driver is updated by introducing a local struct device variable to
> simplify repeated &spi->dev / &client->dev references, and converting
> error paths to use dev_err_probe().
> 
> Drivers updated:
>  - adrf6780
>  - admv1014
>  - admv1013
>  - adf4377
>  - ad7293
>  - admv8818
> 
> Changes in v3:
>  - Squash the struct device variable introduction and dev_err_probe()
>    conversion into a single patch per driver.

Why? Maybe my comment was unclear previous time.

The idea is to convert to short dev the only lines that are not being touched
by the second (dev_err_probe() conversion) patch.

-- 
With Best Regards,
Andy Shevchenko


