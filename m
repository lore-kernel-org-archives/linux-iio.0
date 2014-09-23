Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-066.synserver.de ([212.40.185.66]:1077 "EHLO
	smtp-out-066.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755937AbaIWSEP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 23 Sep 2014 14:04:15 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 4/4] staging:iio:ad5933: Remove platform data from state struct
Date: Tue, 23 Sep 2014 20:04:08 +0200
Message-Id: <1411495448-17941-4-git-send-email-lars@metafoo.de>
In-Reply-To: <1411495448-17941-1-git-send-email-lars@metafoo.de>
References: <1411495448-17941-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The platform data is only used in the probe function. No need to keep it
around.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/impedance-analyzer/ad5933.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index ebff637..77c77b0 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -89,7 +89,6 @@
 struct ad5933_state {
 	struct i2c_client		*client;
 	struct regulator		*reg;
-	struct ad5933_platform_data	*pdata;
 	struct delayed_work		work;
 	unsigned long			mclk_hz;
 	unsigned char			ctrl_hb;
@@ -711,9 +710,7 @@ static int ad5933_probe(struct i2c_client *client,
 	st->client = client;
 
 	if (!pdata)
-		st->pdata = &ad5933_default_pdata;
-	else
-		st->pdata = pdata;
+		pdata = &ad5933_default_pdata;
 
 	st->reg = devm_regulator_get(&client->dev, "vcc");
 	if (!IS_ERR(st->reg)) {
@@ -726,10 +723,10 @@ static int ad5933_probe(struct i2c_client *client,
 	if (voltage_uv)
 		st->vref_mv = voltage_uv / 1000;
 	else
-		st->vref_mv = st->pdata->vref_mv;
+		st->vref_mv = pdata->vref_mv;
 
-	if (st->pdata->ext_clk_Hz) {
-		st->mclk_hz = st->pdata->ext_clk_Hz;
+	if (pdata->ext_clk_Hz) {
+		st->mclk_hz = pdata->ext_clk_Hz;
 		st->ctrl_lb = AD5933_CTRL_EXT_SYSCLK;
 	} else {
 		st->mclk_hz = AD5933_INT_OSC_FREQ_Hz;
-- 
1.8.0

