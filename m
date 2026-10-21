Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792575360;
	b=uD4Nw1tH0StF+5uFNotvIJHBVWb150HDcUUdE7EEoBKBYZnBLmcW60fl/h1Xr2e3285f
	 j/gCkdp7mWRStyyyLLnnvWm3jlnbXJ0oEoc4gcga9Wp87FRLcLy1K+FCRf76itVKttNlX
	 ojro1bif7T1YNfA0JTQmaGhi2cdizUahlx2SfVRL1d9TewnhZNRnlInFg5tNRB03OvT+6
	 Dqj9GSV3uIW1Lf8ikCRYq0y+1RRHEqr/jIH8F37oXF9eFcFu1S9/YY8yT0DmGr2l2zWUC
	 wQKd271eDxJPw0ye36n6UfXgpZt/hv9xdJiK1upUSPmE+Vtej16+Rg+nfmqWLQJZ+og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792575360;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=vESFpxx0VNlWv9cyNazlbbd+txTe8v8vPR3h4QzwP9c=;
	b=OrS+JIYlA1B82LIq/94J40APkGmhECvw4lvr/+lyB4uPvxSWWosF6j2cozB3Xhbs/sIE
	 q+G9RD/yMsBH00SODR42BIKTiomTj1fZounsUlRd7q1/uoVrnvd1KYYVU4tw8lgnbfmqI
	 jssBaydfyoyzqsfXdX5in+Gvx2keKdoFCBLByeTPjWqIxZT0KVEJT7X6VIFWZqE085qWx
	 Eke5vNkZg0g/GUgJikoHFhGO+/fW0Vm9V7Xtdc2pvKUT5qMDkdarzU8FDUAsakZL9wUfl
	 xCz2g/T7UR8kMG42LdX4zHDGLjyT/y/gvtqOacGUKj2vH4QCcoRfUwU1nmgUGmPk3UA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="K/QunA4g";
	arc=none smtp.remote-ip=209.85.160.46
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC945606A31E
	for <linux-iio@vger.kernel.org>; Wed, 21 Oct 2026 09:35:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC945606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=K/QunA4g
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-4949f037131so305491fac.3
        for <linux-iio@vger.kernel.org>; Wed, 21 Oct 2026 02:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792575358; x=1793180158; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vESFpxx0VNlWv9cyNazlbbd+txTe8v8vPR3h4QzwP9c=;
        b=K/QunA4gLyUdCC9TYZCnXtwnhnkHnbML3h8cQpfsW+/fJ+cOYFQyOufQWY3bKogqVm
         r/IliMVAXHqNoDBA+NmtPYQjBsFdxtiav6wZLzHeoKvi9Qi7NWFFV6t2i4PK2p1A8tBv
         9ZdOTSQ5qAqpLI3GkvHLni42pRefDw7QZ+fkIhcTLN5QOXxaosLSZjergEDqy9NVNar1
         Ci7cx3MADb9T7UjRXu/BDe/xxKZ2PLiQ15rZskNbdBDWu6sKLJWLHHmZMMSGUDgUd2ET
         uCaiCYcKTlocrB5z0toX3FoiIZELwzvcmHHYSAVvCO2E2Z6YAsuMowxSXfbqM5CzMI5d
         g4/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792575358; x=1793180158;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vESFpxx0VNlWv9cyNazlbbd+txTe8v8vPR3h4QzwP9c=;
        b=H+sxXemHEdWA+MuJ+tc+6ofk5sBYOo8XakGOpk1V/ggWRV8rHTjlZlptSEQZRtYVcL
         Qkd389/iX0WSHwuFNye9s1IZKc6HMWJLHyKsXAoCQUxhVO4DtMFgTlKfF0PpjuNcploR
         7T42pt4ZnIQ2whGbQ9fwzk9FLYcg3bsK3C5EUQZNBNiTTWLrdBtKJuNISu/Qfkp2XUIn
         wS2KT6LPNBzUIkLuwax/cyXynxj/wjCtdigVZtRcMfCxUUKghZiCWfLrIeV4Bfgk2FLf
         V49j4CZZ2WOZFxpbJG8NH+u4456iLuXc7mnlyFNw+BPiXKFF6q4gfsS1evJNQBpZwDEr
         mfFA==
