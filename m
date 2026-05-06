Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F7F14B08A;
	Wed,  6 May 2026 09:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778059505; cv=none; b=CK8CGJ6MKVIvVi8oDrThZ7kQuRfz7VSU2LWg7n6zb+Aec0CuxzlozqLEdyckDgS+E++TL/nU0QPL+hsfEXJiU+7VOFeBbQAtioTEMhOkEUugrs6kHvy5DRc8RzoLEMQ2F19SNZs0wtt7nCN94CNloHoJB4CFQgiXuYjut2ozA8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778059505; c=relaxed/simple;
	bh=WigBB3A294w7eGFlLRtKELKJ59UfbI+AWkHFAGqfbU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CDiw8iZaYDd8fQHAghgXgSB237mVnSpIKgRMwQurVNqpKcbRv/+QzcXiZoM5nANVyinbQH/WoFge6KG53VRAk8Dn/T7Qb4EVyPigvBdibrn8eDckixLBzH7ABqL7AwFzLHk6lVOCz+AV/csH1Ut5ZECuT8klXqfz+u/eAzBzZgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FpOTw287; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FpOTw287"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778059504; x=1809595504;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WigBB3A294w7eGFlLRtKELKJ59UfbI+AWkHFAGqfbU4=;
  b=FpOTw287aoEWSYWhAZOQTmIvjbf3p2xicBg6G+Rr8bzAcwydGB06SVRo
   9KmebjwE4+9cbClhGhwx3hJMC+LpysLRRT7widtxeAkhrYfdP6Ovrn4Xg
   x5AnFS4Z9CIcpcDgqSqn79wFyJjUl72EcdqEvi3aCpUmJ+fl805RwKbNA
   9eGukSWxsnlgEl+nozBQLDSteRj1/GtF6YSpifU5DQFuKUyhzX/3T6j45
   lMy0g7nwENh1H7/rWcEmCVHU7OZFxENdu4QnTr3MIRl1XyqAsquEGjvta
   hMA+B+SI0wxfvB8vzs/ruMec7kbgvl3MiJUTj0fHIWKBLETDN6PkNCpa7
   Q==;
X-CSE-ConnectionGUID: fsg/xWinSviq5ItO4RBHFQ==
X-CSE-MsgGUID: Ql40FzoKQ6qLf9iAxSxH4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="78873578"
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="78873578"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 02:25:04 -0700
X-CSE-ConnectionGUID: J6xEwgA8Ryu7iswogZD5jg==
X-CSE-MsgGUID: U8lmsxIVRlqR5v/klQ6dxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="236189552"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.183])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 02:25:01 -0700
Date: Wed, 6 May 2026 12:24:58 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, sakari.ailus@linux.intel.com,
	christoph.muellner@theobroma-systems.com, martink@posteo.de,
	mfuzzey@parkeon.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/10] iio: accel: mma8452: improve coding style, pm
 and resource cleanup
Message-ID: <afsI6hyCHghRUOz1@ashevche-desk.local>
References: <20260505174640.3998281-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505174640.3998281-1-sanjayembedded@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, May 05, 2026 at 11:16:30PM +0530, Sanjay Chitroda wrote:

> This series contains a small fixes, cleanup and improvements to use
> modern kernel helper API and coding style for mma8452 accel driver.
> 
> The changes modernize mutex with guard(), dev_err_probe usage,
> resolve checkpatch CHECKS and pm_ptr macro usage.

...

> Feedback and reviews are very welcome.

Sorry I haven't asked this previously. Is any part of this analysis / commit
messages / et cetera AI assisted?

-- 
With Best Regards,
Andy Shevchenko


