Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Dimitris Papastamos
	<dp@opensource.wolfsonmicro.com>, Jonathan Cameron <jic23@kernel.org>
CC: Michael Hennerich <michael.hennerich@analog.com>,
	<linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
	<device-drivers-devel@blackfin.uclinux.org>, <drivers@analog.com>, Lars-Peter
 Clausen <lars@metafoo.de>
Subject: [PATCH 6/7] regmap: Add support for 10/14 register formating
Date: Wed, 16 Nov 2011 16:28:21 +0100
Message-ID: <1321457302-8724-6-git-send-email-lars@metafoo.de>
In-Reply-To: <1321457302-8724-1-git-send-email-lars@metafoo.de>
References: <1321457302-8724-1-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

This patch adds support for 10 bits register, 14 bits value type register
formating. This is for example used by the Analog Devices AD5380.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/base/regmap/regmap.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index b96cf72..e533368 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -90,6 +90,16 @@ static void regmap_format_7_9_write(struct regmap *map,
 	*out = cpu_to_be16((reg << 9) | val);
 }
 
+static void regmap_format_10_14_write(struct regmap *map,
+				    unsigned int reg, unsigned int val)
+{
+	u8 *out = map->work_buf;
+
+	out[2] = val;
+	out[1] = (val >> 8) | (reg << 6);
+	out[0] = reg >> 2;
+}
+
 static void regmap_format_8(void *buf, unsigned int val)
 {
 	u8 *b = buf;
@@ -188,6 +198,16 @@ struct regmap *regmap_init(struct device *dev,
 		}
 		break;
 
+	case 10:
+		switch (config->val_bits) {
+		case 14:
+			map->format.format_write = regmap_format_10_14_write;
+			break;
+		default:
+			goto err_map;
+		}
+		break;
+
 	case 8:
 		map->format.format_reg = regmap_format_8;
 		break;
-- 
1.7.7.1
