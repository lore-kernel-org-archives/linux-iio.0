Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from gateway24.websitewelcome.com ([192.185.50.45]:26015 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752653AbdHVTgQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 22 Aug 2017 15:36:16 -0400
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id 0B5333E958
        for <linux-iio@vger.kernel.org>; Tue, 22 Aug 2017 14:13:26 -0500 (CDT)
Date: Tue, 22 Aug 2017 14:13:25 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] iio: imu: inv_mpu6050: fix missing break in switch
Message-ID: <20170822191324.GA15477@embeddedgus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add missing break statement to prevent the code for case
IIO_CHAN_INFO_CALIBBIAS falling through to the default case.

Also, add a break to the default case for the switch within
case IIO_CHAN_INFO_CALIBBIAS.

Addresses-Coverity-ID: 1357377
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
This issue was reported by Coverity and it was tested by compilation only.
Please, verify if this is an actual bug.

 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 44830bc..6d2268a 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -542,7 +542,9 @@ static int inv_mpu6050_write_raw(struct iio_dev *indio_dev,
 			break;
 		default:
 			result = -EINVAL;
+			break;
 		}
+		break;
 	default:
 		result = -EINVAL;
 		break;
-- 
2.5.0

