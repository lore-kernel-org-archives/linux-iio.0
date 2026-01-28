Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D242F7440;
	Wed, 28 Jan 2026 22:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769639125; cv=none; b=BhUZmgDI5PijlHnh+PFHM5Id17PT6g07nwrsDFmcABX2ucRK/FUH4bOj0w1fRc3FPqcxBryzR04GVQBpWMjOkk7Itk7wtR40b6HUBJVU32bEjg39wdM/8f7ih64UZ34xTKpklVBm7C9s/ipio6SCWW6/pe6pzUW/QdxsfGpTARY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769639125; c=relaxed/simple;
	bh=0sKkWq5NWOL/M05Hc8CntNTZSdBgOj06xeSyns/8i/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sr1A86JmOG08yQzZH0aDfAiW8YGOAleT5oXSFeLHXuyEndbDjDe3BBTtHDW4t4I08i8U+UAv11zFEkEYDlMKBh4H5G/amxmy+cPAsHvwOVQuQm13yKVqbxm1/iKPZdokeoDGn9dH2GXADLeexyxZlrwXLBsdQXBhPvta6/t8+Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IhXVRNDf; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IhXVRNDf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769639125; x=1801175125;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0sKkWq5NWOL/M05Hc8CntNTZSdBgOj06xeSyns/8i/Y=;
  b=IhXVRNDf4gYp3gW+4FzgBjNd9UcZE+cO0v4sXtZUQiyuOOZ9gNX19OJJ
   mUKqZUctngPU3Y6Iu+2b/j48njwetYa4nZNEEkki3tCmZ7J0/RezxhdcZ
   1YWHWwN/bfg662zrSd+mT2pmW2TpxzDdY3OoBWoTj4ERcZ/asktiQdrp4
   UEzgzpAKRY9mhNx/K0BIAOsgFvD6cgx4gB9VA4K8IPqsPEL/D18O/YqxB
   z3A/feEkOyJuX3AOc6lmYIcTPUvs8pM65RDZOWDHa8Fx+pWVmywCq+aOZ
   D4/q4YSLiq0K6E/A/R959Y93mWy+A/315Wo321HieYPphrJAHoSPLQgyL
   A==;
X-CSE-ConnectionGUID: L5TND8BtQNOrID1gIdvoXA==
X-CSE-MsgGUID: ZM66yrfJSRSMcCnRc7nDnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="70904920"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="70904920"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 14:25:24 -0800
X-CSE-ConnectionGUID: v5HMF2jnSk65QgkMZda+SQ==
X-CSE-MsgGUID: eruXD0ilQrKuclvEYr5xxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="207990499"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.57])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 14:25:21 -0800
Date: Thu, 29 Jan 2026 00:25:19 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: raskar.shree97@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 0/6] iio: proximity: Add interrupt support for RFD77402
Message-ID: <aXqMz3TYNA3hegcX@smile.fi.intel.com>
References: <20260128-b4-rfd77402_v5-v8-0-36388fe7b95e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128-b4-rfd77402_v5-v8-0-36388fe7b95e@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jan 28, 2026 at 11:21:47PM +0530, Shrikant Raskar via B4 Relay wrote:
> This series improves the RFD77402 ToF driver by cleaning up include
> ordering, improving resource lifetime handling, switching to kernel
> polling helpers, and adding optional interrupt-driven operation.
> 
> Changes in v8:
> - Add comment for polling timeout value.

And mistakenly removed it...

> - Fix indentation for macro's.

-- 
With Best Regards,
Andy Shevchenko


