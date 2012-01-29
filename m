Return-Path: <jic23@hermes.cam.ac.uk>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: greg@kroah.com,
	guenter.roeck@ericsson.com,
	khali@linux-fr.org,
	dmitry.torokhov@gmail.com,
	broonie@opensource.wolfsonmicro.com,
	alan@lxorguk.ukuu.org.uk,
	arnd@arndb.de,
	linus.walleij@linaro.org,
	maxime.ripard@free-electrons.com,
	thomas.petazzoni@free-electrons.com,
	zdevai@gmail.com,
	w.sang@pengutronix.de,
	marek.vasut@gmail.com,
	Jonathan Cameron <jic23@cam.ac.uk>,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 2/5] staging:iio: move iio data return types into types.h for use by inkern
Date: Sun, 29 Jan 2012 11:46:51 +0000
Message-Id: <1327837614-24176-3-git-send-email-jic23@kernel.org>
In-Reply-To: <1327837614-24176-1-git-send-email-jic23@kernel.org>
References: <1327837614-24176-1-git-send-email-jic23@kernel.org>
Sender: "J.I. Cameron" <jic23@hermes.cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

From: Jonathan Cameron <jic23@cam.ac.uk>

In kernel interfaces need these, so make them available.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/iio.h   |    6 ------
 drivers/staging/iio/types.h |    4 ++++
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
index be6ced3..1e1f5a0 100644
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
