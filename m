Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42614277029;
	Sun, 17 May 2026 10:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779012972; cv=none; b=IU3SRyUzfOt1sEMtD/rrIFyYegH8qHMxp5pRnONGuTveP0zhoyv/W9bn+08IzChpX30u0rrwLQmyXdhfKngAn0XPY9SgX7kT/fLG3iS8hbYsAnD++iVGwpPOMg1ppVAMsQ8LOiCUbmYWiDHi3C71PUAU32l6VVLCJo1GGJkHKZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779012972; c=relaxed/simple;
	bh=mMEYe2IXf84yppCn3wo1LKLlecO1k2Eng9bC+NciIgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dsDOCwcHwa01RelEjrrSqBKQK5xFq+l2gRi0nIqCIeB4fzBZ2MqpZDSEMplCjsLHu9aE0FxmLDVPBV4AAqLdbbtAlrvo98BC6/OuoC+TYEtHm2zvVULLbCXOzMyd4fZAIrOwlIJmUky5imlKZC1s+UMI2LFbgbimy83NBbml018=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CMmuQa+d; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CMmuQa+d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779012971; x=1810548971;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mMEYe2IXf84yppCn3wo1LKLlecO1k2Eng9bC+NciIgE=;
  b=CMmuQa+dL+RKUyMhjKijAFK9RfxFaHqYwtnbrw17x5jwx82aE5L40Xr1
   f+uxC1ZHKKIeS97ibe/hSYEK7D/1Pu5Yx7Omp1gsznTLFrnwnkM1kzxUU
   2YsO9cajAieYOvurfVYk3Ml0Wn6Qn3poHjGQ5AIg191GGU4Ng0LDigV8f
   hac9dd8hF25hu7Ij2bK6kqcN3n5zwKAqWKbzjS7WrM4SRcGjIle0wVDFU
   MS7gYiGMd5yYgmoDSJ5dlwZv+ZhvVXC/Dne9cOlg1hgDH/icQG3XWxY7B
   zAqtOWkkja0CBtRkJJqbusqu2+Lb+MedBoaBlKVfX2pTUuwze57mCebib
   Q==;
X-CSE-ConnectionGUID: PAGbf+mtRgq/kXr8ci1UyQ==
X-CSE-MsgGUID: 13sLIQkPQOO9mHCVZro7Iw==
X-IronPort-AV: E=McAfee;i="6800,10657,11788"; a="90474531"
X-IronPort-AV: E=Sophos;i="6.23,239,1770624000"; 
   d="scan'208";a="90474531"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2026 03:16:10 -0700
X-CSE-ConnectionGUID: rg1+4YVmS4qYjcnXJnRLAA==
X-CSE-MsgGUID: P6+sOOD/RJm3sUd55czwNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,239,1770624000"; 
   d="scan'208";a="244118817"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.182])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2026 03:16:05 -0700
Date: Sun, 17 May 2026 13:16:02 +0300
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
Subject: Re: [PATCH v13 06/12] iio: core: add decimal value formatting into
 64-bit value
Message-ID: <agmVYvWBmLI4A65m@ashevche-desk.local>
References: <20260517-adf41513-iio-driver-v13-0-bb6e134a360f@analog.com>
 <20260517-adf41513-iio-driver-v13-6-bb6e134a360f@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260517-adf41513-iio-driver-v13-6-bb6e134a360f@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, May 17, 2026 at 10:14:01AM +0100, Rodrigo Alencar via B4 Relay wrote:

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

> +	{
> +		int scale = type - IIO_VAL_DECIMAL64_BASE;

> +		int l = 0;

Perhaps make it global in the function? We have the same in
IIO_VAL_INT_MULTIPLE case.

> +		s64 frac;
> +
> +		tmp2 = div64_s64_rem(iio_val_s64_from_s32s(vals),
> +				     int_pow(10, scale), &frac);
> +		if (tmp2 == 0 && frac < 0)
> +			l += sysfs_emit_at(buf, offset, "-");
> +
> +		l += sysfs_emit_at(buf, offset + l, "%lld.%0*lld", tmp2, scale,
> +				   abs(frac));
> +		return l;
> +	}

...

>  #ifndef _IIO_TYPES_H_
>  #define _IIO_TYPES_H_

Also needs types.h now... Which makes me think if the proposed macros are
placed in the good enough location.

(Note, iio/iio.h missing actually types.h, but includes it indirectly.)

-- 
With Best Regards,
Andy Shevchenko


