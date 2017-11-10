Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55290 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754129AbdKJV4N (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 10 Nov 2017 16:56:13 -0500
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: Lee Jones <lee.jones@linaro.org>, bleung@chromium.org
Cc: Guenter Roeck <groeck@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        rtc-linux@googlegroups.com, Stephen Barber <smbarber@chromium.org>
Subject: [PATCH v4 1/2] mfd: cros_ec: Introduce RTC commands and events definitions.
Date: Fri, 10 Nov 2017 22:55:52 +0100
Message-Id: <20171110215553.20696-2-enric.balletbo@collabora.com>
In-Reply-To: <20171110215553.20696-1-enric.balletbo@collabora.com>
References: <20171110215553.20696-1-enric.balletbo@collabora.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Stephen Barber <smbarber@chromium.org>

The EC can function as a simple RT, this patch adds the RTC related
definitions needed by the rtc-cros-ec driver.

Signed-off-by: Stephen Barber <smbarber@chromium.org>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Benson Leung <bleung@chromium.org>
---
 include/linux/mfd/cros_ec_commands.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index 2b16e95..c6046a2 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -291,6 +291,9 @@ enum host_event_code {
 	/* EC desires to change state of host-controlled USB mux */
 	EC_HOST_EVENT_USB_MUX = 28,
 
+	/* EC RTC event occurred */
+	EC_HOST_EVENT_RTC = 26,
+
 	/*
 	 * The high bit of the event mask is not used as a host event code.  If
 	 * it reads back as set, then the entire event mask should be
@@ -799,6 +802,8 @@ enum ec_feature_code {
 	EC_FEATURE_USB_MUX = 23,
 	/* Motion Sensor code has an internal software FIFO */
 	EC_FEATURE_MOTION_SENSE_FIFO = 24,
+	/* EC has RTC feature that can be controlled by host commands */
+	EC_FEATURE_RTC = 27,
 };
 
 #define EC_FEATURE_MASK_0(event_code) (1UL << (event_code % 32))
@@ -1709,6 +1714,9 @@ struct ec_response_rtc {
 #define EC_CMD_RTC_SET_VALUE 0x46
 #define EC_CMD_RTC_SET_ALARM 0x47
 
+/* Pass as param to SET_ALARM to clear the current alarm */
+#define EC_RTC_ALARM_CLEAR 0
+
 /*****************************************************************************/
 /* Port80 log access */
 
-- 
2.9.3

