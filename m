Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39022E65D;
	Wed,  4 Feb 2026 01:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770169543; cv=none; b=l5ntgBc7HFR+NdQBSZjHQkrLYxVI7gJqSsPHd9aE6/ADhMpcVUwfFMvxVBdjE50rc9ieG6B+6LJjtCjcOEImBWgGKyVCp4vwxz6wNFPQzcfPn+F5mO+Y+5AjWN5pjeW6HHjdJhZm477RhcsIEIjiCHlqImb+mFHfjONAUBG6SZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770169543; c=relaxed/simple;
	bh=YiABNjtqxGsl4v+Aef/koK3zybLExycxmkylXR0NkLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nNPMue3xp6e9nROWs2mryztTHVRkPROyzzW4k2XL7QMz//UsCLbobIWbszJfP7R5032bx2p+8fpfGJr2sbfZQDONoTd5bJQoONVwU9r8kceBdAy13OWpV+dKOyP6Qr4G43giu1P8Wi/XWq+tfS2AvrdS5cjNedbpbpsfxSXt5cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WJTiDp34; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WJTiDp34"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770169541; x=1801705541;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YiABNjtqxGsl4v+Aef/koK3zybLExycxmkylXR0NkLM=;
  b=WJTiDp345RuZA91pJPPL0lnK0WKaqksgjEo24XBA0joW0JwTC8Z1Mvuo
   haLNpq+M/0VjWlUufryZVzELI3+xkbXkppZDlHFg7F1R4aX/uIHNFUK2x
   iz+Xzm+jY2drsQz2BWWb/6luXY3NOpovtihNWjC4uasWMLB+irtaF8o95
   jds+gZ75eeCsHBPXdEigFunckRj58MODueWxAMG8m4cMqCq4aqxMcJdPW
   ZoZAXLv6E/A5VJ5K291sn9CJoVYHAe4std4WC/tS1fciKge4aYyoWqA7Y
   cToMojyhRpFFq4mEsD7mTdtn25/KKKRxZTQ4lGKJR53n43O++NIaxyECI
   w==;
X-CSE-ConnectionGUID: y2GWe0hiQlKCVBhEd++b/A==
X-CSE-MsgGUID: rPGlRoRNRhucPB9FrErGPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="70552212"
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="70552212"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 17:45:40 -0800
X-CSE-ConnectionGUID: VuQZQQs7Rf6DdquKrzRZQw==
X-CSE-MsgGUID: j3ODpeaBSSmdHo+qaUY7pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="210093354"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.168])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 17:45:37 -0800
Date: Wed, 4 Feb 2026 03:45:35 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: rodrigo.alencar@analog.com
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v6 2/8] iio: core: add fixed point parsing with 64-bit
 parts
Message-ID: <aYKkv3dq9Vkm3s_3@smile.fi.intel.com>
References: <20260130-adf41513-iio-driver-v6-0-cf46239026bc@analog.com>
 <20260130-adf41513-iio-driver-v6-2-cf46239026bc@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260130-adf41513-iio-driver-v6-2-cf46239026bc@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jan 30, 2026 at 10:06:43AM +0000, Rodrigo Alencar via B4 Relay wrote:

> Add iio_str_to_fixpoint64() function that leverages simple_strtoull()
> to parse numbers from a string.
> A helper function __iio_str_to_fixpoint64() replaces
> __iio_str_to_fixpoint() implementation, extending its usage for
> 64-bit fixed-point parsing.

...

> +/**
> + * iio_safe_strntou64() - Parse u64 from string checking for overflow safety
> + * @str: The string to parse
> + * @endp: output pointer to the end parsing position
> + * @result: parsed value
> + * @max_chars: maximum number of digit characters to read
> + *
> + * This function is used in fixed-point parsing and it iterates over a const
> + * char array. It might duplicate behavior of simple_strtoull() or kstrtoull(),
> + * but those have their own limitations:
> + * - simple_strtoull() is not overflow-safe and its usage is discouraged;
> + * - kstrtoull() is safe, but requires termination and it would required a copy
> + *   of the string to a temporary buffer.
> + *
> + * The implementation of this function is similar to _parse_integer_limit()
> + * available in lib/kstrtox.h, but that header/function is not available to be
> + * used in kernel modules. Hence, this implementation may need to change or
> + * removed to reuse a new suitable helper that is properly exposed.
> + *
> + * Returns:
> + * number of parsed characters on success, -ERANGE on overflow
> + */
> +static ssize_t iio_safe_strntou64(const char *str, const char **endp,
> +				  u64 *result, size_t max_chars)
> +{
> +	u64 digit, acc = 0;
> +	ssize_t idx = 0;
> +
> +	while (isdigit(str[idx]) && idx < max_chars) {
> +		digit = str[idx] - '0';
> +		if (unlikely(acc & (~0ull << 60))) {
> +			if (check_mul_overflow(acc, 10, &acc) ||
> +			    check_add_overflow(acc, digit, &acc))
> +				return -ERANGE;
> +		} else {
> +			acc = acc * 10 + digit;
> +		}
> +		idx++;
> +	}
> +
> +	*endp = str + idx;
> +	*result = acc;
> +	return idx;
> +}

There is a development in the parse_integer in the lib/. I reviewed that series
and hopefully it will go in. With that done, we better reuse the lib/ function.

https://lore.kernel.org/linux-hardening/20260202115451.290173-1-dmantipov@yandex.ru/

-- 
With Best Regards,
Andy Shevchenko


