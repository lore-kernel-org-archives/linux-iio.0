Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF9434E769;
	Fri, 27 Mar 2026 10:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774606883; cv=none; b=EdE6cVOzQ71sLaiD/durncnB8vku7nRL8ekJioEZjz9yswA4jn7wLmbInt6W81AVv4Xm1awQJyvvFKWbTTeJFIZeV2dpJhh81Tf6h3Eg5PTBq7v2WDj12v4vO6kaQ95oZbTs34+bcFSLj7z4cv0Y5asAkgOhfJYb/6EGMjqCNiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774606883; c=relaxed/simple;
	bh=KhTv+Nt7V0IOkV+PoWZHXzr5jPHmyejLL7h4ZDWD/Mo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bqy1DeFNyreAUlZhd0JqMPLsFcALvN58utp9XxG3PTnIw0Q/ITI1eaSXM7Gbby3QAaFACey9D08L1qTnDfd3Eqtmeccw9mcJlpbP/6RQSVkkOWmfFOQxMrYkC3a70gkVV/h2g428gH7d8Gz1M2z/IUJM+NV6g+0wFv0Q2uivy+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z8+W60Mf; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z8+W60Mf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774606882; x=1806142882;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KhTv+Nt7V0IOkV+PoWZHXzr5jPHmyejLL7h4ZDWD/Mo=;
  b=Z8+W60Mfg2n/g9ii9uHKJy5GPhRBnCOqyVv8Cs63OfDTk3gfcCCTyF8l
   gwYOQSOJDF9Og2kchiKhu63RITtL13P8Qodh9Cl29hqTmk1ETWFx0yllC
   9YLHMCIYc3sA0YrdrYNFLTfJdU6bNMRv2GLvbdEH/YBlAHacn3D6fre9X
   jK4FCozOKJ2rI8f14qnjFyNslIGX8WLcDNBYGOEW7gR15tN/ZuSNpPR6+
   DO8zf7QUwYbQZ0KoH/rfjW8n6axzkYbc7/5y8h707wBT1T1vBETCCa3Ih
   LyvTTxfPLQLgxlh3a+XW++jMFlJlOOCwvGVCabdK3pZvyJLnB1i0FxDan
   g==;
X-CSE-ConnectionGUID: UiHOJ2NRQR2FeifoIGPjsA==
X-CSE-MsgGUID: EdIzoyDEQcqDmNEPR5Daqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="93258769"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="93258769"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 03:21:22 -0700
X-CSE-ConnectionGUID: /AKdzB86Seyuz3wj5/MVtw==
X-CSE-MsgGUID: y0xkGxVRTDmCB+RX16pD7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="263216808"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.127])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 03:21:16 -0700
Date: Fri, 27 Mar 2026 12:21:13 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>, rodrigo.alencar@analog.com,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
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
	Steven Rostedt <rostedt@goodmis.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v9 2/9] lib: vsprintf: export simple_strntoull() in a
 safe prototype
Message-ID: <acZaGUV0MwuHNDru@ashevche-desk.local>
References: <20260320-adf41513-iio-driver-v9-0-132f0d076374@analog.com>
 <20260320-adf41513-iio-driver-v9-2-132f0d076374@analog.com>
 <acZDneLrIPOmU5ci@pathway.suse.cz>
 <acZLHAT5qJyjKTsp@ashevche-desk.local>
 <4uijfg4efzaapu3esobez55hfwqzszwagpeb4lxej2ybmifu76@s3c57fmnsme6>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4uijfg4efzaapu3esobez55hfwqzszwagpeb4lxej2ybmifu76@s3c57fmnsme6>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Mar 27, 2026 at 10:11:56AM +0000, Rodrigo Alencar wrote:
> On 26/03/27 11:17AM, Andy Shevchenko wrote:
> > On Fri, Mar 27, 2026 at 09:45:17AM +0100, Petr Mladek wrote:
> > > On Fri 2026-03-20 16:27:27, Rodrigo Alencar via B4 Relay wrote:

