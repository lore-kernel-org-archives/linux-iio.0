Return-Path: <SRS0=7p2b=JV=mail.steuer-voss.de=nv@kernel.org>
Message-Id: <b990bc14d89daba5ac3b14d4b2eefb47c972d63d.1530782560.git.nikolaus.voss@loewensteinmedical.de>
In-Reply-To: <cover.1530782560.git.nikolaus.voss@loewensteinmedical.de>
References: <cover.1530782560.git.nikolaus.voss@loewensteinmedical.de>
From: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
Date: Tue, 3 Jul 2018 08:06:57 +0200
Subject: [PATCH v4 2/2] IIO: st_accel_i2c.c: Use probe_new() instead of probe()
To: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Xiongfeng Wang <xiongfeng.wang@linaro.org>, nv@vosn.de, Javier Martinez Canillas <javier@dowhile0.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-iio@vger.kernel.org>

struct i2c_device_id argument of probe() is not used, so use probe_new()
instead.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
---
 drivers/iio/accel/st_accel_i2c.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
index d02298f0256c..2ca5d1f6ade0 100644
--- a/drivers/iio/accel/st_accel_i2c.c
+++ b/drivers/iio/accel/st_accel_i2c.c
@@ -139,8 +139,7 @@ static const struct i2c_device_id st_accel_id_table[] = {
 };
 MODULE_DEVICE_TABLE(i2c, st_accel_id_table);
 
-static int st_accel_i2c_probe(struct i2c_client *client,
-						const struct i2c_device_id *id)
+static int st_accel_i2c_probe(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev;
 	struct st_sensor_data *adata;
@@ -179,7 +178,7 @@ static struct i2c_driver st_accel_driver = {
 		.of_match_table = of_match_ptr(st_accel_of_match),
 		.acpi_match_table = ACPI_PTR(st_accel_acpi_match),
 	},
-	.probe = st_accel_i2c_probe,
+	.probe_new = st_accel_i2c_probe,
 	.remove = st_accel_i2c_remove,
 	.id_table = st_accel_id_table,
 };
-- 
2.17.1
