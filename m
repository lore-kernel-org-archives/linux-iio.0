Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E602386C1E
	for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 11:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778586756; cv=none; b=uYvWH025GZ6uLvy4ihzFK1/LuWM9AoSpzoISUXryM/s2h1n2YMQJmbUWUofxmG4XBJwLn8+k150TIGa4JVas5wHaS57C3/OpGMfJlTBrpJMtoHtWrrjB887InxupVlNW1ZRqegrb4Y949YJvA7H47Aem9YuLsKiVReeI61XpYao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778586756; c=relaxed/simple;
	bh=q0toXFtdCq3Gd+N6IgETwyG7TGJD8jNf6JYTpn7lJtI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tG1yJy9Cx/yjuAcruA/W1OWchqLA8hgpkRrLhEdB8KzLakl8UYZ12QC/+Z5tnSjn+ks2dlab56byhdVBlMCmHpYYoFeAc9Duc9tr8H34yLSWGwb4TGOvLYZCBUTjppnsgvx7uSTV4Hd9ghDPRvGWhOb2oNbLjKNJRulH6ehkT0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=icLlewEA; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="icLlewEA"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488e1a8ac40so53069625e9.2
        for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 04:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778586753; x=1779191553; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xiotYhVrHRnwS6rwT87KZq6Tjp1oH1i2jknlxHPxVk0=;
        b=icLlewEApWrjhDb7l1QbIfjfj97emDKwPEDz8PQuWPsO3Luw42gifpz+WZ/an2n0OK
         Cqs4nCT/Ntv8kVr4fXQr1HYwmSl0YXkF813l286yTQBsbfXWievHgJA3tM+QDc2e2WFf
         p9GY+14Sa8SOrWzJjq2XaeVqTtQsqM5Vz155RUmvrYFVHyvGo6xPdp15b0TWAwEO1pbK
         wW2ZGm2Lbr5HleDT/To24q89YUOe/S5FZxPNCXNN5YCXCbAhPnIGVTAOjoqQeJJXxsP8
         FBpyEpWutcxr/+N5tJC7Z1aPw9sCNIYDEVbXROu4UT7OaQo4/Af16pVolqlD3Gg/S7mO
         EF+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778586753; x=1779191553;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xiotYhVrHRnwS6rwT87KZq6Tjp1oH1i2jknlxHPxVk0=;
        b=h7+M0oF8hFNRzyS/ucSnBCYDUC86pfeo0ca14hw/4zxJc7O3jQuUXTcwTaDY38gy9H
         n6ZtsGHm246D1mpH5t8qUm4Cmq5J+DIaBOqSQWx2dcl+fQESrfhsZMCrfz4pf/60uunz
         w+G/Fi4rMV7MecoZYejCEJ14FHW25+1lU9zoYM3Agicz4rj5WT1FG0ZD1rjOCVbCxCsP
         iwYYZcKkdFHD91zHSAl8/IhPFkleqLN0wakQno6kNA0YCYCK04H/ls3MZ5T8NNVLNFdK
         lsus3bsghEpCLEfVuqYY9V0c3Mx4cnVffN57CvPTGIy//CCIti9Sx8NqGozM/V8dlDkv
         ybsA==
X-Forwarded-Encrypted: i=1; AFNElJ/8jrkrNwakANWFepGEWOQ1WY5fGDAtdsHriIYpRwkMKQUKz9IyylXuxlqRK6PEQ5GqBOtxPTEkges=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+3EgwI354VhlTFl/UO+TF7pxQdlVMP8Qc5I+sIDXoCq/wg1Sf
	S7LNta0w5odrdpmRhYLMjBi+zaBgi6Tt4G2vsI25L96pvbXDngPlrG4L
X-Gm-Gg: Acq92OGSDmHr5mIwkNYGE5H9pvtExNLkS9r8oqFGSDmk/32T/Yh4livA3iur8jzJsA3
	U2cj3VZ4lRCmkHLq+uSi2h3wLuOqgoeMP+fqXA6A2qMOS1qtc3WAUmf5xX+BjvvGmpirTQC6oX+
	nld5z/E/ITobzXzvVsr00c8eSLxfhBwzmkQ9SUjWXCZNdzDRKku1ha4RMSkYdnLXn+3+fUMTGd3
	UWLzNqvqbLOmyEZVqPt/xkzPzaoSg8/8D5G9Q+NwdAccHl+NYl+tfRbZ5us2xtMQE/sLbOdkHmO
	AjEV6Zzfoe7rqG2aro9GgcFokcZqru42arkqghrW1MndgIPcCSt0fCv8s+UgF/yfwLmEN0NXhMA
	h0pemdG+oyGL0QkmzhRy9VM5pFxQDaTjr+iRwQvpC++3I/tyB5ec+7V1PDu0W/lDafOyDgc5+A+
	ZSnaUEwQusUi5yy80s6fiUVg5x5jmrc5sK2JvgdCVQtu+hgr9KuFzFUq6Fx5ye8OHVHBPZr/MiD
	EKHgkEtFgKdCoeuM5UNmdcdUGayioLMuiHBlg70cStCkDS0oA==
