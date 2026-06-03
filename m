Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB4730C15C
	for <linux-iio@vger.kernel.org>; Wed,  3 Jun 2026 01:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780449113; cv=none; b=Ntx61LAcTYceb4Xalam1DwAzbjiKo18DKlADfCnTyQrCfUJUki3cor6VMVBzI3MZm2H5G34UubkyFLHzwKv7Wi3P69/nKtxMFxTjimHTRgCqfwb9LjwT2sX7CKWG6SXvmJTiVi170xHVLKKF02eNt74ysJorFd7fDM+dUsSKrMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780449113; c=relaxed/simple;
	bh=pxsYJ1ePpzQuD5t0vTi+GN7ozjOM4QwjIHiqhvwy5NE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=l8r6Tcs5wtLciMm41N8PjROnGWcPDXC2PiTp+cim4wlHE4OOpH8wq7oaAALHryychu13av6Ox99bVJBhm7b0bczhfsB4v7ZHEVLvtVu2VRjDqpqjsVdcceXHvifRzBuBKbNLk8TuWmkYO5WZxGPfdnuOo9CBS76CZ6JlS6U+WHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rtVdKDuD; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rtVdKDuD"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-84234c83142so1353076b3a.1
        for <linux-iio@vger.kernel.org>; Tue, 02 Jun 2026 18:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780449109; x=1781053909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wfa0xqifL6vDOGACfxfGJ3JF4SFfMplxwiS2lFwtPkg=;
        b=rtVdKDuDFHOFEuFkxwFgAQwL/f2YaFezQ9KAYzGrcQ/Jy7nYJ+MbyRtQMvxAZaw+Gp
         51ta3AIgM89aS5lGjUzmhze40BIKYFGe+9VL1JXJvaeA3iQAvYkojsHvaeRfnunyqXF4
         pxwsSM/yUasjnlfWWqB8F05mOI2ElvVJgHmKYpZAKWVP8jQ1RIcjZ/buLrNz0sYmARup
         0bplJ1vJ5WT4ickbVszGW66LbzdYponzejsJcvOWCoMle/4OACm/9LzPKxj+HKx8ui20
         SiYPMS7LEmWPkNhqWm9xhSMjLpTD9wqve1wrmxAM5dCWWN3Jtgnm41L/KuSeMkYzgvXA
         rhiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780449109; x=1781053909;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wfa0xqifL6vDOGACfxfGJ3JF4SFfMplxwiS2lFwtPkg=;
        b=ac1B4Awlr6RdD+13rflQorHKk5v4265YgBR3PLvLofZ3W9fj2NdUyZUZROrIxs1hrN
         P3yCZ+Pf02QJs4gwe5pfG+xf+SWuqZSljnhqAj8ZHA5+GzmRnzzNbSoQQlGlXBnBBqiT
         VyBM3xwD1yzMvwHc5fBD7EKaTet1Fi4s0xsoTx1+ryDNcw5NMGAJdCdMP5gNHANe8F7L
         dZtkdd+FmLAah3sQswkhhSy8I4J8Tr230YtUsNl8KGobCv8Xq0JD0Cfn7JaV1EiLJxyS
         mnu6/IpbhutPZ7iTndEzEEr4IQDFRgmw9NhzkblrtwdZ1dXdixwgcv5TflX1JJOZWGOx
         SeJw==
X-Gm-Message-State: AOJu0YzBFHWMagmTcp6fA1enR7/hfJXIHT4QrFzhQAW/R0cuuzI8xHkO
	4bni4etkLJMQ5mT+xUq3h65gFGq6ezGaEzqDNuiLbdYn/JKN9/n/1+T5
X-Gm-Gg: Acq92OFOiky300++UHNxxL3jJuQjGYb6eun6fyP8x/syQjwFKw8Uk6LwcMNqadsmZH5
	Us5SSbdAf1Q4lrXpsYC5umWPgldh2CdE/YuNRikqlhveeGdzOQrvtf+fKrhZnH31CRGep2I04oE
	urxj4oC1Y1VH/1t25qgeHM+EUsDPamGUFKkdhqOlC/z43JWHcYaV4mmnW9gDhdQXfynzyRUPAXl
	UxLsCPynGh3DXVopE2+gp+7uN8VaSGEh9wsMS+NHSiX7cBOl5OLYgzoVQDLhX34hve2f33cftWY
	/OJGsBvFXwqTe3JnxW4U602Mt8GQqh2sZwCYzxxRLhxkl9mk1BVxJGKDtSr8+R1YOsg6AguiInt
	XHHCa5mtJrxWBetSu1tLpbKAKG03WypSjwb8EJZeD838chI5g0OmxpMTFhSCU5aQazwCDidpMZC
	zXxGiNOkAkMYbETnx8TBRuwLAF8uBzmp/lnvOHkpDlOIa7W4wrXKxVy2WlXw==
