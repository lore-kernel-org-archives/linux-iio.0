Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-029.synserver.de ([212.40.185.29]:1035 "EHLO
	smtp-out-029.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756156Ab2IQM0J (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 17 Sep 2012 08:26:09 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, drivers@analog.com,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/4] staging:iio:trigger:bfintmr: Avoid divide by zero
Date: Mon, 17 Sep 2012 14:26:45 +0200
Message-Id: <1347884808-26833-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

If the timer frequency has not been configured yet get_gptimer_period() will
return 0. Handle this case instead of blindly dividing by the returned value.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/trigger/iio-trig-bfin-timer.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/trigger/iio-trig-bfin-timer.c b/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
index ce6a7b1..2772ea2 100644
--- a/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
+++ b/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
@@ -99,9 +99,15 @@ static ssize_t iio_bfin_tmr_frequency_show(struct device *dev,
 {
 	struct iio_trigger *trig = to_iio_trigger(dev);
 	struct bfin_tmr_state *st = trig->private_data;
+	unsigned int period = get_gptimer_period(st->t->id);
+	unsigned long val;
 
-	return sprintf(buf, "%lu\n",
-			get_sclk() / get_gptimer_period(st->t->id));
+	if (period == 0)
+		val = 0;
+	else
+		val = get_sclk() / get_gptimer_period(st->t->id);
+
+	return sprintf(buf, "%lu\n", val);
 }
 
 static DEVICE_ATTR(frequency, S_IRUGO | S_IWUSR, iio_bfin_tmr_frequency_show,
-- 
1.7.10.4

