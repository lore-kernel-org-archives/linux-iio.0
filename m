Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D446A2DEA7A;
	Sat, 31 Jan 2026 18:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769882615; cv=none; b=uaR8QKC7810zuSzVD0t7O6Z/v53TGR8jiPmsdZITMuB8JZvrKZyXER105UuQzwNgbnvbFSeUCXqCBG6bbFC8caXJO2ztycLS7D5fQ3guoq6ak+Zob4xr7JqRd/r3LnUic8WCBo9CkJz2oq1PXooL/SVE/K4/jGIdWe2phiI+8aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769882615; c=relaxed/simple;
	bh=UJPEhEh2cez9JnPirLgqTvQBSdwrP7nhn31j+/gtkYA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IgFjhiQ0p0i4BmnEcAuIF9GHRb8fRd8p80w5lfyqFTRRjXbPU24nXuLTWOOB/YbxZuWMhFLfbXGivi4Dc0FNpOtuqDDlCJw12egC/QN+oTAyUrkLUj2RZCv7aPH09pLCdcchOvu9YF0TsYAd54AZETGm0wwBvX4YE9QjJyOTmmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QC0YfuzU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QC0YfuzU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 746C5C4CEF1;
	Sat, 31 Jan 2026 18:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769882615;
	bh=UJPEhEh2cez9JnPirLgqTvQBSdwrP7nhn31j+/gtkYA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QC0YfuzUXMFet3J/viPgBHT76UKFD8U8G1mWyyYvxhB3hTbZBgwt5ls8ScbGezOoj
	 nz/CboulK08iCAk4X7sM/f+mnGB7WeNSFA2eBz+wRTq4+2ustioAyFVusPO+7l3FiR
	 SnvzBNJZ9euyCEkBCN8nIgAquttC+mlTCodxX+k5V/0PG2aE/FsBGMYMbNk+IeFBgo
	 Mgh51zWA0+ZyR1VpEy8tiq5cQNn8yXNM5Ps0ZzCuIToRY9QY3ZKmLDSKuBtiOLdMC2
	 uXSRuSAFayH2obBNWg5X3tuxR0DQQuplaMosAF6b8+izhwm+6aWKKPz23GId7WAXdY
	 litFcvJyWQ7Mg==
Date: Sat, 31 Jan 2026 18:03:25 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Dmitry Antipov
 <dmantipov@yandex.ru>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Kees
 Cook <kees@kernel.org>, Petr Mladek <pmladek@suse.com>,
 rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH v5 2/8] iio: core: add fixed point parsing with 64-bit
 parts
Message-ID: <20260131180325.62520933@jic23-huawei>
In-Reply-To: <bvdpwe7453udqml6rnrrgt64n3hpxcc77ygtpofuymqx56zhez@vko4me2vxotj>
References: <aXdUvRZ9NmP5Nh95@smile.fi.intel.com>
	<byitgzjli5gsq5v66topve7ip3inkk2udwhuihjdp6bknnkmos@tv226l7tek7s>
	<aXdtpkL5QUhhB_hh@smile.fi.intel.com>
	<ty6hptfh65k2rkqo6c6mg5z6vismuvyqsu3emvqarr2rbhpvcz@kn6tzjk5xi2o>
	<aXd_0uNVm8c_Fhwd@smile.fi.intel.com>
	<n2ms3esyxlegqibu4nluut3x4c4bkjxt5xrcd4gw35xxb2tipb@a2v73y25kroc>
	<shsikp7hinoxzj7pzxopvmvgpaak4dioekh4tyvns4kv6xp46f@z5vgnisqskco>
	<aXeRQ4AXmn1SxoNa@smile.fi.intel.com>
	<anhtxco52jz2ktmxlittsjuvfqybwrwgy76bjhni3j5dzx2rh2@hpzf3sfwe7hf>
	<aXhsu2DvG-5PLOEU@smile.fi.intel.com>
	<bvdpwe7453udqml6rnrrgt64n3hpxcc77ygtpofuymqx56zhez@vko4me2vxotj>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 Jan 2026 10:17:33 +0000
Rodrigo Alencar <455.rodrigo.alencar@gmail.com> wrote:

> On 26/01/27 09:43AM, Andy Shevchenko wrote:
> > 
> > Remove DT related people and ML and add others based on the links I posted
> > below.
> > 
> > On Mon, Jan 26, 2026 at 04:55:13PM +0000, Rodrigo Alencar wrote:  
> > > On 26/01/26 06:07PM, Andy Shevchenko wrote:  
> > > > On Mon, Jan 26, 2026 at 03:30:44PM +0000, Rodrigo Alencar wrote:  
> > > > > On 26/01/26 03:20PM, Rodrigo Alencar wrote:  
> > > > > > On 26/01/26 04:53PM, Andy Shevchenko wrote:  
> > > > > > > On Mon, Jan 26, 2026 at 02:26:20PM +0000, Rodrigo Alencar wrote:  
> > 
> > ...
> >   
> > > > > > > Why? Can you elaborate how checking amount of digits is different to
> > > > > > > check_mul_overflow()?  
> > > > > > 
> > > > > > consider U64_MAX = 18_446_744_073_709_551_615 as the limit:
> > > > > > - 19_000_000_000_000_000_000 contains the same amount of digits but overflows.
> > > > > > - 18_446_744_073_710_000_000 contains the same amount of digits but overflows.
> > > > > > 
> > > > > > to catch those cases, we need to check for the overflow, everytime we read a
> > > > > > character and accumulate:
> > > > > > 
> > > > > > u64 acc;
> > > > > > 
> > > > > > while(isdigit(*str))
> > > > > > 	if (check_mul_overflow(acc, 10, &acc) ||
> > > > > > 	    check_add_overflow(acc, *str - '0', &acc))
> > > > > > 		return -EOVERFLOW;
> > > > > > 
> > > > > > *res = acc;
> > > > > > 
> > > > > > acc can get weird results if not checked.   
> > > > > 
> > > > > Thinking about it again, that check could be done only in the last step
> > > > > (20th for u64)  
> > > > 
> > > > Does kstrto*() also perform only last check? I think they do for each
> > > > iteration.  
> > > 
> > > It does the following:
> > > 
> > > ...
> > > 		if (unlikely(res & (~0ull << 60))) {
> > > 			if (res > div_u64(ULLONG_MAX - val, base))
> > > 				rv |= KSTRTOX_OVERFLOW;
> > > 		}
> > > ...
> > > 
> > > so overflow is checked when either one of the 4 MSbits are set.
> > > 
> > > for now, I am thinking of something like:
> > > 
> > > static ssize_t iio_safe_strtou64(const char *str, const char **endp,
> > > 				 size_t max_chars, u64 *result)
> > > {
> > > 	u64 digit, acc = 0;
> > > 	size_t idx = 0;
> > > 
> > > 	while (isdigit(*str) && idx < max_chars) {
> > > 		digit = *str - '0';
> > > 		if (unlikely(idx > 19)) {
> > > 			if (check_mul_overflow(acc, 10, &acc) ||
> > > 			    check_add_overflow(acc, digit, &acc))
> > > 				return -EOVERFLOW;
> > > 		} else {
> > > 			acc = acc * 10 + digit;
> > > 		}
> > > 		str++;
> > > 		idx++;
> > > 	}
> > > 
> > > 	*endp = str;
> > > 	*result = acc;
> > > 	return idx;
> > > }
> > > 
> > > which would help the truncation when parsing the fractional part
> > > with max_chars, avoiding a div64_u64() to adjust precision:
> > > 
> > > ...
> > > 	digit_count = iio_safe_strtou64(str, &end, SIZE_MAX, &i);
> > > 	if (digit_count < 0)
> > > 		return digit_count;
> > > 
> > > 	if (precision && *end == '.') {
> > > 		str = end + 1;
> > > 		digit_count = iio_safe_strtou64(str, &end, precision, &f);
> > > 		if (digit_count < 0)
> > > 			return digit_count;
> > > 
> > > 		if (digit_count < precision) /* scale up */
> > > 			f *= int_pow(10, precision - digit_count);
> > > 
> > > 		while (isdigit(*end)) /* truncate */
> > > 			end++;
> > > 	}
> > > ...
> > > 
> > > but I understand you would not like this approach, because it does not use
> > > simple_strtoull() or kstrtoull(). Problem is simple_strtoull() is not
> > > overflow-safe and kstrtoull() does not allow to track a pointer to end
> > > of the string.
> > > 
> > > Given that the current implementation of iio_str_to_fixpoint() is not using
> > > simple_strtoull() I am not seeing an issue with this approach.  
> > 
> > I believe this is the goal, id est to get rid of the code duplication.
> > The idea is not exactly in _using_ simple_strto*() or kstrto*(), but
> > deriving the common parts that can be reused here.  
> 
> Let's recap:
> - The real goal here is the PLL driver implementation;
> - Such driver requires 64-bit parsing because frequencies are big values
>   with sub-Hz resolutions.
> - IIO helpers currently does not support that, so I added the code in driver;
> - Duplication and reuse of code argument is valid, so I moved the code to IIO
>   core.
> - Existing functions simple_strtoull() and kstrtoull() have their limitations.
> 
> About the current state of IIO core fixed-point parsing:
> - Overflow-unsafe;
> - Does not support 64-bit values;
> - custom implementation, so does not reuse code;
> 
> > For simplicity, we
> > may leave iio_str_to_fixpoint() alone for now (as you mentioned it
> > doesn't share currently the code, so can be addressed later on)
> > and try to provide a treewide available safe_strto*().  
> 
> For simplicity, if possible, I still think the work here should be
> bound to the IIO subsystem. I would like get other pepole's opinion here,
> As you are increasing the scope of this patch, again.

I'd go with what Andy suggests for looking at global unification
but agree that might be split from what you need here.

> 
> The scope I would like to push for this work:
> - Add 64-bit parsing support into IIO core;
Makes sense as it seems we have real users and if you improve the other
cases along the way (tests etc) all the better!

> - Add IIO kunit test for fixed point parsing;
That sounds particularly good to have.

> - Get the code to be overflow-safe;
Don't think anyone has really looked at that parser for a while
so good to test it better and fix the corner cases.

Jonathan

> 

