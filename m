Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACC33033F5
	for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 16:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777394280; cv=pass; b=sRi22OtoTIoZIsxFe0LQekwy5yBIGVFLvyNImNfaAO1oSArldidZ/J2l5TduDG8caX9udcu2QbQTSf/LJu4dxZENfSeQi9x16+CGrpHz5HzE9d/eKXaZM42k0HOramP0KKFivQXlvtIxAfvC50aD0IMwOvRRpHfrHx78+yR6DME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777394280; c=relaxed/simple;
	bh=46kUkyT+mJAqBDiqey4FnoXVuTuRZH8Lqvg6bCf8vkc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j1flqcax2J76QgigfHBBUyzOPVY+M2e3+xXaG6qOdmHydEjkpb55AtFMQ1mgK1Z/fF4h22ieFnrJSP3dNVWiWdIfAOXKploaVceKWSoeo6qb2LhRnT4WtwF5qUWsctFw7AOVfuf/D8a/f79oC9ACA6Ow2SdYyV8plHIFrCrPbno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G3b1zZRa; arc=pass smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3b1zZRa"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43cfd832155so8608808f8f.1
        for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 09:37:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777394277; cv=none;
        d=google.com; s=arc-20240605;
        b=QucgHUl2HzxkKOUVjnrBlqUeX4i2vmX5SaCnNLbQteZ/avFhxIE8RIEh23fLqHtZ9c
         cJiNloRT4rLbUzqiaJfcCvb1WVIdSQDJS0FLGuVQ7nbgkCeisu+5d6pqyOB2ShrhMerG
         mrLD5JJdxd+u5DCHhqTTdYT437vzh0/UdJMsxdPFSjaQOvFZhb2xnEJN2LvKvcenusDo
         meX5N+coYYkjnbVnzwVEbhabMXe2eWGE5WOObJY2awt+nFmqj3G4PpOmch0ujJpI1e5z
         09x4PlYWCaSk+C1iPHjcsWv+tdpwkBNiWfYqfDoT1Ppekg7LHu8Pmoef30K+GzW4gcr0
         Mizg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ES4BqI23lSRTmtx8ua3WDZHX5s/VU3T+0RJq4xShGY8=;
        fh=Mzi30Xw0vs9Dz2pTQydiKZRz+ykSujYEcucseXTid+0=;
        b=JiX+C0Th+7Kfp9SBMw1WE5aGeLof7kbrliuIvYR20M/1hpCQWFvVm2SvKZl3zwTsWy
         Z9SNjKmtC8XsUaUnYy1lM8ezkWVArNuKEFuNlaL0CbNYwPfpOEItXvaB3hEyI+BJ9pGQ
         d5jFvmNGdlimm6XFdP0I1SXBLGc2mfkgqbAr+3d7+V0rNuHAh7BvyS6DtodA5HQnEdia
         7K1n62uRzJtTWs0D/rbXgPrO4zyaqXw+7Prul7nkCoHZsX6hqbrZfV2RO+rTP/IHGrtL
         zyI7f2JQGMo4oADO/VzlvX/yTpstwBZ53Bafhm2679L1flOQwbK4zttN9nNUzubcJWCK
         +8dg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777394277; x=1777999077; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ES4BqI23lSRTmtx8ua3WDZHX5s/VU3T+0RJq4xShGY8=;
        b=G3b1zZRaYNIQbhd9+jj7ZRxxwgzwZJC1cUVre5VMXg/K5npAnxfIWwtI1tfYQiGVyV
         s/YPYsWBEBClGLjvyOS2mR9UqEbuCV/Pool0Dv3lZrs82ioHooYuj8tJFnGuES3XbE2N
         A+PhyFctp8zpEqX+PaQe8ruYUnfpGC0pmsnJCNnpQi8Hd+R107WrwIV5NPLzkuEg8XCd
         jNVrmVHOXiG3gVmDPbv4/MCc82yS7QXE4aMtfV4lH0Be7bDLtitueF5Xdh6o3xV9N2R1
         4C2z1/u+vJ6DbN28Xal6lcD5fVgbQT9qILdjCfh5o04iTaGt8pDZjMKLDfMLG/nMU4/A
         q8JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777394277; x=1777999077;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ES4BqI23lSRTmtx8ua3WDZHX5s/VU3T+0RJq4xShGY8=;
        b=qdPetSZbFLqySsj9b8TZoQ5X1474xEqCxjIc63mdo5dq7WXhu1yJCvLYCD4RW5XcYa
         0ifMB0EU1VVAqRSjqtto1Ovb7VQDb+LwnfOno0YRQtEjzKKb24hkSGO8ZdhNHKXzBh/m
         C9wcZcFGkIsc3AAmwuNKC2yIu6J11WtivfzDEzN2zuS/HAf8z3B8pM7qLQ3/udTx+Otf
         ZzhRimehA9pVzW66mZYbQ5TTYXE+tM5L1+mTrIxRF3SQGp9uVdZ6r2XL4LETX1K45o9M
         HlO5iwHyic/3iB7IwiYe34KazPNnHz4QuylZ8j7dKMiT4H+zLqTjhMzA7NormTMhsNjn
         Qt6w==
