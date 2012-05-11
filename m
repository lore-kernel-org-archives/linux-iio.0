Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:47697 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759832Ab2EKNgU (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 11 May 2012 09:36:20 -0400
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: gregkh@linuxfoundation.org
Cc: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	thomas@free-electrons.com, patrice.vilchez@atmel.com,
	plagnioj@jcrosoft.com, jic23@kernel.org, nicolas.ferre@atmel.com
Subject: [PATCH 5/9] ARM: AT91: Add the ADC clock to the sam9x5 SoC file
Date: Fri, 11 May 2012 15:35:36 +0200
Message-Id: <1336743340-4578-6-git-send-email-maxime.ripard@free-electrons.com>
In-Reply-To: <1336743340-4578-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1336743340-4578-1-git-send-email-maxime.ripard@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-at91/at91sam9x5.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/mach-at91/at91sam9x5.c b/arch/arm/mach-at91/at91sam9x5.c
index 13c8cae..1b144b4 100644
--- a/arch/arm/mach-at91/at91sam9x5.c
+++ b/arch/arm/mach-at91/at91sam9x5.c
@@ -120,6 +120,11 @@ static struct clk adc_clk = {
 	.pmc_mask	= 1 << AT91SAM9X5_ID_ADC,
 	.type	= CLK_TYPE_PERIPHERAL,
 };
+static struct clk adc_op_clk = {
+	.name		= "adc_op_clk",
+	.type		= CLK_TYPE_PERIPHERAL,
+	.rate_hz	= 5000000,
+};
 static struct clk dma0_clk = {
 	.name		= "dma0_clk",
 	.pmc_mask	= 1 << AT91SAM9X5_ID_DMA0,
@@ -205,6 +210,7 @@ static struct clk *periph_clocks[] __initdata = {
 	&tcb0_clk,
 	&pwm_clk,
 	&adc_clk,
+	&adc_op_clk,
 	&dma0_clk,
 	&dma1_clk,
 	&uhphs_clk,
-- 
1.7.9.5

