Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:41662 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757948Ab3HHQkX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 8 Aug 2013 12:40:23 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH] iio: Restore alphabetic order in Makefile
Date: Thu,  8 Aug 2013 18:39:48 +0200
Message-Id: <1375979988-16697-2-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1375979988-16697-1-git-send-email-pmeerw@pmeerw.net>
References: <1375979988-16697-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/iio/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
index 161f769..7c85a4b 100644
--- a/drivers/iio/Makefile
+++ b/drivers/iio/Makefile
@@ -23,6 +23,6 @@ obj-y += frequency/
 obj-y += imu/
 obj-y += light/
 obj-y += magnetometer/
+obj-y += pressure/
 obj-y += temperature/
 obj-y += trigger/
-obj-y += pressure/
-- 
1.8.3.4

