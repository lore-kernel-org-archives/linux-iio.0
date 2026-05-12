Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC81274652;
	Tue, 12 May 2026 20:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778617014; cv=none; b=A3VyD6Lyad+knN0RJvlYf1WFHyzH9IdELzP7keTSlFYTmjp9h+qCWp1lUFZwCuYBBzcJMfNp6XzjGHgX1VJ0tfe2KI3OBizp5vVt3fUdwq6Hc1c3OgxK+yqDxvzdW7hrWEIO2GpANWKHAg1pwOcOQwG74j9AA1zeAf0Y21bQBzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778617014; c=relaxed/simple;
	bh=RT2NwAYbxnLXBPcxy0wu3RqnGUBLKP8VG7ARlQi7UDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cHAfg34GAlYKCXKtIqo+ueBfsP8NKsT6KdtqzWiV4AYkT7uCdlUfIuG4+mPQxm0KzRbG++PZsNNh2VMp00QFS/QXzOYmgjsHujvzlcZkrxUPFPgvz8ZwRKCVq4KBi1cG84ijm/MbzqpcIE7wNsgVwMt85zKSPxEddkRZQU0TpII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CuExYTyf; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CuExYTyf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778617012; x=1810153012;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=RT2NwAYbxnLXBPcxy0wu3RqnGUBLKP8VG7ARlQi7UDU=;
  b=CuExYTyfQwGYyeivs5M6SWyMsLhMdTQbrXY/j+5kOexreJgqaSOZ2Taf
   QJ+QzpAQg4akClWmujSvrd5jv51fL+hVVF8rWnlvwtPxmsrwV5FzkylIX
   9LCe2mGn0qN3BIOWRvjCLtyvcU3PvicladiAePt23n60e38uYXW10R9tl
   oWhFmXxpmu0poQ+XV5LvdBcEXWmuvhUguRBP9XF/gEc2A98XxAICTzYel
   IQsEni5tNsiXgTAv+Hu4RdCqOsWDhcuYBZ6AuNQO2uFozWHCX4C2qMmY7
   xF85/Oq5j0PxaT5aY1QMyQ/YHVvuttZ7PXcgJvqIQcRMRTS+STszG/Etq
   g==;
X-CSE-ConnectionGUID: btPrho6TSe6idbtPbzevvQ==
X-CSE-MsgGUID: H0cd+AIqRCCGlAkmgKvLDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="90236234"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="90236234"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 13:16:51 -0700
X-CSE-ConnectionGUID: Kq1jwXMYRBiFytywUSpx0w==
X-CSE-MsgGUID: PPqQM23dSNa0mQer5n3lYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="234816551"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.244])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 13:16:46 -0700
Date: Tue, 12 May 2026 23:16:43 +0300
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
Message-ID: <agOKq0iH2CHQ3TIg@ashevche-desk.local>
References: <agM8pWrM6j_XksvN@ashevche-desk.local>
 <ur6brs3yjzyb4mtelabmcglxjltddqvjxtgl3lkdkmbjlkmnsq@bwd6rz7gided>
 <CAHp75VeoH3yVfp8NWjKfc_df0VRLkyf_SK4e==-wJOEodVjW_A@mail.gmail.com>
 <q4rmlkgecvztnvjg7b7wtqyvhdy7uxgaouvhae2mlsxaasasbf@dfakp4m5l5sl>
 <agNfqiZpGZAM-x_H@ashevche-desk.local>
 <ru2h3ip7qf6j54dlrij54nwp45uyq6m2e6zspt6v6eynpsagqq@eo5v3yparuhh>
 <agNnfWZa9_NyLoWq@ashevche-desk.local>
 <bc7mqfgll34vyaxdtvfssgypkhyx233wd4hxfzu32rddxnolaq@rd6c3z6yu6aq>
 <agN6onIAwG1yn5p6@ashevche-desk.local>
 <hvwyrb7g3ar7hzesj32zoxzqvjmdtwybamy4zxepqdbu37qvog@xnmgqhfya34f>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <hvwyrb7g3ar7hzesj32zoxzqvjmdtwybamy4zxepqdbu37qvog@xnmgqhfya34f>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, May 12, 2026 at 08:39:21PM +0100, Rodrigo Alencar wrote:
> On 26/05/12 10:08PM, Andy Shevchenko wrote:
> > On Tue, May 12, 2026 at 07:15:17PM +0100, Rodrigo Alencar wrote:
> > > On 26/05/12 08:46PM, Andy Shevchenko wrote:
> > > > On Tue, May 12, 2026 at 06:26:12PM +0100, Rodrigo Alencar wrote:
> > > > > On 26/05/12 08:13PM, Andy Shevchenko wrote:
> > > > > > On Tue, May 12, 2026 at 05:35:59PM +0100, Rodrigo Alencar wrote:
> > > > > > > On 26/05/12 06:21PM, Andy Shevchenko wrote:
> > > > > > > > On Tue, May 12, 2026 at 6:11 PM Rodrigo Alencar
> > > > > > > > <455.rodrigo.alencar@gmail.com> wrote:
> > > > > > > > > On 26/05/12 05:43PM, Andy Shevchenko wrote:
> > > > > > > > > > On Tue, May 12, 2026 at 03:12:24PM +0100, Rodrigo Alencar wrote:
> > > > > > > > > > > On 26/05/12 04:48PM, Andy Shevchenko wrote:
> > > > > > > > > > > > On Tue, May 12, 2026 at 02:21:14PM +0100, Rodrigo Alencar wrote:
> > > > > > > > > > > > > On 26/05/12 04:12PM, Andy Shevchenko wrote:
> > > > > > > > > > > > > > On Tue, May 12, 2026 at 12:39:53PM +0100, Jonathan Cameron wrote:
> > > > > > > > > > > > > > > On Sun, 10 May 2026 13:42:20 +0100
> > > > > > > > > > > > > > > Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > Add helpers that parses decimal numbers into 64-bit number, i.e., decimal
> > > > > > > > > > > > > > > > point numbers with pre-defined scale are parsed into a 64-bit value (fixed
> > > > > > > > > > > > > > > > precision). After the decimal point, digits beyond the specified scale
> > > > > > > > > > > > > > > > are ignored.

...

