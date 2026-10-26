Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793024301;
	b=pDO1Sa0L2IX8lVn4FFZhkeirPwZB2N/YxKr/X322DqD2jmNuXsrqTxnkQM8reziJzgku
	 OtuO4y1lLjC3DPHMkCA5mMjb6Bml2EdVkZ6O5Z7nHhUcc4EQVaeHmmtW4nJZZhUAd315I
	 hiMH8lwdfAnKeAnvvEOLBiB0C4DnQ6J5cS8seixB7rr/D2VwdCA+B+nkTyZtkn0e9wESp
	 bTXwdTO2c1lvy9UkPNfUZ2U4bv7ucSwza6Qp9dqDb13uPoUm0x4nlDbGKJ5VaaDMHF4R3
	 ioX/uXrS3LnjpufQezyBn5Qso1PlDZx9fmjfiG3BJ+h04pe7eAjJ3O5Hmkff7WYBuPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793024301;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ifM+PXldux5sH2cm3CGnH/RRo/Iq9tlkwFAZTBnx4+Q=;
	b=jhXk+BY+VPK8K4L5C2sNnMP8aiMBB56817H7rvQ4lXTS/mjJ+CB5O1CFxMjD53T7EAzh
	 bgF4OToxzozhLZNqTiD5YYo9PMiQpV6Ikd2kc1+GddAfY8tOxuXZ2nlmZ0VckdNxjZgzv
	 xhRp5KR7FgqolTtcgJFpDIbpBCFTu15yZxqWSXFfeL3uf4IUntOxB75dniTeIoS3OHooX
	 EbNNGaCW37EZytv3LhrFwY1aFgY9nT6sus9JWySmDOaTpZxvTlMVokCEakwThkU8rf6Bf
	 qrnw39BmbquUnxC6YdHJkdiWwjhkUhg/743uaNgM6Vh4gpwH79gz1RboQ0iZUdlQuSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=arAe2ryG;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A63606A321
	for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 14:18:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8A63606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=arAe2ryG
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a60f9474c4so11480705e9.0
        for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 07:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793024294; x=1793629094; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ifM+PXldux5sH2cm3CGnH/RRo/Iq9tlkwFAZTBnx4+Q=;
        b=arAe2ryGITQNaEOL6zbSb3LMwQmpaYIjaYHVlzJt+RwVkXz+ibO9s+qLO7YT1Dexse
         wjEb/ve7fTopNBXX3YVni2GCZ+uWleeRmGhQOxUpH0OpM9W+4VuvjPijH+D66GQeaCKl
         trLGCt7AqToC4FKcJ5oXvR4QIrkTuGShxtajFOcIIVcNVL0KlAw3RsgRa20lHE7EMgA+
         pDpSpHcxEMQvzDhCfFJDZ5IP45budIblqKHrLqt9Fj8lrT/GY0hw7SfxT1pBYhc+6BRk
         wZ1KYLk53bpOQLyS3knUrpi7z2H9z66bVOjWZg97H07dhGu531lOyOGQ571VIaKoWRSY
         ImOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793024294; x=1793629094;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ifM+PXldux5sH2cm3CGnH/RRo/Iq9tlkwFAZTBnx4+Q=;
        b=fcLs10w/vYECnMf04YSFBeJxqGzRjUBNXg0MYI82AhbI5aIEun2vfzillYoPruQAy2
         WbFwypq0vgPudov9D8mVfNf3Vx9PNTs3dWN/begg+2qJimPnKZFQDFAdLoWaxNp17uoY
         sFACvXJzmIbnpUzeYVJnoXHOFSp3+UVdPK799Dw6M9Ez2b8jNZ0U5rdVeLrktoX9NMEL
         Bfg+TJTbFuQK8NtlA6Ne0AzHyqai0wTcrRpDvJ7JS0lYO8+4/BqYJBAf9rGwiggmXMeX
         ZdD1p/x5/x+i7EGC6JRB0N53U9+4lPi3sw3c8o4lHLxx6atK5aTk5dxKbFMRm/V6gkzV
         vKDw==
