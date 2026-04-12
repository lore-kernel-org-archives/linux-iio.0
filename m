Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54AB1A9B24;
	Sun, 12 Apr 2026 15:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776006369; cv=none; b=VD7rC3cb+/96aYuKJb5jueFAvt/kwCbri2oXdoniulrLAKWWgvOxnEkw8geJHnwj/bNvrBuxBiC3jWd2CClXmHGt5OEzd1sqsC3SHUKpfRZyMKkYEcBryrcTxhecookIg6jOBqe7Scntqm2+pjJ7FHW3/DBA13VnI1RmocBCw28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776006369; c=relaxed/simple;
	bh=UcSympXQJ9b3M0RiLFwXAgw6p+0gTGwvhAg18x5yTB0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sG8am5Ue1OHVaJnrK2UfNxDET9DR+SHig+1ZiprnaQkw9/V9MJVJYMU5dBAB6gc38C73krq4WUDBmjmvYt/4uWoapdnmfSQhhbVoZD+4p5QkKa6nq4lc4m1XCe1Y/6VJVq9j+x34R+zqmjfgdiuS36yvUorfpJD4pWNcog9vn3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sv2v7JO6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sv2v7JO6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86C65C19424;
	Sun, 12 Apr 2026 15:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776006368;
	bh=UcSympXQJ9b3M0RiLFwXAgw6p+0gTGwvhAg18x5yTB0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sv2v7JO67veBqJeZo2TAd0BNRsS+Mksy460oi9Wtl3w4Ojjnm83il4lIOF0pvcK13
	 TXkzybAXMi5F4vCxgCIR1QVBFsOUGElV425xtfYnSPGrBTg2FUvVRqKGEJZWA/XBd8
	 WjC1w+uoic7OG+JOqbibm8gv16WGq7KPTQKSgMqpavGwkNge6FmQaN6+I9iM7fOWLc
	 IK7WcyAflLHGwLN1yRVlMelqjFFCIJdBkbEbyXKbR/XcM89IoO6UXOKbs32aOykJK+
	 om7yXciNx/CZJUJ0uODBdm1wDgDW5WGN/RyH+aMae4xreHe2jjQNtopOClgWckB3Di
	 FflQLdHR4HDAw==
Date: Sun, 12 Apr 2026 16:05:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Petr Mladek
 <pmladek@suse.com>, rodrigo.alencar@analog.com,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org, David Lechner
 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Morton
 <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, Rasmus
 Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v9 2/9] lib: vsprintf: export simple_strntoull() in a
 safe prototype
Message-ID: <20260412160555.4f0ac419@jic23-huawei>
In-Reply-To: <mnz7d2zd27x6h2qa24rajgrbhkhsypybadkqz2fi43rg7bvjvj@oufys7xs25t4>
References: <20260320-adf41513-iio-driver-v9-0-132f0d076374@analog.com>
	<20260320-adf41513-iio-driver-v9-2-132f0d076374@analog.com>
	<acZDneLrIPOmU5ci@pathway.suse.cz>
	<acZLHAT5qJyjKTsp@ashevche-desk.local>
	<4uijfg4efzaapu3esobez55hfwqzszwagpeb4lxej2ybmifu76@s3c57fmnsme6>
	<acZaGUV0MwuHNDru@ashevche-desk.local>
	<x34d7jz7be4ommjh6efx5mcq5pbpellykwuyrqayr4ske3lywf@wh46mu3anmcz>
	<qnb3ozrhrq5n4zkh2luitkpwr5oj4omgcuo5vnvy2gatdfdqlg@cgsgux7etcql>
	<mnz7d2zd27x6h2qa24rajgrbhkhsypybadkqz2fi43rg7bvjvj@oufys7xs25t4>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 31 Mar 2026 14:01:04 +0100
Rodrigo Alencar <455.rodrigo.alencar@gmail.com> wrote:

