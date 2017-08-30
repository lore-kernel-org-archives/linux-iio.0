Return-Path: <SRS0=75rx=AA=canonical.com=colin.king@kernel.org>
From: Colin King <colin.king@canonical.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Jean-Baptiste Maneyrol <JManeyrol@invensense.com>,
	linux-iio@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: imu: inv_mpu6050: make arrays hz and d static
Date: Wed, 30 Aug 2017 12:16:16 +0100
Message-Id: <20170830111616.27559-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-iio@vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

Don't populate the arrays on the stack, instead make them static.
Makes the object code smaller by 135 bytes:

Before:
   text	   data	    bss	    dec	    hex	filename
  15135	   4240	    128	  19503	   4c2f	inv_mpu_core.o

After:
   text	   data	    bss	    dec	    hex	filename
  14840	   4400	    128	  19368	   4ba8	inv_mpu_core.o

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 44830bce13df..6692f5e08dc8 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -570,10 +570,12 @@ static int inv_mpu6050_write_raw(struct iio_dev *indio_dev,
  */
 static int inv_mpu6050_set_lpf(struct inv_mpu6050_state *st, int rate)
 {
-	const int hz[] = {188, 98, 42, 20, 10, 5};
-	const int d[] = {INV_MPU6050_FILTER_188HZ, INV_MPU6050_FILTER_98HZ,
-			INV_MPU6050_FILTER_42HZ, INV_MPU6050_FILTER_20HZ,
-			INV_MPU6050_FILTER_10HZ, INV_MPU6050_FILTER_5HZ};
+	static const int hz[] = {188, 98, 42, 20, 10, 5};
+	static const int d[] = {
+		INV_MPU6050_FILTER_188HZ, INV_MPU6050_FILTER_98HZ,
+		INV_MPU6050_FILTER_42HZ, INV_MPU6050_FILTER_20HZ,
+		INV_MPU6050_FILTER_10HZ, INV_MPU6050_FILTER_5HZ
+	};
 	int i, h, result;
 	u8 data;
 
-- 
2.14.1
