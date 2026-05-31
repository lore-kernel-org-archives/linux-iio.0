Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549803546D0
	for <linux-iio@vger.kernel.org>; Sun, 31 May 2026 15:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780241162; cv=none; b=ECuoNDAvWOdXostkZqIhyhq5UYE/lqklxC2Qzk9OJsZlChOuIF7+Jo40O1W/ZNNydljqykK8dyHku/InLK4Aic96bZixcQT2nRENpwAchnY74wObZsrh0rMlQ0HCYUvkCFfqWkwJ+ksUIPgdk1v5PVpKeRyvYCkX2y+EAc00g8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780241162; c=relaxed/simple;
	bh=MIaaE/2mzFPAjGyRfiNactxhQ4J82Q69lpAJVLJ9J+4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lBaNmzYZFHDRaMm4tTevYdCs4OPHBdhzFUt+Pg94HbyVQfXCUu6O9pNVPPNLALZZLz83+FqzdeZlGBpxGEkbrls/dYq+AoBOHxM9Fg1xDuH1ufQavZWsx/1OeLTBZg6d71aFvSOGKvgqB5k/ZjYRp7Z/rDJvWuLmFR8o7vaalT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=Am0a1Dy8; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="Am0a1Dy8"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490a765d410so6421605e9.1
        for <linux-iio@vger.kernel.org>; Sun, 31 May 2026 08:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1780241159; x=1780845959; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1oxdFj4Oh6M9kXl1w5/7S95bL1PgDTh+f8B3yZnortM=;
        b=Am0a1Dy8jtfFD13Ck3w+AmmzZ+FLwQMxHAPKHSu4tDxgogIUUFkhH07pAmysdTFqJ5
         OU+22/4zSjGiKFivGe+7kn41GJ7ghqGaFMzNFxEhYM9PRF/kA1mM/nb82iGTFc3qCF3j
         hfg1pXyiEuZ/pel8JLHnqdKzEolDdqrAqtljlBX2R/7N5zWimHp5FZpYBD0SoH69flHF
         a01+3ktPvFKr1yMLqBwKCGV+mcBPnDdP9BvQtstXQuG+CQzZ7Wpoplpiam53mhklSORn
         v1NMw8eSh3VoO+5a8GB5+A/kW4oKBNaDgGwriime8m0/fT4qtvpD7t9q4hrAPdmlq620
         kXTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780241159; x=1780845959;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1oxdFj4Oh6M9kXl1w5/7S95bL1PgDTh+f8B3yZnortM=;
        b=bczWXLe8xS0RvQfl7S6nO04l+BtVj4bk8uyjuj6/fQEqoCwwfbam8KC46VhKi2GNGx
         V8yqDjBj/ZxqK0c4If6DXXf//zV9ZyipykclEpcNJHfTaY0i45Y7lLwOEquoI8JyfZ2P
         FFMNwxrgbdgdC6FN6ISZAsMQzUCblAGXWM5s1tortOC/AkeF5B6HWpN+YbQwr2gAk6lT
         58y+Yc7vmsXmqXiY4oP9EbquU4GcXStGNvmBCU0WK45OroQTpHqyYcnPuqAvqVMvCTxx
         aU6VKnbFZEekIvCXYGsNZE5jl6TH6wiMO07RogCNkNn0zYnW+uujFWi3XWEp4vk4t6T6
         kL1Q==
X-Forwarded-Encrypted: i=1; AFNElJ+Se0pA/fga/o8YYhsIVFwV+exGj5gbCZtqkYh0H5bNhhHglrh4WgAREqpC0vrcmqBuWto+tIMTd8w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrFVT76d3klM2Hr22Op5zFuC6IXTKN9noFlPM24FPmnCCeH1bc
	sZmxqTshWRCpRaI3PUWxzkIPCjLQPDFUwFE5UWljZ+EHzancVO3XgZKDiSECf1o+iD8=
X-Gm-Gg: Acq92OGPjYoW62JC49ZlD0EYKRJIaLWgGnMmPxjqL0IDj9JN2cfFxGZTnECcftnh8oO
	ZxQBrT3g2BlgPs/hfGkD/HAuHW/HQkjdt1E/3zIInMaJZwiDbtaQFZqf6JJmFyo9fiNF/I6r6K9
	Z1FNCfmGZWrBu48iitp1/VK79wiU1unkOWRDcvwZToVj4p3R1QtN9eT/kFmxhjALZv8/X37/7V5
	TnCUBRCj/aSi5UtCiUO046TXGIQk7C/5Vk2Dp9o+c3SARzoNDJwpGC8QCc4lzZzushQ+N+vdh/0
	nyMHlUXASkYUpCrbBfYRSNtOpuIoE2BhlqlACMyuZM+m85fVyXRU+oJUgm6ipRDOEV4Ixs/Ksmu
	e7EVTwZXu9U8C7ZdE06zDzssTivaz3vxuTNsTK48qq6ghKV9sl7wrZrTF+LNJEUQy9kf3i6IgsO
	efvN/2hUs9qpo93E2mQhl8aDGR+CU1iogRUO8cqjXqyQ==
