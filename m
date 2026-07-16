Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4183D3314
	for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2026 19:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784228923; cv=pass; b=Nxh1ExqK5nGT/6IDsyFsWmOcW93ubQpfvb8IFxqB8zVcmqDVcB8EUGZ0TIEXTkr8vIOhkrW/6P1LKd0dc+a1FtVKr15EQYukQ2jQ1Rwe/v2edAtyU99PrqzGYG7K7O/J7h9TA9P2doRXgplC+dsDdVM3IAJABGU/kbpWdwQcKPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784228923; c=relaxed/simple;
	bh=jLdFeRnLlFspnZwXeo9oBcZZ/8ssWumYg5r20QmYeNo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sO/SwFhOK8yAv1YctbuOCds95F14FkKq/ZttwmH2ztlG8CeyPRTQE0UUV2qD772awIsMzkzcMz5FnyeC9bMCky++oLO3KKYplPm9EUG3Zw91BrDOCtjb0y+CcvhqXFvb6+MCnDHWgJefcAnfzlskJE3/af1oosCHR5qM1p/9ZuY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YWedmSFm; arc=pass smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWedmSFm"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-493ec555a26so45995405e9.0
        for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2026 12:08:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784228921; cv=none;
        d=google.com; s=arc-20260327;
        b=mDVplRw4Q80UhaPC+LLliW3mE77J07lT1ykcsgkx4AsYG+Kq4v7pos2yiAWsCojGdW
         i3yJ/c0c7nLtN+r6VNnDJQAXW+vx/QYlEYoJM/vnOINyxjQAcGZDjeih4C0iqcnbJWMl
         Z3YDyj9ht9DwW4ho0cFzaOowt5b5Ma/iL/V/ZIduMA6OW9JSQ3V6M6KPRltl4Jm+xjhT
         AtpIzVLWG1qDK2eCTVyKWpkroYRf2N8kOSg1yjR4hZxzRbiBHzshl67srNhkyI0ydk3G
         +7YmB5RYDVF09wYURK8l5v/AL05SAq1g+DV8fzs/GhLUNrlMwtshEQ0z7zvVXNdxbUVy
         LLMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=5fFbXpQ6cgL1W+wXgp57WxL1BMwiS9aV1pLY4h9zMNk=;
        fh=aawzeEFvmuKVDgGe7AexM0nTJE9TMZ8rXnjaayiJkBg=;
        b=O2owoCP0ywZeTKX0gAefDEZhL4sJyl21B+VFgvLxJhmEcGpQbcAnwSp7/q9LXKyBvX
         mQXWVcYad1YOWGFq+mddNTi+Mzg0NRVnRuHsei7Y4OaeeI5LFEiNOmdrmDJOpVA15hra
         0Sjmf95n3t6+fvWVZiGMBuJ4CqDtJaIU5Brg5uNTa58FFSrGn+K01k8G9YwCTxE6W9Rb
         K3i0bByMS8aitwDOXuDPrMx50yeXhmrNm+Lt3+4onBprP69F4bxzdG290ZFFjWPqUla9
         r44kULxLag+Ygpwoa9k/a3yuWJo0i+F9nzyira2gF2b3+s4miI27FKJGGh3KWKomUhRu
         0aXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784228921; x=1784833721; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5fFbXpQ6cgL1W+wXgp57WxL1BMwiS9aV1pLY4h9zMNk=;
        b=YWedmSFm80jIjFcKxqJ4AC0eHC5iHFykx0HicwhLkCsVcI6/tpozRbDnF9YpbUjIWj
         qr+0nEDMhxaUpP5M7oqP0B/l5kcQgPdCavGAqqzF3WMgkibB+EmTGZmEiJ9Bm6zZRQE5
         PZSqj+SRgYfpsIvy64xC5pu5/juS4AgUVnJHTSP0R4AwAiAgOETG9a+yymSRxSmXOlZx
         hzm4Cv5d1zoSoLEHPOT9L/+41cxh6QV/rU+ZvBcpkc2xFzQw8GkhG/TIN1pKu0zWXh9K
         jEFHbmF+yufJy97+Ouzq2JOVpc413pgnhuv4vt5X9IRg52f/IXpihxqN5jxyDsxszcWR
         HA0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784228921; x=1784833721;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5fFbXpQ6cgL1W+wXgp57WxL1BMwiS9aV1pLY4h9zMNk=;
        b=oF756+cEkeeI/lIbCfcnyBuHwDR6f6Hdycv0fDJxyKOdBFdWuVp1faiQnli8lrsixg
         VQ0RrB/QW3NOi0JTjSP9UOccesISPvi5HtVU/UQik6iY4yeL2zZXpU7J/la2UtT2R1gZ
         Qx3So3LNab6ctmgtTcI+lkQDDEJYSkMgyBxoIES88GvwFZGK+Zc6x7Y9Eqvc820pL49N
         cRh1GbP4wRrIQNq4Tnsh25sMirkTgRNrufD2dEGFzky/f5UqQoctvhlD46ZoVOpolBLf
         WOuHoBgxECxryc5mzodPUtEXQNCmKK/F7ri73ICytSnNc29XzymPsV2812jt59oxsW3F
         eLgg==
