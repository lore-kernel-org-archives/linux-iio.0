Return-Path: <jic23@kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 4/8] IIO: Add a modifier for sqrt(x^2+y^2)
Date: Wed, 30 May 2012 20:41:02 +0100
Message-Id: <1338406866-3833-5-git-send-email-jic23@kernel.org>
In-Reply-To: <1338406866-3833-1-git-send-email-jic23@kernel.org>
References: <1338406866-3833-1-git-send-email-jic23@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

There will probably be a number of such modifiers eventually but
this one is used in the adis16204 accelerometer driver.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/industrialio-core.c |    1 +
 include/linux/iio/types.h       |    1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index aa2edf4..071fbf1 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -70,6 +70,7 @@ static const char * const iio_modifier_names[] = {
 	[IIO_MOD_X] = "x",
 	[IIO_MOD_Y] = "y",
 	[IIO_MOD_Z] = "z",
+	[IIO_MOD_ROOT_SUM_SQUARED_X_Y] = "sqrt(x^2+y^2)",
 	[IIO_MOD_LIGHT_BOTH] = "both",
 	[IIO_MOD_LIGHT_IR] = "ir",
 };
diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
index 1b073b1..ab907bf 100644
--- a/include/linux/iio/types.h
+++ b/include/linux/iio/types.h
@@ -45,6 +45,7 @@ enum iio_modifier {
 	IIO_MOD_X_OR_Y_OR_Z,
 	IIO_MOD_LIGHT_BOTH,
 	IIO_MOD_LIGHT_IR,
+	IIO_MOD_ROOT_SUM_SQUARED_X_Y,
 };
 
 #define IIO_VAL_INT 1
-- 
1.7.10.2
