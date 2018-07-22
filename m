Return-Path: <SRS0=M7s+=KG=gmail.com=vilhelm.gray@kernel.org>
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: gregkh@linuxfoundation.org
Cc: jic23@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	fabrice.gasnier@st.com,
	benjamin.gaignard@st.com,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	akpm@linux-foundation.org,
	William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v9 02/11] counter: Documentation: Add Generic Counter sysfs documentation
Date: Sun, 22 Jul 2018 18:50:23 -0400
Message-Id: <3a52e525835db358620ad02dbb83c66a9d32006e.1532298882.git.vilhelm.gray@gmail.com>
In-Reply-To: <cover.1532298882.git.vilhelm.gray@gmail.com>
References: <cover.1532298882.git.vilhelm.gray@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

This patch adds standard documentation for the userspace sysfs
attributes of the Generic Counter interface.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-counter | 230 ++++++++++++++++++++
 MAINTAINERS                                 |   1 +
 2 files changed, 231 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-counter

diff --git a/Documentation/ABI/testing/sysfs-bus-counter b/Documentation/ABI/testing/sysfs-bus-counter
new file mode 100644
index 000000000000..62d4a931326a
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-counter
@@ -0,0 +1,230 @@
+What:		/sys/bus/counter/devices/counterX/countY/count
+KernelVersion:	4.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Count data of Count Y represented as a string.
+
+What:		/sys/bus/counter/devices/counterX/countY/ceiling
+KernelVersion:	4.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Count value ceiling for Count Y. This is the upper limit for the
+		respective counter.
+
+What:		/sys/bus/counter/devices/counterX/countY/floor
+KernelVersion:	4.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Count value floor for Count Y. This is the lower limit for the
+		respective counter.
+
+What:		/sys/bus/counter/devices/counterX/countY/count_mode
+KernelVersion:	4.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Count mode for channel Y. The ceiling and floor values for
+		Count Y are used by the count mode where required. The following
+		count modes are available:
+
+		normal:
+			Counting is continuous in either direction.
+
+		range limit:
+			An upper or lower limit is set, mimicking limit switches
+			in the mechanical counterpart. The upper limit is set to
+			the Count Y ceiling value, while the lower limit is set
+			to the Count Y floor value. The counter freezes at
+			count = ceiling when counting up, and at count = floor
+			when counting down. At either of these limits, the
+			counting is resumed only when the count direction is
+			reversed.
+
+		non-recycle:
+			The counter is disabled whenever a counter overflow or
+			underflow takes place. The counter is re-enabled when a
+			new count value is loaded to the counter via a preset
+			operation or direct write.
+
+		modulo-n:
+			A count value boundary is set between the Count Y floor
+			value and the Count Y ceiling value. The counter is
+			reset to the Cunt Y floor value at count = ceiling when
+			counting up, while the counter is set to the Count Y
+			ceiling value at count = floor when counting down; the
+			counter does not freeze at the boundary points, but
+			counts continuously throughout.
+
+What:		/sys/bus/counter/devices/counterX/countY/count_mode_available
+What:		/sys/bus/counter/devices/counterX/countY/error_noise_available
+What:		/sys/bus/counter/devices/counterX/countY/function_available
+What:		/sys/bus/counter/devices/counterX/countY/signalZ_action_available
+KernelVersion:	4.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Discrete set of available values for the respective Count Y
+		configuration are listed in this file. Values are delineated by
+		newline characters.
+
+What:		/sys/bus/counter/devices/counterX/countY/direction
+KernelVersion:	4.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read-only attribute that indicates the count direction of Count
+		Y. Two count directions are available: forward and backward.
+
+		Some counter devices are able to determine the direction of
+		their counting. For example, quadrature encoding counters can
+		determine the direction of movement by evaluating the leading
+		phase of the respective A and B quadrature encoding signals.
+		This attribute exposes such count directions.
+
+What:		/sys/bus/counter/devices/counterX/countY/enable
+KernelVersion:	4.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Whether channel Y counter is enabled. Valid attribute values are
+		boolean.
+
+		This attribute is intended to serve as a pause/unpause mechanism
+		for Count Y. Suppose a counter device is used to count the total
+		movement of a conveyor belt: this attribute allows an operator
+		to temporarily pause the counter, service the conveyor belt,
+		and then finally unpause the counter to continue where it had
+		left off.
+
+What:		/sys/bus/counter/devices/counterX/countY/error_noise
+KernelVersion:	4.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read-only attribute that indicates whether excessive noise is
+		present at the channel Y counter inputs.
+
+What:		/sys/bus/counter/devices/counterX/countY/function
+KernelVersion:	4.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Count function mode of Count Y; count function evaluation is
+		triggered by conditions specified by the Count Y signalZ_action
+		attributes. The following count functions are available:
+
+		increase:
+			Accumulated count is incremented.
+
+		decrease:
+			Accumulated count is decremented.
+
+		pulse-direction:
+			Rising edges on signal A updates the respective count.
+			The input level of signal B determines direction.
+
+		quadrature x1 a:
+			If direction is forward, rising edges on quadrature pair
+			signal A updates the respective count; if the direction
+			is backward, falling edges on quadrature pair signal A
+			updates the respective count. Quadrature encoding
+			determines the direction.
+
+		quadrature x1 b:
+			If direction is forward, rising edges on quadrature pair
+			signal B updates the respective count; if the direction
+			is backward, falling edges on quadrature pair signal B
+			updates the respective count. Quadrature encoding
+			determines the direction.
+
+		quadrature x2 a:
+			Any state transition on quadrature pair signal A updates
+			the respective count. Quadrature encoding determines the
+			direction.
+
+		quadrature x2 b:
+			Any state transition on quadrature pair signal B updates
+			the respective count. Quadrature encoding determines the
+			direction.
+
+		quadrature x4:
+			Any state transition on either quadrature pair signals
+			updates	the respective count. Quadrature encoding
+			determines the direction.
+
+What:		/sys/bus/counter/devices/counterX/countY/name
+KernelVersion:	4.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read-only attribute that indicates the device-specific name of
+		Count Y. If possible, this should match the name of the
+		respective channel as it appears in the device datasheet.
+
+What:		/sys/bus/counter/devices/counterX/countY/preset
+KernelVersion:	4.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+		If the counter device supports preset registers -- registers
+		used to load counter channels to a set count upon device-defined
+		preset operation trigger events -- the preset count for channel
+		Y is provided by this attribute.
+
+What:		/sys/bus/counter/devices/counterX/countY/preset_enable
+KernelVersion:	4.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Whether channel Y counter preset operation is enabled. Valid
+		attribute values are boolean.
+
+What:		/sys/bus/counter/devices/counterX/countY/signalZ_action
+KernelVersion:	4.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Action mode of Count Y for Signal Z. This attribute indicates
+		the condition of Signal Z that triggers the count function
+		evaluation for Count Y. The following action modes are
+		available:
+
+		none:
+			Signal does not trigger the count function. In
+			Pulse-Direction count function mode, this Signal is
+			evaluated as Direction.
+
+		rising edge:
+			Low state transitions to high state.
+
+		falling edge:
+			High state transitions to low state.
+
+		both edges:
+			Any state transition.
+
+What:		/sys/bus/counter/devices/counterX/name
+KernelVersion:	4.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read-only attribute that indicates the device-specific name of
+		the Counter. This should match the name of the device as it
+		appears in its respective datasheet.
+
+What:		/sys/bus/counter/devices/counterX/num_counts
+KernelVersion:	4.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read-only attribute that indicates the total number of Counts
+		belonging to the Counter.
+
+What:		/sys/bus/counter/devices/counterX/num_signals
+KernelVersion:	4.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read-only attribute that indicates the total number of Signals
+		belonging to the Counter.
+
+What:		/sys/bus/counter/devices/counterX/signalY/signal
+KernelVersion:	4.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Signal data of Signal Y represented as a string.
+
+What:		/sys/bus/counter/devices/counterX/signalY/name
+KernelVersion:	4.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read-only attribute that indicates the device-specific name of
+		Signal Y. If possible, this should match the name of the
+		respective signal as it appears in the device datasheet.
diff --git a/MAINTAINERS b/MAINTAINERS
index 7f0ab08184d8..46bff1b47d83 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3710,6 +3710,7 @@ COUNTER SUBSYSTEM
 M:	William Breathitt Gray <vilhelm.gray@gmail.com>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
+F:	Documentation/ABI/testing/sysfs-bus-counter*
 F:	drivers/counter/
 F:	include/linux/counter.h
 F:	include/linux/counter_enum.h
-- 
2.18.0
