Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f44.google.com ([209.85.215.44]:36814 "EHLO
        mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751063AbcIAI10 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 1 Sep 2016 04:27:26 -0400
Received: by mail-lf0-f44.google.com with SMTP id g62so54795892lfe.3
        for <linux-iio@vger.kernel.org>; Thu, 01 Sep 2016 01:27:26 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Giuseppe Barba <giuseppe.barba@st.com>,
        Denis Ciocca <denis.ciocca@st.com>,
        Crestez Dan Leonard <leonard.crestez@intel.com>,
        Gregor Boirie <gregor.boirie@parrot.com>
Subject: [PATCH 2/3] iio: st_sensors: use the helper function
Date: Thu,  1 Sep 2016 10:27:18 +0200
Message-Id: <1472718439-16734-2-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1472718439-16734-1-git-send-email-linus.walleij@linaro.org>
References: <1472718439-16734-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The ST sensors can be used as a trigger for its own triggered buffer
but it is also possible to use an external trigger: a HRTimer or
even a different sensor (!) as trigger. In that case we should not
pick the timestamp from our own interrupt top half even if it is
active.

This could practically happen if some other sensor is using the
ST sensor as trigger but the ST sensor itself is using e.g.
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
 drivers/iio/common/st_sensors/st_sensors_buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/common/st_sensors/st_sensors_buffer.c b/drivers/iio/common/st_sensors/st_sensors_buffer.c
index d06e728cea37..fe7775bb3740 100644
--- a/drivers/iio/common/st_sensors/st_sensors_buffer.c
+++ b/drivers/iio/common/st_sensors/st_sensors_buffer.c
@@ -63,7 +63,7 @@ irqreturn_t st_sensors_trigger_handler(int irq, void *p)
 	 * the hardware trigger) and the hw_timestamp may get updated.
 	 * By storing it in a local variable first, we are safe.
 	 */
-	if (sdata->hw_irq_trigger)
+	if (iio_trigger_using_own(indio_dev))
 		timestamp = sdata->hw_timestamp;
 	else
 		timestamp = iio_get_time_ns(indio_dev);
-- 
2.7.4

