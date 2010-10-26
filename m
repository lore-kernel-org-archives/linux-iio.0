Return-Path: <vapier@gentoo.org>
From: Mike Frysinger <vapier@gentoo.org>
To: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Cc: device-drivers-devel@blackfin.uclinux.org
Subject: [PATCH 01/36] staging: iio: adis16350: add missing reference to temp offset
Date: Tue, 26 Oct 2010 14:17:11 -0400
Message-Id: <1288117066-18055-2-git-send-email-vapier@gentoo.org>
In-Reply-To: <1288117066-18055-1-git-send-email-vapier@gentoo.org>
References: <1288117066-18055-1-git-send-email-vapier@gentoo.org>
List-ID: <linux-iio@vger.kernel.org>

We declare this attr but never link it in to the attr list.

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 drivers/staging/iio/imu/adis16350_core.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/imu/adis16350_core.c b/drivers/staging/iio/imu/adis16350_core.c
index 97c1ec8..cf7176b 100644
--- a/drivers/staging/iio/imu/adis16350_core.c
+++ b/drivers/staging/iio/imu/adis16350_core.c
@@ -570,6 +570,7 @@ static struct attribute *adis16350_attributes[] = {
 	&iio_dev_attr_temp_y_raw.dev_attr.attr,
 	&iio_dev_attr_temp_z_raw.dev_attr.attr,
 	&iio_const_attr_temp_scale.dev_attr.attr,
+	&iio_const_attr_temp_offset.dev_attr.attr,
 	&iio_dev_attr_in1_raw.dev_attr.attr,
 	&iio_const_attr_in1_scale.dev_attr.attr,
 	&iio_dev_attr_sampling_frequency.dev_attr.attr,
-- 
1.7.3.2
