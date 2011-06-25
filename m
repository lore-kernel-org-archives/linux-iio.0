Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: randy.dunlap@oracle.com,
	linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH] staging:iio: one more fix for IIO_RING_BUFFER not enabled.
Date: Sat, 25 Jun 2011 12:20:39 +0100
Message-Id: <1309000839-19741-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Same problem as seen and fixed in adis16204 et al.
These were fixed by Randy in: 
staging: fix more iio builds when IIO_RING_BUFFER is not enabled

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
Reported-by: Randy Dunlap <randy.dunlap@oracle.com>

---
 drivers/staging/iio/accel/adis16240.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16240.h b/drivers/staging/iio/accel/adis16240.h
index 162b1f4..0f400f0 100644
--- a/drivers/staging/iio/accel/adis16240.h
+++ b/drivers/staging/iio/accel/adis16240.h
@@ -143,7 +143,6 @@ struct adis16240_state {
 
 int adis16240_set_irq(struct iio_dev *indio_dev, bool enable);
 
-#ifdef CONFIG_IIO_RING_BUFFER
 /* At the moment triggers are only used for ring buffer
  * filling. This may change!
  */
@@ -155,6 +154,7 @@ int adis16240_set_irq(struct iio_dev *indio_dev, bool enable);
 #define ADIS16240_SCAN_AUX_ADC	4
 #define ADIS16240_SCAN_TEMP	5
 
+#ifdef CONFIG_IIO_RING_BUFFER
 void adis16240_remove_trigger(struct iio_dev *indio_dev);
 int adis16240_probe_trigger(struct iio_dev *indio_dev);
 
-- 
1.7.3.4
