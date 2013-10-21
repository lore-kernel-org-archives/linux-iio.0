Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:10524 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751812Ab3JUVB1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 21 Oct 2013 17:01:27 -0400
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 8/9] iio: Add channel modifiers for Quaternion Rotations
Date: Mon, 21 Oct 2013 14:01:16 -0700
Message-Id: <1382389277-7932-8-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1382389277-7932-1-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1382389277-7932-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

A quaternion is composed of four components: a vector with x, y, z
coordinates and a w rotation. Added channel modifiers for exporting
these four components via user space.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/industrialio-core.c | 4 ++++
 include/linux/iio/types.h       | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index f95c697..4ffaead 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -80,6 +80,10 @@ static const char * const iio_modifier_names[] = {
 	[IIO_MOD_LIGHT_RED] = "red",
 	[IIO_MOD_LIGHT_GREEN] = "green",
 	[IIO_MOD_LIGHT_BLUE] = "blue",
+	[IIO_MOD_QUATERNION_X] = "quat_x",
+	[IIO_MOD_QUATERNION_Y] = "quat_y",
+	[IIO_MOD_QUATERNION_Z] = "quat_z",
+	[IIO_MOD_QUATERNION_W] = "quat_w",
 };
 
 /* relies on pairs of these shared then separate */
diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
index 88bf0f0..ac2345c 100644
--- a/include/linux/iio/types.h
+++ b/include/linux/iio/types.h
@@ -52,6 +52,10 @@ enum iio_modifier {
 	IIO_MOD_LIGHT_RED,
 	IIO_MOD_LIGHT_GREEN,
 	IIO_MOD_LIGHT_BLUE,
+	IIO_MOD_QUATERNION_X,
+	IIO_MOD_QUATERNION_Y,
+	IIO_MOD_QUATERNION_Z,
+	IIO_MOD_QUATERNION_W,
 };
 
 #define IIO_VAL_INT 1
-- 
1.8.3.1

