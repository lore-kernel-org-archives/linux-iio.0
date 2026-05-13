Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778BE357D0E
	for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 09:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778663684; cv=none; b=akU6Ji24Y5s11qUSLpDhnnA0t/pF/kGwnHQ5j+buZ4bXvceT8vztvzqNV+8tYwyj6cflYSYj9Y132zAiZm5zRW7asAFTzTXnjk/Oa8v+ZgZnXHex+YeGPZtNqKXLWp+m38MhNhmoqML+S+tHFBtW/TAx/6zBF8L17kA9h/bYojk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778663684; c=relaxed/simple;
	bh=MIaaE/2mzFPAjGyRfiNactxhQ4J82Q69lpAJVLJ9J+4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mKVmMyZkNr+ywZHu47Po0oJMhj5IaTxXtaKms/hTNpu2NWyWlDBsOhAHvvDdP5wnLZhiji4JuzLl+cPNvqGDW/3TJmpF8D7hNI40O4nDwqwYpE1VQhJErsHEHWYxuytKnXnrJ2xxReotSaZz5rxhPUP5m8ohXjN2Bc3708vbktU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=BeDAs2nJ; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="BeDAs2nJ"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-453903ee4adso5638644f8f.3
        for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 02:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778663681; x=1779268481; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1oxdFj4Oh6M9kXl1w5/7S95bL1PgDTh+f8B3yZnortM=;
        b=BeDAs2nJkOhTbgWtUnLp0knNsfkowfGZxgwnXpoTT7wSZZBcfVsL5pRMJXTmJQY17e
         bLF0t/4woVkOPPpcL13jwvmbViuBlCU3/8yPi2VXrnkQWzzsOkc3KqjWWZB5pmnEr0yN
         LVXKGGrFK7DgD4geKwPFAa3hR9bqcCDKFe6hBUTlHFkrzOzuAVk/fj7IEowFywWWuawO
         7X4CgCIHq3K4Z3+VNcHqXjI5CRwHSRiiAAcHZ0m4TqKYibBMIi6RlxDQfdEjmjvOOO/9
         bXWlo/lNRT8Y4kw8lkwZ1rOdk1di+DtfA7wksuqKAVtsCGHT5jZSOz9HgSzG2kYtPIkG
         MBlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778663681; x=1779268481;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1oxdFj4Oh6M9kXl1w5/7S95bL1PgDTh+f8B3yZnortM=;
        b=dPv7QMuoIF74naMVZkhr6n7qO4eHbebV7PmN/ihJ+in9bz4oQ+BP0UAZWRbUZhmwCZ
         X6BCaQkIgqOBrQQwABgLhie2MnZkeF6kkESMImyJBWy1672KfDFcVhate0ln62md/PX0
         hA5ZeWgMUAUZPtZiCYhO3XQW0gRSY3JWyM/zwOZ41TSuUnHefV15EWFreXbZrWGGba4c
         5uL0WDDg8eUiDbrgdopFSSVxxrK9U+h+509CuIqS1gTyeROf7x37K/0JnyA4UioGRABu
         8px2AJnHcUcQNUmc8bdElJQVFfukVNBYKqWMgkIq5u4qj7RVmrxraaSxik+5tZxT8TDj
         cIBg==
X-Forwarded-Encrypted: i=1; AFNElJ+Xl9NTTuYfXKM43qsp5vplhYhQGmXk2W8mA8Su2zEe4Fh30sZnNs69xcZap/IHFZikYRjDR4q5tCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzvsmHUe2mHT5aQZ75H6oNDBB0iy67zQ+YLnpX1pzxM7abHvCp
	d60co5XcsVO4c9XxVf5zTgY2fLRQG81jrJAiatSdIzfpFEj2N77x4z9B6V5R+WetxeU=
X-Gm-Gg: Acq92OFaqqUKAQf7NB1Z0ShP58kxxCA2NjVXye7nVclhkET1U2WL0ZxCX3SlVAwXVNA
	Zgiq0J3/1ZqOkW9qbDbbh1FORMMBC5YLUN4Y+/Ik7w6Aqs0E50E552ahMAUeHrg6atRxQq9oNnS
	ApzwP0VS8fg0qhgovxuvjrXWA0D9I690ZRLiz1UOdrEJxjBG15/HiKk/aSqs/Ryfm97Ex26UDvT
	MWp8SdPPUti8kfFdwesXztKD/iFOYa2GwTlbfpxz+lbPC1mtcwaYqfsMC8D/EfDch/YVbxvmuvv
	29x9DfjP+xUXGeiHqFP+CSCjExovi6Ox6IoRsAVO/HuJciVyO/AnI0hLrM96KQQpGLEeeCIDSfO
	Wx/8kCCgyIq5zb8fKxAX6Om72xYpfJlO5tsG0xxy5MOz0dFdl1NvHv5KfRVainQo5Rnw5ZFQiOt
	jzpdxGySdfBExjd9BjSJzz/W1lvbTDoY8=
X-Received: by 2002:a5d:5f51:0:b0:453:f951:4e5b with SMTP id ffacd0b85a97d-45c584a86acmr3767577f8f.13.1778663680934;
        Wed, 13 May 2026 02:14:40 -0700 (PDT)
Received: from [192.168.0.2] ([2a07:7e81:7daa:0:62cf:84ff:feee:627])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548e6a66bfsm34590821f8f.4.2026.05.13.02.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 02:14:40 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Wed, 13 May 2026 11:14:25 +0200
Subject: [PATCH v2 01/11] m68k: mcf5441x: fix clocks numbering
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-wip-stmark2-dac-v2-1-fcdae50cf51a@baylibre.com>
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

