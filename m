Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-by2nam01on0088.outbound.protection.outlook.com ([104.47.34.88]:51615
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727434AbeJBSls (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 2 Oct 2018 14:41:48 -0400
From: Alexandru Ardelean <alexandru.ardelean@analog.com>
To: <linux-iio@vger.kernel.org>, <Michael.Hennerich@analog.com>,
        <Dragos.Bogdan@analog.com>, <jic23@kernel.org>
CC: <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        Dragos Bogdan <dragos.bogdan@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 2/4] staging: iio: ad5933: Add regulator binding for vref
Date: Tue, 2 Oct 2018 14:57:58 +0300
Message-ID: <20181002115800.12399-2-alexandru.ardelean@analog.com>
In-Reply-To: <20181002115800.12399-1-alexandru.ardelean@analog.com>
References: <20181002115800.12399-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Dragos Bogdan <dragos.bogdan@analog.com>

In order to add full device tree support, add the option of specifying
the vref using the regulator framework.

Signed-off-by: Dragos Bogdan <dragos.bogdan@analog.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/staging/iio/impedance-analyzer/ad5933.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index 8a920f675b83..ec54ab4471b9 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -97,6 +97,7 @@ struct ad5933_platform_data {
 struct ad5933_state {
 	struct i2c_client		*client;
 	struct regulator		*reg;
+	struct regulator		*vref;
 	struct delayed_work		work;
 	struct mutex			lock; /* Protect sensor state */
 	unsigned long			mclk_hz;
@@ -721,6 +722,14 @@ static int ad5933_probe(struct i2c_client *client,
 	}
 	voltage_uv = regulator_get_voltage(st->reg);
 
+	st->reg = devm_regulator_get(&client->dev, "vref");
+	if (!IS_ERR(st->vref)) {
+		ret = regulator_enable(st->vref);
+		if (ret)
+			goto error_disable_reg;
+		pdata->vref_mv = regulator_get_voltage(st->vref) / 1000;
+	}
+
 	if (voltage_uv)
 		st->vref_mv = voltage_uv / 1000;
 	else
@@ -747,7 +756,7 @@ static int ad5933_probe(struct i2c_client *client,
 
 	ret = ad5933_register_ring_funcs_and_init(indio_dev);
 	if (ret)
-		goto error_disable_reg;
+		goto error_disable_vref;
 
 	ret = ad5933_setup(st);
 	if (ret)
@@ -761,6 +770,8 @@ static int ad5933_probe(struct i2c_client *client,
 
 error_unreg_ring:
 	iio_kfifo_free(indio_dev->buffer);
+error_disable_vref:
+	regulator_disable(st->vref);
 error_disable_reg:
 	regulator_disable(st->reg);
 
@@ -775,6 +786,7 @@ static int ad5933_remove(struct i2c_client *client)
 	iio_device_unregister(indio_dev);
 	iio_kfifo_free(indio_dev->buffer);
 	regulator_disable(st->reg);
+	regulator_disable(st->vref);
 
 	return 0;
 }
-- 
2.17.1
