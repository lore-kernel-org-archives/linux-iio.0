Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 2/3] staging:iio:adc: max1363 fix 2 raw sysfs issues.
Date: Mon, 25 Jul 2011 14:04:31 +0100
Message-Id: <1311599072-14637-3-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1311599072-14637-1-git-send-email-jic23@cam.ac.uk>
References: <1311599072-14637-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

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
