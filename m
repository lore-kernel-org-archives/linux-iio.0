Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8101E266B67;
	Fri, 20 Feb 2026 22:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771627520; cv=none; b=dnCMUbEcPSkkx4IgLQ1fz6Ce0cQGczWbFKUOLEeS1MzikSHQRmRkWlg1vKzkzpdVVRweDr8QwueGYC91GhE/Fd0FXE1iqiwva6oCUB8pHtDP9vWZmhmSL3InmmWsgZeUS3abxZwb7uHlyEvN1QMe2auTPQTzRcuPBnLkbQR5Hfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771627520; c=relaxed/simple;
	bh=UTBkj8VT+688mCqyc8UEZ0XrbKTQqGCIcVdEzPwcqD8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fbgsXJf36BXsKYj9zWBEAqFd4Jhovpyw7i4Cp+3eNzdlssPgOGst69KRn1qRHc10HkW/IN3siKmeEucg3KcynR3pepvokt6iC2r8CEgSKGOdi6at4BCAMXMM3/jCccALk7WRSsvGPVz2WnFJOVbT8SC5zkX1mGX+N4HFgb8g18c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MpgXigd5; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MpgXigd5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771627518; x=1803163518;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UTBkj8VT+688mCqyc8UEZ0XrbKTQqGCIcVdEzPwcqD8=;
  b=MpgXigd5UBmJiluFrPcND1mxeVP62L4cmqpzd5jbjODWCA0to3fAsj0+
   5LJ9IYkthcgQME/N2ZAVza9xp9k5v7SjePyiXssc95iWDO2ynKfgisAsX
   eLKftdGb6C9G/leuMEMxBRhMD/T9k5mV2u87+Z8gM9Z2v680gIaE2lwkj
   kRrX0q4B2147Kzo2HQhnYHnCjhog0JpX+clHutua54R7yVyVT1gRFF23z
   U6L4mQDbMWB3iPmbFfQ1VQNIz+YpaesIQWsyTirh5AbNMi71HmJi6jXz3
   WBNjRWeYrIFDWh0nCLtkg+NOSW4iyZN98xnWaBaPvUj9IQjqUnUr1NDIU
   w==;
X-CSE-ConnectionGUID: lgc+eszRQ3a3SUxZbdzZgA==
X-CSE-MsgGUID: MLeyRhaaRnGTxqMHMmhyXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11707"; a="76336755"
X-IronPort-AV: E=Sophos;i="6.21,302,1763452800"; 
   d="scan'208";a="76336755"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 14:45:18 -0800
X-CSE-ConnectionGUID: DdRLQ9YXRNGgmxmt0d/OHw==
X-CSE-MsgGUID: wDmCrjgwQL6FXFPeVEDykg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,302,1763452800"; 
   d="scan'208";a="252663742"
Received: from spandruv-desk.jf.intel.com ([10.54.55.20])
  by orviesa001.jf.intel.com with ESMTP; 20 Feb 2026 14:45:18 -0800
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	bigeasy@linutronix.de,
	spasswolf@web.de,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2] iio: hid-sensors: Use software trigger
Date: Fri, 20 Feb 2026 14:45:14 -0800
Message-ID: <20260220224514.471348-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recent changes linux mainline resulted in warning:
"genirq: Warn about using IRQF_ONESHOT without a threaded handler"
when HID sensor hub is used.

When INDIO_BUFFER_TRIGGERED is used, the core attaches a poll function
when enabling the buffer. This poll function uses request_threaded_irq()
with both bottom half and top half handlers. But when using HID
sensor hub, bottom half (thread handler) is not registered.

In HID sensors, once a sensor is powered on, the hub collects samples
and pushes data to the host when programmed thresholds are met. When
this data is received for a sensor, it is pushed using
iio_push_to_buffers_with_ts().

The sensor is powered ON or OFF based on the trigger callback
set_trigger_state() when the poll function is attached. During the call
to iio_triggered_buffer_setup_ext(), the HID sensor specifies only a
handler function but provides no thread handler, as there is no data
to read from the hub in thread context. Internally, this results in
calling request_threaded_irq(). Recent kernel changes now warn when
request_threaded_irq() is called without a thread handler.

To address this issue, fundamental changes are required to avoid using
iio_triggered_buffer_setup_ext(). HID sensors can use
INDIO_BUFFER_SOFTWARE instead of INDIO_BUFFER_TRIGGERED, as this can
work in trigger-less mode.

In this approach, when user space opens the buffer, the sensor is powered
on, and when the buffer is closed, the sensor is powered off using
iio_buffer_setup_ops callbacks.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
Changes:
v2:
changed 
indio_dev->modes |= INDIO_DIRECT_MODE | INDIO_HARDWARE_TRIGGERED;
to 
indio_dev->modes = INDIO_DIRECT_MODE | INDIO_HARDWARE_TRIGGERED;