X-Received: by 2002:a05:600c:5306:b0:490:a455:f882 with SMTP id 5b1f17b1804b1-490a455f915mr130621895e9.24.1780241158784;
        Sun, 31 May 2026 08:25:58 -0700 (PDT)
Received: from [192.168.0.2] ([2a07:7e81:7daa:0:202:c9ff:fe53:eda4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef354cf0dsm18526622f8f.17.2026.05.31.08.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 08:25:58 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Sun, 31 May 2026 17:25:54 +0200
Subject: [PATCH v4 01/11] m68k: mcf5441x: fix clocks numbering
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260531-wip-stmark2-dac-v4-1-7e65ab4215dd@baylibre.com>
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

Fix clocks numbering, set correct values for eport and DAC,
as per RM Rev 5, 05/2018, table 9.5.

Fixes: bea8bcb12da09 ("m68knommu: Add support for the Coldfire m5441x.")
Fixes: 007f84ede6e3e ("m68k: coldfire: remove private clk_get/clk_put")
Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 arch/m68k/coldfire/m5441x.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/m68k/coldfire/m5441x.c b/arch/m68k/coldfire/m5441x.c
index 6ce730098ff6..613b0275d9d8 100644
--- a/arch/m68k/coldfire/m5441x.c
+++ b/arch/m68k/coldfire/m5441x.c
@@ -41,9 +41,9 @@ DEFINE_CLK(0, "mcfpit.0", 32, MCF_BUSCLK);
 DEFINE_CLK(0, "mcfpit.1", 33, MCF_BUSCLK);
 DEFINE_CLK(0, "mcfpit.2", 34, MCF_BUSCLK);
 DEFINE_CLK(0, "mcfpit.3", 35, MCF_BUSCLK);
-DEFINE_CLK(0, "mcfeport.0", 37, MCF_CLK);
-DEFINE_CLK(0, "mcfadc.0", 38, MCF_CLK);
-DEFINE_CLK(0, "mcfdac.0", 39, MCF_CLK);
+DEFINE_CLK(0, "mcfeport.0", 36, MCF_CLK);
+DEFINE_CLK(0, "mcfadc.0", 37, MCF_CLK);
+DEFINE_CLK(0, "mcfdac.0", 38, MCF_CLK);
 DEFINE_CLK(0, "mcfrtc.0", 42, MCF_CLK);
 DEFINE_CLK(0, "mcfsim.0", 43, MCF_CLK);
 DEFINE_CLK(0, "mcfusb-otg.0", 44, MCF_CLK);
@@ -103,9 +103,9 @@ static struct clk_lookup m5411x_clk_lookup[] = {
 	CLKDEV_INIT("mcfpit.1", NULL, &__clk_0_33),
 	CLKDEV_INIT("mcfpit.2", NULL, &__clk_0_34),
 	CLKDEV_INIT("mcfpit.3", NULL, &__clk_0_35),
-	CLKDEV_INIT("mcfeport.0", NULL, &__clk_0_37),
-	CLKDEV_INIT("mcfadc.0", NULL, &__clk_0_38),
-	CLKDEV_INIT("mcfdac.0", NULL, &__clk_0_39),
+	CLKDEV_INIT("mcfeport.0", NULL, &__clk_0_36),
+	CLKDEV_INIT("mcfadc.0", NULL, &__clk_0_37),
+	CLKDEV_INIT("mcfdac.0", NULL, &__clk_0_38),
 	CLKDEV_INIT("mcfrtc.0", NULL, &__clk_0_42),
 	CLKDEV_INIT("mcfsim.0", NULL, &__clk_0_43),
 	CLKDEV_INIT("mcfusb-otg.0", NULL, &__clk_0_44),
@@ -156,7 +156,7 @@ static struct clk * const enable_clks[] __initconst = {
 	&__clk_0_27, /* uart3 */
 
 	&__clk_0_33, /* pit.1 */
-	&__clk_0_37, /* eport */
+	&__clk_0_36, /* eport */
 	&__clk_0_48, /* pll */
 	&__clk_0_51, /* esdhc */
 
@@ -174,8 +174,8 @@ static struct clk * const disable_clks[] __initconst = {
 	&__clk_0_32, /* pit.0 */
 	&__clk_0_34, /* pit.2 */
 	&__clk_0_35, /* pit.3 */
-	&__clk_0_38, /* adc */
-	&__clk_0_39, /* dac */
+	&__clk_0_37, /* adc */
+	&__clk_0_38, /* dac.0 */
 	&__clk_0_44, /* usb otg */
 	&__clk_0_45, /* usb host */
 	&__clk_0_47, /* ssi.0 */

-- 
2.54.0

