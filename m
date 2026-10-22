Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792652896;
	b=Mbi499qTkWpFcVLmrgPGA3GKPAIvddsfUH1NvWeNb7lO6uHKCG2gcBowmmUvuFCTbSjB
	 UXmPWMtEnOlVqiK2yZmpYaUPyLTc52k7O03SQprAs1IiZ02KAJqTPuBMV+aqL48mDVFcs
	 1UUVqJDbkwIxjJ9VutJMSKwquHqBjhAq6DIFv+o3+tmZp6ftMSsE4VGIsNksk1zBQqxop
	 rWZv6J0o9UcrtD9ePxeWbswBe2z9YSvAEYBWbR8yA6oOdeZZBIpwdVKRC9kwKCLDxawqe
	 C4tojuR9DPOpWGzZhMNu7lDlrFknXjSon6D6dd9rIEtCqtTgOpPOi6uRz/Us1arkILQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792652896;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=ObZvU+XQmGZG3o23DiXFT3XrTWwzGNWdvfr2/vc5O34=;
	b=35K5k343UvTCD1BjjaUaihTDtqpYKERCO0hhygiwv4enBZtrzDIDwYaOrbxpJ6iHDipc
	 DV8FGtQ2LjgKGNuzhjddtId8LY8vuk8ffgSdy8gysT5Y0pMFnjAtWJQnJwwDsvq+MKf68
	 mWJSG2aF1e1HRCONA7oGP6Z7Gl3dDYSBh75KC4HLSjV6RXkitfJi2OAoMD+XGdXCL5ZNq
	 BTa1+KL4z+xlTbrtyInB8hc+YQuJTYblhSiW3Dx2LjtDvtGmnVEEDSNVrWgVsi0ujGol/
	 XAg/KIA1SsnKpQiEAvX6RmF42ZtZ3l/1u5zl1da4+YYY3chqlR0ymgkcQNDa46F4KUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bkz7W+ZG;
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D6F606A31B;
	Thu, 22 Oct 2026 07:08:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9D6F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bkz7W+ZG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792652896; x=1824188896;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=x7UcIOl68v/yplQB3o2tSi3KkbbDcGf5tiMGGiPZRXI=;
  b=bkz7W+ZGO2qCZXZHlXpTs6cDrvW0W7o7Rl8Fb5PppmrcoEM1aBClvrv/
   hErnSagpR688QVbcGRoKoN0HE5tgso+arRzubTwRV82CTc11GBYtkih7b
   8wYm2hKZoc8sCYxjoD5qthM7nriDlwm2qI8V/5SDpeN2cfMAGWE6ax2cS
   yA98zKpx41Y5RMofPCiyWjlBW96RMMyswO17S73Ys1JVuIkoB0R+0Rpu2
   MnIueRC9EoK65i730i74VX6m+C2xpi+EVGFVMdFqOWTN9b1XWV9zoFEr7
   W4scflZbEH2hi6g12wj2au2EkBQxRcnLDQR7QjQlisOVGippmHZ0Z9WcM
   w==;
X-CSE-ConnectionGUID: RK98V18bSfmE/VsWWy+ptQ==
X-CSE-MsgGUID: MAHrjdgJQXSl03BZxqhkhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1292731"
X-IronPort-AV: E=Sophos;i="6.27,171,1787036400"; 
   d="scan'208";a="1292731"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 00:08:15 -0700
X-CSE-ConnectionGUID: 1/fnXGRAS9OfXNqmigeYGw==
X-CSE-MsgGUID: OloM3ZDvTbK4FxaeL/NkQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,171,1787036400"; 
   d="scan'208";a="3694020"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.189])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 00:08:12 -0700
Date: Thu, 22 Oct 2026 10:08:10 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Arnav Kapoor <kapoorarnav43@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Rodrigo Alencar <rodrigo.alencar@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: core: fix signed integer overflow in
Message-ID: <atm2WhX9KDkbUIPk@ashevche-desk.local>
References: <20261021225306.623361-1-kapoorarnav43@gmail.com>
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
In-Reply-To: <20261021225306.623361-1-kapoorarnav43@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

+Cc: Rodrigo

On Thu, Oct 22, 2026 at 04:22:48AM +0530, Arnav Kapoor wrote:
> __iio_str_to_fixpoint() accumulates the integer part of the parsed number
> into an int. Feeding it a string with more digits than an int can hold
> overflows that variable, which is undefined behaviour. The same happens
> when the parsed value is INT_MIN and the sign is applied afterwards.
> 
> The parser is reachable from userspace via the writable IIO channel
> attributes, for example the "sampling_frequency" or "in_voltage_scale"
> ones, and via the exported iio_str_to_fixpoint() helper used by a
> number of IIO drivers. A user writing a long enough string therefore
> triggers a signed integer overflow.
> 
> Accumulate the integer and the fractional part in a s64 and reject
> values that do not fit into an int with -ERANGE. The limit for the
> integer part depends on the sign as the sign is applied only after the
> whole string has been parsed.

This needs a Fixes tag, otherwise it probably won't needed as Rodrigo working
towards tons of improvements in this area.

OTOH, Rodrigo's test cases might be good as part of this fix as well.

...

> -	int i = 0, f = 0;
> +	s64 i = 0, f = 0;
> +	s64 limit;
>  	bool integer_part = true, negative = false;

While at it, make it reversed xmas tree order.

...

> +	/*
> +	 * The integer part is accumulated as a magnitude and the sign is only
> +	 * applied once the whole string has been parsed. Hence the limit
> +	 * depends on the sign.
> +	 */
> +	limit = negative ? (s64)INT_MAX + 1 : INT_MAX;

Wow, what's wrong with INT_MIN?

>  	while (*str) {
>  		if ('0' <= *str && *str <= '9') {
>  			if (integer_part) {
> -				i = i * 10 + *str - '0';
> +				i = i * 10 + (*str - '0');

What's the point in changing this line?

> +				if (i > limit)
> +					return -ERANGE;
>  			} else {
> -				f += fract_mult * (*str - '0');
> +				f += (s64)fract_mult * (*str - '0');
>  				fract_mult /= 10;
>  			}
>  		} else if (*str == '\n') {

>  	}

...

> +	*integer = (int)i;
> +	*fract = (int)f;

Why do you need explicit castings?

...

Do you know about APIs in overflow.h? I think you wanted to use something
from there.

-- 
With Best Regards,
Andy Shevchenko


