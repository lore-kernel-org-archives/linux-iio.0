Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:44063 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1035274AbcIWPTv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 23 Sep 2016 11:19:51 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Philippe Reynes <tremyfr@yahoo.fr>,
        Martin Fuzzey <mfuzzey@parkeon.com>, linux-iio@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v3 3/4] iio:max1027: Use iio_trigger_validate_own_device() helper
Date: Fri, 23 Sep 2016 17:19:43 +0200
Message-Id: <1474643984-14262-3-git-send-email-lars@metafoo.de>
In-Reply-To: <1474643984-14262-1-git-send-email-lars@metafoo.de>
References: <1474643984-14262-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Use the new iio_trigger_validate_own_device() to verify that the trigger
can only be attached to the matching IIO device rather than using a custom
variant.

While the implementation of iio_trigger_validate_own_device() and the
custom variant and are not identical their behaviour is.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
New in v3
---
 drivers/iio/adc/max1027.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
index 712fbd2..8ea3271 100644
--- a/drivers/iio/adc/max1027.c
+++ b/drivers/iio/adc/max1027.c
@@ -360,17 +360,6 @@ static int max1027_set_trigger_state(struct iio_trigger *trig, bool state)
 	return 0;
 }
 
-static int max1027_validate_device(struct iio_trigger *trig,
-				   struct iio_dev *indio_dev)
-{
-	struct iio_dev *indio = iio_trigger_get_drvdata(trig);
-
-	if (indio != indio_dev)
-		return -EINVAL;
-
-	return 0;
-}
-
 static irqreturn_t max1027_trigger_handler(int irq, void *private)
 {
 	struct iio_poll_func *pf = (struct iio_poll_func *)private;
@@ -391,7 +380,7 @@ static irqreturn_t max1027_trigger_handler(int irq, void *private)
 
 static const struct iio_trigger_ops max1027_trigger_ops = {
 	.owner = THIS_MODULE,
-	.validate_device = &max1027_validate_device,
+	.validate_device = &iio_trigger_validate_own_device,
 	.set_trigger_state = &max1027_set_trigger_state,
 };
 
-- 
2.1.4

