Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:49029 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753451AbaJMNxn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 13 Oct 2014 09:53:43 -0400
From: Vlad Dogaru <vlad.dogaru@intel.com>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: Vlad Dogaru <vlad.dogaru@intel.com>
Subject: [PATCH v2] iio: add ABI documentation for scaled pressure
Date: Mon, 13 Oct 2014 16:53:40 +0300
Message-Id: <1413208420-12226-1-git-send-email-vlad.dogaru@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Vlad Dogaru <vlad.dogaru@intel.com>
---
Since v1: also mention channel Y, for uniformity with the description of
the raw channel above.

 Documentation/ABI/testing/sysfs-bus-iio | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index d760b02..d3d67b6 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -200,6 +200,13 @@ Description:
 		Raw pressure measurement from channel Y. Units after
 		application of scale and offset are kilopascal.
 
+What:		/sys/bus/iio/devices/iio:deviceX/in_pressureY_input
+What:		/sys/bus/iio/devices/iio:deviceX/in_pressure_input
+KernelVersion:	3.8
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Scaled pressure measurement from channel Y, in kilopascal.
+
 What:		/sys/bus/iio/devices/iio:deviceX/in_humidityrelative_raw
 KernelVersion:	3.14
 Contact:	linux-iio@vger.kernel.org
-- 
1.9.1

