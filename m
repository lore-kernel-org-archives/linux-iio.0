Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792443805;
	b=F7PpyWEifHBiSfR0xHQjZux9mRnbJsRo9c47iH+/hxpB019yLhc5e+0hSvqGwGq/MYic
	 Fhdl6Ec4hg9UX29CPeetrlB7FtIf8ECel47BDna1Ij2yQBN57lqShqcdZZ67lKmAAC6Li
	 Sf4+4rW/NNnFSVgq1Thn0PkYyBY2z2BL4YqBDJw+EXcFrXGt4B0Uex/fq9zT1evOrRlEj
	 E2qaFf4wACXSijByu0yqPNRzESvh+I+ImSRPdMC8F6kCDYVcQQUCtcaBwouXxke29Ic/s
	 5S+iCPEywXtlGYqvHSZe+RFd6YSq6TmINhp3t28e9FrtNiI9jrD+spBdVeWE5O4Ffuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792443805;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=bFksrm77cyr8jHa+bYjO51SDtxqIh7+jp/ljya0vLSI=;
	b=OyRCCjbZXzyLriJT02OlXt53Kwd3yhAV8TWCRPWRD4ns7RdXRmYzwVECmuGG8rTr4i8Y
	 Ufe2qCENeT6mkcIfnjvBCQLBJAK/I6XC0OSl38Z1Azs/rSNLjFqM4dx3UBTboa2OSKQHc
	 kiEYpdgI5KKf5KegvMzmDHFy/Ib4xOfj82WmA3l5xb/kyc0XeiS4nLm+IzM/X3AeGS4m+
	 ptPJKyyrLMN3LNFui7WhYv1MuKjp5hqiRAP3ufa7JZaOdVnYH7MR66KZeb+zXW+zR256W
	 HaKGXNFv8A3iaaRKLyaEIHQD/uXpnwAdq89/dTkCb5R+nhA4USZcy0MP5PlsEEyA8sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=js3Iw7wY;
	arc=none smtp.remote-ip=209.85.221.182
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FB8606A31A
	for <linux-iio@vger.kernel.org>; Mon, 19 Oct 2026 21:03:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1FB8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=js3Iw7wY
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-5ead5ff47caso618206e0c.0
        for <linux-iio@vger.kernel.org>; Mon, 19 Oct 2026 14:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792443804; x=1793048604; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bFksrm77cyr8jHa+bYjO51SDtxqIh7+jp/ljya0vLSI=;
        b=js3Iw7wYynwqlO3t0d4usi7oCUftDpJQchdczdYGmfAyX6uduBi6AUw5xsU8aog2VZ
         WUYVx9F3k0clssm0SpDe68hNUb2mILlxQv0BE+KBqlOiplUUPn4Z2OCgQEZMDdl67kJH
         NVifoGWbCKPZuCZUbK4baNijj11h+3nhviXo045eloX7IXrIT1BhW6KN/z+4xW6o9RLb
         CexhCSjxAX6tgNzkjGmiDMVklFjNuUeK6BbuMSuNrqYIhuS8BCK9ecNubGQpJRwVCzaj
         ZrTz8x29dbj5G9t16h/gr3BCniqk/wENGkv1Y2jtq0IeSL0cfBti7Ds50b3HaoahSiNd
         NHIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792443804; x=1793048604;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bFksrm77cyr8jHa+bYjO51SDtxqIh7+jp/ljya0vLSI=;
        b=Vaw+7Wt30Mkyjx2thVsWcEeXaN9wP4MxpuSWJVwXrI4zGKfz1D/f9/7chPNBKPY31O
         0NH5UzVSsZGq+3Y4mTGxEzoV+LaVLsTdKSu2LWqjMaKvooYH+ojRLV+WPNhjDSaeweG3
         ALfaNgjKhfJL6VTC8rIQ+yb/WvrsKABkthfr1MrJPDgy6U0kxSikBNaOh2sJWKDT/Kcp
         ZuAMu1oHPUUbKFPID4fZ6XyjjBUNWf4KbzUFrifMUcq9HASg5uGVXuRUwcmQCKe+ZWFd
         7dqM4KMrv4bhO5hSUTaBjGnyIsdrp55ccfZq7aZ9L2Bwr3LHzCMwoyuj2wgZbIeH8I5l
         X1pw==
X-Forwarded-Encrypted: i=1; AKwUvBwLALYXSJJ0036OV8uVU+BX+EAyaE2XwHB7eyslU3C2fVZr5ZzeZ9z/a+WY992IUWD78ulTmRXc7xo=@vger.kernel.org
X-Gm-Message-State: AFq9FYI4n2vMTssZZ4mkTa8KUFo880NcNJK3pm9fOYL4PeUqI1as0p5F
	2BfrVhYAKymtrvv2LhXFqmOkTJk6RTrFfHf+gDabiKnBOw+kjjoaMhHMN51VLTBg
