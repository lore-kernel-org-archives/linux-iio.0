Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f45.google.com ([209.85.215.45]:36822 "EHLO
        mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750841AbcIAI11 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 1 Sep 2016 04:27:27 -0400
Received: by mail-lf0-f45.google.com with SMTP id g62so54796192lfe.3
        for <linux-iio@vger.kernel.org>; Thu, 01 Sep 2016 01:27:27 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Giuseppe Barba <giuseppe.barba@st.com>,
        Denis Ciocca <denis.ciocca@st.com>,
        Crestez Dan Leonard <leonard.crestez@intel.com>,
        Gregor Boirie <gregor.boirie@parrot.com>
Subject: [PATCH 3/3] iio: gyro: mpu3050: use the helper function
Date: Thu,  1 Sep 2016 10:27:19 +0200
Message-Id: <1472718439-16734-3-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1472718439-16734-1-git-send-email-linus.walleij@linaro.org>
References: <1472718439-16734-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The MPU-3050 can be used as a trigger for its own triggered buffer
but it is also possible to use an external trigger: a HRTimer or
even a different sensor (!) as trigger. In that case we should not
pick the timestamp from our own interrupt top half even if it is
active.

This could practically happen if some other sensor is using the
MPU-3050 as trigger but the MPU-3050 sensor itself is using e.g.
an HRTimer as trigger. So the trigger is on, but not used by us.

We used to assume that whenever the hardware interrupt is turned
on, we are using it for our own trigger, but this is an
oversimplification.

Handle this logically by using the iio_trigger_using_own() helper.

Cc: Giuseppe Barba <giuseppe.barba@st.com>
Cc: Denis Ciocca <denis.ciocca@st.com>
Cc: Crestez Dan Leonard <leonard.crestez@intel.com>
Cc: Gregor Boirie <gregor.boirie@parrot.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
This applies on top of the new MPU-3050 driver which is not yet
upstream.
---
 drivers/iio/gyro/mpu3050-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
index e0fefcccaae1..0a5179c8d37f 100644
--- a/drivers/iio/gyro/mpu3050-core.c
+++ b/drivers/iio/gyro/mpu3050-core.c
@@ -483,7 +483,7 @@ static irqreturn_t mpu3050_trigger_handler(int irq, void *p)
 	 * timestamp here so it will be close in time to the actual values
 	 * read from the registers.
 	 */
-	if (mpu3050->hw_irq_trigger)
+	if (iio_trigger_using_own(indio_dev))
 		timestamp = mpu3050->hw_timestamp;
 	else
 		timestamp = iio_get_time_ns(indio_dev);
-- 
2.7.4

