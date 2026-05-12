Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892D3360EC9;
	Tue, 12 May 2026 11:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778586007; cv=none; b=ml5XSoLWrqo7yznRN6LpCULGSzzsx686vKxI2eVN7MIw5dZdJUSS90OeuCrkwjCaZsEQEC/QtZWtcG0L5vf8e7VbE9EF5c1PbItQQT7PTCgluytuiaSVi5c0P64OfuTwuNzYPIAdo79ODUWgT7NfONU4qjMvEgK/KCS6buNuuL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778586007; c=relaxed/simple;
	bh=sAb39qTp+vHuh7hzcoR8g5rHErQJcRmQkIRa9ZzBAVw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rHwUeDk2BK5KR1d4g5lCUYukZqpvkvtEIEK9nWYJXfv78ccw2ZYyCBgFTDkF1hVeNoRZF//ixyz2BN6gw0NNg+P+MHApCUtKCDaO7mdNEkI92vEMLHr6KtMmVGIcGJfl8P5uRQomlY8w2Nctyzpaig4Whu2JFVprxu4sz9LLZgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KoLTI9kP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KoLTI9kP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2374EC2BCB0;
	Tue, 12 May 2026 11:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778586007;
	bh=sAb39qTp+vHuh7hzcoR8g5rHErQJcRmQkIRa9ZzBAVw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KoLTI9kPKwZ0lflIzroveAtPnWPcLJqjlyB6cOjWmkqnB7LTr4z1o8Ltsbd/ndRpV
	 ogtt/WIdFckg9YLw7eUIlrIzb467u9+OPPy0c6raarVOjjJwb7RMlBo3R0BpgQen11
	 Xmuhw53x6yB5HFfiUuiQprbBYpWdCgmz8AAYjr8wQ0pupJDeZ5S+JIcYZIw+jYjLrG
	 dMJQIWuYPhXOkaJ0q9NbcGsnrcscsNevuuv1aBenrn1B1XMhe1V6ypTdWSXpQv//RR
	 TxA9G+4tDLD8PPcPVhrECehx2bskvtHtKnIHmJ/u9gE9FwFFuT+R9CEyAvdiOuCvlP
	 nX9CYy9limntA==
Date: Tue, 12 May 2026 12:39:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-doc@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Andrew Morton
 <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>, Steven Rostedt
 <rostedt@goodmis.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Shuah Khan <skhan@linuxfoundation.org>, David
 Laight <david.laight.linux@gmail.com>
Subject: Re: [PATCH v12 02/11] lib: kstrtox: add kstrtoudec64() and
 kstrtodec64()
Message-ID: <20260512123953.40d80bc9@jic23-huawei>
In-Reply-To: <20260510-adf41513-iio-driver-v12-2-34af2ed2779f@analog.com>
References: <20260510-adf41513-iio-driver-v12-0-34af2ed2779f@analog.com>
	<20260510-adf41513-iio-driver-v12-2-34af2ed2779f@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 10 May 2026 13:42:20 +0100
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Add helpers that parses decimal numbers into 64-bit number, i.e., decimal
> point numbers with pre-defined scale are parsed into a 64-bit value (fixed
> precision). After the decimal point, digits beyond the specified scale
> are ignored.
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>

Whilst Rodrigo has already replied to say there will be another version
I'd like to request final feedback from those who were involved in the parser
discussions.  

They got very involved and I'm far from an expert in the right way to do
this stuff.  

I don't think David Laight was +CC so I've added that.
David, Andy - I think you two were most involved in that discussion:
Any objections to the end result? 

Thanks,

Jonathan


