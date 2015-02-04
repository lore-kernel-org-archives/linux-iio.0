Return-Path: <rdunlap@infradead.org>
Message-ID: <54D26727.4060109@infradead.org>
Date: Wed, 04 Feb 2015 10:38:31 -0800
From: Randy Dunlap <rdunlap@infradead.org>
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>, linux-iio@vger.kernel.org
CC: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH -next] iio/magnetometer: fix AK09911 dependencies
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

From: Randy Dunlap <rdunlap@infradead.org>

Fix AK09911 dependencies to eliminate these build errors (since
'select' does not follow dependencies):

drivers/built-in.o: In function `ak8975_set_mode':
X32/../drivers/iio/magnetometer/ak8975.c:431: undefined reference to `i2c_smbus_write_byte_data'
drivers/built-in.o: In function `ak8975_read_raw':
X32/../drivers/iio/magnetometer/ak8975.c:572: undefined reference to `i2c_smbus_read_byte_data'
X32/../drivers/iio/magnetometer/ak8975.c:555: undefined reference to `i2c_smbus_read_byte_data'
X32/../drivers/iio/magnetometer/ak8975.c:650: undefined reference to `i2c_smbus_read_word_data'
X32/../drivers/iio/magnetometer/ak8975.c:634: undefined reference to `i2c_smbus_read_byte_data'
drivers/built-in.o: In function `ak8975_probe':
X32/../drivers/iio/magnetometer/ak8975.c:393: undefined reference to `i2c_smbus_read_i2c_block_data'
X32/../drivers/iio/magnetometer/ak8975.c:506: undefined reference to `i2c_smbus_read_i2c_block_data'
drivers/built-in.o: In function `ak8975_driver_init':
X32/../drivers/iio/magnetometer/ak8975.c:846: undefined reference to `i2c_register_driver'
drivers/built-in.o: In function `ak8975_driver_exit':
X32/../drivers/iio/magnetometer/ak8975.c:846: undefined reference to `i2c_del_driver'
drivers/built-in.o:(.debug_addr+0x4d868): undefined reference to `i2c_register_driver'
drivers/built-in.o:(.debug_addr+0x4d89c): undefined reference to `i2c_smbus_write_byte_data'
drivers/built-in.o:(.debug_addr+0x4d8a4): undefined reference to `i2c_smbus_read_word_data'
drivers/built-in.o:(.debug_addr+0x4d98c): undefined reference to `i2c_del_driver'
drivers/built-in.o:(.debug_addr+0x4da14): undefined reference to `i2c_smbus_read_i2c_block_data'
drivers/built-in.o:(.debug_addr+0x4dad4): undefined reference to `i2c_smbus_read_byte_data'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc:	Jonathan Cameron <jic23@kernel.org>
Cc:	Hartmut Knaack <knaack.h@gmx.de>
Cc:	Lars-Peter Clausen <lars@metafoo.de>
Cc:	Peter Meerwald <pmeerw@pmeerw.net>
Cc:	linux-iio@vger.kernel.org
---
 drivers/iio/magnetometer/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20150204.orig/drivers/iio/magnetometer/Kconfig
+++ linux-next-20150204/drivers/iio/magnetometer/Kconfig
@@ -18,6 +18,7 @@ config AK8975
 
 config AK09911
 	tristate "Asahi Kasei AK09911 3-axis Compass"
+	depends on I2C && GPIOLIB
 	select AK8975
 	help
 	  Deprecated: AK09911 is now supported by AK8975 driver.