> On 26/03/30 01:49PM, Rodrigo Alencar wrote:
> > On 26/03/27 03:17PM, Rodrigo Alencar wrote:  
> > > On 26/03/27 12:21PM, Andy Shevchenko wrote:  
> > > > On Fri, Mar 27, 2026 at 10:11:56AM +0000, Rodrigo Alencar wrote:  
> > > > > On 26/03/27 11:17AM, Andy Shevchenko wrote:  
> > > > > > On Fri, Mar 27, 2026 at 09:45:17AM +0100, Petr Mladek wrote:  
> > > > > > > On Fri 2026-03-20 16:27:27, Rodrigo Alencar via B4 Relay wrote:  
> > 
> > ...
> >   
> > > > > > Maybe we want to have kstrtof32() and kstrtof64() for these two cases?
> > > > > > 
> > > > > > With that we will always consider the fraction part as 32- or 64-bit,
> > > > > > imply floor() on the fraction for the sake of simplicity and require
> > > > > > it to be NUL-terminated with possible trailing '\n'.  
> > > > > 
> > > > > I think this is a good idea, but calling it float or fixed point itself
> > > > > is a bit confusing as float often refers to the IEEE 754 standard and
> > > > > fixed point types is often expressed in Q-format.  
> > > > 
> > > > Yeah... I am lack of better naming.  
> > > 
> > > decimals is the name, but they are often represented as:
> > > 
> > > 	DECIMAL = INT * 10^X + FRAC
> > > 
> > > in a single 64-bit number, which would be fine for my end use case.
> > > However IIO decimal fixed point parsing is out there for quite some time a
> > > lot of drivers use that. The interface often relies on breaking parsed values
> > > into an integer array (for standard attributes int val and int val2 are expected).  
> > 
> > Thinking about this again and in IIO drivers we end up doing something like:
> > 
> > val64 = (u64)val * MICRO + val2;
> > 
> > so that drivers often work with scaled versions of the decimal value.
> > then, would it make sense to have a function that already outputs such value?
> > That would allow to have more freedom over the 64-bit split between integer
> > and fractional parts.
> > As a draft:
> > 
> > static int _kstrtodec64(const char *s, unsigned int scale, u64 *res)
> > {
> > 	u64 _res = 0, _frac = 0;
> > 	unsigned int rv;
> > 
> > 	if (*s != '.') {
> > 		rv = _parse_integer(s, 10, &_res);
> > 		if (rv & KSTRTOX_OVERFLOW)
> > 			return -ERANGE;
> > 		if (rv == 0)
> > 			return -EINVAL;
> > 		s += rv;
> > 	}
> > 
> > 	if (*s == '.') {
> > 		s++;
> > 		rv = _parse_integer_limit(s, 10, &_frac, scale);
> > 		if (rv & KSTRTOX_OVERFLOW)
> > 			return -ERANGE;
> > 		if (rv == 0)
> > 			return -EINVAL;
> > 		s += rv;
> > 		if (rv < scale)
> > 			_frac *= int_pow(10, scale - rv);
> > 		while (isdigit(*s)) /* truncate */
> > 			s++;
> > 	}
> > 
> > 	if (*s == '\n')
> > 		s++;
> > 	if (*s)
> > 		return -EINVAL;
> > 
> > 	if (check_mul_overflow(_res, int_pow(10, scale), &_res) ||
> > 	    check_add_overflow(_res, _frac, &_res))
> > 		return -ERANGE;
> > 
> > 	*res = _res;
> > 	return 0;
> > }
> > 
> > noinline
> > int kstrtoudec64(const char *s, unsigned int scale, u64 *res)
> > {
> > 	if (s[0] == '+')
> > 		s++;
> > 	return _kstrtodec64(s, scale, res);
> > }
> > EXPORT_SYMBOL(kstrtoudec64);
> > 
> > noinline
> > int kstrtosdec64(const char *s, unsigned int scale, s64 *res)
> > {
> > 	u64 tmp;
> > 	int rv;
> > 
> > 	if (s[0] == '-') {
> > 		rv = _kstrtodec64(s + 1, scale, &tmp);
> > 		if (rv < 0)
> > 			return rv;
> > 		if ((s64)-tmp > 0)
> > 			return -ERANGE;
> > 		*res = -tmp;
> > 	} else {
> > 		rv = kstrtoudec64(s, scale, &tmp);
> > 		if (rv < 0)
> > 			return rv;
> > 		if ((s64)tmp < 0)
> > 			return -ERANGE;
> > 		*res = tmp;
> > 	}
> > 	return 0;
> > }
> > EXPORT_SYMBOL(kstrtosdec64);
> > 
> > e.g., kstrtosdec64() or kstrtoudec64() parses "3.1415" with scale 3 into 3141  
> 
> Hi Jonathan,
> 
> developing more on that, I wouldn't need to create a iio_str_to_fixpoint64(),
> what do you think on new format types:
> 
> #define IIO_VAL_DECIMAL64_1 101
> #define IIO_VAL_DECIMAL64_2 102
> #define IIO_VAL_DECIMAL64_3 103
> #define IIO_VAL_DECIMAL64_4 104
> #define IIO_VAL_DECIMAL64_5 105
> #define IIO_VAL_DECIMAL64_6 106
> #define IIO_VAL_DECIMAL64_7 107
> #define IIO_VAL_DECIMAL64_8 108
> #define IIO_VAL_DECIMAL64_9 109
> #define IIO_VAL_DECIMAL64_10 110
> #define IIO_VAL_DECIMAL64_11 111
> #define IIO_VAL_DECIMAL64_12 112
> #define IIO_VAL_DECIMAL64_13 113
> #define IIO_VAL_DECIMAL64_14 114
> #define IIO_VAL_DECIMAL64_15 115

