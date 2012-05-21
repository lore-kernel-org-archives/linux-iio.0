Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-046.synserver.de ([212.40.185.46]:1494 "EHLO
	smtp-out-044.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752247Ab2EULkL (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 21 May 2012 07:40:11 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 03/18] staging:iio:dac:ad5446: Use iio_enum for powerdown modes
Date: Mon, 21 May 2012 13:42:52 +0200
Message-Id: <1337600587-19848-3-git-send-email-lars@metafoo.de>
In-Reply-To: <1337600587-19848-1-git-send-email-lars@metafoo.de>
References: <1337600587-19848-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This allows us to remove some boilerplate code for comparing and formatting the
enum strings.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/dac/ad5446.c |   55 +++++++++++++-------------------------
 1 file changed, 19 insertions(+), 36 deletions(-)

diff --git a/drivers/staging/iio/dac/ad5446.c b/drivers/staging/iio/dac/ad5446.c
index daa65b3..1774f7f 100644
--- a/drivers/staging/iio/dac/ad5446.c
+++ b/drivers/staging/iio/dac/ad5446.c
@@ -42,47 +42,34 @@ static int ad5660_write(struct ad5446_state *st, unsigned val)
 }
 
 static const char * const ad5446_powerdown_modes[] = {
-	"", "1kohm_to_gnd", "100kohm_to_gnd", "three_state"
+	"1kohm_to_gnd", "100kohm_to_gnd", "three_state"
 };
 
-static ssize_t ad5446_read_powerdown_mode_available(struct iio_dev *indio_dev,
-	uintptr_t private, const struct iio_chan_spec *chan, char *buf)
-{
-	return sprintf(buf, "%s %s %s\n", ad5446_powerdown_modes[1],
-		ad5446_powerdown_modes[2], ad5446_powerdown_modes[3]);
-}
-
-static ssize_t ad5446_write_powerdown_mode(struct iio_dev *indio_dev,
-					    uintptr_t private,
-					    const struct iio_chan_spec *chan,
-					    const char *buf, size_t len)
+static int ad5446_set_powerdown_mode(struct iio_dev *indio_dev,
+	const struct iio_chan_spec *chan, unsigned int mode)
 {
 	struct ad5446_state *st = iio_priv(indio_dev);
-	int i;
-
-	for (i = 1; i < ARRAY_SIZE(ad5446_powerdown_modes); i++) {
-		if (sysfs_streq(buf, ad5446_powerdown_modes[i])) {
-			st->pwr_down_mode = i;
-			break;
-		}
-	}
 
-	if (i == ARRAY_SIZE(ad5446_powerdown_modes))
-		return -EINVAL;
+	st->pwr_down_mode = mode + 1;
 
-	return len;
+	return 0;
 }
 
-static ssize_t ad5446_read_powerdown_mode(struct iio_dev *indio_dev,
-					   uintptr_t private,
-					   const struct iio_chan_spec *chan,
-					   char *buf)
+static int ad5446_get_powerdown_mode(struct iio_dev *indio_dev,
+	const struct iio_chan_spec *chan)
 {
 	struct ad5446_state *st = iio_priv(indio_dev);
 
-	return sprintf(buf, "%s\n", ad5446_powerdown_modes[st->pwr_down_mode]);
+	return st->pwr_down_mode - 1;
 }
 
+static const struct iio_enum ad5446_powerdown_mode_enum = {
+	.items = ad5446_powerdown_modes,
+	.num_items = ARRAY_SIZE(ad5446_powerdown_modes),
+	.get = ad5446_get_powerdown_mode,
+	.set = ad5446_set_powerdown_mode,
+};
+
 static ssize_t ad5446_read_dac_powerdown(struct iio_dev *indio_dev,
 					   uintptr_t private,
 					   const struct iio_chan_spec *chan,
@@ -129,15 +116,9 @@ static const struct iio_chan_spec_ext_info ad5064_ext_info_powerdown[] = {
 		.name = "powerdown",
 		.read = ad5446_read_dac_powerdown,
 		.write = ad5446_write_dac_powerdown,
-	}, {
-		.name = "powerdown_mode",
-		.read = ad5446_read_powerdown_mode,
-		.write = ad5446_write_powerdown_mode,
-	}, {
-		.name = "powerdown_mode_available",
-		.shared = true,
-		.read = ad5446_read_powerdown_mode_available,
 	},
+	IIO_ENUM("powerdown_mode", false, &ad5446_powerdown_mode_enum),
+	IIO_ENUM_AVAILABLE("powerdown_mode", &ad5446_powerdown_mode_enum),
 	{ },
 };
 
@@ -321,6 +302,8 @@ static int __devinit ad5446_probe(struct spi_device *spi)
 	indio_dev->channels = &st->chip_info->channel;
 	indio_dev->num_channels = 1;
 
+	st->pwr_down_mode = MODE_PWRDWN_1k;
+
 	if (st->chip_info->int_vref_mv)
 		st->vref_mv = st->chip_info->int_vref_mv;
 	else if (voltage_uv)
-- 
1.7.10

