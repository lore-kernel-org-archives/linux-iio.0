Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326A334DB7C;
	Mon, 23 Feb 2026 08:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771836772; cv=none; b=BI144Br6GMfiDCCuT8w6GcaL/EexT46vUO89L9eT3TPPpyo4L3e+job42r8p5d5PN2dXKWpWip+eXikj01G5qDUlpuKeXMCJC/+hOQpXNa89yOlIEBWnvux9wA75oQm6QqFUvE80Y5CBsPONZs7vDkaEqXL2yE2SQGhYTtpRMu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771836772; c=relaxed/simple;
	bh=LlLUhL/5KJLTiYu4D2lyW615C3JXm7LubjYHLzrZXZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JM3tbsn4IPijCd11jU2L/qtm/PbuYbWNIt1kEtzlG592o75vhgNvcft3SXdZSEKUfVXhsWossBbjmz2DzhLzcHsyvPA6GdTe8Ee+agXhAxDIz9CuoDcBVIlEuZB5G6SZE2TZY6hio7UlK0wc//+rodNHCI34MaVT3w3hNRmpUDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HxPyckUg; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HxPyckUg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771836771; x=1803372771;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LlLUhL/5KJLTiYu4D2lyW615C3JXm7LubjYHLzrZXZI=;
  b=HxPyckUgR+LuUQfk92F0DvNua1+9U9pHZjb1MdNczQT1d4PdQBT9/om/
   P0ulHijosAs+BMSs+zKjA6agMXhIWu6g83AXAe86ihskmbmdK9wNvk94w
   KIHCSGYZizu2kJcUAxI0hmd29ZHkF6dP0lMCq+Q26i/Te1GTNh18EQQA1
   oBCGWh4wFJF9zT/y+djCmNOjXx+77pxM4pR0b9ce+ldpzsKAOuKayKBSs
   VachGD8wLTOLqft28l3VeEt2XyLik2xgPo4UVZJV08oMMuWkhyPN+L9NI
   SYkgg/EwHYUoPObXTrMiyx7WpaPN3HWvSfmRmpjKFacX16anAMcW8lqMf
   g==;
X-CSE-ConnectionGUID: VfWtB7kOSSCw734FnmPoCQ==
X-CSE-MsgGUID: 9myRS4dcQSywNQB2Fwq0KQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11709"; a="72925739"
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="72925739"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 00:52:51 -0800
X-CSE-ConnectionGUID: 285LsgYdRLeizYdw9nyGbw==
X-CSE-MsgGUID: 4h5ojgzgS4KnAXpPWTQeqw==
X-ExtLoop1: 1
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.222])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 00:52:48 -0800
Date: Mon, 23 Feb 2026 10:52:46 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Felix Gu <ustc.gu@gmail.com>
Cc: Ariana Lazar <ariana.lazar@microchip.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: dac: mcp47feb02: Fix mutex used before
 initialization
Message-ID: <aZwVXtGOcA9Jfw5v@smile.fi.intel.com>
References: <20260223-mcp47feb02-v1-1-41f80bdbbb45@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223-mcp47feb02-v1-1-41f80bdbbb45@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Feb 23, 2026 at 04:03:34PM +0800, Felix Gu wrote:
> The mcp47feb02_parse_fw() function uses data->lock, but the mutex was
> initialized after this function in probe path.
> 
> Fix this by moving devm_mutex_init() before mcp47feb02_parse_fw().

There are several patches from you lately. Are you sure the version is correct,
id est this one is indeed v1? Sorry, I'm a bit lost.

-- 
With Best Regards,
Andy Shevchenko


