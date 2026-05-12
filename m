Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDA22F8BF0;
	Tue, 12 May 2026 17:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778606004; cv=none; b=UO9/B5v0BKAn4z3LMZTQssIlUYy9KyprgxEWhYwfO9+k2ZxSdbXWJzn4JU2syBMD9riCIH8SALX88iX/H4CZRuy1M3UPJIdRrLJ2/H5vUDuE78x0LB7FNuILlApwz3FKQMZKgG4N1zFkXAVoqdH+lKBRJStlUu4+pZy0QxBgUEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778606004; c=relaxed/simple;
	bh=upy5irLRMfq5OvYLOHwa14JMBYnvWCDdOHZ+IXGw6Vo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lX/EDsSfqJm1uyE+wNjtoKfARvHEPhjZ00C6g9hd1Tzr6JrmRvbPk99B0yy+p75b1g6hSc+PxQ+9zFJKETQzS37XZDbbqLUX/a2A3pVZ/UL7xE4Vg0TmLPiaQPUuTpToBGqmf6w5oPlAdEHSbXQZlOE8KxVNh0o8XHvHLDch4sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J0a+xZeB; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J0a+xZeB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778606003; x=1810142003;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=upy5irLRMfq5OvYLOHwa14JMBYnvWCDdOHZ+IXGw6Vo=;
  b=J0a+xZeBbSHG6vYMnGTbw1SffMibgFC1jtOTvDrkLwdFXEz4dR2lIfVu
   p4idV01qHnmgl3gDEvIuACZyQFsenGWXMo9uRFTfF3o+7p1lt5F16deF/
   uGn8tFWewYVdBfWENCVg1UL0vwFI+iCh+P0NhGskiyZ/BdtO2ykZVcYBT
   gWyg0Cr3ShTx4K0/UqdYIrFCipLSwPmTSUI9/ccu2CBGtEONmrT/4o0ut
   rT4vj7r6XdYUrenJUroID0GZYXSlfITmCXKGL1iuFOQMZNAi9QHpJGt1p
   u8jWxbg0cDwkXpH3wPFeWCVsD/73DKbmZzRww0e1K2YdXAHaJpSGj8S0V
   w==;
X-CSE-ConnectionGUID: l8vpUaBrR9WDMuLcg7y/tg==
X-CSE-MsgGUID: 59TlNU4mQYqrA7kWkDZAew==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="102186412"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="102186412"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 10:13:22 -0700
X-CSE-ConnectionGUID: aFbXCRH3QOqlfQVB6TlZSg==
X-CSE-MsgGUID: 7GUSE0AvRuaPXHqvMdzocw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="236849296"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.244])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 10:13:16 -0700
Date: Tue, 12 May 2026 20:13:14 +0300
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
Message-ID: <agNfqiZpGZAM-x_H@ashevche-desk.local>
References: <20260510-adf41513-iio-driver-v12-2-34af2ed2779f@analog.com>
 <20260512123953.40d80bc9@jic23-huawei>
 <agMnWzMjW1LwCSyT@ashevche-desk.local>
 <sj6cpjhakyfvv6rgox6cnhl2u2tgaecugcok6fw2l7zgku5wtc@aqx3ul72vgca>
 <agMvlS3-0wvGmBwh@ashevche-desk.local>
 <dxjg2sdyxb7ieb4abmeyyye7qok6cczrxabpsjyjhcbehwoec3@sbbqoo4wmzre>
 <agM8pWrM6j_XksvN@ashevche-desk.local>
 <ur6brs3yjzyb4mtelabmcglxjltddqvjxtgl3lkdkmbjlkmnsq@bwd6rz7gided>
 <CAHp75VeoH3yVfp8NWjKfc_df0VRLkyf_SK4e==-wJOEodVjW_A@mail.gmail.com>
 <q4rmlkgecvztnvjg7b7wtqyvhdy7uxgaouvhae2mlsxaasasbf@dfakp4m5l5sl>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <q4rmlkgecvztnvjg7b7wtqyvhdy7uxgaouvhae2mlsxaasasbf@dfakp4m5l5sl>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, May 12, 2026 at 05:35:59PM +0100, Rodrigo Alencar wrote:
> On 26/05/12 06:21PM, Andy Shevchenko wrote:
> > On Tue, May 12, 2026 at 6:11 PM Rodrigo Alencar
> > <455.rodrigo.alencar@gmail.com> wrote:
> > > On 26/05/12 05:43PM, Andy Shevchenko wrote:
> > > > On Tue, May 12, 2026 at 03:12:24PM +0100, Rodrigo Alencar wrote:
> > > > > On 26/05/12 04:48PM, Andy Shevchenko wrote:
> > > > > > On Tue, May 12, 2026 at 02:21:14PM +0100, Rodrigo Alencar wrote:
> > > > > > > On 26/05/12 04:12PM, Andy Shevchenko wrote:
> > > > > > > > On Tue, May 12, 2026 at 12:39:53PM +0100, Jonathan Cameron wrote:
> > > > > > > > > On Sun, 10 May 2026 13:42:20 +0100
> > > > > > > > > Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
> > > > > > > > >
> > > > > > > > > > Add helpers that parses decimal numbers into 64-bit number, i.e., decimal
> > > > > > > > > > point numbers with pre-defined scale are parsed into a 64-bit value (fixed
> > > > > > > > > > precision). After the decimal point, digits beyond the specified scale
> > > > > > > > > > are ignored.
> > > > > > > > >
> > > > > > > > > Whilst Rodrigo has already replied to say there will be another version
> > > > > > > > > I'd like to request final feedback from those who were involved in the parser
> > > > > > > > > discussions.
> > > > > > > > >
> > > > > > > > > They got very involved and I'm far from an expert in the right way to do
> > > > > > > > > this stuff.
> > > > > > > > >
> > > > > > > > > I don't think David Laight was +CC so I've added that.
> > > > > > > > > David, Andy - I think you two were most involved in that discussion:
> > > > > > > > > Any objections to the end result?
> > > > > > > >
> > > > > > > > I already said a few times about the naming. I do not like the kstrto*()
> > > > > > > > be semantically different on how they treat the input. Second point is
> > > > > > > > to avoid code duplication, but this one is less of a concern since the
> > > > > > > > new code is in the library close to the other potentially duplicate code
> > > > > > > > piece and hence can be addressed later.
> > > > > > >
> > > > > > > I suppose I reached into kstrtodec64() and kstrtoudec64() because it aligns
> > > > > > > with your expectations for kstrto*() semantics, no? Those include:
> > > > > > >  - overflow check;
> > > > > > >  - extensive input validation;
> > > > > > >  - optional '\n' in the end;
> > > > > > >  - mandatory nul-termination.
> > > > > > >
> > > > > > > am I missing anything?
> > > > > >
> > > > > > When we add scale we basically make that not true. Moreover the code in this
> > > > > > patch makes scale == number_of_characters which I think a bit fragile, however
> > > > > > it's about the fractional part when the amount of digits is equal to scale.
> > > > >
> > > > > That is not really the case. It is being set as a limit, so it does check for
> > > > > truncation and zero-padding.
> > > >
> > > > I do not see it happens in _parse_integer_limit(). It doesn't try to parse more
> > > > characters than it's requested in max_chars. It doesn't check if there are more
> > > > character nor their converted values.
> > > >
> > > > > > To make this work as expected we need to add an additional call like
> > > > > > kstrtoull() (and perhaps drop that \n and NUL-terminator checks) and see
> > > > > > if that overflows or not. Since it's a fractional part it must have less
> > > > > > than 20 (decimal) digits there, so we check the rv (or how many digits
> > > > > > were parsed successfully) and compare to 20. If it's more, we got too many
> > > > > > decimal digits.
> > > > >
> > > > > For overflow it checks the KSTRTOX_OVERFLOW flag and leverages check_mul_overflow()
> > > > > and check_add_overflow() when combining fractional and integer parts. The amount
> > > > > of characters is not really important there. The scale cannot be bigger than 19 and
> > > > > that makes sure that int_pow() does not overflow. The code uses _parse_integer_limit()
> > > > > due to the nature of input and to avoid 64-bit division, kstrtoull() at any point
> > > > > (parsing integer or fractional parts) does not make much sense.
> > > >
> > > > Under 'like kstrotoull()' I meant something that repeats needed functionality.
> > > > I believe it's parse_integer() (without limit).
> > >
> > > I think we are going in circles here and we could look at the code instead:
> > > - integer parsing with _parse_integer()
> > >         - overflow check and validation of the return value
> > > - fractional parsing with _parse_integer_limit()
> > >         - overflow check and validation of the return value
> > 
> > No, this is not fully true. That's what my whole point is about. The
> > max_chars parameter limits the input check, then it skips an arbitrary
> > number of digits and only *then* it checks for \n and \0. What will be
> > the result of the
> > 0.00000000000000000000000000000000423 in your case? Whatever scale you
> > gave it will return 0 without checking on how many digits were
> > supplied.
> 
> I suppose that is a valid input and 0 is the expected result there.
> 
> > All the same for 0.9999999999999999999999999999999000423. My
> > point is that we should limit this by 19 digits.
> 
> why we need to limit by 19? Digits beyond the scale carry no value...

...only if they are all 0:s.

> just like leading zeros to the integer part (which is also accepted by
> kstrtoull() when parsing with base 10). Not sure why this is invalid input.

See above. I agree on truncating trailing 0:s as it's done for leading ones
in integer part, but if any of the digit behind 19th is not 0, it's an overflow
condition (or bad input, depending how strict the rules are).

> > On top of that, what about -0.9(19 times) ? the fraction should be u64
> > in this case and it's fine. The sign applies to the combined value.
> 
> yes, range for signed values are verified later.

> > >         - extra scaling and truncation happening outside if needed.
> > 
> > Right, but the given input may be way too long and still needs more validation.
> 
> What is the problem with a long input of digits?
> C compiler does not complain about this when parsing a float value,
> python does not
> complain about this when parsing floats or decimals either.

Because there is an exponent limit and for double it's something like 1e307
IIRC, meaning, try 1024 digits to be sure.

Python most likely uses the library for big numbers, you can't compare it at all with this.

> > > - check for input termination
> > > - combination of integer and fractional parts with check_mul_overflow() and check_add_overflow()
> > >
> > > > > > Maybe I'm missing these checks already performed?
> > > > > >
> > > > > > > > Having the test cases is a big benefit, and that part I like the most.

-- 
With Best Regards,
Andy Shevchenko


