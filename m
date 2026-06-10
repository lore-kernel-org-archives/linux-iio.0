Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0473947ECD4
	for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 20:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781123716; cv=none; b=U+ATc2hCmX1j9vo1vohgdbnwYKhYe63MU5sla6LLpJy8MiNDxhaMcy6YXZ90F873cuHMRMfIy3Ca14lHhkRxC7dlFSHZQIqpGA8sqb6LQa7pfeo8JsZk/58eLc5/NzIFVyO0c9Ef9sPF+xshT65d1ro5GPGAzPQg+Mg2zBpyqZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781123716; c=relaxed/simple;
	bh=AIY4P522I6mAiy1VKzYtffjJj8yluqaVUv3znf+Q8Qc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pg2x7XauzZ/uH2M5G9iEI0NKwUfnMUTpfaL7sgxDeM2RwyJTAOURWK015maRS/BtTQj4oMrcLyemvLtJttTOmhw4FBtrpMXKZ6cZYPq8iQAjhE4+h7gp5WoF0yZRO7htX/fIRcugPkpaPfHTNgQOUhfCYoA5n6gvn4Pr0CJBolE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=JMKCsfra; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="JMKCsfra"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-490ae94a89eso61452175e9.1
        for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 13:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781123712; x=1781728512; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h/JC/lCvJB29DmlH+qRhnlQ7JKVcjCcbMoFC+b+6/88=;
        b=JMKCsfraLd1RJ4mtIV6EFNYO17F2ozHEaH6ofFrkfTIf5sN2sv3wTWKb5v8u7498MJ
         SvMzb9C4AklyLXLb8J+r3yL+yotId5te1NGXbbW50mIYIGS7ENAZ8MwXDQN3n57OzbQj
         UXpZ2EWtVF1pSN6Pb8ieIU/PqS+DrHh76ZSZxq2gj0XSIj01B5lMUygKSb2IkDS213Dl
         ZGBDXM6GvDHlctpToGdHgpdnhkWpH9Dp2Kw+DHAv8l6q1Nfuh30oy1HafbkxwquesAae
         /YQn5AqI6qiXSM0B7bOLvfeA99DFjOkkjxgbq9pH8pLsLuU9LihWYfDPLl/2p63fTdju
         kHWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781123712; x=1781728512;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=h/JC/lCvJB29DmlH+qRhnlQ7JKVcjCcbMoFC+b+6/88=;
        b=PRvLpZLlwFfSNvBpw17KCM3+NSAKwK40nRa88Bh8F6dRYa2+B4AkANLE+OA7DwpudM
         70fIgqUAYRujQbEUSKFKNj6sNuJ3NuLj2Sri1Xi7OQ/oMd7l28hUBxq20+Kpj4VlV7lq
         sihPf9jpiCmZy1NTjXG5G2U1+29zUMuumd8ZC24sVjPnPkfHblj5CsEFu/oRbsVP6Sti
         E2M6TZHoxGHacvYf8Sv0LQjzDsArPIjv/LWQAi8u2eTxOEAK+S6nqP19Sgk9raMUmLjf
         ICvtLjemBh7tB9+/b6kIxKZWKRXe3kVWrGio4MIZ70cnpuDraUvU97dCZwQ6VrLOf892
         XVdA==
X-Forwarded-Encrypted: i=1; AFNElJ+x+ASh9nbp+B6fDyE/Xeck51Uc25Vix505WJtviaOpKhdrLf7i9+Jz2fZkn6vQlPWQXf+ZytU/7Ss=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY+cTQc3U8KXjM9lW7HsCH/ZyXkIKQB3+8pKQC7ZSP41pouaSf
	S+VpIqj73Np1nAMqgtZPqd9yNaaSSKWPwoaTHJpYzhAT1YDFc01dP2s1Bi0uSTlDDrc=
