Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-164.synserver.de ([212.40.185.164]:1057 "EHLO
	smtp-out-163.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753381Ab3I1Ja6 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 28 Sep 2013 05:30:58 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 25/25] iio: Update unit of the voltage scale in the documentation
Date: Sat, 28 Sep 2013 11:31:57 +0200
Message-Id: <1380360717-26103-25-git-send-email-lars@metafoo.de>
In-Reply-To: <1380360717-26103-1-git-send-email-lars@metafoo.de>
References: <1380360717-26103-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The documentation says that the result of raw * scale should be in microvolts,
but in reallity all drivers actually report the scale so that the result is in
millivolts. So update the documentation to match reallity.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 Documentation/ABI/testing/sysfs-bus-iio | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index ab1047c..2d736208 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -79,7 +79,7 @@ Description:
 		correspond to externally available input one of the named
 		versions may be used. The number must always be specified and
 		unique to allow association with event codes. Units after
-		application of scale and offset are microvolts.
+		application of scale and offset are millivolts.
 
 What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY-voltageZ_raw
 KernelVersion:	2.6.35
@@ -90,7 +90,7 @@ Description:
 		physically equivalent inputs when non differential readings are
 		separately available. In differential only parts, then all that
 		is required is a consistent labeling.  Units after application
-		of scale and offset are microvolts.
+		of scale and offset are millivolts.
 
 What:		/sys/bus/iio/devices/iio:deviceX/in_capacitanceY_raw
 KernelVersion:	3.2
-- 
1.8.0

