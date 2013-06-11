Return-Path: <alexandre@relange.org>
From: Alexandre Relange <alexandre@relange.org>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org,
	Alexandre Relange <alexandre@relange.org>
Subject: [PATCH 2/5] iio: mechanical: new category of sensors
Date: Tue, 11 Jun 2013 16:52:13 +0200
Message-Id: <1370962336-20739-2-git-send-email-alexandre@relange.org>
In-Reply-To: <1370962336-20739-1-git-send-email-alexandre@relange.org>
References: <1370962336-20739-1-git-send-email-alexandre@relange.org>
List-ID: <linux-iio@vger.kernel.org>

adds the category of mechanical sensors (switches,...)

Signed-off-by: Alexandre Relange <alexandre@relange.org>
---
 drivers/iio/Kconfig             | 1 +
 drivers/iio/Makefile            | 1 +
 drivers/iio/mechanical/Kconfig  | 6 ++++++
 drivers/iio/mechanical/Makefile | 3 +++
 4 files changed, 11 insertions(+)
 create mode 100644 drivers/iio/mechanical/Kconfig
 create mode 100644 drivers/iio/mechanical/Makefile

diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
index b2f963b..dbed2f1 100644
--- a/drivers/iio/Kconfig
+++ b/drivers/iio/Kconfig
@@ -70,5 +70,6 @@ source "drivers/iio/gyro/Kconfig"
 source "drivers/iio/imu/Kconfig"
 source "drivers/iio/light/Kconfig"
 source "drivers/iio/magnetometer/Kconfig"
+source "drivers/iio/mechanical/Kconfig"
 
 endif # IIO
diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
index a0e8cdd..78ec75b 100644
--- a/drivers/iio/Makefile
+++ b/drivers/iio/Makefile
@@ -21,3 +21,4 @@ obj-y += frequency/
 obj-y += imu/
 obj-y += light/
 obj-y += magnetometer/
+obj-y += mechanical/
diff --git a/drivers/iio/mechanical/Kconfig b/drivers/iio/mechanical/Kconfig
new file mode 100644
index 0000000..b536fa2
--- /dev/null
+++ b/drivers/iio/mechanical/Kconfig
@@ -0,0 +1,6 @@
+#
+# Mechanical sensors
+#
+menu "Mechanical sensors"
+
+endmenu
diff --git a/drivers/iio/mechanical/Makefile b/drivers/iio/mechanical/Makefile
new file mode 100644
index 0000000..716098f
--- /dev/null
+++ b/drivers/iio/mechanical/Makefile
@@ -0,0 +1,3 @@
+#
+# Makefile for IIO Mechanical sensors
+#
-- 
1.8.3
