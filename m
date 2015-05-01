Return-Path: <k.kozlowski.k@gmail.com>
From: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
To: onathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Subject: [PATCH 6/9] iio: hid-sensor-magn-3d: Constify platform_device_id
Date: Sat,  2 May 2015 00:53:35 +0900
Message-Id: <1430495618-31807-6-git-send-email-k.kozlowski.k@gmail.com>
In-Reply-To: <1430495618-31807-1-git-send-email-k.kozlowski.k@gmail.com>
References: <1430495618-31807-1-git-send-email-k.kozlowski.k@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

The platform_device_id is not modified by the driver and core uses it as
const.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 drivers/iio/magnetometer/hid-sensor-magn-3d.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d.c b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
index 4f9c0be24451..d8a0c8da8db0 100644
--- a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
+++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
@@ -510,7 +510,7 @@ static int hid_magn_3d_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct platform_device_id hid_magn_3d_ids[] = {
+static const struct platform_device_id hid_magn_3d_ids[] = {
 	{
 		/* Format: HID-SENSOR-usage_id_in_hex_lowercase */
 		.name = "HID-SENSOR-200083",
-- 
2.1.4
