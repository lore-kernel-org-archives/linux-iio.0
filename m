Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AAE2FD7BE;
	Wed, 29 Apr 2026 19:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777490405; cv=none; b=i8r8fzs80fTqkSb/W4eJngdhVpBBdilT3tv6nNbLcEl7F5L6fZX7mUWHnWWTvBUEsWzR1CHf+wIgerhHNSunyD7wsv8n/Pfj8xOE1GtOYQinj59at/MCzHik/iTQ8/jSQ99fR2vBNbBDEn9E88srp1KKnQgEX0/Qe5CH2sKdNbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777490405; c=relaxed/simple;
	bh=wKEioHsn+UvWj0UWADvN2rinWVwdy45o4YD3N+eUVYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=obfpuyL5am3x0HI1Sx6SyIBI6K57Ta0qWKOPIKRy5hVP1g5QXsgmD0Y0jloqhgT/XLkK6i53Nv/xiLe4YIoSDPIy3UVHx70w/ObPy+9fBxxiTJrJ2rJxJCQfSfw4Hiq2RfX+KS2dywJdvQ5rwKvTiJINNjgfUCwJiAzgTdTsrn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FzeYj/wG; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FzeYj/wG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777490404; x=1809026404;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wKEioHsn+UvWj0UWADvN2rinWVwdy45o4YD3N+eUVYo=;
  b=FzeYj/wGw00vp8ySG1aePqyQxkNV9jHtwqA/7lSctAwGlLcpBDNngodJ
   dzprJarDLjZ0HvRpa9LvqiXSrEHv4chR99FloiTOGiPTkIqb8le6kdNPS
   x6UaDSsX0vTVUoJ85tWlQAcfTdAxHD3ZNHYkAIAvH61zAm61J7lZKFrA9
   vLUPxc6NC6Aqc6pYRSFcDfQPsBu0USQDrcaQlBYWfGJUuJ0i58B8EJ0Nk
   s4ukI19r50YtuzjSyzpJqCi6BeUZAlDQ+laKwVoPQ2N8a6+46/5BxOwHf
   SkEW5rCtEpFH/tDdzzgkibNN+ulJsHJo3CO76bI5z+SPaeSjI5T3jPHZ9
   Q==;
X-CSE-ConnectionGUID: nwTBYcv/QAOInPxwIwhTyA==
X-CSE-MsgGUID: oE/7VUR3Sqy+Tudg4cbNEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="101094021"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="101094021"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 12:20:03 -0700
X-CSE-ConnectionGUID: hJqPiElESN6cdx6zPzYoqw==
X-CSE-MsgGUID: 0zUos0/EQqWm9eRTVfXD+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="236132279"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.141])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 12:20:01 -0700
Date: Wed, 29 Apr 2026 22:19:59 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: joshua.crofts1@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/8] iio: light: si1133: use guard(mutex)() macro
Message-ID: <afJZ3_CQU0BIFO11@ashevche-desk.local>
References: <20260429-si1133-checkup-v3-0-469f21d960eb@gmail.com>
 <20260429-si1133-checkup-v3-5-469f21d960eb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429-si1133-checkup-v3-5-469f21d960eb@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 29, 2026 at 05:04:53PM +0200, Joshua Crofts via B4 Relay wrote:

> Remove mutex_lock()/mutex_unlock() and goto instances and add
> guard(mutex)() macro to modernize driver and improve mutex handling.

...

>  		if (!wait_for_completion_timeout(&data->completion,
> +			msecs_to_jiffies(SI1133_COMPLETION_TIMEOUT_MS)))
> +			return -ETIMEDOUT;

I believe Jonathan gave you a green light for loner line and properly indented.

		if (!wait_for_completion_timeout(&data->completion,
						 msecs_to_jiffies(SI1133_COMPLETION_TIMEOUT_MS)))

It fits 100 and hence doesn't trigger a warning in checkpatch (in default mode).

-- 
With Best Regards,
Andy Shevchenko


