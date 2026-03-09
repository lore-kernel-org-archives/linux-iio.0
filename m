Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D7E3E8C77;
	Mon,  9 Mar 2026 16:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773073574; cv=none; b=GbZix2Bzuef5j4AKj+4ugS2ZF2b4trEnXa7En4cORaWt6GMZ5xQVdX0UV+sAsRUR/scfuZ6HpEORqfeBGfwp2PFwy+VO7Ydt9s8m5yzmEFPwrRDJcZ+2jmqgJflLIBArsdrkrRBUJVOE4m8Ggw9hNl7WA025tzr4bDoBPaou2Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773073574; c=relaxed/simple;
	bh=/99WfYSDpZwBfNB1pNckuMpP1XkY32lCSfWFKU81WIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MIrizXRV5VH6Jcp5IEvZgQjb4qnIHWgsojHBLwV/ttz5LOZ9jg8wQlqcSYgdUjxiOaLqw7SlcRkhllnW51XMdWlo7T4tR+FxmUP6V541hVsHR2KX7NvV1eydmbN9H4aDsO4pyq3qKOiwzLogec3gvJgUL7DDQ8v3So5jjGFr3lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l83yjJre; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l83yjJre"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773073573; x=1804609573;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/99WfYSDpZwBfNB1pNckuMpP1XkY32lCSfWFKU81WIY=;
  b=l83yjJrehWxET04M8hzYeRTnxETc5S0mc+wFU51NjO9QlBKtIf9olPNP
   LIRHNjKhhVY7teDUled5sBV3tcJ2OLwkD3JzK+vkItjBx2O8sTR1kQvn1
   LY0sG52L1AbitAK2SJTLEvBk+VnRakPlLwsvev2rQMGt8v+Dt8CuwWmf+
   JxjNe5jEA7pqZPU6LJKWb1M0Qa0LgeCxYlv5S4VUj431KHYkRnf4E1YHU
   xiXNfQTPY9Fkhrgx5kp/0rwNovrFBegHi5/P0PbmwnKBvwRqrQwEYyjMy
   HhoEV6faR3uusxXxslXuO1u0FzChzggTDt/onD+tlvT2n0fm6fyc85+gY
   g==;
X-CSE-ConnectionGUID: 2oi86Qe2QbKc+Fuf7yLMNg==
X-CSE-MsgGUID: ePLaNIflSJmvxVGzizgX8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11723"; a="77953711"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="77953711"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 09:26:12 -0700
X-CSE-ConnectionGUID: C4P6s/qxTGGH+v3qUDhWtA==
X-CSE-MsgGUID: PmEnxo2LR9yXSbMA4QKiuA==
X-ExtLoop1: 1
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.181])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 09:26:08 -0700
Date: Mon, 9 Mar 2026 18:26:06 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Waqar Hameed <waqar.hameed@axis.com>
Cc: Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linusw@kernel.org, sakari.ailus@linux.intel.com,
	harshit.m.mogalapalli@oracle.com, antoniu.miclaus@analog.com,
	andrew.ijano@gmail.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] iio: accel: bmc150: convert to guard(mutex)
Message-ID: <aa70ngEIxDNPYqky@ashevche-desk.local>
References: <20260309142352.57407-1-rajveer.chaudhari.linux@gmail.com>
 <20260309142352.57407-2-rajveer.chaudhari.linux@gmail.com>
 <pndeclt5aup.a.out@axis.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pndeclt5aup.a.out@axis.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Mar 09, 2026 at 03:35:58PM +0100, Waqar Hameed wrote:
> On Mon, Mar 09, 2026 at 19:53 +0530 Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com> wrote:

[...]

> > Aligned headers in alphabatical order.
> 
> Never mix unrelated changes. This should be separate patches.

Yep, I only mentioned to place cleanup.h in the better place.

> Why? Think about traceability (bisect etc.).

It's all about maintenance and development. Easy to see where need to put
a new header if it's not present (also easier to find this at a glance).

> This comment applies to all other patches in the series as well. I'll
> just state it here and wait for V2 before taking a deeper look. 

> To be honest, I'm not even sure if sorting the headers is a "valid"
> patch. It's just cosmetics (and there seems to be no such code style
> guidelines)...

It's valid when in a series (not as just for the sake of sorting). Here
it would make sense to have it as a precursor to find the best place for
a new header inclusion to place.

Guidelines here are still missing maintainer preferences for IIO subsystem.

-- 
With Best Regards,
Andy Shevchenko


