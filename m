Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2413A5E70
	for <linux-iio@vger.kernel.org>; Mon,  4 May 2026 10:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777891370; cv=none; b=F+8xr8Qd9s43GeE1ZRcA0kNY/5tJcQuD5yCr4ATHXn0WN0renmnBFFQJnX5wUNDJDr5o3aKMGi0ID4yJYUzrcYknJhAbxA3hrMe0QM5nc/MPUlSw3LTlgKJySzk3cESiegI9T+nhORqG6N0wkKIAcQ4pc7edk3FBxNwvMvBtJNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777891370; c=relaxed/simple;
	bh=O+TCmQ94hvpfpTfj1UNiv4DI2N+SEeVnVz0y/FMSn4U=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iUXYNxnq7ZTAV1c4r4NIMy/yDH6t/Ur1+kNFiDRM+/VJwD2s5rW+7LB4PUdVdKJjh0XQ6n0ccyyaM2bvNqFF9rFknTH5POajZasHBXQfg9QnvhyQZU6f9bvsLjMukqnvfm/k5kKCBG/3VbygbauF/jBxk7ewwPk+Zl1Ef9aSAd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bBhTaJiB; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bBhTaJiB"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-488e1a8ac40so37583825e9.2
        for <linux-iio@vger.kernel.org>; Mon, 04 May 2026 03:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777891367; x=1778496167; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=glBEbPzQqS5RuxVbjECm23lF7bGWaZdBFdJ4PJmnbu0=;
        b=bBhTaJiBtOF9PvxWRhwEvp+jWWYyQjfRq1ATLJJHVGDrPDbtFk5jcGeGofeN8HuJ7m
         b2KQpo+NdOQf//jTah/eq/Dgicyvs8/3c4gm5Y6FhaplYgh0HRuXjzz+/sfO9B9CDX7M
         Kiu3DqUgYu1HLyOHMnCNPwdP78XwVoS3TefJtemt5P46mDqIGI0KwLlKf2XJbIXCBAtB
         9EYL19u+pVFwZbuX7tKxWm8ns7Pyh/MRkDfZ61q9QxLFx6hoavcuylGn/6BjC3jOfiZl
         epI4vsZU2p92DlA0tnDyyY/+wdUrNMhwYtjRky2Tf0x616kbVu5jLMYfwBBHBJgVCc5S
         nK1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777891367; x=1778496167;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=glBEbPzQqS5RuxVbjECm23lF7bGWaZdBFdJ4PJmnbu0=;
        b=sxFFTdnbsccZRC4P97qwYwPM5svch6Enr1/QmBZCdaMXeywHpTbzV0nnf16zj5HdLK
         xNa6IRR4I4jkeg6nLy8Rgb5mPl/A0E/ujQ3J1Gz9ye+k9LsSgQM6dIb27YQjXGdeVRLu
         SvA8h/5dTSvu4C3taQKOzuJB+74sBTVEy5i/mMC3WQmaZW6bPS8fJPUN+3QEadBsNiqY
         8QiLtQZ/oUlKVQqifNhWLQ8LJalXz7oUNVboFVDJq+xmPpbO9l4heRmCndMO+6qCTCqh
         zG7YC36QEC4udk40YntTPNjZsEJ5giUZFC71VG1dn8brBmPJY34FzGzNiZVGnAOF+6Mp
         9FiQ==
X-Forwarded-Encrypted: i=1; AFNElJ/YvLajcDy3vb4AIXitJm6uivs1IrXEovb9IvVBxfZJSPijkfHG9ylJ8RkjHDeXuXD38jseSblUsBg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8zs91Hi9A9bGUQ1my3OtmYp5PVZ0/wwvKhI0xT93jIEldt74A
	y7CP0h7CJWRospLWb9sfyD9kRL34ET1uLFXt+3R8xtBDzeeEkvV6zklv
X-Gm-Gg: AeBDiet2h8Kh2O9wepL+/5nicMzIyEcaqU1WVJaZolOLTFuhVX3t0tUOG7S2auqlFiD
	jFuXSbix9V5dNga7eifEA1Q0RE72vfu90GtPpqubbSRiuygspA0npHnA1UyDpCNLe2UN2Q1343D
	SNXzSjtyt5u4ZzJ+I5un0oVPiJiug9dU6ESWnMKg30CIJffR/TNkSaxnLqWVKJjoeTh2p/eBK+P
	9lPuRAFw1fE05uKt5IpWfhfrw8vFUTT8RQ89EhkkVCQbp9yZj4s6Js6nS1WsPJOZuTGuyP6KiRp
	jbSt7AJh1sNzf9haXYvJMSNHbnZ8AikBo43g76k/0u9sbQG7gQMH4Qpm6jrSJfYsEfWV26A72u7
	5UGL2CZ4/+jqO+NiM6SnFlBbQkjYvGl5dLiMC7XHCWJxjgJCdU4wrHfUqp1evNqj6QO/31SRckQ
	F2RMqZaswNvmiajpWdf1X2mAro86UZVN/BkdSbFV6bUmD9tTQezQgrm4bKciNBuQ6/puB8pEGdz
	H+lLzW1HcN1gOU7rYevLVkVRo/cvAqTFuTzQWaOlU6cJQWeOVaAqSWN36k2IA==
