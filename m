Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA7134750E
	for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 12:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779020388; cv=none; b=Xx+yYo62uraeQTeiCIltQQSi+yNUcMros2eq9j2QYVLVxemd/Jq1fKL/vNht4JtRnhXn50gScm2VBhqNwgdxs9uRDoJEaHk7vBOo+zcqyXc75tOXze8Pf8TzfLn6EzDlghuoqB0PBKBFkdUPMDE+if0jUKZMj8PhKTk7dpyOVto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779020388; c=relaxed/simple;
	bh=4ORFF+hqy++5JiE4nhagBY/ZLP3fzcu7areLbccw1mE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jXrTnNgN86UbV4BdDSmW8OnCcfCQUohnzX578Et5858NxdxwupqwH2CogkUH5Lyx8zrqEGQjJ+NAtGvbtl0nlFJxnVcZpndqkYrN0nAc8aPSgh98YFkZkBpl3qOUPqhLw1MtYGj+mSzdC/AaHAoliy6j+7ruWZLSUm3LLBua08w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CzU00kr1; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CzU00kr1"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488ab2db91aso13567525e9.3
        for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 05:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779020385; x=1779625185; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h1PMPeBjbxQbz6gz4zIfXl+IxRIZnCvMJpkmx9O6DI4=;
        b=CzU00kr192XRukF0XOn//ebLoA822sba79VWZX/ZgKEI9BM5lrOsl/kPNDAcEQg2qG
         jHrxUkSY3k1wD6yf49ki7EhuKnb4q2WETSvmBuyH1hZucWB/bscfOS0k4TFEJlqGHfB8
         HbKu4MCYtJNogH8iRs1FNzVgAtWEp5z9dLGVt0YioFZEAS6a4MlIj39oVWBc7igR1Ers
         4CnyEs+5vctuaFL2ima+ks/tahmyi6MJRA+RqefjW2ix8HKrAaEIyIpZY/d00HbzzERn
         xJHYhYHEM8IkMaCZFXG5iKGVbizlPJ11na4mZLfwEfBjxYND4SeOn//vGJjGGATPUytC
         0+jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779020385; x=1779625185;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h1PMPeBjbxQbz6gz4zIfXl+IxRIZnCvMJpkmx9O6DI4=;
        b=coPUUIdP3bLZ25p7sLATbAt/kMD47RPMwTp5tRStaeLp7xaVAyjjduJt8eOJ5CZh74
         9Ygo0qE1W7OgcQTbx77+n2f2uq1ckB2oTDVWhrgh3OwWt5fw6kYJQNpOsnWEoZNg8q7d
         i+X3yFRb/4kr9TGSYk08ITp+xXyzJid5JOC6OM5ge2xvgVVymvw1RtkUguGlF9yw7shp
         zeFNQagqbFv0XGU7MXkeb4Fi9WJcm+gFNyEAoV7BVIyXm/eTdTkOkJ0nKv1ngD4RrEel
         SOEVLbJSyMVl+EgUzlE6GE56+tqlczCqPtbLtpvVX+u2xnnKhaWQpMPFvg/VDWPZNgCx
         MKNQ==
X-Forwarded-Encrypted: i=1; AFNElJ+VA5Bny3TS1hC5hOh5jW9HPRLdg+a+Ul/+1eVWOYmS5MRNyGGiNBTdjx1Z3n3O7XZPfpRJfo8Wqc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA0eCyGdoRVIxCyTv9XVbp00llyWEt+MKXd5sm2ujUT3IaLX8h
	CxRwiyjMoeQhT+1VQCdv34UVeIfp/XvL9ol5GxZeCM/Nsd/QAkxfTEmA
X-Gm-Gg: Acq92OFspMUMDefXGewaFbaqxBieZtuwFTkM7Ym4iFMC6rKiy3OkQ1esn4RXkQpjFr8
	pmPS9RVPz8y4zXazcsaAPqUmoi2DIntWI8dyEbmDrmN+FUPJVllqtR+Uu+rnndPWHVySH8Xx8FX
	cpf3Wi8A+bSLPwxUAdntFjHamCAQqe49eMnKG+AzajxH+jLgkK3dBQ3JUVuUjWyJ3TRGQX0yHYR
	n+NqrxM6nIdlSkIoKB1myqc+WTsZJG4jNBB2zItxeJBoPgRqmPaMkct/yJawj/V8iEcAHFqqlm2
	7yV9K26kq/INctyEmmmAK3GgLCdpV++3d2NUlecVxLxeA9zMEwFczuatpuiDiC4O2GVBOUQGy98
	xuSXPSw0x5THVM85NvtmU2h0VuCpiuN/zZa+Y9dF/RrQxTy/Ahq2FhiQZqEwmU2/X7tYiJWILRk
	CC8hFI8LNSi7PO1X8xDRnTvSKYTvkV3vl17dbzM4wk7p/QcM9tx6EgzelBtAvQ6FG7OXSK4mSpn
	fK0rmpvILxgQ3zb+Dz33G2On3hCcaYuy94MaZvJUCZ6wHZV6w==
