Return-Path: <jic23@hermes.cam.ac.uk>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 1/2] staging:iio:accel:kxsd9
Date: Sun,  6 Jan 2013 15:10:16 +0000
Message-Id: <1357485017-27916-2-git-send-email-jic23@kernel.org>
In-Reply-To: <1357485017-27916-1-git-send-email-jic23@kernel.org>
References: <1357485017-27916-1-git-send-email-jic23@kernel.org>
Sender: "J.I. Cameron" <jic23@hermes.cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Remove an unneeded initialization and trivial reorder to ensure
the device is ready when the device is registered.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/accel/kxsd9.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/iio/accel/kxsd9.c b/drivers/staging/iio/accel/kxsd9.c
index 318331f..4a24c2e 100644
--- a/drivers/staging/iio/accel/kxsd9.c
+++ b/drivers/staging/iio/accel/kxsd9.c
@@ -226,7 +226,7 @@ static int kxsd9_probe(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev;
 	struct kxsd9_state *st;
-	int ret = 0;
+	int ret;
 
 	indio_dev = iio_device_alloc(sizeof(*st));
 	if (indio_dev == NULL) {
@@ -245,14 +245,14 @@ static int kxsd9_probe(struct spi_device *spi)
 	indio_dev->info = &kxsd9_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	ret = iio_device_register(indio_dev);
-	if (ret)
-		goto error_free_dev;
-
 	spi->mode = SPI_MODE_0;
 	spi_setup(spi);
 	kxsd9_power_up(st);
 
+	ret = iio_device_register(indio_dev);
+	if (ret)
+		goto error_free_dev;
+
 	return 0;
 
 error_free_dev:
-- 
1.8.1
