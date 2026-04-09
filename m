Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE393368B2
	for <linux-iio@vger.kernel.org>; Thu,  9 Apr 2026 17:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775755681; cv=none; b=XpshCcDLRMAcfm9sJRatUGBMw7nb39QLc3FjNs1BzCs9pmaI1iWwU0YFWZvLJSfsEbipgMJtqbbutDCQc3IlxFu6PVrb5XPfJK4/qEeYDku86OuSxXVDV1xXakbZKY3kW4oO1lEUQcqwc3eiC41BprQC2RANCOG2hFgMBtHwxJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775755681; c=relaxed/simple;
	bh=Xj16wV6V2Sno6eWwvBPH3/NEusVgaroJmp/zJ27wEdc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rWxhqB72Vc2qcSzqACDNkfdb1mcvqCl6Dyy6am3u43t8t2zD1ITtSJRukU0o9nBv79ZqwEYncGk61HWOoyo7QO5Q1z3TIHrFTeIsvM4mn9oJieaf62ZQD1P/FK0iI+hIZv0KoqCZdcBbBwPta+Vd4THspVcgkpq6+kgYpB7n/6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K2+UBS/q; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K2+UBS/q"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4852a9c6309so11249305e9.0
        for <linux-iio@vger.kernel.org>; Thu, 09 Apr 2026 10:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775755679; x=1776360479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=budwIyBidm2S9h+Ojfca4wDAEHhJaK900JgD39+1wwQ=;
        b=K2+UBS/q+WKUd6E5ctRJowgArIqNhDQUyiOk2qTPCgjvoG7t+N36n/kEb1oKE5KpWI
         htBfTIW8uG5itiW2Z82ww11ABChY8TphdUpOlKborzhWr+KbO96koRo9A3b0WMGzfJmR
         nn8B9rDNu/kwfNmSFJRsAvQy+aPHgXH6ArheCWVHzBKKoduFOw6t17vn3k1XC6s/lynu
         +atzMtLuIhFv72QSLIRSiPlsZqJ8L0L2SMnFCE0gnPWwRdr6oiD8TiLtlrugOal93Pjd
         OOAwNGUHKx/ddiy2a5qje8qCwVWpG9QvV2RJx0s1skr1DPy7LIpubyQEkmzuDcUNz4bB
         KuBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775755679; x=1776360479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=budwIyBidm2S9h+Ojfca4wDAEHhJaK900JgD39+1wwQ=;
        b=NdK8Hw0HnxAwArMdO37a5RdoFGmiNEkQqD7BYHlo8m6UdKUjdF3q5QN3HWl52M6jrH
         W17bbSOAadB4g4YqjzBjlzCX5ae31BmsxvbxtFSSjmcYHSqBtdeCznGQEtRXEcU4RrE0
         RNtVb16qlV2NkDsBHqGGJCfEa+cfbcO37ML4znXi+ADsZcNWQDzTgB/8huR4Q4xU0VDl
         X0MFdu1KzkdrFeBMamScYE7B25mA8dmRReD/7qarmPUOiD8SD/5se2eC7mJM727ZXeqP
         DbjzcWQY7H4p2yk3ueIyNIYaHImv7LFVovdIXZMCx6ygHQlkVsrR6cNOXqqPEoxdSUy6
         YhAg==
X-Forwarded-Encrypted: i=1; AJvYcCVmgq+SysMmPBnxBPeOvfUiDpAJMW0watvR+RsfVfNQ8lAa00xQWrLOs61sI3p3wHIpRg6GoIxv8ZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxOW6d1XLfaUVhOpC9CrRr6zZeCvJhbnnI2xYL/pRtsco9AHoe
	KKRuBQBc2t2+eIEj9pKLhp50Q4lM9BujHsFZI2PxCyEpWQ92vsORooPn