X-Received: by 2002:a05:6000:25c7:b0:43c:f66e:f24 with SMTP id ffacd0b85a97d-44bb6d96a1emr15514078f8f.35.1777891366752;
        Mon, 04 May 2026 03:42:46 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.103.netskope-rdns.com. [24.206.116.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44a9879ef89sm28731094f8f.30.2026.05.04.03.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 03:42:46 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Mon, 4 May 2026 11:42:38 +0100
To: Rodrigo Alencar <rodrigo.alencar@analog.com>, 
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-doc@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v10 05/11] iio: core: add decimal value formatting into
 64-bit value
Message-ID: <keeskqikjulxcgc36zpzzvqw2osvm437hlchgcuovh5gkvmdr3@ishisbiujrrn>
References: <20260415-adf41513-iio-driver-v10-0-df61046d5457@analog.com>
 <20260415-adf41513-iio-driver-v10-5-df61046d5457@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415-adf41513-iio-driver-v10-5-df61046d5457@analog.com>

On 26/04/15 10:51AM, Rodrigo Alencar wrote:
> Create new format types for iio values (IIO_VAL_DECIMAL64_*), which
> defines the representation of fixed decimal point values into a single
> 64-bit number. This new format increases the range of represented values,
> allowing for integer parts greater than 2^32, as bits are not "wasted"
> in the fractional part, which can be seen in IIO_VAL_INT_PLUS_MICRO and
> IIO_VAL_INT_PLUS_NANO. Helper macros are created to compose and decompose
> 64-bit decimals into integer values used in IIO formatting interfaces,
> which creates consistency and avoid error-prone manual assignments when
> using wordpart macros. When doing the parsing, kstrtodec64() is used with
> the scale defined by the specific decimal format type.
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>

...

> --- a/include/linux/iio/types.h
> +++ b/include/linux/iio/types.h
> @@ -7,6 +7,7 @@
>  #ifndef _IIO_TYPES_H_
>  #define _IIO_TYPES_H_
>  
> +#include <linux/wordpart.h>
>  #include <uapi/linux/iio/types.h>
>  
>  enum iio_event_info {
> @@ -34,6 +35,38 @@ enum iio_event_info {
>  #define IIO_VAL_FRACTIONAL_LOG2 11
>  #define IIO_VAL_CHAR 12
>  
> +#define IIO_VAL_DECIMAL64_BASE		100
> +#define IIO_VAL_DECIMAL64_MILLI		(IIO_VAL_DECIMAL64_BASE + 3)
> +#define IIO_VAL_DECIMAL64_MICRO		(IIO_VAL_DECIMAL64_BASE + 6)
> +#define IIO_VAL_DECIMAL64_NANO		(IIO_VAL_DECIMAL64_BASE + 9)
> +#define IIO_VAL_DECIMAL64_PICO		(IIO_VAL_DECIMAL64_BASE + 12)
> +
> +#define iio_val_s64_compose(_val0, _val1)				\
> +	({ (s64)((((u64)(_val1)) << 32) | (u32)(_val0)); })
> +
> +#define iio_val_s64_from_array(_vals)					\
> +	({								\
> +		const int *_arr = (const int *)(_vals);			\
> +		s64 _dec64 = iio_val_s64_compose(_arr[0], _arr[1]);	\
> +									\
> +		_dec64;							\
> +	})
> +
> +#define iio_val_s64_decompose(_dec64, _val0, _val1)			\
> +	do {								\
> +		s64 _tmp64 = (s64)(_dec64);				\
> +									\
> +		*(_val0) = lower_32_bits(_tmp64);			\
> +		*(_val1) = upper_32_bits(_tmp64);			\
> +	} while (0)
> +
> +#define iio_val_s64_array_populate(_dec64, _vals)			\
> +	do {								\
> +		int *_arr = (int *)(_vals);				\
> +									\
> +		iio_val_s64_decompose((_dec64), &_arr[0], &_arr[1]);	\
> +	} while (0)

Hi Jonathan,

Are those macros ok? in terms of where they are declared or whether they
should be static inline functions? any preferences?

> +
>  enum iio_available_type {
>  	IIO_AVAIL_LIST,
>  	IIO_AVAIL_RANGE,
> 
> -- 
> 2.43.0
> 

-- 
Kind regards,

Rodrigo Alencar
