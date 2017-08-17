Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from 78-11-180-123.static.ip.netia.com.pl ([78.11.180.123]:41858
        "EHLO rere.qmqm.pl" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752750AbdHQOF5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 17 Aug 2017 10:05:57 -0400
Date: Thu, 17 Aug 2017 15:56:11 +0200
Message-Id: <e03b5e1041e404d30ee31b1a6d61cb49f36ed1ed.1502977929.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1502977929.git.mirq-linux@rere.qmqm.pl>
References: <cover.1502977929.git.mirq-linux@rere.qmqm.pl>
From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 3/4] iio: magnetometer: ak8974: mark INT_CLEAR as precious
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Reading INT_CLEAR has side effects - disallow reading it via debugfs.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/iio/magnetometer/ak8974.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iio/magnetometer/ak8974.c b/drivers/iio/magnetometer/ak8974.c
index ab204f8560e3..d8c45206ba00 100644
--- a/drivers/iio/magnetometer/ak8974.c
+++ b/drivers/iio/magnetometer/ak8974.c
@@ -662,11 +662,17 @@ static bool ak8974_writeable_reg(struct device *dev, unsigned int reg)
 	}
 }
 
+static bool ak8974_precious_reg(struct device *dev, unsigned int reg)
+{
+	return reg == AK8974_INT_CLEAR;
+}
+
 static const struct regmap_config ak8974_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
 	.max_register = 0xff,
 	.writeable_reg = ak8974_writeable_reg,
+	.precious_reg = ak8974_precious_reg,
 };
 
 static int ak8974_probe(struct i2c_client *i2c,
-- 
2.11.0

