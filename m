Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-la0-f52.google.com ([209.85.215.52]:34084 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751031AbbD3NQb (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 30 Apr 2015 09:16:31 -0400
Received: by laat2 with SMTP id t2so43934175laa.1
        for <linux-iio@vger.kernel.org>; Thu, 30 Apr 2015 06:16:30 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	Denis CIOCCA <denis.ciocca@st.com>
Cc: Lee Jones <lee.jones@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 06/10] iio: st_accel: support 8bit channel data
Date: Thu, 30 Apr 2015 15:15:51 +0200
Message-Id: <1430399755-26475-6-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1430399755-26475-1-git-send-email-linus.walleij@linaro.org>
References: <1430399755-26475-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Some sensors like the LIS331DL only support 8bit data by a single
register per axis. These utilize the MSB byte. Make it possible
to register these apropriately.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/accel/st_accel_core.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
index 58d1d13d552a..689a9f360e7c 100644
--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -153,6 +153,22 @@
 #define ST_ACCEL_4_IG1_EN_MASK			0x08
 #define ST_ACCEL_4_MULTIREAD_BIT		true
 
+static const struct iio_chan_spec st_accel_8bit_channels[] = {
+	ST_SENSORS_LSM_CHANNELS(IIO_ACCEL,
+			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+			ST_SENSORS_SCAN_X, 1, IIO_MOD_X, 's', IIO_LE, 8, 16,
+			ST_ACCEL_DEFAULT_OUT_X_L_ADDR+1),
+	ST_SENSORS_LSM_CHANNELS(IIO_ACCEL,
+			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+			ST_SENSORS_SCAN_Y, 1, IIO_MOD_Y, 's', IIO_LE, 8, 16,
+			ST_ACCEL_DEFAULT_OUT_Y_L_ADDR+1),
+	ST_SENSORS_LSM_CHANNELS(IIO_ACCEL,
+			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+			ST_SENSORS_SCAN_Z, 1, IIO_MOD_Z, 's', IIO_LE, 8, 16,
+			ST_ACCEL_DEFAULT_OUT_Z_L_ADDR+1),
+	IIO_CHAN_SOFT_TIMESTAMP(3)
+};
+
 static const struct iio_chan_spec st_accel_12bit_channels[] = {
 	ST_SENSORS_LSM_CHANNELS(IIO_ACCEL,
 			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
-- 
1.9.3

