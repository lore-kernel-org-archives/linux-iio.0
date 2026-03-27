Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E523DBD60;
	Fri, 27 Mar 2026 09:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774603077; cv=none; b=KW6gAxNI6oo2WA8e5wpNFy23nKzJCy2hgBnV7RPsIEVi13DQlOnX2IkpTcW0gqUj7A2cYP9IfFZsPt0R2TsJ4JUt22yXhDT0URG86+evz068egu62DD/sKqFO7w009aEXa11NTEXCLxUnBnVwYn8rHrtpgUxTRYtG6hnDFP3EEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774603077; c=relaxed/simple;
	bh=9xnqu2U78yxsRU0eiXXKO5PGtS5N+f/3OEQ7NZl2GBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=blp4UFeO64vowknMRrda5RnVDoRmi7qJi6MDA9q3e3cPV7XrPRtTnLG0m+Dqm65vQdQMu9FCgXdv8zfmeg9litwYj6k9RI12srlprhmf0la967hdiWytB+UJp2hxDSn8jSVYkXc96jeZtBR2rG7ZHAlqK7FLy9GkZbUdribPtt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TsqK+uwa; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TsqK+uwa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774603073; x=1806139073;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9xnqu2U78yxsRU0eiXXKO5PGtS5N+f/3OEQ7NZl2GBk=;
  b=TsqK+uwa6BvzaN5D/K9dVqp4NhmWDvdDk3Ekjzk+naS1S3ss8XFrSn7P
   Hwrh8jH+qeaBdYC9KhtdPFQgHVgD5j3rVc3MRfRcGizI0yn34WFW5h648
   egrexH4/pr7M5c45dSs3zkn5DQm5GOWujxoSwEr5UVcnpLahU0Bg+haRI
   p0p9VzwhGpUIrAr52KzogyBmMqTOU9N021DtynN9FYkdstc2yLIkx1kk/
   gBmY00b4T5rAT9475D3WRvI4f6NaJWoqITuG4Q8e1F6FJxJHhBvLjKXvv
   7dZqNGXUg8LzxBXxIzxTFDDDO7PVmUGJZjQIcUsBQ08mfpQxe6WpGuH8R
   A==;
X-CSE-ConnectionGUID: 7TTk/09ZRAmFYiDfqIXfXA==
X-CSE-MsgGUID: aVjMHnQnQQiDE79GrXjuAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="79577066"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="79577066"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 02:17:25 -0700
X-CSE-ConnectionGUID: 4HWi7vfyT8eKdVXZB3VlOg==
X-CSE-MsgGUID: tsARdpr2SEWYEr1ISoA7Mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="230190503"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.127])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 02:17:18 -0700
Date: Fri, 27 Mar 2026 11:17:16 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Petr Mladek <pmladek@suse.com>
Cc: rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
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
Message-ID: <acZLHAT5qJyjKTsp@ashevche-desk.local>
References: <20260320-adf41513-iio-driver-v9-0-132f0d076374@analog.com>
 <20260320-adf41513-iio-driver-v9-2-132f0d076374@analog.com>
 <acZDneLrIPOmU5ci@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acZDneLrIPOmU5ci@pathway.suse.cz>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Mar 27, 2026 at 09:45:17AM +0100, Petr Mladek wrote:
> On Fri 2026-03-20 16:27:27, Rodrigo Alencar via B4 Relay wrote:

...

> > +extern ssize_t __must_check simple_strntoull(const char *startp, const char **endp,
> > +					     unsigned int base, size_t max_chars,
> > +					     unsigned long long *res);
> 
> Sigh, naming is hard. I personally find it a bit confusing that the
> name is too similar to the unsafe API.
> 
> IMHO, the semantic of the new API is closer to kstrtoull().
> It just limits the size, so I would call it kstrntoull().

It's not. kstrto*() quite strict about the input, this one is actually relaxed
variant, so I wouldn't mix these two groups.

> Also I would use int as the return parameter, see below.

...

TBH, I am skeptical about this approach. My main objection is max_chars
parameter. If we want to limit the input strictly to the given number of
characters, we have to copy the string and then just use kstrto*() in a normal
way. The whole idea of that parameter is to be able to parse the fractional
part of the float number as 'iiiii.fffff', where 'i' is for integer part, and
'f' for the fractional. Since we have *endp, we may simply check that.

In case if we want to parse only, say, 6 digits and input is longer there are
a few options (in my personal preferences, the first is the better):
- consider the input invalid
- parse it as is up to the maximum and then do ceil() or floor() on top of that
- copy only necessary amount of the (sub)string and parse that.

The problem with precision is that we need to also consider floor() or ceil()
and I don't think this should be burden of the library as it's individual
preference of each of the callers (users). At least for the starter, we will
see if it's only one approach is used, we may incorporate it into the library
code.

The easiest way out is to just consider the input invalid if it overflows the
given type (s32 or s64).

But we need to have an agreement what will be the representation of the
fixed-width float numbers in the kernel? Currently IIO uses
	struct float // name is crafted for simplicity
	{
		int integer;
		int fraction;
	}

This parser wants AFAIU to have at the end of the day something like

	struct float
	{
		s64 integer;
		s64 fraction;
	}

but also wants to have the fraction part be limited in some cases to s32
or so:

	struct float
	{
		s64 integer;
		s32 fraction; // precision may be lost if input is longer
	}

Maybe we want to have kstrtof32() and kstrtof64() for these two cases?

With that we will always consider the fraction part as 32- or 64-bit,
imply floor() on the fraction for the sake of simplicity and require
it to be NUL-terminated with possible trailing '\n'.

-- 
With Best Regards,
Andy Shevchenko


