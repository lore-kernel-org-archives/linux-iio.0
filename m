Return-Path: <jic23@hermes.cam.ac.uk>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 10/13] staging:iio:impedance Add IIO_CHAN_INFO_RAW/PROCESSED entries to all drivers.
Date: Fri, 13 Apr 2012 11:04:28 +0100
Message-Id: <1334311471-23054-11-git-send-email-jic23@kernel.org>
In-Reply-To: <1334311471-23054-1-git-send-email-jic23@kernel.org>
References: <1334311471-23054-1-git-send-email-jic23@kernel.org>
Sender: "J.I. Cameron" <jic23@hermes.cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Precursor to making value read / write attribute optional.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/impedance-analyzer/ad5933.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

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
1.7.0.4
