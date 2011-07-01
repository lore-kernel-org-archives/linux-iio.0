Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: device-drivers-devel@blackfin.uclinux.org,
	ldewangan@nvidia.com,
	shubhrajyoti@ti.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 25/25] staging:iio:gyro:adis16260 fix missing num_channels setup.
Date: Fri,  1 Jul 2011 11:11:16 +0100
Message-Id: <1309515076-12323-26-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1309515076-12323-1-git-send-email-jic23@cam.ac.uk>
References: <1309515076-12323-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/gyro/adis16260_core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/gyro/adis16260_core.c b/drivers/staging/iio/gyro/adis16260_core.c
index 7c63f27..b09b367 100644
--- a/drivers/staging/iio/gyro/adis16260_core.c
+++ b/drivers/staging/iio/gyro/adis16260_core.c
@@ -613,7 +613,7 @@ static int __devinit adis16260_probe(struct spi_device *spi)
 		}
 	else
 		indio_dev->channels = adis16260_channels_x;
-
+	indio_dev->num_channels = ARRAY_SIZE(adis16260_channels_x);
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = adis16260_configure_ring(indio_dev);
-- 
1.7.3.4
