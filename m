Return-Path: <SRS0=aVu3=BY=users.sourceforge.net=elfring@kernel.org>
Subject: [PATCH 1/2] iio/accel/stk8ba50: Use common error handling code in
 stk8ba50_probe()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Tiberiu Breana <tiberiu.a.breana@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <5ab7e200-2dea-63e2-06db-0e185f563d16@users.sourceforge.net>
Message-ID: <0f26a13b-7bbf-525b-a864-8aa8e13c3aef@users.sourceforge.net>
Date: Wed, 25 Oct 2017 22:16:31 +0200
MIME-Version: 1.0
In-Reply-To: <5ab7e200-2dea-63e2-06db-0e185f563d16@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 25 Oct 2017 21:36:03 +0200

* Add a jump target so that a specific error message is stored only once
  at the end of this function implementation.

* Replace two calls of the function "dev_err" by goto statements.

* Adjust condition checks.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/iio/accel/stk8ba50.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/accel/stk8ba50.c b/drivers/iio/accel/stk8ba50.c
index 576b6b140f08..afe90567ad37 100644
--- a/drivers/iio/accel/stk8ba50.c
+++ b/drivers/iio/accel/stk8ba50.c
@@ -426,16 +426,13 @@ static int stk8ba50_probe(struct i2c_client *client,
 	/* Set up interrupts */
 	ret = i2c_smbus_write_byte_data(client,
 			STK8BA50_REG_INTEN2, STK8BA50_DREADY_INT_MASK);
-	if (ret < 0) {
-		dev_err(&client->dev, "failed to set up interrupts\n");
-		goto err_power_off;
-	}
+	if (ret)
+		goto report_failure;
+
 	ret = i2c_smbus_write_byte_data(client,
 			STK8BA50_REG_INTMAP2, STK8BA50_DREADY_INT_MAP);
-	if (ret < 0) {
-		dev_err(&client->dev, "failed to set up interrupts\n");
-		goto err_power_off;
-	}
+	if (ret)
+		goto report_failure;
 
 	if (client->irq > 0) {
 		ret = devm_request_threaded_irq(&client->dev, client->irq,
@@ -495,6 +492,10 @@ static int stk8ba50_probe(struct i2c_client *client,
 err_power_off:
 	stk8ba50_set_power(data, STK8BA50_MODE_SUSPEND);
 	return ret;
+
+report_failure:
+	dev_err(&client->dev, "failed to set up interrupts\n");
+	goto err_power_off;
 }
 
 static int stk8ba50_remove(struct i2c_client *client)
-- 
2.14.3
