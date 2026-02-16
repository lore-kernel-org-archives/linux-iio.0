Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA27E2F12B7;
	Mon, 16 Feb 2026 10:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771236213; cv=none; b=m/63WzjeNaxrqEFBGNgA1vyjmNu3znBd5eJCKSOA4a2M4xlCtZjxYhlT7kmnnzHBsxataLk4ZsYMjmzomhVdqU5J0H8Twrzuparc8zCQgijZOh03av9dg7+CH45DDo6WFiRTvctYXVCBYzSjdr2ph2ZIwGGxlHdEe4wUB61sW18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771236213; c=relaxed/simple;
	bh=8tudBQOW6yv7afWToLxNK1fayOXwgxK/lX+X5lS0Og4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bo57R6MNFKRJcrrXP/n+y0XYpDif9LtQ9RdtEltNAVg8da1RscEtSa5KRt5HjtDA2wFjHRu7LLGCo5bKZFtn9fCq6gaXV+xZfikxy98RyOJHWQVNW2WpxSY6rQZZSy7zqhJFErZFgZYsysUGpBJhG7gfCjssMAUGWmRonyoXcRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h9XTzawT; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h9XTzawT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771236213; x=1802772213;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8tudBQOW6yv7afWToLxNK1fayOXwgxK/lX+X5lS0Og4=;
  b=h9XTzawTak8KMXEqUN7VDFfCCudphhdizumFA74LyouA+BcSSwrMA5RP
   XX1NAq7KU06TRv9EpzWD3XdZqQOteysGC20AAtdxPhr07qbwMMZBJBrdU
   d/m0TN5tZ6rJ4t4iMJjZRm/ySMXeJ4SGpRoUSkdEMum9JjQi/uxiwwIV8
   pmdHd+z7PoNB7D+UC18TIkbVwJJoFHoIphfdRSpl2xAqJ/MPMnH8ePAv8
   2ZKOBndkYwX/yPhpwj04iIg/5DUiFWyNdBY5JM7db+J9RemMNOqNus7ot
   SRhgyFEZMRqC1hNve8I/VtFFrkOoOst6S2oxps/Iy/Jnwm2zKaICdl2R4
   Q==;
X-CSE-ConnectionGUID: qP5Za+WmQ9W+yRV4SGw4Og==
X-CSE-MsgGUID: 1nKjTSD6Tnyva7ho1i4+nw==
X-IronPort-AV: E=McAfee;i="6800,10657,11702"; a="59881362"
X-IronPort-AV: E=Sophos;i="6.21,294,1763452800"; 
   d="scan'208";a="59881362"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2026 02:03:32 -0800
X-CSE-ConnectionGUID: NWrMh1pGQN230qJtGIxwng==
X-CSE-MsgGUID: 8eryHReJSnCn6LAEGJvdtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,294,1763452800"; 
   d="scan'208";a="212116803"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.188])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2026 02:03:30 -0800
Date: Mon, 16 Feb 2026 12:03:27 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andrew Ijano <andrew.ijano@gmail.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH next] iio: sca3000: simplify with
 spi_get_device_match_data()
Message-ID: <aZLrb943-fnkyB7s@smile.fi.intel.com>
References: <20260216095110.1062611-1-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260216095110.1062611-1-harshit.m.mogalapalli@oracle.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Feb 16, 2026 at 01:51:05AM -0800, Harshit Mogalapalli wrote:
> Refactor each sca3000 variant with it's own chip_info struct, update the
> sca3000_probe() to use spi_get_device_match_data().

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

...

> -	st->info = &sca3000_spi_chip_info_tbl[spi_get_device_id(spi)
> -					      ->driver_data];
> +	st->info = spi_get_device_match_data(spi);

> +	if (!st->info)
> +		return -EINVAL;

This is a dead check. Just make it a requirement and drop dead code.
The support of a new HW will be assumed not tested at all if there
is no driver_data.

-- 
With Best Regards,
Andy Shevchenko