X-Received: by 2002:a05:600c:8b57:b0:48e:706b:53e3 with SMTP id 5b1f17b1804b1-48e8fe4b07dmr43967305e9.1.1778586753200;
        Tue, 12 May 2026 04:52:33 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.131.netskope-rdns.com. [24.206.116.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e906ae8b5sm71070485e9.6.2026.05.12.04.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 04:52:32 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Tue, 12 May 2026 12:52:28 +0100
To: Jonathan Cameron <jic23@kernel.org>, 
	Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, David Laight <david.laight.linux@gmail.com>
Subject: Re: [PATCH v12 02/11] lib: kstrtox: add kstrtoudec64() and
 kstrtodec64()
Message-ID: <aldsbu5etakdgrg2qjpcnaehyvr7n352j5huv6ipyjrmnqtvxa@2rkypkhor4mi>
References: <20260510-adf41513-iio-driver-v12-0-34af2ed2779f@analog.com>
 <20260510-adf41513-iio-driver-v12-2-34af2ed2779f@analog.com>
 <20260512123953.40d80bc9@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512123953.40d80bc9@jic23-huawei>

On 26/05/12 12:39PM, Jonathan Cameron wrote:
> On Sun, 10 May 2026 13:42:20 +0100
> Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
> 
> > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > 
> > Add helpers that parses decimal numbers into 64-bit number, i.e., decimal
> > point numbers with pre-defined scale are parsed into a 64-bit value (fixed
> > precision). After the decimal point, digits beyond the specified scale
> > are ignored.
> > 
> > Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Whilst Rodrigo has already replied to say there will be another version
> I'd like to request final feedback from those who were involved in the parser
> discussions.  
> 
> They got very involved and I'm far from an expert in the right way to do
> this stuff.  
> 
> I don't think David Laight was +CC so I've added that.
> David, Andy - I think you two were most involved in that discussion:
> Any objections to the end result? 

I am evaluating on taking sashiko's feedback here too, so it is a good
time to check this again indeed.

> Thanks,
> 
> Jonathan
> 
> 
> > ---
> >  include/linux/kstrtox.h |   3 ++
> >  lib/kstrtox.c           | 107 ++++++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 110 insertions(+)
> > 
> > diff --git a/include/linux/kstrtox.h b/include/linux/kstrtox.h
> > index 6ea897222af1..bec2fc17bde0 100644
> > --- a/include/linux/kstrtox.h
> > +++ b/include/linux/kstrtox.h
> > @@ -97,6 +97,9 @@ int __must_check kstrtou8(const char *s, unsigned int base, u8 *res);
> >  int __must_check kstrtos8(const char *s, unsigned int base, s8 *res);
> >  int __must_check kstrtobool(const char *s, bool *res);
> >  
> > +int __must_check kstrtoudec64(const char *s, unsigned int scale, u64 *res);
> > +int __must_check kstrtodec64(const char *s, unsigned int scale, s64 *res);
> > +
> >  int __must_check kstrtoull_from_user(const char __user *s, size_t count, unsigned int base, unsigned long long *res);
> >  int __must_check kstrtoll_from_user(const char __user *s, size_t count, unsigned int base, long long *res);
> >  int __must_check kstrtoul_from_user(const char __user *s, size_t count, unsigned int base, unsigned long *res);
> > diff --git a/lib/kstrtox.c b/lib/kstrtox.c
> > index 97be2a39f537..da7b5f83a3c5 100644
> > --- a/lib/kstrtox.c
> > +++ b/lib/kstrtox.c
> > @@ -17,6 +17,7 @@
> >  #include <linux/export.h>
> >  #include <linux/kstrtox.h>
> >  #include <linux/math64.h>
> > +#include <linux/overflow.h>
> >  #include <linux/types.h>
> >  #include <linux/uaccess.h>
> >  
> > @@ -392,6 +393,112 @@ int kstrtobool(const char *s, bool *res)
> >  }
> >  EXPORT_SYMBOL(kstrtobool);
> >  
> > +static int _kstrtoudec64(const char *s, unsigned int scale, u64 *res)
> > +{
> > +	u64 _res = 0, _frac = 0;
> > +	unsigned int rv;
> > +
> > +	if (scale > 19) /* log10(2^64) = 19.26 */
> > +		return -EINVAL;
> > +
> > +	if (*s != '.') {
> > +		rv = _parse_integer(s, 10, &_res);
> > +		if (rv & KSTRTOX_OVERFLOW)
> > +			return -ERANGE;
> > +		if (rv == 0)
> > +			return -EINVAL;
> > +		s += rv;
> > +	}
> > +
> > +	if (*s == '.' && scale) {

I havent really considered the scale == 0 case, I suppose that
one could rely on kstrtoull() instead. But as sashiko points
out, it deviates from the documented behavior. Also, I will
consider accepting "123." as a valid input, I see that others
parsers do that and should not be a problem. So I will add a
small change here. Also will make sure the test cases are ok.

> > +		s++; /* skip decimal point */
> > +		rv = _parse_integer_limit(s, 10, &_frac, scale);
> > +		if (rv & KSTRTOX_OVERFLOW)
> > +			return -ERANGE;
> > +		if (rv == 0)
> > +			return -EINVAL;
> > +		s += rv;
> > +		if (rv < scale)
> > +			_frac *= int_pow(10, scale - rv);
> > +		while (isdigit(*s)) /* truncate */
> > +			s++;
> > +	}
> > +
> > +	if (*s == '\n')
> > +		s++;
> > +	if (*s)
> > +		return -EINVAL;
> > +
> > +	if (check_mul_overflow(_res, int_pow(10, scale), &_res) ||
> > +	    check_add_overflow(_res, _frac, &_res))
> > +		return -ERANGE;
> > +
> > +	*res = _res;
> > +	return 0;
> > +}
> > +
> > +/**
> > + * kstrtoudec64() - Convert a string to an unsigned 64-bit value that represents
> > + *		    a scaled decimal number.
> > + * @s: The start of the string. The string must be null-terminated, and may also
> > + *  include a single newline before its terminating null. The first character
> > + *  may also be a plus sign, but not a minus sign. Digits beyond the specified
> > + *  scale are ignored.
> > + * @scale: The number of digits to the right of the decimal point. For example,
> > + *  a scale of 2 would mean the number is represented with two decimal places,
> > + *  so "123.45" would be represented as 12345.
> > + * @res: Where to write the result of the conversion on success.
> > + *
> > + * Return: 0 on success, -ERANGE on overflow and -EINVAL on parsing error.
> > + */
> > +noinline
> > +int kstrtoudec64(const char *s, unsigned int scale, u64 *res)
> > +{
> > +	if (s[0] == '+')
> > +		s++;
> > +	return _kstrtoudec64(s, scale, res);
> > +}
> > +EXPORT_SYMBOL(kstrtoudec64);
> > +
> > +/**
> > + * kstrtodec64() - Convert a string to a signed 64-bit value that represents a
> > + *		   scaled decimal number.
> > + * @s: The start of the string. The string must be null-terminated, and may also
> > + *  include a single newline before its terminating null. The first character
> > + *  may also be a plus sign or a minus sign. Digits beyond the specified
> > + *  scale are ignored.
> > + * @scale: The number of digits to the right of the decimal point. For example,
> > + *  a scale of 5 would mean the number is represented with five decimal places,
> > + *  so "-3.141592" would be represented as -314159.
> > + * @res: Where to write the result of the conversion on success.
> > + *
> > + * Return: 0 on success, -ERANGE on overflow and -EINVAL on parsing error.
> > + */
> > +noinline
> > +int kstrtodec64(const char *s, unsigned int scale, s64 *res)
> > +{
> > +	u64 tmp;
> > +	int rv;
> > +
> > +	if (s[0] == '-') {
> > +		rv = _kstrtoudec64(s + 1, scale, &tmp);
> > +		if (rv < 0)
> > +			return rv;
> > +		if ((s64)-tmp > 0)
> > +			return -ERANGE;
> > +		*res = -tmp;
> > +	} else {
> > +		rv = kstrtoudec64(s, scale, &tmp);
> > +		if (rv < 0)
> > +			return rv;
> > +		if ((s64)tmp < 0)
> > +			return -ERANGE;
> > +		*res = tmp;
> > +	}
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL(kstrtodec64);
> > +
> >  /*
> >   * Since "base" would be a nonsense argument, this open-codes the
> >   * _from_user helper instead of using the helper macro below.
> > 
> 

-- 
Kind regards,

Rodrigo Alencar
