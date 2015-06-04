Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:50512 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932119AbbFDSpI (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 4 Jun 2015 14:45:08 -0400
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Marek Vasut <marex@denx.de>,
	=?UTF-8?q?Kristina=20Mart=C5=A1enko?=
	<kristina.martsenko@gmail.com>,
	Fabio Estevam <fabio.estevam@freescale.com>,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH] iio: mxs-lradc: add datasheet name for every usable channel
Date: Thu,  4 Jun 2015 18:44:31 +0000
Message-Id: <1433443471-16970-1-git-send-email-stefan.wahren@i2se.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

In order to provide a channel name to in kernel consumers add the
datasheet names for every usable AD channel.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/staging/iio/adc/mxs-lradc.c |   32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
index d7c5223..cafd6a0 100644
--- a/drivers/staging/iio/adc/mxs-lradc.c
+++ b/drivers/staging/iio/adc/mxs-lradc.c
@@ -1369,7 +1369,7 @@ static const struct iio_buffer_setup_ops mxs_lradc_buffer_ops = {
  * Driver initialization
  */
 
-#define MXS_ADC_CHAN(idx, chan_type) {				\
+#define MXS_ADC_CHAN(idx, chan_type, name) {			\
 	.type = (chan_type),					\
 	.indexed = 1,						\
 	.scan_index = (idx),					\
@@ -1382,17 +1382,18 @@ static const struct iio_buffer_setup_ops mxs_lradc_buffer_ops = {
 		.realbits = LRADC_RESOLUTION,			\
 		.storagebits = 32,				\
 	},							\
+	.datasheet_name = (name),				\
 }
 
 static const struct iio_chan_spec mxs_lradc_chan_spec[] = {
-	MXS_ADC_CHAN(0, IIO_VOLTAGE),
-	MXS_ADC_CHAN(1, IIO_VOLTAGE),
-	MXS_ADC_CHAN(2, IIO_VOLTAGE),
-	MXS_ADC_CHAN(3, IIO_VOLTAGE),
-	MXS_ADC_CHAN(4, IIO_VOLTAGE),
-	MXS_ADC_CHAN(5, IIO_VOLTAGE),
-	MXS_ADC_CHAN(6, IIO_VOLTAGE),
-	MXS_ADC_CHAN(7, IIO_VOLTAGE),	/* VBATT */
+	MXS_ADC_CHAN(0, IIO_VOLTAGE, "LRADC0"),
+	MXS_ADC_CHAN(1, IIO_VOLTAGE, "LRADC1"),
+	MXS_ADC_CHAN(2, IIO_VOLTAGE, "LRADC2"),
+	MXS_ADC_CHAN(3, IIO_VOLTAGE, "LRADC3"),
+	MXS_ADC_CHAN(4, IIO_VOLTAGE, "LRADC4"),
+	MXS_ADC_CHAN(5, IIO_VOLTAGE, "LRADC5"),
+	MXS_ADC_CHAN(6, IIO_VOLTAGE, "LRADC6"),
+	MXS_ADC_CHAN(7, IIO_VOLTAGE, "VBATT"),
 	/* Combined Temperature sensors */
 	{
 		.type = IIO_TEMP,
@@ -1403,6 +1404,7 @@ static const struct iio_chan_spec mxs_lradc_chan_spec[] = {
 				      BIT(IIO_CHAN_INFO_SCALE),
 		.channel = 8,
 		.scan_type = {.sign = 'u', .realbits = 18, .storagebits = 32,},
+		.datasheet_name = "TEMP_DIE",
 	},
 	/* Hidden channel to keep indexes */
 	{
@@ -1411,12 +1413,12 @@ static const struct iio_chan_spec mxs_lradc_chan_spec[] = {
 		.scan_index = -1,
 		.channel = 9,
 	},
-	MXS_ADC_CHAN(10, IIO_VOLTAGE),	/* VDDIO */
-	MXS_ADC_CHAN(11, IIO_VOLTAGE),	/* VTH */
-	MXS_ADC_CHAN(12, IIO_VOLTAGE),	/* VDDA */
-	MXS_ADC_CHAN(13, IIO_VOLTAGE),	/* VDDD */
-	MXS_ADC_CHAN(14, IIO_VOLTAGE),	/* VBG */
-	MXS_ADC_CHAN(15, IIO_VOLTAGE),	/* VDD5V */
+	MXS_ADC_CHAN(10, IIO_VOLTAGE, "VDDIO"),
+	MXS_ADC_CHAN(11, IIO_VOLTAGE, "VTH"),
+	MXS_ADC_CHAN(12, IIO_VOLTAGE, "VDDA"),
+	MXS_ADC_CHAN(13, IIO_VOLTAGE, "VDDD"),
+	MXS_ADC_CHAN(14, IIO_VOLTAGE, "VBG"),
+	MXS_ADC_CHAN(15, IIO_VOLTAGE, "VDD5V"),
 };
 
 static int mxs_lradc_hw_init(struct mxs_lradc *lradc)
-- 
1.7.9.5

