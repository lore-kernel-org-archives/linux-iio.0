Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A243E1693
	for <linux-iio@vger.kernel.org>; Thu, 25 Jun 2026 12:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782391415; cv=none; b=FYn9wt7k7sp4AATQlXReYJL4f4lwlu4fJ0KVfCaNnuAz6yEyxEDcqVe2nUneicSG91pwh7cvHvu4gd31ycQq9k4mPUwmR3KzUm2gkOwfcShJX3VMzFdQWQpsMwerIi7V5mpu+gO2sKDIAs2oni9Sh7885ZhTRcrG4AWW6fzeja0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782391415; c=relaxed/simple;
	bh=jdpmD6iVy3FAIMitjzPlLAWE1W7zO//hEsmY+/wCHto=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=duIaRjAAKzPrPftYW73mRms/7ZYpqOCDoxxIdr01sz6QAB/qCmKnMaDddSUQt1eqo9q7WqLhBJCNgvRTi98lHmg03llF3s1Af9QvRfJCgWqCfgwQnRySexiMZYU4DkmqoCCoCNSZIriRFDb6R7d3zZ1BhOfHHiOUDv3ppDg94jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hxrFOPME; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hxrFOPME"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-46cdc80779bso1482371f8f.1
        for <linux-iio@vger.kernel.org>; Thu, 25 Jun 2026 05:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782391413; x=1782996213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a66eo69NOE+n4s902wAJueSdPmo/jdek0/gyrvoE+0k=;
        b=hxrFOPMEdBnXaEvXcXlNAxMjnD/2oe+/Z42cyy6WdtoC2B1k+K3KgOpgIHPBPlp8W/
         uOQFMJCRiGfCGykNsa8yEnBu3jBY6CNvafEG3JPksrAdgQFnyu2ZdGd+e4ogLuyhtDsh
         B2uL2WT9C25YPxd0r43Piy7dTIPCGsdVA3D+KRi1xJdo/CH0mjv9dmGlcQIwH8Q/et5R
         /iT8leUoQsvgl75T3vRnMrwcy4yMiarLwI1cwWZMCtGP6nEeHPyQMOl6wjpSsGsBMjjb
         ybTUI+Zoh9wLodNhz6Pb2CznDdydrgkbGPGvBJK+Wach+D1DhTKqu77zq+4zn/6rT9IT
         rR4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782391413; x=1782996213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a66eo69NOE+n4s902wAJueSdPmo/jdek0/gyrvoE+0k=;
        b=DjP+t7pG03FaRO4ht+4l0Wit5jCsW504tmqpBdR+MGdX8TVRd7k+nEDJEgqGZTi2g8
         l+AkEgfbeyhr3R6BWNky8KwVAT1gp2KdpKizeWjq6E1GwmEDXQJj5NTqc1PnYO8Eg+Ex
         a2+9dpEkytaW9IPIIEijgTA15zRav1mumKiNaz6jwDC6N9YEyVc1HWLHa+VTSPsYOqmt
         OlZdk8eGCwoWW+VGVvhwOnzbCq7kvg2G2VzaCNBha4Qpj6sImZbcrMFaaoPMbLKf9+cA
         03qr4qYTg9QzZL8JGQNU1F8EPi/lHC6eyJ4qPyTyEoYGLAY1TBIm4IEJwUOunluBWADR
         u4Tg==
X-Forwarded-Encrypted: i=1; AHgh+RqtUQj7PfBH30v/S/LRH76or8uwefJCjexyLCSz07pDZBWC/8d9dh5ozxQ3xU1jDfXKd1PblLFXavw=@vger.kernel.org
X-Gm-Message-State: AOJu0YziOBEaBLHWLFh8dRRETZAu45H5JnRSABYG0dvkUo0jah7cragD
	YeKxgi0FXTqJnUq2xqZiuDjZtn5n+dr6QAiraaVopK/zqR8aoGOvvNdn
X-Gm-Gg: AfdE7ckSHvNBjfKxV7YlMv3Cq/i2LwMpbrMEdjoi97aJPClYIWFO1c2YhnTEgbtTvzq
	p698tT8fTlFm8Xkss0vq+gL8opHPjbucc9CeUajn6cXnd9aqI1JHn2CSK6HNLnUqVgGkTDEvo9z
	gnwpj4mha7SYe5yrLSRxyt/kLbzLM1sAqmW9VyfdZkpICQjKuNV/ZdJZkXL/9KXpD3IVJbzEAE5
	n/iVltrQ8Y7oTd3CFjwQl5HszUC7nj4epzo8lyPTS5Wm13kx5+aJzCrBmFooJzgO0iFO7KfEoYa
	MiKdgaeGXyi8D51rupfFP5aN8/owLURtlAcmwxkcrBDELYV7ewFxr6nCluECDNHKZqZmxemRtmY
	8hVu/jtCG1E2vwrJ0zayIGi0V2xu0XiiUSfEW/gLIcPwhU2cc412JSnInL0SpoL2cg9HqB7pxJi
	vgOv/5CSPoPYUHOUKWqo8EhWxgfKyhcJsfFb+9GjYDB3N5c97fRKr8Ck/gq0g85WiaFhBdZLs7k
	8w7KOMX+d6XHohraBl5wkgw7uoTRIzIF/BQUNCcsoo8hA+NhprQQdGWbBEkDbq03swHYdLPM8Ce
	cyDTw3WSkGoh6BnkNofnoaDyq2b8642x5l2Sk4hNDGxnTb6jB8cSptOp+cYoZSzFVw==
X-Received: by 2002:a5d:5e8e:0:b0:46e:1225:1e0a with SMTP id ffacd0b85a97d-46e12251e76mr2637554f8f.37.1782391412492;
        Thu, 25 Jun 2026 05:43:32 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c1ee01d46sm14905648f8f.13.2026.06.25.05.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 05:43:32 -0700 (PDT)
Date: Thu, 25 Jun 2026 14:43:30 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Batu Ada Tutkun <batuadatutkun@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, linux-iio@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: frequency: ad9834: use guard() for mutex
 locking
Message-ID: <20260625144330.00005231@gmail.com>
In-Reply-To: <20260625120456.1267-1-batuadatutkun@gmail.com>
References: <20260625120456.1267-1-batuadatutkun@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Jun 2026 15:04:55 +0300
Batu Ada Tutkun <batuadatutkun@gmail.com> wrote:
> @@ -17,6 +17,7 @@
>  #include <linux/regulator/consumer.h>
>  #include <linux/err.h>
>  #include <linux/module.h>
> +#include <linux/mutex.h>
>  #include <asm/div64.h>

You're definitely developing against an old tree - this won't
apply cleanly :( Please update your branch.

>  #include <linux/iio/iio.h>
> @@ -152,7 +153,7 @@ static ssize_t ad9834_write(struct device *dev,
>  	if (ret)
>  		return ret;
>  
> -	mutex_lock(&st->lock);
> +	guard(mutex)(&st->lock);

Blank line here.

>  	switch ((u32)this_attr->address) {

-- 
Kind regards

CJD
