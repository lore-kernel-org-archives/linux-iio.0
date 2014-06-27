Return-Path: <srinivas.pandruvada@linux.intel.com>
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [RFC PATCH 1/2] iio: core: add xyz modifier value
Date: Thu, 26 Jun 2014 17:40:25 -0700
Message-Id: <1403829626-17660-2-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1403829626-17660-1-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1403829626-17660-1-git-send-email-srinivas.pandruvada@linux.intel.com>
List-ID: <linux-iio@vger.kernel.org>

iio types defines a modifier called IIO_MOD_X_AND_Y_AND_Z, but since
no modifier name is specified, it shows (null) as channel name.
Here name is assiged a value "xyz".

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/industrialio-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 4b1f375..e8428bb 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -87,6 +87,7 @@ static const char * const iio_modifier_names[] = {
 	[IIO_MOD_QUATERNION] = "quaternion",
 	[IIO_MOD_TEMP_AMBIENT] = "ambient",
 	[IIO_MOD_TEMP_OBJECT] = "object",
+	[IIO_MOD_X_AND_Y_AND_Z] = "xyz",
 };
 
 /* relies on pairs of these shared then separate */
-- 
1.8.3.2
