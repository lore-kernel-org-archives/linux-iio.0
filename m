Return-Path: <pmeerw@pmeerw.net>
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 1/3] iio: Add TEMP_AMBIENT and TEMP_OBJECT channel modifiers
Date: Fri,  2 May 2014 17:57:04 +0200
Message-Id: <1399046226-6673-2-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1399046226-6673-1-git-send-email-pmeerw@pmeerw.net>
References: <1399046226-6673-1-git-send-email-pmeerw@pmeerw.net>
List-ID: <linux-iio@vger.kernel.org>

useful for contactless temperature sensors to distinguish
between the ambient temperature and the temperature of the object

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/iio/industrialio-core.c | 2 ++
 include/linux/iio/types.h       | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index de8b1c2..4b1f375 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -85,6 +85,8 @@ static const char * const iio_modifier_names[] = {
 	[IIO_MOD_LIGHT_GREEN] = "green",
 	[IIO_MOD_LIGHT_BLUE] = "blue",
 	[IIO_MOD_QUATERNION] = "quaternion",
+	[IIO_MOD_TEMP_AMBIENT] = "ambient",
+	[IIO_MOD_TEMP_OBJECT] = "object",
 };
 
 /* relies on pairs of these shared then separate */
diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
index 4fdab2e..d480631 100644
--- a/include/linux/iio/types.h
+++ b/include/linux/iio/types.h
@@ -54,6 +54,8 @@ enum iio_modifier {
 	IIO_MOD_LIGHT_GREEN,
 	IIO_MOD_LIGHT_BLUE,
 	IIO_MOD_QUATERNION,
+	IIO_MOD_TEMP_AMBIENT,
+	IIO_MOD_TEMP_OBJECT,
 };
 
 enum iio_event_type {
-- 
1.9.1
