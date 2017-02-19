Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35629 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751747AbdBSUAr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Feb 2017 15:00:47 -0500
Received: by mail-pg0-f65.google.com with SMTP id 1so2915557pgz.2
        for <linux-iio@vger.kernel.org>; Sun, 19 Feb 2017 12:00:46 -0800 (PST)
Date: Mon, 20 Feb 2017 01:30:27 +0530
From: sayli karnik <karniksayli1995@gmail.com>
To: outreachy-kernel@googlegroups.com
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org
Subject: [PATCH v2 2/2] staging: iio: ad7152: Use GENMASK() macro for left
 shifts
Message-ID: <b74094e5c94e11cad734b1bde11db0356e6d3aab.1487483384.git.karniksayli1995@gmail.com>
References: <cover.1487483384.git.karniksayli1995@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1487483384.git.karniksayli1995@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Use GENMASK() macro for left shifting integers.

Signed-off-by: sayli karnik <karniksayli1995@gmail.com>
---
v2:
Used GENMASK() macro instead of BIT() macro for multi-bit bitfields.
Removed extra parentheses around argument to macro

 drivers/staging/iio/cdc/ad7152.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7152.c b/drivers/staging/iio/cdc/ad7152.c
index e8609b8..ab94fad 100644
--- a/drivers/staging/iio/cdc/ad7152.c
+++ b/drivers/staging/iio/cdc/ad7152.c
@@ -47,28 +47,28 @@
 #define AD7152_STATUS_PWDN		BIT(7)
 
 /* Setup Register Bit Designations (AD7152_REG_CHx_SETUP) */
-#define AD7152_SETUP_CAPDIFF		(1 << 5)
-#define AD7152_SETUP_RANGE_2pF		(0 << 6)
-#define AD7152_SETUP_RANGE_0_5pF	(1 << 6)
-#define AD7152_SETUP_RANGE_1pF		(2 << 6)
-#define AD7152_SETUP_RANGE_4pF		(3 << 6)
-#define AD7152_SETUP_RANGE(x)		((x) << 6)
+#define AD7152_SETUP_CAPDIFF		GENMASK(1, 5)
+#define AD7152_SETUP_RANGE_2pF		GENMASK(0, 6)
+#define AD7152_SETUP_RANGE_0_5pF	GENMASK(1, 6)
+#define AD7152_SETUP_RANGE_1pF		GENMASK(2, 6)
+#define AD7152_SETUP_RANGE_4pF		GENMASK(3, 6)
+#define AD7152_SETUP_RANGE(x)		GENMASK(x, 6)
 
 /* Config Register Bit Designations (AD7152_REG_CFG) */
-#define AD7152_CONF_CH2EN		(1 << 3)
-#define AD7152_CONF_CH1EN		(1 << 4)
-#define AD7152_CONF_MODE_IDLE		(0 << 0)
-#define AD7152_CONF_MODE_CONT_CONV	(1 << 0)
-#define AD7152_CONF_MODE_SINGLE_CONV	(2 << 0)
-#define AD7152_CONF_MODE_OFFS_CAL	(5 << 0)
-#define AD7152_CONF_MODE_GAIN_CAL	(6 << 0)
+#define AD7152_CONF_CH2EN		GENMASK(1, 3)
+#define AD7152_CONF_CH1EN		GENMASK(1, 4)
+#define AD7152_CONF_MODE_IDLE		GENMASK(0, 0)
+#define AD7152_CONF_MODE_CONT_CONV	GENMASK(1, 0)
+#define AD7152_CONF_MODE_SINGLE_CONV	GENMASK(2, 0)
+#define AD7152_CONF_MODE_OFFS_CAL	GENMASK(5, 0)
+#define AD7152_CONF_MODE_GAIN_CAL	GENMASK(6, 0)
 
 /* Capdac Register Bit Designations (AD7152_REG_CAPDAC_XXX) */
-#define AD7152_CAPDAC_DACEN		(1 << 7)
-#define AD7152_CAPDAC_DACP(x)		((x) & 0x1F)
+#define AD7152_CAPDAC_DACEN		GENMASK(1, 7)
+#define AD7152_CAPDAC_DACP(x)		GENMASK(x, 0x1F)
 
 /* CFG2 Register Bit Designations (AD7152_REG_CFG2) */
-#define AD7152_CFG2_OSR(x)		(((x) & 0x3) << 4)
+#define AD7152_CFG2_OSR(x)		GENMASK((x) & 0x3, 4)
 
 enum {
 	AD7152_DATA,
-- 
2.7.4

