Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-32.csi.cam.ac.uk ([131.111.8.132]:58439 "EHLO
	ppsw-32.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753276Ab0IVLmh (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 22 Sep 2010 07:42:37 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: manuel.stahl@iis.fraunhofer.de, linux-iio@vger.kernel.org
Cc: drivers@analog.com, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 5/8] staging:iio:adis16350 add missing registration of temp_offset attr
Date: Wed, 22 Sep 2010 12:47:50 +0100
Message-Id: <1285156073-6327-7-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1285156073-6327-1-git-send-email-jic23@cam.ac.uk>
References: <1285156073-6327-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/imu/adis16350_core.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/imu/adis16350_core.c b/drivers/staging/iio/imu/adis16350_core.c
index 5ccb9aa..91d31b7 100644
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
1.7.2.2

