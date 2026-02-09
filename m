Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DFA2E62AC
	for <linux-iio@vger.kernel.org>; Mon,  9 Feb 2026 20:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770669757; cv=none; b=fFiuS2vB5PTlPOWqGfRHY5+q28soHoLUeVXPu6+/izymBhydgLrvMBQLG2Zu0GA5++CbiLoRa6FdQUlAo8oi1FLkR4pda36uEnRc/5MKSTdG4RqWZD9am2ulFKxGBG2QF40JZehy5TpxdksFCUqmV6uT3SR2QL6g41reqIDTAdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770669757; c=relaxed/simple;
	bh=/M6HXL8ynDh7TdNDpu/DjIVdxvZP56/j+MyzZ5yxv1I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bP/o1Tbbsdl/mPGERZGtegDdi4ZOufqpw3vHnPAr+zUrmmGb5vMy3uO4Z0IZJ0+Ece//emcbf3jvhgLdn2ThjKaFTfnSgNDmx4WO5/S4xInY+bBFLEpCC5Vrs2hAjeEmJNHX4YiNc0EZU87oVvtyz8Yb0I4a5UF+/QrobH5rB7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WupZzcE7; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WupZzcE7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770669756; x=1802205756;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/M6HXL8ynDh7TdNDpu/DjIVdxvZP56/j+MyzZ5yxv1I=;
  b=WupZzcE7ApbgKh3a62rDGW1c/cK5mDhk36c/XwoFPxl0eO6GpWn4MnY0
   /4/J2APVS+9zTYLKPteblKfZvUBfvcL4TWE97s/SZcjROLluoTTay2T1B
   dePdg+nYK4CuHbzAG9vXGtSub2HB42P+HncTXJcIREcfXnXQk6aDEFrHx
   DV6EL9nzFPSQLFVLGKVwdghmT4fNcv7Vi/htKgcJ+whlBUKERbn1Y+HkA
   1wAVqsWFaeRJFYnuHp1gsU7iy5tW9zSB2PiWOqG822lFMWtACmR9ALqTF
   /0idb7FuEvDsZxqszawbzrJ8a9Cmw1krC76JkPCyye5a3yPS0KPaEVvTU
   Q==;
X-CSE-ConnectionGUID: CRQtiod4S1eW04sjAPLs6A==
X-CSE-MsgGUID: 4A63DB/jToqm4sC2Zm3gYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="82521410"
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; 
   d="scan'208";a="82521410"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 12:42:36 -0800
X-CSE-ConnectionGUID: PTmVEgMqSdm0E/TcLy6Zeg==
X-CSE-MsgGUID: gYqe5dmrQ1SMzDk8gNNUXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; 
   d="scan'208";a="216674543"
Received: from spandruv-desk.jf.intel.com ([10.54.55.20])
  by orviesa005.jf.intel.com with ESMTP; 09 Feb 2026 12:42:36 -0800
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	bigeasy@linutronix.de,
	spasswolf@web.de,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [RFC PATCH] iio: hid-sensors: Use software trigger
Date: Mon,  9 Feb 2026 12:42:27 -0800
Message-ID: <20260209204227.1352304-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.51.0
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
This is RFC, because
The current user space in distro "iio-sensor-proxy" is not working in
trigerless mode as it expects /sys/bus/iio/devices/iio:device0/trigger/current_trigger.
So, change needs to be submitted to fix that.

 .../common/hid-sensors/hid-sensor-trigger.c   | 62 ++++++-------------
 1 file changed, 18 insertions(+), 44 deletions(-)

diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
index 5540e2d28f4a..113fd1361643 100644
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
@@ -217,59 +227,30 @@ void hid_sensor_remove_trigger(struct iio_dev *indio_dev,
 	pm_runtime_set_suspended(&attrb->pdev->dev);
 
 	cancel_work_sync(&attrb->work);
-	iio_trigger_unregister(attrb->trigger);
-	iio_trigger_free(attrb->trigger);
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
 	const struct iio_dev_attr **fifo_attrs;
 	int ret;
-	struct iio_trigger *trig;
 
 	if (hid_sensor_batch_mode_supported(attrb))
 		fifo_attrs = hid_sensor_fifo_attributes;
 	else
 		fifo_attrs = NULL;
 
-	ret = iio_triggered_buffer_setup_ext(indio_dev,
-					     &iio_pollfunc_store_time, NULL,
-					     IIO_BUFFER_DIRECTION_IN,
-					     NULL, fifo_attrs);
+	ret = devm_iio_kfifo_buffer_setup_ext(&indio_dev->dev, indio_dev,
+					      &hid_sensor_buffer_ops,
+					      fifo_attrs);
 	if (ret) {
-		dev_err(&indio_dev->dev, "Triggered Buffer Setup Failed\n");
+		dev_err(&indio_dev->dev, "Kfifo Buffer Setup Failed\n");
 		return ret;
 	}
-
-	trig = iio_trigger_alloc(indio_dev->dev.parent,
-				 "%s-dev%d", name, iio_device_id(indio_dev));
-	if (trig == NULL) {
-		dev_err(&indio_dev->dev, "Trigger Allocate Failed\n");
-		ret = -ENOMEM;
-		goto error_triggered_buffer_cleanup;
-	}
-
-	iio_trigger_set_drvdata(trig, attrb);
-	trig->ops = &hid_sensor_trigger_ops;
-	ret = iio_trigger_register(trig);
-
-	if (ret) {
-		dev_err(&indio_dev->dev, "Trigger Register Failed\n");
-		goto error_free_trig;
-	}
-	attrb->trigger = trig;
-	indio_dev->trig = iio_trigger_get(trig);
-
 	ret = pm_runtime_set_active(&indio_dev->dev);
 	if (ret)
-		goto error_unreg_trigger;
+		return ret;
 
 	iio_device_set_drvdata(indio_dev, attrb);
 
@@ -280,13 +261,6 @@ int hid_sensor_setup_trigger(struct iio_dev *indio_dev, const char *name,
 	pm_runtime_set_autosuspend_delay(&attrb->pdev->dev,
 					 3000);
 	return ret;
-error_unreg_trigger:
-	iio_trigger_unregister(trig);
-error_free_trig:
-	iio_trigger_free(trig);
-error_triggered_buffer_cleanup:
-	iio_triggered_buffer_cleanup(indio_dev);
-	return ret;
 }
 EXPORT_SYMBOL_NS(hid_sensor_setup_trigger, "IIO_HID");
 
-- 
2.52.0