Seems unlikely more than a few of these would ever be used.
If you want to keep the offsets define them in terms
of first one + whatever makes sense (maybe with a base value
to make that easier - then MICRO is BASE + 6 etc)

> 
> #define IIO_VAL_DECIMAL64_MILLI IIO_VAL_DECIMAL64_3
> #define IIO_VAL_DECIMAL64_MICRO IIO_VAL_DECIMAL64_6
> #define IIO_VAL_DECIMAL64_NANO IIO_VAL_DECIMAL64_9
> #define IIO_VAL_DECIMAL64_PICO IIO_VAL_DECIMAL64_12
> #define IIO_VAL_DECIMAL64_FEMTO IIO_VAL_DECIMAL64_15
> 
> which gets stored as 64-bit, and represent the decimal scaled value.
> That would also work for the PLL driver (using IIO_VAL_DECIMAL64_MICRO):
>   - It supports frequency range from 1 to 26 GHz with micro Hz resolution
>   - In the driver a 64-bit value: (val * MICRO + val2) is already created
>   anyways.
> I would leverage something like kstrtodec64() in iio_write_channel_info().
> 
> That way, I would drop the changes on the iio fixpoint parse, which I think
> it would do better with something like kstrntoull() to be able to handle that
> "dB" suffix.
> 
> So for now, I may have the following approaches:
> - new kstrntoull() function: to have control over the parsing, whithout
>   requiring NUL-termination, avoiding unecessary string scanning or copying.
>   covered in v8.
> - expose a "safe" simple_strntoull(): minimal changes to vsprintf.c, this
>   is covered by this patch series (v9), and it similar solution to kstrntoull().
> - new kstrtodec64() function: parse decimal numbers as 64-bit with NUL-termination.
>   Might be covered in a v10, if it is a good idea.
> 
> let me know your thoughts.

For string parsing I'm not a particular expert, so I only really care
about useability of the end result.  Having types would work, but I'd kind
of want an 'odd ones' to stand out. Hence only defining them for parsing 
cases we already support (but with 64 bit values) would be my preference
if you got ahead with this new approach.

Jonathan

> 

