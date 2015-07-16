Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:35346 "EHLO
	mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753693AbbGPJTD (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 16 Jul 2015 05:19:03 -0400
Received: from pps.filterd (m0046670.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.14.5/8.14.5) with SMTP id t6G9EWkp017979
	for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2015 11:19:02 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com with ESMTP id 1vmbkf079h-1
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2015 11:19:02 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 30F6031
	for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2015 09:19:00 +0000 (GMT)
Received: from Webmail-eu.st.com (safex1hubcas1.st.com [10.75.90.14])
	by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 16AAF15B0
	for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2015 09:19:00 +0000 (GMT)
From: Giuseppe Barba <giuseppe.barba@st.com>
To: <linux-iio@vger.kernel.org>
CC: Giuseppe Barba <giuseppe.barba@st.com>
Subject: [PATCH 3/5] iio: st_magn: Add irq trigger handling
Date: Thu, 16 Jul 2015 11:17:42 +0200
Message-ID: <1437038264-12936-4-git-send-email-giuseppe.barba@st.com>
In-Reply-To: <1437038264-12936-1-git-send-email-giuseppe.barba@st.com>
References: <1437038264-12936-1-git-send-email-giuseppe.barba@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add irq trigger handling for magnetometer also

Signed-off-by: Giuseppe Barba <giuseppe.barba@st.com>
---
 drivers/iio/magnetometer/st_magn.h        |  2 ++
 drivers/iio/magnetometer/st_magn_buffer.c |  7 +++++++
 drivers/iio/magnetometer/st_magn_core.c   | 13 ++++++++++++-
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/magnetometer/st_magn.h b/drivers/iio/magnetometer/st_magn.h
index 287691c..60441023 100644
--- a/drivers/iio/magnetometer/st_magn.h
+++ b/drivers/iio/magnetometer/st_magn.h
@@ -25,6 +25,8 @@ void st_magn_common_remove(struct iio_dev *indio_dev);
 #ifdef CONFIG_IIO_BUFFER
 int st_magn_allocate_ring(struct iio_dev *indio_dev);
 void st_magn_deallocate_ring(struct iio_dev *indio_dev);
+int st_magn_trig_set_state(struct iio_trigger *trig, bool state);
+#define ST_MAGN_TRIGGER_SET_STATE (&st_magn_trig_set_state)
 #else /* CONFIG_IIO_BUFFER */
 static inline int st_magn_probe_trigger(struct iio_dev *indio_dev, int irq)
 {
diff --git a/drivers/iio/magnetometer/st_magn_buffer.c b/drivers/iio/magnetometer/st_magn_buffer.c
index bf427dc..ecd3bd0 100644
--- a/drivers/iio/magnetometer/st_magn_buffer.c
+++ b/drivers/iio/magnetometer/st_magn_buffer.c
@@ -23,6 +23,13 @@
 #include <linux/iio/common/st_sensors.h>
 #include "st_magn.h"
 
+int st_magn_trig_set_state(struct iio_trigger *trig, bool state)
+{
+	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
+
+	return st_sensors_set_dataready_irq(indio_dev, state);
+}
+
 static int st_magn_buffer_preenable(struct iio_dev *indio_dev)
 {
 	return st_sensors_set_enable(indio_dev, true);
diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
index 4c0335b..4948185 100644
--- a/drivers/iio/magnetometer/st_magn_core.c
+++ b/drivers/iio/magnetometer/st_magn_core.c
@@ -481,6 +481,16 @@ static const struct iio_info magn_info = {
 	.write_raw = &st_magn_write_raw,
 };
 
+#ifdef CONFIG_IIO_TRIGGER
+static const struct iio_trigger_ops st_magn_trigger_ops = {
+	.owner = THIS_MODULE,
+	.set_trigger_state = ST_MAGN_TRIGGER_SET_STATE,
+};
+#define ST_MAGN_TRIGGER_OPS (&st_magn_trigger_ops)
+#else
+#define ST_MAGN_TRIGGER_OPS NULL
+#endif
+
 int st_magn_common_probe(struct iio_dev *indio_dev)
 {
 	struct st_sensor_data *mdata = iio_priv(indio_dev);
@@ -517,7 +527,8 @@ int st_magn_common_probe(struct iio_dev *indio_dev)
 		return err;
 
 	if (irq > 0) {
-		err = st_sensors_allocate_trigger(indio_dev, NULL);
+		err = st_sensors_allocate_trigger(indio_dev,
+						ST_MAGN_TRIGGER_OPS);
 		if (err < 0)
 			goto st_magn_probe_trigger_error;
 	}
-- 
1.9.1

