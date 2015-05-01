Return-Path: <k.kozlowski.k@gmail.com>
From: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
To: onathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Subject: [PATCH 4/9] iio: light: hid-sensor-als: Constify platform_device_id
Date: Sat,  2 May 2015 00:53:33 +0900
Message-Id: <1430495618-31807-4-git-send-email-k.kozlowski.k@gmail.com>
In-Reply-To: <1430495618-31807-1-git-send-email-k.kozlowski.k@gmail.com>
References: <1430495618-31807-1-git-send-email-k.kozlowski.k@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

The platform_device_id is not modified by the driver and core uses it as
const.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 drivers/iio/light/hid-sensor-als.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
index 1609ecdd01b0..cf13a18bafd0 100644
--- a/drivers/iio/light/hid-sensor-als.c
+++ b/drivers/iio/light/hid-sensor-als.c
@@ -361,7 +361,7 @@ static int hid_als_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct platform_device_id hid_als_ids[] = {
+static const struct platform_device_id hid_als_ids[] = {
 	{
 		/* Format: HID-SENSOR-usage_id_in_hex_lowercase */
 		.name = "HID-SENSOR-200041",
-- 
2.1.4
