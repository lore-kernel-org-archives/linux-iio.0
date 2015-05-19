Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-la0-f43.google.com ([209.85.215.43]:34799 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932294AbbESNhN (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 19 May 2015 09:37:13 -0400
Received: by laat2 with SMTP id t2so24385406laa.1
        for <linux-iio@vger.kernel.org>; Tue, 19 May 2015 06:37:11 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	Denis CIOCCA <denis.ciocca@st.com>
Cc: Lee Jones <lee.jones@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 1/2 v2] iio: st_accel: support 8bit channel data
Date: Tue, 19 May 2015 15:37:02 +0200
Message-Id: <1432042622-26703-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Some sensors like the LIS331DL only support 8bit data by a single
register per axis. These utilize the MSB byte. Make it possible
to register these apropriately.

A oneliner change is needed in the ST sensors core to handle 8bit
reads as this is the first supported 8bit sensor.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Change the .storage type to 8 bits.
- Alter the st_sensors_core to cast the byte properly to a signed
  int.
---
 drivers/iio/accel/st_accel_core.c               | 16 ++++++++++++++++
 drivers/iio/common/st_sensors/st_sensors_core.c |  4 +++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
index 58d1d13d552a..ad19fb4304df 100644
--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -153,6 +153,22 @@
 #define ST_ACCEL_4_IG1_EN_MASK			0x08
 #define ST_ACCEL_4_MULTIREAD_BIT		true
 
+static const struct iio_chan_spec st_accel_8bit_channels[] = {
+	ST_SENSORS_LSM_CHANNELS(IIO_ACCEL,
+			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+			ST_SENSORS_SCAN_X, 1, IIO_MOD_X, 's', IIO_LE, 8, 8,
+			ST_ACCEL_DEFAULT_OUT_X_L_ADDR+1),
+	ST_SENSORS_LSM_CHANNELS(IIO_ACCEL,
+			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+			ST_SENSORS_SCAN_Y, 1, IIO_MOD_Y, 's', IIO_LE, 8, 8,
+			ST_ACCEL_DEFAULT_OUT_Y_L_ADDR+1),
+	ST_SENSORS_LSM_CHANNELS(IIO_ACCEL,
+			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+			ST_SENSORS_SCAN_Z, 1, IIO_MOD_Z, 's', IIO_LE, 8, 8,
+			ST_ACCEL_DEFAULT_OUT_Z_L_ADDR+1),
+	IIO_CHAN_SOFT_TIMESTAMP(3)
+};
+
 static const struct iio_chan_spec st_accel_12bit_channels[] = {
 	ST_SENSORS_LSM_CHANNELS(IIO_ACCEL,
 			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
index 7973c0457042..9007b618d434 100644
--- a/drivers/iio/common/st_sensors/st_sensors_core.c
+++ b/drivers/iio/common/st_sensors/st_sensors_core.c
@@ -434,7 +434,9 @@ static int st_sensors_read_axis_data(struct iio_dev *indio_dev,
 	if (err < 0)
 		goto st_sensors_free_memory;
 
-	if (byte_for_channel == 2)
+	if (byte_for_channel == 1)
+		*data = (s8)*outdata;
+	else if (byte_for_channel == 2)
 		*data = (s16)get_unaligned_le16(outdata);
 	else if (byte_for_channel == 3)
 		*data = (s32)st_sensors_get_unaligned_le24(outdata);
-- 
1.9.3