X-Received: by 2002:a05:6000:2c07:b0:45e:75c5:1a6a with SMTP id ffacd0b85a97d-45e75c51b5emr2297637f8f.33.1779020384879;
        Sun, 17 May 2026 05:19:44 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.103.netskope-rdns.com. [24.206.116.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0a1aeafsm30436836f8f.23.2026.05.17.05.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 05:19:44 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Sun, 17 May 2026 13:19:38 +0100
To: rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v13 02/12] iio: kstrtox: add local
 _parse_integer_limit_init() helper
Message-ID: <u6uqytictupj7kgaxadxmvuayc66cpfw2g4k4ebvdmtgpjqdfz@zlnl3arq73xn>
References: <20260517-adf41513-iio-driver-v13-0-bb6e134a360f@analog.com>
 <20260517-adf41513-iio-driver-v13-2-bb6e134a360f@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260517-adf41513-iio-driver-v13-2-bb6e134a360f@analog.com>

On 26/05/17 10:13AM, Rodrigo Alencar via B4 Relay wrote:
> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Add parsing helper that accepts an initial value for the accumulated
> result when parsing an 64-bit integer. It reuses current implementation
> for _parse_integer_limit(), which now consumes the new function with
> init = 0. The diff algorithm would have the documentation header and
> prototype of _parse_integer_limit() moved around so it is adjusted
> according to guidelines.

Sashiko's feedback at:
https://sashiko.dev/#/patchset/20260517-adf41513-iio-driver-v13-0-bb6e134a360f%40analog.com?part=2

...

> -/*
> - * Convert non-negative integer string representation in explicitly given radix
> - * to an integer. A maximum of max_chars characters will be converted.
> - *
> - * Return number of characters consumed maybe or-ed with overflow bit.
> - * If overflow occurs, result integer (incorrect) is still returned.
> - *
> - * Don't you dare use this function.
> - */
> -noinline
> -unsigned int _parse_integer_limit(const char *s, unsigned int base, unsigned long long *p,
> -				  size_t max_chars)

...

> +/**
> + * _parse_integer_limit() - Convert integer string representation to an integer
> + *			    limiting the number of characters parsed.
> + * @s: The start of the string.
> + * @base: The number base to use.
> + * @p: Where to write the result of the conversion.
> + * @max_chars: Maximum amount of characters to consume.
> + *
> + * Convert non-negative integer string representation in explicitly given radix
> + * to an integer. A maximum of max_chars characters will be converted.
> + *
> + * Return: Number of characters consumed maybe or-ed with overflow bit.
> + *	   If overflow occurs, result integer (incorrect) is still returned.
> + */
> +noinline
> +unsigned int _parse_integer_limit(const char *s, unsigned int base,
> +				  unsigned long long *p, size_t max_chars)

	Is it safe to remove the "Don't you dare use this function." warning?
	Since this function returns the number of consumed characters bitwise-ORed with
	the KSTRTOX_OVERFLOW flag, turning the comment into standard kernel-doc format
	makes it look like an inviting API.
	If a developer uses this and directly advances a pointer by the return value
	without masking the overflow bit, could an integer overflow during parsing cause
	the pointer to jump out-of-bounds?

That return value merged with the overflow indication is a bit weird in the first
place. I wonder if we need a precursor patch cleaning _parse_integer_limit() and
removing this KSTRTOX_OVERFLOW completely... turning it into:

	ssize_t _parse_integer_limit(const char *s,
				     const char **endp,
				     unsigned int base,
				     unsigned long long *res,
				     size_t max_chars);

so ssize_t returns the amount of converted characters, or -ERANGE if overflow occurs.
Also endp would point to the end of the conversion, so current usage (in _kstrtoull())

	rv = _parse_integer(s, base, &_res);
	if (rv & KSTRTOX_OVERFLOW)
		return -ERANGE;
	if (rv == 0)
		return -EINVAL;
	s += rv;

would become:

	ret = _parse_integer(s, &s, base, &_res);
	if (ret < 0)
		return ret;
	if (!ret)
		return -EINVAL;

which seems more aligned to the code we see out there.

-- 
Kind regards,

Rodrigo Alencar
