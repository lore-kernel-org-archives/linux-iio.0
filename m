Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793783084;
	b=kzd4/opU0CWpHYqFpwIeHJszaZd6XaM03xZJ+hUzvlwzsFNOLGLDvFdqjW4iMs/znIFj
	 SoW0/XBF7NeNioHFUu4uMADpDCpzUz/XxClZlER2dXlODBCJYshl1/rOlXGlT0M8iQ3l0
	 vl/+WEQjC65j/ZaDhfnW0qd3El3EFpPGKQnG0incfdjz69NqmAmRhgJWFe+ICNfJncvDD
	 Zk81PCiA3svepRJhrmzm7uTeN1xvF4b2596N/4kTvCWCFAs+4IXH29O7TNEPFTgcnD+EV
	 pRdSENMAl5Xp3npVT9gssfsUe7h9OGVemCYlbB4lPtB5AeQ00Ft4QjOllG1cybNMdzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793783084;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=abCJPnZRJTccf2CBVLemfheLgJNapsyRZa2z8kbgwdM=;
	b=ojbeUglpTObDGCLFGZbyyfbZvVgul6gDtURI7GbBTNqtkbgj11mQ10m6MYhK9tmKit6I
	 QYyaaV781QJE2N3h+0pgKoQM1wbwE3tkGzbH63Y2Zj4DYOeBfFOp2ZxZ97qM1Q9f5OFAG
	 hV0Ja4M20XNebHsccc/ZO+cEYG/3OYxHRih6eOWUNY7GYJj/cZzVflkgQoOKtI6kodgqs
	 uOQanPMsGgBVMYtnk9SiUtCzOY61B8QwzKLoEmWShsEZOeES8qYe8/+hQn40qOfHNJZdY
	 690SLKHf5GLts1FuTP3HVDGAWeoTKLO8aoDX2/znwV+8KpgsOiSqVLD+DVLUpGLCJXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gs79E6th;
	arc=none smtp.remote-ip=74.125.224.41
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A99606D801
	for <linux-iio@vger.kernel.org>; Wed,  4 Nov 2026 09:04:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48A99606D801
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gs79E6th
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-67be4686827so389703d50.2
        for <linux-iio@vger.kernel.org>; Wed, 04 Nov 2026 01:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793783083; x=1794387883; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=abCJPnZRJTccf2CBVLemfheLgJNapsyRZa2z8kbgwdM=;
        b=gs79E6thA3kgM6oDsprNfbjRxjwDOdimV5m5dxpy6nnkoyTnCaxm36bTVL4jKtu7QG
         8U/a3mbtqM9vauAo6IBgnl2s1UtA/flpMpKlV8xNTBvMCmI45PGN/q9RTQgpd4qtNOUn
         b+4Lck/6cMDEE1dmQq3TkbXCoJQakUKtUiL71KNUsbz3/XMlSejTPBih4EZPquQR9dpP
         plj8nJ5zBbmSugfbxbPpVLW+JLImaH6B6QK0hUYoU0heGJAiU7A8lLjvvZUGJG68UhDN
         y2eLtL96yRqWgdt/WbIh+VFLSoU9/wSy8wvWg5N1nkpmseOEyS4E3qyQiNsjqC1GDbcN
         j4yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793783083; x=1794387883;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=abCJPnZRJTccf2CBVLemfheLgJNapsyRZa2z8kbgwdM=;
        b=KNgRrkGGASQL0wXX/RwzoRWdX6oT2nJpzs5bJbayo8+iL41QSV3zNtW4KexmDUy30M
         RmPt4XaYGVXpJveUNqSNz1vnaQevxdMdBJ588OH8Ez4rKJBV6qK5ary31AQ1lRz6UCcn
         dHtAwJXq3mU3UpbdaJQ3umt8XqGhWOWii/yq07D8F40w/DVw0w7QpLem9P7aLZzDriei
         fGpBodiBNkdiTzlSP0RL7hu271huvQ8zyd90lb8CV264Gi75srlsWyiioI3ajxlIj4YR
         m9yZoAHqSlZjUQH+wi92xwkKNQfqCTtYwCFJl+reBGfsxHafjK1o4QTImfE4kp+R/InB
         rnSQ==
X-Forwarded-Encrypted: i=1; AKwUvBwijUaToi2dnZorhngVo9dMsGN8czXRgYMl51CuDlhY1DoX7gMViW9SeuwIPyGUgpIwprD1cMN0dPE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/kGhkb+K4u1rpk77GCxf1BquxliBGOT17gtEddfF9FRqKLwQaQ
	dumdcQgSiwyXNftMYXwI+l/T7fYzyX1+ryrf2kgbPbiYJE/sA110GLaX
