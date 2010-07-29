Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: Greg KH <greg@kroah.com>
Cc: Randy Dunlap <randy.dunlap@oracle.com>,
	akpm@linux-foundation.org,
	linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 3/6] staging:iio:adis16350 add dummy ring functions for no ring build case
Date: Thu, 29 Jul 2010 17:50:48 +0100
Message-Id: <1280422251-13572-4-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1280422251-13572-1-git-send-email-jic23@cam.ac.uk>
References: <1280422251-13572-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/imu/adis16350.h |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/imu/adis16350.h b/drivers/staging/iio/imu/adis16350.h
index 738deba..b00001e 100644
--- a/drivers/staging/iio/imu/adis16350.h
+++ b/drivers/staging/iio/imu/adis16350.h
@@ -165,5 +165,13 @@ adis16350_read_data_from_ring(struct device *dev,
 	return 0;
 }
 
+static inline int adis16350_configure_ring(struct iio_dev *indio_dev)
+{
+	return 0;
+}
+
+static inline void adis16350_unconfigure_ring(struct iio_dev *indio_dev)
+{
+}
 #endif /* CONFIG_IIO_RING_BUFFER */
 #endif /* SPI_ADIS16350_H_ */
-- 
1.7.1
