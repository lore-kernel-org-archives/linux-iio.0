Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:43047 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753252AbdCXRoi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 24 Mar 2017 13:44:38 -0400
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Olof Johansson <olof@lixom.net>, bleung@chromium.org
Cc: martinez.javier@gmail.com, Guenter Roeck <groeck@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        rtc-linux@googlegroups.com, Stephen Barber <smbarber@chromium.org>
Subject: [PATCH 5/7] mfd: cros_ec: Introduce RTC commands and events definitions.
Date: Fri, 24 Mar 2017 18:44:05 +0100
Message-Id: <20170324174407.25401-6-enric.balletbo@collabora.com>
In-Reply-To: <20170324174407.25401-1-enric.balletbo@collabora.com>
References: <20170324174407.25401-1-enric.balletbo@collabora.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Stephen Barber <smbarber@chromium.org>

The EC can function as a simple RT, this patch adds the RTC related
definitions needed by the rtc-cros-ec driver.

Signed-off-by: Stephen Barber <smbarber@chromium.org>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Lee Jones <lee.jones@linaro.org>
---
 include/linux/mfd/cros_ec_commands.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index 84e1abb..852ce34 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -286,6 +286,9 @@ enum host_event_code {
 	/* Hang detect logic detected a hang and warm rebooted the AP */
 	EC_HOST_EVENT_HANG_REBOOT = 21,
 
+	/* EC RTC event occurred */
+	EC_HOST_EVENT_RTC = 26,
+
 	/*
 	 * The high bit of the event mask is not used as a host event code.  If
 	 * it reads back as set, then the entire event mask should be
@@ -794,6 +797,8 @@ enum ec_feature_code {
 	EC_FEATURE_USB_MUX = 23,
 	/* Motion Sensor code has an internal software FIFO */
 	EC_FEATURE_MOTION_SENSE_FIFO = 24,
+	/* EC has RTC feature that can be controlled by host commands */
+	EC_FEATURE_RTC = 27,
 };
 
 #define EC_FEATURE_MASK_0(event_code) (1UL << (event_code % 32))
@@ -1704,6 +1709,9 @@ struct ec_response_rtc {
 #define EC_CMD_RTC_SET_VALUE 0x46
 #define EC_CMD_RTC_SET_ALARM 0x47
 
+/* Pass as param to SET_ALARM to clear the current alarm */
+#define EC_RTC_ALARM_CLEAR 0
+
 /*****************************************************************************/
 /* Port80 log access */
 
-- 
2.9.3

