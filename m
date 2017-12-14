Return-Path: <SRS0=Dxs2=DK=gmail.com=vilhelm.gray@kernel.org>
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net
Cc: benjamin.gaignard@linaro.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v4 09/11] counter: Documentation: Add Quadrature Counter sysfs documentation
Date: Thu, 14 Dec 2017 15:52:41 -0500
Message-Id: <875b929895c1f38972c921c7591bb8370e8e9163.1513266127.git.vilhelm.gray@gmail.com>
In-Reply-To: <cover.1513266127.git.vilhelm.gray@gmail.com>
References: <cover.1513266127.git.vilhelm.gray@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

This patch adds standard documentation for the userspace sysfs
attributes of the Quadrature Counter interface.

Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 .../ABI/testing/sysfs-bus-counter-quadrature-sysfs | 76 ++++++++++++++++++++++
 1 file changed, 76 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-counter-quadrature-sysfs

diff --git a/Documentation/ABI/testing/sysfs-bus-counter-quadrature-sysfs b/Documentation/ABI/testing/sysfs-bus-counter-quadrature-sysfs
new file mode 100644
index 000000000000..69d1a3e4a1a5
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-counter-quadrature-sysfs
@@ -0,0 +1,76 @@
+What:		/sys/bus/counter/devices/counterX/countY
+KernelVersion:	4.16
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Count data of Count Y. This is a signed integer value that
+		represents the position. Typically, this is determined by
+		hardware evaluation of the quadrature encoding input signals.
+
+What:		/sys/bus/counter/devices/counterX/countY_direction
+KernelVersion:	4.16
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Count direction of Count Y. Typically, this is determined by
+		hardware evaluation of the quadrature encoding input signals.
+		Two count directions are available: forward and backward.
+
+What:		/sys/bus/counter/devices/counterX/countY_function
+KernelVersion:	4.16
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Count function mode of Count Y. Count function evaluation is
+		triggered by conditions specified by the countY_signalZ_action
+		attributes. Four count function modes are available:
+		pulse-direction, quadrature x1, quadrature x2, quadrature x4.
+
+		Pulse-Direction:
+			Rising edges on quadrature pair signal A updates the
+			respective count. The input level of quadrature pair
+			signal B determines direction.
+
+		Quadrature x1:
+			If direction is forward, rising edges on quadrature pair
+			signal A updates the respective count; if the direction
+			is backward, falling edges on quadrature pair signal A
+			updates the respective count. Quadrature encoding
+			determines the direction.
+
+		Quadrature x2:
+			Any state transition on quadrature pair signal A updates
+			the respective count. Quadrature encoding determines the
+			direction.
+
+		Quadrature x4:
+			Any state transition on either quadrature pair signals
+			updates	the respective count. Quadrature encoding
+			determines the direction.
+
+What:		/sys/bus/counter/devices/counterX/countY_signalZ_action
+KernelVersion:	4.16
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Action mode of Count Y for Signal Z. This attribute indicates
+		the condition of Signal Z that triggers the count function
+		evaluation for Count Y. Four action modes are available: none,
+		rising edge, falling edge, and both edges.
+
+		None:
+			Signal does not trigger the count function. In
+			Pulse-Direction count function mode, this Signal is
+			evaluated as Direction.
+
+		Rising Edge:
+			Low state transitions to High state.
+
+		Falling Edge:
+			High state transitions to Low state.
+
+		Both Edges:
+			Any state transition.
+
+What:		/sys/bus/counter/devices/counterX/signalY
+KernelVersion:	4.16
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Signal data of Signal Y. This is the respective input level
+		represented by two available states: low and high.
-- 
2.15.1