> ---
>  include/linux/kstrtox.h |   3 ++
>  lib/kstrtox.c           | 107 ++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 110 insertions(+)
> 
> diff --git a/include/linux/kstrtox.h b/include/linux/kstrtox.h
> index 6ea897222af1..bec2fc17bde0 100644
> --- a/include/linux/kstrtox.h
> +++ b/include/linux/kstrtox.h
> @@ -97,6 +97,9 @@ int __must_check kstrtou8(const char *s, unsigned int base, u8 *res);
>  int __must_check kstrtos8(const char *s, unsigned int base, s8 *res);
>  int __must_check kstrtobool(const char *s, bool *res);
>  
> +int __must_check kstrtoudec64(const char *s, unsigned int scale, u64 *res);
> +int __must_check kstrtodec64(const char *s, unsigned int scale, s64 *res);
> +
>  int __must_check kstrtoull_from_user(const char __user *s, size_t count, unsigned int base, unsigned long long *res);
>  int __must_check kstrtoll_from_user(const char __user *s, size_t count, unsigned int base, long long *res);
>  int __must_check kstrtoul_from_user(const char __user *s, size_t count, unsigned int base, unsigned long *res);
> diff --git a/lib/kstrtox.c b/lib/kstrtox.c
> index 97be2a39f537..da7b5f83a3c5 100644
> --- a/lib/kstrtox.c
> +++ b/lib/kstrtox.c
> @@ -17,6 +17,7 @@
>  #include <linux/export.h>
>  #include <linux/kstrtox.h>
>  #include <linux/math64.h>
> +#include <linux/overflow.h>
>  #include <linux/types.h>
>  #include <linux/uaccess.h>
>  
> @@ -392,6 +393,112 @@ int kstrtobool(const char *s, bool *res)
>  }
>  EXPORT_SYMBOL(kstrtobool);
>  
> +static int _kstrtoudec64(const char *s, unsigned int scale, u64 *res)
> +{
> +	u64 _res = 0, _frac = 0;
> +	unsigned int rv;
> +
> +	if (scale > 19) /* log10(2^64) = 19.26 */
> +		return -EINVAL;
> +
> +	if (*s != '.') {
> +		rv = _parse_integer(s, 10, &_res);
> +		if (rv & KSTRTOX_OVERFLOW)
> +			return -ERANGE;
> +		if (rv == 0)
> +			return -EINVAL;
> +		s += rv;
> +	}
> +
> +	if (*s == '.' && scale) {
> +		s++; /* skip decimal point */
> +		rv = _parse_integer_limit(s, 10, &_frac, scale);
> +		if (rv & KSTRTOX_OVERFLOW)
> +			return -ERANGE;
> +		if (rv == 0)
> +			return -EINVAL;
> +		s += rv;
> +		if (rv < scale)
> +			_frac *= int_pow(10, scale - rv);
> +		while (isdigit(*s)) /* truncate */
> +			s++;
> +	}
> +
> +	if (*s == '\n')
> +		s++;
> +	if (*s)
> +		return -EINVAL;
> +
> +	if (check_mul_overflow(_res, int_pow(10, scale), &_res) ||
> +	    check_add_overflow(_res, _frac, &_res))
> +		return -ERANGE;
> +
> +	*res = _res;
> +	return 0;
> +}
> +
> +/**
> + * kstrtoudec64() - Convert a string to an unsigned 64-bit value that represents
> + *		    a scaled decimal number.
> + * @s: The start of the string. The string must be null-terminated, and may also
> + *  include a single newline before its terminating null. The first character
> + *  may also be a plus sign, but not a minus sign. Digits beyond the specified
> + *  scale are ignored.
> + * @scale: The number of digits to the right of the decimal point. For example,
> + *  a scale of 2 would mean the number is represented with two decimal places,
> + *  so "123.45" would be represented as 12345.
> + * @res: Where to write the result of the conversion on success.
> + *
> + * Return: 0 on success, -ERANGE on overflow and -EINVAL on parsing error.
> + */
> +noinline
> +int kstrtoudec64(const char *s, unsigned int scale, u64 *res)
> +{
> +	if (s[0] == '+')
> +		s++;
> +	return _kstrtoudec64(s, scale, res);
> +}
> +EXPORT_SYMBOL(kstrtoudec64);
> +
> +/**
> + * kstrtodec64() - Convert a string to a signed 64-bit value that represents a
> + *		   scaled decimal number.
> + * @s: The start of the string. The string must be null-terminated, and may also
> + *  include a single newline before its terminating null. The first character
> + *  may also be a plus sign or a minus sign. Digits beyond the specified
> + *  scale are ignored.
> + * @scale: The number of digits to the right of the decimal point. For example,
> + *  a scale of 5 would mean the number is represented with five decimal places,
> + *  so "-3.141592" would be represented as -314159.
> + * @res: Where to write the result of the conversion on success.
> + *
> + * Return: 0 on success, -ERANGE on overflow and -EINVAL on parsing error.
> + */
> +noinline
> +int kstrtodec64(const char *s, unsigned int scale, s64 *res)
> +{
> +	u64 tmp;
> +	int rv;
> +
> +	if (s[0] == '-') {
> +		rv = _kstrtoudec64(s + 1, scale, &tmp);
> +		if (rv < 0)
> +			return rv;
> +		if ((s64)-tmp > 0)
> +			return -ERANGE;
> +		*res = -tmp;
> +	} else {
> +		rv = kstrtoudec64(s, scale, &tmp);
> +		if (rv < 0)
> +			return rv;
> +		if ((s64)tmp < 0)
> +			return -ERANGE;
> +		*res = tmp;
> +	}
> +	return 0;
> +}
> +EXPORT_SYMBOL(kstrtodec64);
> +
>  /*
>   * Since "base" would be a nonsense argument, this open-codes the
>   * _from_user helper instead of using the helper macro below.
> 

