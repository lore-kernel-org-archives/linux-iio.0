Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9712C21EE
	for <linux-iio@vger.kernel.org>; Thu,  2 Jul 2026 11:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782993272; cv=none; b=MldxIA/lNpTRFC21QXyUPW0i8fbTKAo23b0Utd20EF34uD2cRSDrOxqGFEXqMnyjJ41rn7rklxXRvajQG2u15VCUrKvTKOzzwQfMXICllHLl41tz4c/D0J3LMS7eMemGEdXeSuEx7UcwHDjp6ohKP1+WMC0xR+Ik/HcP4k0IuVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782993272; c=relaxed/simple;
	bh=ZB7humf4olh9yUCGVXx9X8ijp+5GuYZk89PF6iqsHwo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fD65tDikLBJ1Di+do2O5xw6ocZFgYfv86GBf2kE+bLpv+wJDhTytML0maLP09aymBEISecumycFqBLmP7Aqrym+VrQLgp2SYnX8/M1XacrjgcPE2bncKAGPerCVJt8MwokXz3riibswNGVKqU/HfxmmPd2MhONO9RSHIKWgUJDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RIwCKJhO; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RIwCKJhO"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-470174001a0so1278026f8f.0
        for <linux-iio@vger.kernel.org>; Thu, 02 Jul 2026 04:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782993270; x=1783598070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=86pI1MrB+vm8HFIM8sZBjMOwPSJi0NDQhLHjF8XY2bU=;
        b=RIwCKJhOS8A62VeSaEPdCCaLESnkDAyQQ0B/WFb3kILO14i/y692grxUWVbDEyT8ho
         POl6HrNL/58+iZTnoTWsYrxx3uoPAnhLT8DI1VBBD0mF8k59YAW3zg4ilO6yllvwIjp6
         MF6jRdIdo5RSP7acN4yourW+sY6dcILScDKnr17TAERA+K9123BFDJgFVwWgyESdFMQW
         PEXJ09eox0wFaYVSfiFRlAS33b37/VuOjAhea09d/GP70VXJM2fEnckQc3hWguHtVMqW
         H3r+1lltnTeZP2L1aRO8lkFcTXLXE6AW7dRUnsRpaFlEbDGhFa5R1T8W+5hpDqfjvfFs
         9xAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782993270; x=1783598070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=86pI1MrB+vm8HFIM8sZBjMOwPSJi0NDQhLHjF8XY2bU=;
        b=jfxspBm50W3/UJ0RG3fX1f2QTsmuL2iTo72AA1L7DMmmyWeQYVHqCulKWLQEIHihRr
         utoz8oMVDnBj+C9dkIUDqvxdr4tAo05fjZjToEkvqlD/v3sgciQm+IG4up6gNfZrFcrT
         UuCal4M90kQOmJMLxpABBOqMQz5e5OM1Zt1UGpa2ehOgWylZr6p5CpQ69R/gqo972VUj
         ipjDeFwlfCtBu8rQoVSz6K/3Yt70NCW+Bgb1RYkRHycO8VcxX8s1X9pQ2v0t0wRsWvKK
         eHdZDm0PtWEmxtCQZYm4Yk+458yqqSQY/2EtPTzdmGyDWHYvrWXdN0AhsjiZKYOelhdq
         a9Fg==
X-Forwarded-Encrypted: i=1; AHgh+RpeDhxLr3SjNvGlFpbuHIr652Hst6v66aztD1t5IgRdAizKjItipBgoBL6gd7PguvQxOyM1IWx74po=@vger.kernel.org
X-Gm-Message-State: AOJu0YzS1+jKJ+5zuIxaSzS5k6BnvS5yy+1qAod6tCOoLifj+vb5KOvx
	EoTWiQfCWdeIcEb5Q1eZdZ7Je2AQwttvrdw+y/MgY944X8g2SuyPX3dp8R7Kow==
