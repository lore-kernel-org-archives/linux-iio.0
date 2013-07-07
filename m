Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:48263 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753136Ab3GGUYV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 7 Jul 2013 16:24:21 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 2/5] iio: fix typo, Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4350
Date: Sun,  7 Jul 2013 22:24:03 +0200
Message-Id: <1373228646-5356-2-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1373228646-5356-1-git-send-email-pmeerw@pmeerw.net>
References: <1373228646-5356-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4350 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4350 b/Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4350
index d89aded..1254457 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4350
+++ b/Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4350
@@ -18,4 +18,4 @@ Description:
 		adjust the reference frequency accordingly.
 		The value written has no effect until out_altvoltageY_frequency
 		is updated. Consider to use out_altvoltageY_powerdown to power
-		down the PLL and it's RFOut buffers during REFin changes.
+		down the PLL and its RFOut buffers during REFin changes.
-- 
1.8.3.2

