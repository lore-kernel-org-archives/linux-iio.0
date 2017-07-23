Return-Path: <SRS0=UbNB=62=huawei.com=Jonathan.Cameron@kernel.org>
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: linux-iio@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	platform-driver-x86@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 38/45] platform/x86: toshiba_acpi: drop assignment of iio_info.driver_module
Date: Sun, 23 Jul 2017 17:26:20 +0100
Message-Id: <20170723162627.22534-39-Jonathan.Cameron@huawei.com>
In-Reply-To: <20170723162627.22534-1-Jonathan.Cameron@huawei.com>
References: <20170723162627.22534-1-Jonathan.Cameron@huawei.com>
List-ID: <linux-iio@vger.kernel.org>

From: Jonathan Cameron <jic23@kernel.org>

This is now handled by use of a macro for device registration.  The field
in iio_info will be going away shortly as it is no longer used.

Cc: <platform-driver-x86@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Acked-by: Azael Avalos <coproscefalo@gmail.com>
---
 drivers/platform/x86/toshiba_acpi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/toshiba_acpi.c
index d0daf75cbed1..ef4301f41727 100644
--- a/drivers/platform/x86/toshiba_acpi.c
+++ b/drivers/platform/x86/toshiba_acpi.c
@@ -2515,7 +2515,6 @@ static const struct iio_chan_spec toshiba_iio_accel_channels[] = {
 };
 
 static const struct iio_info toshiba_iio_accel_info = {
-	.driver_module = THIS_MODULE,
 	.read_raw = &toshiba_iio_accel_read_raw,
 };
 
-- 
2.13.3
