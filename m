Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] iio: gyro: mpu3050: remove duplicate initializer
Date: Tue,  8 Nov 2016 14:59:29 +0100
Message-Id: <20161108135945.2217384-1-arnd@arndb.de>
List-ID: <linux-iio@vger.kernel.org>

The newly added mpu3050 driver has two initializations for the
module owner, which causes a warning for 'make W=1':

include/linux/export.h:37:21: error: initialized field overwritten [-Werror=override-init]
drivers/iio/gyro/mpu3050-core.c:749:19: note: in expansion of macro 'THIS_MODULE'

This removes one of the two.

Fixes: 3904b28efb2c ("iio: gyro: Add driver for the MPU-3050 gyroscope")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/iio/gyro/mpu3050-core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
index ed681c70a7b4..2be2a5d287e6 100644
--- a/drivers/iio/gyro/mpu3050-core.c
+++ b/drivers/iio/gyro/mpu3050-core.c
@@ -746,7 +746,6 @@ static const struct iio_info mpu3050_info = {
 	.read_raw = mpu3050_read_raw,
 	.write_raw = mpu3050_write_raw,
 	.attrs = &mpu3050_attribute_group,
-	.driver_module = THIS_MODULE,
 };
 
 /**
-- 
2.9.0
