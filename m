Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AC32EBB84;
	Tue, 12 May 2026 17:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778608008; cv=none; b=qa1K6mZEY5OsYtKNl3lg0bTjbCoB6OvCftMmRIzsMD6xQ64NfP6F10cKM7ctSxNhx730H9OFmGGmM4Z3NmnrFWhiNZskgBn/t1/B077z5ndnI2sNDDsqqM4wiJSjg6N4/iv6dhYfcRudf+0pgpzXEwdP78pU7hDMZyR3kyzQ5QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778608008; c=relaxed/simple;
	bh=bHtDWYlh7qWp/rUZKOZwCyZPCkE6LQ6XG3TERWH3mes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DfNOEeKUwHg4PhN6FsaVSknHZrD2fUPCCwXU+HEOWrJH/Pe8+rztLxg5OTpOYYB0kG0WAqzN0l6CY+fiJ0XAGKkT8okUgpcj1g47mD9bqmmBV8ZpVUSuVOKHPHtgEQ7V2SeB1ZuSG+eCIQLL96FRu4JWc4hb7mIF0ypRdKUPXgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g/H8x1wa; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g/H8x1wa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778608006; x=1810144006;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=bHtDWYlh7qWp/rUZKOZwCyZPCkE6LQ6XG3TERWH3mes=;
  b=g/H8x1wajtMGpQRPnxitpu7V7CD/ECoFijxTr/UrAN1QEa9yII4wBhNX
   jgA3VY3RKdUqFZvfpma054TYG41//0wf+qhx1g4lXJV0rrvZSjajUOnlP
   Jwc1IFTlK2Tmqt0tPq7diqbUEhku67FfZ0Fje/w05krZRXm1HpeWJnIcF
   8XmXi6r14+hKUBnZM9Bqfp4Ci5xDCoJ2L3UQ656+jnvTCCOPWcqyzoXPm
   Wcjp8DhH+hsQqr/JThkhd7oodwdL/rGJCdYOtWGPBLf5+PWQxnekKvKJB
   PjEfx5swFQGRYE6YXIAYjg/4Y/JDS2FGMW9kWPu4fppJ9zItWABBeS+Iu
   Q==;
X-CSE-ConnectionGUID: DuFbUSXbRoaZrWpqSECMGA==
X-CSE-MsgGUID: dtOflJNYTa2cPmj4oRaS6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="79383617"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="79383617"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 10:46:45 -0700
X-CSE-ConnectionGUID: BbLviimOTouA2OEQpzfrDg==
X-CSE-MsgGUID: m8ObnuKLSy2QV0ceWEs4zA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="242832195"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.244])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 10:46:40 -0700
Date: Tue, 12 May 2026 20:46:37 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
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
Message-ID: <agNnfWZa9_NyLoWq@ashevche-desk.local>
References: <agMnWzMjW1LwCSyT@ashevche-desk.local>
 <sj6cpjhakyfvv6rgox6cnhl2u2tgaecugcok6fw2l7zgku5wtc@aqx3ul72vgca>
 <agMvlS3-0wvGmBwh@ashevche-desk.local>
 <dxjg2sdyxb7ieb4abmeyyye7qok6cczrxabpsjyjhcbehwoec3@sbbqoo4wmzre>
 <agM8pWrM6j_XksvN@ashevche-desk.local>
 <ur6brs3yjzyb4mtelabmcglxjltddqvjxtgl3lkdkmbjlkmnsq@bwd6rz7gided>
 <CAHp75VeoH3yVfp8NWjKfc_df0VRLkyf_SK4e==-wJOEodVjW_A@mail.gmail.com>
 <q4rmlkgecvztnvjg7b7wtqyvhdy7uxgaouvhae2mlsxaasasbf@dfakp4m5l5sl>
 <agNfqiZpGZAM-x_H@ashevche-desk.local>
 <ru2h3ip7qf6j54dlrij54nwp45uyq6m2e6zspt6v6eynpsagqq@eo5v3yparuhh>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ru2h3ip7qf6j54dlrij54nwp45uyq6m2e6zspt6v6eynpsagqq@eo5v3yparuhh>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, May 12, 2026 at 06:26:12PM +0100, Rodrigo Alencar wrote:
