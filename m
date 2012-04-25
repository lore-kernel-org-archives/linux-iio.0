Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:43701 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751750Ab2DYOzH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 25 Apr 2012 10:55:07 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 1/5] staging:iio:documentation pull a few sysfs entries out of main docs.
Date: Wed, 25 Apr 2012 15:54:56 +0100
Message-Id: <1335365700-1138-2-git-send-email-jic23@kernel.org>
In-Reply-To: <1335365700-1138-1-git-send-email-jic23@kernel.org>
References: <1335365700-1138-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

These two attributes are only used in the one driver.  Whilst they
are fairly general I'm not entirely happy committing to them at
this stage.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/Documentation/sysfs-bus-iio    |   21 --------------------
 .../staging/iio/Documentation/sysfs-bus-iio-ad7192 |   20 +++++++++++++++++++
 2 files changed, 20 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/iio/Documentation/sysfs-bus-iio b/drivers/staging/iio/Documentation/sysfs-bus-iio
index eec9acb..f7de494 100644
--- a/drivers/staging/iio/Documentation/sysfs-bus-iio
+++ b/drivers/staging/iio/Documentation/sysfs-bus-iio
@@ -728,24 +728,3 @@ Contact:	linux-iio@vger.kernel.org
 Description:
 		This attribute is used to read the amount of quadrature error
 		present in the device at a given time.
-
-What:		/sys/.../iio:deviceX/ac_excitation_en
-KernelVersion:	3.1.0
-Contact:	linux-iio@vger.kernel.org
-Description:
-		This attribute, if available, is used to enable the AC
-		excitation mode found on some converters. In ac excitation mode,
-		the polarity of the excitation voltage is reversed on
-		alternate cycles, to eliminate DC errors.
-
-What:		/sys/.../iio:deviceX/bridge_switch_en
-KernelVersion:	3.1.0
-Contact:	linux-iio@vger.kernel.org
-Description:
-		This attribute, if available, is used to close or open the
-		bridge power down switch found on some converters.
-		In bridge applications, such as strain gauges and load cells,
-		the bridge itself consumes the majority of the current in the
-		system. To minimize the current consumption of the system,
-		the bridge can be disconnected (when it is not being used
-		using the bridge_switch_en attribute.
diff --git a/drivers/staging/iio/Documentation/sysfs-bus-iio-ad7192 b/drivers/staging/iio/Documentation/sysfs-bus-iio-ad7192
new file mode 100644
index 0000000..1c35c50
--- /dev/null
+++ b/drivers/staging/iio/Documentation/sysfs-bus-iio-ad7192
@@ -0,0 +1,20 @@
+What:		/sys/.../iio:deviceX/ac_excitation_en
+KernelVersion:	3.1.0
+Contact:	linux-iio@vger.kernel.org
+Description:
+		This attribute, if available, is used to enable the AC
+		excitation mode found on some converters. In ac excitation mode,
+		the polarity of the excitation voltage is reversed on
+		alternate cycles, to eliminate DC errors.
+
+What:		/sys/.../iio:deviceX/bridge_switch_en
+KernelVersion:	3.1.0
+Contact:	linux-iio@vger.kernel.org
+Description:
+		This attribute, if available, is used to close or open the
+		bridge power down switch found on some converters.
+		In bridge applications, such as strain gauges and load cells,
+		the bridge itself consumes the majority of the current in the
+		system. To minimize the current consumption of the system,
+		the bridge can be disconnected (when it is not being used
+		using the bridge_switch_en attribute.
-- 
1.7.0.4

