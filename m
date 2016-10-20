Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34733 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936542AbcJTNIo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 20 Oct 2016 09:08:44 -0400
Received: by mail-pf0-f194.google.com with SMTP id 128so5593220pfz.1
        for <linux-iio@vger.kernel.org>; Thu, 20 Oct 2016 06:08:44 -0700 (PDT)
From: Eva Rachel Retuya <eraretuya@gmail.com>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        Eva Rachel Retuya <eraretuya@gmail.com>
Subject: [PATCH 1/2] staging: iio: ad7606: set proper supply name to devm_regulator_get()
Date: Thu, 20 Oct 2016 21:08:22 +0800
Message-Id: <1476968903-15771-2-git-send-email-eraretuya@gmail.com>
In-Reply-To: <1476968903-15771-1-git-send-email-eraretuya@gmail.com>
References: <1476968903-15771-1-git-send-email-eraretuya@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The name passed to devm_regulator_get() should match the name of the
supply as specified in the device datasheet. The supply on this device
is called 'AVcc' while currently, the driver uses just 'vcc'.

Use 'avcc' to specify the supply voltage since it is custom to use the
lower-caps version of the datasheet name.

Suggested-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Eva Rachel Retuya <eraretuya@gmail.com>
---
 drivers/staging/iio/adc/ad7606.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/adc/ad7606.c b/drivers/staging/iio/adc/ad7606.c
index 010c6e1..f9b354f 100644
--- a/drivers/staging/iio/adc/ad7606.c
+++ b/drivers/staging/iio/adc/ad7606.c
@@ -424,7 +424,7 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 	st->oversampling = 1;
 	INIT_WORK(&st->poll_work, &ad7606_poll_bh_to_ring);
 
-	st->reg = devm_regulator_get(dev, "vcc");
+	st->reg = devm_regulator_get(dev, "avcc");
 	if (!IS_ERR(st->reg)) {
 		ret = regulator_enable(st->reg);
 		if (ret)
-- 
2.7.4

