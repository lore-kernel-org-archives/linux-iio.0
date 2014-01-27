Return-Path: <groeck7@gmail.com>
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] iio: max1363: Use devm_regulator_get_optional for optional regulator
Date: Mon, 27 Jan 2014 10:10:27 -0800
Message-Id: <1390846227-28320-1-git-send-email-linux@roeck-us.net>
List-ID: <linux-iio@vger.kernel.org>

In kernel version 3.13, devm_regulator_get() may return no error
if a regulator is undeclared. regulator_get_voltage() will return
-EINVAL if this happens. This causes the driver to fail loading if
the vref regulator is not declared.

Since vref is optional, call devm_regulator_get_optional instead.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
Should be a candidate for -stable (v3.12+).

 drivers/iio/adc/max1363.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
index e283f2f..3602592 100644
--- a/drivers/iio/adc/max1363.c
+++ b/drivers/iio/adc/max1363.c
@@ -1560,7 +1560,7 @@ static int max1363_probe(struct i2c_client *client,
 	st->client = client;
 
 	st->vref_uv = st->chip_info->int_vref_mv * 1000;
-	vref = devm_regulator_get(&client->dev, "vref");
+	vref = devm_regulator_get_optional(&client->dev, "vref");
 	if (!IS_ERR(vref)) {
 		int vref_uv;
 
-- 
1.7.9.7
