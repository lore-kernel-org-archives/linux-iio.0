Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:40652 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753812Ab1HLPrn (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 12 Aug 2011 11:47:43 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 03/12] staging:iio:adc: max1363 fix 2 raw sysfs issues.
Date: Fri, 12 Aug 2011 16:55:29 +0100
Message-Id: <1313164538-1769-4-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1313164538-1769-1-git-send-email-jic23@cam.ac.uk>
References: <1313164538-1769-1-git-send-email-jic23@cam.ac.uk>
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
index 72b0917..d93b7a9 100644
--- a/drivers/staging/iio/adc/max1363_core.c
+++ b/drivers/staging/iio/adc/max1363_core.c
@@ -255,7 +255,7 @@ static int max1363_read_raw(struct iio_dev *indio_dev,
 	switch (m) {
 	case 0:
 		ret = max1363_read_single_chan(indio_dev, chan, val, m);
-		if (ret)
+		if (ret < 0)
 			return ret;
 		return IIO_VAL_INT;
 	case (1 << IIO_CHAN_INFO_SCALE_SHARED):
@@ -1295,6 +1295,8 @@ static int __devinit max1363_probe(struct i2c_client *client,
 
 	indio_dev->info = st->chip_info->info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = st->chip_info->channels;
+	indio_dev->num_channels = st->chip_info->num_channels;
 	ret = max1363_initial_setup(st);
 	if (ret < 0)
 		goto error_free_available_scan_masks;
-- 
1.7.3.4

