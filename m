Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from eu1sys200aog101.obsmtp.com ([207.126.144.111]:57017 "EHLO
	eu1sys200aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754553Ab3BGJql (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 7 Feb 2013 04:46:41 -0500
From: Denis CIOCCA <denis.ciocca@st.com>
To: jic23@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org
Cc: Denis Ciocca <denis.ciocca@st.com>
Subject: [PATCH] iio:common: added allocate and deallocate trigger functions when trigger is disabled.
Date: Thu,  7 Feb 2013 10:46:03 +0100
Message-Id: <1360230363-15553-1-git-send-email-denis.ciocca@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch resolve a bugfix when driver is compiled without trigger.
---
 include/linux/iio/common/st_sensors.h |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/common/st_sensors.h
index c40fdf5..1f86a97 100644
--- a/include/linux/iio/common/st_sensors.h
+++ b/include/linux/iio/common/st_sensors.h
@@ -235,6 +235,16 @@ void st_sensors_deallocate_trigger(struct iio_dev *indio_dev);
 irqreturn_t st_sensors_trigger_handler(int irq, void *p);
 
 int st_sensors_get_buffer_element(struct iio_dev *indio_dev, u8 *buf);
+#else
+static inline int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
+				const struct iio_trigger_ops *trigger_ops)
+{
+	return 0;
+}
+static inline void st_sensors_deallocate_trigger(struct iio_dev *indio_dev)
+{
+	return;
+}
 #endif
 
 int st_sensors_init_sensor(struct iio_dev *indio_dev);
-- 
1.7.9.5

