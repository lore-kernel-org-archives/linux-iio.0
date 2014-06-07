Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:43404 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753025AbaFGPnF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 7 Jun 2014 11:43:05 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 12/12] staging:iio-trig-periodic-rtc: Allow to reset frequency to 0
Date: Sat,  7 Jun 2014 17:42:52 +0200
Message-Id: <1402155772-1373-13-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1402155772-1373-1-git-send-email-pmeerw@pmeerw.net>
References: <1402155772-1373-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

periodic rtc trigger initially has frequency 0

it is possible to change trigger frequency on-the-fly, but it is not
possible to set frequency back to 0

this patch allows to set trigger frequency to 0, thereby disabling
the rtc interrupt

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/staging/iio/trigger/iio-trig-periodic-rtc.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c b/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
index 7283e50..1abe18f 100644
--- a/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
+++ b/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
@@ -26,16 +26,22 @@ struct iio_prtc_trigger_info {
 	struct rtc_device *rtc;
 	int frequency;
 	struct rtc_task task;
+	bool state;
 };
 
 static int iio_trig_periodic_rtc_set_state(struct iio_trigger *trig, bool state)
 {
 	struct iio_prtc_trigger_info *trig_info = iio_trigger_get_drvdata(trig);
-	if (trig_info->frequency == 0)
+	int ret;
+	if (trig_info->frequency == 0 && state)
 		return -EINVAL;
 	dev_dbg(&trig_info->rtc->dev, "trigger frequency is %d\n",
 			trig_info->frequency);
-	return rtc_irq_set_state(trig_info->rtc, &trig_info->task, state);
+	ret = rtc_irq_set_state(trig_info->rtc, &trig_info->task, state);
+	if (ret == 0)
+		trig_info->state = state;
+
+	return ret;
 }
 
 static ssize_t iio_trig_periodic_read_freq(struct device *dev,
@@ -61,7 +67,14 @@ static ssize_t iio_trig_periodic_write_freq(struct device *dev,
 	if (ret)
 		goto error_ret;
 
-	ret = rtc_irq_set_freq(trig_info->rtc, &trig_info->task, val);
+	if (val > 0) {
+		ret = rtc_irq_set_freq(trig_info->rtc, &trig_info->task, val);
+		if (ret == 0 && trig_info->state && trig_info->frequency == 0)
+			ret = rtc_irq_set_state(trig_info->rtc, &trig_info->task, 1);
+	} else if (val == 0) {
+		ret = rtc_irq_set_state(trig_info->rtc, &trig_info->task, 0);
+	} else
+		ret = -EINVAL;
 	if (ret)
 		goto error_ret;
 
-- 
1.9.1

