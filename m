Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD883CAE89
	for <linux-iio@vger.kernel.org>; Mon, 30 Mar 2026 12:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774874998; cv=none; b=lJcC+QGEpKfoLlxgfDliH54f0HPOK6T265yRQefwLLYlXND9sGKR0IfjEXdcYUTCucnE6qRn7MmzQ50WqoHq3eeT+wq5BsOOg/cJuA4aZKxPrIvX444I5bsq3MEajndP/Ig1EYjRSdCYyZiiEnkOQMeiitvYjkBYBDCXrj+mtus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774874998; c=relaxed/simple;
	bh=WWyTk+NtT7VBydiBDCtThdwfOouiS0kGioG4tnTS5wg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I+bG+YRGGXSthd9xt+HuubFvmtXTdBalZPDJUecdQW4rwEu4sRKBMwO6tXP10SBp3rPFI04yutW8Uebri8gLRHDaXBP5Zd+cpPryEYqWjNh43IE0413LPIV/M33fDh+15K33q32RvzD9eMbZ4SwS+VuvI3VfLc+otT8Bgted8yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cxGNkqDU; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxGNkqDU"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43cf5d14d6eso1371365f8f.0
        for <linux-iio@vger.kernel.org>; Mon, 30 Mar 2026 05:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774874995; x=1775479795; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vIPxU8NPiUBkc7/lauG310zB4DTmb8xB6TYqBKHKduU=;
        b=cxGNkqDUsgdinQZCDnxI7wYeprLxwOOUKHW3nvHU/WStsBT0kwRF9+xP2wge840F1M
         FF472gNa6SYjWypywlg96mm3YqKaPi7RkXx7GNdgDybDh4F75WDZRyYDoAqszwUkQALd
         dphxPSLlGaiIwom8lSQo0zZCEL5PUPjT3BGNIPK+IA0/SwOAeWJvE931gpPsuF9doxR8
         vAca3J/bAjBFoilSo2W+mPEREDUbMOhPkHTgQVgkpVBGlJuAWAFzPYOMUfB085eKV9xk
         3mIFHTLAyhIesCPypKg68hGRagOgsKV0CcCR5PQHxjjilsRFl2J9mhzA/NnOs6DSMiBW
         5qZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774874995; x=1775479795;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vIPxU8NPiUBkc7/lauG310zB4DTmb8xB6TYqBKHKduU=;
        b=OIqjlRlEHejkKu+gDB0RMNbCzWZ508yrDp6XnujTHxELlWXBQgc8qXHl8UWNckSUmN
         75v6JkQIpguBUHAj/HCLBtlq0XaB1FnOdbYIxrgaliklEF/+Z55DTJGkEVVl8vPbDsHY
         5rUNfVexLlJeMGCAU2Gim1pUVHGDA77ABM2iskhUJc5X16xPeVP6xyOUpAoRzs2v+4jI
         Pfmj12lOZ656EzY1c4hjLdCYzKphqLEHiAFX6KJ1VIB6woB+t2eNm/7vvqLVDOXwh9SM
         lZerceaGu+2tRO75nW6S5K4IdOKJovq0nKAe2Mj0iR/AFr6kvTPZKcx1KRIhSOPp2QKl
         kElQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4wUIwgP9gBj3tXJsBL2ei4nTUGlA9tt9VuF5UQieOWthDW/867wLv7uXiZ8+VEY1e9CABs5tIjfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4adhILKSHOEsnPUU15ENnCmOANmb2gV0FunqMs4ZGBliEmthE
	AyTzvXQ9hQvm86z+LZNJtgzTKCrgKDi2g5Y3y0NgyEzWsbdoOh0SNeoo
X-Gm-Gg: ATEYQzzcnj91b926tdFDOSQcdXh6FBj13gRNp1FanSTquwYUxU1gtJhlvaGHjeY5Fx9
	lKQz4WH5FOtweaxUGeEjRd4UuGYMks9QgXTpuTWYQBOFd5CmHoLXLKlor6LEbMRPO1DnHnbGSAM
	3PsEPng4pZYraS4FdDxbrO7ollxqjMuhhjulVcWJU6u8y3TBV/h7JRQaV8tZgT+KK4bnjrya/LW
	KJFcnS+UW4rSDrIUp6yuysrec+GmgH1X8JrMD5lI9inWyba1ErhXeOnj89us0pzlUm1mBQ6nxxt
	nPvjOh91A8kSUrK7RW7m7NBwcXIjgHNbE9zciCFKSPi3F49L9lpMFGRm6D14cbg9qJMvy2ef5/P
	pnfM3MqKrx2izfpd2HummHUQiC46l57nqh4X9c+ehje5jsVGYRBcwSoeQBoJihKUOX3/BFR8YN5
	4y9MqCibsHxnc9+92J0fdrVbsPjNCr98rKM0XEBO+coAXJxK+e5qkYhb7pdsETaDFH9v2j04L7k
	XElVHnGlBmmNJ7ozhtJ5tTS5SRYH/sexp6DwFyWE5oKippznaQ=
