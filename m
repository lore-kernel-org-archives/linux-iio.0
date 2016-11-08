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
Subject: [PATCH 2/2] iio: gyro: mpu3050: add I2C dependency
Date: Tue,  8 Nov 2016 14:59:30 +0100
Message-Id: <20161108135945.2217384-2-arnd@arndb.de>
In-Reply-To: <20161108135945.2217384-1-arnd@arndb.de>
References: <20161108135945.2217384-1-arnd@arndb.de>
List-ID: <linux-iio@vger.kernel.org>

The new mpu3050 driver fails to build if I2C is disabled:

drivers/iio/built-in.o: In function `mpu3050_i2c_driver_exit':
mpu3050-i2c.c:(.exit.text+0x17f): undefined reference to `i2c_del_driver'
drivers/iio/built-in.o: In function `mpu3050_i2c_driver_init':
mpu3050-i2c.c:(.init.text+0x215): undefined reference to `i2c_register_driver'

This adds a Kconfig dependency to ensure we only build it when I2C
is available.

Fixes: 3904b28efb2c ("iio: gyro: Add driver for the MPU-3050 gyroscope")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/iio/gyro/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/gyro/Kconfig b/drivers/iio/gyro/Kconfig
index 107b5efd4178..3126cf05e6b9 100644
--- a/drivers/iio/gyro/Kconfig
+++ b/drivers/iio/gyro/Kconfig
@@ -93,6 +93,7 @@ config MPU3050
 config MPU3050_I2C
 	tristate "Invensense MPU3050 devices on I2C"
 	depends on !(INPUT_MPU3050=y || INPUT_MPU3050=m)
+	depends on I2C
 	select MPU3050
 	select REGMAP_I2C
 	select I2C_MUX
-- 
2.9.0
