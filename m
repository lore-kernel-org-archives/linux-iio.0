Received: from mail-dl2-f40.google.com (mail-dl2-f40.google.com [74.125.229.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DB0429825
	for <linux-iio@vger.kernel.org>; Fri,  2 Oct 2026 09:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790933305; cv=none; b=MF5fr6IPXONHbqe9ECrMsaeSeXMaMUUOsjUpKCgIKSBAY/20gWiaCEQLPv+ogw67dLmW0vvoyQx0L/3S9YQYmrPi4l1qBc8kVKAbu635oYhaTmBV8oMRo2vBluH0U9PLqpOar9+zBP2tEv6VXz+egB5njrxk3u82l1pf+9ufyKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790933305; c=relaxed/simple;
	bh=tsuaYRXNLmb551fr7i7sn+dPJ7NhzMn88WF918CGBx0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KjhsxcUfnDh14kV2iJm3s6gi3KRWRBYxkCD1wqS3Sm8fUiD9hgCmtLZ1NpLKMne67RXYXugXr2lD/OQIcr+G5b+IyvnKAOLwUYioGidluONudeUN9ilqGAZQRun776Zv99dTGv9cDVJGyX4jat9KluR6l2JKQtE4f5KjeCcLtQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ihoNZOiV; arc=none smtp.client-ip=74.125.229.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ihoNZOiV"
Received: by mail-dl2-f40.google.com with SMTP id a92af1059eb24-1515575ead6so6234c88.3
        for <linux-iio@vger.kernel.org>; Fri, 02 Oct 2026 02:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790933303; x=1791538103; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Dzk0FhsAtQa7VZB+Dgj776CLsrZWObscUvWBIN8rkJU=;
        b=ihoNZOiVDx3d+A6En85M7MD+JSmVnKZHeaiwYR3OXrbN6TfUD/3JAFardg/4PBsqzL
         R5Jmgz9Zgt7Q5UAATd2ZlHIs2VYrTJEgpIdYqHEQo2FogSth6TECdHESCVZZpn04so3R
         YoLF5hOqG+UgRvFSc8byPg0oGrgIh4SUmwkaZmgtEjFH1sHeqPe0uCmRBjrroCdn+qUJ
         BTscBicWDESpQ51zKle+xAowgSY1ywPNw1rrXydkMwneUQ6zr6tiGqz1PWy79QqOG4Yk
         8WjI4I/t6WP3yBUQs5jzG6yyqv93efatFsQKRvZtX+oKTA3mWuf/ayBMO1iOsRPck/XU
         dJ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790933303; x=1791538103;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dzk0FhsAtQa7VZB+Dgj776CLsrZWObscUvWBIN8rkJU=;
        b=lmihOHRXK3dr5EEkPEa7Dw7bXQT8PTK6IG3oqwfEZ0L/CF6v9hg5uOtGfQtC4/wBcI
         8L9VlCaCk8WUMFsOOdDoFchmveRzLpPulVOB3hYW+ElxlVkSEUWiwcSrLh6ECcZ7vYdZ
         IN6sRutFJMW58wXnu/b4hY7ZK09eaYrQb+5r3M8mzWcRAhOnM9pdw7bvfY+M8UQdR/Bc
         w9HuOtKE4w0WI+qz+8DgJVKcWy1AtvaCVoZJnjYHk5p6MAGOCSRcWY4mXo4c94MfJlpB
         Xfu4k2EFVHlJPkBGCaeG+FqyP6SEPrthbOOHiAp3V6nD7iIJTGGHklRGkoY+xWwjTBVW
         z+sA==
X-Forwarded-Encrypted: i=1; AKwUvByWSMNR1zbG80TPgOLRVKaVxVa1safzUzcGekIJ/kZKVD9n7heoK8gi+lmPsGpbkAmSeqp0+igF3W0=@vger.kernel.org
X-Gm-Message-State: AFuF++maP0G+wtVYXQxb0kgFAnU4Rs2d7qKW6kFd4tRHkUS2Rpwx1wVs
	XcFKh2DAg+I5kaMeAJpHvywv6Ogx65jjxUyd5LIwnFDejpiHGiZOuX8+
X-Gm-Gg: AYBFou3IEnKshGw81YW1Nd1UbVOJhhPlUjegR8lS+U4reP/BtN4g3GL/YLIYgXtmxUJ
	GK4BBmXMgOPNsgazHCpqT5wT47F6QiHSDg78UdZ1+bkWOm8CPOVX1DzRPiW4xb3Zy6ozHwX8NbK
	ey8gECF+7T/VH+gvYvA6cNbmUXf3Ji10bB8sj/k2etlwAPGWEsWnfQ4/NApJaoDkKOK0VJjwLK/
	o88ytphf3zu1/CEFagbY+eJz3z26C+dwlPhpI4D4VedhrMV8UvjALOmysIdzRwJYm53S3hOGCOO
	JSaW6Rau1Z9Bkah28WdB/YaWiZvyKPVUKkWklKiYGDaUBZnuwbR3mT0nsS83E13Pk1a7hm+8Uyq
	TBVaANVzxQjAjNsTUlKnA8jd7onwQ3OZWKlk+XvR0fnrAYEOl/j3eo6BwhKWy7bXONq2QTB4WaZ
	VXBgTrsHu+JE9G8FnDh1zxS3U46mUe7MFg3o2gR8C3ZJxgt5ZnS2oQSr0BBf6nt8L0EsyhDM4Ib
	RVuHFisvdq+3CVJ159l/fE4lCwBqewBW6gs+HE0Qs/+IiId6bDJtKXi61aXAtteS4xGtTw0Yd4j
	SnQ8
X-Received: by 2002:a05:701b:4281:20b0:149:49c:233 with SMTP id a92af1059eb24-14f5bdf3b15mr2385023c88.27.1790933302395;
        Fri, 02 Oct 2026 02:28:22 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (158.95.44.30.netskope-rdns.com. [158.95.44.30])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14f468c08absm4645586c88.8.2026.10.02.02.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 02:28:20 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Date: Fri, 2 Oct 2026 06:28:16 -0300
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH RFC 3/3] iio: core: use kstrtodec64() to parse
 fixed-point values
Message-ID: <zo6yokvdhts7sa7kd3f4i2wraa34df24znvus7rqawdjlmsi3l@rujyvtp7i5bm>
References: <20261001-e-notation-v1-0-75187bf06c10@analog.com>
 <20261001-e-notation-v1-3-75187bf06c10@analog.com>
 <ar60h2px1C8hM4-O@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ar60h2px1C8hM4-O@ashevche-desk.local>

On 01/10/26 22:29, Andy Shevchenko wrote:
> On Thu, Oct 01, 2026 at 12:34:58PM -0300, Rodrigo Alencar via B4 Relay wrote:
> 
> > Replace the open-coded __iio_str_to_fixpoint() parser with
> > kstrtodec64(), so sysfs writes of fixed-point values also accept E
> > notation. The scale passed to kstrtodec64() comes from fract_mult, which
> > is a power of ten, 10^n, so ffs(10^n) = n + 1. The fractional part only
> > keeps the sign when the integer part is zero, as before.
> > 
> > The dB suffix for scale attributes is now handled by a separate
> > iio_str_to_fixpoint_units() helper. It strips an optional trailing
> > newline and the "dB" or " dB" suffix before parsing.
> > 
> > When there is no fractional part (fract_mult == 0, or dec_scale == 0 for
> > 64-bit values), try base-autodetecting kstrtoll() first so hexadecimal
> > and octal input keeps its meaning ("010" is still 8). Fall back to
> > kstrtodec64() on -EINVAL to accept E notation.
> > 
> > As a side effect, inputs that used to be rejected for integer-only
> > attributes are now accepted. An invalid octal number such as "08" is
> > parsed as decimal 8, and a fractional value such as "1.5" is truncated
> > to 1, matching how kstrtodec64() drops digits beyond the requested
> > scale.

...

> > +static int iio_str_to_fixpoint_units(const char *str, const char *units,
> > +				     int fract_mult, int *integer, int *fract)
> > +{
> > +	size_t units_len = strlen(units);
> > +	size_t num_len = strlen(str);
> > +	const char *dec_str = str;
> > +	char buf[64];
> > +
> > +	if (num_len && str[num_len - 1] == '\n')
> > +		num_len--;
> > +
> > +	if (num_len > units_len &&
> > +	    !strncmp(str + num_len - units_len, units, units_len)) {
> > +		num_len -= units_len;
> > +		if (str[num_len - 1] == ' ')
> > +			num_len--;
> > +		if (num_len >= sizeof(buf))
> > +			return -EINVAL;
> > +		memcpy(buf, str, num_len);
> > +		buf[num_len] = '\0';
> > +		dec_str = buf;
> > +	}
> > +
> > +	return iio_str_to_fixpoint(dec_str, fract_mult, integer, fract);
> > +}
> 
> This won't support cases when we have too many leading 0:s.
> All these functions should also strip leading and unneeded 0:s.

sorry, I messed up when replying to this (doing a proper group reply now).

It does support leading zeros just as kstrtodec64() (there are test cases
for that) does so, but when handling those units in the end the buffer is
being limited to 64, which I think it is enough (19 digits can hold real
decimal value, the rest could be the decimal point, signs, termination char
and leading zeros). In a practical use case, how many leading 0:s you would
expect to be supported?

-- 
Kind regards,

Rodrigo Alencar
