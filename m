Return-Path: <SRS0=IS6r=5R=arw.name=arw@kernel.org>
From: Alexander Wuerstlein <arw@arw.name>
To: arw@arw.name
Cc: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] iio hid-sensor-trigger: add Kconfig depends on IIO_BUFFER
Date: Mon, 12 Jun 2017 13:56:05 +0200
Message-Id: <20170612115608.28058-1-arw@arw.name>
List-ID: <linux-iio@vger.kernel.org>

Building a kernel with my configuration failed with:
> drivers/built-in.o: In function `hid_sensor_setup_batch_mode': staging/drivers/iio/common/hid-sensors/hid-sensor-trigger.c:104: undefined reference to `iio_buffer_set_attrs'
which is fixed by this patch.

Signed-off-by: Alexander Wuerstlein <arw@arw.name>
---
 drivers/iio/common/hid-sensors/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/common/hid-sensors/Kconfig b/drivers/iio/common/hid-sensors/Kconfig
index 39188b72cd3b..80105378b0ba 100644
--- a/drivers/iio/common/hid-sensors/Kconfig
+++ b/drivers/iio/common/hid-sensors/Kconfig
@@ -16,7 +16,7 @@ config HID_SENSOR_IIO_COMMON
 
 config HID_SENSOR_IIO_TRIGGER
 	tristate "Common module (trigger) for all HID Sensor IIO drivers"
-	depends on HID_SENSOR_HUB && HID_SENSOR_IIO_COMMON
+	depends on HID_SENSOR_HUB && HID_SENSOR_IIO_COMMON && IIO_BUFFER
 	select IIO_TRIGGER
 	help
 	  Say yes here to build trigger support for HID sensors.
-- 
2.11.0
