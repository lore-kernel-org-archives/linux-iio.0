Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8DA2E22AB
	for <linux-iio@vger.kernel.org>; Mon,  2 Feb 2026 09:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770026225; cv=none; b=qoIiXXcSGsCpy7aE3o0Af2zS0Mksx92ZwqemlDeEZt1zE90GS5YPiA1+x2YSNQia6Bsf6WxxhcuhjsublxApyBgYXbgM3bJvCq/BKQ7DlKGzO9Vmhk8gw3R1IwxW/zkuAuITIoaI6AwtJcI1whxTEmPLPGn6NFfZIbKKBv15FYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770026225; c=relaxed/simple;
	bh=aQyS+hE0k2g5HzJUxy2lGI++kpB0sDD0gMSMsx1vkYE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RmsHYScI8sMYCvECWCXb3Vton91UdEinAXRiQmwhkhYr9YA2hskTH2suoTLyqHt3C26iNwn9uWh+2Edg8PRXeveq8xTNpYd+9bw25vXqxFW2eaYrEyQ7oKoPzaLJaGs5BI4ygXLLWQvvxIi353DChsbNpu20XcT5DQPOVObGjiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AhFPS8rS; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AhFPS8rS"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4359108fd24so2560783f8f.2
        for <linux-iio@vger.kernel.org>; Mon, 02 Feb 2026 01:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770026222; x=1770631022; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AFDYJ7q5ek+KQjUhD9TdsFNk97m/l5Paz0LDlGO6qOo=;
        b=AhFPS8rSkzQLsTOupJ+6H0meExyi1Bz1CHUpTwrBTmp8xc9ZCXfAB3XhMDsFHXBRyx
         7GXi9yOy1fVJryLASSDmr1BAwW27HZhgLvceQX9KQaE5blpqbfFDn9aJDitA0wAvT1ob
         2zcYadrwjl8xlofawGgQ/FIwbsCIvvl0JFef3gRq6w1u2rwt/9Zv+AYRYjbLLgrwnGbN
         RQ761QqXE8kMx6FMx54oh990Vw48Xpadhb4Ee4mO/3+lV3MfT8bqbtvIkJmzVkzd5LTg
         q6NJbkIVvYI7xFRq/AKRAYPDbUwaPsIfXIfmebtI60H72Ewn6Oi50Lk/0zyPjgHMn1Mw
         XLHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770026222; x=1770631022;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AFDYJ7q5ek+KQjUhD9TdsFNk97m/l5Paz0LDlGO6qOo=;
        b=bFEWs6Q7EB7xwsmf6EcyeY/bFqSdiq7nz1Ev32wg2V/Tl6V78mDemKcvBvMxNM/+5z
         dlPtBC6+l5LRl36xN8dBJHfs9i3jKWUmxm7puaNye2yezuZZEEgPAXMd2UOiCxKjDSA6
         EnXUpwUuZrJp5mw9d2Da/Dw0ci427PvEZ1JcG5d1zWL7MtSu9LEYAmUBeCc25HHOEgsV
         Pg4mUCkysvlpq5Ai393Pv6g5vmLNEpZOJ/QAr/eEPJMM7XwAytH/y3jnuWU2uV1r9E2V
         DoNH4wmqwURVfqOC1ntPDaN0K5WV95J2DnsKx63082gqLdV/8iQYZTqAS5Tz5Ecx5UgO
         SlpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDHL8OHjRCOech8NOrr/kLIA7bHTbl7MR/ufGW/38Q1eyV6AbhCBGlS/ZykvcxzbMeGSmQw7BHqwM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI+k3GPGITvauRQ5x1eAHVMWVtCdb0x/eGgUAeRm++2Pr6h/1I
	bfJ4wBQJfJBdk6dl+0MMoWS6eUpXD+WFNVDBsj9Y4qnfuHWMJILaqcRj
X-Gm-Gg: AZuq6aIoYZ0qhJEQPiOI04WvFlYmmk9YQKBoGGFTSGrsUuYuewpxj8LwSv4P+BlfwI7
	kIRV3QLG/e+cMa+uuMH/9YLpfJEwKSiPeHokfsIL0/9X29f6a6LJmHew8JAWW0H3FXFN7dBltMJ
	9DUqjFvEflMgPo8Nioxa8CE8R0raU4zpuOUIsYceXTKlOYGn2W7tnfqqaWfKOIG+lo3qxaNEzJu
	zOdfSi9rLjJE53NSG9RKfOYGKSq+QxvoUOMlkeX0+H0tFV2n8gvMM1smUDSRqdgglYKDMrqqYPb
	sv2TT5v03HtWiTwhP6/xezijNSy55VtRPyYS0GH7B/9pWtap0QQVrRM2IRyVMYx+C5YKgpuVAT+
	GFJT/bd0LUa1qK1xhfS6DmVnS0JD1lAW2yAdjhKLOaSjm9FTVr51LXmvwBL+VrERSz4yS18KmT2
	/nCQ6HaEORo9K4wKkubMg=
