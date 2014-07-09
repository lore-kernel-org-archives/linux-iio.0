Return-Path: <reyad.attiyat@gmail.com>
From: Reyad Attiyat <reyad.attiyat@gmail.com>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jic23@kernel.org,
	srinivas.pandruvada@linux.intel.com
Cc: Reyad Attiyat <reyad.attiyat@gmail.com>
Subject: [PATCH v5 2/4] iio: types: Added support for rotation from north usage attributes
Date: Wed,  9 Jul 2014 14:30:11 -0500
Message-Id: <1404934213-2733-3-git-send-email-reyad.attiyat@gmail.com>
In-Reply-To: <1404934213-2733-1-git-send-email-reyad.attiyat@gmail.com>
References: <1404934213-2733-1-git-send-email-reyad.attiyat@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Added the rotation from north usage attributes to the iio modifier enum and to the iio modifier names array.

Signed-off-by: Reyad Attiyat <reyad.attiyat@gmail.com>
---
 drivers/iio/industrialio-core.c | 4 ++++
 include/linux/iio/types.h       | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 4b1f375..af3e76d 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -87,6 +87,10 @@ static const char * const iio_modifier_names[] = {
 	[IIO_MOD_QUATERNION] = "quaternion",
 	[IIO_MOD_TEMP_AMBIENT] = "ambient",
 	[IIO_MOD_TEMP_OBJECT] = "object",
+	[IIO_MOD_NORTH_MAGN] = "from_north_magnetic",
+	[IIO_MOD_NORTH_TRUE] = "from_north_true",
+	[IIO_MOD_NORTH_MAGN_TILT_COMP] = "from_north_magnetic_tilt_comp",
+	[IIO_MOD_NORTH_TRUE_TILT_COMP] = "from_north_true_tilt_comp",
 };
 
 /* relies on pairs of these shared then separate */
diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
index d480631..d09c40d 100644
--- a/include/linux/iio/types.h
+++ b/include/linux/iio/types.h
@@ -56,6 +56,10 @@ enum iio_modifier {
 	IIO_MOD_QUATERNION,
 	IIO_MOD_TEMP_AMBIENT,
 	IIO_MOD_TEMP_OBJECT,
+	IIO_MOD_NORTH_MAGN,
+	IIO_MOD_NORTH_TRUE,
+	IIO_MOD_NORTH_MAGN_TILT_COMP,
+	IIO_MOD_NORTH_TRUE_TILT_COMP
 };
 
 enum iio_event_type {
-- 
1.9.3
