Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FD53D3D14
	for <linux-iio@vger.kernel.org>; Wed, 19 Aug 2026 06:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787122407; cv=none; b=AeVme096qzzlB3zEaKdPTkaRUsRGrs6AnRKzIA0WICkR2qvbV4dkn8YIhHlcW1gFJP2om/PaNW6XVG+8BDEJRX4GBC1ZZehvY4rE3Pb7D4ASa3WD5o2VF0g+oJ5DtEkMKJSjXaGsXydFBkoTyUIHFBY4toxSu6iGlukby+6G8ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787122407; c=relaxed/simple;
	bh=ViPrjrGLX5Hxdc/Zs9vdFchHc6vI5aQgBpj7167p+6M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Iihi9sVxmK239jcx92eEZtpOPXgp7+3F5bfy+VcR2bPDXjviWeho7FGL49T5IqMQEinoMHyJYV8IfH9DnicceASPce42/RXPblmrqDbsUNEgrFbpqIHXbCoAFIEephmo5i3zckV6oz3tONi6HWz1Od/S8iuP3d1T7xjpmSWshUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SnyG/VAT; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SnyG/VAT"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4954d29264cso3062075e9.2
        for <linux-iio@vger.kernel.org>; Tue, 18 Aug 2026 23:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787122404; x=1787727204; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IpqeN5lIytC9amcBTT7riRYHzG5rbVz5f45Yb8g38Eo=;
        b=SnyG/VATLdpbRUxd1tq9pshly/Kh66bANPAqGwJFP80lrGxmcQFaSU31fF9P9n51YF
         LoRdAungqEZMyPrw7s16rFPL6rpTkC9k2DJADeCCci9+v9hAuEzvUu5WncOtGT6lETWA
         /eveWIbqYCCMXsmnt0TJIgkvE2As7lAIB+UHCtK/wssfClYa0XI6SdmeiGU4H2b+yj33
         WdaqrqEOcPhPFokZqH+QhyUEeym2MrTStWJS1foARWL3llh+Ycny88Cg0fPgN5nD8tul
         kTJjRNC5V/oUTFl8uiMpI33Hi8BN/dl8qPwVsmKnXTvmS8aa7st9GlK7nvC9W/+Zy8un
         OpMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787122404; x=1787727204;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IpqeN5lIytC9amcBTT7riRYHzG5rbVz5f45Yb8g38Eo=;
        b=oYSFniPz1fcWv7RIXEJb2Ei/XrP65AQmqFQ04pYEbXskJ+i5ssoQ/I/SJ8J+Pl7fQL
         ZMFpdMtW+ZAINaqnEDRjFjKrkoBD3eGwncnPRZ92YlNGhYeRH2rdf9p36Js9Ip8vFjV2
         wQKHvpQrOWhLET8Z+0bLHgBtRHw6Q/kCk7Q45YH/Si2viaJBrYw8dEpvph/Lm8VFcpUc
         ZqDuy+RU78L4upMzBwkkWS4Jz9QBovo27/OJ+DBgbNWCGWyBnYRY20cXlZVyUntdPqRs
         gkEIC8kUnekSqNmjjCWN+K8xbjGzec419f8dwKOCExh4noRsGZ+wIr+3qN0DeDMLtQ5n
         TXsg==
X-Forwarded-Encrypted: i=1; AHgh+RqbSaXzxCZ3ZWqkeUL6pDxwrVRsL+hRmJM8OwugaUDC9Ve1MaTDzi17aKGeVIwIeAxRv+45z6wsggw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtC+/Ff1WOYBhEqhRya+vBLUCGkftHfm2aEzGE8mFESJvW3g46
	YSzOGPABYFFKtSR+mCDLxX1OtmVBiiewQ3pxVb4QEXDxL4Eoxhc407KW
