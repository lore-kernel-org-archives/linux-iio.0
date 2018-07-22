Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yb0-f195.google.com ([209.85.213.195]:43876 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730429AbeGVXua (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Jul 2018 19:50:30 -0400
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: gregkh@linuxfoundation.org
Cc: jic23@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, fabrice.gasnier@st.com,
        benjamin.gaignard@st.com, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, akpm@linux-foundation.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v9 11/11] iio: counter: Add deprecation markings for IIO Counter attributes
Date: Sun, 22 Jul 2018 18:52:05 -0400
Message-Id: <2450136fe1f5e7f582af69b61e6e1efe0d582c41.1532298882.git.vilhelm.gray@gmail.com>
In-Reply-To: <cover.1532298882.git.vilhelm.gray@gmail.com>
References: <cover.1532298882.git.vilhelm.gray@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The IIO counter subdirectory is now superceded by the Counter subsystem.
This patch adds deprecation warnings to the documentation of the
relevant IIO Counter sysfs attributes.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-iio          |  8 ++++++++
 .../ABI/testing/sysfs-bus-iio-counter-104-quad-8 | 16 ++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index a5b4f223641d..06218a5ae10c 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -1652,6 +1652,8 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_countY_raw
 KernelVersion:	4.10
 Contact:	linux-iio@vger.kernel.org
 Description:
+		This interface is deprecated; please use the Counter subsystem.
+
 		Raw counter device counts from channel Y. For quadrature
 		counters, multiplication by an available [Y]_scale results in
 		the counts of a single quadrature signal phase from channel Y.
@@ -1660,6 +1662,8 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_indexY_raw
 KernelVersion:	4.10
 Contact:	linux-iio@vger.kernel.org
 Description:
+		This interface is deprecated; please use the Counter subsystem.
+
 		Raw counter device index value from channel Y. This attribute
 		provides an absolute positional reference (e.g. a pulse once per
 		revolution) which may be used to home positional systems as
@@ -1669,6 +1673,8 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_count_count_direction_available
 KernelVersion:	4.12
 Contact:	linux-iio@vger.kernel.org
 Description:
+		This interface is deprecated; please use the Counter subsystem.
+
 		A list of possible counting directions which are:
 		- "up"	: counter device is increasing.
 		- "down": counter device is decreasing.
@@ -1677,6 +1683,8 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_countY_count_direction
 KernelVersion:	4.12
 Contact:	linux-iio@vger.kernel.org
 Description:
+		This interface is deprecated; please use the Counter subsystem.
+
 		Raw counter device counters direction for channel Y.
 
 What:		/sys/bus/iio/devices/iio:deviceX/in_phaseY_raw
diff --git a/Documentation/ABI/testing/sysfs-bus-iio-counter-104-quad-8 b/Documentation/ABI/testing/sysfs-bus-iio-counter-104-quad-8
index 7fac2c268d9a..bac3d0d48b7b 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio-counter-104-quad-8
+++ b/Documentation/ABI/testing/sysfs-bus-iio-counter-104-quad-8
@@ -6,6 +6,8 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_index_synchronous_mode_available
 KernelVersion:	4.10
 Contact:	linux-iio@vger.kernel.org
 Description:
+		This interface is deprecated; please use the Counter subsystem.
+
 		Discrete set of available values for the respective counter
 		configuration are listed in this file.
 
@@ -13,6 +15,8 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_countY_count_mode
 KernelVersion:	4.10
 Contact:	linux-iio@vger.kernel.org
 Description:
+		This interface is deprecated; please use the Counter subsystem.
+
 		Count mode for channel Y. Four count modes are available:
 		normal, range limit, non-recycle, and modulo-n. The preset value
 		for channel Y is used by the count mode where required.
@@ -47,6 +51,8 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_countY_noise_error
 KernelVersion:	4.10
 Contact:	linux-iio@vger.kernel.org
 Description:
+		This interface is deprecated; please use the Counter subsystem.
+
 		Read-only attribute that indicates whether excessive noise is
 		present at the channel Y count inputs in quadrature clock mode;
 		irrelevant in non-quadrature clock mode.
@@ -55,6 +61,8 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_countY_preset
 KernelVersion:	4.10
 Contact:	linux-iio@vger.kernel.org
 Description:
+		This interface is deprecated; please use the Counter subsystem.
+
 		If the counter device supports preset registers, the preset
 		count for channel Y is provided by this attribute.
 
@@ -62,6 +70,8 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_countY_quadrature_mode
 KernelVersion:	4.10
 Contact:	linux-iio@vger.kernel.org
 Description:
+		This interface is deprecated; please use the Counter subsystem.
+
 		Configure channel Y counter for non-quadrature or quadrature
 		clock mode. Selecting non-quadrature clock mode will disable
 		synchronous load mode. In quadrature clock mode, the channel Y
@@ -83,6 +93,8 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_countY_set_to_preset_on_index
 KernelVersion:	4.10
 Contact:	linux-iio@vger.kernel.org
 Description:
+		This interface is deprecated; please use the Counter subsystem.
+
 		Whether to set channel Y counter with channel Y preset value
 		when channel Y index input is active, or continuously count.
 		Valid attribute values are boolean.
@@ -91,6 +103,8 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_indexY_index_polarity
 KernelVersion:	4.10
 Contact:	linux-iio@vger.kernel.org
 Description:
+		This interface is deprecated; please use the Counter subsystem.
+
 		Active level of channel Y index input; irrelevant in
 		non-synchronous load mode.
 
@@ -98,6 +112,8 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_indexY_synchronous_mode
 KernelVersion:	4.10
 Contact:	linux-iio@vger.kernel.org
 Description:
+		This interface is deprecated; please use the Counter subsystem.
+
 		Configure channel Y counter for non-synchronous or synchronous
 		load mode. Synchronous load mode cannot be selected in
 		non-quadrature clock mode.
-- 
2.18.0

