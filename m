Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CEF390C8B
	for <linux-iio@vger.kernel.org>; Sun, 31 May 2026 15:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780241163; cv=none; b=qRAqq+jbLlZRmslbJAZAHCtIY88YXRzV3m06rSiW1aaMicN2GgtBT5LMBsut5T8fxLUXPxnRUtFPmxM5r0YUmWbkpUm7vhWan7LQD/JtHNEQM396SQxO6KcXvn4V49tbY9H9JczTrMNbwHaFE+FzAK+7QTpdNL+4A2manVhh/yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780241163; c=relaxed/simple;
	bh=AIY4P522I6mAiy1VKzYtffjJj8yluqaVUv3znf+Q8Qc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uXb5ZK56HjJDCllFu+8TaTWehDN2hVJsoD5+wDvcWArtAD1XiuYfXuD5RA170SqtQrkR+81WrP78z8iI8jsTxBeywTwGP1Ld5Rxj0wT4OVSovBjreneQ/woM2NgiPU7P6Txql01kVSfnly/s97gWsWNlGgSWTcD+hUQTsB5/A8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=GOIQtz21; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="GOIQtz21"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-45e9f4a3510so5417134f8f.1
        for <linux-iio@vger.kernel.org>; Sun, 31 May 2026 08:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1780241160; x=1780845960; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h/JC/lCvJB29DmlH+qRhnlQ7JKVcjCcbMoFC+b+6/88=;
        b=GOIQtz21a+dL5Cqsb/KNFX46FJEHhOl1wMC51UAxEaQTIOQ4DAGD6QvkweLLCv87wa
         yhD91JBiaxaClKIzUUkP7iUslWub1flQs23I1CMwxRLjoGN2lFkY3TrF36vjyaoJYWgj
         cPYximaA4XyFAwuUE4W1fhyFxv4tgc5ycHe7HU2i4nPFpEJx2W0amHewrCLroH66hPQU
         e2e/2NTnsM9BAvEjPZ4wIpdH7BCFwNEmyY/S3+g52d6bqsfN1rpTZAP1UDP5Fm8qDQJd
         hx3oGEQibzLh/Lh6gfJwRgUsiYPznkraROXc6Y+uILk61Io6yTqLOG/7Cgi/NIDCVEv5
         gOJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780241160; x=1780845960;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=h/JC/lCvJB29DmlH+qRhnlQ7JKVcjCcbMoFC+b+6/88=;
        b=mKrhyy/Xf1ajFr12zEl7RQCMTImxrrpPzYrnC1qzQovYZLBIvJoyYaGTOai520dCzS
         2IiZ7Y0tq625b8AfOh/HWRiT/UZn/bn/qFnqhuGAq/bVUAXJklkpGylW0ygQPd9raO9f
         QkmXjFWoeBQiL3FzRip3Yrvv/9xObJ5xgJbuETyZYIUG9eM1WL0RYX0XKfLEKLrM/Hm7
         eDMj36DovfPimOPzty5aW3gCx7RmRXIuoFed7d/U18EC6WkuZzMTjjBPHGTh+hFfXvh9
         WqMRTIusWERL3ipCJlMer7Bg9F64qcxM0zQgh7df0wupJ5s+JyA8IJa8+Jghv68Q/mbT
         J2Ww==
X-Forwarded-Encrypted: i=1; AFNElJ8vn/7pKGHBkj+SqqMYAB2gpIxIfHYvrAF464iqtcpusP4I/WX51SXNZeDmwrFu7AzDnZZwv1hj+ng=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTgb3FqbQ1KmN/h9cXC9buaYE+i63hCJtSPIO0WMVkBaZCpnKM
	Bnp4ABCYIrXxyNVB8ef3PUTBxTDa0mN46ncAnfBFpVNjT6m2waGeGk/3zv0s1jBS8CI=
X-Gm-Gg: Acq92OFfhF1ZVMTCsmw5Gho0GzX2Ty654TMxCv6oYGkhkXwTApItWI2nL2e4zGH7QZf
	G03BBKwPsAmdEy0W6af5h3bDfFzRHzUc4ahne7gSNJjqzfagRsWeeWHMcKWAy5fusF7jfgbX1Ir
	NOQsRRubEc8epIBp/1U28P6DdHwFq+F2mRVF4A3YMlDG9C8RVaDecmudnsdk8sJodtDjIKgBjGD
	fOdobUhpz8suYUHdbLXeNbN4Az/dwuuMntwGHRVldl0S8g4RS4gR2eV6MckMSIeJNqevkHkKUT4
	oL9G1yDDJpsKw4LfhRC7zQqXJCLEDVC72iWGeM/qTLtd5srfcfnnAc3hN7uUcI4okB1XkVwfpz9
	Bi+jEGt/arhT4qHAkG3T46zSRsDRuSBYfnb41o4DrTrGhkdwOr2DBGNhjKDe65DN6r6dC2VOy8i
	Ffe6IQh/wHgk9bdBJyOlT+TZxnJfnSHECnavWClV8gkg==
X-Received: by 2002:a5d:624e:0:b0:45d:3aa3:7f76 with SMTP id ffacd0b85a97d-45ef6b836a9mr11291781f8f.33.1780241160201;
        Sun, 31 May 2026 08:26:00 -0700 (PDT)
Received: from [192.168.0.2] ([2a07:7e81:7daa:0:202:c9ff:fe53:eda4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef354cf0dsm18526622f8f.17.2026.05.31.08.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 08:25:59 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Sun, 31 May 2026 17:25:55 +0200
Subject: [PATCH v4 02/11] m68k: mcf5441x: add clock for DAC channel 1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260531-wip-stmark2-dac-v4-2-7e65ab4215dd@baylibre.com>
References: <20260531-wip-stmark2-dac-v4-0-7e65ab4215dd@baylibre.com>
In-Reply-To: <20260531-wip-stmark2-dac-v4-0-7e65ab4215dd@baylibre.com>
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

