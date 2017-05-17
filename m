Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35679 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753873AbdEQROL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 17 May 2017 13:14:11 -0400
Received: by mail-wr0-f195.google.com with SMTP id g12so2836235wrg.2
        for <linux-iio@vger.kernel.org>; Wed, 17 May 2017 10:14:10 -0700 (PDT)
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Ryan Mallon <rmallon@gmail.com>
Cc: Alexander Sverdlin <alexander.sverdlin@gmx.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>
Subject: [PATCH v4 2/5] clk: ep93xx: Add ADC clock
Date: Wed, 17 May 2017 19:13:49 +0200
Message-Id: <20170517171352.20369-3-alexander.sverdlin@gmail.com>
In-Reply-To: <20170517171352.20369-1-alexander.sverdlin@gmail.com>
References: <20170517171352.20369-1-alexander.sverdlin@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Alexander Sverdlin <alexander.sverdlin@gmx.de>

ADC and keypad controller clocks share the same control register, so use the
existing infrastructure to add ADC clock support for Cirrus Logic EP93xx SoCs.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
---
 arch/arm/mach-ep93xx/clock.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/mach-ep93xx/clock.c b/arch/arm/mach-ep93xx/clock.c
index b9cd9d7da14d..425342637e47 100644
--- a/arch/arm/mach-ep93xx/clock.c
+++ b/arch/arm/mach-ep93xx/clock.c
@@ -98,6 +98,13 @@ static struct clk clk_keypad = {
 	.enable_mask	= EP93XX_SYSCON_KEYTCHCLKDIV_KEN,
 	.set_rate	= set_keytchclk_rate,
 };
+static struct clk clk_adc = {
+	.parent		= &clk_xtali,
+	.sw_locked	= 1,
+	.enable_reg	= EP93XX_SYSCON_KEYTCHCLKDIV,
+	.enable_mask	= EP93XX_SYSCON_KEYTCHCLKDIV_TSEN,
+	.set_rate	= set_keytchclk_rate,
+};
 static struct clk clk_spi = {
 	.parent		= &clk_xtali,
 	.rate		= EP93XX_EXT_CLK_RATE,
@@ -214,6 +221,7 @@ static struct clk_lookup clocks[] = {
 	INIT_CK(NULL,			"pll2",		&clk_pll2),
 	INIT_CK("ohci-platform",	NULL,		&clk_usb_host),
 	INIT_CK("ep93xx-keypad",	NULL,		&clk_keypad),
+	INIT_CK("ep93xx-adc",		NULL,		&clk_adc),
 	INIT_CK("ep93xx-fb",		NULL,		&clk_video),
 	INIT_CK("ep93xx-spi.0",		NULL,		&clk_spi),
 	INIT_CK("ep93xx-i2s",		"mclk",		&clk_i2s_mclk),
-- 
2.12.2

