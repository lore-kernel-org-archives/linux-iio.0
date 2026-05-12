Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901CA33F598
	for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 19:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778612485; cv=none; b=IOOl8kW1Y5c9aPkM9b8c1XzQ9FB3vuwBIajfDS5ChnN9v/k/W14VEsIE1RQU5OMtm9973lEWUWLBys/bA9vMblWNnJw0yPtBvYBaZ3MpQVyNYWiYvlrdkF+nc1hySvZAQSK7WJUDkgQkTPreul0/opg08J0dK7gtTcTRn4DbDQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778612485; c=relaxed/simple;
	bh=SeD74GBi/WomNdZYaNJemftdaB+eK35ZhAEI9YJm9K4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LUsYvXAy3ZDyZzuF8ldwSAMYCjKq/GRs44c2DL9NAzgIEt/fNRx7eCU9bi1jnBXD6yfVpSsRiJUYP9csib9arQZFJqyqewih06GqQPeUoVEJP1cKx8mjBK0fXFp7WMqwdgGEKBEaOh6VSbg1fezl9XSMRRSaL4E8goYkb0WQ/MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m72a46az; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m72a46az"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488af9fdaa7so33867335e9.1
        for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 12:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778612482; x=1779217282; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JfVrzDr86zATEwD1OuodPd4t6Fj18Y970qlap5qDmRM=;
        b=m72a46azprArlIiQaehve9LLM/bCBXAENf2OiFcAC7x7juTLUxIudkYCYs1z1+d+WA
         K7WTmZSc3BWFpTGzqk5pBLB+yt/U7/ztVeCxAnN5RZIpl1WbD0qx29KvgAeb5/WTOFyM
         4tNZHY4xIk39z1SQiGYUwCzAR0lYyCG7wxbfWRDvQOQzZXJiQC8vCI5kov8NndsWZuI5
         MC0lBywBq19Yv9SDm83fb+8jQ4x+G8ZTwWvilfHDziJpG5Frg6frmticLdAK6177eZgC
         oFkmGUBev6+HnKFEovWML5dC8SMO2qHX1UITg4jkOfRl9eOF5eaYdA3vGJZsn8LH2BVt
         ksEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778612482; x=1779217282;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JfVrzDr86zATEwD1OuodPd4t6Fj18Y970qlap5qDmRM=;
        b=KmlqMgUTianGeuPOfpGPQc9cAkRlNWcmkmZZJBgPgqaSiAOZRfS8gAWopoBxM1rxgu
         AlAa3+KITw5xlWZQfhHkY8u3aH2ipFaGe78dYpSa0CczVCSFWak47J4rnahpfqLNpo+y
         G8zqdKs+K6+Dj4R7jtZwF/rj4z8wJDJT54UWCpKms8wToCCuSa7Bj6iCpnw6X0YmAkPr
         BNtCbupYdepBT06FhZIM0dXB7yf+tlWpJRnWvg4qoSgWEpinyXjq9XLDKovHMeUthvQR
         x1eWk3lE/24BnswYEBVeAyaBhSK0T5eDT6GYBJU+wfuB5VlrWx9ivJlGGGo3xGy8GNhE
         Qk+g==
X-Forwarded-Encrypted: i=1; AFNElJ8x3BMKjEmhtXbkQhzgAzxxqohkBSv+U7/G6BnCcDHJgXMUBBBf+C5lTHJ0dJ/gtFWOZhAN9Q8dcZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUiAXLRG+RxLSmWkpUrDMjLD9eQznomPEgbFymVT/aOoeK+3gG
	FYXZo8P96WkiiYozr3rw+VBtSEy8jR6kxNOeQhoOs13jayWhtKnjTA0W
X-Gm-Gg: Acq92OGFd2UAwzTLewVjZvaHloDTacarryMuiwk2t0nOixXTWz9LiGPUxTIiUWcYWVV
	Aw8jtKwcnp2KZOFIxJc9Fe0531g0Cs8oYRLwIAXyJ1oBn+9AjlvCFhXJlUMul8BGCYgrSDhOKRt
	AXJUVfOBLjKmub6m+dULqtIne1gFgl04zQjF6EN4YMmx0SUW7F7XM3FgLWge9K82XFFd+FYsghE
	F+jG23raX7HZOVZ2AfCHaA1xgywlrO++y1hd1HJCt2D3n8Cz4DKLLZ0yLN76hNFh/xBCUYBair4
	FzXcwnYNIGy1VEPxxDRDpdB5mrLfLakeR2ytABVE7cQ8RSJNC3YRFF4YsQa6kfTu8v4EDnUqOpU
	2HR24hmthU0aqHj154MM4n/f7yPZXWr5K6SFYa/KnLOwBhSxzRzlSa1sbiJ0Gv1fi11Oxa3OkJ4
	GsDTU+2f0z/Ax5lRj9LUuNngiHNrp+v7WOipbQeHdEZNo2iwKCSIffALGdKvzc9KVwEfB5BE9rm
	NVRO6x5n1KF+LlJY2jLfCEy2UVjZWWb5/FLnhuLwEvnYGowHQ==
