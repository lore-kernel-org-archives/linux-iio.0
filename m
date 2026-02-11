Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5071B4F2C;
	Wed, 11 Feb 2026 13:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770816939; cv=none; b=HMQxcvCSnBh+8ePQjpobl0Cpv6FVFTV+24g9dNJ3zIqtxLY0cRUJSl78+OPrbCydj0lu5450mvgYya1Mdu0v6qiLM1+aHBTXK6HeoFFVVcX7gxQzrYpp/UFSySHLpTFraCF2BognRClLyynAkGJOoGA8nspRTrjgJhslL3A3uKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770816939; c=relaxed/simple;
	bh=OJ7Ttg9TJQHlRjCx+HLHCXkP69Xqy3GbPd5HZG1bRlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mD2tDTGqMYEclqbaV4JW6fiALEjMNepM+l7orPfoI8dbKSmNoRA0KdqkKWpBceqlIklumELqE/unjMVcEVh6IxN0HAOovT7yseFHwuJaYouW3dURIJWUIWVoRzYbp3bLpO1Sx0rzALf42lTAX53dPKOG8ZFIv4VI64FgAdBwISY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HR2Repwl; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HR2Repwl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770816938; x=1802352938;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OJ7Ttg9TJQHlRjCx+HLHCXkP69Xqy3GbPd5HZG1bRlc=;
  b=HR2RepwlumHuRaACjgUvACUui6XjFTqvoSkGohTIZRdurbB/WgEptOeE
   t0ltYYJRCC+QnNKq979uEX42qqoemPSmMD40nsJ3xLF4XdHdqKMlvaxgQ
   Df9XR+C55MDfBBZvosi2wFK6mDUjul3hwt2RYwVMaK7Z766UcCmW9j1L4
   85hgJztj7qSJ2UcbKD5qE7ZrHvagoawk9bcTF7UvCjRQbqN7SjLf92i+d
   pEk2Wb5W7v1wtQ5V8kdcNSMTcNgNNayXYe/UptAWgfRwJUXLDwXYPdLg8
   +xaGCoCAEzXLDWzuomO8fHsdj7+l7wySxI4AQwdWUJfZmGJApZLMxz26D
   Q==;
X-CSE-ConnectionGUID: UUE40+emQLKhQvfTUWnxRQ==
X-CSE-MsgGUID: rKJ72dSJT8aZr8NzpJ4KUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="71862107"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="71862107"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2026 05:35:37 -0800
X-CSE-ConnectionGUID: kTLGV9bfR6CaTeHq3FGV4w==
X-CSE-MsgGUID: V2BNS4K2QVmLzEsf50t73w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="211184245"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.220])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2026 05:35:34 -0800
Date: Wed, 11 Feb 2026 15:35:32 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v4 03/11] iio: amplifiers: ad8366: remove unused include
 headers
Message-ID: <aYyFpFAQcfn7Qifn@smile.fi.intel.com>
References: <20260210-iio-ad8366-update-v4-0-15505f7b15b4@analog.com>
 <20260210-iio-ad8366-update-v4-3-15505f7b15b4@analog.com>
 <aYuNr8alZt-mjd5x@smile.fi.intel.com>
 <appnjr2asjxadbvcf2fosrkvfwj3dkcnvq7tk74i4xa4ku5zr3@c7qedqneukyn>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <appnjr2asjxadbvcf2fosrkvfwj3dkcnvq7tk74i4xa4ku5zr3@c7qedqneukyn>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Feb 11, 2026 at 12:55:30PM +0000, Rodrigo Alencar wrote:
> On 26/02/10 09:57PM, Andy Shevchenko wrote:
> > On Tue, Feb 10, 2026 at 07:42:03PM +0000, Rodrigo Alencar via B4 Relay wrote:
> > 
> > > Apply IWYU principle, removing the following headers:
> > > - linux/device.h: no usage of devm_add_action_or_reset, device_attr...
> > > - linux/kernel.h: no usage of container_of, kasprintf, ...
> > > - linux/slab.h: memory management handled by iio
> > > - linux/sysfs.h: sysfs interaction is managed by iio
> > > - linux/iio/sysfs.h: not using iio device attributes in this driver
> > 
> > Yeah, but it also means to add (a lot of) missed headers...
> > 
> > array_size,h
> > dev_printk.h
> > mod_devicetable.h
> > mutex.h
> > stddef.h
> 
> Are there proper guidelines for IWYU in the kernel?
> Include headers end up including a bunch of others, so
> the build finishes successfully anyways.

This is global stuff, no need to repeat this in the kernel documentation.
It's the same as asking documentation for KISS principle.

> I understand that the concern is build time, so we better
> include all small parts that are needed rather than a generic
> header that includes that and much more.

> This is the output of the iwyu tool without this patch series:

Have you applied the configuration Jonathan made for this tool in relation
to the Linux kernel project? By default the tool has a lot of noise, indeed.

And note, tool != principle. The tool is just an implementation of the helper
to enforce the principle in practice, but it may be not always suitable for
the certain project "as is".

In the below output some are valid, but some are just noise as there are
guarantees for the "proxying".

-- 
With Best Regards,
Andy Shevchenko