X-Received: by 2002:a05:6000:61e:b0:432:8504:8d5b with SMTP id ffacd0b85a97d-435f3abb458mr15482339f8f.50.1770026221918;
        Mon, 02 Feb 2026 01:57:01 -0800 (PST)
Received: from [192.168.1.187] ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10e483asm41024865f8f.3.2026.02.02.01.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 01:57:01 -0800 (PST)
Message-ID: <eb1d9b939f95888739ce4a70f516cec07393c6df.camel@gmail.com>
Subject: Re: [PATCH v6 2/8] iio: core: add fixed point parsing with 64-bit
 parts
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-doc@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>,  Andy Shevchenko	 <andy@kernel.org>, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich	
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>
Date: Mon, 02 Feb 2026 09:57:44 +0000
In-Reply-To: <20260130-adf41513-iio-driver-v6-2-cf46239026bc@analog.com>
References: <20260130-adf41513-iio-driver-v6-0-cf46239026bc@analog.com>
	 <20260130-adf41513-iio-driver-v6-2-cf46239026bc@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-01-30 at 10:06 +0000, Rodrigo Alencar via B4 Relay wrote:
> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
>=20
> Add iio_str_to_fixpoint64() function that leverages simple_strtoull()
> to parse numbers from a string.
> A helper function __iio_str_to_fixpoint64() replaces
> __iio_str_to_fixpoint() implementation, extending its usage for
> 64-bit fixed-point parsing.
>=20
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> ---
> =C2=A0drivers/iio/industrialio-core.c | 211 +++++++++++++++++++++++++++++=
+----------
> =C2=A0include/linux/iio/iio.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0=C2=A0 2 +
> =C2=A02 files changed, 163 insertions(+), 50 deletions(-)
>=20
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-c=
ore.c
> index 3115d59c1372..37e9ed6b659b 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -21,6 +21,7 @@
> =C2=A0#include <linux/kernel.h>
> =C2=A0#include <linux/module.h>
> =C2=A0#include <linux/mutex.h>
> +#include <linux/overflow.h>
> =C2=A0#include <linux/poll.h>
> =C2=A0#include <linux/property.h>
> =C2=A0#include <linux/sched.h>
> @@ -881,6 +882,136 @@ static ssize_t iio_read_channel_info_avail(struct d=
evice *dev,
> =C2=A0	}
> =C2=A0}
> =C2=A0
> +/**
> + * iio_safe_strntou64() - Parse u64 from string checking for overflow sa=
fety
> + * @str: The string to parse
> + * @endp: output pointer to the end parsing position
> + * @result: parsed value
> + * @max_chars: maximum number of digit characters to read
> + *
> + * This function is used in fixed-point parsing and it iterates over a c=
onst
> + * char array. It might duplicate behavior of simple_strtoull() or kstrt=
oull(),
> + * but those have their own limitations:
> + * - simple_strtoull() is not overflow-safe and its usage is discouraged=
;
> + * - kstrtoull() is safe, but requires termination and it would required=
 a copy
> + *=C2=A0=C2=A0 of the string to a temporary buffer.
> + *
> + * The implementation of this function is similar to _parse_integer_limi=
t()
> + * available in lib/kstrtox.h, but that header/function is not available=
 to be
> + * used in kernel modules. Hence, this implementation may need to change=
 or
> + * removed to reuse a new suitable helper that is properly exposed.
> + *
> + * Returns:
> + * number of parsed characters on success, -ERANGE on overflow
> + */
> +static ssize_t iio_safe_strntou64(const char *str, const char **endp,
> +				=C2=A0 u64 *result, size_t max_chars)
> +{
> +	u64 digit, acc =3D 0;
> +	ssize_t idx =3D 0;
> +
> +	while (isdigit(str[idx]) && idx < max_chars) {
> +		digit =3D str[idx] - '0';
> +		if (unlikely(acc & (~0ull << 60))) {
> +			if (check_mul_overflow(acc, 10, &acc) ||
> +			=C2=A0=C2=A0=C2=A0 check_add_overflow(acc, digit, &acc))
> +				return -ERANGE;
> +		} else {
> +			acc =3D acc * 10 + digit;
> +		}
> +		idx++;
> +	}
> +
> +	*endp =3D str + idx;
> +	*result =3D acc;
> +	return idx;
> +}
> +
> +/**
> + * __iio_str_to_fixpoint64() - Parse a fixed-point number from a string
> + * @str: The string to parse
> + * @fract_mult: Multiplier for the first decimal place, should be a powe=
r of 10
> + * @integer: The integer part of the number
> + * @fract: The fractional part of the number
> + * @scale_db: True if this should parse as dB
> + *
> + * This variant uses 64-bit integers for both integer and fractional par=
ts.
> + * Parsed positive values greater than S64_MAX are returned as-is. Parse=
d
> + * negative values less than S64_MIN are treated as range error, so -ERA=
NGE is
> + * returned.
> + *
> + * Returns:
> + * 0 on success, or a negative error code if the string could not be par=
sed.
> + */
> +static int __iio_str_to_fixpoint64(const char *str, u64 fract_mult,
> +				=C2=A0=C2=A0 s64 *integer, s64 *fract, bool scale_db)
> +{
> +	u64 i =3D 0, f =3D 0;
> +	int ret, precision =3D ffs(fract_mult);
> +	bool negative =3D false;
> +
> +	if (precision > 20) /* ceil(log10(U64_MAX)) =3D 20 */
> +		return -EINVAL;
> +
> +	if (str[0] =3D=3D '-') {
> +		negative =3D true;
> +		str++;
> +	} else if (str[0] =3D=3D '+') {
> +		str++;
> +	}
> +
> +	ret =3D iio_safe_strntou64(str, &str, &i, SIZE_MAX);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (precision && *str =3D=3D '.') {
> +		str++; /* skip decimal point */
> +		ret =3D iio_safe_strntou64(str, &str, &f, precision);
> +		if (ret < 0)
> +			return ret;
> +
> +		if (ret < precision) /* scale up */
> +			f *=3D int_pow(10, precision - ret);
> +
> +		while (isdigit(*str)) /* truncate: ignore further digits */
> +			str++;
> +	}
> +
> +	if (!ret)
> +		return -EINVAL;
> +
> +	if (scale_db) {
> +		/* Ignore the dB suffix */
> +		if (!strncmp(str, " dB", sizeof(" dB") - 1))
> +			str +=3D sizeof(" dB") - 1;
> +		else if (!strncmp(str, "dB", sizeof("dB") - 1))
> +			str +=3D sizeof("dB") - 1;
> +	}
> +
> +	if (*str =3D=3D '\n')
> +		str++;
> +
> +	if (*str !=3D '\0')
> +		return -EINVAL;
> +
> +	if (negative) {
> +		if (i) {
> +			if (i > (u64)S64_MIN)
> +				return -ERANGE;
> +			i =3D -i;
> +		} else {
> +			if (f > (u64)S64_MIN)
> +				return -ERANGE;
> +			f =3D -f;
> +		}
> +	}
> +
> +	*integer =3D i;
> +	*fract =3D f;
> +
> +	return 0;
> +}
> +
> =C2=A0/**
> =C2=A0 * __iio_str_to_fixpoint() - Parse a fixed-point number from a stri=
ng
> =C2=A0 * @str: The string to parse
> @@ -895,63 +1026,43 @@ static ssize_t iio_read_channel_info_avail(struct =
device *dev,
> =C2=A0static int __iio_str_to_fixpoint(const char *str, int fract_mult,
> =C2=A0				 int *integer, int *fract, bool scale_db)
> =C2=A0{
> -	int i =3D 0, f =3D 0;
> -	bool integer_part =3D true, negative =3D false;
> +	s64 integer64, fract64;
> +	int ret;
> =C2=A0
> -	if (fract_mult =3D=3D 0) {
> -		*fract =3D 0;
> +	ret =3D __iio_str_to_fixpoint64(str, fract_mult, &integer64, &fract64,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 scale_db);
> +	if (ret)
> +		return ret;

I know it feels tempting to do the above while adding the 64bit variant. Bu=
t isn't the
overflow safety also an issue on the 32bit variant? IMO, we should first ha=
ve a patch
adding the overflow safety with a Fixes tag and then add 64bit support.

=20
> =C2=A0
> -		return kstrtoint(str, 0, integer);
> -	}
> +	if (integer64 < INT_MIN || integer64 > UINT_MAX ||
> +	=C2=A0=C2=A0=C2=A0 fract64 < INT_MIN || fract64 > UINT_MAX)
> +		return -ERANGE;
> =C2=A0
> -	if (str[0] =3D=3D '-') {
> -		negative =3D true;
> -		str++;
> -	} else if (str[0] =3D=3D '+') {
> -		str++;
> -	}
> -
> -	while (*str) {
> -		if ('0' <=3D *str && *str <=3D '9') {
> -			if (integer_part) {
> -				i =3D i * 10 + *str - '0';
> -			} else {
> -				f +=3D fract_mult * (*str - '0');
> -				fract_mult /=3D 10;
> -			}
> -		} else if (*str =3D=3D '\n') {
> -			if (*(str + 1) =3D=3D '\0')
> -				break;
> -			return -EINVAL;
> -		} else if (!strncmp(str, " dB", sizeof(" dB") - 1) && scale_db) {
> -			/* Ignore the dB suffix */
> -			str +=3D sizeof(" dB") - 1;
> -			continue;
> -		} else if (!strncmp(str, "dB", sizeof("dB") - 1) && scale_db) {
> -			/* Ignore the dB suffix */
> -			str +=3D sizeof("dB") - 1;
> -			continue;
> -		} else if (*str =3D=3D '.' && integer_part) {
> -			integer_part =3D false;
> -		} else {
> -			return -EINVAL;
> -		}
> -		str++;
> -	}
> -
> -	if (negative) {
> -		if (i)
> -			i =3D -i;
> -		else
> -			f =3D -f;
> -	}
> -
> -	*integer =3D i;
> -	*fract =3D f;
> +	*integer =3D integer64;
> +	*fract =3D fract64;

Hmmm, aren't we truncating the values? They are still int pointers...

- Nuno S=C3=A1