X-Received: by 2002:a05:600c:8b56:b0:48a:599a:3716 with SMTP id 5b1f17b1804b1-48fc9a45891mr1464025e9.23.1778612481673;
        Tue, 12 May 2026 12:01:21 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.131.netskope-rdns.com. [24.206.116.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fc8d1b100sm17867995e9.4.2026.05.12.12.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 12:01:21 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Tue, 12 May 2026 20:01:14 +0100
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>, 
	Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v12 05/11] iio: core: add decimal value formatting into
 64-bit value
Message-ID: <b6wjjzv7wpyv3cpgftltu7sppttmrvrqxcs5b4gre5d7goknqd@vlhenvjct6la>
References: <20260510-adf41513-iio-driver-v12-0-34af2ed2779f@analog.com>
 <20260510-adf41513-iio-driver-v12-5-34af2ed2779f@analog.com>
 <agM6uzhdn7o8g9v5@ashevche-desk.local>
 <ql7smsqza7liupm7fhdts73cxsltrpxsqofu5ovzpxpwvcscuv@qigi3dwukk7k>
 <agNoKbcwT6_spC93@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agNoKbcwT6_spC93@ashevche-desk.local>

On 26/05/12 08:49PM, Andy Shevchenko wrote:
> On Tue, May 12, 2026 at 05:09:32PM +0100, Rodrigo Alencar wrote:
> > On 26/05/12 05:35PM, Andy Shevchenko wrote:
> > > On Sun, May 10, 2026 at 01:42:23PM +0100, Rodrigo Alencar via B4 Relay wrote:
> > > 
> > > > Create new format types for iio values (IIO_VAL_DECIMAL64_*), which
> > > > defines the representation of fixed decimal point values into a single
> > > > 64-bit number. This new format increases the range of represented values,
> > > > allowing for integer parts greater than 2^32, as bits are not "wasted"
> > > > in the fractional part, which can be seen in IIO_VAL_INT_PLUS_MICRO and
> > > > IIO_VAL_INT_PLUS_NANO. Helpers are created to compose and decompose 64-bit
> > > > decimals into integer values used in IIO formatting interfaces, which
> > > > creates consistency and avoid error-prone manual assignments when using
> > > > wordpart macros. When doing the parsing, kstrtodec64() is used with the
> > > > scale defined by the specific decimal format type.
> 
> ...
> 
> > > > +		tmp2 = div64_s64_rem(iio_val_s64_from_array(vals),
> > > > +				     int_pow(10, scale), &frac);
> > > > +		if (tmp2 == 0 && frac < 0)
> > > > +			return sysfs_emit_at(buf, offset, "-0.%0*lld", scale,
> > > > +					     abs(frac));
> > > > +		else
> > > > +			return sysfs_emit_at(buf, offset, "%lld.%0*lld", tmp2,
> > > > +					     scale, abs(frac));
> > > > +	}
> > > 
> > > What about
> > > 
> > > 		/* Print a leading '-' for negative fractions */
> > > 		if (tmp2 == 0 && frac < 0)
> > > 			offset += sysfs_emit_at(buf, offset, "-");
> > > 
> > > 		return sysfs_emit_at(buf, offset, "%lld.%0*lld", tmp2, scale, abs(frac));
> > > 
> > > Also note this won't work with the frac that are == S64_MIN. It's UB (undefined
> > > behaviour), see the comment at abs() implementation. Maybe a time to add abs()
> > > corner case tests...
> > 
> > frac cannot be S64_MIN, it is always and remainder of a power of 10 modulus.
> 
> Okay, but what about input of -0.9999999999999999999 ? Will it fit the signed
> frac type?

For the scales considered here it would not be a problem (*_PICO = 12 + *_BASE).
For the max scale of 19 it would probably fail the parsing of the fractional part
with overflow.
 
-- 
Kind regards,

Rodrigo Alencar
