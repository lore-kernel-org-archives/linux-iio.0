Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from 132.79-246-81.adsl-static.isp.belgacom.be ([81.246.79.132]:46620
	"EHLO viper.mind.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754468AbbCXPyq (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 24 Mar 2015 11:54:46 -0400
From: =?UTF-8?q?Vianney=20le=20Cl=C3=A9ment=20de=20Saint-Marcq?=
	<vianney.leclement@essensium.com>
To: linux-iio@vger.kernel.org
Cc: =?UTF-8?q?Vianney=20le=20Cl=C3=A9ment=20de=20Saint-Marcq?=
	<vianney.leclement@essensium.com>,
	"Arnout Vandecappelle (Essensium/Mind)" <arnout@mind.be>
Subject: [PATCH v2 2/7] iio: mlx90614: Add symbols for accessible registers
Date: Tue, 24 Mar 2015 16:54:14 +0100
Message-Id: <1427212459-31585-3-git-send-email-vianney.leclement@essensium.com>
In-Reply-To: <1427212459-31585-1-git-send-email-vianney.leclement@essensium.com>
References: <1427212459-31585-1-git-send-email-vianney.leclement@essensium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add symbols for all accessible RAM and EEPROM registers, as well as the
sleep command and timings defined in the datasheet.

Signed-off-by: Vianney le Clément de Saint-Marcq <vianney.leclement@essensium.com>
Cc: Arnout Vandecappelle (Essensium/Mind) <arnout@mind.be>
---
 drivers/iio/temperature/mlx90614.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/temperature/mlx90614.c b/drivers/iio/temperature/mlx90614.c
index e2c6f1a..a2e3aa6 100644
--- a/drivers/iio/temperature/mlx90614.c
+++ b/drivers/iio/temperature/mlx90614.c
@@ -20,11 +20,35 @@
 
 #include <linux/iio/iio.h>
 
-#define MLX90614_OP_RAM 0x00
+#define MLX90614_OP_RAM		0x00
+#define MLX90614_OP_EEPROM	0x20
+#define MLX90614_OP_SLEEP	0xff
 
 /* RAM offsets with 16-bit data, MSB first */
+#define MLX90614_RAW1	(MLX90614_OP_RAM | 0x04) /* raw data IR channel 1 */
+#define MLX90614_RAW2	(MLX90614_OP_RAM | 0x05) /* raw data IR channel 2 */
 #define MLX90614_TA	(MLX90614_OP_RAM | 0x06) /* ambient temperature */
 #define MLX90614_TOBJ1	(MLX90614_OP_RAM | 0x07) /* object 1 temperature */
+#define MLX90614_TOBJ2	(MLX90614_OP_RAM | 0x08) /* object 2 temperature */
+
+/* EEPROM offsets with 16-bit data, MSB first */
+#define MLX90614_EMISSIVITY	(MLX90614_OP_EEPROM | 0x04) /* emissivity correction coefficient */
+#define MLX90614_CONFIG		(MLX90614_OP_EEPROM | 0x05) /* configuration register */
+
+/* Control bits in configuration register */
+#define MLX90614_CONFIG_IIR_SHIFT 0 /* IIR coefficient */
+#define MLX90614_CONFIG_IIR_MASK (0x7 << MLX90614_CONFIG_IIR_SHIFT)
+#define MLX90614_CONFIG_DUAL_SHIFT 6 /* single (0) or dual (1) IR sensor */
+#define MLX90614_CONFIG_DUAL_MASK (1 << MLX90614_CONFIG_DUAL_SHIFT)
+#define MLX90614_CONFIG_FIR_SHIFT 8 /* FIR coefficient */
+#define MLX90614_CONFIG_FIR_MASK (0x7 << MLX90614_CONFIG_FIR_SHIFT)
+#define MLX90614_CONFIG_GAIN_SHIFT 11 /* gain */
+#define MLX90614_CONFIG_GAIN_MASK (0x7 << MLX90614_CONFIG_GAIN_SHIFT)
+
+/* Timings (in ms) */
+#define MLX90614_TIMING_EEPROM 20 /* time for EEPROM write/erase to complete */
+#define MLX90614_TIMING_WAKEUP 34 /* time to hold SDA low for wake-up */
+#define MLX90614_TIMING_STARTUP 250 /* time before first data after wake-up */
 
 struct mlx90614_data {
 	struct i2c_client *client;
-- 
2.3.3