X-Gm-Gg: AR+sD10chtNcaHuNZhsp0rDlsDy7PKTgf+vLCHsYka7eackAuv2XXIAaIyRAoCQNnRg
	AH9cQShi4DCwCTJ4WALDM9xXQg9OszHNVDARX6sybgfNqfu0JSzn4qzaA5NdFps8fzd2j44Mr1Z
	YFh6LhNq0KAgQJn6JpfD5bTA0Aipo1vzOa8Y3fU8PbYnFg47vzmozLrbutIogonYKdm+H6KJnjF
	ydBqcQv+GUXrIygiaAmtouvu2EGoFAPURx+zUkZ69AuQZTAWINkyrVWMbD+goQUcnRBbNfsxF+M
	Hk5qcSQBVN3Pj625YIcNWXmT700PlS16AFDhCWKnry6xoVdYc1FTo95nlp7PL8izIO2SR6WW/bT
	zitpCTsdtvfPUIieNjsJ3MQtwfgWdQ4KED7P0eJ0sgAzPZSw33VrdPIS/O5iEMxxyRp+FEfPKn0
	slb+jzYMRRYd8ulJ0qNhm4uSRMzA1hXDzBBE9qfNVYHklzby+3f0Fj84XFth9NbuxiolmC9sQgN
	P1tLr/HKoZIta2lSMzjf1T67QccgULrk8daVEGTixIF/ZyFevDlYqs6clVdLYSeNiq2c6PoIb11
	UP3ML3MoZ64dcP/C8rhkYBy3P+oxAr/VF8Sk+xKk3brITXmCq4LNngJU8GHs5YbBjYVQzr79nsk
	eS8uYGYh7jc8gJuKYTLKZ1Xos9moksSZszcYSSVqc2RUxomRfnU8OTJYSD+Pqqgu3hjpUMA==
X-Received: by 2002:a05:600c:4e55:b0:499:a07d:a482 with SMTP id 5b1f17b1804b1-499aa1a28efmr46091735e9.10.1787122404470;
        Tue, 18 Aug 2026 23:53:24 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499aa0d6a84sm35256565e9.10.2026.08.18.23.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 23:53:24 -0700 (PDT)
Date: Wed, 19 Aug 2026 08:52:55 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Vladislav Leonov <vlad@zlab.su>
Cc: Jonathan Cameron <jic23@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Andy Shevchenko <andy@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Rob
 Herring <robh@kernel.org>, Jonas Karlman <jonas@kwiboo.se>, Simon Glass
 <sjg@chromium.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: adc: rockchip-saradc: Fix RV1106
 compatible
Message-ID: <20260819085255.00001e60@gmail.com>
In-Reply-To: <20260816113636.33635-1-vlad@zlab.su>
References: <20260816113636.33635-1-vlad@zlab.su>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 16 Aug 2026 14:36:36 +0300
Vladislav Leonov <vlad@zlab.su> wrote:

> rockchip,rv1106-saradc was folded into the fallback enum together
> with rockchip,rk3576-saradc, falling back to rockchip,rk3588-saradc.
> The two IP blocks are not equivalent, though: per the RV1106 TRM v0.3,
> chapter 20 (SAR-ADC), RV1106 only has 2 channels at 10-bit resolution,
> versus 8 channels at 12-bit on RK3588. Documenting it as falling back
> to rk3588-saradc allows device trees that would bind against the wrong
> channel table and report an incorrect voltage scale.
> 
> Remove rockchip,rv1106-saradc from the RK3588 fallback enum and give
> it its own standalone compatible entry, matching the dedicated match
> table entry added by the driver patch.
> 
> Fixes: bdba14f6122c ("dt-bindings: iio: adc: rockchip-saradc: Add RV1106 compatible")
> Link: https://lore.kernel.org/all/20260810090826.146758-1-vlad@zlab.su
> Signed-off-by: Vladislav Leonov <vlad@zlab.su>
> ---

Looking at the link provided, it seems that there should be a Suggested-by
tag for Jonathan?

Otherwise LGTM

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards,
Joshua Crofts