...

> > > > +extern ssize_t __must_check simple_strntoull(const char *startp, const char **endp,
> > > > +					     unsigned int base, size_t max_chars,
> > > > +					     unsigned long long *res);
> > > 
> > > Sigh, naming is hard. I personally find it a bit confusing that the
> > > name is too similar to the unsafe API.
> > > 
> > > IMHO, the semantic of the new API is closer to kstrtoull().
> > > It just limits the size, so I would call it kstrntoull().
> > 
> > It's not. kstrto*() quite strict about the input, this one is actually relaxed
> > variant, so I wouldn't mix these two groups.
> > 
> > > Also I would use int as the return parameter, see below.

...

> > TBH, I am skeptical about this approach. My main objection is max_chars
> > parameter. If we want to limit the input strictly to the given number of
> > characters, we have to copy the string and then just use kstrto*() in a normal
> > way. The whole idea of that parameter is to be able to parse the fractional
> > part of the float number as 'iiiii.fffff', where 'i' is for integer part, and
> > 'f' for the fractional. Since we have *endp, we may simply check that.
> 
> A max_chars would not be only useful for that. It can prevent out-of-bounds
> reads when the input isn't NUL-terminated (like buffers, file chunks,
> network packets, memory-mapped data, ....). Even if there is a NUL later in
> memory, a regular strtoull() function may consume characters that are outside
> the field one intends to parse.

Okay, but is it the current case or just an attempt to solve the problem that
doesn't exist (yet)?

> > In case if we want to parse only, say, 6 digits and input is longer there are
> > a few options (in my personal preferences, the first is the better):
> > - consider the input invalid
> > - parse it as is up to the maximum and then do ceil() or floor() on top of that
> > - copy only necessary amount of the (sub)string and parse that.
> 
> Yes, my use case is the fixed point parsing, but I suppose we are implementing
> things here for reuse.

Yes, I'm full for reuse, but I want to have it balanced between complexity,
existing use cases and possible reuse in the future.

> Also, the default behavior of the previous fixed point
> parsing in IIO is flooring the result, which leads to the same result as
> ignoring further digits.

Correct, I also lean to implying floor() (as you can read below).

> > The problem with precision is that we need to also consider floor() or ceil()
> > and I don't think this should be burden of the library as it's individual
> > preference of each of the callers (users). At least for the starter, we will
> > see if it's only one approach is used, we may incorporate it into the library
> > code.
> > 
> > The easiest way out is to just consider the input invalid if it overflows the
> > given type (s32 or s64).
> > 
> > But we need to have an agreement what will be the representation of the
> > fixed-width float numbers in the kernel? Currently IIO uses
> > 	struct float // name is crafted for simplicity
> > 	{
> > 		int integer;
> > 		int fraction;
> > 	}
> 
> Yes, but to represent things like that, an assumption is made to the precision that
> "fraction" carries.

Correct.

> > This parser wants AFAIU to have at the end of the day something like
> > 
> > 	struct float
> > 	{
> > 		s64 integer;
> > 		s64 fraction;
> > 	}
> > 
> > but also wants to have the fraction part be limited in some cases to s32
> > or so:
> > 
> > 	struct float
> > 	{
> > 		s64 integer;
> > 		s32 fraction; // precision may be lost if input is longer
> > 	}
> > 
> > Maybe we want to have kstrtof32() and kstrtof64() for these two cases?
> > 
> > With that we will always consider the fraction part as 32- or 64-bit,
> > imply floor() on the fraction for the sake of simplicity and require
> > it to be NUL-terminated with possible trailing '\n'.
> 
> I think this is a good idea, but calling it float or fixed point itself
> is a bit confusing as float often refers to the IEEE 754 standard and
> fixed point types is often expressed in Q-format.

Yeah... I am lack of better naming.

-- 
With Best Regards,
Andy Shevchenko


