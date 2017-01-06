Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34374 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754624AbdAFJjj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 6 Jan 2017 04:39:39 -0500
Received: by mail-pg0-f68.google.com with SMTP id b1so43528715pgc.1
        for <linux-iio@vger.kernel.org>; Fri, 06 Jan 2017 01:39:39 -0800 (PST)
From: rishabh hardas <rishabheudyptula@gmail.com>
To: pmeerw@pmeerw.net
Cc: rishabh hardas <rishabheudyptula@gmail.com>,
        linux-iio@vger.kernel.org
Subject: [PATCH] Fixed a coding style issue as a part of Eudyptula Challenge
Date: Fri,  6 Jan 2017 15:09:30 +0530
Message-Id: <1483695570-13082-1-git-send-email-rishabheudyptula@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: rishabh hardas <rishabheudyptula@gmail.com>
---
 drivers/staging/iio/trigger/iio-trig-bfin-timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/trigger/iio-trig-bfin-timer.c b/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
index 38dca69..9658f20 100644
--- a/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
+++ b/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
@@ -133,7 +133,7 @@ static ssize_t iio_bfin_tmr_frequency_show(struct device *dev,
 	return sprintf(buf, "%lu\n", val);
 }
 
-static DEVICE_ATTR(frequency, S_IRUGO | S_IWUSR, iio_bfin_tmr_frequency_show,
+static DEVICE_ATTR(frequency, 0644, iio_bfin_tmr_frequency_show,
 		   iio_bfin_tmr_frequency_store);
 
 static struct attribute *iio_bfin_tmr_trigger_attrs[] = {
-- 
2.7.4

