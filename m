Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:61248 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751676AbaHSPVm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 19 Aug 2014 11:21:42 -0400
From: Daniel Baluta <daniel.baluta@intel.com>
To: jic23@kernel.org
Cc: srinivas.pandruvada@linux.intel.com,
	o.v.kravchenko@globallogic.com, swarren@nvidia.com,
	daniel.baluta@intel.com, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.o
Subject: [PATCH] iio: accel: kxcjk-1013: add support for kxcj9-1008
Date: Tue, 19 Aug 2014 18:25:59 +0300
Message-Id: <1408461959-29660-1-git-send-email-daniel.baluta@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch adds support for KXCJ9-1008 3-axis acceleromenter sensor.
KXCJ9-1008 uses the same register definitions as KXCJK-1013.

The specification for KXCJ9-1008 can be downloaded from:
http://www.kionix.com/sites/default/files/KXCJ9-1008%20Specifications%20Rev%205.pdf

Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
---
 drivers/iio/accel/Kconfig      | 2 +-
 drivers/iio/accel/kxcjk-1013.c | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index 5704d6b..01b857e 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -97,7 +97,7 @@ config KXCJK1013
 	select IIO_TRIGGERED_BUFFER
 	help
 	  Say Y here if you want to build a driver for the Kionix KXCJK-1013
-	  triaxial acceleration sensor.
+	  triaxial acceleration sensor. This driver also supports KXCJ9-1008.
 
 	  To compile this driver as a module, choose M here: the module will
 	  be called kxcjk-1013.
diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index 57c515b..70a5679 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -932,12 +932,14 @@ static const struct dev_pm_ops kxcjk1013_pm_ops = {
 
 static const struct acpi_device_id kx_acpi_match[] = {
 	{"KXCJ1013", 0},
+	{"KXCJ1008", 0},
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, kx_acpi_match);
 
 static const struct i2c_device_id kxcjk1013_id[] = {
 	{"kxcjk1013", 0},
+	{"kxcj91008", 0},
 	{}
 };
 
-- 
1.9.1