X-Forwarded-Encrypted: i=1; AFNElJ86NELvHIToR8Z+5W8mS4BlhdEhXpcb4Ax302JbVh00IEGn2DSuo/4nNHf60sxGJ4TxW63o2EpNx8A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7QXmb1vDnOfyNvSdjDtmEQwSo2NMznahl2oJzmv66c2s6QCi2
	jlPiYDtzoSeHom5fzwfMb/WqlLpJGCQ19PfP4LGwV+VLSWdaFsAmWy2pVt1uistW8KrrgSxTu8y
	pAb9t37JmJjwlQ2n5fxgYXwa000R+jlU=
X-Gm-Gg: AeBDiesvJb8nowWufV8gw+2PDd5jadg3O6ZhqmEaCJ2Y5dRJV3TGaLf+Wt7+8/Im1gQ
	YfP2LpFpr1JgBFprmw1LiqC/Z9Jo0cSKWO/IrEePnaIEECNwthnHC1zM+JGEgI834ejktawcF9U
	BUktPJwLuYth15eW09kWJKdezj9qBKIqMWT2RPc7s4iD4T25rjRHjH24j4LvzqwDBZdnPt4SUq1
	DYKlXo5/taOQlGnCrVJaH/KWSL8fUd4mRolLxioqpXyQVgiHicDDve86a4MVRLK0gkJw5cjWgAb
	9VfaQwnYOgLBV4W2iIKjqLBfzQZZpYNAo3m14ycEghiLVa7d3xmp5wtoT7sP7R8fPyzgvRTpm/B
	tYEyOZq+AWQ6+6Hn2WG7Dn1gruvBpFIUf00Hd21nGnq6ULrJBSDWZhHPO0TsHQ69bKNTOhDHInu
	eYxcwR2GiDdFmRDmJmpsSfa8CMSjcWaGNag7fSpLgcU/7kEzeTPA==
X-Received: by 2002:a05:6000:2502:b0:43d:7403:4b5d with SMTP id
 ffacd0b85a97d-44647dd166amr7318519f8f.15.1777394277154; Tue, 28 Apr 2026
 09:37:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428161339.1187956-1-rafael.guimaraes.dias@usp.br>
In-Reply-To: <20260428161339.1187956-1-rafael.guimaraes.dias@usp.br>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Tue, 28 Apr 2026 18:37:44 +0200
X-Gm-Features: AVHnY4IpT5TCs8nY9QzSW388Pn4PnyntQsbJeccawM8iwbOImrr5e4OMu0S--6w
Message-ID: <CALoEA-yYG5hFrwOpJTEPiD9_KG38aXkg3r7dBSvyYACFGMU-Ow@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] iio: light: stk3310: Sort headers alphabetically
To: "Rafael G. Dias" <rafael.guimaraes.dias@usp.br>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, linux-iio@vger.kernel.org, 
	Felipe Khoury Dayoub <felipedayoub@usp.br>
Content-Type: text/plain; charset="UTF-8"

On Tue, 28 Apr 2026 at 18:13, Rafael G. Dias
<rafael.guimaraes.dias@usp.br> wrote:
>
> Sort the included headers alphabetically and group the <linux/iio/*>
> headers separately from the generic <linux/*> headers.
>
> Co-developed-by: Felipe Khoury Dayoub <felipedayoub@usp.br>
> Signed-off-by: Felipe Khoury Dayoub <felipedayoub@usp.br>
> Signed-off-by: Rafael G. Dias <rafael.guimaraes.dias@usp.br>
> ---
>  drivers/iio/light/stk3310.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
> index a75a83594a7e..1fad9367c2d4 100644
> --- a/drivers/iio/light/stk3310.c
> +++ b/drivers/iio/light/stk3310.c
> @@ -10,9 +10,10 @@
>  #include <linux/i2c.h>
>  #include <linux/interrupt.h>
>  #include <linux/kernel.h>
> -#include <linux/module.h>
>  #include <linux/mod_devicetable.h>
> +#include <linux/module.h>
>  #include <linux/regmap.h>
> +
>  #include <linux/iio/events.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> --
> 2.43.0
>

Try not to send follow-up patches at least 24 hours,
let them sit so others can look over them.

Otherwise LGTM.

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards

CJD
