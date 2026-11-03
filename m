Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793728307;
	b=hsOY6dK/IUWbgQMLNByiXJQOW5qpgOX+gM3m5c5XjUsaZIkgYIXoYMFDexeGDpuBvUcr
	 ugPjXqUabqf3AAJ7rYY645qmuAq4i5wvBgT+uCjeDLui5jwMr9ykvO9R5GtIaTO3OyFMm
	 4HN3vP0Ls1hDfyVjcRTvxep8G8LFYHQrGw9MhyhxqP56LZWufzjUwPF8CDB1JPm4A69Zf
	 ipUqZObekhUdm9PhopmLkag8ATXFt+Tk3tS5U4OBx8S1G72BF5+e9sUltywD86OHmwgTw
	 rpQwKsB5mUZTvFKXTwgdDK6TOLzLZr5X3lp6RpjtUTgNRGQ3D0A5CpiiQOdDYxmX6RQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793728307;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=R9rwuiah1mEgbqQCSd+Ah4mYf3c/C8eBl/wcNjI9svs=;
	b=Uby78pDNsx+z1C1DOnD6i/m63iS7SSJ9WsNoB+3CYPhrr2yLLHUtQY0tHcdw+zeifCqf
	 67QIcHxsfVXWVGhU+J9WQMumJ+RDysqWzjfzqJfY+UqPHNfGSxaC34DyTjlxUmLpElbqe
	 ZfQqwCSBblq1dLNfa8ebexqIMZfIidu0DOOw4AK12IUALPPGzcZ8oRLPHnlcukTnd2a/u
	 /4qtR0GnU7RqqQ14SbYEK+HrCHnmqrUKbxZZ8pqrwfDbiwWlvl+QFq9N4yLPvFK8pp6ZG
	 4ntCaPjtaYABuaOva+WON37hb+LEeC2T93NYWDgQVJHdgzCo3FNj+4C3tSfM/JcXKdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YGN9uZZN;
	arc=none smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBCB606A335;
	Tue,  3 Nov 2026 17:51:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EBCB606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YGN9uZZN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793728306; x=1825264306;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AVpN612zkCB9naibtE/gJKAwd/OOYKMHVnMK4oGbxI8=;
  b=YGN9uZZNz98ydu+QSz8wbFmcPG5xm8kbajenHRMzlZBm1aTUnf4oKjFl
   OpFzeGlpjv3pCdXODQskstkzcEdLcdA8z2OIcz8u0XDqM6SZqO3Zf/dCl
   rPv4EZCHVmB1q4zm1EWjmppzGQI7h2Q+f6AMpWSM2+Ikr0AvPeui5jlNy
   nArL/+KpX3dOp3gEbpjWIzJyqvYmzLlno7n8vTVsVtLJGHFbBbe1BHyuN
   eI0/SkTraApFqyvydMeAqJAOwRvWj8tcaES9pDaxFALko2jQdet7EtpcM
   1Sxtd7BNDyI/U6yqXgWLn6fIH+GAmhMwwhTtCuAS0smH8rwZ0CEgyDMPM
   Q==;
X-CSE-ConnectionGUID: CB2sgV1PS1qOlIIeJ0yNow==
X-CSE-MsgGUID: iYYjsRWXREe2QUFHSdf/2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2463441"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2463441"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 09:51:45 -0800
X-CSE-ConnectionGUID: FFUNtS/VQ7GPqE8zuRQGLw==
X-CSE-MsgGUID: uwTjvFrASZ6Fdk0DVB491g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6499695"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 09:51:43 -0800
Date: Tue, 3 Nov 2026 19:51:40 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: rodrigo.alencar@analog.com
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v5 1/7] lib: kstrtox: support E notation in
 kstrtoudec64() and kstrtodec64()
Message-ID: <auofLF8TivwJiMwT@ashevche-desk.local>
References: <20261102-e-notation-v5-0-d399e544a982@analog.com>
 <20261102-e-notation-v5-1-d399e544a982@analog.com>
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
In-Reply-To: <20261102-e-notation-v5-1-d399e544a982@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 02, 2026 at 07:40:59AM -0300, Rodrigo Alencar via B4 Relay wrote:
> 
> Allow decimal strings to carry an exponent suffix, such as "2.7e10" or
> "271828e-5", in kstrtoudec64() and kstrtodec64(). The exponent is added
> to the requested scale to work out how many integer and fractional digits
> are consumed. A negative effective exponent drops integer digits.
> 
> The digits are now scanned first and the string termination is checked
> before any conversion. A missing or malformed exponent ("1e", "1e+")
> returns -EINVAL. An exponent that overflows when added to the scale, or
> that makes the result exceed 64 bits, returns -ERANGE.

...

> +static int skip_digits(const char **s)

In case we need a new version, the skip_and_count_digits() fits better.

> +{
> +	const char *start = *s;
> +
> +	while (isdigit(**s))
> +		(*s)++;
> +
> +	return *s - start;
> +}

-- 
With Best Regards,
Andy Shevchenko


