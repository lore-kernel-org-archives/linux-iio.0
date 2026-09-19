Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31982F8EAC
	for <linux-iio@vger.kernel.org>; Sat, 19 Sep 2026 09:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789810792; cv=none; b=jdMzRwH+NYtOnj25Ju0co1P6zXmyUi/zYiWcHHmu87atCvEi8roI6o7HMO7nYJ0mIkGjd3DhrLr37eSysiHk2fX4IuelKOf80cI84YFPji8BaYIXVOamzTFa91cPrPmOVr0OHPgyfpb1Ncn4w94Z+E04ZCa60THoF4I3R4SXJ+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789810792; c=relaxed/simple;
	bh=VnurqPrpnN+sAeEL0x3TldaQv3nsKFA2accKz2jjL5k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uq2ngcAwaEmxqy9mkl9jvgv1VqfsjNA0F354fNOUeDgumMOElSNSrW+jdkhXn4okRlGZmPkq7qwmfbhcACJeGES1q6XgnB/N4IEQuJpPL+A0daXn1zBZRgjIPYjOl9CeAUv2BRFVH8Ols5M7BzdV7Y22coXhpfvtpmQd0Auc1Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xdy4y/0d; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xdy4y/0d"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cd38e0e5dso19674335e9.2
        for <linux-iio@vger.kernel.org>; Sat, 19 Sep 2026 02:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789810788; x=1790415588; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uuNs+jmp7P80c+ETSoD8IhUkYAoa0hGSn0P6AjTo/tk=;
        b=Xdy4y/0d9E2EulS41gMojgLvVGEQa5wi6wotpFRTtA5Ug2QefACIn+1zHZfH4ZDUXk
         Zdc6t5JAYrL8mZCUeTf9NqrpUeIkVGOYHjXROLksUbQEOMX8U15kNJY96+RM9VjpQlGC
         8Xg/n5gD1UQ8W8WuV/1+raPO3W4RQN5b0OHIJ9XBcKfCMBxy+lw1SSbXkSAr/mX6dRha
         ICmho3xvBFd9RHdsphEZ2ZzaYnzW3YxaCmjLauVBN1PnSkoNgkzUEk5jTM5YYrxgZ4MG
         XT2Rx9W1m87Y4EdaXCfpJVzn509bBTWF5mWaG1utt0zE2Bm908PNouVsG9uvgGJwba8n
         GU1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789810788; x=1790415588;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uuNs+jmp7P80c+ETSoD8IhUkYAoa0hGSn0P6AjTo/tk=;
        b=Oy3w84LHSg2kRvbZaRnuhW5Rhq5EkM5nZeANcTXVcTnWUHPTEx0/ODD+xOv8UKdlMY
         sMUXa4gKwOGj/8HTxEXCm9gWqAafgN1QYzv9yScwNRZC2pFu8WFiK9tKm7vX3Uf8eR7M
         5foybcxpNssvpjvd059gDJYSVYPQinnG7Kqtl4MHvDJoS2Ztqj/xF6/E35M3Ft9r1MiB
         s5Y6t8tanUjcOQL+rRmvYS1dDZNOHFA7TwAnRSTe5OCMMTPKs9YfLZdTnT7Cpm3uqPZh
         oYJO0/sPe3smDKyLxFeIxTnfKMjaxvltVu9NhBCHtI7LOlKffHmJmrv8mXK+6XGtvZum
         i0wQ==
X-Forwarded-Encrypted: i=1; AKwUvBxAVPDIGbpyn5/wEAyPV90ZRXSaVkjGjRtULBDmoZqVVaWHOPTARUjeh7z/hkbivWI/8lagQM+SmGk=@vger.kernel.org
X-Gm-Message-State: AFuF++k/U3yLglSGXbDZWhZANltDIAXkbQ1aXpJJpWeuRjTWD9alqcA1
	rzDDKTdoN3I67+0IF1d+ZbtpAQm8p6R6V5eHdwzoiy0Ke2HiZTu0drRl
