Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yb0-f194.google.com ([209.85.213.194]:35079 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759857AbcINTYh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 14 Sep 2016 15:24:37 -0400
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v2 1/2] iio: Implement counter channel type and info constants
Date: Wed, 14 Sep 2016 15:24:30 -0400
Message-Id: <bd7044c5088c8f0d445d236581de9b19c806bbfc.1473877757.git.vilhelm.gray@gmail.com>
In-Reply-To: <cover.1473877757.git.vilhelm.gray@gmail.com>
References: <cover.1473877757.git.vilhelm.gray@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Quadrature encoders, such as rotary encoders and linear encoders, are
devices which are capable of encoding the relative position and
direction of motion of a shaft. This patch introduces the counter
subdirectory and several IIO constants for supporting quadrature encoder
counter devices.

  IIO_COUNT: Current count (main data provided by the counter device)
  IIO_INDEX: Set high when index input is at active level
  IIO_CHAN_INFO_PRESET: Counter preset value

Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/iio/Kconfig             | 1 +
 drivers/iio/Makefile            | 1 +
 drivers/iio/counter/Kconfig     | 8 ++++++++
 drivers/iio/counter/Makefile    | 6 ++++++
 drivers/iio/industrialio-core.c | 3 +++
 include/linux/iio/iio.h         | 1 +
 include/uapi/linux/iio/types.h  | 2 ++
 7 files changed, 22 insertions(+)
 create mode 100644 drivers/iio/counter/Kconfig
 create mode 100644 drivers/iio/counter/Makefile

diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
index 6743b18..574d1fb 100644
--- a/drivers/iio/Kconfig
+++ b/drivers/iio/Kconfig
@@ -73,6 +73,7 @@ source "drivers/iio/adc/Kconfig"
 source "drivers/iio/amplifiers/Kconfig"
 source "drivers/iio/chemical/Kconfig"
 source "drivers/iio/common/Kconfig"
+source "drivers/iio/counter/Kconfig"
 source "drivers/iio/dac/Kconfig"
 source "drivers/iio/dummy/Kconfig"
 source "drivers/iio/frequency/Kconfig"
diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
index 87e4c43..77b2000 100644
--- a/drivers/iio/Makefile
+++ b/drivers/iio/Makefile
@@ -18,6 +18,7 @@ obj-y += amplifiers/
 obj-y += buffer/
 obj-y += chemical/
 obj-y += common/
+obj-y += counter/
 obj-y += dac/
 obj-y += dummy/
 obj-y += gyro/
diff --git a/drivers/iio/counter/Kconfig b/drivers/iio/counter/Kconfig
new file mode 100644
index 0000000..95a7a0df
--- /dev/null
+++ b/drivers/iio/counter/Kconfig
@@ -0,0 +1,8 @@
+#
+# Counter devices
+#
+# When adding new entries keep the list in alphabetical order
+
+menu "Counters"
+
+endmenu
diff --git a/drivers/iio/counter/Makefile b/drivers/iio/counter/Makefile
new file mode 100644
index 0000000..c4dfa50
--- /dev/null
+++ b/drivers/iio/counter/Makefile
@@ -0,0 +1,6 @@
+#
+# Makefile for IIO counter devices
+#
+
+# When adding new entries keep the list in alphabetical order
+
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 0528a0c..42d8c8b 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -81,6 +81,8 @@ static const char * const iio_chan_type_name_spec[] = {
 	[IIO_PH] = "ph",
 	[IIO_UVINDEX] = "uvindex",
 	[IIO_ELECTRICALCONDUCTIVITY] = "electricalconductivity",
+	[IIO_COUNT] = "count",
+	[IIO_INDEX] = "index",
 };
 
 static const char * const iio_modifier_names[] = {
@@ -151,6 +153,7 @@ static const char * const iio_chan_info_postfix[] = {
 	[IIO_CHAN_INFO_DEBOUNCE_TIME] = "debounce_time",
 	[IIO_CHAN_INFO_CALIBEMISSIVITY] = "calibemissivity",
 	[IIO_CHAN_INFO_OVERSAMPLING_RATIO] = "oversampling_ratio",
+	[IIO_CHAN_INFO_PRESET] = "preset",
 };
 
 /**
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index b4a0679..7dc86d1 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -46,6 +46,7 @@ enum iio_chan_info_enum {
 	IIO_CHAN_INFO_DEBOUNCE_TIME,
 	IIO_CHAN_INFO_CALIBEMISSIVITY,
 	IIO_CHAN_INFO_OVERSAMPLING_RATIO,
+	IIO_CHAN_INFO_PRESET,
 };
 
 enum iio_shared_by {
diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
index 22e5e58..e54d14a 100644
--- a/include/uapi/linux/iio/types.h
+++ b/include/uapi/linux/iio/types.h
@@ -40,6 +40,8 @@ enum iio_chan_type {
 	IIO_PH,
 	IIO_UVINDEX,
 	IIO_ELECTRICALCONDUCTIVITY,
+	IIO_COUNT,
+	IIO_INDEX,
 };
 
 enum iio_modifier {
-- 
2.7.3

