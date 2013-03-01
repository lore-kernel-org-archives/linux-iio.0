Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:57297 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750983Ab3CAP53 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 1 Mar 2013 10:57:29 -0500
From: Guenter Roeck <linux@roeck-us.net>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Denis Ciocca <denis.ciocca@st.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] iio: Fix build error seen if IIO_TRIGGER is defined but IIO_BUFFER is not
Date: Fri,  1 Mar 2013 07:57:28 -0800
Message-Id: <1362153448-16259-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

If CONFIG_IIO_TRIGGER is defined but CONFIG_IIO_BUFFER is not, the following
build error is seen.

drivers/iio/common/st_sensors/st_sensors_trigger.c:21:5: error:
redefinition of ‘st_sensors_allocate_trigger’
In file included from
drivers/iio/common/st_sensors/st_sensors_trigger.c:18:0:
include/linux/iio/common/st_sensors.h:239:19: note: previous
definition of ‘st_sensors_allocate_trigger’ was here
drivers/iio/common/st_sensors/st_sensors_trigger.c:65:6: error:
redefinition of ‘st_sensors_deallocate_trigger’
In file included from
drivers/iio/common/st_sensors/st_sensors_trigger.c:18:0:
include/linux/iio/common/st_sensors.h:244:20: note: previous
definition of ‘st_sensors_deallocate_trigger’ was here

This occurs because st_sensors_deallocate_trigger is built if CONFIG_IIO_TRIGGER
is defined, but the dummy function is compiled if CONFIG_IIO_BUFFER is defined.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 include/linux/iio/common/st_sensors.h |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/common/st_sensors.h
index 1f86a97..8bd12be 100644
--- a/include/linux/iio/common/st_sensors.h
+++ b/include/linux/iio/common/st_sensors.h
@@ -227,14 +227,17 @@ struct st_sensor_data {
 };
 
 #ifdef CONFIG_IIO_BUFFER
+irqreturn_t st_sensors_trigger_handler(int irq, void *p);
+
+int st_sensors_get_buffer_element(struct iio_dev *indio_dev, u8 *buf);
+#endif
+
+#ifdef CONFIG_IIO_TRIGGER
 int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
 				const struct iio_trigger_ops *trigger_ops);
 
 void st_sensors_deallocate_trigger(struct iio_dev *indio_dev);
 
-irqreturn_t st_sensors_trigger_handler(int irq, void *p);
-
-int st_sensors_get_buffer_element(struct iio_dev *indio_dev, u8 *buf);
 #else
 static inline int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
 				const struct iio_trigger_ops *trigger_ops)
-- 
1.7.9.7

