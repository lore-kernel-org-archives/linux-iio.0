Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89363C945B
	for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2026 13:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777296494; cv=none; b=AwGkvRQ8p/WK7jShJj0v37oyj7d5XyHnTfLHg6odHkd9wFCQ7Lv76AxwqP4eXujOB6KmHh8nIPUYWheZ9fcwzICbHtstVpnBIuOdpUuD+uyyxklaf4Hx4fTBH0pzbXPeMnKdMj1G2RVxCA71N/Vwe0lvy4XYrFi0hfRmXe40CHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777296494; c=relaxed/simple;
	bh=RawA8kFKlVgoCnSWNrA4L/zBnsZKcbnP0MwwWabTrcY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=km3X2y/GTzVRmwaUA7hNFOQ1/hiX1umu7LvslJ3C4lEhk80itG+t7DnSDkhY3nLPLKKNZ4I6v76efkghqtzM0l4UdGZPB0aHbnruuWkuCiabnAdDGY0gIPhfx0X2cWB+rpud3skeqHAWwlLBxXwKvk8j+xudABFYKr1x7rYA7+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BRnw5pQt; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BRnw5pQt"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4891cd41959so85546795e9.3
        for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2026 06:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777296489; x=1777901289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H3HsbDChDqMa8EYV88ugt2cCnK15VruQ+CLu8vbEo/A=;
        b=BRnw5pQty6CawsYF7Uf3ZiQlqzoxcNzF5o+8+UFWWTk3ufWIDHgbz9M1Ql/AropEAq
         fwHCtnwvJOjvl4Dwqw07I6IQdHywvUa9MJjo0zP7MeN7PnYIunm5w3k/xQ9rc0yIuBin
         mR33VlJDK+UiGg13XT0qpBSGugHZIlCThYnvwpY8Nk6euKTDEIDcwTk8ONHatcNjY9G8
         SHJs5cn8na+yJEbsWOPeG+m6tlUQJgDGE2KGa3c1RjUAav9UV7qyJTG5ZxZqYe7UH/KS
         X2EqrlDBbVbLLpRupHwg0OU21tNhpF/6L27Es9HNvPHq4++51aoARep4SerGQEH9HTzT
         hFvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777296489; x=1777901289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H3HsbDChDqMa8EYV88ugt2cCnK15VruQ+CLu8vbEo/A=;
        b=eUFQJel80r7Uk6qRBm6xDfn9Mjus/vHljmndUWi3dGdKl8wedkXC8SkIzLEnEgWOrT
         2zR38tbs9phGWH+B0F2piF1XK53o25oiHlLXFJJPrUxdRhl5eVzhrwGeXhSGGykB4LOh
         k1othiTOD4BabpAfKnbzgRzhOWUslnA0OrPkrD82X49Zwn2531nlA2o59GPcJM+0c5i0
         Bz0LjUv+LdnRkH0C1YB02iRzIW0QNO0pxhv98RdrkF64h/r5eUZtrZMd4aS7ml0mC3V2
         5GyEpEtMslLa87akwGc1yGhPlSjxUmlExWddySxcN9hlyzuEo5364bQblaWmAdCZ/Xqi
         /8eQ==
X-Forwarded-Encrypted: i=1; AFNElJ9AjBTgc4dt9037IJDV0EPKuopIVv29BLgaZSg0pmoHBBDd0Keo0miuaWUfcEJF+4O79gKMR5WyG28=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCZchLSwQ0n0hRxYMcn1JfeEAVsuGwkrOp79qstzO553tkg6b1
	x0z6f5bgwuv2V5xUH8IvEUEIu8AKxBIoy1rYzV/PPN+phqPgzrXQxdbT
