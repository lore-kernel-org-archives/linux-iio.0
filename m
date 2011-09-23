Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:51252 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753534Ab1IWLx0 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 23 Sep 2011 07:53:26 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: Michael.Hennerich@analog.com
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 10/16] staging:iio:adc:ad7606 add local define for chan_spec structures.
Date: Fri, 23 Sep 2011 13:01:36 +0100
Message-Id: <1316779302-12357-11-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1316779302-12357-1-git-send-email-jic23@cam.ac.uk>
References: <1316779302-12357-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

IIO_CHAN is being phased out and in this case things are so
simple it makes sense to have a local one parameter equivalent.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/ad7606_core.c |   82 +++++++++++---------------------
 1 files changed, 28 insertions(+), 54 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7606_core.c b/drivers/staging/iio/adc/ad7606_core.c
index 17cdafb..7ea5232 100644
--- a/drivers/staging/iio/adc/ad7606_core.c
+++ b/drivers/staging/iio/adc/ad7606_core.c
@@ -233,69 +233,43 @@ static const struct attribute_group ad7606_attribute_group = {
 	.is_visible = ad7606_attr_is_visible,
 };
 
+#define AD7606_CHANNEL(num)				\
+	{						\
+		.type = IIO_VOLTAGE,			\
+		.indexed = 1,				\
+		.channel = num,				\
+		.address = num,				\
+		.scan_index = num,			\
+		.scan_type = IIO_ST('s', 16, 16, 0),	\
+	}
+
 static struct iio_chan_spec ad7606_8_channels[] = {
-	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 0, 0,
-		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
-		 0, 0, IIO_ST('s', 16, 16, 0), 0),
-	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 1, 0,
-		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
-		 1, 1, IIO_ST('s', 16, 16, 0), 0),
-	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 2, 0,
-		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
-		 2, 2, IIO_ST('s', 16, 16, 0), 0),
-	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 3, 0,
-		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
-		 3, 3, IIO_ST('s', 16, 16, 0), 0),
-	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 4, 0,
-		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
-		 4, 4, IIO_ST('s', 16, 16, 0), 0),
-	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 5, 0,
-		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
-		 5, 5, IIO_ST('s', 16, 16, 0), 0),
-	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 6, 0,
-		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
-		 6, 6, IIO_ST('s', 16, 16, 0), 0),
-	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 7, 0,
-		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
-		 7, 7, IIO_ST('s', 16, 16, 0), 0),
+	AD7606_CHANNEL(0),
+	AD7606_CHANNEL(1),
+	AD7606_CHANNEL(2),
+	AD7606_CHANNEL(3),
+	AD7606_CHANNEL(4),
+	AD7606_CHANNEL(5),
+	AD7606_CHANNEL(6),
+	AD7606_CHANNEL(7),
 	IIO_CHAN_SOFT_TIMESTAMP(8),
 };
 
 static struct iio_chan_spec ad7606_6_channels[] = {
-	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 0, 0,
-		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
-		 0, 0, IIO_ST('s', 16, 16, 0), 0),
-	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 1, 0,
-		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
-		 1, 1, IIO_ST('s', 16, 16, 0), 0),
-	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 2, 0,
-		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
-		 2, 2, IIO_ST('s', 16, 16, 0), 0),
-	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 3, 0,
-		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
-		 3, 3, IIO_ST('s', 16, 16, 0), 0),
-	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 4, 0,
-		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
-		 4, 4, IIO_ST('s', 16, 16, 0), 0),
-	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 5, 0,
-		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
-		 5, 5, IIO_ST('s', 16, 16, 0), 0),
+	AD7606_CHANNEL(0),
+	AD7606_CHANNEL(1),
+	AD7606_CHANNEL(2),
+	AD7606_CHANNEL(3),
+	AD7606_CHANNEL(4),
+	AD7606_CHANNEL(5),
 	IIO_CHAN_SOFT_TIMESTAMP(6),
 };
 
 static struct iio_chan_spec ad7606_4_channels[] = {
-	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 0, 0,
-		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
-		 0, 0, IIO_ST('s', 16, 16, 0), 0),
-	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 1, 0,
-		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
-		 1, 1, IIO_ST('s', 16, 16, 0), 0),
-	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 2, 0,
-		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
-		 2, 2, IIO_ST('s', 16, 16, 0), 0),
-	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 3, 0,
-		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
-		 3, 3, IIO_ST('s', 16, 16, 0), 0),
+	AD7606_CHANNEL(0),
+	AD7606_CHANNEL(1),
+	AD7606_CHANNEL(2),
+	AD7606_CHANNEL(3),
 	IIO_CHAN_SOFT_TIMESTAMP(4),
 };
 
-- 
1.7.3.4

