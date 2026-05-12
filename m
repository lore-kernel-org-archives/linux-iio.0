Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0033E1736;
	Tue, 12 May 2026 13:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778593695; cv=none; b=KZeOamS6MhK7FKmJC6JB0AA9VZaYm5kKwnrSsfUmVweQ9O7rk8sF7EhtvUu4gtB0P5NJ6fLCkTCLORAIVjuAdrcJDjBksYANySG3eFNEAMQQn2dTNvwvGzt3wDN+ogDoPdsXdVNpWNb8z9ol01ZTeA3xQ3kZpD6Dqiinbp7jHYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778593695; c=relaxed/simple;
	bh=r+bP2PcvT8EXMJqvaFH8Gm6ju6GZHFtWA7Wop977om4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XblhW4vqhMBdH4708Cl3WQz15hlX4YQrI/GlkjapfBb/AH9gxM05cs/gUeTVUH3edFLARCFp/knYDvPTA36pPjO5xROTtD8RQSeQCcAaAwZYybn5zBzfQfWjBJGYrpL6nT/JqPOhx6xRkYaxfZzNSFGtsAIi8PlsFAYXreFC3Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Umci97+K; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Umci97+K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778593693; x=1810129693;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=r+bP2PcvT8EXMJqvaFH8Gm6ju6GZHFtWA7Wop977om4=;
  b=Umci97+Krq1louP3kmzwhnyVK514lipQFiFo/WculOkDDTC2ej8QUAMX
   9fXMuLb3cIf6wu7jInElLbiLjIZtM3RGXOK1r5lf/7KovkQeB+2nGKIDm
   mrsYxgQBBZ7qEfP5wywkLxc/ihSrTVixC/5iZ9ltAPACK+fqzYb9A0OJO
   kb+9YZAomAYoFBwmbr/16hd3d9XPTGEGFBify68DK8YEWjmXLBXvqjQtl
   s5kGtLyVevRZtVzxNoHyF3+9TPc8IbV8GPDWZxYCf2+yjuZWsv0oC6V0x
   uC9uLBOGHFWmKXncrP52qvOMgD+4yff+pvzdA2dAnMbzYlerfoQaJn0rG
   A==;
X-CSE-ConnectionGUID: CVuA39YOR7WhgrpBVxFC4w==
X-CSE-MsgGUID: KalNDiKoQkOpSIE8kwyqeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="79450068"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="79450068"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 06:48:12 -0700
X-CSE-ConnectionGUID: A6rYsYftRP+xU5l/JXC8bg==
X-CSE-MsgGUID: RpfTNLa6R8qT/cGIRZvfRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="261522951"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.112])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 06:48:07 -0700
Date: Tue, 12 May 2026 16:48:05 +0300
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
Message-ID: <agMvlS3-0wvGmBwh@ashevche-desk.local>
References: <20260510-adf41513-iio-driver-v12-0-34af2ed2779f@analog.com>
 <20260510-adf41513-iio-driver-v12-2-34af2ed2779f@analog.com>
 <20260512123953.40d80bc9@jic23-huawei>
 <agMnWzMjW1LwCSyT@ashevche-desk.local>
 <sj6cpjhakyfvv6rgox6cnhl2u2tgaecugcok6fw2l7zgku5wtc@aqx3ul72vgca>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sj6cpjhakyfvv6rgox6cnhl2u2tgaecugcok6fw2l7zgku5wtc@aqx3ul72vgca>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, May 12, 2026 at 02:21:14PM +0100, Rodrigo Alencar wrote:
> On 26/05/12 04:12PM, Andy Shevchenko wrote:
> > On Tue, May 12, 2026 at 12:39:53PM +0100, Jonathan Cameron wrote:
> > > On Sun, 10 May 2026 13:42:20 +0100
> > > Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
> > > 
> > > > Add helpers that parses decimal numbers into 64-bit number, i.e., decimal
> > > > point numbers with pre-defined scale are parsed into a 64-bit value (fixed
> > > > precision). After the decimal point, digits beyond the specified scale
> > > > are ignored.
> > > 
> > > Whilst Rodrigo has already replied to say there will be another version
> > > I'd like to request final feedback from those who were involved in the parser
> > > discussions.  
> > > 
> > > They got very involved and I'm far from an expert in the right way to do
> > > this stuff.  
> > > 
> > > I don't think David Laight was +CC so I've added that.
> > > David, Andy - I think you two were most involved in that discussion:
> > > Any objections to the end result? 
> > 
> > I already said a few times about the naming. I do not like the kstrto*()
> > be semantically different on how they treat the input. Second point is
> > to avoid code duplication, but this one is less of a concern since the
> > new code is in the library close to the other potentially duplicate code
> > piece and hence can be addressed later.
> 
> I suppose I reached into kstrtodec64() and kstrtoudec64() because it aligns
> with your expectations for kstrto*() semantics, no? Those include:
>  - overflow check;
>  - extensive input validation;
>  - optional '\n' in the end;
>  - mandatory nul-termination.
> 
> am I missing anything?

When we add scale we basically make that not true. Moreover the code in this
patch makes scale == number_of_characters which I think a bit fragile, however
it's about the fractional part when the amount of digits is equal to scale.

To make this work as expected we need to add an additional call like
kstrtoull() (and perhaps drop that \n and NUL-terminator checks) and see
if that overflows or not. Since it's a fractional part it must have less
than 20 (decimal) digits there, so we check the rv (or how many digits
were parsed successfully) and compare to 20. If it's more, we got too many
decimal digits.

Maybe I'm missing these checks already performed?

> > Having the test cases is a big benefit, and that part I like the most.

-- 
With Best Regards,
Andy Shevchenko


