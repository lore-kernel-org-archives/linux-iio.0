Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 3/3]     staging:iio:max1363 fix bug due to scan_element directory move.
Date: Thu,  7 Oct 2010 13:10:21 +0100
Message-Id: <1286453421-7584-4-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1286453421-7584-1-git-send-email-jic23@cam.ac.uk>
References: <1286453421-7584-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

    The device found passed to the attr functions is that of the ring
    buffer, not the the iio_dev so we need to bounce through one more
    hop to get the right address.

    Reported-by: Michael Hennerich <michael.hennerich@analog.com>
    Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/max1363_core.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/adc/max1363_core.c b/drivers/staging/iio/adc/max1363_core.c
index 06c6024..dde097a 100644
--- a/drivers/staging/iio/adc/max1363_core.c
+++ b/drivers/staging/iio/adc/max1363_core.c
@@ -151,7 +151,8 @@ static ssize_t max1363_show_precision_u(struct device *dev,
 				struct device_attribute *attr,
 				char *buf)
 {
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
+	struct iio_ring_buffer *ring = dev_get_drvdata(dev);
+	struct iio_dev *dev_info = ring->indio_dev;
 	struct max1363_state *st = iio_dev_get_devdata(dev_info);
 	return sprintf(buf, "u%d/16\n", st->chip_info->bits);
 }
@@ -160,7 +161,8 @@ static ssize_t max1363_show_precision_s(struct device *dev,
 				struct device_attribute *attr,
 				char *buf)
 {
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
+	struct iio_ring_buffer *ring = dev_get_drvdata(dev);
+	struct iio_dev *dev_info = ring->indio_dev;
 	struct max1363_state *st = iio_dev_get_devdata(dev_info);
 	return sprintf(buf, "s%d/16\n", st->chip_info->bits);
 }
-- 
1.7.2.2
