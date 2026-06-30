Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0EC3B52F1
	for <linux-iio@vger.kernel.org>; Tue, 30 Jun 2026 07:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782805176; cv=none; b=kjVwTMZdRKxjI4RiYENo4jWICMBkz5hWYLi9JrNRVTh/I6xg99eiHCLetaAgKtKbJvAQGFcOA2dblooCs5U0UItkxuJxdsQGGMt0pwMNgbPU8ZdMjoKccezRv1Ub8okH5A7CuqxhfADWHMqdpSTpQTwbtRLI9McsOFzxnr23Yzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782805176; c=relaxed/simple;
	bh=x5lClJ+hHisus7sv+EdEVUAs07TB8Y5FSVG2Xgr71+8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JDMk38c6Kz5xoCaiZ7Roet3BZxMZif6WB9MzhYaTpOnDne73UOS1WHyZ2LZIIpH1HcrWZ0+CIRmwoQ40Z0ete2IIrijwl3bQWz4IUX3eMB3yQuqNcNMReP649DqxS17i3ATVeVxs+BWUiJU5eKhBn6ktSGS0riee30OcdRz6f20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=or/+htdc; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="or/+htdc"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4758bd3731bso226468f8f.0
        for <linux-iio@vger.kernel.org>; Tue, 30 Jun 2026 00:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782805174; x=1783409974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6f0a6CUBMW6wzjEw+k5eQBiq+eEykiLHNiQv7o3R41E=;
        b=or/+htdcSG2JvXTkq77P1IVFh00U61Ybeczs3l2KfpB/Q52IOIZpJP/RxNYX6SgNW9
         GCHD09XROf1mM55t+iyBzXV36IBUO/xOiBU8WU4+46lxgF3wWhJeByh87VDe3yNWy10/
         IyL7mEz2cUkgV3wChZeGac2YLaT2RQRw6seTQXqtRL9lly2WiODhrxvOd3o7LaT6b30v
         MlpW8dNCFvtHVsIlTPUII2uQNWS2AqS1RZHWnL6ajxPO5exZO1e8vSRCCd6at9EB9WJ4
         FrCNg4+hNZGWXqecd1GIfakUOhjq1uzMiKcDQR6ZnuZklbgn4HwVrT/uxpBlKzVNKSpG
         NWhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782805174; x=1783409974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6f0a6CUBMW6wzjEw+k5eQBiq+eEykiLHNiQv7o3R41E=;
        b=THMQmpwuCe5XtWeAeIZLP4H702IuBdGxV1eN8U47A5ZmvFb63DaLsAKzTTPsUKUhAd
         xTPZji9lBGLvcYsvR/osgUshidJv5u9WhXNQYZxft0rOMqIIW2Hl/hu6it2xMww5MHH1
         L7UcagRtUaa7yD02L8dlfRRWr1f2PcEEN2tVp6BuMNen1piXnHCh9Y+tyHW6jLGwPDfr
         KNPIbvmbb05PeX3xzOYP5S9HQ+w2aN4uEo/1XRj7fyFW8PSJ134n/o3ShfPlsSrSP0yM
         FlTXvodV9tBLhjHSnW3orR8NQQWJZfalGaWRyuZuPw0eLQhj8F0G6mfnwe5Un7rM0K2I
         RMEA==
X-Forwarded-Encrypted: i=1; AHgh+Rqp3MjPeEElducwo4IY/OLFOMm0Qs2Kw89Im/py92042NXUhPJlViV3f81bLk/9NYiEtM1MvRYPwIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy677kOp/XaQ7qAtg3acKlJrHRVX19b2Vs5SyzoVEhgHXxwSmV
	+8cLjsNDRxgYFdw7mXgjNnBZur+w4ugkNaT7M0o1d93klpX8tUyVRh9v
