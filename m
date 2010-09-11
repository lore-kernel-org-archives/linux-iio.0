Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-30.csi.cam.ac.uk ([131.111.8.130]:43165 "EHLO
	ppsw-30.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752602Ab0IKO63 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 11 Sep 2010 10:58:29 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Michael.Hennerich@analog.com, Robin.Getz@analog.com,
	manuel.stahl@iis.fraunhofer.de, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 4/6] staging:iio:adis16350 add missing registration of temp_offset attr
Date: Sat, 11 Sep 2010 15:58:18 +0100
Message-Id: <1284217100-2469-5-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1284217100-2469-1-git-send-email-jic23@cam.ac.uk>
References: <1284217100-2469-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/imu/adis16350_core.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/imu/adis16350_core.c b/drivers/staging/iio/imu/adis16350_core.c
index b852dfc..dc83489 100644
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

