Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from nasmtp02.atmel.com ([204.2.163.16]:47655 "EHLO
	SJOEDG01.corp.atmel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753630Ab3JHD4J (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 7 Oct 2013 23:56:09 -0400
From: Josh Wu <josh.wu@atmel.com>
To: <jic23@kernel.org>, <dmitry.torokhov@gmail.com>
CC: <linux-iio@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<maxime.ripard@free-electrons.com>, <plagnioj@jcrosoft.com>,
	<nicolas.ferre@atmel.com>, <thomas.petazzoni@free-electrons.com>,
	<mark.rutland@arm.com>, <b.brezillon@overkiz.com>,
	Josh Wu <josh.wu@atmel.com>, <devicetree@vger.kernel.org>
Subject: [PATCH 2/3] iio: at91: move the num_channels from DT to driver itself
Date: Tue, 8 Oct 2013 11:48:55 +0800
Message-ID: <1381204136-32322-3-git-send-email-josh.wu@atmel.com>
In-Reply-To: <1381204136-32322-1-git-send-email-josh.wu@atmel.com>
References: <1381204136-32322-1-git-send-email-josh.wu@atmel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

CC: devicetree@vger.kernel.org
Signed-off-by: Josh Wu <josh.wu@atmel.com>
Acked-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 .../devicetree/bindings/arm/atmel-adc.txt          |    1 -
 drivers/iio/adc/at91_adc.c                         |   12 +++++-------
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/atmel-adc.txt b/Documentation/devicetree/bindings/arm/atmel-adc.txt
index 723c205..0e65e01 100644
--- a/Documentation/devicetree/bindings/arm/atmel-adc.txt
+++ b/Documentation/devicetree/bindings/arm/atmel-adc.txt
@@ -7,7 +7,6 @@ Required properties:
   - interrupts: Should contain the IRQ line for the ADC
   - atmel,adc-channels-used: Bitmask of the channels muxed and enable for this
     device
-  - atmel,adc-num-channels: Number of channels available in the ADC
   - atmel,adc-startup-time: Startup Time of the ADC in microseconds as
     defined in the datasheet
   - atmel,adc-vref: Reference voltage in millivolts for the conversions
diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index cee04a4..22cf61d2 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -43,6 +43,7 @@ struct at91_adc_caps {
 	/* startup time calculate function */
 	u32 (*calc_startup_ticks)(u8 startup_time, u32 adc_clk_khz);
 
+	u8	num_channels;
 	struct at91_adc_reg_desc registers;
 };
 
@@ -502,13 +503,6 @@ static int at91_adc_probe_dt(struct at91_adc_state *st,
 	}
 	st->channels_mask = prop;
 
-	if (of_property_read_u32(node, "atmel,adc-num-channels", &prop)) {
-		dev_err(&idev->dev, "Missing adc-num-channels property in the DT.\n");
-		ret = -EINVAL;
-		goto error_ret;
-	}
-	st->num_channels = prop;
-
 	st->sleep_mode = of_property_read_bool(node, "atmel,adc-sleep-mode");
 
 	if (of_property_read_u32(node, "atmel,adc-startup-time", &prop)) {
@@ -534,6 +528,7 @@ static int at91_adc_probe_dt(struct at91_adc_state *st,
 		goto error_ret;
 
 	st->registers = &st->caps->registers;
+	st->num_channels = st->caps->num_channels;
 	st->trigger_number = of_get_child_count(node);
 	st->trigger_list = devm_kzalloc(&idev->dev, st->trigger_number *
 					sizeof(struct at91_adc_trigger),
@@ -779,6 +774,7 @@ static int at91_adc_remove(struct platform_device *pdev)
 #ifdef CONFIG_OF
 static struct at91_adc_caps at91sam9260_caps = {
 	.calc_startup_ticks = calc_startup_ticks_9260,
+	.num_channels = 4,
 	.registers = {
 		.channel_base = AT91_ADC_CHR(0),
 		.drdy_mask = AT91_ADC_DRDY,
@@ -791,6 +787,7 @@ static struct at91_adc_caps at91sam9260_caps = {
 
 static struct at91_adc_caps at91sam9g45_caps = {
 	.calc_startup_ticks = calc_startup_ticks_9260,	/* same as 9260 */
+	.num_channels = 8,
 	.registers = {
 		.channel_base = AT91_ADC_CHR(0),
 		.drdy_mask = AT91_ADC_DRDY,
@@ -803,6 +800,7 @@ static struct at91_adc_caps at91sam9g45_caps = {
 
 static struct at91_adc_caps at91sam9x5_caps = {
 	.calc_startup_ticks = calc_startup_ticks_9x5,
+	.num_channels = 12,
 	.registers = {
 		.channel_base = AT91_ADC_CDR0_9X5,
 		.drdy_mask = AT91_ADC_SR_DRDY_9X5,
-- 
1.7.9.5

