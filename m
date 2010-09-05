Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: manuel.stahl@iis.fraunhofer.de,
	drivers@analog.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 4/4] staging:iio:adis16350 add missing registration of temp_offset attr
Date: Sun,  5 Sep 2010 23:20:18 +0100
Message-Id: <1283725218-15157-5-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1283725218-15157-1-git-send-email-jic23@cam.ac.uk>
References: <1283725218-15157-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/imu/adis16350_core.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/imu/adis16350_core.c b/drivers/staging/iio/imu/adis16350_core.c
index 8480dc2..b344cd9 100644
--- a/drivers/staging/iio/imu/adis16350_core.c
+++ b/drivers/staging/iio/imu/adis16350_core.c
@@ -570,6 +570,7 @@ static struct attribute *adis16350_attributes[] = {
 	&iio_dev_attr_temp_y_raw.dev_attr.attr,
 	&iio_dev_attr_temp_z_raw.dev_attr.attr,
 	&iio_const_attr_temp_scale.dev_attr.attr,
+	&iio_const_attr_temp_offset.dev_attr.attr,
 	&iio_dev_attr_in0_raw.dev_attr.attr,
 	&iio_const_attr_in0_scale.dev_attr.attr,
 	&iio_dev_attr_sampling_frequency.dev_attr.attr,
-- 
1.7.0.4
