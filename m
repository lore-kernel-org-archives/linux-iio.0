Return-Path: <jic23@kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: rdunlap@infradead.org,
	denis.ciocca@st.com,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 1/2] iio:triggers Protect functions in triggers.h from use when not compiled
Date: Sat,  9 Feb 2013 10:49:26 +0000
Message-Id: <1360406967-25026-2-git-send-email-jic23@kernel.org>
In-Reply-To: <1360406967-25026-1-git-send-email-jic23@kernel.org>
References: <1360406967-25026-1-git-send-email-jic23@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

Also include a couple of forward defs of struct iio_trigger and struct
iio_trigger_ops to avoid doing this in each driver.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Reported-by: Randy Dunlap <rdunlap@infradead.org>
---
 include/linux/iio/trigger.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/iio/trigger.h b/include/linux/iio/trigger.h
index 20239da..c66e0a9 100644
--- a/include/linux/iio/trigger.h
+++ b/include/linux/iio/trigger.h
@@ -12,6 +12,7 @@
 #ifndef _IIO_TRIGGER_H_
 #define _IIO_TRIGGER_H_
 
+#ifdef CONFIG_IIO_TRIGGER
 struct iio_subirq {
 	bool enabled;
 };
@@ -117,4 +118,8 @@ irqreturn_t iio_trigger_generic_data_rdy_poll(int irq, void *private);
 __printf(1, 2) struct iio_trigger *iio_trigger_alloc(const char *fmt, ...);
 void iio_trigger_free(struct iio_trigger *trig);
 
+#else
+struct iio_trigger;
+struct iio_trigger_ops;
+#endif
 #endif /* _IIO_TRIGGER_H_ */
-- 
1.8.1.1