X-Gm-Gg: AfdE7ck+E8zx2wC740n9/zMFad/8yfcuzZlO3dUPZnknaPLnGfh7b0PQqSfnaKCetRe
	R3CoUkMNRYP1Kj6d18GS9tPVwecbLuLD+UxyaqeuyTK6gf5ZwUnEUrBagi2UMoFPM9mVaTALHFQ
	JUVi2zaRAq0EV2JwJwxz6yTYojkmgr8R2OW3Rkq9aA9IyT2Gd7vaSTp4ezwQASJnthIs9078FOS
	KTIrfACVH/WwYEX2FGXbvaHTtOVZib1unJsCYieT+bn9kqW0bW1I4qtO5SWhnBuC3UEKeP/9W4M
	4QHkg/wh+w9iOVBJhp1zKwph/xmbn+dUZ5UIj8X/3ibxrBopWEjJs/rrPUlpmmclKKmNWWXi21U
	16WgFlChzF4Q2cz514wQWYXQdYwK3hem6Htnaj0pZhoCNvMqB99+yZT9EQg0VcVOqHGb9jUtonR
	BEDapaEas8n+MuOffAZkYHmRxDGzTsSuC9kpYbnPV57lbW6TepTf67YArU6W05WV0i70MDGx5pm
	tmMK0VaR3NP4Dn/hxWSET01f0JfhTbMd8vlQkcxVOmR1TP+mgVNbETyNWwoQuWj6YqIXzWWck80
	afa2jd09+poVtLkMu64V+w/+rPzKkqJFbJUC3Aff/ZuLIj3lTGTGZ7E=
X-Received: by 2002:a05:6000:4a13:b0:472:e43b:5e8c with SMTP id ffacd0b85a97d-475dff5e567mr1152217f8f.20.1782805173846;
        Tue, 30 Jun 2026 00:39:33 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47563d19573sm5008391f8f.4.2026.06.30.00.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 00:39:33 -0700 (PDT)
Date: Tue, 30 Jun 2026 09:39:31 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 gregkh@linuxfoundation.org, skhan@linuxfoundation.org,
 linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: frequency: ad9832/ad9834: use div64_ul
 instead of do_div
Message-ID: <20260630093931.00006eca@gmail.com>
In-Reply-To: <20260630032322.5805-1-raizudeen.kerneldev@gmail.com>
References: <20260630032322.5805-1-raizudeen.kerneldev@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jun 2026 08:53:22 +0530
Mohamad Raizudeen <raizudeen.kerneldev@gmail.com> wrote:

> Coccinelle warns that do_div() should not be used when the divisor is an unsigned long, because do_div() expects a 32-bit divisor.
> 
> In this case, the 'mclk' divisor is an 'unsigned long', which can be 64-bit on certain architectures. The correct function to use here is div64_ul().
> 
> Because do_div() modifies the dividend in place, while div64_ul() returns the result, the code was updated to directly return the result of div64_ul. This keeps the math exactly the same but fixes the warning and makes the code safer.

Please try to wrap your lines to 72 characters.

> 
> Signed-off-by: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
> ---
>  drivers/staging/iio/frequency/ad9832.c | 3 +--
>  drivers/staging/iio/frequency/ad9834.c | 3 +--
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
> index b87ea1781b27..91df7ee65bfc 100644
> --- a/drivers/staging/iio/frequency/ad9832.c
> +++ b/drivers/staging/iio/frequency/ad9832.c
> @@ -115,8 +115,7 @@ static unsigned long ad9832_calc_freqreg(unsigned long mclk, unsigned long fout)
>  {
>  	unsigned long long freqreg = (u64)fout *
>  				     (u64)((u64)1L << AD9832_FREQ_BITS);
> -	do_div(freqreg, mclk);
> -	return freqreg;
> +	return div64_ul(freqreg, mclk);
>  }

I've actually sent a patch for this previously, however the
discussion ended with the fact that there really isn't a point in
doing this, since mclk will always be a value that can fit
into a 32-bit unsigned type, therefore truncation isn't possible.

See here:
https://lore.kernel.org/all/20260409182755.499a419c@pumpkin/

-- 
Kind regards

CJD