From RFC
- The trigger alloc and register is still kept as old code with
additional
indio_dev->modes |= INDIO_DIRECT_MODE | INDIO_HARDWARE_TRIGGERED;

 .../common/hid-sensors/hid-sensor-trigger.c   | 48 ++++++++++++-------
 1 file changed, 30 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
index 5540e2d28f4a..417c4ab8c1b2 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
@@ -14,6 +14,7 @@
 #include <linux/iio/triggered_buffer.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/sysfs.h>
+#include <linux/iio/kfifo_buf.h>
 #include "hid-sensor-trigger.h"
 
 static ssize_t _hid_sensor_set_report_latency(struct device *dev,
@@ -202,12 +203,21 @@ static void hid_sensor_set_power_work(struct work_struct *work)
 		_hid_sensor_power_state(attrb, true);
 }
 
-static int hid_sensor_data_rdy_trigger_set_state(struct iio_trigger *trig,
-						bool state)
+static int buffer_postenable(struct iio_dev *indio_dev)
 {
-	return hid_sensor_power_state(iio_trigger_get_drvdata(trig), state);
+	return hid_sensor_power_state(iio_device_get_drvdata(indio_dev), 1);
 }
 
+static int buffer_predisable(struct iio_dev *indio_dev)
+{
+	return hid_sensor_power_state(iio_device_get_drvdata(indio_dev), 0);
+}
+
+static const struct iio_buffer_setup_ops hid_sensor_buffer_ops = {
+	.postenable = buffer_postenable,
+	.predisable = buffer_predisable,
+};
+
 void hid_sensor_remove_trigger(struct iio_dev *indio_dev,
 			       struct hid_sensor_common *attrb)
 {
@@ -219,14 +229,9 @@ void hid_sensor_remove_trigger(struct iio_dev *indio_dev,
 	cancel_work_sync(&attrb->work);
 	iio_trigger_unregister(attrb->trigger);
 	iio_trigger_free(attrb->trigger);
-	iio_triggered_buffer_cleanup(indio_dev);
 }
 EXPORT_SYMBOL_NS(hid_sensor_remove_trigger, "IIO_HID");
 
-static const struct iio_trigger_ops hid_sensor_trigger_ops = {
-	.set_trigger_state = &hid_sensor_data_rdy_trigger_set_state,
-};
-
 int hid_sensor_setup_trigger(struct iio_dev *indio_dev, const char *name,
 				struct hid_sensor_common *attrb)
 {
@@ -239,25 +244,34 @@ int hid_sensor_setup_trigger(struct iio_dev *indio_dev, const char *name,
 	else
 		fifo_attrs = NULL;
 
-	ret = iio_triggered_buffer_setup_ext(indio_dev,
-					     &iio_pollfunc_store_time, NULL,
-					     IIO_BUFFER_DIRECTION_IN,
-					     NULL, fifo_attrs);
+	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_HARDWARE_TRIGGERED;
+
+	ret = devm_iio_kfifo_buffer_setup_ext(&indio_dev->dev, indio_dev,
+					      &hid_sensor_buffer_ops,
+					      fifo_attrs);
 	if (ret) {
-		dev_err(&indio_dev->dev, "Triggered Buffer Setup Failed\n");
+		dev_err(&indio_dev->dev, "Kfifo Buffer Setup Failed\n");
 		return ret;
 	}
 
+	/*
+	 * The current user space in distro "iio-sensor-proxy" is not working in
+	 * trigerless mode and it expects
+	 * /sys/bus/iio/devices/iio:device0/trigger/current_trigger.
+	 * The change replacing iio_triggered_buffer_setup_ext() with
+	 * devm_iio_kfifo_buffer_setup_ext() will not create attribute without
+	 * registering a trigger with INDIO_HARDWARE_TRIGGERED.
+	 * So the below code fragment is still required.
+	 */
+
 	trig = iio_trigger_alloc(indio_dev->dev.parent,
 				 "%s-dev%d", name, iio_device_id(indio_dev));
 	if (trig == NULL) {
 		dev_err(&indio_dev->dev, "Trigger Allocate Failed\n");
-		ret = -ENOMEM;
-		goto error_triggered_buffer_cleanup;
+		return -ENOMEM;
 	}
 
 	iio_trigger_set_drvdata(trig, attrb);
-	trig->ops = &hid_sensor_trigger_ops;
 	ret = iio_trigger_register(trig);
 
 	if (ret) {
@@ -284,8 +298,6 @@ int hid_sensor_setup_trigger(struct iio_dev *indio_dev, const char *name,
 	iio_trigger_unregister(trig);
 error_free_trig:
 	iio_trigger_free(trig);
-error_triggered_buffer_cleanup:
-	iio_triggered_buffer_cleanup(indio_dev);
 	return ret;
 }
 EXPORT_SYMBOL_NS(hid_sensor_setup_trigger, "IIO_HID");
-- 
2.52.0

