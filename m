Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-dm3nam03on0062.outbound.protection.outlook.com ([104.47.41.62]:48256
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751413AbdFGNm2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 7 Jun 2017 09:42:28 -0400
From: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To: linux-iio <linux-iio@vger.kernel.org>
Subject: [PATCH v2 2/7] iio: imu: inv_mpu6050: replace sprintf with scnprintf
Date: Wed, 7 Jun 2017 13:42:26 +0000
Message-ID: <BLUPR12MB065777243F5CD0574B4B19B1C4C80@BLUPR12MB0657.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/i=
nv_mpu6050/inv_mpu_core.c
index 37fb18f..64af12c 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -684,7 +684,8 @@ static ssize_t inv_attr_show(struct device *dev, struct=
 device_attribute *attr,
 	case ATTR_ACCL_MATRIX:
 		m =3D st->plat_data.orientation;
=20
-		return sprintf(buf, "%d, %d, %d; %d, %d, %d; %d, %d, %d\n",
+		return scnprintf(buf, PAGE_SIZE,
+			"%d, %d, %d; %d, %d, %d; %d, %d, %d\n",
 			m[0], m[1], m[2], m[3], m[4], m[5], m[6], m[7], m[8]);
 	default:
 		return -EINVAL;
--=20
1.9.1