> On 26/05/12 08:13PM, Andy Shevchenko wrote:
> > On Tue, May 12, 2026 at 05:35:59PM +0100, Rodrigo Alencar wrote:
> > > On 26/05/12 06:21PM, Andy Shevchenko wrote:
> > > > On Tue, May 12, 2026 at 6:11 PM Rodrigo Alencar
> > > > <455.rodrigo.alencar@gmail.com> wrote:
> > > > > On 26/05/12 05:43PM, Andy Shevchenko wrote:
> > > > > > On Tue, May 12, 2026 at 03:12:24PM +0100, Rodrigo Alencar wrote:
> > > > > > > On 26/05/12 04:48PM, Andy Shevchenko wrote:
> > > > > > > > On Tue, May 12, 2026 at 02:21:14PM +0100, Rodrigo Alencar wrote:
> > > > > > > > > On 26/05/12 04:12PM, Andy Shevchenko wrote:
> > > > > > > > > > On Tue, May 12, 2026 at 12:39:53PM +0100, Jonathan Cameron wrote:
> > > > > > > > > > > On Sun, 10 May 2026 13:42:20 +0100
> > > > > > > > > > > Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
> > > > > > > > > > >
> > > > > > > > > > > > Add helpers that parses decimal numbers into 64-bit number, i.e., decimal
> > > > > > > > > > > > point numbers with pre-defined scale are parsed into a 64-bit value (fixed
> > > > > > > > > > > > precision). After the decimal point, digits beyond the specified scale
> > > > > > > > > > > > are ignored.
> > > > > > > > > > >
> > > > > > > > > > > Whilst Rodrigo has already replied to say there will be another version
> > > > > > > > > > > I'd like to request final feedback from those who were involved in the parser
> > > > > > > > > > > discussions.
> > > > > > > > > > >
> > > > > > > > > > > They got very involved and I'm far from an expert in the right way to do
> > > > > > > > > > > this stuff.
> > > > > > > > > > >
> > > > > > > > > > > I don't think David Laight was +CC so I've added that.
> > > > > > > > > > > David, Andy - I think you two were most involved in that discussion:
> > > > > > > > > > > Any objections to the end result?
> > > > > > > > > >
> > > > > > > > > > I already said a few times about the naming. I do not like the kstrto*()
> > > > > > > > > > be semantically different on how they treat the input. Second point is
> > > > > > > > > > to avoid code duplication, but this one is less of a concern since the
> > > > > > > > > > new code is in the library close to the other potentially duplicate code
> > > > > > > > > > piece and hence can be addressed later.
> > > > > > > > >
> > > > > > > > > I suppose I reached into kstrtodec64() and kstrtoudec64() because it aligns
> > > > > > > > > with your expectations for kstrto*() semantics, no? Those include:
> > > > > > > > >  - overflow check;
> > > > > > > > >  - extensive input validation;
> > > > > > > > >  - optional '\n' in the end;
> > > > > > > > >  - mandatory nul-termination.
> > > > > > > > >
> > > > > > > > > am I missing anything?
> > > > > > > >
> > > > > > > > When we add scale we basically make that not true. Moreover the code in this
> > > > > > > > patch makes scale == number_of_characters which I think a bit fragile, however
> > > > > > > > it's about the fractional part when the amount of digits is equal to scale.
> > > > > > >
> > > > > > > That is not really the case. It is being set as a limit, so it does check for
> > > > > > > truncation and zero-padding.
> > > > > >
> > > > > > I do not see it happens in _parse_integer_limit(). It doesn't try to parse more
> > > > > > characters than it's requested in max_chars. It doesn't check if there are more
> > > > > > character nor their converted values.
> > > > > >
> > > > > > > > To make this work as expected we need to add an additional call like
> > > > > > > > kstrtoull() (and perhaps drop that \n and NUL-terminator checks) and see
> > > > > > > > if that overflows or not. Since it's a fractional part it must have less
> > > > > > > > than 20 (decimal) digits there, so we check the rv (or how many digits
> > > > > > > > were parsed successfully) and compare to 20. If it's more, we got too many
> > > > > > > > decimal digits.
> > > > > > >
> > > > > > > For overflow it checks the KSTRTOX_OVERFLOW flag and leverages check_mul_overflow()
> > > > > > > and check_add_overflow() when combining fractional and integer parts. The amount
> > > > > > > of characters is not really important there. The scale cannot be bigger than 19 and
> > > > > > > that makes sure that int_pow() does not overflow. The code uses _parse_integer_limit()
> > > > > > > due to the nature of input and to avoid 64-bit division, kstrtoull() at any point
> > > > > > > (parsing integer or fractional parts) does not make much sense.
> > > > > >
> > > > > > Under 'like kstrotoull()' I meant something that repeats needed functionality.
> > > > > > I believe it's parse_integer() (without limit).
> > > > >
> > > > > I think we are going in circles here and we could look at the code instead:
> > > > > - integer parsing with _parse_integer()
> > > > >         - overflow check and validation of the return value
> > > > > - fractional parsing with _parse_integer_limit()
> > > > >         - overflow check and validation of the return value
> > > > 
> > > > No, this is not fully true. That's what my whole point is about. The
> > > > max_chars parameter limits the input check, then it skips an arbitrary
> > > > number of digits and only *then* it checks for \n and \0. What will be
> > > > the result of the
> > > > 0.00000000000000000000000000000000423 in your case? Whatever scale you
> > > > gave it will return 0 without checking on how many digits were
> > > > supplied.
> > > 
> > > I suppose that is a valid input and 0 is the expected result there.
> > > 
> > > > All the same for 0.9999999999999999999999999999999000423. My
> > > > point is that we should limit this by 19 digits.
> > > 
> > > why we need to limit by 19? Digits beyond the scale carry no value...
> > 
> > ...only if they are all 0:s.
> 
> I thought your concern was on input length.

