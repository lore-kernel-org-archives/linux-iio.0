Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:14162 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757226AbaH1IfO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 28 Aug 2014 04:35:14 -0400
From: Laurentiu Palcu <laurentiu.palcu@intel.com>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: srinivas.pandruvada@linux.intel.com, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net, laurentiu.palcu@intel.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] iio: accel: BMC150: fix issues when CONFIG_PM_RUNTIME is not set
Date: Thu, 28 Aug 2014 11:35:05 +0300
Message-Id: <1409214906-27038-3-git-send-email-laurentiu.palcu@intel.com>
In-Reply-To: <1409214906-27038-1-git-send-email-laurentiu.palcu@intel.com>
References: <1409214906-27038-1-git-send-email-laurentiu.palcu@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

When CONFIG_PM_RUNTIME is not set, the following issues are seen:
 * warning message at compilation time:
    warning: 'bmc150_accel_get_startup_times' defined but not used [-Wunused-function]
 * bmc150_accel_set_power_state() will always fail and reading the
   accelerometer data is impossible;

This commit fixes these.

Signed-off-by: Laurentiu Palcu <laurentiu.palcu@intel.com>
---
 drivers/iio/accel/bmc150-accel.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/accel/bmc150-accel.c b/drivers/iio/accel/bmc150-accel.c
index ccb6cf8..0e6566a 100644
--- a/drivers/iio/accel/bmc150-accel.c
+++ b/drivers/iio/accel/bmc150-accel.c
@@ -499,6 +499,7 @@ static int bmc150_accel_get_bw(struct bmc150_accel_data *data, int *val,
 	return -EINVAL;
 }
 
+#ifdef CONFIG_PM_RUNTIME
 static int bmc150_accel_get_startup_times(struct bmc150_accel_data *data)
 {
 	int i;
@@ -529,6 +530,12 @@ static int bmc150_accel_set_power_state(struct bmc150_accel_data *data, bool on)
 
 	return 0;
 }
+#else
+static int bmc150_accel_set_power_state(struct bmc150_accel_data *data, bool on)
+{
+	return 0;
+}
+#endif
 
 static int bmc150_accel_set_scale(struct bmc150_accel_data *data, int val)
 {
-- 
1.9.1