X-Gm-Gg: AYBFou31jNy8GJHWCcSqZ4rRFMQknrrzm4XYiG0Wxxs7FBMjEDPA5w8dcU+RRu+WwtY
	2hVXW7AGr3lsj92p70LFfsocfNW+F94eOu4/nQBhjzsuvlVgJkAD17cpQn88wFddCjUbk6r9aMz
	zINvcuJWFfHKXd/YImHBw/BJ1ZSl+K6Zb1JtA2lcr0f4YI2Jt4YbjtwKTP0h/1L19wJFGuUwnmp
	tlIhpbDEdUOhIXE+5yaXo9ah0v6KrnLUJQlm1o/v01b11zRXF8ORNafAlmw508R7ccSOa6KzVIa
	4KfYAeyGyPBppUvJoFWTijznw0XyQ902RKYhJG0dV0GGEj8dRq4uS7xprqUWn8zEZbfEz55CdSz
	zPv/xyt0bwVeWOq9Ds4tEZMAjPtJGa6VBtJKfiu9SooVBmGALiibwONa3tx0qVx2+KC6a5q0hJf
	rNs9C62+1D2pb/7W9oO2/Pcgm5kJpj+e8h+LZIdr2NK/qAhW/EyjVx+vdKsud8l1IhJQkvDTE+i
	aezRmFl3d5gHR9CW330G2xQUuJ60nsLsUB4MT4EMtnISav0sYt8PulpEHMIc9J9bwwhl5Srv0fE
	WTvmvecJ8IwRkuljWdMf9p7EKUNSfSDfyytw40QDyIL+7Y+pO1+XA+sGs3oofHa6LCv65DnaSjr
	hAYVoKh2VX0vYP87xSQrPtS8=
X-Received: by 2002:a05:690e:bc9:b0:675:a278:10a4 with SMTP id 956f58d0204a3-67ba5071189mr12464797d50.103.1793783083257;
        Wed, 04 Nov 2026 01:04:43 -0800 (PST)
Received: from RDEALENC-L01.ad.analog.com (158.95.44.31.netskope-rdns.com. [158.95.44.31])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b309bbb4f7sm14402517b3.41.2026.11.04.01.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 01:04:42 -0800 (PST)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Date: Wed, 4 Nov 2026 06:04:38 -0300
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v5 2/7] lib: kstrtox: round to nearest, ties to even in
 kstrto[u]dec64()
Message-ID: <7qc3geup2edufde3wbx5wsyhjz6tcnekoa4c4alxudqb7buvmf@lijbrfhachls>
References: <20261102-e-notation-v5-0-d399e544a982@analog.com>
 <20261102-e-notation-v5-2-d399e544a982@analog.com>
 <auof_hMbsbFq3MYj@ashevche-desk.local>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <auof_hMbsbFq3MYj@ashevche-desk.local>

On 03/11/26 19:55, Andy Shevchenko wrote:
> On Mon, Nov 02, 2026 at 07:41:00AM -0300, Rodrigo Alencar via B4 Relay wrote:
> 
> > kstrtoudec64() and kstrtodec64() drop the digits beyond the requested
> > scale, which truncates the result toward zero. The error is up to one
> > unit in the last place and is always in the same direction.
> > 
> > This is easy to hit with values produced by userspace floating point
> > formatting. Printing 0.3 with "%.17g" gives "0.29999999999999999",
> > which is parsed as 299999 with a scale of 6 instead of 300000. With E
> > notation a negative exponent can also drop integer digits, so "19e-1"
> > with a scale of 0 gives 1 instead of 2.
> 
> To avoid unneeded brain work it would be nice to add an example for negative
> input, like -19e-01. And I hope (and it seems the case) we have test cases
> for that.

We do have the tests:

	/* E notation: negative exponent rounds integer digits */
	{"-27e-4",		3,	-3LL},
	{"-125e-1",		0,	-12LL},
	{"-135e-1",		0,	-14LL},

> 
> > Round the result to nearest instead, with ties to even. This is the
> > IEEE 754 default rounding mode, as used by strtod() and printf(), and it
> > does not bias results in either direction. The first discarded digit is
> > known from where parsing stopped, so no extra pass over the string is
> > needed: the remaining digits are only checked when the first discarded
> > digit is a 5. Since round-half-even is symmetric, kstrtodec64() keeps
> > rounding the magnitude and negates it.
> > 
> > Inputs that fit within the scale are parsed exactly as before. An input
> > that rounds up past the type limit, such as "18446744073.7095516155"
> > with a scale of 9, now returns -ERANGE.
> > 
> > Update the existing truncation test cases and add cases for ties and
> > for rounding at the type limits.

-- 
Kind regards,

Rodrigo Alencar
