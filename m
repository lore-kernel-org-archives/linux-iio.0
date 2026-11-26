Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795703062;
	b=Z5ZIeHNbmfwbD1eNzkyx+h0DrJv+TI5ilbpfVRV73cEYZabVPr+CQAUQYj70Va4yGK+Q
	 uyKlTaa7S7GjO2iWfUPQyLBsAHH9bJs5Zp2fGAfR3LNSTr1MtVmwTDlfRMIgrEnj2I+k1
	 0Sr2Nx61ZQF6P78xpIrpVgvX+HXRgooABqWXsrTxCeRcQMqgdJfenEsZCgphdhKREBWd2
	 YpmoA6PYa3roImFzXpUIkFX+SlhSH0BI2yo3HelrFo716HTMqSdPhnY1Gu7tt5Nb+cADN
	 9Ejwe1WxifowJfHnsyx7wMdzg9Dc+LbXqQ0eqzaiMuyycP6MtxZVqOG7IkNCdrk+c0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795703062;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=YoQJi0E2u6KNMOZLeqYhtROWmRCICFOTpd4u2TPiQ0g=;
	b=qy4eW/hWUJx2jnpvTelrNFLe0RBFFwZqSuumCyy4BMThIQQvrEjTMKN1DfKd3a4DzYkD
	 WOqiq8GpirJZF691AKWuraysgof/7DM4zRIVv6MLvBa8pxr74u+b05EtJn4j7JhMVyxx+
	 niWGXjmqCzYJDb3Thgpw6yNDtoYCrxfOykMZ7UTrWsZbfIC1YZkCQkELDbJKiiUObCJPc
	 SpVJIQYDeaEmEO7XyvGDrWCf4TwEiLBgNbIMzhf+YasRsGLAMLG9fZ5tuYvu6yVdF2jM+
	 6/DLkrZWk6/1iQpUwKyLsNZsFr6qTfvyezFHDS56pcnRrG3J8GlXnrLuKgsFqhFjNKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZrLoLnLD;
	arc=none smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BB7606A31E;
	Thu, 26 Nov 2026 14:24:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14BB7606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZrLoLnLD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795703062; x=1827239062;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZvzEs1Hev41dOJbtnB6dy5Rb+UIgVmY7ywomSy9YJeQ=;
  b=ZrLoLnLDIae2txjRvi0gI3I50KYxXMCcbxsWbPS1RPE1TKoVdm/lHpwg
   gyFVlJLPt1LKEamYsB3HMECmUbpnjaWCWMMcz0jrvzK6rT2SZDQ3NZCjJ
   Lzw/ycoybQn8IzGwlrdhOK6FfQvNaD5JFMWLj1o6nBRV9VgOV4pMuJW3T
   gqiXah3n3Y+nWsXFIymz8gsIX6DlZL7VQ+E8MzwGq5xIXuAXhPwQ7b5yp
   penaSwE/juhBNyNvVczCVMRMebKQCL54DbQFdf1xX9j4z/unb9v0qbhGz
   ncjE7U2ZEHvvuwqLzcQZVADIjn1sQw8Orl0l/tSQE1hQ98Gldlh0KML34
   w==;
X-CSE-ConnectionGUID: GPgrVvKyQ+OCis2yKstzfg==
X-CSE-MsgGUID: kuStUjgoTbqJEHG/Ix14NA==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4622774"
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="4622774"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2026 06:24:21 -0800
X-CSE-ConnectionGUID: DYzGS5FnQ3WlEYVF3BIuGg==
X-CSE-MsgGUID: jYDRh+8CSbu+a/9a1IB+mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="12334045"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.208])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2026 06:24:19 -0800
Date: Thu, 26 Nov 2026 16:24:17 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: iasnezhkov@gmail.com
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, Arnav Kapoor <kapoorarnav43@gmail.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: inkern: guard fwnode_xlate with info_exist_lock
Message-ID: <awhBEfD6I5nakCKJ@ashevche-desk.local>
References: <20261126060615.63790-1-iasnezhkov@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261126060615.63790-1-iasnezhkov@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 26, 2026 at 06:06:15AM +0000, Ilia Snezhkov via B4 Relay wrote:
> 
> __fwnode_iio_channel_get() dereferences indio_dev->info->fwnode_xlate
> and invokes it without holding info_exist_lock. Concurrent
> iio_device_unregister() clears indio_dev->info under info_exist_lock,
> allowing a NULL dereference or callback execution during provider
> teardown.
> 
> Hold iio_dev_opaque->info_exist_lock with scoped_guard(mutex, ...)
> matching the rest of inkern.c, and return -EPROBE_DEFER if
> indio_dev->info is NULL. Since iio_device_unregister() calls
> cdev_device_del() before clearing indio_dev->info, seeing a NULL info
> pointer corresponds to racing right before device removal from
> iio_bus_type, where !idev already returns -EPROBE_DEFER. Using
> -EPROBE_DEFER also avoids colliding with the -ENODEV sentinel used by
> callers to continue parent or map-list lookups and avoids the named
> lookup -EINVAL fallback in __fwnode_iio_channel_get_by_name().

...

> static int __fwnode_iio_channel_get(struct iio_channel *channel,
>  				    struct fwnode_handle *fwnode, int index)

>  {
>  	struct fwnode_reference_args iiospec;
> +	struct iio_dev_opaque *iio_dev_opaque;

I see that this block is not so ordered, but even though, try to follow
the reversed xmas tree order.

>  	struct device *idev;
>  	struct iio_dev *indio_dev;
>  	int err;

...

>  	indio_dev = dev_to_iio_dev(idev);
> +	iio_dev_opaque = to_iio_dev_opaque(indio_dev);
>  	channel->indio_dev = indio_dev;

You ignored my previous comment. Why?

-- 
With Best Regards,
Andy Shevchenko


