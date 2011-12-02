Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:35885 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756812Ab1LBPfi (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 2 Dec 2011 10:35:38 -0500
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: linux-iio@vger.kernel.org
Cc: Patrice Vilchez <patrice.vilchez@atmel.com>,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH 4/5] AT91:IIO: Move the SoC specific informations to the ADC driver
Date: Fri,  2 Dec 2011 16:35:03 +0100
Message-Id: <1322840104-3525-5-git-send-email-maxime.ripard@free-electrons.com>
In-Reply-To: <1322840104-3525-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1322840104-3525-1-git-send-email-maxime.ripard@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-at91/at91sam9260_devices.c |    9 -----
 drivers/staging/iio/adc/at91_adc.c       |   51 ++++++++++++++++++++++++++---
 include/linux/platform_data/at91_adc.h   |   11 +------
 3 files changed, 46 insertions(+), 25 deletions(-)

diff --git a/arch/arm/mach-at91/at91sam9260_devices.c b/arch/arm/mach-at91/at91sam9260_devices.c
index 3575019..95b3127 100644
--- a/arch/arm/mach-at91/at91sam9260_devices.c
+++ b/arch/arm/mach-at91/at91sam9260_devices.c
@@ -1366,15 +1366,6 @@ void __init at91_add_device_adc(struct at91_adc_data *data)
 	if (test_bit(3, &data->channels_used))
 		at91_set_A_periph(AT91_PIN_PC3, 0);
 
-	/*
-	 * The electrical characteristics part of the AT91SAM9G20 datasheet
-	 * sets the ADC clock to 5MHz.
-	 */
-	data->adc_clock = 5000000;
-
-	data->num_channels = 4;
-	data->startup_time = 10;
-
 	adc_data = *data;
 	platform_device_register(&at91_adc_device);
 }
diff --git a/drivers/staging/iio/adc/at91_adc.c b/drivers/staging/iio/adc/at91_adc.c
index d10df7a..b357363 100644
--- a/drivers/staging/iio/adc/at91_adc.c
+++ b/drivers/staging/iio/adc/at91_adc.c
@@ -24,6 +24,20 @@
 #include <linux/platform_data/at91_adc.h>
 
 #include <mach/at91_adc.h>