X-Gm-Gg: AeBDieutTleP525K1SjT5S9qpNHTnsDUi6g+6frGBVbUAL33e/1YifV8fsfekUuNLCX
	zbDGO65z5J8g5veskuBF6paLLVo4C5/6JzsjPXYr29swepeMMGbw9oVg6f5gSun7dSDWvwfaV7d
	1SNK34rV9CaqO9aIBQXdan38PN/WGjs/nmUmN6gJ2S+n1a3aVU7KSabufgVMF/nLCuL+c37Lrfw
	/Se60rNqVk56SUJR4xFkPAz+ffSXySuOJ/evn8n+AkJcy8Rxz9QxNRW066iDyJMXw8aJTfMBZlw
	P7vwKdDQ4PScejQzBGCRskiKyKrwCt1HuNHAS4dxxrPVBI+d+m5MGowbPbnBJ7EGN/wy4w9/0vk
	1BI6dpJsAgqHs0Llr3wjlE4jRZrGpVm2pBSEqDPan+XiDqMyHRAIbXXz+n9X5CtSWssrJdmXdLy
	VOFi0jNAnY6O6pZFJ80dfs/JbbIsF9mbiX3dGHO3k4JFfaXEMZGIpFBtFToJBWUQM/
X-Received: by 2002:a05:600c:c083:b0:487:1108:48b8 with SMTP id 5b1f17b1804b1-488ccf4062fmr45114025e9.2.1775755678580;
        Thu, 09 Apr 2026 10:27:58 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d532ed4dsm10576585e9.4.2026.04.09.10.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 10:27:58 -0700 (PDT)
Date: Thu, 9 Apr 2026 18:27:55 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
 greghk@linuxfoundation.org, dlechner@baylibre.com, nono.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-staging@lists.linux.dev
Subject: Re: [PATCH] iio: frequency: ad983x: replace do_div() with
 div64_ul().
Message-ID: <20260409182755.499a419c@pumpkin>
In-Reply-To: <20260409131823.1289-1-joshua.crofts1@gmail.com>
References: <20260409131823.1289-1-joshua.crofts1@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  9 Apr 2026 13:18:23 +0000
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> Coccinelle reported the following in both ad983x drivers:
> do_div() does a 64-by-32 division, please consider using
> div64_ul instead.
> 
> Fix this by replacing do_div() with div64_ul(), which
> safely handles 64-bit dividends and unsigned long
> divisors across all architectures.

Except here you have clock frequencies.
Either they fit in 32bits or they don't.
So the value shouldn't be 'unsigned long', but either u32 or u64.

You need to check the domain of the values, coccinelle is just looking
at the types.
Even with mclk being 'unsigned long' the code is fine provided the
frequency is below 4.2GHz.

So you are probably fixing nothing.

	David

> 
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> ---
>  drivers/staging/iio/frequency/ad9832.c | 3 ++-
>  drivers/staging/iio/frequency/ad9834.c | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
> index b87ea1781b..61ee93263a 100644
> --- a/drivers/staging/iio/frequency/ad9832.c
> +++ b/drivers/staging/iio/frequency/ad9832.c
> @@ -13,6 +13,7 @@
>  #include <linux/device.h>
>  #include <linux/err.h>
>  #include <linux/kernel.h>
> +#include <linux/math64.h>
>  #include <linux/module.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/slab.h>
> @@ -115,7 +116,7 @@ static unsigned long ad9832_calc_freqreg(unsigned long mclk, unsigned long fout)
>  {
>  	unsigned long long freqreg = (u64)fout *
>  				     (u64)((u64)1L << AD9832_FREQ_BITS);
> -	do_div(freqreg, mclk);
> +	freqreg = div64_ul(freqreg, mclk);
>  	return freqreg;
>  }
>  
> diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
> index d339d5e8e0..83d0e1360c 100644
> --- a/drivers/staging/iio/frequency/ad9834.c
> +++ b/drivers/staging/iio/frequency/ad9834.c
> @@ -10,6 +10,7 @@
>  #include <linux/workqueue.h>
>  #include <linux/device.h>
>  #include <linux/kernel.h>
> +#include <linux/math64.h>
>  #include <linux/slab.h>
>  #include <linux/sysfs.h>
>  #include <linux/list.h>
> @@ -101,7 +102,7 @@ static unsigned int ad9834_calc_freqreg(unsigned long mclk, unsigned long fout)
>  {
>  	unsigned long long freqreg = (u64)fout * (u64)BIT(AD9834_FREQ_BITS);
>  
> -	do_div(freqreg, mclk);
> +	freqreg = div64_ul(freqreg, mclk);
>  	return freqreg;
>  }
>  

