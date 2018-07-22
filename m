Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yb0-f195.google.com ([209.85.213.195]:42141 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387732AbeGVXti (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Jul 2018 19:49:38 -0400
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: gregkh@linuxfoundation.org
Cc: jic23@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, fabrice.gasnier@st.com,
        benjamin.gaignard@st.com, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, akpm@linux-foundation.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v9 06/11] counter: 104-quad-8: Documentation: Add Generic Counter sysfs documentation
Date: Sun, 22 Jul 2018 18:51:13 -0400
Message-Id: <3f51391e2bb036b332a518503d60f15fe1dfddd9.1532298882.git.vilhelm.gray@gmail.com>
In-Reply-To: <cover.1532298882.git.vilhelm.gray@gmail.com>
References: <cover.1532298882.git.vilhelm.gray@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch adds standard documentation for the Generic Counter interface
userspace sysfs attributes of the 104-QUAD-8 driver.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 .../ABI/testing/sysfs-bus-counter-104-quad-8  | 36 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 37 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-counter-104-quad-8

diff --git a/Documentation/ABI/testing/sysfs-bus-counter-104-quad-8 b/Documentation/ABI/testing/sysfs-bus-counter-104-quad-8
new file mode 100644
index 000000000000..2d9fa57af101
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-counter-104-quad-8
@@ -0,0 +1,36 @@
+What:		/sys/bus/counter/devices/counterX/signalY/index_polarity
+KernelVersion:	4.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Active level of index input Signal Y; irrelevant in
+		non-synchronous load mode.
+
+What:		/sys/bus/counter/devices/counterX/signalY/index_polarity_available
+What:		/sys/bus/counter/devices/counterX/signalY/synchronous_mode_available
+KernelVersion:	4.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Discrete set of available values for the respective Signal Y
+		configuration are listed in this file.
+
+What:		/sys/bus/counter/devices/counterX/signalY/synchronous_mode
+KernelVersion:	4.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Configure the counter associated with Signal Y for
+		non-synchronous or synchronous load mode. Synchronous load mode
+		cannot be selected in non-quadrature (Pulse-Direction) clock
+		mode.
+
+		non-synchronous:
+			A logic low level is the active level at this index
+			input. The index function (as enabled via preset_enable)
+			is performed directly on the active level of the index
+			input.
+
+		synchronous:
+			Intended for interfacing with encoder Index output in
+			quadrature clock mode. The active level is configured
+			via index_polarity. The index function (as enabled via
+			preset_enable) is performed synchronously with the
+			quadrature clock on the active level of the index input.
diff --git a/MAINTAINERS b/MAINTAINERS
index f41c45246e2b..865c47a3feae 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -270,6 +270,7 @@ ACCES 104-QUAD-8 DRIVER
 M:	William Breathitt Gray <vilhelm.gray@gmail.com>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
+F:	Documentation/ABI/testing/sysfs-bus-counter-104-quad-8
 F:	Documentation/ABI/testing/sysfs-bus-iio-counter-104-quad-8
 F:	drivers/counter/104-quad-8.c
 
-- 
2.18.0

