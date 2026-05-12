Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06E8385D60;
	Tue, 12 May 2026 17:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778605749; cv=none; b=G5V6QUEb9CDck3xJrCsd1TjZZHP2Bry8oC15U2Cg52n17bxfEl7M87x2ldxiPmsF+PVuSfqqMwb0nT4g/vRjXr3n7Og1OW+MrRN1XGp/PrNGwuGDjnQ+rxYydvQe6KQXe7dXT8ZXaiQ1c85nQGMhXM+1Vb54yKPyPz7gls5L2cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778605749; c=relaxed/simple;
	bh=NiAQCeEZmvLNFa0kMcgqrD0HI8x/m+OQuywwtqbbDac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VR2J1ReuILycHJ9PULH1X7H1HkovscpcoGPZXDizY4UXoUe6R/UHpHHGmMWLpvr4pvaaY7kgD5XQV65thmaGF9q8eM4EcSbh1K7c0zM1dMj+atoTS4Eks0/gtJxfeMyfBi/4yjBk6hobUl60Alo+H8nXvcyISvRJtAEDZdMtZ3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JwMtQBVk; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JwMtQBVk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778605748; x=1810141748;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NiAQCeEZmvLNFa0kMcgqrD0HI8x/m+OQuywwtqbbDac=;
  b=JwMtQBVktE5/N7RRYeGtAV998ANEQVHBu6CqsbfFvjQf+1Kdq9Yio1dm
   K6jdpM0loR4DJs6j3KmjuFc50FhBPVQ7+Q7zzed1xItS0BPyKnE9Ik3kP
   HT+vka7+D6BSDUCtbnay/hML8dxY7tXt4w97OGSN6SmmyDnVe8K9DffUH
   9sPIOOsQsi9tiGYH1zYWbJ4PleGdhjv3c1N9PoekBRnUDhNxQZNgRRiMA
   bRKQAf2Pbz9Paa2QeJyn5OHNnc2vZI5cdM713iBLIGLFpGLX3EJ7WOO3c
   XXKAO7LPLV0efuf9Tx1RZQTPm4thXaWfK24HmnhoIcZV5nhoVmgtkpJjK
   A==;
X-CSE-ConnectionGUID: /g7uXq/GQ3i3kaWFPWBr+Q==
X-CSE-MsgGUID: 7SrC29VuQ2OQXLC50wUUCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="97092403"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="97092403"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 10:09:07 -0700
X-CSE-ConnectionGUID: hQBkBdFUTLqiME4dL9xvvw==
X-CSE-MsgGUID: UNIClucJTeetg5YGg7bkrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="231419695"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.244])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 10:09:01 -0700
Date: Tue, 12 May 2026 20:08:59 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Rodrigo Alencar <455.rodrigo.alencar@gmail.com>,
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
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v12 02/11] lib: kstrtox: add kstrtoudec64() and
 kstrtodec64()
Message-ID: <agNeq4MMPTR1xkQ8@ashevche-desk.local>
References: <20260510-adf41513-iio-driver-v12-2-34af2ed2779f@analog.com>
 <20260512123953.40d80bc9@jic23-huawei>
 <agMnWzMjW1LwCSyT@ashevche-desk.local>
 <sj6cpjhakyfvv6rgox6cnhl2u2tgaecugcok6fw2l7zgku5wtc@aqx3ul72vgca>
 <agMvlS3-0wvGmBwh@ashevche-desk.local>
 <dxjg2sdyxb7ieb4abmeyyye7qok6cczrxabpsjyjhcbehwoec3@sbbqoo4wmzre>
 <agM8pWrM6j_XksvN@ashevche-desk.local>
 <ur6brs3yjzyb4mtelabmcglxjltddqvjxtgl3lkdkmbjlkmnsq@bwd6rz7gided>
 <CAHp75VeoH3yVfp8NWjKfc_df0VRLkyf_SK4e==-wJOEodVjW_A@mail.gmail.com>
 <20260512171814.1934aeb4@pumpkin>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512171814.1934aeb4@pumpkin>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, May 12, 2026 at 05:18:14PM +0100, David Laight wrote:
> On Tue, 12 May 2026 18:21:44 +0300
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

...

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
> > supplied. All the same for 0.9999999999999999999999999999999000423. My
> > point is that we should limit this by 19 digits.
> 
> Don't forget about 000000000.123

And how is it special? We don't care about the integer part as we use
parse_integer() which does check for overflow.

> And that you also need to worry about leading spaces affecting the length.

Leading spaces is a bad input.

> To me, the easy way to parse it is to know how many digits are valid
> after the '.' and just carry on parsing digits after a '.' until the
> limit is hit.
> If you really want one function, pass zero to indicate that '.' is invalid.

Would this function makes any sense to be run with scale == 0?

> > On top of that, what about -0.9(19 times) ? the fraction should be u64
> > in this case and it's fine. The sign applies to the combined value.
> > 
> > >         - extra scaling and truncation happening outside if needed.  
> > 
> > Right, but the given input may be way too long and still needs more validation.
> > 
> > > - check for input termination
> > > - combination of integer and fractional parts with check_mul_overflow() and check_add_overflow()
> 
> A lot of the time overflow can be ignored because the digit string is short.
> The check_mul_overflow() code is likely to measurably slow things down.
> (Especially on 32bit where even a compare against 2**64/10 isn't cheap.)
> 
> > > > > > Maybe I'm missing these checks already performed?
> > > > > >  
> > > > > > > > Having the test cases is a big benefit, and that part I like the most.  

-- 
With Best Regards,
Andy Shevchenko