X-Forwarded-Encrypted: i=1; AKwUvBz0/M1YxuySimwKfvKgKzGFHmYPU7h+piWDf7pn8rebKbja48OJYYoIK9LxbhZK/EWZ5j1FdV0emPM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLd+hqLCRPreTP78gPpFoxuwLEVy0FwE9xgsSSjYEap1wxNb0CC
	TRAoC7EQl91yrpB+9Kl/n6dNyw+XTQOLpU0GCMs72H2PgsPR3eX7lTkD
X-Gm-Gg: AYBFou3BuCMNTBrFAapYM5u48UOGuK0mJvvQAEXnVKtW+bvdesj7wf8H/hdeQ6qPhrk
	s85d6GlzbrvWwE8gYT+VEOs6nCOApgLy4NwLg0cbdipTowQUZMxOTcAMr3oLO8BbsBNVMSYjz/c
	L1l9nhZSOGiynAw7cp8F0LmUCBJpOYXPGkhQV7eZh7blJvgeVhsSHk74Fv2bREDpIvPvGUGJA8+
	JH3G55m/J6jHyDfC/y+U5erwc8+2qqZrZMvh6hytrYugg6LW3dWoyKUfc8sqTkTNQ9RoCBpU50w
	3gBrm/qiBtXoIMn7cCGtzYspLGUiNsrPFsDZ6y7VgdCLFGCPLLezgL8gm1wd3Xtz2Gl61iZ6RHx
	q36/SzcrV4HB5jwy7265QBL7Zavz8hMO4cr4sdnpaH2/31Kqe6SnUBdrb3U2kwwtXNAeHcWUyLj
	jTTGojCs3i8ugR0v/qVMOte3XsjzH5H1SpoY7M+SFQl4zzONGQcL9H1EZZiLtH83Gbwx0lMCzaG
	MhVDJ/PQcTtMMJ5gBnxW3uYBRzN13AFZAIm49KP/2Y7mkMSvf3OsT7c11lVDH+26P1SNuYiRheM
	6IU2Q/S/SfPP0cfaIB/tfuOaryrHdJb11Hy1smshDzIQPjQgjHM=
X-Received: by 2002:a05:6871:288:b0:48f:e107:8e48 with SMTP id 586e51a60fabf-4a7dc238a6cmr729894fac.41.1792575358461;
        Wed, 21 Oct 2026 02:35:58 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (158.95.44.31.netskope-rdns.com. [158.95.44.31])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a7d617c2f2sm1491979fac.8.2026.10.21.02.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 02:35:57 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Date: Wed, 21 Oct 2026 06:35:49 -0300
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH RFC v3 2/5] lib: kstrtox: round to nearest, ties to even
 in kstrto[u]dec64()
Message-ID: <e2zxpo6o34qbp3oihrenolktavoczl2dqyggp3q773i7ryrrtd@4ixkwasrh2kv>
References: <20261020-e-notation-v3-0-fd385c0fbf65@analog.com>
 <20261020-e-notation-v3-2-fd385c0fbf65@analog.com>
 <ath_3QVy5DVV4fxw@ashevche-desk.local>
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
In-Reply-To: <ath_3QVy5DVV4fxw@ashevche-desk.local>

On 21/10/26 12:03, Andy Shevchenko wrote:
> On Tue, Oct 20, 2026 at 09:27:00AM -0300, Rodrigo Alencar via B4 Relay wrote:
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
> > 
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
> 
> > Update the existing truncation test cases and add cases for ties and
> > for rounding at the type limits.
> 
> ...
> 
> > +static bool _round_half_even(const char *p, const char *end, u64 res)

...

> > +	/* tie: any nonzero digit after it breaks it, skipping the decimal point */
> > +	for (; p < end; p++)
> > +		if (*p != '0' && *p != '.')
> 
> This is a loop, so this also passes '.0.0.' case and some other similar to it.
> Is this a problem?

no, string validation has been done before at this point.

> 
> > +			return true;
> > +	return res & 1;
> 
> So, this res is used only once to get a parity. But this doesn't semantically
> sound like boolean to me. What if we actually return 0 or 1 from this function
> and use its output directly in the check_add_overflow()?

Yes, if it is fine to always take the path to check_add_overflow().

-- 
Kind regards,

Rodrigo Alencar
