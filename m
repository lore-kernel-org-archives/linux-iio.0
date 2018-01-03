Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from szxga06-in.huawei.com ([45.249.212.32]:42706 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751357AbeACIGc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 3 Jan 2018 03:06:32 -0500
From: Wei Yongjun <weiyongjun1@huawei.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
CC: Wei Yongjun <weiyongjun1@huawei.com>, <linux-iio@vger.kernel.org>
Subject: [PATCH -next] iio: light: st_uvis25: make local symbols static
Date: Wed, 3 Jan 2018 08:12:07 +0000
Message-ID: <1514967127-127457-1-git-send-email-weiyongjun1@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Fixes the following sparse warning:

drivers/iio/light/st_uvis25_i2c.c:22:28: warning:
 symbol 'st_uvis25_i2c_regmap_config' was not declared. Should it be static?
drivers/iio/light/st_uvis25_spi.c:22:28: warning:
 symbol 'st_uvis25_spi_regmap_config' was not declared. Should it be static?

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/iio/light/st_uvis25_i2c.c | 2 +-
 drivers/iio/light/st_uvis25_spi.c | 2 +-
 2 file changed, 2 insertion(+), 2 deletion(-)

diff --git a/drivers/iio/light/st_uvis25_i2c.c b/drivers/iio/light/st_uvis25_i2c.c
index c939c0b..afd6eb0 100644
--- a/drivers/iio/light/st_uvis25_i2c.c
+++ b/drivers/iio/light/st_uvis25_i2c.c
@@ -19,7 +19,7 @@
 
 #define UVIS25_I2C_AUTO_INCREMENT	BIT(7)
 
-const struct regmap_config st_uvis25_i2c_regmap_config = {
+static const struct regmap_config st_uvis25_i2c_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
 	.write_flag_mask = UVIS25_I2C_AUTO_INCREMENT,
diff --git a/drivers/iio/light/st_uvis25_spi.c b/drivers/iio/light/st_uvis25_spi.c
index e697e14..cdfee5e 100644
--- a/drivers/iio/light/st_uvis25_spi.c
+++ b/drivers/iio/light/st_uvis25_spi.c
@@ -19,7 +19,7 @@
 #define UVIS25_SENSORS_SPI_READ		BIT(7)
 #define UVIS25_SPI_AUTO_INCREMENT	BIT(6)
 
-const struct regmap_config st_uvis25_spi_regmap_config = {
+static const struct regmap_config st_uvis25_spi_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
 	.read_flag_mask = UVIS25_SENSORS_SPI_READ | UVIS25_SPI_AUTO_INCREMENT,