> > > > > > > > > I think we are going in circles here and we could look at the code instead:
> > > > > > > > > - integer parsing with _parse_integer()
> > > > > > > > >         - overflow check and validation of the return value
> > > > > > > > > - fractional parsing with _parse_integer_limit()
> > > > > > > > >         - overflow check and validation of the return value
> > > > > > > > 
> > > > > > > > No, this is not fully true. That's what my whole point is about. The
> > > > > > > > max_chars parameter limits the input check, then it skips an arbitrary
> > > > > > > > number of digits and only *then* it checks for \n and \0. What will be
> > > > > > > > the result of the
> > > > > > > > 0.00000000000000000000000000000000423 in your case? Whatever scale you
> > > > > > > > gave it will return 0 without checking on how many digits were
> > > > > > > > supplied.
> > > > > > > 
> > > > > > > I suppose that is a valid input and 0 is the expected result there.
> > > > > > > 
> > > > > > > > All the same for 0.9999999999999999999999999999999000423. My
> > > > > > > > point is that we should limit this by 19 digits.
> > > > > > > 
> > > > > > > why we need to limit by 19? Digits beyond the scale carry no value...
> > > > > > 
> > > > > > ...only if they are all 0:s.
> > > > > 
> > > > > I thought your concern was on input length.
> > > > 
> > > > One of, since I think you rose the topic of leading 0:s for integers and
> > > > I agreed with that which makes sense to have mirrored in fractional part.
> > > > 
> > > > > > > just like leading zeros to the integer part (which is also accepted by
> > > > > > > kstrtoull() when parsing with base 10). Not sure why this is invalid input.
> > > > > > 
> > > > > > See above. I agree on truncating trailing 0:s as it's done for leading ones
> > > > > > in integer part, but if any of the digit behind 19th is not 0, it's an overflow
> > > > > > condition (or bad input, depending how strict the rules are).
> > > > > 
> > > > > stating in the documentation that digits beyond the scale are ignored is not
> > > > > enough?
> > > > 
> > > > It's in case we are not for kstrto*() family. My understanding that kstrto*()
> > > > use strict rules on the input in overflow check.
> > > > 
> > > > > > > > On top of that, what about -0.9(19 times) ? the fraction should be u64
> > > > > > > > in this case and it's fine. The sign applies to the combined value.
> > > > > > > 
> > > > > > > yes, range for signed values are verified later.
> > > > > > 
> > > > > > > > >         - extra scaling and truncation happening outside if needed.
> > > > > > > > 
> > > > > > > > Right, but the given input may be way too long and still needs more validation.
> > > > > > > 
> > > > > > > What is the problem with a long input of digits?
> > > > > > > C compiler does not complain about this when parsing a float value,
> > > > > > > python does not
> > > > > > > complain about this when parsing floats or decimals either.
> > > > > > 
> > > > > > Because there is an exponent limit and for double it's something like 1e307
> > > > > > IIRC, meaning, try 1024 digits to be sure.
> > > > > > 
> > > > > > Python most likely uses the library for big numbers, you can't compare it at all with this.
> > > > > 
> > > > > You would be fine if the truncation loop:
> > > > > 
> > > > > while (isdigit(*s)) /* truncate */
> > > > > 	s++;
> > > > > 
> > > > > is bounded by (19-scale) iteration count? or it should keep iterating if those are zero?
> > > > 
> > > > Ideally both.
> > > > 
> > > > We don't care about the digits in the range of 19-scale and skip all 0:s after
> > > > that.
> > > > 
> > > > 	/* truncate unrequired digits within type limit, i.e. 19 decimal digits */
> > > > 	while (isdigit(*s) && "(s - pos_of_dot) is less than 19")
> > > > 		s++;
> > > > 	while (s == '0') /* truncate trailing 0:s, it's not a bad input nor overflow */
> > > > 		s++;
> > > 
> > > We could have agreed on something like that since the beginning!
> > 
> > Yes, but who knew that we go to have this agreement?
> > 
> > > And I think that changing the logic to something like this would not change a
> > > thing on the kind of inputs we expect, it will just complicate the code.
> > > I suppose that kind of kstrto*() rules were never stated anywhere.
> > > 
> > >                            |> 20th digit 
> > > Also, 0.00000000000000000001 still sounds like a valid decimal number to me, even
> > > though it is going to be parsed as 0!
> > 
> > Hmm... It would mean that testing for 19th/20th digits is not enough... :-(
> > 
> > > > 
> > > > 	// Now if it's not \0 nor \n and
> > > > 	//	a) still a digit consider either overflow or bad input,
> > > > 	//	b) if not a digit, consider as bad input.
> > > > 
> > > > In a) I tend to be on par with the other k*() and consider that as overflow.
> > > > 
> > > > > is that the only concern? Again, the usage of _parse_integer_limit(s, 10, &_frac, scale)
> > > > > avoids a 64-bit division when checking the rv.
> > > > 
> > > > I'm not against usage of _parse_integer_limit(), I'm for stricter rules on the input.
> > > > With the above addressed, I have no more concerns.
> > > 
> > > Thanks! I will proceed with the requested adjustments.
> > 
> > But it seems it's not enough as you pointed out!
> > 
> > So the biggest fraction we may consume in 64-bit (unsigned) value is
> > 0.18446744073709551615. If we go with one digit less, the whole value
> > can be
> > 
> > In [3]: hex(9999999999999999999)
> > Out[3]: '0x8ac7230489e7ffff'
> > 
> > So, I don't know how we are supposed to represent values between
> > -0.9223372036854775808
> > -0.9999999999999999999
> > in a signed type as they have bit 63 set.
> > 
> > The easiest way out is to limit scale to 18 (but still accept 19th digit, and
> > with check for overflow even 20th up to 0.18446744073709551615). This will need
> > to run _parse_integer_limit() twice (with given scale and with 20).
> > 
> > Can you add the respective test cases and see what is currently going on with
> > them?
> 
> I can add test cases, but for the signed case the situation is:
> 
> scale = 0
> 	max = 9223372036854775807, min = -9223372036854775808
> scale = 1
> 	max = 922337203685477580.7, min = -922337203685477580.8
> scale = 2
> 	max = 92233720368547758.07, min = -92233720368547758.08
> ...
> scale = 18
> 	max = 9.223372036854775807, min = -9.223372036854775808
> scake = 19
> 	max = 0.9223372036854775807, min = -0.9223372036854775808
> 
> anything outside those ranges will give you -ERANGE. Then it depends on the scale used.

Oh, I only now realised that this is sliding window for a single 64-bit signed value!
I was under impression that you wanted implementation that covers 128-bit signed value
(with 64 + 64)...

> I am not representing -0.9999999999999999999 as is. The desired scale will have this
> truncated. It may be -0.9999 or -0.999999 or -0.9. And this is practical for a
> reasonable scale value... for pico and femto precision you still get a decent range.

-- 
With Best Regards,
Andy Shevchenko


