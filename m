Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:47893 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751226AbaFLFAm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 12 Jun 2014 01:00:42 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH v2 11/12] staging:iio-trig-periodic-rtc: Cleanup
Date: Thu, 12 Jun 2014 07:00:28 +0200
Message-Id: <1402549229-4449-12-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1402549229-4449-1-git-send-email-pmeerw@pmeerw.net>
References: <1402549229-4449-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Fix extra space in module description
Silence output about trigger frequency when trigger gets enabled/disabled
Add dash to make trigger name look nicer (periodicrtc0 -> periodic-rtc0)

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/staging/iio/trigger/iio-trig-periodic-rtc.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c b/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
index 38ecb4b..362a54a 100644
--- a/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
+++ b/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
@@ -33,7 +33,7 @@ static int iio_trig_periodic_rtc_set_state(struct iio_trigger *trig, bool state)
 	struct iio_prtc_trigger_info *trig_info = iio_trigger_get_drvdata(trig);
 	if (trig_info->frequency == 0)
 		return -EINVAL;
-	dev_info(&trig_info->rtc->dev, "trigger frequency is %d\n",
+	dev_dbg(&trig_info->rtc->dev, "trigger frequency is %d\n",
 			trig_info->frequency);
 	return rtc_irq_set_state(trig_info->rtc, &trig_info->task, state);
 }
@@ -128,8 +128,7 @@ static int iio_trig_periodic_rtc_probe(struct platform_device *dev)
 		iio_trigger_set_drvdata(trig, trig_info);
 		trig->ops = &iio_prtc_trigger_ops;
 		/* RTC access */
-		trig_info->rtc
-			= rtc_class_open(pdata[i]);
+		trig_info->rtc = rtc_class_open(pdata[i]);
 		if (trig_info->rtc == NULL) {
 			ret = -EINVAL;
 			goto error_free_trig_info;
@@ -199,5 +198,5 @@ static struct platform_driver iio_trig_periodic_rtc_driver = {
 module_platform_driver(iio_trig_periodic_rtc_driver);
 
 MODULE_AUTHOR("Jonathan Cameron <jic23@kernel.org>");
-MODULE_DESCRIPTION("Periodic realtime clock  trigger for the iio subsystem");
+MODULE_DESCRIPTION("Periodic realtime clock trigger for the iio subsystem");
 MODULE_LICENSE("GPL v2");
-- 
1.9.1

