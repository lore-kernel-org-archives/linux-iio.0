Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7915C39E19C;
	Mon,  9 Mar 2026 11:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773056553; cv=none; b=gyzOXE9x9TRazLlA5VjnUul9B4ewQWP7UknnDVFU2daU29ccoVH10nGbFRzLYDogXmm/3TKZod5NxcxY+nWllOXdKqPaF8wKoQONJptP4FZ87zrSHXIzXJGzcQYlTD8HDP7JPxPP4JicZmO+TatqD8iALPyfWOmJZazbvIRlZWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773056553; c=relaxed/simple;
	bh=8S2/1xPjkL6NQwjq1SuVIVjm9DGkgKBdQeF8KSO2gx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WkXilBywJGjzlfWaT0f6X8F/Zptw3qOmqbvbnza3giwP+sBmjkIlgX2JEBYRbvBNyPEWkZSCJUD36SoJgmMX/Kqpoicu8WWcjunIos2QGA3ZEHcqijhsO6jcWV7x9zb/8ejFwQdFs/PIcOMkuBak4jPOevJpsYTpz998dD3A0LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZhSOqn2v; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZhSOqn2v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773056551; x=1804592551;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8S2/1xPjkL6NQwjq1SuVIVjm9DGkgKBdQeF8KSO2gx8=;
  b=ZhSOqn2vwvkc2b2p6vwqp59arxdPtE0hlbF00aF1NFqwjlN7RNnT+q9v
   P/gUxYjIM/slKPO95R/cIVW6Lcuu6C91f3jGIrAKmLafWM+dR/Bb+ffqr
   bZjlyFsbh+3HeSWIhYdUcYTGmZHk0wsC3myufg60BYUIg+JwEVm9hgk3t
   k6ChE/TKvSM+5VMY8WMKkwjgUZYriFKPpsQPM5MWwKi7vA0UmDud/N39x
   LwtmG8Lx0NUMV1wPrvx7BrkEpuGYSNeFm7Isam6IqViu4hizifbVwCHC4
   5mTIkw08+uO4udmeYG81zYtQncGSm2h/HleIGqb403YkG350SKAIF4XLH
   g==;
X-CSE-ConnectionGUID: ISvMolwfTEOu6Zc7kqkMRQ==
X-CSE-MsgGUID: X1GjWV39RpyQtrA9TAM1Zw==
X-IronPort-AV: E=McAfee;i="6800,10657,11723"; a="73993039"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="73993039"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 04:42:31 -0700
X-CSE-ConnectionGUID: Q6euOmKAQKuCgfWHQYaqwg==
X-CSE-MsgGUID: 5EUjSkhCQY6mfVjz4Qlbew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="257653626"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.181])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 04:42:29 -0700
Date: Mon, 9 Mar 2026 13:42:26 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Shi Hao <i.shihao.999@gmail.com>
Cc: jic23@kernel.org, andy@kernel.org, dlechner@baylibre.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	marcelo.schmitt@analog.com, mazziesaccount@gmail.com,
	nuno.sa@analog.com
Subject: Re: [PATCH v3 5/6] iio: chemical: fix typo insuffient to insufficient
Message-ID: <aa6yItmh2HlBRQ5d@ashevche-desk.local>
References: <20260309104513.40359-1-i.shihao.999@gmail.com>
 <20260309104513.40359-6-i.shihao.999@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309104513.40359-6-i.shihao.999@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Mar 09, 2026 at 04:15:12PM +0530, Shi Hao wrote:
> fix incorrect spelling in comment
> 
> - insuffient -> insufficient

Same comment as per patch 6.

...

> 	/*
> -	 * occurs if either the gas heating duration was insuffient
> +	 * occurs if either the gas heating duration was insufficient

"This may occur..."
OR
"This occurs..."

> 	 * to reach the target heater temperature or the target
> 	 * heater temperature was too high for the heater sink to
> 	 * reach.

-- 
With Best Regards,
Andy Shevchenko


