Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7B7481221
	for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 20:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781123714; cv=none; b=kZz20iHmeqLeB9FVY/P7lLabGOJ85znRyG9ygTh6XkYZE4zShhIPJ5O6mjAzPvXGBW+mVQ8jMHUi6mlXJtzOyFWxjrEQph3eJOvlJv9nVsW0iZc6CBTcMtXju/aY/MuoiAtQUp8OllIPqw2exHg98AHs31IU9FqY1xT2LIf3edU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781123714; c=relaxed/simple;
	bh=MIaaE/2mzFPAjGyRfiNactxhQ4J82Q69lpAJVLJ9J+4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dd1TZIL+OK3v4CQ1BakGk/fl93NkjgsXoBsxNz9w6Xf4DvlD7LzMc4rTq+i6LD8f6O0UdIwvm2YbKMVH21ZaCsY64j1Uum0hvRzQY0YQw6TziICQFTtueu9fAp16SoEjxIT7Nedoj5cVk0eGzlTIRARQgaA4HjUz/nqKmDFU1D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=DiHFcWQL; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="DiHFcWQL"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490bc6a7958so2528495e9.1
        for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 13:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781123711; x=1781728511; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1oxdFj4Oh6M9kXl1w5/7S95bL1PgDTh+f8B3yZnortM=;
        b=DiHFcWQLwW06F4CbyQhhBOSwTJTwX3QeNggIH6uhO/ksZYgWzeX4M/Jt0YJGw+KOu/
         /X1TyArypQSxXz/NGZHwHVYdDhqGEkAWlH66asnBE6v3/MOdkXfXlfLPd14oRyn9lrjB
         Ty2ji6RzY6DoG8e9g2gKlnKOpNVpqrJO9rY1cTo/uCq5nDGQ8Ac+pjC8ZLY/4A5KDcq7
         Nx7JAg4PQnjr2Xarg7VVvuf2X4jWkEzqIBYz6ldVTSPm9LBCFQXeTkocI3Pkn7Y5CgQo
         2MCoSWJLxMfFjVg7AVvnqb4BsUyiljoywMHiWVZxCSAt8w4katL8wM5iQBaApJkTyKXZ
         iTyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781123711; x=1781728511;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1oxdFj4Oh6M9kXl1w5/7S95bL1PgDTh+f8B3yZnortM=;
        b=q1UDCx5L1y6X2dZNY7folTKUvBDrDepkEWqqCc4qHaXB8AhYWbYt6ijjw0z4LTk7Ql
         n1BhTeoUfjo1qfwWbVZdpaArDSKFtZpaAkUorHKIswi9HT+KjclHHrUdvldYk6Q4NOgg
         uy07cpNsA36pEv6LDA3muNwkrZ3wYHDSAtqMXZYJcY1q4oGUcs5sXr9cffZznQCkl+id
         3qgbpJbBU/Ggf5BxS8pPxL0xKt8oHwJ4GCh+DykAjlngB1KpYGlOZrIQKscWA1nt2LHx
         xYcDRaG9FymKV8/8xCQoLmTGlWJG5TcS7HDVPHAAi7coP0CsCFsSc2of4R9VqofRe01Y
         1zfQ==
X-Forwarded-Encrypted: i=1; AFNElJ+jtK4B0xwtBci8NDLmW1qYKKLD7AYfjPihHjieC9YyKeR0UGhKyHcWJIyc2I3Igy6hNbzUYrvo8hw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUgpCsM7LlXhj4ROi9eNF/PZxtxKsO5a5skHp8Fw61WSnpbbWG
	DkPdyYpcEBjfgljxtWqFiFhzV5KQ24IRJ5CzZliVgQgoSSHG9+Fdkm6ORReK9L73QE8=
X-Gm-Gg: Acq92OETOU2vjUaM44G3yPW5tGoSYeNxcktXQ4zr2oSXFvH60uY9fO0FJI9yolGVkmD
	6cJ/LRaOpzERoW/CFMryG6+o3Ah4NAPpAc8wYCMPRQmKyvU8mCUiM7Zt2YeKs//CXlF9yRK8JQQ
	VRg1dxl1Rj9Ux5yzg6CopMQIf0yhCj3589f+BiWhJs3Oj9XRqQkM+vzEgUJLs6Urj/yzmRca0pg
	HiTu7Rxqzgh7rskdy6YQpDejRjBIR5/vpLQEkkmYfCaNO96gThIA4PGJbxGOAWfrcoZMuuMo4oy
	QFnRe32hAyHk/iPHPuwm4X4HoY/JoJ9w6QyNPoCk2Xkkww0ZVXnye4xpjMQ5a3byB2nY8CJGKOa
	k51fNwBISkQe04L4Wu3xpYPXjGDLngYipWqCvJw8deF4DPzgGdDgAfPb5gw+BWVF2/2ZKvj4aLn
	zvn1/NMJncVGOZtqwYHdR/CD3H3NP7dusU8Rtw8Q33Mg==
X-Received: by 2002:a05:600c:3d96:b0:490:e19b:9632 with SMTP id 5b1f17b1804b1-490e34ce241mr1647825e9.17.1781123711199;
        Wed, 10 Jun 2026 13:35:11 -0700 (PDT)
Received: from [192.168.0.2] ([2a07:7e81:7daa:0:202:c9ff:fe53:eda4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490dc4715e4sm62390975e9.0.2026.06.10.13.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 13:35:10 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Wed, 10 Jun 2026 22:35:06 +0200
Subject: [PATCH v5 01/10] m68k: mcf5441x: fix clocks numbering
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-wip-stmark2-dac-v5-1-b76b83366d5c@baylibre.com>
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