X-Gm-Gg: AYBFou10lLedQBgCa4LGl7L0FQc0cEUmQ2oBkrJoNSw8+UZZV/XhF1plDQMy3EXg7Wg
	546CGbal7ktT2DYxQ5Jsasv1qzHeovJaJvoqRAsN1bRkqonwG2iwFYT+aeEKnoQXwgRIL9F9SiO
	wB0Cj29BBQeyGkwS94f4hCiDEfMkfCxevDY81Ap29yQuQitxeOVss8Ntiks9c27hxx1wGn/sng+
	SxA5GHEoPV+Tb8KTgb8L4WP0SqMm2iRHn+x5ClpBQtPKuRug4t6zEac5RHzV6xOUYWmm47sYfNr
	pUSefzAOjz0YrUvEBmJR5k8xnQNfOQ1E3ymDaKBzbS9vDP31+AQYXiKwMqm9y6bCmOo2Li8Gd/6
	hER0/5aVjNE7tydD1lqr3wvtgbshjUVuwdYtiyjrfzrKgvAHHX0q8Vg07V0C6YydygSVhYt3qSj
	uhhjeAccTcQedZWgQtWU1QArDqOigHJX04E+XHTm693NCHxVyF3LVs6xf9cWVxbYlwYWhI6pQIN
	WwdzA==
X-Received: by 2002:a05:6102:5488:b0:7a7:5355:7fb6 with SMTP id ada2fe7eead31-7cc36a207e5mr1757779137.24.1792443803558;
        Mon, 19 Oct 2026 14:03:23 -0700 (PDT)
Received: from localhost ([2804:30c:4067:b00:a68b:4892:7af1:b51d])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-990bb355e82sm1292902241.6.2026.10.19.14.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 14:03:22 -0700 (PDT)
Date: Mon, 19 Oct 2026 18:04:28 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux@analog.com, nuno.sa@analog.com, dlechner@baylibre.com,
	andy@kernel.org, Michael.Hennerich@analog.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, corbet@lwn.net,
	skhan@linuxfoundation.org
Subject: Re: [PATCH v5 06/15] iio: adc: ad4134: Protect conventional device
 access from debug accesses
Message-ID: <ataF3Bpop9cAYuXW@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1792200021.git.marcelo.schmitt@analog.com>
 <b05978468abb537f7fe5b1d0ed2753df9a69decb.1792200021.git.marcelo.schmitt@analog.com>
 <20261017194707.48f6f242@jic23-hlaptop>
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
In-Reply-To: <20261017194707.48f6f242@jic23-hlaptop>

On 10/17, Jonathan Cameron wrote:
> On Fri, 16 Oct 2026 22:58:05 -0300
> Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:
> 
> > Require debug access to acquire device synchronization locks before
> > allowing any transfer from the debug interface so to avoid disrupting
> > operations issued from usual (non-debug) interfaces.
> 
> These needs more.  What sort of disruption are we talking?
> 
> A deliberate write to change state that breaks normal operation
> is a debug mess up that we don't guard against, but if a read
> is enough to break things, or there is an inherent disruption
> of other operations by using the bus at all then state that.

A read is enough to break any ongoing buffered read because register reads will
cause the bus configuration to change to a state that invalidates any sample read
that happens afterwards. 

> 
> What isn't regmap locking covering?  

regmap doens't cover IIO device direct/buffered modes.

> 
> If this is all about the mux stuff and backend usage,
> then move it to nearer that in the series and refer to that.

We also need the mux usage to be synchronized which is why debugfs_reg_access
now also locks on device state sync_lock.

In practice, because every device access will select then deselect the mux state,
we are not able to have two operations going on simultaneously (not even two
register read can run concurrently due to the needed mux state care).

On v3, there was a dedicated mutex for mux access synchronization. In an atempt
to make things more simple, that second mutex was removed and sync_lock is now
also utilized to prevent multiple threads from changing the mux state simultaneously. 
It shall work properly as long as any device access first
claims IIO direct + get sync_lock or claims IIO buffered mode.
Is it okay to have it like that?

> 
> Jonathan
> 
> > 
> > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > ---
> > New patch in v5.
> > 
> > I'm not sure about this one and have no strong opinion about it.
> > Providing it according to suggestion from Nuno.
> > https://lore.kernel.org/linux-iio/179199692826.658576.4841754843069240356.b4-review@b4/
> > From previous discussions I guess this patch might not be welcome.
> > https://lore.kernel.org/linux-iio/20250421142359.11fb483f@jic23-huawei/
> > In that case, completely fine with it being dropped.
> > 
> >  drivers/iio/adc/ad4134.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/iio/adc/ad4134.c b/drivers/iio/adc/ad4134.c
> > index dc4d801490db..42a1272c2894 100644
> > --- a/drivers/iio/adc/ad4134.c
> > +++ b/drivers/iio/adc/ad4134.c
> > @@ -302,6 +302,12 @@ static int ad4134_debugfs_reg_access(struct iio_dev *indio_dev,
> >  {
> >  	struct ad4134_state *st = iio_priv(indio_dev);
> >  
> > +	IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
> > +	if (IIO_DEV_ACQUIRE_FAILED(claim))
> > +		return -EBUSY;
> > +
> > +	guard(mutex)(&st->sync_lock);
> > +
> >  	if (readval)
> >  		return regmap_read(st->regmap, reg, readval);
> >  
> 
