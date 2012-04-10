Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:36148 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759425Ab2DJU1u (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 10 Apr 2012 16:27:50 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: device-drivers-devel@blackfin.uclinux.org,
	michael.hennerich@analog.com, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 10/10] staging:iio: Make read / write attributes for channel values optional.
Date: Tue, 10 Apr 2012 21:27:43 +0100
Message-Id: <1334089663-22900-11-git-send-email-jic23@kernel.org>
In-Reply-To: <1334089663-22900-1-git-send-email-jic23@kernel.org>
References: <1334089663-22900-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Until now all channels have had read/write attributes. This patch
allows for channels where we can't actually read the value (or for
output devices, write it!)

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/industrialio-core.c |   29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index a4ac061..2b51178 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -581,20 +581,21 @@ static int iio_device_add_channel_sysfs(struct iio_dev *indio_dev,
 
 	if (chan->channel < 0)
 		return 0;
-
-	ret = __iio_add_chan_devattr(iio_data_type_name[chan->processed_val],
-				     chan,
-				     &iio_read_channel_info,
-				     (chan->output ?
-				      &iio_write_channel_info : NULL),
-				     0,
-				     0,
-				     &indio_dev->dev,
-				     &indio_dev->channel_attr_list);
-	if (ret)
-		goto error_ret;
-	attrcount++;
-
+	if (chan->info_mask & IIO_CHAN_INFO_VALUE_SEPARATE_BIT) {
+		ret = __iio_add_chan_devattr(iio_data_type_name[chan->
+								processed_val],
+					     chan,
+					     &iio_read_channel_info,
+					     (chan->output ?
+					      &iio_write_channel_info : NULL),
+					     0,
+					     0,
+					     &indio_dev->dev,
+					     &indio_dev->channel_attr_list);
+		if (ret)
+			goto error_ret;
+		attrcount++;
+	}
 	for_each_set_bit_from(i, &chan->info_mask, sizeof(long)*8) {
 		ret = __iio_add_chan_devattr(iio_chan_info_postfix[i/2],
 					     chan,
-- 
1.7.9.4

