Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEDE3E1CF1;
	Fri, 27 Mar 2026 10:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774609086; cv=none; b=d2THp5a05OlufOsH0vCBq1bsj4XiXj1WdZpVDTvtQEMHwYmZd2RFJMhbfFgHoN1R8Pf47pEV8T0gGjiq3aRa3PG33NACv20o0CqrKMOnyE7/rQsZuby1o4P6DSLXDmqzDj+BI3zr5XWAruyHADmt1n8k4zi4p/o88++vPW842dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774609086; c=relaxed/simple;
	bh=U8MfkpjpjX3ULf08t5CyqwN0Jgzw0hwvnroRfmt14L8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g9BSTDsc5pdI0LumNoq4e61ilRhYScW5U6Qg3RkGo44WJpTu18XX+R/lyVFmeYkUAUeqk8hfgUmEjLBl7XyXcLCuAaqfUPUoFkjJXl748YWZRUjLkXz+dwDjMNQh2f9aBX2NWKL2ZzNc87aIAIkeoxpkhfG6EA/mXK61g2w1L/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gykRhtbj; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gykRhtbj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774609085; x=1806145085;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=U8MfkpjpjX3ULf08t5CyqwN0Jgzw0hwvnroRfmt14L8=;
  b=gykRhtbjWAIA11wm6N23W+PLnXkZiDb9o0j18evjRyjy10MwpWNasZoy
   2BDbQ6/5OCC19wyN31V33SuyuUXsYu/WtnwgShUtH7oHJSOReVSWyXGG7
   nM8lXpwCN+6Z10ul/C/ewcJBleH+BQbrJ6fNTEOO1KzB95mq3lSqN3K8h
   Y1bmDOeDHLsXek5V6l8XSLQiArrOeK/fIA1zFOF+wIRVdMaQmBeDONr1K
   LEyGZ1h4rqf/uFKtfCRRHGLDZ1j3lVZ2UNFSKU7BsYrARwn7lEf67nWGP
   0urgbNrBtDH//iLR+oT7YJAy+shy4eq4fHla4cF0sghpiDL7VE8xTFeDz
   g==;
X-CSE-ConnectionGUID: 8oGpaV1JQWipfZodcUWXfw==
X-CSE-MsgGUID: z7AE/N6oSHmVj2inyfpnxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="75878977"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="75878977"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 03:58:04 -0700
X-CSE-ConnectionGUID: inGQ+/sZTU2BSMZEnyrViw==
X-CSE-MsgGUID: Xnm8UGoCReugSvkZSrETuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="229762085"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.127])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 03:57:59 -0700
Date: Fri, 27 Mar 2026 12:57:56 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: David Laight <david.laight.linux@gmail.com>
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
Message-ID: <acZitENbWQF7cmDA@ashevche-desk.local>
References: <20260320-adf41513-iio-driver-v9-0-132f0d076374@analog.com>
 <20260320-adf41513-iio-driver-v9-2-132f0d076374@analog.com>
 <acZDneLrIPOmU5ci@pathway.suse.cz>
 <acZLHAT5qJyjKTsp@ashevche-desk.local>
 <20260327104440.079343c9@pumpkin>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260327104440.079343c9@pumpkin>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Mar 27, 2026 at 10:44:40AM +0000, David Laight wrote:
> On Fri, 27 Mar 2026 11:17:16 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

...

> > TBH, I am skeptical about this approach. My main objection is max_chars
> > parameter. If we want to limit the input strictly to the given number of
> > characters, we have to copy the string and then just use kstrto*() in a normal
> > way. The whole idea of that parameter is to be able to parse the fractional
> > part of the float number as 'iiiii.fffff', where 'i' is for integer part, and
> > 'f' for the fractional. Since we have *endp, we may simply check that.
> > 
> > In case if we want to parse only, say, 6 digits and input is longer there are
> > a few options (in my personal preferences, the first is the better):
> > - consider the input invalid
> > - parse it as is up to the maximum and then do ceil() or floor() on top of that
> > - copy only necessary amount of the (sub)string and parse that.
> 
> Isn't there a bigger problem?
> If you want a max of 6 digits you need to correctly parse 3.1 3.159265
> 3.159256358979 3.0001 3.000159 3.00015926535 3.000100 (etc).
> That seems to always require checking the length and then multiply/divide
> by 10.

Yep.

> Then there is 'round to even' which rounds these two in opposite directions:
>    4.500000000000000000000000000000000000000000000000000
>    4.500000000000000000000000000000000000000000000000001

These are wrong inputs and if we want to have them cut, it will be just a cut.
(Yeah, which will have different result for negative numbers.)

> I suspect you really want a completely different function for reading
> fractional parts of floating point numbers.
> It isn't as though the actual digit conversion is hard.
> 
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
> > 
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
> 
> Are those 'fraction' counts of (say) 10^-6 (like times in seconds+usecs)
> or true binary values where the value could be treated as a u64 (or u128)
> for addition and subtraction.

It depends. IIO has scale on top of that, so the fraction part can be 10⁻³,
10⁻⁶, 10⁻⁹. I don't remember by heart if the ABI requires all digits to be
placed, I think we don't require that.

> So parse the latter you don't need to know the length
> (and it can be converted the to former by multiplying by 10^6).
> 
> > Maybe we want to have kstrtof32() and kstrtof64() for these two cases?
> > 
> > With that we will always consider the fraction part as 32- or 64-bit,
> > imply floor() on the fraction for the sake of simplicity and require
> > it to be NUL-terminated with possible trailing '\n'.

-- 
With Best Regards,
Andy Shevchenko


