Return-Path: <SRS0=1Hpq=CB=linux.intel.com=andriy.shevchenko@kernel.org>
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v1] iio: magnetometer: ak8975: Remove wrong ACPI ID
Date: Fri,  3 Nov 2017 19:56:40 +0200
Message-Id: <20171103175640.33403-1-andriy.shevchenko@linux.intel.com>
List-ID: <linux-iio@vger.kernel.org>

The ID is added to proper sensor by the commit 6ed5ac50a3e0
("iio: imu: inv_mpu6050: ACPI enumeration").

Remove it from wrong place, otherwise user will get:

 ak8975 i2c-INVN6500:00: mounting matrix not found: using identity...
 ak8975 i2c-INVN6500:00: Unexpected device

Fixes: 6ed5ac50a3e0 ("iio: imu: inv_mpu6050: ACPI enumeration").
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/magnetometer/ak8975.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index 42a827a66512..f29a00729fa0 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -787,7 +787,6 @@ static const struct iio_info ak8975_info = {
 static const struct acpi_device_id ak_acpi_match[] = {
 	{"AK8975", AK8975},
 	{"AK8963", AK8963},
-	{"INVN6500", AK8963},
 	{"AK009911", AK09911},
 	{"AK09911", AK09911},
 	{"AK09912", AK09912},
-- 
2.14.2
