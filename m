Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yb0-f194.google.com ([209.85.213.194]:37243 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752433AbdLNUvI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 14 Dec 2017 15:51:08 -0500
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc: benjamin.gaignard@linaro.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v4 02/11] counter: Documentation: Add Generic Counter sysfs documentation
Date: Thu, 14 Dec 2017 15:50:58 -0500
Message-Id: <e1235f0c7151a69f838dfc8eb4f25bd4cb9fe415.1513266127.git.vilhelm.gray@gmail.com>
In-Reply-To: <cover.1513266127.git.vilhelm.gray@gmail.com>
References: <cover.1513266127.git.vilhelm.gray@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch adds standard documentation for the userspace sysfs
attributes of the Generic Counter interface.

Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 .../ABI/testing/sysfs-bus-counter-generic-sysfs    | 73 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 74 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-counter-generic-sysfs

diff --git a/Documentation/ABI/testing/sysfs-bus-counter-generic-sysfs b/Documentation/ABI/testing/sysfs-bus-counter-generic-sysfs
new file mode 100644
index 000000000000..3b1c3c4498d1
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-counter-generic-sysfs
@@ -0,0 +1,73 @@
+What:		/sys/bus/counter/devices/counterX/countY
+KernelVersion:	4.16
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Count data of Count Y. Typically, this is an accumulated count
+		value.
+
+What:		/sys/bus/counter/devices/counterX/countY_function
+KernelVersion:	4.16
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Count function mode of Count Y; count function evaluation is
+		triggered by conditions specified by the countY_signalZ_action
+		attributes.
+
+What:		/sys/bus/counter/devices/counterX/countY_function_available
+KernelVersion:	4.16
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Discrete set of available count function modes for the
+		configuration of the respective Count Y are listed in this file.
+
+What:		/sys/bus/counter/devices/counterX/countY_name
+KernelVersion:	4.16
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read-only attribute that indicates the device-specific name of
+		Count Y.
+
+What:		/sys/bus/counter/devices/counterX/countY_signalZ_action
+KernelVersion:	4.16
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Action mode of Count Y for Signal Z. This attribute indicates
+		the condition of Signal Z that triggers the count function
+		evaluation for Count Y.
+
+What:		/sys/bus/counter/devices/counterX/countY_signalZ_action_available
+KernelVersion:	4.16
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Discrete set of available action modes are listed in this file
+		for the configuration of the respective Synapse associating
+		Signal Z to Count Y.
+
+What:		/sys/bus/counter/devices/counterX/counter_name
+KernelVersion:	4.16
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read-only attribute that indicates the device-specific name of
+		the Counter.
+
+What:		/sys/bus/counter/devices/counterX/signalY
+KernelVersion:	4.16
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Signal data of Signal Y. Typically, this is an input line level
+		state.
+
+What:		/sys/bus/counter/devices/counterX/signalY_name
+KernelVersion:	4.16
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read-only attribute that indicates the device-specific name of
+		Signal Y.
+
+What:		/sys/bus/counter/devices/counterX/countY_synapses
+KernelVersion:	4.16
+Contact:	linux-iio@vger.kernel.org
+Description:
+		List of Synapses associating Signals to Count Y. The columns
+		represent the following in the respective order: Signal ID,
+		Signal name, and current action mode.
diff --git a/MAINTAINERS b/MAINTAINERS
index 07dd7b933bfa..38da1bc615b3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3665,6 +3665,7 @@ COUNTER INTERFACE
 M:	William Breathitt Gray <vilhelm.gray@gmail.com>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
+F:	Documentation/ABI/testing/sysfs-bus-counter-*
 F:	drivers/iio/counter/
 F:	include/linux/iio/counter.h
 
-- 
2.15.1