X-Gm-Gg: Acq92OEAbIHA/ZKGakZG86roYTatm9U+C/DcrQJL5jH1pTxPEZrR0nqyKdpBaN5jzia
	67RYUymZcutPMpYoOPYZzGeCcudQ/ZejXl5DHjQRj8ufcG6NmKVEhmzndA2dYuLfOcFBfCVYzh+
	k6H5iELodfD5HmonxqG/G1WmFRMQt1Fhf+1qkQXVboGVeXOa2J2He0622/1ROUWZ0aPFz78MuL3
	6wCAkgQTtAeL5fhOoj17WMwSWDQJYcYLjZ2WJbLFbf8/RcxVMBQBUC+OUHiXdaQ02iCDwv6Vy2x
	vs+HqkMCuFF5atQPSMmKD0SsmDgd6hAEQNqbbumj83su3YCNdiDqU2sUPRnijFcXrzJ36UBt0tU
	VaEgb9wnQPbdvOWpK1AtJDmg6oeV84lbD+dd9Skmj1nLPFpGOLk28jBKSVmP0RtDW3vXwiCMnKb
	MiiuhCdf6Q/w09xrj45z+SrQUDnBCUV15cLR5Gua/qBQ==
X-Received: by 2002:a05:600c:628c:b0:48f:e26a:1744 with SMTP id 5b1f17b1804b1-490c25a87f5mr431093845e9.9.1781123712367;
        Wed, 10 Jun 2026 13:35:12 -0700 (PDT)
Received: from [192.168.0.2] ([2a07:7e81:7daa:0:202:c9ff:fe53:eda4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490dc4715e4sm62390975e9.0.2026.06.10.13.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 13:35:11 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Wed, 10 Jun 2026 22:35:07 +0200
Subject: [PATCH v5 02/10] m68k: mcf5441x: add clock for DAC channel 1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-wip-stmark2-dac-v5-2-b76b83366d5c@baylibre.com>
References: <20260610-wip-stmark2-dac-v5-0-b76b83366d5c@baylibre.com>
In-Reply-To: <20260610-wip-stmark2-dac-v5-0-b76b83366d5c@baylibre.com>
To: Greg Ungerer <gerg@linux-m68k.org>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, Steven King <sfking@fdwdc.com>, 
 Arnd Bergmann <arnd@arndb.de>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Greg Ungerer <gerg@uclinux.org>, linux-m68k@lists.linux-m68k.org, 
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.15.2

From: Angelo Dureghello <adureghello@baylibre.com>

Add missing clock for mcf5441x DAC channel 1.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 arch/m68k/coldfire/m5441x.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/m68k/coldfire/m5441x.c b/arch/m68k/coldfire/m5441x.c
index 613b0275d9d8..5b5e09ecf487 100644
--- a/arch/m68k/coldfire/m5441x.c
+++ b/arch/m68k/coldfire/m5441x.c
@@ -44,6 +44,7 @@ DEFINE_CLK(0, "mcfpit.3", 35, MCF_BUSCLK);
 DEFINE_CLK(0, "mcfeport.0", 36, MCF_CLK);
 DEFINE_CLK(0, "mcfadc.0", 37, MCF_CLK);
 DEFINE_CLK(0, "mcfdac.0", 38, MCF_CLK);
+DEFINE_CLK(0, "mcfdac.1", 39, MCF_CLK);
 DEFINE_CLK(0, "mcfrtc.0", 42, MCF_CLK);
 DEFINE_CLK(0, "mcfsim.0", 43, MCF_CLK);
 DEFINE_CLK(0, "mcfusb-otg.0", 44, MCF_CLK);
@@ -106,6 +107,7 @@ static struct clk_lookup m5411x_clk_lookup[] = {
 	CLKDEV_INIT("mcfeport.0", NULL, &__clk_0_36),
 	CLKDEV_INIT("mcfadc.0", NULL, &__clk_0_37),
 	CLKDEV_INIT("mcfdac.0", NULL, &__clk_0_38),
+	CLKDEV_INIT("mcfdac.1", NULL, &__clk_0_39),
 	CLKDEV_INIT("mcfrtc.0", NULL, &__clk_0_42),
 	CLKDEV_INIT("mcfsim.0", NULL, &__clk_0_43),
 	CLKDEV_INIT("mcfusb-otg.0", NULL, &__clk_0_44),
@@ -176,6 +178,7 @@ static struct clk * const disable_clks[] __initconst = {
 	&__clk_0_35, /* pit.3 */
 	&__clk_0_37, /* adc */
 	&__clk_0_38, /* dac.0 */
+	&__clk_0_39, /* dac.1 */
 	&__clk_0_44, /* usb otg */
 	&__clk_0_45, /* usb host */
 	&__clk_0_47, /* ssi.0 */

-- 
2.54.0

