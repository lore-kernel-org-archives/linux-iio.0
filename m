Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46304326927
	for <linux-iio@vger.kernel.org>; Wed, 28 Jan 2026 22:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769639651; cv=none; b=J+MDk2pmwNVzFy73hWSJ35VxgtB1iCoTGWiat47G7ze4wR7gvDHFhm1InoDEtVwuNXZ/gJOy7wU601UNVXeeaLOGbAfSmKFg4PqGf23JNNbEts3NxorRPAzhc75gPuI6E0CA0F4R4Dtu1I9kl5EM0zYv/Bc3S40OawuweTa03Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769639651; c=relaxed/simple;
	bh=nbxQNaWgvbuagcbYGb5sANQ8AjvWPY4DWQmwVNcz7Eo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fX0xoahT0LIhcU8NLwKWV/Ace9fGdJV5TuPDpfgNHxp1fzDCaiG12RBHt7ybrD3mOewoAwFPwUxrKb7gjhKJ3OyjHlvOQK/DnbRzvDWnQ+Sz9jtnEP0NSzDpTMJ1E8DLnTCz/hBSYa9IRgUgqwk7pqtqPC7ADC3ze8z9pvX739U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y2leoDiH; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y2leoDiH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769639650; x=1801175650;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nbxQNaWgvbuagcbYGb5sANQ8AjvWPY4DWQmwVNcz7Eo=;
  b=Y2leoDiH90nxYm9PXPtKdn+/t0j5kVuGIC8gI4/izXCSimPGOj4EQNRX
   QHVUcajXxGxPDTKtLULUCNcPqsYG/4msW/PllXjC4bcztxJ2ROvsJQeTb
   3hStd1QVr7f7I7zF08ds3jcAR0X9WWpNtjlXsp9104zLWr8IrAVs7wNYG
   Eo1SiZQuTFt4t0xWUCacCg80yqFhgBkvlP8YCpUa3N2JnMb/C3udv5Drz
   ngYfbRUEScvhIABCpleLp0xte+r+SzYyxpFMWbzMRdaqAC8FyCylELIKB
   NLgmakdbZhR1VW4N+H1gNhovuHiYxe/dKFezG4cz2X1zYRoMc18TQ6Ff1
   w==;
X-CSE-ConnectionGUID: ANovhu4TTzqukHMn/kMDWg==
X-CSE-MsgGUID: GKoQIwUtT8u+o4nVUfwu6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="70582361"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="70582361"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 14:34:10 -0800
X-CSE-ConnectionGUID: jQLrronnQ5+Cg3L9aWOEVA==
X-CSE-MsgGUID: M5TUAcI0SC6MkxcBcNhwYg==
X-ExtLoop1: 1
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.57])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 14:32:55 -0800
Date: Thu, 29 Jan 2026 00:32:53 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Menderes Sabaz <sabazmenderes@gmail.com>
Cc: Michael.Hennerich@analog.com, andy@kernel.org, dlechner@baylibre.com,
	jic23@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org,
	nuno.sa@analog.com
Subject: Re: [PATCH v2] iio: dac: ad5360: convert to guard(mutex)
Message-ID: <aXqOlTIGyiiww9gf@smile.fi.intel.com>
References: <20260128113751.258219-1-sabazmenderes@gmail.com>
 <20260128153221.327987-1-sabazmenderes@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128153221.327987-1-sabazmenderes@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jan 28, 2026 at 06:32:21PM +0300, Menderes Sabaz wrote:
> Converting mutex_lock and mutex_unlock to guard(mutex)
> Simplify the locking logic by using guard(mutex).
> This removes the need for explicit unlock calls in error paths and
> simplifies the code by removing goto labels.

...

> Changes in v2:
> - Removed unnecessary local variables

Avoid sending v<N+1> in the v<N> email threads.

...

> -	ret = ad5360_write_unlocked(indio_dev, AD5360_CMD_SPECIAL_FUNCTION,
> +	return ad5360_write_unlocked(indio_dev, AD5360_CMD_SPECIAL_FUNCTION,
>  			AD5360_REG_SF_CTRL, st->ctrl, 0);

The second line is wrongly indented.


-- 
With Best Regards,
Andy Shevchenko


