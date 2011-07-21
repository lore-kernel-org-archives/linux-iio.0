Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:42798 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750954Ab1GUNkG (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 21 Jul 2011 09:40:06 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH] staging:iio:adc: max1363 fix 2 raw sysfs issues.
Date: Thu, 21 Jul 2011 14:40:06 +0100
Message-Id: <1311255606-28938-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

indio_dev->channels was accidentally removed thus preventing any sysfs
registrations occuring for direct reading.  That hid the other issue.

Unfortunately the incorrect handling leads to misspresentation of data
in sysfs reads.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/max1363_core.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/adc/max1363_core.c b/drivers/staging/iio/adc/max1363_core.c
index 3fee89e..9525aec 100644
--- a/drivers/staging/iio/adc/max1363_core.c
+++ b/drivers/staging/iio/adc/max1363_core.c
@@ -254,7 +254,7 @@ static int max1363_read_raw(struct iio_dev *indio_dev,
 	switch (m) {
 	case 0:
 		ret = max1363_read_single_chan(indio_dev, chan, val, m);
-		if (ret)
+		if (ret < 0)
 			return ret;
 		return IIO_VAL_INT;
 	case (1 << IIO_CHAN_INFO_SCALE_SHARED):
@@ -1306,6 +1306,8 @@ static int __devinit max1363_probe(struct i2c_client *client,
 
 	indio_dev->info = st->chip_info->info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = st->chip_info->channels;
+	indio_dev->num_channels = st->chip_info->num_channels;
 	ret = max1363_initial_setup(st);
 	if (ret < 0)
 		goto error_free_available_scan_masks;
-- 
1.7.3.4

