Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35149 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965230AbdGTPY6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 20 Jul 2017 11:24:58 -0400
Received: by mail-pg0-f65.google.com with SMTP id d193so3034816pgc.2
        for <linux-iio@vger.kernel.org>; Thu, 20 Jul 2017 08:24:57 -0700 (PDT)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-iio@vger.kernel.org
Cc: Akinobu Mita <akinobu.mita@gmail.com>,
        Daniel Baluta <daniel.baluta@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v2 05/11] iio: adc: ti-ads1015: don't return invalid value from buffer setup callbacks
Date: Fri, 21 Jul 2017 00:24:21 +0900
Message-Id: <1500564267-8613-6-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <1500564267-8613-1-git-send-email-akinobu.mita@gmail.com>
References: <1500564267-8613-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

pm_runtime_get_sync() and pm_runtime_put_autosuspend() return 0 on
success, 1 if the device's runtime PM status was already requested status
or error code on failure.  So a positive return value doesn't indicate an
error condition.

However, any non-zero return values from buffer preenable and postdisable
callbacks are recognized as an error and this driver reuses the return
value from pm_runtime_get_sync() and pm_runtime_put_autosuspend() in
these callbacks.  This change fixes the false error detections.

Cc: Daniel Baluta <daniel.baluta@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
 drivers/iio/adc/ti-ads1015.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index 8905f0d..1c475e2 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -235,7 +235,7 @@ static int ads1015_set_power_state(struct ads1015_data *data, bool on)
 		ret = pm_runtime_put_autosuspend(dev);
 	}
 
-	return ret;
+	return ret < 0 ? ret : 0;
 }
 
 static
-- 
2.7.4

