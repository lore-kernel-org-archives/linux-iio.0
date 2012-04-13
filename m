Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:37397 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758354Ab2DMKEg (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 13 Apr 2012 06:04:36 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 12/13] staging:iio: Make read / write attributes for channel values optional.
Date: Fri, 13 Apr 2012 11:04:30 +0100
Message-Id: <1334311471-23054-13-git-send-email-jic23@kernel.org>
In-Reply-To: <1334311471-23054-1-git-send-email-jic23@kernel.org>
References: <1334311471-23054-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Until now all channels have had read/write attributes. This patch
allows for channels where we can't actually read the value (or for
output devices, write it!)

v2 introduces separate elements for processed and raw thus removing
some special case code from the core.  Thanks to Lars-Peter for an
excellent suggestion!

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/industrialio-core.c |   20 ++++----------------
 1 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index 1969a21..20bed97 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -80,6 +80,8 @@ static const char * const iio_modifier_names[] = {
 
 /* relies on pairs of these shared then separate */
 static const char * const iio_chan_info_postfix[] = {
+	[IIO_CHAN_INFO_RAW] = "raw",
+	[IIO_CHAN_INFO_PROCESSED] = "input",
 	[IIO_CHAN_INFO_SCALE] = "scale",
 	[IIO_CHAN_INFO_OFFSET] = "offset",
 	[IIO_CHAN_INFO_CALIBSCALE] = "calibscale",
@@ -576,26 +578,12 @@ static int iio_device_add_channel_sysfs(struct iio_dev *indio_dev,
 					struct iio_chan_spec const *chan)
 {
 	int ret, attrcount = 0;
-	int i = 4;
+	int i;
 	const struct iio_chan_spec_ext_info *ext_info;
 
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
-	for_each_set_bit_from(i, &chan->info_mask, sizeof(long)*8) {
+	for_each_set_bit(i, &chan->info_mask, sizeof(long)*8) {
 		ret = __iio_add_chan_devattr(iio_chan_info_postfix[i/2],
 					     chan,
 					     &iio_read_channel_info,
-- 
1.7.0.4

