Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F7C341AB6;
	Mon,  4 May 2026 08:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777884103; cv=none; b=ozWZCQf62V+7yFDGI1xKOOXJcv09ErqV0xcvyppAHI4y8YHnMjjGjSYZaAFpyJc8g9AlW6rxrB0FLEy2DjNCXbKYqrfj1hW72wwHhst4f07qjYiWIldTlkhBICLoDKfYXmPcyfP1i1c3QGTcq6lg1TjBOCUk9GHG8su8HyO2sY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777884103; c=relaxed/simple;
	bh=Xikxf4pzjKPHBUXgTEBaZ9iyFpSR3Xz2rwoKi+8qVgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YxODL6eXZLvojL0xSAi+QAiyI3JZUEOWsgdE3Bhmdra0ydF0V3Q9zcS8pzUGta8obJvqur9TLqSm3twDebGAXfjiNy6Nc/MyfE9m5UUdO9DcERzgVMzQez1K3uMTTxy5kmIPEwW3liWFXjarFU9I39DfmkQBqIDjAWFzT3di8No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nxLtSkuX; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nxLtSkuX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777884102; x=1809420102;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Xikxf4pzjKPHBUXgTEBaZ9iyFpSR3Xz2rwoKi+8qVgg=;
  b=nxLtSkuXHbjhc3lJShYZz+Ixqr91EKd9OhXPSkl0KgzkwsNEDjuKwdW6
   +zzOl5u7FH3MwamfgpxVGbHi0CzCQQXFBG9VOf2JiBZoLZSYgZAZPdI39
   az3z9lcg8FzZ4RRGcMDOoN9jra4n+be1pT9+onOG+GF4sbpqpK7lFqnCS
   H0be/zwqIHRVxoVdq3GY9dyLpmcLf2iuZ5vl5nOcP46QLHbwiYzZ+qA/O
   8V1JyIpwCHNz3ltkZGuuUAn4nNlbJ6eBbIukfOHypNd7IPcw6+ltu7eM+
   UCxrjOGgi7iQsj9Qwqi4WcUPNuwkG4o2BdB1a5PqB6rDiET2upQPcBqka
   Q==;
X-CSE-ConnectionGUID: O50RuWnGQdyCAJnoBCz7Dg==
X-CSE-MsgGUID: r5VLht9dSROkoE+KOSphBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11775"; a="89324012"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="89324012"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 01:41:41 -0700
X-CSE-ConnectionGUID: 9wuIIt8HRU6OgsKqGZmWhA==
X-CSE-MsgGUID: 5T17v+XdTxuuFExqxi3iqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="265807827"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.78])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 01:41:37 -0700
Date: Mon, 4 May 2026 11:41:35 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, mingo@kernel.org,
	christophe.jaillet@wanadoo.fr, nabijaczleweli@nabijaczleweli.xyz,
	kees@kernel.org, kyungmin.park@samsung.com, k.wrona@samsung.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 9/9] iio: ssp_sensors: reuse embedded RX buffer for
 SPI transfers
Message-ID: <afhbv6ObQG6TVMLI@ashevche-desk.local>
References: <20260426091710.3722035-1-sanjayembedded@gmail.com>
 <20260426091710.3722035-10-sanjayembedded@gmail.com>
 <20260426153540.3d43a085@jic23-huawei>
 <B6831FB9-2E1A-4A55-B29A-A44371201849@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <B6831FB9-2E1A-4A55-B29A-A44371201849@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, May 03, 2026 at 07:47:03PM +0530, Sanjay Chitroda wrote:
> On 26 April 2026 8:05:40 pm IST, Jonathan Cameron <jic23@kernel.org> wrote:
> >On Sun, 26 Apr 2026 14:47:10 +0530
> >Sanjay Chitroda <sanjayembeddedse@gmail.com> wrote:

...

> >>  	case SSP_HUB2AP_WRITE:
> >> -		buffer = kzalloc(length, GFP_KERNEL | GFP_DMA);
> >Is there any chance that GFP_DMA marking is needed?
> 
> As per my understanding, this must be legacy flag as there is no direct use
> of any dma_* API. marking should be redundant and safe to drop.

But what does this case with HW? It seems the use of this memory is in
spi_read() and SPI framework for sure does dma_*() APIs. Would it be
problematic?

> >> -		if (!buffer)
> >> -			return -ENOMEM;

-- 
With Best Regards,
Andy Shevchenko


