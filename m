Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:16802 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755431AbaDNWHs (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 14 Apr 2014 18:07:48 -0400
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [Patch v5 4/6] IIO: core: Add quaternion modifier
Date: Mon, 14 Apr 2014 15:11:05 -0700
Message-Id: <1397513467-21397-5-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1397513467-21397-1-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1397513467-21397-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Added quaternion in the list of supported modifiers.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/industrialio-core.c | 1 +
 include/linux/iio/types.h       | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index e22a984..dcc1849 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -84,6 +84,7 @@ static const char * const iio_modifier_names[] = {
 	[IIO_MOD_LIGHT_RED] = "red",
 	[IIO_MOD_LIGHT_GREEN] = "green",
 	[IIO_MOD_LIGHT_BLUE] = "blue",
+	[IIO_MOD_QUATERNION] = "quaternion",
 };
 
 /* relies on pairs of these shared then separate */
diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
index a13c224..4fdab2e 100644
--- a/include/linux/iio/types.h
+++ b/include/linux/iio/types.h
@@ -53,6 +53,7 @@ enum iio_modifier {
 	IIO_MOD_LIGHT_RED,
 	IIO_MOD_LIGHT_GREEN,
 	IIO_MOD_LIGHT_BLUE,
+	IIO_MOD_QUATERNION,
 };
 
 enum iio_event_type {
-- 
1.7.11.7

