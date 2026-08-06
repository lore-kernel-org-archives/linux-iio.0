Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A442F30;
	Thu,  6 Aug 2026 21:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786052404; cv=none; b=nFhFG4IF0ZW0BR+xbMaypgf8XlcTJ/hAMinEZE2JSvFUFpBnrjMIVLrZKcnmO81zCixL1IV6GlJwDm2RTkO5m9Vuq9rIlPq0/c9N38rmvHC7gFDutEJHX6l1VDFhwKplEc9cYmoyovB9UsZO3blUi18VB4cymyU0osxANvQZZZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786052404; c=relaxed/simple;
	bh=ompdTaruDcMcsO0WZZQEhlBbEsXJ8M0alKlUXccljqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DKFIMw60Yre5yjXJ5ahEzZjRNMd5ucMY/vxs4bLxxgjACsnvr3G1r7wVMMJdV8E7iZ6vRJC/prL6MAhR6dTLZJVY43IlSjK3WObiX3DnK9tvxI6yujf7uK0EB4BdnYvFFYCz2dFMHkrb/dRptWObV3R23IYnLp8DzfLgBBbFi8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g7UloFae; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g7UloFae"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786052403; x=1817588403;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ompdTaruDcMcsO0WZZQEhlBbEsXJ8M0alKlUXccljqA=;
  b=g7UloFaew+NQcvKf8j+p/r4EyR8IPCiCNHyLZYX5O7kHrkyg/cxIiCav
   ConzUMk9hLp0OXVvO0jDy5DE5+3LpVVdPseLnXuEbS5B9tz6CTUf++9vn
   OdTFfNQ7in7NBFTbRnj1vwLF+npmvOIB3wA29r1XynvFkMdGVEfTU9cj8
   S0PKUpvAGzdN/u0Qp2k4ZlRfopLb57lPj/NTjdm/0I70+2Xhc5q3SPlx2
   tiD2YLydqlTM0zTqEu9TYfErIZKyde4xWYfDUz9+A0G5pSSqGUZsHy9jN
   Orxb790wLVSAxliNHdI/rVYekvixRbP0hSW+7rg2YHZVUxxliEMQ1XeI0
   Q==;
X-CSE-ConnectionGUID: PoJ5WfCUSpmWAltDCVo/jw==
X-CSE-MsgGUID: 5jlL6VpIS7i9eMqnYCpQUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="85782225"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="85782225"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 14:40:02 -0700
X-CSE-ConnectionGUID: ve7vJNPlR1+0zq3deJn6/w==
X-CSE-MsgGUID: 0PvSLkvXQVefxRyXYzKI6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="257915212"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.50])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 14:39:55 -0700
Date: Fri, 7 Aug 2026 00:39:53 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Esben Haabendal <esben@geanix.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Nikita Travkin <nikita@trvn.ru>,
	Maslov Dmitry <maslovdmitry@seeed.cc>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/6] iio: light: ltr501: Fix sorting order of device
 arrays
Message-ID: <anT_KYZjkX2Tcnqu@ashevche-desk.local>
References: <20260804-liteon-ltr329-v3-0-c6b768c7c745@geanix.com>
 <20260804-liteon-ltr329-v3-6-c6b768c7c745@geanix.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804-liteon-ltr329-v3-6-c6b768c7c745@geanix.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Aug 04, 2026 at 07:02:17PM +0200, Esben Haabendal wrote:
> Using alphanumerical sort order for these should help reduce merge
> conflicts.

...

>  enum {
> -	ltr501 = 0,
> -	ltr559,
> -	ltr301,

> +	ltr301 = 0,

Is the 0 required? Why?

>  	ltr303,
>  	ltr329,
> +	ltr501,
> +	ltr559,
>  };

-- 
With Best Regards,
Andy Shevchenko


