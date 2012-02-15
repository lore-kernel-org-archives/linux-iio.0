Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:36680 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754690Ab2BOTrZ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 15 Feb 2012 14:47:25 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: greg@kroah.com, guenter.roeck@ericsson.com, khali@linux-fr.org,
	dmitry.torokhov@gmail.com, broonie@opensource.wolfsonmicro.com,
	alan@lxorguk.ukuu.org.uk, arnd@arndb.de, linus.walleij@linaro.org,
	maxime.ripard@free-electrons.com,
	thomas.petazzoni@free-electrons.com, zdevai@gmail.com,
	w.sang@pengutronix.de, marek.vasut@gmail.com,
	Jonathan Cameron <jic23@cam.ac.uk>,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 3/6] staging:iio: move iio data return types into types.h for use by inkern
Date: Wed, 15 Feb 2012 19:48:02 +0000
Message-Id: <1329335285-31006-4-git-send-email-jic23@kernel.org>
In-Reply-To: <1329335285-31006-1-git-send-email-jic23@kernel.org>
References: <1329335285-31006-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Jonathan Cameron <jic23@cam.ac.uk>

In kernel interfaces need these, so make them available.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/iio.h   |    6 ------
 drivers/staging/iio/types.h |    4 ++++
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
index 478dbe5..9459c17 100644
--- a/drivers/staging/iio/iio.h
+++ b/drivers/staging/iio/iio.h
@@ -197,12 +197,6 @@ static inline s64 iio_get_time_ns(void)
 #define INDIO_ALL_BUFFER_MODES					\
 	(INDIO_BUFFER_TRIGGERED | INDIO_BUFFER_HARDWARE)
 
-/* Vast majority of this is set by the industrialio subsystem on a
- * call to iio_device_register. */
-#define IIO_VAL_INT 1
-#define IIO_VAL_INT_PLUS_MICRO 2
-#define IIO_VAL_INT_PLUS_NANO 3
-
 struct iio_trigger; /* forward declaration */
 struct iio_dev;
 
diff --git a/drivers/staging/iio/types.h b/drivers/staging/iio/types.h
index b7d2647..0c32136 100644
--- a/drivers/staging/iio/types.h
+++ b/drivers/staging/iio/types.h
@@ -46,4 +46,8 @@ enum iio_modifier {
 	IIO_MOD_LIGHT_IR,
 };
 
+#define IIO_VAL_INT 1
+#define IIO_VAL_INT_PLUS_MICRO 2
+#define IIO_VAL_INT_PLUS_NANO 3
+
 #endif /* _IIO_TYPES_H_ */
-- 
1.7.8.4

