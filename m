Return-Path: <k.kozlowski.k@gmail.com>
From: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
To: onathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Subject: [PATCH 5/9] iio: light: hid-sensor-prox: Constify platform_device_id
Date: Sat,  2 May 2015 00:53:34 +0900
Message-Id: <1430495618-31807-5-git-send-email-k.kozlowski.k@gmail.com>
In-Reply-To: <1430495618-31807-1-git-send-email-k.kozlowski.k@gmail.com>
References: <1430495618-31807-1-git-send-email-k.kozlowski.k@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

The platform_device_id is not modified by the driver and core uses it as
const.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 drivers/iio/light/hid-sensor-prox.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
index 91ecc46ffeaa..be9db9d985b2 100644
--- a/drivers/iio/light/hid-sensor-prox.c
+++ b/drivers/iio/light/hid-sensor-prox.c
@@ -352,7 +352,7 @@ static int hid_prox_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct platform_device_id hid_prox_ids[] = {
+static const struct platform_device_id hid_prox_ids[] = {
 	{
 		/* Format: HID-SENSOR-usage_id_in_hex_lowercase */
 		.name = "HID-SENSOR-200011",
-- 
2.1.4
