Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.18]:54094 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754696AbbG0Wtl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 27 Jul 2015 18:49:41 -0400
From: Hartmut Knaack <knaack.h@gmx.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Tiberiu Breana <tiberiu.a.breana@intel.com>
Subject: [PATCH 4/7] iio:accel:stk8312: rework macro definitions
Date: Tue, 28 Jul 2015 00:49:24 +0200
Message-Id: <aa5a9b6fdfbd4d19d3b3eea3a8c4dbe53efd5a59.1437955135.git.knaack.h@gmx.de>
In-Reply-To: <cover.1437955135.git.knaack.h@gmx.de>
References: <cover.1437955135.git.knaack.h@gmx.de>
In-Reply-To: <cover.1437955135.git.knaack.h@gmx.de>
References: <cover.1437955135.git.knaack.h@gmx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Make use of BIT to describe register bits, GENMASK for consecutive
bitmasks, rename and sort existing definitions, replace magic value with
an expressive definition, drop an unused definition.

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
---
 drivers/iio/accel/stk8312.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/accel/stk8312.c b/drivers/iio/accel/stk8312.c
index 50a102ca44d3..8783f0bf7c53 100644
--- a/drivers/iio/accel/stk8312.c
+++ b/drivers/iio/accel/stk8312.c
@@ -37,16 +37,16 @@
 #define STK8312_REG_OTPDATA		0x3E
 #define STK8312_REG_OTPCTRL		0x3F
 
-#define STK8312_MODE_ACTIVE		0x01
+#define STK8312_MODE_ACTIVE		BIT(0)
 #define STK8312_MODE_STANDBY		0x00
-#define STK8312_DREADY_BIT		0x10
-#define STK8312_INT_MODE		0xC0
-#define STK8312_RNG_MASK		0xC0
-#define STK8312_SR_MASK			0x07
-#define STK8312_SR_400HZ_IDX		0
+#define STK8312_MODE_INT_AH_PP		0xC0	/* active-high, push-pull */
+#define STK8312_DREADY_BIT		BIT(4)
+#define STK8312_RNG_6G			1
 #define STK8312_RNG_SHIFT		6
-#define STK8312_READ_RETRIES		16
-#define STK8312_ALL_CHANNEL_MASK	7
+#define STK8312_RNG_MASK		GENMASK(7, 6)
+#define STK8312_SR_MASK			GENMASK(2, 0)
+#define STK8312_SR_400HZ_IDX		0
+#define STK8312_ALL_CHANNEL_MASK	GENMASK(2, 0)
 #define STK8312_ALL_CHANNEL_SIZE	3
 
 #define STK8312_DRIVER_NAME		"stk8312"
@@ -144,7 +144,7 @@ static int stk8312_otp_init(struct stk8312_data *data)
 		if (ret < 0)
 			goto exit_err;
 		count--;
-	} while (!(ret & 0x80) && count > 0);
+	} while (!(ret & BIT(7)) && count > 0);
 
 	if (count == 0) {
 		ret = -ETIMEDOUT;
@@ -560,11 +560,12 @@ static int stk8312_probe(struct i2c_client *client,
 		return ret;
 	}
 	data->sample_rate_idx = STK8312_SR_400HZ_IDX;
-	ret = stk8312_set_range(data, 1);
+	ret = stk8312_set_range(data, STK8312_RNG_6G);
 	if (ret < 0)
 		return ret;
 
-	ret = stk8312_set_mode(data, STK8312_INT_MODE | STK8312_MODE_ACTIVE);
+	ret = stk8312_set_mode(data,
+			       STK8312_MODE_INT_AH_PP | STK8312_MODE_ACTIVE);
 	if (ret < 0)
 		return ret;
 
@@ -685,7 +686,7 @@ MODULE_DEVICE_TABLE(acpi, stk8312_acpi_id);
 
 static struct i2c_driver stk8312_driver = {
 	.driver = {
-		.name = "stk8312",
+		.name = STK8312_DRIVER_NAME,
 		.pm = STK8312_PM_OPS,
 		.acpi_match_table = ACPI_PTR(stk8312_acpi_id),
 	},
-- 
2.4.6

