Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EC447ECDD
	for <linux-iio@vger.kernel.org>; Wed, 22 Jul 2026 08:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784709981; cv=none; b=HSv34Z8Z1apFZo5T0DKjwwxDjnt85NDKfyb+o/V8D03ddQ+gCh99nF2ZoEwJ6zmJk+RyMn9IUtuiasD8lhr4kuGF51c/u2vDR8AyhnbdoMkKQvDuZm2SG3L5KlVBXzzwoPDOU6S41zAkc6Bd1P+J5BVSVwL0U6sVBL6UUKZfZ1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784709981; c=relaxed/simple;
	bh=52I+FqtPSlac7Up26ZcTnxLn+KCNGyoMvIJjZotH8VM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QBGrYsOp3qX2udJ0F2VJULKudniDowkBmO0I4OiiYEb4lcEah1ArDoIBJIywc1shzetGa88RLTnTsFCmKMY5mqMtNmVRTmehb1hg7q2vzwyfWYDpf5BqaEGsPXO9mcJqB4lWES91mbUSUyvDyKotEmIS2VETTfT+h8PkQ4H1IyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gWLBoGdC; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gWLBoGdC"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-47f707e5d75so2276188f8f.1
        for <linux-iio@vger.kernel.org>; Wed, 22 Jul 2026 01:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784709979; x=1785314779; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QWQplWHzIYiB9ra/DxAbtBKO9FD01YAgyf90olLpA8U=;
        b=gWLBoGdCplx5We8AhMqSU+/iLm8o6nrZmgYTCKK/b+GS4G2ASqIESWh/ESOkvIVUTi
         5BImqglxxhOLOIsmaoNXxn57UDRzBvJSCnwEu5trrE216BJQlwl0vqp0Kky8vaxJW4Tx
         XbtakwM7NMYnAuIG0sLTEcRhbl7axKw7MCzBkaR9cWY7xGm6+xkOtGT3NHz5qNk9OAzs
         vzEIcxOInE0JeGTgWGHqqA05kFGvdx6f3JqDxBPe38Y7/mPe6xkJq0heVa3qnpEjl6i/
         EwCDUCNgiT94HeNto6GlCo+MnBBJjkXpMdQAfSw57l3fIjEGCefnfOxj3dMb9fC3y0Ym
         RSAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784709979; x=1785314779;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QWQplWHzIYiB9ra/DxAbtBKO9FD01YAgyf90olLpA8U=;
        b=ejNuYI0JN1XHD2tV75bXcweN+4VOOj/HB/s9ac3fO9aHS4lY29Z8uIbwM3O3T3KKFL
         Wm2dzUiz9WkYY1Cv4EEALFs2B+DXTBlqjsRLs/f/4WgzoKBN89eSmFwh6WbnoWbfTb8Y
         IEZkoi3NWmwXCbRY+djCntkWahmv3PQnlU+RBuIBdJLBBVMek06lSTEh+C03d41KqTNZ
         ClNEEW2LCxkL1KM1342HtccMJTpM1w5O6oO2qBWEftXJfsJGDtzBDOPwK3xFjIIB5LMt
         xxriE2BHxiZXJL4TJLWEgthapvUgEAcVLYdi4KRbSCkoxasOI9jm73JJ4GKSdQon0vtU
         TcZA==
X-Forwarded-Encrypted: i=1; AHgh+Rr7hFriP7MOjgSj/25ejGB8mT/9SGJzIBEgvanJmj/Pp4rB/9ZO2UZLvw9eBu+OmhFb4Hn9L4Manww=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzGV9XmxRdq4T/1BHZAuOvQYTUbjyXZZA5/EoLMFj2lC3NUkMV
	burZhBO0PAMiZPiM+rSO+EyL6MkPaB0zR/1Bn9goyk52vWeZgqDD8IMf
