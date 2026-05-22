Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9DA3750CF
	for <linux-iio@vger.kernel.org>; Fri, 22 May 2026 21:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779484879; cv=none; b=R/7C4ctcXhZ9xjbr9Wyw8KNsI4ahHMjXgLfOeXdnFkjLIf3CquX08gbeNXqmxCJhVpZ7WG4kXtE0WbQ/h0Df3+DZ3MIo/r/1oFx8Bdhp8VU8Y1EIMsnOAYKx6ED6XxED2FP9/0yZtNNs4ITvIMsVqKuXzEhvhUQByamCzpplCm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779484879; c=relaxed/simple;
	bh=MIaaE/2mzFPAjGyRfiNactxhQ4J82Q69lpAJVLJ9J+4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bIp5aSLYG6cY4GogEAQ6B06d74SZ4YW7hyMkSdq52X/UeIbmIDXpz0m4ggi8hiMGyOKelVIrVMs5E3pDMpG63fghJh3sRzvGdEttJvUd6LglDK9uEdy0jHfGmRevPclhgdGB9HoApISLpiybE2hhxFLDMfK9FbGvB3TmRl5tMnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=nQepUvIG; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="nQepUvIG"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4904fd4f6aeso1817785e9.2
        for <linux-iio@vger.kernel.org>; Fri, 22 May 2026 14:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779484877; x=1780089677; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1oxdFj4Oh6M9kXl1w5/7S95bL1PgDTh+f8B3yZnortM=;
        b=nQepUvIG6zW4L+dk/meupG8qSB0+wafuoY+eWYFfQk8yXxrd8GdQw2xXQzEe5FHQMa
         rZ7fWxuy2muBBogX+tBvr/1z1X9oCzORBQlCxGEvsKVsFJCXgdAFCuNseiyMmPGQsUpo
         ZGIBPGi50QdE4ShZuyZvRJ/CfCwFy1Y+1iCBWWEdbdiZXYPrejBrGZLXJ4b5HSTvLtVu
         zDhvjYDpDxEpIZrMQrjTzR2NQNNIc8CpJrRGTv+8GHvadYC4k8QK2osY5TBaCrAgigCC
         qX/UvHM/boJRg1HViqRbIpTCiqWsdLt5ERJFPyZ7XrwH5Tr+FbYEybmNa2URhkw1UtJk
         8Rxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779484877; x=1780089677;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1oxdFj4Oh6M9kXl1w5/7S95bL1PgDTh+f8B3yZnortM=;
        b=F9C03Q7V6B4l9Sir1W9YS4u51NzLIXQVGAQmAEbcgCjikwpWtz4cVb8pv3KHa6sWXC
         2t1LUi8X/NVhIpBX4MTYrjSfP2vNwVCmbQsjbn3fs4HBUNIX1oU6UwSKuroinVmRDm9y
         DrUwZYlzt5BXvf+S1U6J9CfUBh+dwqjAImgblEThaIrOyDSo6Akp6zEHF/0gSNsDqRQq
         34OoUJPssKvfW/EFD7uOrAzVPwHDML+uMwy3v8otN4w/41SEsGuogjfZyrPioX8+pstu
         psv306kXpfoQg6uMlVGw3+RLg/Vbpxf58BJvu6gpeageGpv+aPbocwdAejfTkeJg61TG
         dZPQ==
X-Forwarded-Encrypted: i=1; AFNElJ/RVCeXMHridANJAEYHpGAlYLyEhiv5mC3UMIoNLYr7o7yRwdMUvFEHr1rhK3wBV8beHMzKgJRtrWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCPFaQtaA110vJR87OUumk3WZoWAEQ4jYsycRrNVTMt+HH5QUE
	Ou+Taba7NA1DFJImQCbvJ0BgbXYw+G7PZnMI9bfGQYGWxh7Yo3r8vMFBZHvFd/EjZrc=
X-Gm-Gg: Acq92OH+Bk4+nk8LpauktdGivRnIM2FAbr1UyUSlh1NOH7XAdQstKO8L2fTQIi0+Vko
	4XYEApDr97JpTzrRF2ngjQojkz1+5zqh4qGSF+UCLw+LVWzSqjUZjgcLBdA0Xsz5JmKrJg8G2UH
	0ZHO+hKVXEqGyVvS+SnKZ2G3xzSO/F8MS8meNNwp4vlZTsya5dhcmBFWwNq1zI1FyRLXLdKKpFV
	yOdPQDsViPVhp8JhtDXbj9QP77iPisgeyNCgZrgzhqxNSoNsjqvvfo/jG9d5feEyKh0Ka6eIaeb
	VZ809QSdOpRwKt2Kq38KwKGw2V6YHPSYHHI6UEVgoIMxS5IgREvUi/Q/BAbKMajEXJ7CMiWCFu8
	TYNiW3LYH8D/zYhvAh0sc8hbFOxtJfwRMy4qi8p+AWjA6hUWBRNfIV4hQFZqB6ko4pAbMrv1svE
	fCZ5vG6i5R/J5htMDXY/dFMHYR7W4q354hADHcYxIEcQ==
X-Received: by 2002:a7b:ca57:0:b0:490:4b89:535f with SMTP id 5b1f17b1804b1-4904b8956e5mr22552095e9.8.1779484876828;
        Fri, 22 May 2026 14:21:16 -0700 (PDT)
Received: from [192.168.0.2] ([2a07:7e81:7daa:0:62cf:84ff:feee:627])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490454a0b82sm73312225e9.9.2026.05.22.14.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 14:21:16 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Fri, 22 May 2026 23:20:29 +0200
Subject: [PATCH v3 01/11] m68k: mcf5441x: fix clocks numbering
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-wip-stmark2-dac-v3-1-16be0ad35a67@baylibre.com>
References: <20260522-wip-stmark2-dac-v3-0-16be0ad35a67@baylibre.com>
In-Reply-To: <20260522-wip-stmark2-dac-v3-0-16be0ad35a67@baylibre.com>
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