X-Forwarded-Encrypted: i=1; AHgh+RofW3UthX2Bsfd7glKWC8NfYVJxDGxkVXXfLagBqNEg+T6xtnKxdOp8sZbZkXqiNVyv6nGeMDPsfTU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdGRlCyc6uO6wYL6xbqNBrE2w/uH/9mDkSM0uA2/78FgjTDJWs
	Cne9PYCGXn2FEdCDC3OuMG4wg8ZmRgj/xWUVc5nW9/1FvGrOhgXtJksod0lK6rFzuo8QNCO0g0K
	zpQzw8/BiKWfCTdbxq6XJ/nf9lHnCNcVTa2QKwlY=
X-Gm-Gg: AfdE7ckKh+3joRbZDAV3Wfkhg1wcxIieVn8eHoh984fZ2+ETx8ENOYlXyad7aJNAiVI
	5IlhAUbqcUBIpZEwvLcEZfz3RMfhEpzE2Kv9rghDCBa2Zbph+p7kmwggxbs0OZnw5f2AuEpUS7N
	3P7mHUCfna+5CnLz6+x/F1cIB9CXt0dVpCN9kENcP/tU8vO751zljhSgW8yVjYY/aezat8uSBe9
	BKOdElUV7TBPnbRgDH1n0m6jCU5S2geA5l/EvwFsXbyZLECmPKw8qkrt/EZ6gVLxylbMHd1c3pr
	rHDwgK8E6NZzRKCfe8b33+oQf8nm1nwN9DW6dRln2H6cSdKUXO7EXUBCrR4LsfJaLp3yMOxMkds
	mH3eHScle0gV6rkUxmdiCpXfSm599wtSpqA+fhI8/NLtBBFiSyUwCY5n4M5jB0CU25iPxd17RNf
	m7d960ZRvmjg/CM+M+SpxhGj21YfydWjGhdRLkI9bvxVrrCkasDD7It98ksDJHcA==
X-Received: by 2002:a05:600c:1507:b0:493:9b02:484c with SMTP id
 5b1f17b1804b1-4953c289549mr63624915e9.29.1784228920599; Thu, 16 Jul 2026
 12:08:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716-ad5686-new-features-v8-0-ebb0051af5e5@analog.com>
 <20260716-ad5686-new-features-v8-2-ebb0051af5e5@analog.com> <alkmAcDvSXr_COc_@ashevche-desk.local>
In-Reply-To: <alkmAcDvSXr_COc_@ashevche-desk.local>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Thu, 16 Jul 2026 21:08:29 +0200
X-Gm-Features: AUfX_mxCntOtogOB2qZP4BBtfm04CggLYlXKnLS_glyM7cRaPGIAoMal3mZWjak
Message-ID: <CALoEA-wQwxjG860Y9u-vBkGn=Y=82UBX4bG1rvaed_A-qZu6Yg@mail.gmail.com>
Subject: Re: [PATCH v8 2/8] iio: dac: ad5686: missing NULL check on match data
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: rodrigo.alencar@analog.com, Michael Auchter <michael.auchter@ni.com>, linux@analog.com, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 16 Jul 2026 at 20:42, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Thu, Jul 16, 2026 at 01:14:18PM +0100, Rodrigo Alencar via B4 Relay wrote:
>
> > Verify that chip_info pointer is not NULL. If a user binds the driver
> > using driver_override via sysfs with a device name not present in the
> > id_table or of_match_table, match data will be NULL.
>
> ...
>
> >       struct iio_dev *indio_dev;
> >       int ret, i;
>
>
> Move an assignment here as well.
>
>         chip_info = ...
>
> > +     if (!chip_info)
> > +             return -ENODEV;
>

Enough reviewing for me today, considering I let this slip past me.

-- 
Kind regards

CJD
