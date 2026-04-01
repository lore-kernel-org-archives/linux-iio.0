Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7292438238B
	for <linux-iio@vger.kernel.org>; Wed,  1 Apr 2026 12:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775046141; cv=none; b=X/f/RicooSeG5x3MSoddeNsQPpPmxBck0Sy/26yJ+eHga0GnIW3JVTEyCXJdEDfGIxm5M6ThR6sdQLlKrQNFFMlMA04HjeLDv907/lQjHsEZmlF1TCGdGRGHy8qvsSv6ZO/fYbAuiiAsdj1y4GQL9CBkUdo7aVl8WacxnZvAe7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775046141; c=relaxed/simple;
	bh=YsuTa5lww5YDewP07S+OGZgDQWwFL2bTgBarz21FTJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hb9c9qfl7ZpuIYc2U16NJUbyPm00rDAyCEcn3Zdh4O4cKES/UuVx0CYyNpPAmRv4hkoDnJuWxEMLVvo4kb6VkFkou0mZmygQC4+sVQ4/pznXWJfV1XdOCbtN94sp6wlxG0f899qt5cE04WnisuZeXLP+hkNjl5U7wCSVo/u1tI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=S+7GNyvM; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="S+7GNyvM"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-486fe655187so89324175e9.2
        for <linux-iio@vger.kernel.org>; Wed, 01 Apr 2026 05:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775046139; x=1775650939; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2JvmNkijtfkleZl4AVh3d/5C7ipYcZLtHwRqCUWikPo=;
        b=S+7GNyvMsbCFemCcYYP5Rfttkomv+zAQzRl4khfCO9ATuTwRMAlTgPJMK81oCybmQv
         pDsbTX92Zr+zEBhe9+O1/VPFlxuxpqA6ygxd8DI2zcc/g4v0CznQ0SraWIs/0ZbyVkdN
         zSB4mC0jmuvzLffHHIZ2vVBilLyNGqU+Z8mkizsqGXSKveq33FFdeatNAL3nh65Y01+Y
         v/1GLud0A/xKO4VftC9qAc1r3Ujprg1saJ6p98I7bLAAXBj0o+BAW83XgWQOzsTIP2Uh
         cHQBsP61+MaCr7aDH0SuLo63Pvj1XUMvqY3T4HdJ+w/m+To0R/4ctPzHoEbDNUh1bshz
         tZ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775046139; x=1775650939;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2JvmNkijtfkleZl4AVh3d/5C7ipYcZLtHwRqCUWikPo=;
        b=CEq+vCe+JVwi5qhrtZClt3IyDWi/ayAJHT5+bpxYM43zdgCjPFI2bdItRmgCdZOXZl
         2Od0c6Nd4gAxPX88KvdOdL19rtb4pGFvmQr/E1Rpuyiy6CwTTR7MUgAflyKPiBrgeT6k
         +x4uHDB36CfjBqp6mwe2YoOEEakgZR4K2Q4IagmgwTV6hnQt8gGH47Dqs6gZaejpn4zY
         fPNtEJtP3hpddyScc38y6EQ9pSVGJDbJDhEvbpG2Us/BEzocfDqySAgxiDI4nl+BDc6w
         cykZ3ni05c9U/ChYeU67EGKvBh5n56qhn0vfBUPM78cRHytaxYajnJRV4PfFOZqGdww2
         NT0w==
X-Forwarded-Encrypted: i=1; AJvYcCWcUFRCl81CEJwoqSGpIDWHoZ5WXjOYyx0sXSIWKHuJGGgh2TjlrPTXhDYkoNxj6vuGyb0tMLe1vk8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1RHALGX2a979ANCs0MyZqSRRhiiLvBg5FBlIygcBCXO6CBay3
	WjvvIaugclrqdfZ38q0mHIhWUjekQzEwR9Zp2zyRi/qf+bZVEoPPHq+SNI8lLULbnxo=
