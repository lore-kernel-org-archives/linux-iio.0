Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-eopbgr710061.outbound.protection.outlook.com ([40.107.71.61]:56224
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727434AbeJBSlY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 2 Oct 2018 14:41:24 -0400
From: Alexandru Ardelean <alexandru.ardelean@analog.com>
To: <linux-iio@vger.kernel.org>, <Michael.Hennerich@analog.com>,
        <Dragos.Bogdan@analog.com>, <jic23@kernel.org>
CC: <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 1/4] staging: iio: ad5933: rename ext_clk_Hz -> ext_clk_hz
Date: Tue, 2 Oct 2018 14:57:57 +0300
Message-ID: <20181002115800.12399-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The checkpatch script doesn't like camel-case names.
Renamed the variable.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/staging/iio/impedance-analyzer/ad5933.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index a2370dd1e1a8..8a920f675b83 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -84,13 +84,13 @@
 
 /**
  * struct ad5933_platform_data - platform specific data
- * @ext_clk_Hz:		the external clock frequency in Hz, if not set
+ * @ext_clk_hz:		the external clock frequency in Hz, if not set
  *			the driver uses the internal clock (16.776 MHz)
  * @vref_mv:		the external reference voltage in millivolt
  */
 
 struct ad5933_platform_data {
-	unsigned long			ext_clk_Hz;
+	unsigned long			ext_clk_hz;
 	unsigned short			vref_mv;
 };
 
@@ -726,8 +726,8 @@ static int ad5933_probe(struct i2c_client *client,
 	else
 		st->vref_mv = pdata->vref_mv;
 
-	if (pdata->ext_clk_Hz) {
-		st->mclk_hz = pdata->ext_clk_Hz;
+	if (pdata->ext_clk_hz) {
+		st->mclk_hz = pdata->ext_clk_hz;
 		st->ctrl_lb = AD5933_CTRL_EXT_SYSCLK;
 	} else {
 		st->mclk_hz = AD5933_INT_OSC_FREQ_Hz;
-- 
2.17.1
