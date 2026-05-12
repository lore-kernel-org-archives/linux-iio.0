Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029B83B5F67;
	Tue, 12 May 2026 14:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778596548; cv=none; b=ZvxOXJ5wbZ8FCEt7iJLS8vtxova6BLG1muweicDbmFCRcSp0B3fURWZR+LpHxI3z2kx4FKgBFxSqzhc8ucXuXzMNtU+fRrQ9fErvzzcu0WTCBChe+gjzHv9K3MTWykGR0EKpkPIGN0UPcj6pt431CZEanHcjeRxyLPKcph3qhdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778596548; c=relaxed/simple;
	bh=hvdPz87c7qZdxSSSB7hzjsR9y4UsH//SdDzMvwF4jfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cNHvrV7uxD3Kin0Rs8RR/ZuNuOSunHknD2jfxcv0pa0YiQPxep+IQR8bEzS53D/FGir8tMK0n31VMPpT7qqY27sLbol+Xs+1qtbMGGBtOgzGnAJuiRv4dvcq7zm/zVMTwY2jyNWKTUhZqRbu3f3RYZ5Z/vMpTpQN82RsQmIonTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jF6bMc+a; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jF6bMc+a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778596547; x=1810132547;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hvdPz87c7qZdxSSSB7hzjsR9y4UsH//SdDzMvwF4jfU=;
  b=jF6bMc+aVwcfoHa33xoV7jX8K9/qEyuH+2q/MStT827nxjq3bsa3RGDO
   +Y3YGALp7LpM45kPSBsq4Zy6IpxkkpksWeqfLgwtIKdIOzMxiORkpkHen
   SdvDzOMBRYHb2F2rbQ68fY9kJI2/Riud3jNcTlKQQ553I4dQ/c04CWXUm
   Tj4uDOvkfWHUHZvugObCbKDa1jL99BdFnvZ9/YZeanqW9FM+YNeThoQNe
   Jp6A7Pg2t/H4AtRmiNGrNahkKKtUaXBY+s2XX6yRuqR4h7Nrb38JjwyNn
   Q6XAmJYjJitw4LM6LfAlwKMggFjP7lYJtmPdoq4CKYPJxAJv8b5dEfo2d
   Q==;
X-CSE-ConnectionGUID: J/a35NSITu2vWO8IaMPhrg==
X-CSE-MsgGUID: +1qvTorISRGRkqS/Hv81Zg==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="79526492"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="79526492"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 07:35:46 -0700
X-CSE-ConnectionGUID: 2PVtN+CoTQSucEDvtijdtw==
X-CSE-MsgGUID: BmHGMPevQn2s7NEwtqpRdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="231380705"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.112])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 07:35:41 -0700
Date: Tue, 12 May 2026 17:35:39 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v12 05/11] iio: core: add decimal value formatting into
 64-bit value
Message-ID: <agM6uzhdn7o8g9v5@ashevche-desk.local>
References: <20260510-adf41513-iio-driver-v12-0-34af2ed2779f@analog.com>
 <20260510-adf41513-iio-driver-v12-5-34af2ed2779f@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260510-adf41513-iio-driver-v12-5-34af2ed2779f@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, May 10, 2026 at 01:42:23PM +0100, Rodrigo Alencar via B4 Relay wrote:

> Create new format types for iio values (IIO_VAL_DECIMAL64_*), which
> defines the representation of fixed decimal point values into a single
> 64-bit number. This new format increases the range of represented values,
> allowing for integer parts greater than 2^32, as bits are not "wasted"
> in the fractional part, which can be seen in IIO_VAL_INT_PLUS_MICRO and
> IIO_VAL_INT_PLUS_NANO. Helpers are created to compose and decompose 64-bit
> decimals into integer values used in IIO formatting interfaces, which
> creates consistency and avoid error-prone manual assignments when using
> wordpart macros. When doing the parsing, kstrtodec64() is used with the
> scale defined by the specific decimal format type.

...

> +	case IIO_VAL_DECIMAL64_MILLI:
> +	case IIO_VAL_DECIMAL64_MICRO:
> +	case IIO_VAL_DECIMAL64_NANO:
> +	case IIO_VAL_DECIMAL64_PICO:
> +	{
> +		s64 frac;
> +		unsigned int scale = type - IIO_VAL_DECIMAL64_BASE;

Can we stick with reversed xmas tree order?

> +		tmp2 = div64_s64_rem(iio_val_s64_from_array(vals),
> +				     int_pow(10, scale), &frac);
> +		if (tmp2 == 0 && frac < 0)
> +			return sysfs_emit_at(buf, offset, "-0.%0*lld", scale,
> +					     abs(frac));
> +		else
> +			return sysfs_emit_at(buf, offset, "%lld.%0*lld", tmp2,
> +					     scale, abs(frac));
> +	}

What about

		/* Print a leading '-' for negative fractions */
		if (tmp2 == 0 && frac < 0)
			offset += sysfs_emit_at(buf, offset, "-");

		return sysfs_emit_at(buf, offset, "%lld.%0*lld", tmp2, scale, abs(frac));

Also note this won't work with the frac that are == S64_MIN. It's UB (undefined
behaviour), see the comment at abs() implementation. Maybe a time to add abs()
corner case tests...

...

>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
> -	int ret, fract_mult = 100000;
> +	int type, ret, fract_mult = 100000, dec_scale = 0;

I wouldn't mix ret here and put it...

>  	int integer, fract = 0;
>  	long long integer64;
>  	bool is_char = false;

...as standalone here

	int ret;


...

> +#include <linux/wordpart.h>

+ blank line.

>  #include <uapi/linux/iio/types.h>

...

>  #define IIO_VAL_FRACTIONAL_LOG2 11
>  #define IIO_VAL_CHAR 12
>  
> +#define IIO_VAL_DECIMAL64_BASE		100

Okay, but I would rather see something smaller like 32 or 64.

...

> +static inline s64 iio_val_s64_compose(int val0, int val1)

Hmm... s64 composed form two int:s...

> +{
> +	return (s64)(((u64)val1 << 32) | (u32)val0);
> +}
> +
> +static inline s64 iio_val_s64_from_array(const int *vals)

When I see 'array' in the name, I think of real array and some index. Here is
no index available. Perhaps

static inline s64 iio_val_s64_from_s32s(const s32 *vals)

> +{
> +	return iio_val_s64_compose(vals[0], vals[1]);
> +}
> +
> +static inline void iio_val_s64_decompose(s64 dec64, int *val0, int *val1)
> +{
> +	*val0 = lower_32_bits(dec64);
> +	*val1 = upper_32_bits(dec64);
> +}
> +
> +static inline void iio_val_s64_array_populate(s64 dec64, int *vals)

_to_array() or _to_s32s()

> +{
> +	iio_val_s64_decompose(dec64, &vals[0], &vals[1]);
> +}

-- 
With Best Regards,
Andy Shevchenko


