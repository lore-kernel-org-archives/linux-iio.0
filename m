Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:33387 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759216Ab3ICBFd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 2 Sep 2013 21:05:33 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 12/18] staging:iio:hmc5843: Fix format of MODULE_AUTHOR's email
Date: Tue,  3 Sep 2013 03:05:14 +0200
Message-Id: <1378170320-27538-13-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1378170320-27538-1-git-send-email-pmeerw@pmeerw.net>
References: <1378170320-27538-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/staging/iio/magnetometer/hmc5843.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
index 131ab8d..efd7d171 100644
--- a/drivers/staging/iio/magnetometer/hmc5843.c
+++ b/drivers/staging/iio/magnetometer/hmc5843.c
@@ -736,6 +736,6 @@ static struct i2c_driver hmc5843_driver = {
 };
 module_i2c_driver(hmc5843_driver);
 
-MODULE_AUTHOR("Shubhrajyoti Datta <shubhrajyoti@ti.com");
+MODULE_AUTHOR("Shubhrajyoti Datta <shubhrajyoti@ti.com>");
 MODULE_DESCRIPTION("HMC5843/5883/5883L driver");
 MODULE_LICENSE("GPL");
-- 
1.7.9.5

