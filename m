Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:64644 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753760Ab3I0Qca (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 27 Sep 2013 12:32:30 -0400
From: Lukasz Czerwinski <l.czerwinski@samsung.com>
To: jic23@cam.ac.uk
Cc: denis.ciocca@st.com, linux-iio@vger.kernel.org,
	lee.jones@linaro.org, devicetree@vger.kernel.org
Subject: [RFC v2 PATCH 09/14] iio: st_gyro: Add event ops
Date: Fri, 27 Sep 2013 18:32:13 +0200
Message-id: <1380299538-22047-10-git-send-email-l.czerwinski@samsung.com>
In-reply-to: <1380299538-22047-1-git-send-email-l.czerwinski@samsung.com>
References: <1380299538-22047-1-git-send-email-l.czerwinski@samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Lukasz Czerwinski <l.czerwinski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/iio/gyro/st_gyro_core.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iio/gyro/st_gyro_core.c b/drivers/iio/gyro/st_gyro_core.c
index 42f45af..6a41836 100644
--- a/drivers/iio/gyro/st_gyro_core.c
+++ b/drivers/iio/gyro/st_gyro_core.c
@@ -290,6 +290,10 @@ static const struct iio_info gyro_info = {
 	.attrs = &st_gyro_attribute_group,
 	.read_raw = &st_gyro_read_raw,
 	.write_raw = &st_gyro_write_raw,
+	.read_event_value = &st_sensors_read_event_value,
+	.write_event_value = &st_sensors_write_event_value,
+	.read_event_config = &st_sensors_read_event_config,
+	.write_event_config = &st_sensors_write_event_config,
 };
 
 #ifdef CONFIG_IIO_TRIGGER
-- 
1.7.9.5

