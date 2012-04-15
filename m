Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:60236 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751231Ab2DOLmF (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 15 Apr 2012 07:42:05 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: device-drivers-devel@blackfin.uclinux.org, lars@metafoo.de,
	ldewangan@nvidia.com, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH] staging:iio:isl29028 Add IIO_CHAN_INFO_RAW/PROCESSED entries
Date: Sun, 15 Apr 2012 12:41:57 +0100
Message-Id: <1334490117-28009-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Precursor to making value read / write attribute optional.
This one stands along as it merged just before the series
doing all the other drivers.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
This driver crossed with review of these patches.  To test
just apply it after the series 
[PATCH 00/13 V2] IIO: Make the value attribute optional for channels

Fairly trivial case, but obviously I can't push out the removal
of the old code until this is in place.  In the meantime I'll push
the rest of the conversion patches to Greg.


 drivers/staging/iio/light/isl29028.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/light/isl29028.c b/drivers/staging/iio/light/isl29028.c
index e705e45..5ef2d0d 100644
--- a/drivers/staging/iio/light/isl29028.c
+++ b/drivers/staging/iio/light/isl29028.c
@@ -330,7 +330,8 @@ static int isl29028_read_raw(struct iio_dev *indio_dev,
 
 	mutex_lock(&chip->lock);
 	switch (mask) {
-	case 0:
+	case IIO_CHAN_INFO_RAW:
+	case IIO_CHAN_INFO_PROCESSED:
 		switch (chan->type) {
 		case IIO_LIGHT:
 			ret = isl29028_als_get(chip, val);
@@ -391,12 +392,15 @@ static const struct iio_chan_spec isl29028_channels[] = {
 	{
 		.type = IIO_LIGHT,
 		.processed_val = 1,
-		.info_mask = IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
+		.info_mask = IIO_CHAN_INFO_PROCESSED_SEPARATE_BIT |
+		IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
 	}, {
 		.type = IIO_INTENSITY,
+		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT,
 	}, {
 		.type = IIO_PROXIMITY,
-		.info_mask = IIO_CHAN_INFO_SAMP_FREQ_SEPARATE_BIT,
+		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
+		IIO_CHAN_INFO_SAMP_FREQ_SEPARATE_BIT,
 	}
 };
 
-- 
1.7.9.4

