Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795517480;
	b=2TnS8Rya4rv+7L+Z3mAcYhv/u2QvoMSbvoPZg/BGopM1irgAe9jfkd4jcLydLeFix6Mj
	 QLtHPtVFPTgJqIg/OSHX6ZIca1ANsEQwD3kqa7v3+d6GEoFG6ZxiSpCgNWJaD+K50sFZm
	 jS0yGJpOEGjDesz7m2TrY0hZgDi9gy0OFWJiBHvwoMHumAdbsl8L70iyWrS+DmsUcYC/6
	 PcX0D89rlqQJC99xn5aT31Nr0McVLrH9owLkmfR0UPdk8L5LAyas9mWQImCTIKOiTF0EM
	 VOOPPFbzrWuh1AcjO/Ki8BAlsqSNlMMvGl1xg7ZC8qDoNQoIR0TWk6N7zehtBkNIJXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795517480;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=4zO4rDfr4nG2QMVUenWO5tqTmd6cL22mP2XVe5vj/fI=;
	b=2Fs4YRJD7nVg9IMeIOCKwhpkATQOv86K1abjXZwDVxQfyJzm4kjQXuFNEWlBqUjTTN+c
	 ZRBerDXgRfHDpUCZZWt2L8Ts2JBVxaQJVYFOxtRID+XkXAWxBp/2duUmIfsOsNEl/NUUC
	 37TDkSnYehh5pkM6CWNPXcnnhmMItMP/9UH4XHy4p2j2U7q8pCJqp3Y+l5EaXaJ5sHZMh
	 D0lo6fkDaCatHJ4bXU1wrqOb+2DMT7uAgHLUfkEznNqFdpSqW/NDpaFAIMF95pYM3PScq
	 DZS4jmym8NK7FFafuLmIGzOEGmJ3/X3Of6/ZFBUcmhTM3NB2GRaGMWHkL6u210zNLrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IMFYM5mw;
	arc=none smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1446E606A321;
	Tue, 24 Nov 2026 10:51:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1446E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IMFYM5mw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795517480; x=1827053480;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AWg78TjOm1CVOXHavM5ONlcLRv970rnOjuXn9t1XkSk=;
  b=IMFYM5mwpZb2nrrcxH5uMBaDl0njEydg0ELaCPAy/CvdHcbkFeezlBGS
   9mT/53VktlbWlwLHdptIQ9CMJtQiqXnREoGBnGTGFnKMCcnKMtUeRWMqZ
   U7Yz2w6XPmd0bqq7jsePa9SHQiS5kdUP0zYkWuFueTE2td0RleltlRZBI
   AGYP9n30t7qCo6bfxBnlJ/L+Gv4DX5lgximrSGZJSCV+meH4UwvcHVEcM
   ddPt5EBYtjTSf+Clq9Ltu/brMe4ZacANF9hzpTU3Hil5K5Rvm3wOcBv/8
   mxW78bxdaPUkYymSns6zqzcHBJrkIqHvQ2SJx/l7AyjZxi77BhAnOM2yk
   A==;
X-CSE-ConnectionGUID: WCwOmDcZRomE/Ugobeq03g==
X-CSE-MsgGUID: D4Uk31zgT72w9eUPtv4HgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4210813"
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="4210813"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 02:51:19 -0800
X-CSE-ConnectionGUID: 88S0v+WJRn+EG/3x2OL0zQ==
X-CSE-MsgGUID: fxmCzNynTWqHqrNvjMMKaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="11428883"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.125])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 02:51:17 -0800
Date: Tue, 24 Nov 2026 12:51:15 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Joshua Crofts <crofts@kernel.org>
Cc: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rupesh Majhi <zoone.rupert@gmail.com>
Subject: Re: [PATCH v1 1/1] iio: core: Split debugfs routines
Message-ID: <awVsI5KfsvEruJYG@ashevche-desk.local>
References: <20261124094502.557175-1-andriy.shevchenko@linux.intel.com>
 <09328c36-a32f-488b-a2c9-76fab784d259@kernel.org>
 <awVq-mE1H2g01yS4@ashevche-desk.local>
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
In-Reply-To: <awVq-mE1H2g01yS4@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 24, 2026 at 12:46:22PM +0200, Andy Shevchenko wrote:
> On Tue, Nov 24, 2026 at 11:17:01AM +0100, Joshua Crofts wrote:
> > On 24-Nov-26 10:44, Andy Shevchenko wrote:

...

> > > +#if defined(CONFIG_DEBUG_FS)
> > 
> > Veeery small nit, but why not #ifdef CONFIG_DEBUG_FS? It's not
> > as if you're checking for multiple defines.
> 
> Or even IS_ENABLED()?  Let me check if we have a precedent in IIO, I will use
> then the same or most used style.

FWIW, iio core uses exactly this form for DEBUG_FS test, so for the consistency
I leave it as it, and if required we can fix this later.

$ git grep -n '^#if.*DEBUG' -- drivers/iio/ include/linux/iio/
drivers/iio/gyro/adis16136.c:66:#ifdef CONFIG_DEBUG_FS
drivers/iio/humidity/dht11.c:87:#ifdef CONFIG_DYNAMIC_DEBUG
drivers/iio/humidity/dht11.c:235:#ifdef CONFIG_DYNAMIC_DEBUG
drivers/iio/iio_core.h:19:#if defined(CONFIG_DEBUG_FS)
drivers/iio/imu/adis.c:227:#ifdef CONFIG_DEBUG_FS
include/linux/iio/iio-opaque.h:73:#if defined(CONFIG_DEBUG_FS)
include/linux/iio/iio.h:1010:#if defined(CONFIG_DEBUG_FS)
include/linux/iio/imu/adis.h:573:#ifdef CONFIG_DEBUG_FS

...

> > Static here but not in the header file. Same goes for register_debugfs().
> 
> Oh, how does it compile?

Will be fixed in v2. I'll wait a bit and send an update tomorrow.

-- 
With Best Regards,
Andy Shevchenko