+#include <mach/cpu.h>
+
+struct at91_adc_desc {
+	/* ADC Clock as specified by the datasheet, in Hz. */
+	u32 clock;
+	/*
+	 * Global number of channels available (to specify which channels are
+	 * indeed used on the board, see the channels_used bitmask in the
+	 * platform data).
+	 */
+	u8 num_channels;
+	/* Startup time of the ADC, in microseconds. */
+	u8 startup_time;
+};
 
 struct at91_adc_state {
 	struct clk *clk;
@@ -35,8 +49,26 @@ struct at91_adc_state {
 	void __iomem *reg_base;
 	unsigned int vref_mv;
 	unsigned long channels_mask;
+	bool irq_enabled;
+	struct at91_adc_desc *desc;
 };
 
+static struct at91_adc_desc at91_adc_desc_sam9g20 = {
+	.clock = 5000000,
+	.num_channels = 4,
+	.startup_time = 10,
+};
+
+static int at91_adc_select_soc(struct at91_adc_state *st)
+{
+	if (cpu_is_at91sam9g20()) {
+		st->desc = &at91_adc_desc_sam9g20;
+		return 0;
+	}
+
+	return -ENODEV;
+}
+
 static inline u32 at91_adc_reg_read(struct at91_adc_state *st,
 				    u8 reg)
 {
@@ -72,18 +104,19 @@ static irqreturn_t at91_adc_eoc_trigger(int irq, void *private)
 static int at91_adc_channel_init(struct iio_dev *idev,
 				struct at91_adc_data *pdata)
 {
+	struct at91_adc_state *st = iio_priv(idev);
 	struct iio_chan_spec *chan_array;
 	int bit, idx = 0;
 
 	idev->num_channels = bitmap_weight(&pdata->channels_used,
-					   pdata->num_channels);
+					   st->desc->num_channels);
 	chan_array = kcalloc(idev->num_channels, sizeof(struct iio_chan_spec),
 			     GFP_KERNEL);
 
 	if (chan_array == NULL)
 		return -ENOMEM;
 
-	for_each_set_bit(bit, &pdata->channels_used, pdata->num_channels) {
+	for_each_set_bit(bit, &pdata->channels_used, st->desc->num_channels) {
 		struct iio_chan_spec *chan = chan_array + idx;
 		chan->type = IIO_VOLTAGE;
 		chan->indexed = 1;
@@ -186,6 +219,12 @@ static int __devinit at91_adc_probe(struct platform_device *pdev)
 	idev->info = &at91_adc_info;
 
 	st = iio_priv(idev);
+	ret = at91_adc_select_soc(st);
+	if (ret) {
+		dev_err(&pdev->dev, "SoC unknown\n");
+		goto error_free_device;
+	}
+
 	st->irq = platform_get_irq(pdev, 0);
 	if (st->irq < 0) {
 		dev_err(&pdev->dev, "No IRQ ID is designated\n");
@@ -238,7 +277,7 @@ static int __devinit at91_adc_probe(struct platform_device *pdev)
 		goto error_free_clk;
 	}
 
-	if (!pdata->adc_clock) {
+	if (!st->desc->clock) {
 		dev_err(&pdev->dev, "No ADCClock available.\n");
 		ret = -EINVAL;
 		goto error_free_clk;
@@ -249,9 +288,9 @@ static int __devinit at91_adc_probe(struct platform_device *pdev)
 	 * datasheet : ADC Clock = MCK / ((Prescaler + 1) * 2), ADC Clock being
 	 * specified by the electrical characteristics of the board.
 	 */
-	prsc = (mstrclk / (2 * pdata->adc_clock)) - 1;
+	prsc = (mstrclk / (2 * st->desc->clock)) - 1;
 
-	if (!pdata->startup_time) {
+	if (!st->desc->startup_time) {
 		dev_err(&pdev->dev, "No startup time available.\n");
 		ret = -EINVAL;
 		goto error_free_clk;
@@ -262,7 +301,7 @@ static int __devinit at91_adc_probe(struct platform_device *pdev)
 	 * defined in the electrical characteristics of the board, divided by 8.
 	 * The formula thus is : Startup Time = (ticks + 1) * 8 / ADC Clock
 	 */
-	ticks = round_up((pdata->startup_time * pdata->adc_clock /
+	ticks = round_up((st->desc->startup_time * st->desc->clock /
 			  1000000) - 1, 8) / 8;
 	at91_adc_reg_write(st, AT91_ADC_MR,
 			  (AT91_ADC_PRESCAL_(prsc) & AT91_ADC_PRESCAL) |
diff --git a/include/linux/platform_data/at91_adc.h b/include/linux/platform_data/at91_adc.h
index 1e1813d..9c5a64e 100644
--- a/include/linux/platform_data/at91_adc.h
+++ b/include/linux/platform_data/at91_adc.h
@@ -16,19 +16,10 @@
 #define _AT91_ADC_H_
 
 struct at91_adc_data {
-	/* ADC Clock as specified by the datasheet, in Hz. */
-	unsigned int adc_clock;
-	/*
-	 * Global number of channels available (to specify which channels are
-	 * indeed used on the board, see the channels_used bitmask).
-	 */
-	u8 num_channels;
 	/* Channels in use on the board as a bitmask */
 	unsigned long channels_used;
-	/* Startup time of the ADC, in microseconds. */
-	u8 startup_time;
 	/* Reference voltage for the ADC in millivolts */
-	unsigned short vref;
+	u16 vref;
 };
 
 extern void __init at91_add_device_adc(struct at91_adc_data *data);
-- 
1.7.4.1

