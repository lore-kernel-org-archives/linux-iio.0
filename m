Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yw0-f193.google.com ([209.85.161.193]:35338 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934898AbdIYSJI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 25 Sep 2017 14:09:08 -0400
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: benjamin.gaignard@linaro.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v2 3/5] iio: Documentation: Add IIO Generic Counter sysfs documentation
Date: Mon, 25 Sep 2017 14:09:01 -0400
Message-Id: <227cc8a42620b09445790b84c4d27588887d0dc8.1506353914.git.vilhelm.gray@gmail.com>
In-Reply-To: <cover.1506353914.git.vilhelm.gray@gmail.com>
References: <cover.1506353914.git.vilhelm.gray@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch adds standard documentation for the userspace sysfs
atrributes of the IIO Generic Counter Interface.

Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 .../testing/sysfs-bus-iio-generic-counter-sysfs    | 63 ++++++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-generic-counter-sysfs

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-generic-counter-sysfs b/Documentation/ABI/testing/sysfs-bus-iio-generic-counter-sysfs
new file mode 100644
index 000000000000..b2c09254ec5a
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-generic-counter-sysfs
@@ -0,0 +1,63 @@
+What:		/sys/bus/iio/devices/iio:deviceX/countX-Y_function
+KernelVersion:	4.14
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Counter function mode for Value Y of Counter X; counter function
+		evaluation triggered by conditions specified by the
+		countX-Y_trigger_signalX-Z attributes.
+
+What:		/sys/bus/iio/devices/iio:deviceX/countX-Y_function_available
+KernelVersion:	4.14
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Discrete set of available function modes for the configuration
+		of the respective Value Y of Counter X are listed in this file.
+
+What:		/sys/bus/iio/devices/iio:deviceX/countX-Y_name
+KernelVersion:	4.14
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read-only attribute that indicates the device-specific name of
+		Value Y of Counter X.
+
+What:		/sys/bus/iio/devices/iio:deviceX/countX-Y_raw
+KernelVersion:	4.14
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Raw count data of Value Y of Counter X.
+
+What:		/sys/bus/iio/devices/iio:deviceX/countX-Y_triggers
+KernelVersion:	4.14
+Contact:	linux-iio@vger.kernel.org
+Description:
+		List of Signals associated to Value Y of Counter X.
+
+What:		/sys/bus/iio/devices/iio:deviceX/countX-Y_trigger_signalX-Z
+KernelVersion:	4.14
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Trigger mode of Value Y for Signal Z. This attribute indicates
+		the condition of Signal Z that triggers the counter function
+		evaluation for Value Y. Both Value Y and Signal Z are part of
+		Counter X.
+
+What:		/sys/bus/iio/devices/iio:deviceX/countX-Y_trigger_signalX-Z_available
+KernelVersion:	4.14
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Discrete set of available trigger modes are listed in this file
+		for the configuration of the respective Trigger associating
+		Signal Z of Counter X with Value Y of Counter X.
+
+What:		/sys/bus/iio/devices/iio:deviceX/signalX-Y_name
+KernelVersion:	4.14
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read-only attribute that indicates the device-specific name of
+		Signal Y of Counter X.
+
+What:		/sys/bus/iio/devices/iio:deviceX/signalX-Y_raw
+KernelVersion:	4.14
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Raw signal data of Signal Y of Counter X.
-- 
2.14.1

