Return-Path: <SRS0=wvzB=7T=rere.qmqm.pl=mirq-linux@kernel.org>
Date: Thu, 17 Aug 2017 15:56:11 +0200
Message-Id: <a90b0e9c8886114903498890a0ae2c66cb19b5f3.1502977929.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1502977929.git.mirq-linux@rere.qmqm.pl>
References: <cover.1502977929.git.mirq-linux@rere.qmqm.pl>
From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 2/4] iio: magnetometer: ak8974: add_device_randomness(fw +
 serial)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Linus Walleij <linus.walleij@linaro.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org
List-ID: <linux-iio@vger.kernel.org>

Mix device-specific data into randomness pool.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/iio/magnetometer/ak8974.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/magnetometer/ak8974.c b/drivers/iio/magnetometer/ak8974.c
index 76091da20a0c..ab204f8560e3 100644
--- a/drivers/iio/magnetometer/ak8974.c
+++ b/drivers/iio/magnetometer/ak8974.c
@@ -20,6 +20,7 @@
 #include <linux/mutex.h>
 #include <linux/delay.h>
 #include <linux/bitops.h>
+#include <linux/random.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/pm_runtime.h>
@@ -466,10 +467,12 @@ static int ak8974_detect(struct ak8974 *ak8974)
 		ret = regmap_read(ak8974->map, AMI305_VER, &fw);
 		if (ret)
 			return ret;
+		add_device_randomness(&fw, sizeof(fw));
 		fw &= 0x7f; /* only bits 0 thru 6 valid */
 		ret = ak8974_get_u16_val(ak8974, AMI305_SN, &sn);
 		if (ret)
 			return ret;
+		add_device_randomness(&sn, sizeof(sn));
 		dev_info(&ak8974->i2c->dev,
 			 "detected %s, FW ver %02x, S/N: %04x\n",
 			 name, fw, sn);
-- 
2.11.0