One of, since I think you rose the topic of leading 0:s for integers and
I agreed with that which makes sense to have mirrored in fractional part.

> > > just like leading zeros to the integer part (which is also accepted by
> > > kstrtoull() when parsing with base 10). Not sure why this is invalid input.
> > 
> > See above. I agree on truncating trailing 0:s as it's done for leading ones
> > in integer part, but if any of the digit behind 19th is not 0, it's an overflow
> > condition (or bad input, depending how strict the rules are).
> 
> stating in the documentation that digits beyond the scale are ignored is not
> enough?

It's in case we are not for kstrto*() family. My understanding that kstrto*()
use strict rules on the input in overflow check.

> > > > On top of that, what about -0.9(19 times) ? the fraction should be u64
> > > > in this case and it's fine. The sign applies to the combined value.
> > > 
> > > yes, range for signed values are verified later.
> > 
> > > > >         - extra scaling and truncation happening outside if needed.
> > > > 
> > > > Right, but the given input may be way too long and still needs more validation.
> > > 
> > > What is the problem with a long input of digits?
> > > C compiler does not complain about this when parsing a float value,
> > > python does not
> > > complain about this when parsing floats or decimals either.
> > 
> > Because there is an exponent limit and for double it's something like 1e307
> > IIRC, meaning, try 1024 digits to be sure.
> > 
> > Python most likely uses the library for big numbers, you can't compare it at all with this.
> 
> You would be fine if the truncation loop:
> 
> while (isdigit(*s)) /* truncate */
> 	s++;
> 
> is bounded by (19-scale) iteration count? or it should keep iterating if those are zero?

Ideally both.

We don't care about the digits in the range of 19-scale and skip all 0:s after
that.

	/* truncate unrequired digits within type limit, i.e. 19 decimal digits */
	while (isdigit(*s) && "(s - pos_of_dot) is less than 19")
		s++;
	while (s == '0') /* truncate trailing 0:s, it's not a bad input nor overflow */
		s++;

	// Now if it's not \0 nor \n and
	//	a) still a digit consider either overflow or bad input,
	//	b) if not a digit, consider as bad input.

In a) I tend to be on par with the other k*() and consider that as overflow.

> is that the only concern? Again, the usage of _parse_integer_limit(s, 10, &_frac, scale)
> avoids a 64-bit division when checking the rv.

I'm not against usage of _parse_integer_limit(), I'm for stricter rules on the input.
With the above addressed, I have no more concerns.

> > > > > - check for input termination
> > > > > - combination of integer and fractional parts with check_mul_overflow() and check_add_overflow()
> > > > >
> > > > > > > > Maybe I'm missing these checks already performed?
> > > > > > > >
> > > > > > > > > > Having the test cases is a big benefit, and that part I like the most.

-- 
With Best Regards,
Andy Shevchenko


