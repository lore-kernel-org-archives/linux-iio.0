Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7D63E557B
	for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 09:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778663686; cv=none; b=lrYreZc4aQaJGj+6dgfsz9NnHWIpQlzK/BNRAVDAWghtrXI0MhJ10Z415pZTY3nhcB6aL9veYKF7RlHC2TmQcFbckC6/eG/LUZsRAaPu7Fm1QiMuMmoBKCBR6VO2mJI4dZzC5YLQPR59T5CpazFhJALktIvH5dysLaV1lVielMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778663686; c=relaxed/simple;
	bh=AIY4P522I6mAiy1VKzYtffjJj8yluqaVUv3znf+Q8Qc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sydTssVjarmnqfHwG2hnmkGeOkmDNO9htCxgqLO2fbhRHS7dZ5B4BEi41GAUJjUQmvdEYVR4ZeW+1b3ZarBuEj2MJzD+vrHnVHMHNigAg8kk2M2lt6jg3/MBc2dXrSx2oWQE1t4Ybe55WdIoeV93BYJmecMZ+73arDqx8OfMGP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=HarvkM4E; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="HarvkM4E"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-44a74032ff8so4851537f8f.1
        for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 02:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778663683; x=1779268483; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h/JC/lCvJB29DmlH+qRhnlQ7JKVcjCcbMoFC+b+6/88=;
        b=HarvkM4EyJbaRPicpImOI2aAyAW+T08niXnbK0BZ79xcSiEu+22nqg093OEL6k0ExF
         eDVq/UOKqpllwvo2q7TTtvXTUN9uAzJbAO4ypD1Wso8pf69ag9FWO5LfnUejVgpBgRxC
         +o97XW+SWgaA3a9WOn7QgNIxo9dux5nGUmZMc9T3eJTPr25/0hB7ox+ZWfgcNezEBWSn
         tWrLcmJSklOQtNoFrEteX/rlZYI4YUqHSAOQsQ7uIhDPuoHQNjbO6fNlE0qc/TA9tPdN
         4Msw6XVpwOeHgU98P/w/xC/fU7niAXz4+g5QA/P78PcM9HqGQYUo2xcjoOL7OY7SH4dl
         lCTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778663683; x=1779268483;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=h/JC/lCvJB29DmlH+qRhnlQ7JKVcjCcbMoFC+b+6/88=;
        b=JJFDS6Rzw8jKcC6ceDiFTOWps1RvtcB2k1kU6PBwLdHH3CRdGxU+Sm7yg5PWXy5bpp
         KTtmllCHFsHoGscxCkHrETjuWlrCTZyik4JfCZjPimzLJKqVm5boPYVVOTfckI5xHtV3
         m1656Tc1+I7hSu+LqSB+UOtUWajyZGsRoSYA5Z4EfUnvJ0PXuOQoL2m8pAQT4Pxr4NjK
         GAgzNWc0tviiA1+3DrlRv8CgVZH/47GYo1/nyKnCtRb9IAQi/jFsoMcVw+XDY884x0Xu
         62u5ejBP5plejHY425+m8zAGHFoIo7+6d++SgwyMeQ3sv29KokKZ10eeTQU5U4JnhhJ4
         nRow==
X-Forwarded-Encrypted: i=1; AFNElJ/ceBFRhY0yKx7ktOzNbGQWk7kkdQvD/WfSC8X8zMocxEw/LnNLuc1bUmwxKUbKyRrRW93kw3sclMA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2vy959LRIc6PGGw2lmrvFv0XmAI4AHwXPNUdyT+YCVnx/IEt0
	Ez1E70yqYl/hTVHyFjw3biFuVgWT//nK83b6VJQ4gfgFEe8RDn1/qkkksJ6MXYt1OiE=
X-Gm-Gg: Acq92OEABmqa8yiQD7vczb5/cqTOuRowNnGkZCjethki400vM1zTcdq3rjHzz6gMLET
	6o0XN5R2eib1GBNvWNnECr8uxoLjUkIIW3oag1LNk3klvmCH97kliRkY7bPH1Vwnqs3Lol151HQ
	Qpq45PM19zp7RAp7pszsbF/QfrszK2VR3M/Y3BOJIw39DZDwDCbn2P43Rkk0yZdKlur9Br/0lkR
	ky4u2ZP9MFvfjEqqRSVxOegZDcA2WsM6ps5b60ugmJR7i01L/D7SoA8JyIA8NtO11IisZjDJd6h
	n6kC+agDVEYUHnw6YISxykFRqDLwqYB60yBxOxm7ZFouV+mR/uhAkoa3b/zDHPgvwNHWEdJs92H
	Btbda+cDvzl2VCBfDF8ZdyxIE0Nap9i3BKizNv+1ZeQJpscg8NKi3wXSP/KS5MN3vtQcg8ULTVD
	oKdgo8YsX9DmSo+adBAXkD3Yw2wSLeYYo=
X-Received: by 2002:a05:6000:400f:b0:45a:c0e1:37b with SMTP id ffacd0b85a97d-45c7b470819mr3099954f8f.32.1778663682506;
        Wed, 13 May 2026 02:14:42 -0700 (PDT)
Received: from [192.168.0.2] ([2a07:7e81:7daa:0:62cf:84ff:feee:627])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548e6a66bfsm34590821f8f.4.2026.05.13.02.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 02:14:41 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Wed, 13 May 2026 11:14:26 +0200
Subject: [PATCH v2 02/11] m68k: mcf5441x: add clock for DAC channel 1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-wip-stmark2-dac-v2-2-fcdae50cf51a@baylibre.com>
References: <20260513-wip-stmark2-dac-v2-0-fcdae50cf51a@baylibre.com>
In-Reply-To: <20260513-wip-stmark2-dac-v2-0-fcdae50cf51a@baylibre.com>
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

