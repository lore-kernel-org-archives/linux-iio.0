Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.steuer-voss.de ([85.183.69.95]:45712 "EHLO
        mail.steuer-voss.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753421AbeGDNfT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 4 Jul 2018 09:35:19 -0400
Message-Id: <d6f374da848179583f86bfc965125ebf2e4d8317.1530710826.git.nikolaus.voss@loewensteinmedical.de>
In-Reply-To: <cover.1530710826.git.nikolaus.voss@loewensteinmedical.de>
References: <cover.1530710826.git.nikolaus.voss@loewensteinmedical.de>
From: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
Date: Tue, 3 Jul 2018 08:06:57 +0200
Subject: [PATCH v3 2/2] IIO: st_accel_i2c.c: Use probe_new() instead of probe()
To: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiongfeng Wang <xiongfeng.wang@linaro.org>,
        Javier Martinez Canillas <javier@dowhile0.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

struct i2c_device_id argument of probe() is not used, so use probe_new()
instead.

Signed-off-by: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
---
 drivers/iio/accel/st_accel_i2c.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
index c6e08c834f11..0659e9a67f85 100644
--- a/drivers/iio/accel/st_accel_i2c.c
+++ b/drivers/iio/accel/st_accel_i2c.c
@@ -138,8 +138,7 @@ static const struct i2c_device_id st_accel_id_table[] = {
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

