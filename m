Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:50358 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752824Ab2FNWvF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 14 Jun 2012 18:51:05 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 1/6] iio: sysfs-bus-iio typo
Date: Fri, 15 Jun 2012 00:50:55 +0200
Message-Id: <1339714260-8361-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>

---
 Documentation/ABI/testing/sysfs-bus-iio |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 05449c6..a3774a7 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -122,7 +122,7 @@ Description:
 		If an axis is specified it generally means that the temperature
 		sensor is associated with one part of a compound device (e.g.
 		a gyroscope axis). Units after application of scale and offset
-		are milli degrees Celsuis.
+		are milli degrees Celsius.
 
 What:		/sys/bus/iio/devices/iio:deviceX/in_tempX_input
 KernelVersion:	2.6.38
-- 
1.7.9.5

