Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from va3ehsobe005.messaging.microsoft.com ([216.32.180.31]:38536
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759829Ab2D0I6r (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 27 Apr 2012 04:58:47 -0400
From: <michael.hennerich@analog.com>
To: <gregkh@linuxfoundation.org>
CC: <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
	<device-drivers-devel@blackfin.uclinux.org>,
	Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 1/4] iio: Rename iio/dds to iio/frequency
Date: Fri, 27 Apr 2012 10:58:33 +0200
Message-ID: <1335517116-32307-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Michael Hennerich <michael.hennerich@analog.com>

Generalize naming to allow other frequency synthesis techniques as well.
No functional changes.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/Kconfig                     |    2 +-
 drivers/staging/iio/Makefile                    |    2 +-
 drivers/staging/iio/{dds => frequency}/Kconfig  |    0
 drivers/staging/iio/{dds => frequency}/Makefile |    0
 drivers/staging/iio/{dds => frequency}/ad5930.c |    0
 drivers/staging/iio/{dds => frequency}/ad9832.c |    0
 drivers/staging/iio/{dds => frequency}/ad9832.h |    0
 drivers/staging/iio/{dds => frequency}/ad9834.c |    0
 drivers/staging/iio/{dds => frequency}/ad9834.h |    0
 drivers/staging/iio/{dds => frequency}/ad9850.c |    0
 drivers/staging/iio/{dds => frequency}/ad9852.c |    0
 drivers/staging/iio/{dds => frequency}/ad9910.c |    0
 drivers/staging/iio/{dds => frequency}/ad9951.c |    0
 drivers/staging/iio/{dds => frequency}/dds.h    |    0
 14 files changed, 2 insertions(+), 2 deletions(-)
 rename drivers/staging/iio/{dds => frequency}/Kconfig (100%)
 rename drivers/staging/iio/{dds => frequency}/Makefile (100%)
 rename drivers/staging/iio/{dds => frequency}/ad5930.c (100%)
 rename drivers/staging/iio/{dds => frequency}/ad9832.c (100%)
 rename drivers/staging/iio/{dds => frequency}/ad9832.h (100%)
 rename drivers/staging/iio/{dds => frequency}/ad9834.c (100%)
 rename drivers/staging/iio/{dds => frequency}/ad9834.h (100%)
 rename drivers/staging/iio/{dds => frequency}/ad9850.c (100%)
 rename drivers/staging/iio/{dds => frequency}/ad9852.c (100%)
 rename drivers/staging/iio/{dds => frequency}/ad9910.c (100%)
 rename drivers/staging/iio/{dds => frequency}/ad9951.c (100%)
 rename drivers/staging/iio/{dds => frequency}/dds.h (100%)

diff --git a/drivers/staging/iio/Kconfig b/drivers/staging/iio/Kconfig
index c1054a1..3c8e5ec 100644
--- a/drivers/staging/iio/Kconfig
+++ b/drivers/staging/iio/Kconfig
@@ -30,7 +30,7 @@ source "drivers/staging/iio/adc/Kconfig"
 source "drivers/staging/iio/addac/Kconfig"
 source "drivers/staging/iio/cdc/Kconfig"
 source "drivers/staging/iio/dac/Kconfig"
-source "drivers/staging/iio/dds/Kconfig"
+source "drivers/staging/iio/frequency/Kconfig"
 source "drivers/staging/iio/gyro/Kconfig"
 source "drivers/staging/iio/impedance-analyzer/Kconfig"
 source "drivers/staging/iio/imu/Kconfig"
diff --git a/drivers/staging/iio/Makefile b/drivers/staging/iio/Makefile
index 2acd42f..6a46d5a 100644
--- a/drivers/staging/iio/Makefile
+++ b/drivers/staging/iio/Makefile
@@ -18,7 +18,7 @@ obj-y += adc/
 obj-y += addac/
 obj-y += cdc/
 obj-y += dac/
-obj-y += dds/
+obj-y += frequency/
 obj-y += gyro/
 obj-y += impedance-analyzer/
 obj-y += imu/
diff --git a/drivers/staging/iio/dds/Kconfig b/drivers/staging/iio/frequency/Kconfig
similarity index 100%
rename from drivers/staging/iio/dds/Kconfig
rename to drivers/staging/iio/frequency/Kconfig
diff --git a/drivers/staging/iio/dds/Makefile b/drivers/staging/iio/frequency/Makefile
similarity index 100%
rename from drivers/staging/iio/dds/Makefile
rename to drivers/staging/iio/frequency/Makefile
diff --git a/drivers/staging/iio/dds/ad5930.c b/drivers/staging/iio/frequency/ad5930.c
similarity index 100%
rename from drivers/staging/iio/dds/ad5930.c
rename to drivers/staging/iio/frequency/ad5930.c
diff --git a/drivers/staging/iio/dds/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
similarity index 100%
rename from drivers/staging/iio/dds/ad9832.c
rename to drivers/staging/iio/frequency/ad9832.c
diff --git a/drivers/staging/iio/dds/ad9832.h b/drivers/staging/iio/frequency/ad9832.h
similarity index 100%
rename from drivers/staging/iio/dds/ad9832.h
rename to drivers/staging/iio/frequency/ad9832.h
diff --git a/drivers/staging/iio/dds/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
similarity index 100%
rename from drivers/staging/iio/dds/ad9834.c
rename to drivers/staging/iio/frequency/ad9834.c
diff --git a/drivers/staging/iio/dds/ad9834.h b/drivers/staging/iio/frequency/ad9834.h
similarity index 100%
rename from drivers/staging/iio/dds/ad9834.h
rename to drivers/staging/iio/frequency/ad9834.h
diff --git a/drivers/staging/iio/dds/ad9850.c b/drivers/staging/iio/frequency/ad9850.c
similarity index 100%
rename from drivers/staging/iio/dds/ad9850.c
rename to drivers/staging/iio/frequency/ad9850.c
diff --git a/drivers/staging/iio/dds/ad9852.c b/drivers/staging/iio/frequency/ad9852.c
similarity index 100%
rename from drivers/staging/iio/dds/ad9852.c
rename to drivers/staging/iio/frequency/ad9852.c
diff --git a/drivers/staging/iio/dds/ad9910.c b/drivers/staging/iio/frequency/ad9910.c
similarity index 100%
rename from drivers/staging/iio/dds/ad9910.c
rename to drivers/staging/iio/frequency/ad9910.c
diff --git a/drivers/staging/iio/dds/ad9951.c b/drivers/staging/iio/frequency/ad9951.c
similarity index 100%
rename from drivers/staging/iio/dds/ad9951.c
rename to drivers/staging/iio/frequency/ad9951.c
diff --git a/drivers/staging/iio/dds/dds.h b/drivers/staging/iio/frequency/dds.h
similarity index 100%
rename from drivers/staging/iio/dds/dds.h
rename to drivers/staging/iio/frequency/dds.h
--
1.7.0.4


