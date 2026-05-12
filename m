Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5DB32143D;
	Tue, 12 May 2026 14:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778597039; cv=none; b=ATcqm/3RlYhmcQP6UHxkkiQbk7u4ifXrOMWHwr/WIR6grV9+76T5Wm0YGRmRFuY615k4SHXTSp8UyeoFvB7LoZT6M/aAW8KJZBdF0xa8Xy/cXbdWSy0WWe3s2WwMJO9TA1RaG3AKRCuZkcZprIrpje3d+rTRxnGp0yd7UCrOXtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778597039; c=relaxed/simple;
	bh=R/jhBIChVXR9kgDOd+WISzPt857TrAdWxKQz2nBrnrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F+BYDqsIOdKc84apWOostO5KqlYC8K1HrrO6kpro+/p/Yyh71iFP25B8W1cxX8qrLJBWYHLIMgmpmfThuOBgdJEXTz6WkfS/TtB9aNH+iGQ592Nx6I0JL8bjPsvhBT6pNe1u+fOTBwH2Kwv96hPGXAiWzCJYuadfb7uCg2vwvgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oAsvFXSa; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oAsvFXSa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778597037; x=1810133037;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=R/jhBIChVXR9kgDOd+WISzPt857TrAdWxKQz2nBrnrs=;
  b=oAsvFXSabNAc63pNQq5q0A723wie7n5EVd0/Y59qMB0vREq18G4bSIpi
   Y+Od07+nATZS/sShNft8aSRyGb3z7bJlCXtWuq5gGNUXgrKDuhT2cgSZX
   uIAzidKU5Vi2Eh/yh7ZRnh0DRJjRlbJaq/f/D34P/nV4Jh0Dw6quLiD52
   ESPmpRmeacrYjJG7kr6L5fW3d5GYJurjhM8UN94whF8Uv8ImAw8QxeQb1
   WiF6AfnZ6PgN7Nl7dpcJ8mhrjnul0tFUm5qGfMNyKCqAejk9bJOlyfX/9
   0RoPd3O3oAUMCxA6tBsiGxnP56cAsynnn7HelpsGwkgG9eyRC/aOgEtEb
   g==;
X-CSE-ConnectionGUID: tkEaFxxDR72D+owv0RYPFA==
X-CSE-MsgGUID: PeSqdWSQTp6OfWu5WKsWQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="79455322"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="79455322"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 07:43:57 -0700
X-CSE-ConnectionGUID: 10bEOBdlTOGu130+WC0xcw==
X-CSE-MsgGUID: pPYNsW0wRmOrhbpoh4wDbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="268130406"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.112])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 07:43:51 -0700
Date: Tue, 12 May 2026 17:43:49 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>,
	rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org, David Lechner <dlechner@baylibre.com>,
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
	Shuah Khan <skhan@linuxfoundation.org>,
	David Laight <david.laight.linux@gmail.com>
Subject: Re: [PATCH v12 02/11] lib: kstrtox: add kstrtoudec64() and
 kstrtodec64()
Message-ID: <agM8pWrM6j_XksvN@ashevche-desk.local>
References: <20260510-adf41513-iio-driver-v12-0-34af2ed2779f@analog.com>
 <20260510-adf41513-iio-driver-v12-2-34af2ed2779f@analog.com>
 <20260512123953.40d80bc9@jic23-huawei>
 <agMnWzMjW1LwCSyT@ashevche-desk.local>
 <sj6cpjhakyfvv6rgox6cnhl2u2tgaecugcok6fw2l7zgku5wtc@aqx3ul72vgca>
 <agMvlS3-0wvGmBwh@ashevche-desk.local>
 <dxjg2sdyxb7ieb4abmeyyye7qok6cczrxabpsjyjhcbehwoec3@sbbqoo4wmzre>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dxjg2sdyxb7ieb4abmeyyye7qok6cczrxabpsjyjhcbehwoec3@sbbqoo4wmzre>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, May 12, 2026 at 03:12:24PM +0100, Rodrigo Alencar wrote:
> On 26/05/12 04:48PM, Andy Shevchenko wrote:
> > On Tue, May 12, 2026 at 02:21:14PM +0100, Rodrigo Alencar wrote:
> > > On 26/05/12 04:12PM, Andy Shevchenko wrote:
> > > > On Tue, May 12, 2026 at 12:39:53PM +0100, Jonathan Cameron wrote:
> > > > > On Sun, 10 May 2026 13:42:20 +0100
> > > > > Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
> > > > > 
> > > > > > Add helpers that parses decimal numbers into 64-bit number, i.e., decimal
> > > > > > point numbers with pre-defined scale are parsed into a 64-bit value (fixed
> > > > > > precision). After the decimal point, digits beyond the specified scale
> > > > > > are ignored.
> > > > > 
> > > > > Whilst Rodrigo has already replied to say there will be another version
> > > > > I'd like to request final feedback from those who were involved in the parser
> > > > > discussions.  
> > > > > 
> > > > > They got very involved and I'm far from an expert in the right way to do
> > > > > this stuff.  
> > > > > 
> > > > > I don't think David Laight was +CC so I've added that.
> > > > > David, Andy - I think you two were most involved in that discussion:
> > > > > Any objections to the end result? 
> > > > 
> > > > I already said a few times about the naming. I do not like the kstrto*()
> > > > be semantically different on how they treat the input. Second point is
> > > > to avoid code duplication, but this one is less of a concern since the
> > > > new code is in the library close to the other potentially duplicate code
> > > > piece and hence can be addressed later.
> > > 
> > > I suppose I reached into kstrtodec64() and kstrtoudec64() because it aligns
> > > with your expectations for kstrto*() semantics, no? Those include:
> > >  - overflow check;
> > >  - extensive input validation;
> > >  - optional '\n' in the end;
> > >  - mandatory nul-termination.
> > > 
> > > am I missing anything?
> > 
> > When we add scale we basically make that not true. Moreover the code in this
> > patch makes scale == number_of_characters which I think a bit fragile, however
> > it's about the fractional part when the amount of digits is equal to scale.
> 
> That is not really the case. It is being set as a limit, so it does check for
> truncation and zero-padding.

I do not see it happens in _parse_integer_limit(). It doesn't try to parse more
characters than it's requested in max_chars. It doesn't check if there are more
character nor their converted values.

> > To make this work as expected we need to add an additional call like
> > kstrtoull() (and perhaps drop that \n and NUL-terminator checks) and see
> > if that overflows or not. Since it's a fractional part it must have less
> > than 20 (decimal) digits there, so we check the rv (or how many digits
> > were parsed successfully) and compare to 20. If it's more, we got too many
> > decimal digits.
> 
> For overflow it checks the KSTRTOX_OVERFLOW flag and leverages check_mul_overflow()
> and check_add_overflow() when combining fractional and integer parts. The amount
> of characters is not really important there. The scale cannot be bigger than 19 and
> that makes sure that int_pow() does not overflow. The code uses _parse_integer_limit()
> due to the nature of input and to avoid 64-bit division, kstrtoull() at any point
> (parsing integer or fractional parts) does not make much sense.

Under 'like kstrotoull()' I meant something that repeats needed functionality.
I believe it's parse_integer() (without limit).

> > Maybe I'm missing these checks already performed?
> > 
> > > > Having the test cases is a big benefit, and that part I like the most.

-- 
With Best Regards,
Andy Shevchenko


