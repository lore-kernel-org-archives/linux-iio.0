Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:59554 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751577AbaHSWnc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 19 Aug 2014 18:43:32 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Peter Meerwald <pmeerw@pmeerw.net>,
	Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
Subject: [PATCH v2 09/11] iio:bma180: Prepare for accelerometer channels with different resolutions
Date: Wed, 20 Aug 2014 00:43:24 +0200
Message-Id: <1408488206-2633-10-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1408488206-2633-1-git-send-email-pmeerw@pmeerw.net>
References: <1408488206-2633-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

allow to specify channels resolution and compute shift assuming
16-bit registers and MSB allocation

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Cc: Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
---
 drivers/iio/accel/bma180.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
index a25b060..6e940b0 100644
--- a/drivers/iio/accel/bma180.c
+++ b/drivers/iio/accel/bma180.c
@@ -474,7 +474,7 @@ static const struct iio_chan_spec_ext_info bma180_ext_info[] = {
 	{ },
 };
 
-#define BMA180_ACC_CHANNEL(_axis) {					\
+#define BMA180_ACC_CHANNEL(_axis, _bits) {				\
 	.type = IIO_ACCEL,						\
 	.modified = 1,							\
 	.channel2 = IIO_MOD_##_axis,					\
@@ -484,9 +484,9 @@ static const struct iio_chan_spec_ext_info bma180_ext_info[] = {
 	.scan_index = AXIS_##_axis,					\
 	.scan_type = {							\
 		.sign = 's',						\
-		.realbits = 14,						\
+		.realbits = _bits,					\
 		.storagebits = 16,					\
-		.shift = 2,						\
+		.shift = 16 - _bits,					\
 	},								\
 	.ext_info = bma180_ext_info,					\
 }
@@ -504,9 +504,9 @@ static const struct iio_chan_spec_ext_info bma180_ext_info[] = {
 }
 
 static const struct iio_chan_spec bma180_channels[] = {
-	BMA180_ACC_CHANNEL(X),
-	BMA180_ACC_CHANNEL(Y),
-	BMA180_ACC_CHANNEL(Z),
+	BMA180_ACC_CHANNEL(X, 14),
+	BMA180_ACC_CHANNEL(Y, 14),
+	BMA180_ACC_CHANNEL(Z, 14),
 	BMA180_TEMP_CHANNEL,
 	IIO_CHAN_SOFT_TIMESTAMP(4),
 };
-- 
1.9.1