X-Gm-Gg: ATEYQzwRh+Sn0AnhYJzQQQwQKuK8jnCvExKnEZ24Q66OLQkKWCwalLqW7cv/XQ2CMWz
	cJ/Ge3YF8Co1aPgf9MZvUALRuQuicXpi9qCl4DEgbcgSvrhjUG4cC+PAjeWKPx/udD1nR5cc+Ej
	zz8upWT884U6cw9hCIvAz2HPJr639o0RvKhAaBJpxfqKPeDZRFtw4tOlxrA2XgLf7hvVW0YAVwQ
	OgA7SuDWsFMJBCMZKjLopPQfiAqIZONw04JxQbr9UzdH3eKkh+PTz9AVyOwR6m4/flAMu6kcKeQ
	iuovBBnfvS7+ZQK60rTa+AgSecBhl3zRiNig9MogJskuQEn4bby6sTrnvgWdJ8sn+m0FxQPXtWW
	IcpE/tGoi7u2Iw1qRMlbcdovvrT/XChfJD99qhb34CrBjK/gNVRQnUrKCzWeb1SZsmW1FeEw8Dw
	TT3Vg0jxM34v3CU+WvFMSsrPKZfw==
X-Received: by 2002:a05:600c:a4a:b0:487:21c7:2885 with SMTP id 5b1f17b1804b1-4888355e52cmr57407695e9.5.1775046138735;
        Wed, 01 Apr 2026 05:22:18 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e884dacsm160908025e9.15.2026.04.01.05.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 05:22:17 -0700 (PDT)
Date: Wed, 1 Apr 2026 14:22:11 +0200
From: Petr Mladek <pmladek@suse.com>
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org,
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
Message-ID: <ac0N89sNYcKAJkAP@pathway.suse.cz>
References: <20260320-adf41513-iio-driver-v9-0-132f0d076374@analog.com>
 <20260320-adf41513-iio-driver-v9-2-132f0d076374@analog.com>
 <acZDneLrIPOmU5ci@pathway.suse.cz>
 <acZLHAT5qJyjKTsp@ashevche-desk.local>
 <4uijfg4efzaapu3esobez55hfwqzszwagpeb4lxej2ybmifu76@s3c57fmnsme6>
 <acZaGUV0MwuHNDru@ashevche-desk.local>
 <x34d7jz7be4ommjh6efx5mcq5pbpellykwuyrqayr4ske3lywf@wh46mu3anmcz>
 <qnb3ozrhrq5n4zkh2luitkpwr5oj4omgcuo5vnvy2gatdfdqlg@cgsgux7etcql>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <qnb3ozrhrq5n4zkh2luitkpwr5oj4omgcuo5vnvy2gatdfdqlg@cgsgux7etcql>

On Mon 2026-03-30 13:49:48, Rodrigo Alencar wrote:
> On 26/03/27 03:17PM, Rodrigo Alencar wrote:
> > On 26/03/27 12:21PM, Andy Shevchenko wrote:
> > > On Fri, Mar 27, 2026 at 10:11:56AM +0000, Rodrigo Alencar wrote:
> > > > On 26/03/27 11:17AM, Andy Shevchenko wrote:
> > > > > On Fri, Mar 27, 2026 at 09:45:17AM +0100, Petr Mladek wrote:
> > > > > > On Fri 2026-03-20 16:27:27, Rodrigo Alencar via B4 Relay wrote:
> 
> ...
> 
> > > > > Maybe we want to have kstrtof32() and kstrtof64() for these two cases?
> > > > > 
> > > > > With that we will always consider the fraction part as 32- or 64-bit,
> > > > > imply floor() on the fraction for the sake of simplicity and require
> > > > > it to be NUL-terminated with possible trailing '\n'.
> > > > 
> > > > I think this is a good idea, but calling it float or fixed point itself
> > > > is a bit confusing as float often refers to the IEEE 754 standard and
> > > > fixed point types is often expressed in Q-format.
> > > 
> > > Yeah... I am lack of better naming.
> > 
> > decimals is the name, but they are often represented as:
> > 
> > 	DECIMAL = INT * 10^X + FRAC
> > 
> > in a single 64-bit number, which would be fine for my end use case.
> > However IIO decimal fixed point parsing is out there for quite some time a
> > lot of drivers use that. The interface often relies on breaking parsed values
> > into an integer array (for standard attributes int val and int val2 are expected).
> 
> Thinking about this again and in IIO drivers we end up doing something like:
> 
> val64 = (u64)val * MICRO + val2;
> 
> so that drivers often work with scaled versions of the decimal value.
> then, would it make sense to have a function that already outputs such value?
> That would allow to have more freedom over the 64-bit split between integer
> and fractional parts.
> As a draft:

My understanding is that you want to allow parsing frequencies
in the range from microHz to GHz.

So, you might want to support input in simple float numbers
with some precision, for example, 1.2GHz, 0.345Hz, ...

By simple, I mean that there is no x10^3 or so.

> static int _kstrtodec64(const char *s, unsigned int scale, u64 *res)

I would personally change this to something like:

  static int _unit_float_ktstrtodec64(const char *s, unsigned int precision, u64 *res, char **unit)

It would allow to read float number in the the format XXXX.YYYYunit,
for example 1.2Ghz

, where:

  + _unit_ means that it might set @unit pointer which point to the unit
    string right after the number part.

  + _float_ means that it will be able to read float numbers

  + @precisions parameter defines the number of digits accepted
    after the radix point. It is also used as multiplier for scaling
    the output number.

  + @res is pointer to the read number multiplied by the given
    @precision

  + @unit will be set to string after the number

For example:

  + s="1.2GHz", precision=3 will result in *res=1200, *unit="GHz"
  + s="0.0100004", precision=3 will result in *res=10, *unit=""
  + s=1.234567GHz, precision=3 will result in *res=1235, *unit="GHz"

Note that the result is rounded in the last example.

The function might be used like simple_strtoull() in memparse(),
see lib/cmdline.c. Which is able to read the given size in B
and handle various units like kB, GB, ...

> {
> 	u64 _res = 0, _frac = 0;
> 	unsigned int rv;
> 
> 	if (*s != '.') {
> 		rv = _parse_integer(s, 10, &_res);
> 		if (rv & KSTRTOX_OVERFLOW)
> 			return -ERANGE;
> 		if (rv == 0)
> 			return -EINVAL;
> 		s += rv;
> 	}
> 
> 	if (*s == '.') {
> 		s++;
> 		rv = _parse_integer_limit(s, 10, &_frac, scale);
> 		if (rv & KSTRTOX_OVERFLOW)
> 			return -ERANGE;
> 		if (rv == 0)
> 			return -EINVAL;
> 		s += rv;
> 		if (rv < scale)
> 			_frac *= int_pow(10, scale - rv);
> 		while (isdigit(*s)) /* truncate */
> 			s++;

We might/should use the first digit to round the _frac.

> 	}
> 
> 	if (*s == '\n')
> 		s++;
> 	if (*s)
> 		return -EINVAL;

I would omit this. Instead I would set @unit pointer so that the
caller might handle units defined after the number.

> 	if (check_mul_overflow(_res, int_pow(10, scale), &_res) ||
> 	    check_add_overflow(_res, _frac, &_res))
> 		return -ERANGE;
> 
> 	*res = _res;
> 	return 0;
> }

Otherwise, this approach looks sensible to me. IMHO, some generic
API for reading numbers with misc units should be usable in more
situations. And it would make the kernel interface more user
friendly.

Of course, we must not over-engineer it. But the above does not
look much more complex than we already have.

Best Regards,
Petr

PS: I am sorry if I used some mathematical terms a wrong way.
    I am not a native speaker. And it is a long time since
    I worked with float numbers.
