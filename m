Return-Path: <SRS0=o2nv=EI=no-log.org=m.capdeville@kernel.org>
From: Marc CAPDEVILLE <m.capdeville@no-log.org>
To: Kevin Tsai <ktsai@capellamicro.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, linux-iio@vger.kernel.org, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Marc CAPDEVILLE <m.capdeville@no-log.org>
Subject: [PATCH v7 4/4] iio : cm32181 : cosmetic cleanup
Date: Sat, 13 Jan 2018 14:37:05 +0100
Message-Id: <20180113133705.25044-4-m.capdeville@no-log.org>
In-Reply-To: <20180113133705.25044-1-m.capdeville@no-log.org>
References: <20180113133705.25044-1-m.capdeville@no-log.org>
List-ID: <linux-iio@vger.kernel.org>

Somme cosmetic cleanup suggested by Peter Meerwald-Stadler.

Macro name :
   MLUX_PER_LUX => CM32181_MLUX_PER_LUX

Constante name :
   als_it_bits => cm32181_als_it_bits
   als_it_value => cm32181_als_it_value

Comment :
   Registers Address => Register Addresses

Suggested-by: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Signed-off-by: Marc CAPDEVILLE <m.capdeville@no-log.org>
Acked-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/light/cm32181.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
index eae5b7cc6878..8fc01c8d4522 100644
--- a/drivers/iio/light/cm32181.c
+++ b/drivers/iio/light/cm32181.c
@@ -22,7 +22,7 @@
 #include <linux/acpi.h>
 #include <linux/of_device.h>
 
-/* Registers Address */
+/* Register Addresses */
 #define CM32181_REG_ADDR_CMD		0x00
 #define CM32181_REG_ADDR_ALS		0x04
 #define CM32181_REG_ADDR_STATUS		0x06
@@ -48,7 +48,7 @@
 #define CM32181_MLUX_PER_BIT_BASE_IT	800000	/* Based on IT=800ms */
 #define	CM32181_CALIBSCALE_DEFAULT	1000
 #define CM32181_CALIBSCALE_RESOLUTION	1000
-#define MLUX_PER_LUX			1000
+#define CM32181_MLUX_PER_LUX		1000
 
 #define CM32181_ID			0x81
 #define CM3218_ID			0x18
@@ -57,8 +57,8 @@ static const u8 cm32181_reg[CM32181_CONF_REG_NUM] = {
 	CM32181_REG_ADDR_CMD,
 };
 
-static const int als_it_bits[] = {12, 8, 0, 1, 2, 3};
-static const int als_it_value[] = {25000, 50000, 100000, 200000, 400000,
+static const int cm32181_als_it_bits[] = {12, 8, 0, 1, 2, 3};
+static const int cm32181_als_it_value[] = {25000, 50000, 100000, 200000, 400000,
 	800000};
 
 struct cm32181_chip {
@@ -124,9 +124,9 @@ static int cm32181_read_als_it(struct cm32181_chip *cm32181, int *val2)
 	als_it = cm32181->conf_regs[CM32181_REG_ADDR_CMD];
 	als_it &= CM32181_CMD_ALS_IT_MASK;
 	als_it >>= CM32181_CMD_ALS_IT_SHIFT;
-	for (i = 0; i < ARRAY_SIZE(als_it_bits); i++) {
-		if (als_it == als_it_bits[i]) {
-			*val2 = als_it_value[i];
+	for (i = 0; i < ARRAY_SIZE(cm32181_als_it_bits); i++) {
+		if (als_it == cm32181_als_it_bits[i]) {
+			*val2 = cm32181_als_it_value[i];
 			return IIO_VAL_INT_PLUS_MICRO;
 		}
 	}
@@ -149,14 +149,14 @@ static int cm32181_write_als_it(struct cm32181_chip *cm32181, int val)
 	u16 als_it;
 	int ret, i, n;
 
-	n = ARRAY_SIZE(als_it_value);
+	n = ARRAY_SIZE(cm32181_als_it_value);
 	for (i = 0; i < n; i++)
-		if (val <= als_it_value[i])
+		if (val <= cm32181_als_it_value[i])
 			break;
 	if (i >= n)
 		i = n - 1;
 
-	als_it = als_it_bits[i];
+	als_it = cm32181_als_it_bits[i];
 	als_it <<= CM32181_CMD_ALS_IT_SHIFT;
 
 	mutex_lock(&cm32181->lock);
@@ -202,7 +202,7 @@ static int cm32181_get_lux(struct cm32181_chip *cm32181)
 	lux *= ret;
 	lux *= cm32181->calibscale;
 	lux /= CM32181_CALIBSCALE_RESOLUTION;
-	lux /= MLUX_PER_LUX;
+	lux /= CM32181_MLUX_PER_LUX;
 
 	if (lux > 0xFFFF)
 		lux = 0xFFFF;
@@ -270,9 +270,9 @@ static ssize_t cm32181_get_it_available(struct device *dev,
 {
 	int i, n, len;
 
-	n = ARRAY_SIZE(als_it_value);
+	n = ARRAY_SIZE(cm32181_als_it_value);
 	for (i = 0, len = 0; i < n; i++)
-		len += sprintf(buf + len, "0.%06u ", als_it_value[i]);
+		len += sprintf(buf + len, "0.%06u ", cm32181_als_it_value[i]);
 	return len + sprintf(buf + len, "\n");
 }
 
-- 
2.11.0