X-Gm-Gg: AR+sD13uTPcOzsHPRfdbceh0zhQra00bDbNm7uyEhhzaOcc2UFwBk+141vBqOlyElKx
	7BK7IxOwxdcle8PKOUj0OKYY9klDpeLk0a9vayJ+4PMxKg1WiEjowhjcGyFsPzc4sLnan5vf/yL
	vSAYpO5xhxaH5y0xk0nPNE0dNMSsqEZaSYShcVwjNMK5nVttBIfgAaXGAgib6fT0W7OLFy9gBiX
	dkaIgxYIxxJYbGC2TQ3u6l+9hccjJZXdCmhJ+mcF3U/EMR6oSq5Jzazv+gw5+lKzWlwK+wce1tH
	uiOzW/tZfgRmRH3fSh64O4c7Qs6wDUzBXZf6WkacJoC6b3qA38Ht4Kxn/NzwdlfjznO7KCeXjOX
	AeKJCa5kWCIu/hBjch4C65uy21pLpJ7aXqduVJljYI07v3t2kcMqQzJq6mGtY4hVnAzq72yN1W0
	/GxjE94WQ8DmK87pojiETtiiE3ksFKS7aDePtTgkmpAS7TPQSJfWCLN5UKVl4I93wAg+Kh/BlTp
	ToKcy81DiDIKY/wFR59tuT17Tl4BudfKyDYMeZlGNNqYqSa8Qr0MJswCRzXypL2AkDVjeDR2M7A
	FjuDB0SBEh+L5zC5wRsmlbrdL9EimiOwzt54VHk9PWSVCCHax20eU3Rk/ZmfsGtJENH6k78Nxqr
	7Um9ejWjr1PtG
X-Received: by 2002:a05:600c:2049:b0:495:6397:14b1 with SMTP id 5b1f17b1804b1-495639714bfmr87077095e9.34.1784709978460;
        Wed, 22 Jul 2026 01:46:18 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-495653c9d99sm133607895e9.12.2026.07.22.01.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 01:46:18 -0700 (PDT)
Date: Wed, 22 Jul 2026 10:46:17 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, andy@kernel.org,
 nuno.sa@analog.com, gregkh@linuxfoundation.org, skhan@linuxfoundation.org,
 me@brighamcampbell.com, jkoolstra@xs4all.nl, linux-iio@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, Andy
 Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v2] staging: iio: frequency: ad9832/ad9834: add comment
 explaining do_div usage
Message-ID: <20260722104617.000050fa@gmail.com>
In-Reply-To: <20260722082227.18768-1-raizudeen.kerneldev@gmail.com>
References: <20260630032322.5805-1-raizudeen.kerneldev@gmail.com>
	<20260722082227.18768-1-raizudeen.kerneldev@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Jul 2026 13:52:27 +0530
Mohamad Raizudeen <raizudeen.kerneldev@gmail.com> wrote:
> Previous attempts to change do_div() to div64_ul() were rejected because
> mclk will always fit within 32 bits for this hardware, making do_div()
> safe to use.
> 
> However, Coccinelle continues to flag this as a false positive. To
> prevent future developers from submitting unnecessary fixes, add a
> comment explaining why do_div() is intentionally kept.
> 
> Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
> ---

Please don't send a new version as a reply to the previous version,
as it can break tooling such as b4 for patch review.

As for the comment, I think it's good, however I'm not sure whether
this should be split into two patches, given that this is a small
change. Andy, what do you think?

> diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
> index 60c33e10c46f..6d046e9121e2 100644
> --- a/drivers/staging/iio/frequency/ad9832.c
> +++ b/drivers/staging/iio/frequency/ad9832.c
> @@ -118,6 +118,13 @@ static unsigned long ad9832_calc_freqreg(unsigned long mclk, unsigned long fout)
>  {
>  	u64 freqreg = (u64)fout << AD9832_FREQ_BITS;
>  
> +       /*
> +	* mclk is an unsigned long, which triggers a Coccinelle false positive
> +	* warning about using do_div() for 64-by-32 division. However, mclk
> +	* for this hardware will always fit within 32 bits, so do_div() is
> +	* safe to use here.
> +	*/
> +

Unnecessary blank line here, you want to couple the comment with the
line that it's describing.

>  	do_div(freqreg, mclk);
>  	return freqreg;
>  }
> diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
> index 33dfd723923c..8722f3a01cde 100644
> --- a/drivers/staging/iio/frequency/ad9834.c
> +++ b/drivers/staging/iio/frequency/ad9834.c
> @@ -103,6 +103,13 @@ static unsigned int ad9834_calc_freqreg(unsigned long mclk, unsigned long fout)
>  {
>  	unsigned long long freqreg = (u64)fout * (u64)BIT(AD9834_FREQ_BITS);
>  
> +       /*
> +	* mclk is an unsigned long, which triggers a Coccinelle false positive
> +	* warning about using do_div() for 64-by-32 division. However, mclk
> +	* for this hardware will always fit within 32 bits, so do_div() is
> +	* safe to use here.
> +	*/
> +

Ditto.

>  	do_div(freqreg, mclk);
>  	return freqreg;
>  }



-- 
Kind regards,
Joshua Crofts
