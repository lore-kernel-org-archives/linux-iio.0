Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:50148 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752239AbbBHSTa (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 8 Feb 2015 13:19:30 -0500
Received: by mail-wi0-f178.google.com with SMTP id hm9so1337173wib.5
        for <linux-iio@vger.kernel.org>; Sun, 08 Feb 2015 10:19:29 -0800 (PST)
From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>
Cc: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Joel Porquet <joel@porquet.org>,
	Darshana Padmadas <darshanapadmadas@gmail.com>,
	Catalina Mocanu <catalina.mocanu@gmail.com>,
	Wolfram Sang <wsa@the-dreams.de>, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: iio: trigger: iio-trig-periodic-rtc: Change frequency type to unsigned int
Date: Sun,  8 Feb 2015 19:22:54 +0100
Message-Id: <1423419774-16753-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Change struct iio_prtc_trigger_info frequency
type from int to unsigned int.
Since it is always treated as such in the driver
so they type should probably reflect this.

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 drivers/staging/iio/trigger/iio-trig-periodic-rtc.c |   12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c b/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
index a24caf7..89df1d3 100644
--- a/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
+++ b/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
@@ -24,7 +24,7 @@ static DEFINE_MUTEX(iio_prtc_trigger_list_lock);
 
 struct iio_prtc_trigger_info {
 	struct rtc_device *rtc;
-	int frequency;
+	unsigned int frequency;
 	struct rtc_task task;
 	bool state;
 };
@@ -36,7 +36,7 @@ static int iio_trig_periodic_rtc_set_state(struct iio_trigger *trig, bool state)
 
 	if (trig_info->frequency == 0 && state)
 		return -EINVAL;
-	dev_dbg(&trig_info->rtc->dev, "trigger frequency is %d\n",
+	dev_dbg(&trig_info->rtc->dev, "trigger frequency is %u\n",
 			trig_info->frequency);
 	ret = rtc_irq_set_state(trig_info->rtc, &trig_info->task, state);
 	if (ret == 0)
@@ -62,10 +62,10 @@ static ssize_t iio_trig_periodic_write_freq(struct device *dev,
 {
 	struct iio_trigger *trig = to_iio_trigger(dev);
 	struct iio_prtc_trigger_info *trig_info = iio_trigger_get_drvdata(trig);
-	int val;
+	unsigned int val;
 	int ret;
 
-	ret = kstrtoint(buf, 10, &val);
+	ret = kstrtouint(buf, 10, &val);
 	if (ret)
 		goto error_ret;
 
@@ -74,10 +74,8 @@ static ssize_t iio_trig_periodic_write_freq(struct device *dev,
 		if (ret == 0 && trig_info->state && trig_info->frequency == 0)
 			ret = rtc_irq_set_state(trig_info->rtc,
 						&trig_info->task, 1);
-	} else if (val == 0) {
-		ret = rtc_irq_set_state(trig_info->rtc, &trig_info->task, 0);
 	} else
-		ret = -EINVAL;
+		ret = rtc_irq_set_state(trig_info->rtc, &trig_info->task, 0);
 	if (ret)
 		goto error_ret;
 
-- 
1.7.10.4

