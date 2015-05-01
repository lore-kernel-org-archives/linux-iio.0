Return-Path: <k.kozlowski.k@gmail.com>
From: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Subject: [PATCH] staging: iio: ad7606_par: Constify platform_device_id
Date: Sat,  2 May 2015 00:43:22 +0900
Message-Id: <1430495002-31057-1-git-send-email-k.kozlowski.k@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

The platform_device_id is not modified by the driver and core uses it as
const.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 drivers/staging/iio/adc/ad7606_par.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/adc/ad7606_par.c b/drivers/staging/iio/adc/ad7606_par.c
index 9e24b4d4455f..1d48ae381d16 100644
--- a/drivers/staging/iio/adc/ad7606_par.c
+++ b/drivers/staging/iio/adc/ad7606_par.c
@@ -119,7 +119,7 @@ static const struct dev_pm_ops ad7606_pm_ops = {
 #define AD7606_PAR_PM_OPS NULL
 #endif  /* CONFIG_PM */
 
-static struct platform_device_id ad7606_driver_ids[] = {
+static const struct platform_device_id ad7606_driver_ids[] = {
 	{
 		.name		= "ad7606-8",
 		.driver_data	= ID_AD7606_8,
-- 
2.1.4