X-Received: by 2002:a05:6a00:1f06:b0:83c:928:6e5a with SMTP id d2e1a72fcca58-84284e22fd8mr1087363b3a.13.1780449108782;
        Tue, 02 Jun 2026 18:11:48 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2401:4900:8899:fcac:9fd7:3b2f:a800:e88c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842828fa877sm1081497b3a.51.2026.06.02.18.11.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2026 18:11:48 -0700 (PDT)
Date: Wed, 03 Jun 2026 06:41:43 +0530
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
To: rva333@protonmail.com,
 Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?ISO-8859-1?Q?Nuno_S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Lee Jones <lee@kernel.org>
CC: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, Ben Grisdale <bengris32@protonmail.ch>,
 Roman Vivchar <rva333@protonmail.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_2/4=5D_iio=3A_adc=3A_mt6323-au?=
 =?US-ASCII?Q?xadc=3A_add_mt6323_PMIC_AUXADC_driver?=
User-Agent: Thunderbird for Android
In-Reply-To: <20260602-mt6323-adc-v1-2-68ec737508ee@protonmail.com>
References: <20260602-mt6323-adc-v1-0-68ec737508ee@protonmail.com> <20260602-mt6323-adc-v1-2-68ec737508ee@protonmail.com>
Message-ID: <1F6728A6-BD73-4159-AAC9-82370212EF04@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 2 June 2026 6:16:55=E2=80=AFpm IST, Roman Vivchar via B4 Relay <devnull=
+rva333=2Eprotonmail=2Ecom@kernel=2Eorg> wrote:
>From: Roman Vivchar <rva333@protonmail=2Ecom>
>
>The mt6323 AUXADC is a 15-bit ADC used for system monitoring=2E This driv=
er
>provides support for reading various channels including battery and
>charger voltages, battery and chip temperature, current sensing and
>accessory detection=2E
>
>Add a driver for the AUXADC found in the MediaTek mt6323 PMIC=2E
>
>Tested-by: Ben Grisdale <bengris32@protonmail=2Ech> # Amazon Echo Dot (2n=
d Generation)
>Signed-off-by: Roman Vivchar <rva333@protonmail=2Ecom>
Hi Roman,
Thank you for the patch=2E
>---
> MAINTAINERS                     |   8 ++
> drivers/iio/adc/Kconfig         |  11 ++
> drivers/iio/adc/Makefile        |   1 +
> drivers/iio/adc/mt6323-auxadc=2Ec | 299 ++++++++++++++++++++++++++++++++=
++++++++
> 4 files changed, 319 insertions(+)
>
>diff --git a/MAINTAINERS b/MAINTAINERS
>index d1cc0e12fe1f=2E=2Ec9ad2417a3ef 100644
>--- a/MAINTAINERS
>+++ b/MAINTAINERS
>@@ -16256,6 +16256,14 @@ S:	Maintained
> F:	Documentation/devicetree/bindings/mmc/mtk-sd=2Eyaml
> F:	drivers/mmc/host/mtk-sd=2Ec
>=20
>+MEDIATEK MT6323 PMIC AUXADC DRIVER
>+M:	Roman Vivchar <rva333@protonmail=2Ecom>
>+L:	linux-iio@vger=2Ekernel=2Eorg

No need to add explicit iio list for driver=2E
Top level entry covers this driver=2E

>+L:	linux-mediatek@lists=2Einfradead=2Eorg (moderated for non-subscribers=
)
>+S:	Maintained
>+F:	drivers/iio/adc/mt6323-auxadc=2Ec
>+F:	include/dt-bindings/iio/adc/mediatek,mt6323-auxadc=2Eh
>+
> MEDIATEK MT6735 CLOCK & RESET DRIVERS
> M:	Yassine Oudjana <y=2Eoudjana@protonmail=2Ecom>
> L:	linux-clk@vger=2Ekernel=2Eorg
=2E=2E=2E
Thanks, Sanjay
>+MODULE_DESCRIPTION("MediaTek MT6323 PMIC AUXADC Driver");
>
