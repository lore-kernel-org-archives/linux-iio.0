Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795710199;
	b=FBDFMkedokc8mg9Zd3p/Q9DeaKvhTEXQWHAgEtZOqrDrd3H6uYV/KubFPahVVb9z/MSb
	 Jln4BT8/85M5uBLmqK34/w1t7qNiO5RqU1ZMzmzEiLaq1zRXWJy3cTjMmCWvDRcY3ijB3
	 kQnHNQm7PJg3vsXycx9JsmG5H7HhSKt+4K/4PhnYa4URD367mjMSqkv08PkyoweMaQKm3
	 o61QiEu4v+DGz/4QEB3tEEMdiIu47ZcDUNPSxWdueqDWW/Kux6Kj+ehGRRCbZLskpY/M0
	 pKJ3YbprWxiUYGN6+FGJg8VvTuEKGFmBjH6eNFWjXg4qJc4Fd6xnNtJe4hE673qzJeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795710199;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 From:To:Cc:Subject:X-Mailer:References:In-Reply-To;
	bh=Pg1T9Dulq0nwdntFgrBA2i597/7t38j7zfu/CiMvEbE=;
	b=VNwwzM9UI7OPnmROK+p5erosNJpEMvCatm9X2DK5VDtDR87rHdKdmj6/VithNOKtPngF
	 5vYZnr/XUMNQRuDq0XdIhQmgmI/Of0b/GPcgE25YypsQL2t4uZECdikWLwwS4UnVmm+81
	 GM9MjIMGr6aiQfQJWt0dgqsYEfDgmw00IW9C5WBcDHWT0B5OmDoPrdOop3DpvOOc9goUO
	 m/52Eu3ToHU3yLcVjwnjgioITkc6KndnyfCAbLcz8oPZCjoqDrMcTsLJDLMumK076Z2ux
	 952K6BwSE3VDf/FRw0r4c6i5QKGuy6I8UlS2ScqBgpy2bqrwHj2GV/VMyywP/sAF8Ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=za0tUy5b;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2873606A323
	for <linux-iio@vger.kernel.org>; Thu, 26 Nov 2026 16:23:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2873606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=za0tUy5b
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a2153c8525so58460995e9.3
        for <linux-iio@vger.kernel.org>; Thu, 26 Nov 2026 08:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795710197; x=1796314997; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Pg1T9Dulq0nwdntFgrBA2i597/7t38j7zfu/CiMvEbE=;
        b=za0tUy5bDG6DeUVR8UOXXFv4wekZtvi6jD1JMYNdlmu6vgxWoOIVdG40c4k0jCsCkK
         0xrpNS2Gr246iS5McYjs/kKq5cJoMhAKBpSuABY3v4SjI0/Bw2qPrI5ctzZU6zA5gz7A
         T1eJ/jaQVTaete8XKxHl8kQ5iVOUahGjaAHEOo9RlkBpDqg3bxGiwUsSn044wn1G2WOc
         YVYwc8ct7Y72VqPk/7/lDtZJ3TKMRQw6TrJWogVwJ1i1H1/3Gba2Nv7Hgp+GJLr+NlNe
         V9ulQozkpE7KCSuOnrg86Fea1O+9JN+xkj6y/9EMeALFZwDYDF+Rgu5Hs1XuN+k6C0Bw
         BTGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795710197; x=1796314997;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Pg1T9Dulq0nwdntFgrBA2i597/7t38j7zfu/CiMvEbE=;
        b=egUO9wrSZQyG+LGaA4zOOMQlCQj3ZdpV/slpSOgmti1rcvhZLXMS3jgNtibAxPTHnn
         qnSCveEiQpH3KNLjHnaoiGzwkBmlpPySdFAHwMsysEIfIZ5fZ1ly3qwtiC/dXmhdaprW
         x5IHpkUpCa5CVMRzKxyJPf+24K9+gYl3WYJCGo/2wio06j0GVh2dDb29Zs5F6bdj5k7k
         zjftjx0gc1rtImjiwkvnzD2pam5viQ7s0O+ZRODJp5l5yA1Xmmg+oEKeYLFlffPyUupt
         m3dlCbnmiE/IbiSDJpacvWeO71Ww0gKl1VD57u2R6pk3B3IqCXnLRDzYdkWgAuCt//bs
         Z6DA==
X-Forwarded-Encrypted: i=1; AL+hErE8yxhIxaNIvY+N8iwVUpUmqCH8GIJiiS1JhOtgvd6TbmwEU4MzeVbV5cceTmpgQNC0CiWh6GZ26uQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8S/Nf59UUL+zClqK0K2rXpYetoX/jSLVAjiQH1sAT08FeXNB2c
	6Yj7oVqw5waOyEMONFwJBBaxDlN74hej2Z20DWejKUatGLh95OFj4ky1aAkPyIkC2rI=
