Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793011319;
	b=YPUgeLGGCx+ZxCmepEhX8L2tevtWyBn4FIw7XMhCLYG0gtdZwhMKqldG0y91Zwz05Y6n
	 mOPDoIEShQDIxb2MJGPOCSzyTfxMDDgzM/QZ8X50KI2ZCPvKRGWIZ9ZOLqFJPavvGdquX
	 idlJlvKrs43dPLvyY84LGk2lqDi709OSeWYPeM7ILCEMWODjg74Dg+k/G5nt7zkyOGH/W
	 No2TBrXjwhCi/CEG5BdQOZOBSaWXFdTvVluAwm9lFIP0KygSy8vWB8cYG6I0I8xprZybw
	 AbABuEzK7cDfcxUvn5b7pCFUdv7hEdl5JwytuMnysADkkSDCN5SQTZCWhZ1wC5yMsbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793011319;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=JWu1tuX4kW1Cjp6C6Rivubv9hwm+8cTWeHursPE9SlE=;
	b=Bs/sN3FBlSAoOSsdEM6Gb5q4CS3aGA8RoY9N9WR4QAFlu0zMl+foHPqhN1EdRf8ymE7v
	 AClfE37b3fs4S678wSbGo4gFzA3Fsjzf3NuiGakGzel3U/jzQ15I1o/qb5atnv/lDDXAM
	 u9KkwVc0loP0cRO+KCxu1UaC1iRD2Uza5ICWk4Rzp5btfXjaDgj0uEKfuQv0hhH6/qU5N
	 lT3ClMi7EzFAiTRdwOZwWPnGr6weZen6BEc1CGL4YRAQLvnKKoMZ3OjpMxOIwnYCDZvu4
	 XSCpBIlNgXMoK9q5tXQLzrmFznyjGKlAFSajMttqB6qET6eqwNahkAusEnLqFgTtcRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hsRa2Kr0;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA249606A31E;
	Mon, 26 Oct 2026 10:41:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA249606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hsRa2Kr0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793011318; x=1824547318;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WM6zGa0/xkVzrcbn0JKH6wSyOf1elLj03d05n3GDUnQ=;
  b=hsRa2Kr076ufr9aEnceh+FbDLCcEJbMgCFRXXSuN8B7YC6HjKwi1Nii0
   7E72qOYACHwl5RYXAUoWQ5OCrsKwbivdSxCaXzvt5gbB5YXnF1ab51LCF
   cKXvbYcNrT2420wSKK7YU3STnmpOsWmOGMq4Wy6nEzr6Ye7LhsDjGJ1If
   gkH5nb2HrypqoF2jfLaIa6no+VGtdzjO4kjlUb4SJriwHxItFi4LAkqLE
   0x5W0iu0gm+MLwdQunF/JjE7YLfYFkC5nq0JTVL8BLqkhwO6nbN4i4anD
   i49L53S8N+fZmgL/vH0cKInAleUy35aSRWZzfkk88Nxzm6A4rOHcrZ9M8
   w==;
X-CSE-ConnectionGUID: 92u8fOx2TJKn/cBNEl0KeA==
X-CSE-MsgGUID: RJQuKep1SRuNw+18jmH1lQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1559140"
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="1559140"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 03:41:57 -0700
X-CSE-ConnectionGUID: VChWZLwXRQetuC2astqSeA==
X-CSE-MsgGUID: fLha9bd9QJuJiLdFzuQgxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="4134251"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.93])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 03:41:56 -0700
Date: Mon, 26 Oct 2026 12:41:53 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Arnav Kapoor <kapoorarnav43@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Stephen Boyd <swboyd@chromium.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: proximity: sx9310: report a hysteresis of 0 when it
 is disabled
Message-ID: <at8ucTXC_VYqdVON@ashevche-desk.local>
References: <20261026100041.16018-1-kapoorarnav43@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261026100041.16018-1-kapoorarnav43@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 26, 2026 at 03:30:32PM +0530, Arnav Kapoor wrote:
> sx9310_read_hysteresis() turns a PROXHYST value of 0 (no hysteresis)
> into a shift of 0 and reports the full threshold, which writing back
> then usually fails with -EINVAL. Report 0, as sx9324 and sx9360 do.

...

>  	regval = FIELD_GET(SX9310_REG_PROX_CTRL10_HYST_MASK, regval);
>  	if (!regval)
> -		regval = 5;
> -
> -	/* regval is at most 5 */
> -	*val = pthresh >> (5 - regval);
> +		*val = 0;
> +	else
> +		*val = pthresh >> (5 - regval);

While at it, invert the conditional.

	if (regval)
		*val = pthresh >> (5 - regval);
	else
		*val = 0;

-- 
With Best Regards,
Andy Shevchenko


