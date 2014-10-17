Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:3667 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752943AbaJQRQI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 17 Oct 2014 13:16:08 -0400
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 2/2] iio: magnetometer: ak8975: remove INVN6500 enumeration
Date: Fri, 17 Oct 2014 10:11:41 -0700
Message-Id: <1413565901-4951-2-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1413565901-4951-1-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1413565901-4951-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Since this needs to use mux adapter to select bypass mode,
it can't enumerate directly over i2c physical adapter.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/magnetometer/ak8975.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index bf5ef07..e071aa9 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -472,7 +472,6 @@ static const struct iio_info ak8975_info = {
 static const struct acpi_device_id ak_acpi_match[] = {
 	{"AK8975", AK8975},
 	{"AK8963", AK8963},
-	{"INVN6500", AK8963},
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, ak_acpi_match);
-- 
1.9.3