X-Gm-Gg: AZFdTZcgBKIEj5Bxxn3sJLT+N5nYlUEKRpC+eee9/tGFkbR48pGVmWeZ2GEXm/HqRfg
	U5b5RSXrPnW2UqcoQCXJEBHnvVLL0rKgpqW1hEJSVyJ/KcGXDjX5XbLuwB4h6HhyVShJfnLtnmW
	gKs8mrZ1+Q18xGhXnF72EkEeZeqp5egJHOpN30dY5tPhIVs8uCJTX0WB+JEN405+HmVB/5orzyT
	/QxxsrTrUz0sOBVsvptVGdtPoxHRbJGEbwn897iIzOrRvpPj4LqgRG1V1gQMsgVHYB0kJUI0ssh
	cbbn/DW/31OGhzbNCNItcQzZctH8GMTOT93uzVTIZe4IKnZ1pRHgunByjSFjSbaK2Q3e+ZXeGnZ
	5ajT+ko+axrYzN8kGPQG6hPzIJ88O2WXyKCkQYbVNrq4/9TznMriz8ZLhfUEhz++IqmD0xiY8+5
	kOc0I1+qL/pyYLjNNjMrIi0I1fOD6NhsQ3EW66o0c5PmOCw7KK9szi3wAjAoLbgjd9NVHyS+9cc
	XE6NtEsAt9Ik9QxHH/mynt4u4vV+LJnye4I65wBE4LuTlHLpqzkgq7t5vhgQHeZ+UhMfMvCdou8
	T/Zm3HSf+C3phkGsWbXOXHWesdu7tveoc2DsZOffp6OqJRJ0Y2G9ewWASOvWVFG7+Q+0CQyE4rA
	BAvv93dTiiQh026DZaXA=
X-Received: by 2002:a05:600c:a55:b0:49f:ce78:356d with SMTP id 5b1f17b1804b1-4bb88827db0mr461737765e9.30.1795710197214;
        Thu, 26 Nov 2026 08:23:17 -0800 (PST)
Received: from localhost ([2a00:2381:fd67:101:11a1:dfac:b1c2:1000])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b110ba3sm34026626f8f.35.2026.11.26.08.23.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2026 08:23:16 -0800 (PST)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Nov 2026 16:23:15 +0000
Message-Id: <DN5A4ZMSEDUO.FUSGQTLBRYFN@linaro.org>
From: "Alexey Klimov" <alexey.klimov@linaro.org>
To: =?utf-8?q?Adil_H=C3=BCsrev_Tepe?= <tadilhusrev@gmail.com>
Cc: "Jonathan Cameron" <jic23@kernel.org>, "David Lechner"
 <dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 "Andy Shevchenko" <andy@kernel.org>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Peter Griffin" <peter.griffin@linaro.org>, "Alim
 Akhtar" <alim.akhtar@samsung.com>, "Sam Protsenko"
 <semen.protsenko@linaro.org>, "Krzysztof Kozlowski" <krzk@kernel.org>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-samsung-soc@vger.kernel.org>
Subject: Re: [PATCH v2 0/5] Exynos850 ADC support and soc thermistor
X-Mailer: aerc 0.20.0
References: <20261125-exynos850_adc-v2-0-26de1c6f1717@linaro.org>
 <20261125193122.747908-2-tadilhusrev@gmail.com>
In-Reply-To: <20261125193122.747908-2-tadilhusrev@gmail.com>

Hi Adil,

On Wed Nov 25, 2026 at 7:31 PM GMT, Adil H=C3=BCsrev Tepe wrote:
> On Wed, Nov 25, 2026 at 02:23:32PM +0000, Alexey Klimov wrote:
>> This small series adds support for the ADC block found in the Samsung
>> Exynos850 SoC and enables the Murata NTC thermistor on the WinLink E850-=
96
>> development board.
>
> I tested patches 1-3 on a Samsung Galaxy XCover5 (SM-G525F, Exynos850),
> with an ADC node equivalent to patch 4 (same reg, interrupt and clock)
> and the board's three NTC channels.
> Readings match what I get with the vendor-style sequence (re-init around
> every conversion, SOFT_NON_RESET after reset) to 1-2 LSB on the static
> channels, the NTC channels follow the temperature, and 200 back-to-back
> reads per channel show no stale values. So initialising once at probe
> works fine here.
>
> One small thing: channels 8 and 9 always read 0. The downstream driver
> uses 8 channels for this SoC, so MAX_ADC_V2_CHANNELS (10) may expose two
> channels that don't exist.
>
> For patches 1-3:
> Tested-by: Adil H=C3=BCsrev Tepe <tadilhusrev@gmail.com>

Thank you for the testing!

Regarding number of channels. The Exynos850 spec says that ADC has 10
channels and, looking at the registers, the ADC_CON2 register (offset 0x4)
lists 10 channels as acceptable ones.
ACH_SEL bits [3:0] field in this register wants to see numbers from 0b0000
to 0b1001 (from 0 to 9) and lists numbers 1010 to 1111 as "Reserved".

So, I tend to say it is fine to have it set to 10 if it doesn't trigger
any hw issues.

Best regards,
Alexey
