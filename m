Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FA934753D;
	Sun,  8 Mar 2026 20:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773002575; cv=none; b=LrYb3nCfpbT4rNes7P/m9d9iPYnudERTvXcdp/mz/PuXw2QH/BR+Rpz80Cd19Yh9dHjbut21A+QInf0VuulomQ9SKWpqd+4/XeVaOi52ioU2VU8HqYh1D0Od8kpA1qeMP1Og0CVlPeqn1LKD/Kx6Mwntbrl1/rrs96I++7syOUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773002575; c=relaxed/simple;
	bh=jt1ICJYi76blF97nYqOfpJyuZaLpT+EGwVJFkOQelec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YDJRtMwlb2aYQCquWVdD5M/Wn99Yb9ILYLKmW2D+0vaVM/hwnIxTwbWaEGJoETZbAzj5eWS7ktdgLCA3Y6ez/PqC2HA+42+dJw3eUbm8MGNAvkxCOKEDVmFXbQE5eIrclEGUKGCJCzyEGZaxghkh0HBtd2PVCFvZbf/4kq1rrAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pm5rnxXG; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pm5rnxXG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773002574; x=1804538574;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jt1ICJYi76blF97nYqOfpJyuZaLpT+EGwVJFkOQelec=;
  b=Pm5rnxXGGPtwak//j08qClwLgNi8KCAqaI/yyT1RKYOAN9zhE7A6FqHK
   NocYcgahMLqUflwn3jeN3rL+1Iam1cU+cfEZC9ukJx8Ejrlt99htJ1zP5
   /nfaaUFV54kz+/2D84IW8S2mV9xR6WaTtIfDql97XCTC3FHpBjkWumy3g
   GKghrBa1anQhgcE6qIUl4ffLlq0VH0IeptJyjRzRvLj/m4J5cW4H5xLKV
   G0i53c4WXEfMYZLxukLcPJdqXtnKf+7CMcQtimGC9ARKdycUMwrW+IfMv
   IBkeacUilbI4DZaOtAzBFUXSxBOzayKv7hJrBK5F9djxZq+RQSJEwqSk8
   A==;
X-CSE-ConnectionGUID: mnFPH28VSUqPuSadPtTJXg==
X-CSE-MsgGUID: HyTB8zG7RxaMPTRS598GwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11723"; a="73053529"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="73053529"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2026 13:42:53 -0700
X-CSE-ConnectionGUID: OfhoPhKJQkOOE6GFSkFoFw==
X-CSE-MsgGUID: tyHOXe+HSCqQp4twuHuIsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="216550018"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.83])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2026 13:42:51 -0700
Date: Sun, 8 Mar 2026 22:42:49 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ti-ads7950: use
 iio_push_to_buffers_with_ts_unaligned()
Message-ID: <aa3fSc8UnOMis3li@ashevche-desk.local>
References: <20260307-iio-adc-ti-ads7950-declare-dma-buffer-v1-1-79b1309338df@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260307-iio-adc-ti-ads7950-declare-dma-buffer-v1-1-79b1309338df@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Mar 07, 2026 at 03:15:55PM -0600, David Lechner wrote:
> Use iio_push_to_buffers_with_ts_unaligned() to avoid unaligned access
> when writing the timestamp in the rx_buf.
> 
> The previous implementation would have been fine on architectures that
> support 4-byte alignment of 64-bit integers but could cause issues on
> architectures that require 8-byte alignment.

...

> -	iio_push_to_buffers_with_timestamp(indio_dev, &st->rx_buf[2],
> -					   iio_get_time_ns(indio_dev));
> +	iio_push_to_buffers_with_ts_unaligned(indio_dev, &st->rx_buf[2],
> +					      sizeof(u16) * TI_ADS7950_MAX_CHAN,

sizeof(*st->rx_buf) OR sizeof(st->rx_buf[2]) ?

> +					      iio_get_time_ns(indio_dev));

-- 
With Best Regards,
Andy Shevchenko


