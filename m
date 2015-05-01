Return-Path: <k.kozlowski.k@gmail.com>
From: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
To: onathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Subject: [PATCH 2/9] iio: adc: axp288: Constify platform_device_id
Date: Sat,  2 May 2015 00:53:31 +0900
Message-Id: <1430495618-31807-2-git-send-email-k.kozlowski.k@gmail.com>
In-Reply-To: <1430495618-31807-1-git-send-email-k.kozlowski.k@gmail.com>
References: <1430495618-31807-1-git-send-email-k.kozlowski.k@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

The platform_device_id is not modified by the driver and core uses it as
const.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 drivers/iio/adc/axp288_adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/axp288_adc.c b/drivers/iio/adc/axp288_adc.c
index 08bcfb061ca5..27197fd1517e 100644
--- a/drivers/iio/adc/axp288_adc.c
+++ b/drivers/iio/adc/axp288_adc.c
@@ -238,7 +238,7 @@ static int axp288_adc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct platform_device_id axp288_adc_id_table[] = {
+static const struct platform_device_id axp288_adc_id_table[] = {
 	{ .name = "axp288_adc" },
 	{},
 };
-- 
2.1.4
