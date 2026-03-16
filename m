Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FC2288C39;
	Mon, 16 Mar 2026 15:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773673266; cv=none; b=tCX4EW9HnwVYkj208iHlmm8CMx0lIX3joIdRepXj6zkBQ6Woay0TG9XHzpluzoAi0aPfo6IpgQf3aC+yr1w8vC/jqa66+Y/eBGSZ7cJnk4/GCJt7b1EmNaWy5xtR0TF7SRaDx49o+5MpFP9Mh6+yWiloKsVcSrCPefbPAzHMp/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773673266; c=relaxed/simple;
	bh=ed90cKLh1D3xX/AGCtlP6muk6rhRVx+JCAGAVyNx5ew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fbK35S4Rmv/ppv5oS/PV1B46KxQx4W/f0znqqr5aPMAQltJ/GW6KV2A0s8sFmvaTDIx6CH1W0WjLHaT9E8uy5o4z7ZjE39ClFywh4vy2DeMx+4c4XD7Cj2GCR3uR02yJFfUTV3fqdzEkZKU4g6puHUvpKjvxWo5E9momHC4Rfsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bDtDdtGU; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bDtDdtGU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773673264; x=1805209264;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ed90cKLh1D3xX/AGCtlP6muk6rhRVx+JCAGAVyNx5ew=;
  b=bDtDdtGUEw4XI91gcxavufeyYXA94ZACeNSvi5rpnZ4U2i6wjtDv1nFw
   OQTw598x/CAwfrd+gFLDmft3fnoMcPsJ42COblrryB3cJV8VOkQKYAGKQ
   djdNGnjojvq0PBPPeio5k2QNmjOxJUQz9hDUuCt+a79fx2ik01KBEf5sl
   LkZRkTQL1HTTyJN5Mr8WD5JnT9g7zKzQU5Rf1Ah+hrxgf4LEyoOSKBmzT
   W53yfry3Jo7kTTMknjpTCSAIHIcBfBu8WcDTl1f79Mr7P3HRt8+s06/qi
   PPRdupG2C5baLEbFxhiMIG8u4c1+4RIn/nBU+aMnNfxXMbBvDgpg1wntF
   w==;
X-CSE-ConnectionGUID: 96+51AIMSqGZt9BguJt3gQ==
X-CSE-MsgGUID: 4wqIdVg4Qiin3T7uuUbWOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="62258323"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="62258323"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 08:01:03 -0700
X-CSE-ConnectionGUID: K9ySngHBT7yln40sgLCntg==
X-CSE-MsgGUID: 34G3mGOAQdeFaHlRFhmwSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="221886707"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.237])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 08:01:00 -0700
Date: Mon, 16 Mar 2026 17:00:57 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Shi Hao <i.shihao.999@gmail.com>
Cc: jic23@kernel.org, andy@kernel.org, dlechner@baylibre.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	mazziesaccount@gmail.com, nuno.sa@analog.com
Subject: Re: [PATCH v5 00/14] iio: fix spelling mistakes in comments
Message-ID: <abgbKZro-i2o3Opq@ashevche-desk.local>
References: <20260316090023.14691-1-i.shihao.999@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316090023.14691-1-i.shihao.999@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Mar 16, 2026 at 02:30:08PM +0530, Shi Hao wrote:
> This series fixes spelling mistakes in comments across several IIO
> subsystems to improve readability and code consistency.
> 
> v5:
> 
> - Rebased on linux-next
> - Dropped patches already fixed upstream
> - Added 8 additional patches to previous 6-patch series
> - Rephrased several patches for clarity and grammar
> - Added missing article where needed
> - Improved commit messages for clarity
> 
> v4: https://lore.kernel.org/linux-iio/20260311093933.21333-1/

This URL is wrong as well as other references here.

> - Fix commit message grammar and punctuation across patches
> - Keep 'whilst' instead of 'while'
> - Rephrase sentence in chemical driver comment
> - Capitalize IIO in comments
> 
> v3: https://lore.kernel.org/linux-iio/20260309104513.40359-1
> 
> - Change commit subjects as per changes
> - Capitalize proper acronyms (IRQ) and Celsius
> - Fix short wrap in commit body
> 
> v2: https://lore.kernel.org/linux-iio/20260307104705.49129-1
> 
> - Split original patch into 6 commits
> - Fixed commit message formatting and typos
> - Added necessary tags in commits
> - Added more fixes than previous

-- 
With Best Regards,
Andy Shevchenko


