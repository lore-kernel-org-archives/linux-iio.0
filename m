Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:58064 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753793AbaJMNJF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 13 Oct 2014 09:09:05 -0400
From: Vlad Dogaru <vlad.dogaru@intel.com>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: Vlad Dogaru <vlad.dogaru@intel.com>
Subject: [PATCH] iio: add ABI documentation for scaled pressure
Date: Mon, 13 Oct 2014 16:09:11 +0300
Message-Id: <1413205751-11205-1-git-send-email-vlad.dogaru@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Vlad Dogaru <vlad.dogaru@intel.com>
---

There's at least one user of in_pressure_input, the bmg280 driver I submitted
earlier.

 Documentation/ABI/testing/sysfs-bus-iio | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index d760b02..0b771f8 100644
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
+		Scaled pressure measurement in kilopascal.
+
 What:		/sys/bus/iio/devices/iio:deviceX/in_humidityrelative_raw
 KernelVersion:	3.14
 Contact:	linux-iio@vger.kernel.org
-- 
1.9.1

