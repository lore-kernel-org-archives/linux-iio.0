Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5579833AD85
	for <linux-iio@vger.kernel.org>; Fri, 12 Jun 2026 16:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781280869; cv=none; b=iIV8lymx9S7TRCERGlZGbuU0o0L5J+NOLqTVapiu53I/NMmolhcLw3qxSdRUk4X+oX4NpHAqAQpK8rRM3oLYbaLsI95Yn5efqK0UEeTozavj+AUE8X4WUg/UY6sDNKSDeI0OBlsK7Qhy4AePSCSkk8okTVOXSmXJR5xHtwt5xmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781280869; c=relaxed/simple;
	bh=iBJgYumyLmZ06Ll91fzabhgMTbaPApdwNrYiKE3VKu4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IoG0xL+1eL4UzUtJQ2yBNoS9gWYcvmGAvCsHjlim9IyfMq+y5uolsMjm0PijV+bgCj+9haQ1pK+ib1xh7N4SeGMMVFyZCEEDZrduKsMNF0S5rWjuzjDIZoyCfnRx89qU0tGqvxyCKP9LKDc+x+3RDy0d6AUvfdIboGGfmbmA3Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=bnSv28Ta; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="bnSv28Ta"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-43d26679a6aso725240fac.2
        for <linux-iio@vger.kernel.org>; Fri, 12 Jun 2026 09:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781280867; x=1781885667; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iBJgYumyLmZ06Ll91fzabhgMTbaPApdwNrYiKE3VKu4=;
        b=bnSv28TaqwuZq/QSVGB0kFCIzEOsQA5cCG+wozVc/b/FtQbjJV68FFdIC/xJIgQas6
         CRGXbZhPv4j7zdmUeuRWRfRDl+eyz5DR8HCXe8MrGyKGjBty6Uk+gu/EfgSX34bLn64R
         3tvFdrQJLyvcs9FApapVyVKYYDvbKql2zO2PFUfqHGRsNipm67EgXJJxsc6uw3wPQ2PE
         0kwY4JU7H59X6vwYv7Pb6VAsotqhNRNxOMIte9UWqn0ejeQwUNfzqMfSOMXaZBckVYj/
         s2aweMj8XTFgyNW+rj5cyz6UT0dxAtcAGfFgRYnFWpFPwSkX1bRzahB1sC/+BFfA32QD
         3Tzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781280867; x=1781885667;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iBJgYumyLmZ06Ll91fzabhgMTbaPApdwNrYiKE3VKu4=;
        b=dgRLfKGj5XcEzGSQAMb2AwnW2GgGTESvxCuYAxvZe36ylCePoYNjIbG7plcre/6PM1
         Gl5ciLPUE17lim/s4p03A1PnS0e8oWjGCGJq6P5mECJJiJNFawNwAGJ6I6kV3sui4g97
         ouwKj3zylOA4TcTePO4xmtSFSjl5YQG1lQtZSIxQMf4IAICgN8ouaQ3W6IOXvuAfYlXl
         xedMDgBdbEiyTxBOE+qXT78/x1HlER01z72CkwQQdLKqiqH0BCgMzuxpiWgVgUSQg7dV
         TyRrFf+7/ZhtZabxTWV/8sYdAWYVcpt9QT290z+GFHR/qOJ4XPP8VcHzmQ9azyVJr2HR
         r3vA==
X-Gm-Message-State: AOJu0Yzlcs4ZmuqgcKAOHkm5HmHXolCadv2iblRAfKnGQ/7E1sClA/yM
	bWZ+VjR+HU+HwlKPW1jVljZBji2c3hjBQd+7cdKt/8N6OBQ/vscdBHi52raBHcP5Bsc=
X-Gm-Gg: Acq92OHwGH8NgYrldflt3a8cJNcUbLgALbNIowTnpcgGVSg4fAsJXQVkvggSzbgH1+G
	gsrNPTZM32rN6pdVazN/MujtPdhQzZj/SzEE0CNAt/pPEAf6IzovhtHEWitBA3jm3DEYT7MM6uB
	/Qf5hqKqD9Ll22xy04kDLLWrrJNEQRnams9tMuX0vtViawu+3dRei50hBc5HqR2EkknacE/E8ip
	MMv6dJ+hQIJTcuMNDh61HyiSf6sS68vjndiYfIDOC2YmuJPEYQBGzVnH+qlBdRWC6XPBH7kw6NJ
	CwwIYvP+ZSNWtmQW7Ia8WgkGkbf+XwU5pI0dHze+ConTUEgTHffNmyqcUJTgmkB+dNRDhejMzl6
	XdY1DBLWPECvjTTu1wtBLtkjx03gNImAenOygYceJHNH0RNt2Y4C/T/oCbeA96YVuNjdW6RMEUk
	itsmyyMp7gYqPjDni4m0E7CNt5sY+Xa2+M8T4rWxFIE99qqJwh+3fITdCXCzVw7hP1NGpWDuU=
X-Received: by 2002:a05:6820:1992:b0:69d:81ec:1a61 with SMTP id 006d021491bc7-69edc76c613mr2675655eaf.46.1781280867362;
        Fri, 12 Jun 2026 09:14:27 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:cba0:23d4:353:6048? ([2600:8803:e7e4:500:cba0:23d4:353:6048])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4426b30ee99sm2065001fac.15.2026.06.12.09.14.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2026 09:14:26 -0700 (PDT)
Message-ID: <5beef321-021b-4432-b24b-f473661a41a2@baylibre.com>
Date: Fri, 12 Jun 2026 11:14:26 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iio: adc: Add TI ADS1220 driver
To: Nguyen Minh Tien <zizuzacker@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-kernel@vger.kernel.org
References: <20260610151342.44274-1-zizuzacker@gmail.com>
 <20260610151342.44274-3-zizuzacker@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260610151342.44274-3-zizuzacker@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/10/26 10:13 AM, Nguyen Minh Tien wrote:
> Add an IIO driver for the Texas Instruments ADS1220 24-bit delta-sigma
> SPI ADC. The driver supports single-ended and differential voltage
> channels described as device-tree child nodes, per-channel programmable
> gain (exposed through scale) and data rate (exposed through sampling
> frequency), the internal 2.048V reference, an external reference via a
> regulator, or the analog supply (AVDD) as a ratiometric reference,
> single-shot conversions and a DRDY-interrupt-driven triggered buffer.
> Conversions are gated either on the DRDY interrupt or, when no interrupt
> is wired, on a data-rate-derived delay. Runtime PM powers the device down
> between conversions.

As I mentioned in the DT binding review, I have a driver for ADS122C14
that I should be able to send to the mailing list next week. ADS1220
looks like a simpler version of that but shares many of the same features.

So I would suggest to check that out when I send it and see if we can
share the driver.

