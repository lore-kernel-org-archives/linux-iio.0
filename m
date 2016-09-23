Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:44061 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1035359AbcIWPTv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 23 Sep 2016 11:19:51 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Philippe Reynes <tremyfr@yahoo.fr>,
        Martin Fuzzey <mfuzzey@parkeon.com>, linux-iio@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v3 2/4] iio:mma8452: Use new iio_trigger_validate_own_device() helper
Date: Fri, 23 Sep 2016 17:19:42 +0200
Message-Id: <1474643984-14262-2-git-send-email-lars@metafoo.de>
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
 drivers/iio/accel/mma8452.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index d41e1b5..1c70515 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -1347,20 +1347,9 @@ static int mma8452_data_rdy_trigger_set_state(struct iio_trigger *trig,
 	return mma8452_change_config(data, MMA8452_CTRL_REG4, reg);
 }
 
-static int mma8452_validate_device(struct iio_trigger *trig,
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
 static const struct iio_trigger_ops mma8452_trigger_ops = {
 	.set_trigger_state = mma8452_data_rdy_trigger_set_state,
-	.validate_device = mma8452_validate_device,
+	.validate_device = iio_trigger_validate_own_device,
 	.owner = THIS_MODULE,
 };
 
-- 
2.1.4