X-Gm-Gg: AfdE7cmI+oRtryY5WDk0li3G0Pl7SUJt7sjBOwmzG2HFuZ3uRKlR9tbq2D8JTLOGtve
	yV21LNUfO9eBPf9U7lrr+AZDAXzFXCZJu5o4d2DnP4pSAO7UFKsap4AlyKfTXuT5oPCRXQzVHlD
	2H6aX/AmNGPDe1WpJdAUwQNkZLb+RzPtBl37TbvknOM1ct8DM5mAaSBJKDMU9vP27R+FOJO/ULs
	iLq2f0nyRxnzEuZjII3AwZDha6Hu9mdxKVimGytEH9U7dxPpZWSGozDrjRcCHK+vAmd/gYJu+vJ
	HF6ZyGwuFe/KLnwgbWJiS7/kdemtUA86L3LsyUGjwvkLMdBJVeN+Y931OxdylxgK2DKG5Js2t5Q
	rfMoZLMtBcfnxFf5507Lvylq76j6DgoW0+Venx4YDaArn4TuhcgBEggto0KG2zn9dYyE57WQ/JP
	/GC2SzrgjRGfT4amn99ixjY7iLkW4UXLHGCPlGt9DWKLCdTamHC7VBZiTEqHSp/IPgavkOF5Hpa
	JpFgpdCl3AX9lyL3gvHU5w2U0IuLirbqVjGjocoWD9SH4Gmaph0j4RmLOtd/1kze6hK7ymALCCH
	DsO6tg4iRDKYn7BNJF1u3W8VKK4OGuwJE9ui/ODsky3WZfvZVa/sq/Y=
X-Received: by 2002:a5d:50ce:0:b0:475:f0f0:9ecd with SMTP id ffacd0b85a97d-477b5d37f88mr5680273f8f.56.1782993269663;
        Thu, 02 Jul 2026 04:54:29 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-477dd94cde8sm8963376f8f.22.2026.07.02.04.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 04:54:29 -0700 (PDT)
Date: Thu, 2 Jul 2026 13:54:28 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Moksh Panicker <mokshpanicker.7@gmail.com>
Cc: jic23@kernel.org, nuno.sa@analog.com, Michael.Hennerich@analog.com,
 dlechner@baylibre.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
Subject: Re: [PATCH v3 1/2] iio: adc: ad7779: Remove unused completion field
Message-ID: <20260702135428.000005dc@gmail.com>
In-Reply-To: <20260702114649.9758-2-mokshpanicker.7@gmail.com>
References: <20260702114649.9758-1-mokshpanicker.7@gmail.com>
	<20260702114649.9758-2-mokshpanicker.7@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  2 Jul 2026 11:46:48 +0000
Moksh Panicker <mokshpanicker.7@gmail.com> wrote:

> struct ad7779_state contains a completion field that is initialized
> in ad7779_setup_without_backend() but never waited on or signaled
> anywhere in the driver. Remove the dead code.
> 
> Suggested-by: Joshua Crofts <joshua.crofts1@gmail.com>
> Signed-off-by: Moksh Panicker <mokshpanicker.7@gmail.com>
> ---
>  drivers/iio/adc/ad7779.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7779.c b/drivers/iio/adc/ad7779.c
> index 695cc79e78da..c1a99b4c1256 100644
> --- a/drivers/iio/adc/ad7779.c
> +++ b/drivers/iio/adc/ad7779.c
> @@ -143,7 +143,6 @@ struct ad7779_state {
>  	const struct ad7779_chip_info *chip_info;
>  	struct clk *mclk;
>  	struct iio_trigger *trig;
> -	struct completion completion;
>  	unsigned int sampling_freq;
>  	enum ad7779_filter filter_enabled;
>  	struct iio_backend *back;
> @@ -852,7 +851,6 @@ static int ad7779_setup_without_backend(struct ad7779_state *st, struct iio_dev
>  
>  	indio_dev->trig = iio_trigger_get(st->trig);
>  
> -	init_completion(&st->completion);
>  

Remove the blank line here as well.

>  	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
>  					      &iio_pollfunc_store_time,



-- 
Kind regards

CJD
