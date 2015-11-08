Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:35051 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752669AbbKHEVe (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 7 Nov 2015 23:21:34 -0500
Received: by pasz6 with SMTP id z6so167548350pas.2
        for <linux-iio@vger.kernel.org>; Sat, 07 Nov 2015 20:21:33 -0800 (PST)
From: Matt Ranostay <mranostay@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH] iio: light: apds9960: correct ->last_busy count
Date: Sat,  7 Nov 2015 20:21:28 -0800
Message-Id: <1446956488-8262-1-git-send-email-mranostay@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add missing pm_runtime_mark_last_busy to apds9960_set_power_state
function.

Signed-off-by: Matt Ranostay <mranostay@gmail.com>
---
 drivers/iio/light/apds9960.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/light/apds9960.c b/drivers/iio/light/apds9960.c
index 7d269ef..f6a07dc 100644
--- a/drivers/iio/light/apds9960.c
+++ b/drivers/iio/light/apds9960.c
@@ -453,6 +453,7 @@ static int apds9960_set_power_state(struct apds9960_data *data, bool on)
 			usleep_range(data->als_adc_int_us,
 				     APDS9960_MAX_INT_TIME_IN_US);
 	} else {
+		pm_runtime_mark_last_busy(dev);
 		ret = pm_runtime_put_autosuspend(dev);
 	}
 
-- 
1.9.1

