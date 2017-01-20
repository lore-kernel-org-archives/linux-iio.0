Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.75]:52289 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753101AbdATQ0u (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Jan 2017 11:26:50 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: accel: st_accel: add !SENSORS_LIS3LV02D depedency
Date: Fri, 20 Jan 2017 17:25:54 +0100
Message-Id: <20170120162615.3718940-1-arnd@arndb.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

warning: (IIO_ST_ACCEL_3AXIS) selects IIO_ST_ACCEL_SPI_3AXIS which has unmet direct dependencies (IIO && !SENSORS_LIS3_SPI && IIO_ST_ACCEL_3AXIS && IIO_ST_SENSORS_SPI)

Fixes: 762227721fe6 ("iio: accel: st_accel: handle deprecated bindings")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/iio/accel/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index ea295fe0f561..590ba8835fdc 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -120,6 +120,7 @@ config HID_SENSOR_ACCEL_3D
 config IIO_ST_ACCEL_3AXIS
 	tristate "STMicroelectronics accelerometers 3-Axis Driver"
 	depends on (I2C || SPI_MASTER) && SYSFS
+	depends on !SENSORS_LIS3LV02D
 	select IIO_ST_SENSORS_CORE
 	select IIO_ST_ACCEL_I2C_3AXIS if (I2C)
 	select IIO_ST_ACCEL_SPI_3AXIS if (SPI_MASTER)
-- 
2.9.0

