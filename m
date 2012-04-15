Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:55546 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755773Ab2DOQlg (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 15 Apr 2012 12:41:36 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 10/16] staging:iio:impedance Add IIO_CHAN_INFO_RAW/PROCESSED entries to all drivers.
Date: Sun, 15 Apr 2012 17:41:25 +0100
Message-Id: <1334508091-24027-11-git-send-email-jic23@kernel.org>
In-Reply-To: <1334508091-24027-1-git-send-email-jic23@kernel.org>
References: <1334508091-24027-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Precursor to making value read / write attribute optional.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Acked-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/impedance-analyzer/ad5933.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index 06b9fe2..9d5738a 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -114,6 +114,7 @@ static struct iio_chan_spec ad5933_channels[] = {
 		.indexed = 1,
 		.processed_val = 1,
 		.channel = 0,
+		.info_mask = IIO_CHAN_INFO_PROCESSED_SEPARATE_BIT,
 		.address = AD5933_REG_TEMP_DATA,
 		.scan_type = {
 			.sign = 's',
@@ -125,7 +126,8 @@ static struct iio_chan_spec ad5933_channels[] = {
 		.indexed = 1,
 		.channel = 0,
 		.extend_name = "real_raw",
-		.info_mask = IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
+		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
+		IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
 		.address = AD5933_REG_REAL_DATA,
 		.scan_index = 0,
 		.scan_type = {
@@ -138,7 +140,8 @@ static struct iio_chan_spec ad5933_channels[] = {
 		.indexed = 1,
 		.channel = 0,
 		.extend_name = "imag_raw",
-		.info_mask = IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
+		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
+		IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
 		.address = AD5933_REG_IMAG_DATA,
 		.scan_index = 1,
 		.scan_type = {
@@ -524,7 +527,8 @@ static int ad5933_read_raw(struct iio_dev *indio_dev,
 
 	mutex_lock(&indio_dev->mlock);
 	switch (m) {
-	case 0:
+	case IIO_CHAN_INFO_RAW:
+	case IIO_CHAN_INFO_PROCESSED:
 		if (iio_buffer_enabled(indio_dev)) {
 			ret = -EBUSY;
 			goto out;
-- 
1.7.9.4

