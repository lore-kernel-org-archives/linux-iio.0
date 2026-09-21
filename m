Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72A348FF92
	for <linux-iio@vger.kernel.org>; Mon, 21 Sep 2026 11:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789990443; cv=none; b=afIszntIf73FpzUzMQ86gxSNx3LLt2dQQQNT273A5qvgA8JdLsF//zcqfp/RF1ELCZfkMPIbIS+7b4EsjNQtnDefdFRiXMd6EPyzvFTKryFA2NfxDFiQ6HRnoHQy67kEkEAcnPxhMBhkKwxxnAaBnRxQWJsEHWHxkqX1Gij6vOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789990443; c=relaxed/simple;
	bh=igMMVzyB0kazDBf1FCrnS86fOSdJceOcYZNYKQsRSwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=atzWu1pK/TjYqi1S1RCytTR5JEpq57hQ+xWvAhJCItGw+vIlGYSLI3JALomE/pUam/YalWNVhf8607UPuOEcXK7U57i9uyOelQuTFAHtUEKwLYf6KWC7mptIwbCg/toCJYBAq/OCm3uukloPT5xFf3DAt1OYdy9HcSpa0YSSIN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WF3LwFfF; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WF3LwFfF"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f6350f88so1731374f8f.2
        for <linux-iio@vger.kernel.org>; Mon, 21 Sep 2026 04:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789990438; x=1790595238; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=AlSfZ5SyLA7gnS311aS5PZjku8Ua3hLuitk3rxSYlQg=;
        b=WF3LwFfFXyWuYmq2whc2ae97AmMrzq/jDIrAP4kyu+zgmGWXXaSAArmji8OQfhouxb
         j3HJazSeYnzF5rpOPmuB9EN1p10/5DoUjEy7Dqe8BuoaCvo7R0F73qu0SCX3/7EAsBSh
         cNwlSIh2Vhqo+RopxNtQxHneUj1rAWY6uLhUa+8EX+tMtarH9z7yp+ucIKylswfkgJzU
         mfkatn1g5TKgf94WVksalmzhhW05AuzeRJfNNj+kij90ogrhQnbZsjUwDj4nS0ORpBwh
         T1MtMg6rMJYA+175eLuOcihfaJLpqzjYvXK+sIqTv7Kgkq22dJ5lIewUKwT7J/3OgvCn
         ZY/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789990438; x=1790595238;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AlSfZ5SyLA7gnS311aS5PZjku8Ua3hLuitk3rxSYlQg=;
        b=172BRh3wW1XQkHCwLuVXXf1bQLcet7nCFx4zMV09LYXlWMlTkv6u7TK4VhmysAPUml
         O8cmBmHJfBTeVStv5KoeeoYMtpNkf2rN7jyUZ5A4/DcCzIu5rK2ubvZjnalXEJp8dKwf
         0sryJVSxqB/xAJVKI5tNVzcjV4/y3DTlrkqhhs7FWjpGlGKblUTR7T6yyo2Oen2XqdUF
         IxLAZN9BDld+PcUdyjqxt0tCc6J7IJzvsMV59sC+us27DbvfoNP67+es8WhWKi7/ZAG2
         qGpeUfsuB78gSslM26aGqQbOOfn30kKZVhpQinR5X7tTKgnFEEoJMwcgiv30hfWI9/Wt
         jB7w==
X-Forwarded-Encrypted: i=1; AKwUvBwyHiCdF0E3X7bo7M0Dj5dirn7OwJHjuqNjMYZTQlKoNAZcuBV58cXEfivfNBpri6A0nPJPnts/QsM=@vger.kernel.org
X-Gm-Message-State: AFuF++m5fRZKvOGmGX8+dd/bN8LJrFIqayV/CgblFILsu9hYEdzaiEGs
	1SgGQ6++HdrIzuSyQ5WULMIZESxdVfn1exMHrz0PYdJwYQyA8ziPg0p1
X-Gm-Gg: AYBFou1xfn1J0WL8xDT+RWXPZe4ixgVkNB1Xucusn/4IHqPMTiWxqiBaNTZzf4SK1IF
	YQRHoK0+tNmRi2POCvx2pKqYjRopuITf+dTz9FTqYsx8BP22JVwhZFANy4FTthtMbhxPSlZevU3
	IVhydb3O9jzt84yiKeavg+bOiuRZc16b1X38+lFwCEIFDCavO71XspZ7lqKoO1lKtOXYDcnf/nD
	IlRi5S0xz0eNqM2FKkEvDx2EbEFIHIKgR6QqH/25c5dhSPfcnAwGQrJcnZdI+KWlFqVzwLKXmNp
	acsk6tM/QG8YRgA286KvggHVN+c5MTtdO7ubQpMzTqPDWsKpn6mnxLefy8pYeHgA041MgdgU4gR
	l+Y8NuGLpz10aUjWdTJWzKNt75+aG9ke/32OVc4cYnokV12R+lZIpanKEv0A3tKW1etTK9+zQI6
	/sdUTnzKIWVRT73fyi+Y9j3+097wgmpH7/XB43okYitqRx0kVNzIKMuh+e46dxz8VWGhLSHUPZY
	PHAxVFKq8RyFg==
