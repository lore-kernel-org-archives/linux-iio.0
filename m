Return-Path: <k.kozlowski.k@gmail.com>
From: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
To: onathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Subject: [PATCH 1/9] iio: hid-sensor-accel-3d: Constify platform_device_id
Date: Sat,  2 May 2015 00:53:30 +0900
Message-Id: <1430495618-31807-1-git-send-email-k.kozlowski.k@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

The platform_device_id is not modified by the driver and core uses it as
const.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 drivers/iio/accel/hid-sensor-accel-3d.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/hid-sensor-accel-3d.c
index 2b4fad6998c1..ab711495d56e 100644
--- a/drivers/iio/accel/hid-sensor-accel-3d.c
+++ b/drivers/iio/accel/hid-sensor-accel-3d.c
@@ -400,7 +400,7 @@ static int hid_accel_3d_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct platform_device_id hid_accel_3d_ids[] = {
+static const struct platform_device_id hid_accel_3d_ids[] = {
 	{
 		/* Format: HID-SENSOR-usage_id_in_hex_lowercase */
 		.name = "HID-SENSOR-200073",
-- 
2.1.4
