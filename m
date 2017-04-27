Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:34659 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S939232AbdD0N3a (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 27 Apr 2017 09:29:30 -0400
Received: by mail-wm0-f44.google.com with SMTP id r190so5407193wme.1
        for <linux-iio@vger.kernel.org>; Thu, 27 Apr 2017 06:29:29 -0700 (PDT)
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
To: linux-kernel@vger.kernel.org, jic23@kernel.org,
        linux-iio@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, vilhelm.gray@gmail.com, mwelling@ieee.org
Cc: fabrice.gasnier@st.com, linaro-kernel@lists.linaro.org,
        benjamin.gaignard@linaro.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH 1/2] iio: add hardware triggered operating mode
Date: Thu, 27 Apr 2017 15:29:15 +0200
Message-Id: <1493299756-18157-2-git-send-email-benjamin.gaignard@st.com>
In-Reply-To: <1493299756-18157-1-git-send-email-benjamin.gaignard@st.com>
References: <1493299756-18157-1-git-send-email-benjamin.gaignard@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Devices, like stm32 timer, could be triggered by hardware events which
are not buffer or software events. However it could be necessary to
validate the triggers like it is done for buffer or event triggered modes.
This patch add a new INDIO_HARDWARE_TRIGGERED operating mode for this
kind of devices and allow this mode to register trigger consumer.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 drivers/iio/industrialio-core.c | 4 ++--
 include/linux/iio/iio.h         | 6 ++++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index d18ded4..7872219 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1429,7 +1429,7 @@ static void iio_device_unregister_sysfs(struct iio_dev *indio_dev)
 static void iio_dev_release(struct device *device)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(device);
-	if (indio_dev->modes & (INDIO_BUFFER_TRIGGERED | INDIO_EVENT_TRIGGERED))
+	if (indio_dev->modes & INDIO_ALL_TRIGGERED_MODES)
 		iio_device_unregister_trigger_consumer(indio_dev);
 	iio_device_unregister_eventset(indio_dev);
 	iio_device_unregister_sysfs(indio_dev);
@@ -1711,7 +1711,7 @@ int iio_device_register(struct iio_dev *indio_dev)
 			"Failed to register event set\n");
 		goto error_free_sysfs;
 	}
-	if (indio_dev->modes & (INDIO_BUFFER_TRIGGERED | INDIO_EVENT_TRIGGERED))
+	if (indio_dev->modes & INDIO_ALL_TRIGGERED_MODES)
 		iio_device_register_trigger_consumer(indio_dev);
 
 	if ((indio_dev->modes & INDIO_ALL_BUFFER_MODES) &&
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 3f5ea2e..d68bec2 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -352,10 +352,16 @@ static inline bool iio_channel_has_available(const struct iio_chan_spec *chan,
 #define INDIO_BUFFER_SOFTWARE		0x04
 #define INDIO_BUFFER_HARDWARE		0x08
 #define INDIO_EVENT_TRIGGERED		0x10
+#define INDIO_HARDWARE_TRIGGERED	0x20
 
 #define INDIO_ALL_BUFFER_MODES					\
 	(INDIO_BUFFER_TRIGGERED | INDIO_BUFFER_HARDWARE | INDIO_BUFFER_SOFTWARE)
 
+#define INDIO_ALL_TRIGGERED_MODES	\
+	(INDIO_BUFFER_TRIGGERED		\
+	 | INDIO_EVENT_TRIGGERED	\
+	 | INDIO_HARDWARE_TRIGGERED)
+
 #define INDIO_MAX_RAW_ELEMENTS		4
 
 struct iio_trigger; /* forward declaration */
-- 
1.9.1

