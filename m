Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:55497 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755492Ab2DOQld (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 15 Apr 2012 12:41:33 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 01/16] staging:iio: add a raw and processed elements to info_mask
Date: Sun, 15 Apr 2012 17:41:16 +0100
Message-Id: <1334508091-24027-2-git-send-email-jic23@kernel.org>
In-Reply-To: <1334508091-24027-1-git-send-email-jic23@kernel.org>
References: <1334508091-24027-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This will allow us to have drivers where the channel value
may not be read or written but other information is available.
Also adds the ability to have both processed and raw access
to a given channel, though in most cases this doesn't make
sense.

Ultimately will lead to simpler code by allowing us to drop
the special case handling for the value reading cases.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Acked-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/iio.h               |    9 +++++++--
 drivers/staging/iio/industrialio-core.c |    5 +++--
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
index b07ddd3..dda1602 100644
--- a/drivers/staging/iio/iio.h
+++ b/drivers/staging/iio/iio.h
@@ -26,8 +26,9 @@ enum iio_data_type {
 
 /* Could add the raw attributes as well - allowing buffer only devices */
 enum iio_chan_info_enum {
-	/* 0 is reserved for raw attributes */
-	IIO_CHAN_INFO_SCALE = 1,
+	IIO_CHAN_INFO_RAW = 0,
+	IIO_CHAN_INFO_PROCESSED,
+	IIO_CHAN_INFO_SCALE,
 	IIO_CHAN_INFO_OFFSET,
 	IIO_CHAN_INFO_CALIBSCALE,
 	IIO_CHAN_INFO_CALIBBIAS,
@@ -42,6 +43,10 @@ enum iio_chan_info_enum {
 #define IIO_CHAN_INFO_SHARED_BIT(type) BIT(type*2)
 #define IIO_CHAN_INFO_SEPARATE_BIT(type) BIT(type*2 + 1)
 
+#define IIO_CHAN_INFO_RAW_SEPARATE_BIT			\
+	IIO_CHAN_INFO_SEPARATE_BIT(IIO_CHAN_INFO_RAW)
+#define IIO_CHAN_INFO_PROCESSED_SEPARATE_BIT			\
+	IIO_CHAN_INFO_SEPARATE_BIT(IIO_CHAN_INFO_PROCESSED)
 #define IIO_CHAN_INFO_SCALE_SEPARATE_BIT		\
 	IIO_CHAN_INFO_SEPARATE_BIT(IIO_CHAN_INFO_SCALE)
 #define IIO_CHAN_INFO_SCALE_SHARED_BIT			\
diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index 9e42713..817e3fa 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -576,7 +576,8 @@ error_ret:
 static int iio_device_add_channel_sysfs(struct iio_dev *indio_dev,
 					struct iio_chan_spec const *chan)
 {
-	int ret, i, attrcount = 0;
+	int ret, attrcount = 0;
+	int i = 4;
 	const struct iio_chan_spec_ext_info *ext_info;
 
 	if (chan->channel < 0)
@@ -595,7 +596,7 @@ static int iio_device_add_channel_sysfs(struct iio_dev *indio_dev,
 		goto error_ret;
 	attrcount++;
 
-	for_each_set_bit(i, &chan->info_mask, sizeof(long)*8) {
+	for_each_set_bit_from(i, &chan->info_mask, sizeof(long)*8) {
 		ret = __iio_add_chan_devattr(iio_chan_info_postfix[i/2],
 					     chan,
 					     &iio_read_channel_info,
-- 
1.7.9.4