X-Received: by 2002:a05:6000:22c9:b0:486:fe09:6918 with SMTP id ffacd0b85a97d-4871e373ae9mr15558359f8f.56.1789990437762;
        Mon, 21 Sep 2026 04:33:57 -0700 (PDT)
Received: from iv-work ([193.43.9.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48724562bcbsm24047359f8f.16.2026.09.21.04.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 04:33:57 -0700 (PDT)
Sender: "Ivan A. Melnikov" <ivan.a.melnikov@gmail.com>
Date: Mon, 21 Sep 2026 15:33:55 +0400
From: "Ivan A. Melnikov" <iv@altlinux.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Francesco Lavra <flavra@baylibre.com>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: tools: Use proper macro to detect _Float16 support
Message-ID: <arEDbA8fIxR6mrZq@iv-work>
References: <20260918161305.1161852-1-iv@altlinux.org>
 <20260919113945.2bee973b@systembl0wer>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260919113945.2bee973b@systembl0wer>

On Sat, Sep 19, 2026 at 11:39:45AM +0200, Joshua Crofts wrote:
> On Fri, 18 Sep 2026 20:13:02 +0400
> "Ivan A. Melnikov" <iv@altlinux.org> wrote:
> 
> > __FLT16_MAX__ is an internal compiler macro. GCC defines it if
> > _Float16 is supported by the target in general, but the support
> > may depend on the exact target options. For example, on i586
> > without -msse2 I get the following error from GCC15:
> > 
> >   iio_generic_buffer.c: In function 'print2byte':
> >   iio_generic_buffer.c:141:17: error: invalid conversion from type '_Float16' without option '-msse2'
> >     141 |                 printf("%05f ", ((float)converter.f + info->offset) * info->scale);
> >         |                 ^~~~~~
> > 
> > To fix that, use the public macro without double underscores.
> > 
> > Fixes: cdd445d4b2a9 ("iio: tools: Add support for floating-point types in buffer scan elements")
> > Signed-off-by: Ivan A. Melnikov <iv@altlinux.org>
> > ---
> >  tools/iio/iio_generic_buffer.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/iio/iio_generic_buffer.c b/tools/iio/iio_generic_buffer.c
> > index 000193612aad..9ea93984e0e9 100644
> > --- a/tools/iio/iio_generic_buffer.c
> > +++ b/tools/iio/iio_generic_buffer.c
> > @@ -131,7 +131,7 @@ static void print2byte(uint16_t input, struct iio_channel_info *info)
> >  		printf("%05f ", ((float)input + info->offset) * info->scale);
> >  		break;
> >  	case 'f': {
> > -#if defined(__FLT16_MAX__)
> > +#if defined(FLT16_MAX)
> >  		union {
> >  			uint16_t u;
> >  			_Float16 f;
> 
> One Sashiko issue:
> 
> Does this unintentionally disable _Float16 support for all architectures?

Indeed, it does. Sorry, my patch is incorrect. I must have completely
messed up all my checks on Friday.

> Since the tools build environment uses gnu11 compilation flags without
> explicitly defining __STDC_WANT_IEC_60559_TYPES_EXT__, FLT16_MAX is
> undefined across all architectures. This causes the preprocessor to skip
> this block entirely, causing the tool to always print 
> <unsupported 2-byte float> for 16-bit float data, even on platforms where 
> native support previously worked.
> 
> If FLT16_MAX were actually defined, the compiler would still parse the
> _Float16 block and throw the same missing -msse2 compilation error mentioned
> in the commit message. Is there an alternative way to check for hardware
> support without completely disabling the feature?

Apparently, the only correct way to detect _Float16 is to try compiling
some code that uses it. For that, a feature can be added to tools/build.

On other hand, x86 without SSE2 is the only platform I could find where
__FLT16_MAX__ is defined, but _Float16 does not work, so a simple
platform-specific workaround would also work and would be much less
elaborate.

WDYT?

-- 
  wbr,
    iv m.
