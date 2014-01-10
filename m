Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:57885 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751986AbaAJVhY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 10 Jan 2014 16:37:24 -0500
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>,
	Kravchenko Oleksandr <x0199363@ti.com>
Subject: [PATCH 1/2] iio:accel:bma180: Use modifier instead of index in channel specification
Date: Fri, 10 Jan 2014 22:37:20 +0100
Message-Id: <1389389841-7389-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

should use channel modifiers (X/Y/Z), not channel indices
timestamp channel has scan index 3, not 4

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Cc: Kravchenko Oleksandr <x0199363@ti.com>
---
 drivers/iio/accel/bma180.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
index 3bec922..bfec313 100644
--- a/drivers/iio/accel/bma180.c
+++ b/drivers/iio/accel/bma180.c
@@ -447,14 +447,14 @@ static const struct iio_chan_spec_ext_info bma180_ext_info[] = {
 	{ },
 };
 
-#define BMA180_CHANNEL(_index) {					\
+#define BMA180_CHANNEL(_axis) {					\
 	.type = IIO_ACCEL,						\
-	.indexed = 1,							\
-	.channel = (_index),						\
+	.modified = 1,							\
+	.channel2 = IIO_MOD_##_axis,					\
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
 		BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),	\
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),		\
-	.scan_index = (_index),						\
+	.scan_index = AXIS_##_axis,					\
 	.scan_type = {							\
 		.sign = 's',						\
 		.realbits = 14,						\
@@ -465,10 +465,10 @@ static const struct iio_chan_spec_ext_info bma180_ext_info[] = {
 }
 
 static const struct iio_chan_spec bma180_channels[] = {
-	BMA180_CHANNEL(AXIS_X),
-	BMA180_CHANNEL(AXIS_Y),
-	BMA180_CHANNEL(AXIS_Z),
-	IIO_CHAN_SOFT_TIMESTAMP(4),
+	BMA180_CHANNEL(X),
+	BMA180_CHANNEL(Y),
+	BMA180_CHANNEL(Z),
+	IIO_CHAN_SOFT_TIMESTAMP(3),
 };
 
 static irqreturn_t bma180_trigger_handler(int irq, void *p)
-- 
1.8.3.2

