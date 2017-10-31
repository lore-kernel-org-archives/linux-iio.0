Return-Path: <SRS0=LfGY=B6=linux.intel.com=andriy.shevchenko@kernel.org>
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-i2c@vger.kernel.org,
	Wolfram Sang <wsa@the-dreams.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org
Subject: [PATCH v1 13/15] iio: imu: inv_mpu6050: Remove duplicate NULL check
Date: Tue, 31 Oct 2017 16:21:47 +0200
Message-Id: <20171031142149.32512-13-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20171031142149.32512-1-andriy.shevchenko@linux.intel.com>
References: <20171031142149.32512-1-andriy.shevchenko@linux.intel.com>
List-ID: <linux-iio@vger.kernel.org>

Since i2c_unregister_device() became NULL-aware we may remove duplicate
NULL check.

Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
index dd6fc6d21f9d..d78a10403bac 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
@@ -196,8 +196,7 @@ void inv_mpu_acpi_delete_mux_client(struct i2c_client *client)
 {
 	struct inv_mpu6050_state *st = iio_priv(dev_get_drvdata(&client->dev));
 
-	if (st->mux_client)
-		i2c_unregister_device(st->mux_client);
+	i2c_unregister_device(st->mux_client);
 }
 #else
 
-- 
2.14.2
