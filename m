Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36442 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932659AbdAGKvr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 7 Jan 2017 05:51:47 -0500
Received: by mail-pf0-f195.google.com with SMTP id b22so4946710pfd.3
        for <linux-iio@vger.kernel.org>; Sat, 07 Jan 2017 02:51:47 -0800 (PST)
From: rishabh hardas <rishabheudyptula@gmail.com>
To: pmeerw@pmeerw.net
Cc: rishabh hardas <rishabheudyptula@gmail.com>,
        linux-iio@vger.kernel.org
Subject: [PATCH] iio:trigger: Fix coding style in iio-trig-bfin-timer.c by removing a waring flagged by checkpatch.pl
Date: Sat,  7 Jan 2017 16:21:36 +0530
Message-Id: <1483786296-7849-1-git-send-email-rishabheudyptula@gmail.com>
In-Reply-To: <CAEnQRZCgiUXEZX8iwJV3MU00KoywaPsNFy32QkuEGRui_itgJw>
References: <CAEnQRZCgiUXEZX8iwJV3MU00KoywaPsNFy32QkuEGRui_itgJw>
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