X-Forwarded-Encrypted: i=1; AKwUvBxhF6OgFDdfVUJ099ncmfLHifVjectGkFmgcd10uZxjv9389ceU8YDCqI5QgCEupMgFFSC2tBU+U8Q=@vger.kernel.org
X-Gm-Message-State: AFq9FYLrarH/1HC6pocfRHHb9tAfgsJvYi6TrOR6pfF77CyVdsi5te9B
	2VOIVGjbGORD6ktjyXZ4EWm7RhovnX3bnH7KnoOcH5jZ6Az0KM8rdPyyGRn66g==
X-Gm-Gg: AYBFou18w8iQFGohdQQEA9E0ER4rD05Wqm8klS8o6QDw3wK3m7rTvh10zBX66lS6emb
	Rq8r61TQLAlBreVIXqmjFvO9N8oKF/IH6jnQFW1nFhtj0J+rEQ95FmOrNMLIvCdvRNirNAmyWhL
	ALG+wIrpmKiwNdTtajtl89JjBbQKplijrf9RxRxDKxjC0njUbZfM12DkhZAq54iocvb3PxTDXwV
	kDmDglPUUVvr9ZyRVMCCWleWNgSFBS4GeJ/KF/3Zfc0HcUHdpj5k4NCZ6nUellf4/+kgTCvGNIA
	knTU23axF99vTKKjgYAn08B5QYTqHgZz6CLpAx1E0MIlSX+/G3Neqehaspt8T19F4s0CNg31iRu
	ByumxHXkIMkD7E0blpVLcKpc/2cpXPuNpLsem9eOA2X3maW6ITouBbYcI92C9QArpSA3yIuV74x
	u/YQ/VVU/OmJQGnE/5FczhNQwu8ghZnmQccKNCosLXzOcFiGoGOIZ/Mnaa0pE/QySWHOxPdSuZb
	RVKP3kQQNZMhLk/DZQvaGZ07sfS3doQz2c9UGD+sJni5qcaEeziEgIwkSWgsC4rWZjd36EwU0gF
	gqL7oR2aspbuQ/7Nd6CXUSqZ3LBSAqEtu/1Wwe+aNxNjI701ZsWEivI1rCJKnV6S9OUUo4f+ks1
	lgVCUFucEpZXN+4KRt47hvH1vNxa005xCxXzPs0gIv2cMRFG9x6rTuOEdr0xTame4hxkyMhdvdx
	DK30XXcpgb42BChKabSu+zMawSsAhehvWd5oLinypoDWeJzzkwt+EId5OmBCzWQowzRJxdN9pVm
	l56fVznM0s=
X-Received: by 2002:a05:600c:a318:b0:4a3:5aee:2c25 with SMTP id 5b1f17b1804b1-4a35aee2cfdmr95663085e9.31.1793024293964;
        Mon, 26 Oct 2026 07:18:13 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a58a0e2sm246428935e9.13.2026.10.26.07.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 07:18:13 -0700 (PDT)
Date: Mon, 26 Oct 2026 15:18:11 +0100
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Olivier Louvignes <olivier@mgcrea.io>, Jonathan Cameron
 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Paul Cercueil
 <paul@crapouillou.net>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: Add the Ingenic X1600 ADC
Message-ID: <20261026151811.00002233@gmail.com>
In-Reply-To: <20261026-hungry-masked-anaconda-7fadb6@quoll>
References: <20261024041357.34346-1-olivier@mgcrea.io>
	<20261024083809.000026e5@gmail.com>
	<20261026-hungry-masked-anaconda-7fadb6@quoll>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Oct 2026 11:50:44 +0100
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On Sat, Oct 24, 2026 at 08:38:09AM +0200, Joshua Crofts wrote:
> > On Sat, 24 Oct 2026 06:13:56 +0200
> > Olivier Louvignes <olivier@mgcrea.io> wrote:
> >   
> > > The X1600's SAR ADC has four auxiliary channels and none of the
> > > touchscreen or battery engines of the JZ47xx ADCs in
> > > ingenic,adc.yaml, so it gets a binding of its own.
> > > 
> > > Signed-off-by: Olivier Louvignes <olivier@mgcrea.io>
> > > ---  
> > 
> > Please use a cover letter when submitting a patch series.  
> 
> It's fine for two patch series. Please do not make it more difficult,
> than necessary.

I'm not trying to make it difficult. The cover is usually a good place
where to describe your motivations for a new driver, plus with a cover
it's easier to pull via b4 and Sashiko will treat the two patches as
part of one series, not separately.

-- 
Kind regards,
Joshua Crofts
