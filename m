Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:46766 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932254AbcDTNPi (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 20 Apr 2016 09:15:38 -0400
From: Crestez Dan Leonard <leonard.crestez@intel.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Crestez Dan Leonard <leonard.crestez@intel.com>
Subject: [PATCH 4/5] iio: inv_mpu6050: Add spi_device_id for INV_MPU6500
Date: Wed, 20 Apr 2016 16:15:12 +0300
Message-Id: <2d9d48e073bc9fa5cc7cb70c3e0decf824b8a03a.1461156671.git.leonard.crestez@intel.com>
In-Reply-To: <cover.1461156671.git.leonard.crestez@intel.com>
References: <cover.1461156671.git.leonard.crestez@intel.com>
In-Reply-To: <cover.1461156671.git.leonard.crestez@intel.com>
References: <cover.1461156671.git.leonard.crestez@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
index 3972a46..a0f8df2 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
@@ -80,6 +80,7 @@ static int inv_mpu_remove(struct spi_device *spi)
  */
 static const struct spi_device_id inv_mpu_id[] = {
 	{"mpu6000", INV_MPU6000},
+	{"mpu6500", INV_MPU6500},
 	{}
 };
 
-- 
2.5.5