X-Gm-Gg: AeBDieuOWhuhmGkpH8OZTrpqEq+5GgfKiv1ZiMfovfGH1JFDLAmvkt9dvJz+kk9ozTE
	LgtNojg09pnb9uMI/HfDxuzW6Hfw8buJJzZPzoCWaY6KdqSq4YA33YypcdL0MHc6nAXMT4h24yw
	pRKU+mu2fdBx/zQKEyc+cMjTKYyHJxC6nolmm/f+Kcr6tDrQhFJPpm888XZsEMbLGJoHndCdc81
	E1efgZEMR6Xobam9CJrD8UlCY3xJ0h8uIqU2mNZ9ywB4eMBb9/+VVZGyFogOkiHq5mOQnue/cEj
	CctpuL7iLgOTlmkzQXRf8oMq1Ovzq+7Z1LTDvxIboaJpgYpvORB78NCunw+teCFjkmfWzmdOBR2
	novbt9v4u6YIsm3gb91JcI6WU9fnIcZRgkNb1BsIoMI8kBlw3yZliSyN7dllnWQqbNi3sCtKS1n
	z3BGQ8inKhAIUEurfnp0AHpU+bkaFh0VA+bK5/Pa3pGloDn/YoOfdjYFwhGhpuKnZv79exIKo6Y
	0E=
X-Received: by 2002:a05:600c:c4ab:b0:487:1fb4:7e1 with SMTP id 5b1f17b1804b1-488fb7864c3mr618921975e9.22.1777296488405;
        Mon, 27 Apr 2026 06:28:08 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc1393f5sm734762885e9.9.2026.04.27.06.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 06:28:08 -0700 (PDT)
Date: Mon, 27 Apr 2026 14:28:06 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Cc: antoniu.miclaus@analog.com, lars@metafoo.de,
 Michael.Hennerich@analog.com, jic23@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2] iio: adc: ad7625: fix type mismatch in clamp() macro
Message-ID: <20260427142806.58140ed6@pumpkin>
In-Reply-To: <20260425071615.20406-2-giorgitchankvetadze1997@gmail.com>
References: <20260425071615.20406-2-giorgitchankvetadze1997@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 25 Apr 2026 11:16:16 +0400
Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com> wrote:

> clamp() expects compatible operand types. The period calculation uses
> nanosecond constants, while the local target variable was narrower than
> the upper bound expression.

All the variables and values look to be valid for unsigned comparisons.
So what are you trying to fix?

> 
> Make target unsigned long and use unsigned long bounds, including
> NSEC_PER_USEC for the upper limit. This keeps the operands naturally
> aligned without adding casts.

Changing 'u32' to 'unsigned long' shouldn't make any difference.
The code (probably) has to run on 32bit cpu where both are 32bits.

The upper limit is on 10000 (regardless of how you define it)
so it always fits in u32 (or even u16 - but don't go there).

Indeed NSEC_PER_SEC is less than INT_MAX, so dividing it by anything
gives a value that fits in u32.

So exactly what are you trying to fix?

	David

> 
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
> ---
> Changes in v2:
>  - Make target unsigned long and use unsigned long clamp bounds.
>  - Use NSEC_PER_USEC for the upper bound.
>  - Avoid casts, as suggested by Andy.
> 
>  drivers/iio/adc/ad7625.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7625.c b/drivers/iio/adc/ad7625.c
> index 0466c0c7eae4..b5a7911c75df 100644
> --- a/drivers/iio/adc/ad7625.c
> +++ b/drivers/iio/adc/ad7625.c
> @@ -175,12 +175,12 @@ enum ad7960_mode {
>  
>  static int ad7625_set_sampling_freq(struct ad7625_state *st, u32 freq)
>  {
> -	u32 target;
> +	unsigned long target;
>  	struct pwm_waveform clk_gate_wf = { }, cnv_wf = { };
>  	int ret;
>  
>  	target = DIV_ROUND_UP(NSEC_PER_SEC, freq);
> -	cnv_wf.period_length_ns = clamp(target, 100, 10 * KILO);
> +	cnv_wf.period_length_ns = clamp(target, 100UL, 10UL * NSEC_PER_USEC);
>  
>  	/*
>  	 * Use the maximum conversion time t_CNVH from the datasheet as