X-Received: by 2002:a05:6000:2003:b0:43b:45d1:f438 with SMTP id ffacd0b85a97d-43b9e9da653mr20627980f8f.3.1774874995133;
        Mon, 30 Mar 2026 05:49:55 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.131.netskope-rdns.com. [24.206.116.131])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf2471ee2sm17842031f8f.29.2026.03.30.05.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 05:49:54 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Mon, 30 Mar 2026 13:49:48 +0100
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Petr Mladek <pmladek@suse.com>, rodrigo.alencar@analog.com, 
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-doc@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v9 2/9] lib: vsprintf: export simple_strntoull() in a
 safe prototype
Message-ID: <qnb3ozrhrq5n4zkh2luitkpwr5oj4omgcuo5vnvy2gatdfdqlg@cgsgux7etcql>
References: <20260320-adf41513-iio-driver-v9-0-132f0d076374@analog.com>
 <20260320-adf41513-iio-driver-v9-2-132f0d076374@analog.com>
 <acZDneLrIPOmU5ci@pathway.suse.cz>
 <acZLHAT5qJyjKTsp@ashevche-desk.local>
 <4uijfg4efzaapu3esobez55hfwqzszwagpeb4lxej2ybmifu76@s3c57fmnsme6>
 <acZaGUV0MwuHNDru@ashevche-desk.local>
 <x34d7jz7be4ommjh6efx5mcq5pbpellykwuyrqayr4ske3lywf@wh46mu3anmcz>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <x34d7jz7be4ommjh6efx5mcq5pbpellykwuyrqayr4ske3lywf@wh46mu3anmcz>

On 26/03/27 03:17PM, Rodrigo Alencar wrote:
> On 26/03/27 12:21PM, Andy Shevchenko wrote:
> > On Fri, Mar 27, 2026 at 10:11:56AM +0000, Rodrigo Alencar wrote:
> > > On 26/03/27 11:17AM, Andy Shevchenko wrote:
> > > > On Fri, Mar 27, 2026 at 09:45:17AM +0100, Petr Mladek wrote:
> > > > > On Fri 2026-03-20 16:27:27, Rodrigo Alencar via B4 Relay wrote:

...

> > > > Maybe we want to have kstrtof32() and kstrtof64() for these two cases?
> > > > 
> > > > With that we will always consider the fraction part as 32- or 64-bit,
> > > > imply floor() on the fraction for the sake of simplicity and require
> > > > it to be NUL-terminated with possible trailing '\n'.
> > > 
> > > I think this is a good idea, but calling it float or fixed point itself
> > > is a bit confusing as float often refers to the IEEE 754 standard and
> > > fixed point types is often expressed in Q-format.
> > 
> > Yeah... I am lack of better naming.
> 
> decimals is the name, but they are often represented as:
> 
> 	DECIMAL = INT * 10^X + FRAC
> 
> in a single 64-bit number, which would be fine for my end use case.
> However IIO decimal fixed point parsing is out there for quite some time a
> lot of drivers use that. The interface often relies on breaking parsed values
> into an integer array (for standard attributes int val and int val2 are expected).

Thinking about this again and in IIO drivers we end up doing something like:

val64 = (u64)val * MICRO + val2;

so that drivers often work with scaled versions of the decimal value.
then, would it make sense to have a function that already outputs such value?
That would allow to have more freedom over the 64-bit split between integer
and fractional parts.
As a draft:

static int _kstrtodec64(const char *s, unsigned int scale, u64 *res)
{
	u64 _res = 0, _frac = 0;
	unsigned int rv;

	if (*s != '.') {
		rv = _parse_integer(s, 10, &_res);
		if (rv & KSTRTOX_OVERFLOW)
			return -ERANGE;
		if (rv == 0)
			return -EINVAL;
		s += rv;
	}

	if (*s == '.') {
		s++;
		rv = _parse_integer_limit(s, 10, &_frac, scale);
		if (rv & KSTRTOX_OVERFLOW)
			return -ERANGE;
		if (rv == 0)
			return -EINVAL;
		s += rv;
		if (rv < scale)
			_frac *= int_pow(10, scale - rv);
		while (isdigit(*s)) /* truncate */
			s++;
	}

	if (*s == '\n')
		s++;
	if (*s)
		return -EINVAL;

	if (check_mul_overflow(_res, int_pow(10, scale), &_res) ||
	    check_add_overflow(_res, _frac, &_res))
		return -ERANGE;

	*res = _res;
	return 0;
}

noinline
int kstrtoudec64(const char *s, unsigned int scale, u64 *res)
{
	if (s[0] == '+')
		s++;
	return _kstrtodec64(s, scale, res);
}
EXPORT_SYMBOL(kstrtoudec64);

noinline
int kstrtosdec64(const char *s, unsigned int scale, s64 *res)
{
	u64 tmp;
	int rv;

	if (s[0] == '-') {
		rv = _kstrtodec64(s + 1, scale, &tmp);
		if (rv < 0)
			return rv;
		if ((s64)-tmp > 0)
			return -ERANGE;
		*res = -tmp;
	} else {
		rv = kstrtoudec64(s, scale, &tmp);
		if (rv < 0)
			return rv;
		if ((s64)tmp < 0)
			return -ERANGE;
		*res = tmp;
	}
	return 0;
}
EXPORT_SYMBOL(kstrtosdec64);

e.g., kstrtosdec64() or kstrtoudec64() parses "3.1415" with scale 3 into 3141


-- 
Kind regards,

Rodrigo Alencar
