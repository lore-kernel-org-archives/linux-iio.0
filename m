Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:58103 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754859AbaAJV70 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 10 Jan 2014 16:59:26 -0500
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 3/5] iio:magnetometer:mag3110: Scale factor missing for temperature
Date: Fri, 10 Jan 2014 22:59:21 +0100
Message-Id: <1389391163-9622-3-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1389391163-9622-1-git-send-email-pmeerw@pmeerw.net>
References: <1389391163-9622-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

temperature is reported in milli-Celsius

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/iio/magnetometer/mag3110.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/magnetometer/mag3110.c b/drivers/iio/magnetometer/mag3110.c
index f66955f..02e4f97 100644
--- a/drivers/iio/magnetometer/mag3110.c
+++ b/drivers/iio/magnetometer/mag3110.c
@@ -183,8 +183,17 @@ static int mag3110_read_raw(struct iio_dev *indio_dev,
 			return -EINVAL;
 		}
 	case IIO_CHAN_INFO_SCALE:
-		*val = 0;
-		*val2 = 1000;
+		switch (chan->type) {
+		case IIO_MAGN:
+			*val = 0;
+			*val2 = 1000;
+			return IIO_VAL_INT_PLUS_MICRO;
+		case IIO_TEMP:
+			*val = 1000;
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
 		return IIO_VAL_INT_PLUS_MICRO;
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		i = data->ctrl_reg1 >> MAG3110_CTRL_DR_SHIFT;
@@ -270,7 +279,8 @@ static const struct iio_chan_spec mag3110_channels[] = {
 	MAG3110_CHANNEL(Z, 2),
 	{
 		.type = IIO_TEMP,
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+			BIT(IIO_CHAN_INFO_SCALE),
 		.scan_index = 3,
 		.scan_type = {
 			.sign = 's',
-- 
1.8.3.2