X-Gm-Gg: AYBFou2eAWftgrEJO/5Vj7j17hq/0uzObPgQeqTZjep8dkyyJ7Sf+WwPawaX3Da58sA
	uXIbEvXTkBGzRrBAh2X3COWbHyOyEg/rwdPyZ0l9czagbSk7gPH6HlM5xlXsRrYCdR9R7n1kEAy
	QYOWoHD0Uvcbh0F3u0ffJ1agDMd0oM4m3FQAmrQBZ4NhDstrQSkSZ++1V4UsI8RIJRL91USd0Q1
	HfDd4RPQt17a912l9o01jXCKXpNmd3JUWzj1Bo1QHSiKvouYulruBLsif6xaUhCE71guSacUnFb
	6nYs0rxkj+nj45ubf9gHkas8jYAXCeBFoaOY1kasrV2IeOehVBufMu4BgfS+7h4s3ykk1frw8y+
	fnzL+A45PG4XfJEYMlHuMSGNB/QTo5o9y10PXVtPZfI7xILeDaoP24Xojf3CCJ50KSHt7N4DUiw
	6SK3XcGNOCIKGodJSQdwtwOZmPNhOp+dPzGqrJGF+EjRkfK0DHfU4R0xlMA1mmZnDh1XFZmoh/B
	KN//0NlTc0yEp9ddKIkvfWW4y4ENMDl3OW4mij4qqp+eW6c/SyE9QEv7VtxpRpF63RLt0dTJLjE
	I7mt142cItHJqDN4ncLzQfw4GUgqMOIv6S43aBfOqSibudWM88zWvYUt56MMRuf6DFTm2HYEyIO
	qYgsZMADNIC36tWmBi6LScSgPVWhQri8=
X-Received: by 2002:a05:600c:1391:b0:49d:272d:74b4 with SMTP id 5b1f17b1804b1-49fc566e5ebmr66465085e9.2.1789810787947;
        Sat, 19 Sep 2026 02:39:47 -0700 (PDT)
Received: from systembl0wer ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd0ece6esm83417145e9.2.2026.09.19.02.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 02:39:47 -0700 (PDT)
Date: Sat, 19 Sep 2026 11:39:45 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: "Ivan A. Melnikov" <iv@altlinux.org>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Francesco Lavra <flavra@baylibre.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: tools: Use proper macro to detect _Float16 support
Message-ID: <20260919113945.2bee973b@systembl0wer>
In-Reply-To: <20260918161305.1161852-1-iv@altlinux.org>
References: <20260918161305.1161852-1-iv@altlinux.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Sep 2026 20:13:02 +0400
"Ivan A. Melnikov" <iv@altlinux.org> wrote:

> __FLT16_MAX__ is an internal compiler macro. GCC defines it if
> _Float16 is supported by the target in general, but the support
> may depend on the exact target options. For example, on i586
> without -msse2 I get the following error from GCC15:
> 
>   iio_generic_buffer.c: In function 'print2byte':
>   iio_generic_buffer.c:141:17: error: invalid conversion from type '_Float16' without option '-msse2'
>     141 |                 printf("%05f ", ((float)converter.f + info->offset) * info->scale);
>         |                 ^~~~~~
> 
> To fix that, use the public macro without double underscores.
> 
> Fixes: cdd445d4b2a9 ("iio: tools: Add support for floating-point types in buffer scan elements")
> Signed-off-by: Ivan A. Melnikov <iv@altlinux.org>
> ---
>  tools/iio/iio_generic_buffer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/iio/iio_generic_buffer.c b/tools/iio/iio_generic_buffer.c
> index 000193612aad..9ea93984e0e9 100644
> --- a/tools/iio/iio_generic_buffer.c
> +++ b/tools/iio/iio_generic_buffer.c
> @@ -131,7 +131,7 @@ static void print2byte(uint16_t input, struct iio_channel_info *info)
>  		printf("%05f ", ((float)input + info->offset) * info->scale);
>  		break;
>  	case 'f': {
> -#if defined(__FLT16_MAX__)
> +#if defined(FLT16_MAX)
>  		union {
>  			uint16_t u;
>  			_Float16 f;

One Sashiko issue:

Does this unintentionally disable _Float16 support for all architectures?

Since the tools build environment uses gnu11 compilation flags without
explicitly defining __STDC_WANT_IEC_60559_TYPES_EXT__, FLT16_MAX is
undefined across all architectures. This causes the preprocessor to skip
this block entirely, causing the tool to always print 
<unsupported 2-byte float> for 16-bit float data, even on platforms where 
native support previously worked.

If FLT16_MAX were actually defined, the compiler would still parse the
_Float16 block and throw the same missing -msse2 compilation error mentioned
in the commit message. Is there an alternative way to check for hardware
support without completely disabling the feature?

-- 
Kind regards,
Joshua Crofts
