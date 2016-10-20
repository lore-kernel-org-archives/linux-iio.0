Return-Path: <eraretuya@gmail.com>
From: Eva Rachel Retuya <eraretuya@gmail.com>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	knaack.h@gmx.de,
	pmeerw@pmeerw.net,
	gregkh@linuxfoundation.org,
	Eva Rachel Retuya <eraretuya@gmail.com>
Subject: [PATCH 2/2] staging: iio: ad7606: rework regulator handling
Date: Thu, 20 Oct 2016 21:08:23 +0800
Message-Id: <1476968903-15771-3-git-send-email-eraretuya@gmail.com>
In-Reply-To: <1476968903-15771-1-git-send-email-eraretuya@gmail.com>
References: <1476968903-15771-1-git-send-email-eraretuya@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Currently, this driver ignores all errors from regulator_get(). The way
it is now, it also breaks probe deferral (EPROBE_DEFER). The correct
behavior is to propagate the error to the upper layers so they can
handle it accordingly.

Rework the regulator handling so that it matches the standard behavior.
If the specific design uses a static always-on regulator and does not
explicitly specify it, regulator_get() will return the dummy regulator.

Suggested-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Eva Rachel Retuya <eraretuya@gmail.com>
---
 drivers/staging/iio/adc/ad7606.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7606.c b/drivers/staging/iio/adc/ad7606.c
index f9b354f..b0ae04a 100644
--- a/drivers/staging/iio/adc/ad7606.c
+++ b/drivers/staging/iio/adc/ad7606.c
@@ -425,10 +425,13 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 	INIT_WORK(&st->poll_work, &ad7606_poll_bh_to_ring);
 
 	st->reg = devm_regulator_get(dev, "avcc");
-	if (!IS_ERR(st->reg)) {
-		ret = regulator_enable(st->reg);
-		if (ret)
-			return ret;
+	if (IS_ERR(st->reg))
+		return PTR_ERR(st->reg);
+
+	ret = regulator_enable(st->reg);
+	if (ret) {
+		dev_err(dev, "Failed to enable specified AVcc supply\n");
+		return ret;
 	}
 
 	ret = ad7606_request_gpios(st);
@@ -484,8 +487,7 @@ error_free_irq:
 	free_irq(irq, indio_dev);
 
 error_disable_reg:
-	if (!IS_ERR(st->reg))
-		regulator_disable(st->reg);
+	regulator_disable(st->reg);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(ad7606_probe);
@@ -499,8 +501,7 @@ int ad7606_remove(struct device *dev, int irq)
 	iio_triggered_buffer_cleanup(indio_dev);
 
 	free_irq(irq, indio_dev);
-	if (!IS_ERR(st->reg))
-		regulator_disable(st->reg);
+	regulator_disable(st->reg);
 
 	return 0;
 }
-- 
2.7.4
