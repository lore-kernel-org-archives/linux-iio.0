Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793993576;
	b=KP/+OFIs2ZUjWFWnsdPc/9fOWrdOJZZL6m1fC0f6e7kAS7T/IjJN3Ovr8erASiRuib7x
	 YuuJp5cH3mGRtd4o1AScqpMfrmNQ7SH5/3ns2V9+SiQPcauZyJTdURi4YC2wnUvFumX93
	 gsous4Z64tfTO/2HtJSaCyBPYtEtSACMRpsXkY+2sLZVgG/04igQ2f6ZTs+uDSPALQb3u
	 T8cfzOh2y3mTkY9CIwWVOhgZkb4GlqrO0NLxWCq3JwLIoxNIh+YIejUfy3xsX2gU9Dyn4
	 Rl06BPxl84QbElk91KsnPD+uB0gE+XyU7NFgm0lMmXWk8UN7umVVY6I8WzeC7esaLaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793993576;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=UoxM27iakzAnYr6BdBJMTdIyMXri5uMmOqSHZ/4RcpY=;
	b=cTGGzjNUM4WVepBc5Mblh1JbOqpGqDLVDwznc9JPGPX+KuJd0m9VCpH1xtkfSXYNWjO2
	 dPLL8nNLMR7wPNbxxHWARw+qyEEoDYV70II8vQV3u9dD4weW4vd+rnW1E6Ve87V9F7kpI
	 2POPV04ChaPDSE0Ch6GRtjFB7+PhQkP0iC4z5xzuFPf3oFWr7Cg/sVvFOVL8om+ch/jW+
	 BZ2tUVb9yt2eyuWbMzUMEEi8PlMAFif1g7fMdAGaujQ99bR087mVsySDbNYRBR7kVC5T2
	 AkaQVxIh/z9FC8nIhb3KUTrH1SUmZSWsByEZI/dQ1w2UMHR8tpUjYP073RmU5bgXq4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dbalint.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=QtvBVQku;
	arc=none smtp.remote-ip=209.85.167.70
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com [209.85.167.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168DB606A335
	for <linux-iio@vger.kernel.org>; Fri,  6 Nov 2026 19:32:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 168DB606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dbalint.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=QtvBVQku
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-5c00b58e8c5so88e87.2
        for <linux-iio@vger.kernel.org>; Fri, 06 Nov 2026 11:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793993574; x=1794598374; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UoxM27iakzAnYr6BdBJMTdIyMXri5uMmOqSHZ/4RcpY=;
        b=QtvBVQkuIEnKjcNHSCBnXdH/JArqgiMcAXwI7dkXityapN2Fe8U3DYFPHVMxqIXC91
         FtQJOAqrFAltiPekxpcpOLGynRkmcS+80zpcOkgXfaIc8zxz+OnKJFWx97YMUvuFR8Sh
         fnS+e90lXp1ZLcTydox3pu3nNbWwdlYtuE60O/TUvSGpcmNawD9xcSlzLx7xohN1TSxX
         P0nlh/C3RiP3omIYPH39toL8YCJPl5Z9BJNOOZ/v2I5OMDjGHPmP6dC/DN9AEMPFjlIl
         CiT7fqr6nRDJf/yuvvRceZItYZSXArfgGs9G/h0DWueL/5/TLmKWh6g8jcnRv/pxnPRu
         yQwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793993574; x=1794598374;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UoxM27iakzAnYr6BdBJMTdIyMXri5uMmOqSHZ/4RcpY=;
        b=LznVcGGrbYxX0v3Ccep8JSoyobO7cNvBXhjM77eeM94XWQ+9q9uGZnXvYpAgXxHHcX
         wxUx/7S4Jw7TDySe2N2OLGVro2co5jvB7Tk1j2Cm1vC2m/neUVbAiRegFdadZeDvpO6u
         OZfCptx5kgJAYsbBskc/rHaTucrjl1ZYGmGx1ozEpLeUPX+rWsreLW8B4HXrRotBdSK6
         RvC2c1Yvdhohu2c+AIuoWIMupe7SH/EPGow1DBjnCSriKThy8b6bRyJx8Y384RuaD0kT
         JlfsXLue8wdrRrPO/JWFVvhjBjVPL9acPujSU7RNBW8IXl/xr3JIPQDsvmOb2WBlEssE
         oc4A==
X-Gm-Message-State: APuU4Z/ZfTk0ad3m4u1Sz7Og1S255Jvzs2oFdKaDXG5+Fe8VBhTxQtBK
	wB8lyD2vjEoZ9KBm06OXbI9RExTCy84LAXfFLkFQcdgPa3oRBBKPfsP6UFEcWATEwCaRKHE29r4
	n9Bd6cAwztw==
X-Received: from lfao15-n2.prod.google.com ([2002:a05:6512:378f:20b0:5c0:2c2:ba3b])
 (user=dbalint job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6512:2398:b0:5c0:acc:6e55
 with SMTP id 2adb3069b0e04-5c00acc6fb4mr139524e87.58.1793993574122; Fri, 06
 Nov 2026 11:32:54 -0800 (PST)
Date: Fri,  6 Nov 2026 19:31:16 +0000
In-Reply-To: <20261106193129.43493-1-dbalint@google.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261106193129.43493-1-dbalint@google.com>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261106193129.43493-3-dbalint@google.com>
Subject: [PATCH v1 2/3] iio: adc: add cros_ec_pwrmon driver
From: Daniel Balint <dbalint@google.com>
To: Jonathan Cameron <jic23@kernel.org>, Benson Leung <bleung@chromium.org>, Lee Jones <lee@kernel.org>, 
	Tzung-Bi Shih <tzungbi@kernel.org>
Cc: linux-iio@vger.kernel.org, chrome-platform@lists.linux.dev, 
	mfd@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Daniel Balint <dbalint@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Add the ChromeOS EC On-Device Power Monitoring (ODPM) driver to read
onboard power-monitoring ADCs (such as PAC194x) wired through the EC.

The driver interfaces with the EC via the existing EC_CMD_PWRMON host
command API and EC_MKBP_EVENT_PWRMON events to start/stop accumulation,
latch ADC accumulators, and expose cumulative per-rail energy in
microjoules (uWs) through the energy_value sysfs attribute.

Signed-off-by: Daniel Balint <dbalint@google.com>
---
 .../ABI/testing/sysfs-bus-iio-cros-ec         |  13 +
 MAINTAINERS                                   |   7 +
 drivers/iio/adc/Kconfig                       |  11 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/cros_ec_pwrmon.c              | 333 ++++++++++++++++++
 5 files changed, 365 insertions(+)
 create mode 100644 drivers/iio/adc/cros_ec_pwrmon.c

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-cros-ec b/Documentatio=
n/ABI/testing/sysfs-bus-iio-cros-ec
index 3de1dfc98389..9043824f2831 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio-cros-ec
+++ b/Documentation/ABI/testing/sysfs-bus-iio-cros-ec
@@ -19,3 +19,16 @@ Description:
 		represents the sensor ID as exposed by the EC. This ID is used
 		by the Android sensor service hardware abstraction layer (sensor
 		HAL) through the Android container on ChromeOS.
+
+What:		/sys/bus/iio/devices/iio:deviceX/energy_value
+Date:		November 2026
+KernelVersion:	7.5
+Contact:	chrome-platform@lists.linux.dev, linux-iio@vger.kernel.org
+Description:
+		This read-only attribute is exposed by the ChromeOS EC power
+		monitor (cros_ec_pwrmon) driver for On-Device Power Monitoring
+		(ODPM). Reading it latches all EC power accumulators and returns
+		a snapshot timestamp followed by per-channel accumulated energy:
+
+		t=3D<Measurement timestamp in ms since boot>
+		CH<N>(T=3D<Duration in ms>)[<Rail schematic name>], <Accumulated energy =
in uWs>
diff --git a/MAINTAINERS b/MAINTAINERS
index 93abbb315065..c58e3943cfdc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6335,6 +6335,13 @@ M:	Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
 S:	Maintained
 F:	drivers/leds/leds-cros_ec.c
=20
+CHROMEOS EC POWER MONITORING
+M:	Daniel Balint <dbalint@google.com>
+L:	chrome-platform@lists.linux.dev
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	drivers/iio/adc/cros_ec_pwrmon.c
+
 CHROMEOS EC SUBDRIVERS
 M:	Benson Leung <bleung@chromium.org>
 R:	Guenter Roeck <groeck@chromium.org>
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index a802d8ee4dd9..fbe250019342 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -743,6 +743,17 @@ config CPCAP_ADC
 	  This driver can also be built as a module. If so, the module will be
 	  called cpcap-adc.
=20
+config CROS_EC_PWRMON
+	tristate "ChromeOS EC Power Monitor Driver"
+	depends on MFD_CROS_EC_DEV
+	default MFD_CROS_EC_DEV
+	help
+	  Say yes here to build support for the ChromeOS EC On-Device Power
+	  Monitoring (ODPM) driver.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called cros_ec_pwrmon.
+
 config DA9150_GPADC
 	tristate "Dialog DA9150 GPADC driver support"
 	depends on MFD_DA9150
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 9e82c21dbd37..2f36a3c4a68f 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -63,6 +63,7 @@ obj-$(CONFIG_BCM_IPROC_ADC) +=3D bcm_iproc_adc.o
 obj-$(CONFIG_BERLIN2_ADC) +=3D berlin2-adc.o
 obj-$(CONFIG_CC10001_ADC) +=3D cc10001_adc.o
 obj-$(CONFIG_CPCAP_ADC) +=3D cpcap-adc.o
+obj-$(CONFIG_CROS_EC_PWRMON) +=3D cros_ec_pwrmon.o
 obj-$(CONFIG_DA9150_GPADC) +=3D da9150-gpadc.o
 obj-$(CONFIG_DLN2_ADC) +=3D dln2-adc.o
 obj-$(CONFIG_ENVELOPE_DETECTOR) +=3D envelope-detector.o
diff --git a/drivers/iio/adc/cros_ec_pwrmon.c b/drivers/iio/adc/cros_ec_pwr=
mon.c
new file mode 100644
index 000000000000..795b5f2b2a2c
--- /dev/null
+++ b/drivers/iio/adc/cros_ec_pwrmon.c
@@ -0,0 +1,333 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * ChromeOS EC Power Monitor Driver
+ *
+ * Copyright (c) 2026 Google Inc.
+ */
+
+#include <linux/cleanup.h>
+#include <linux/device.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/ktime.h>
+#include <linux/math64.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/notifier.h>
+#include <linux/platform_data/cros_ec_commands.h>
+#include <linux/platform_data/cros_ec_proto.h>
+#include <linux/platform_device.h>
+#include <linux/spinlock.h>
+#include <linux/string.h>
+#include <linux/sysfs.h>
+#include <linux/types.h>
+#include <linux/unaligned.h>
+#include <linux/wait.h>
+
+#define PWRMON_MAX_CHANNELS 64
+#define PWRMON_MKBP_TIMEOUT_MS 1000
+
+struct cros_ec_pwrmon_state {
+	struct cros_ec_command *msg;
+	struct cros_ec_dev *ec_dev;
+	struct cros_ec_device *ec;
+	/* Serializes EC host commands and energy accumulation state */
+	struct mutex lock;
+	/* Protects MKBP event results and collection state */
+	spinlock_t event_lock;
+	struct notifier_block notifier;
+	wait_queue_head_t wq;
+	struct {
+		s64 value;
+		bool valid;
+	} results[PWRMON_MAX_CHANNELS];
+	int results_received;
+	bool collecting;
+	u64 *accumulated_energy;
+	char (*channel_names)[32];
+	int num_channels;
+	u64 last_time_ms;
+};
+
+/*
+ * MKBP event handler =E2=80=94 called once per channel event from the EC.
+ */
+static int cros_ec_pwrmon_notify(struct notifier_block *nb,
+				 unsigned long queued_during_suspend,
+				 void *data)
+{
+	struct cros_ec_pwrmon_state *st =3D
+		container_of(nb, struct cros_ec_pwrmon_state, notifier);
+	struct cros_ec_device *ec_dev =3D st->ec;
+	s64 val;
+	u8 ch;
+
+	if (ec_dev->event_data.event_type !=3D EC_MKBP_EVENT_PWRMON)
+		return NOTIFY_DONE;
+
+	ch =3D ec_dev->event_data.data.pwrmon_data.channel_id;
+	val =3D get_unaligned_le64(&ec_dev->event_data.data.pwrmon_data.value);
+
+	scoped_guard(spinlock, &st->event_lock) {
+		if (!st->collecting)
+			return NOTIFY_OK;
+
+		if (ch < st->num_channels) {
+			st->results[ch].value =3D val;
+			st->results[ch].valid =3D true;
+		}
+
+		WRITE_ONCE(st->results_received, st->results_received + 1);
+	}
+
+	wake_up(&st->wq);
+
+	return NOTIFY_OK;
+}
+
+/*
+ * Expose ODPM results in the form of accumulated energy
+ * through the energy_value sysfs node.
+ * Format requirement:
+ * t=3D<Measurement timestamp, ms>
+ * CH<N>(T=3D<Duration, ms>)[<Schematic name>], <Accumulated Energy, uWs>
+ */
+static ssize_t energy_value_show(struct device *dev,
+				 struct device_attribute *attr,
+				 char *buf)
+{
+	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
+	struct cros_ec_pwrmon_state *st =3D iio_priv(indio_dev);
+	struct ec_params_pwrmon *params;
+	u64 current_time_ms;
+	s64 delta_uws;
+	u32 duration_ms;
+	int received;
+	ssize_t len =3D 0;
+	int ret, i;
+
+	guard(mutex)(&st->lock);
+
+	/* Reset results and prepare for MKBP events */
+	scoped_guard(spinlock, &st->event_lock) {
+		memset(st->results, 0, sizeof(st->results));
+		WRITE_ONCE(st->results_received, 0);
+		st->collecting =3D true;
+	}
+
+	/* Latch all PACs =E2=80=94 this also triggers async MKBP delivery. */
+	params =3D (struct ec_params_pwrmon *)st->msg->data;
+	params->cmd =3D EC_PWRMON_LATCH;
+	ret =3D cros_ec_cmd_xfer_status(st->ec, st->msg);
+	if (ret < 0) {
+		scoped_guard(spinlock, &st->event_lock)
+			st->collecting =3D false;
+		dev_warn(dev, "Failed to latch PAC accumulators: %d\n", ret);
+		return ret;
+	}
+
+	/* Wait for all MKBP events to arrive from the EC */
+	ret =3D wait_event_timeout(st->wq,
+				 READ_ONCE(st->results_received) >=3D st->num_channels,
+				 msecs_to_jiffies(PWRMON_MKBP_TIMEOUT_MS));
+
+	scoped_guard(spinlock, &st->event_lock) {
+		st->collecting =3D false;
+		received =3D st->results_received;
+	}
+
+	if (!ret)
+		dev_warn(dev, "Timed out waiting for PWRMON MKBP data (received %d/%d)\n=
",
+			 received, st->num_channels);
+
+	/* Timestamp of snapshot taken. */
+	current_time_ms =3D ktime_to_ms(ktime_get_boottime());
+	len +=3D sysfs_emit_at(buf, len, "t=3D%llu\n", current_time_ms);
+
+	duration_ms =3D current_time_ms - st->last_time_ms;
+
+	for (i =3D 0; i < st->num_channels; i++) {
+		if (!st->results[i].valid) {
+			dev_warn(dev, "Missing data for channel %d\n", i);
+			continue;
+		}
+
+		delta_uws =3D div_s64(st->results[i].value * duration_ms,
+				    MSEC_PER_SEC);
+		if (delta_uws > 0)
+			st->accumulated_energy[i] +=3D delta_uws;
+
+		len +=3D sysfs_emit_at(buf, len, "CH%d(T=3D%u)[%s], %llu\n",
+				     i, duration_ms, st->channel_names[i],
+				     st->accumulated_energy[i]);
+	}
+
+	st->last_time_ms =3D current_time_ms;
+
+	return len;
+}
+
+static IIO_DEVICE_ATTR(energy_value, 0444, energy_value_show, NULL, 0);
+
+static struct attribute *cros_ec_pwrmon_attrs[] =3D {
+	&iio_dev_attr_energy_value.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group cros_ec_pwrmon_attr_group =3D {
+	.attrs =3D cros_ec_pwrmon_attrs,
+};
+
+static const struct iio_info cros_ec_pwrmon_info =3D {
+	.attrs =3D &cros_ec_pwrmon_attr_group,
+};
+
+static void cros_ec_pwrmon_stop(void *data)
+{
+	struct cros_ec_pwrmon_state *st =3D data;
+	struct ec_params_pwrmon *params;
+	int ret;
+
+	guard(mutex)(&st->lock);
+
+	params =3D (struct ec_params_pwrmon *)st->msg->data;
+	params->cmd =3D EC_PWRMON_STOP;
+	ret =3D cros_ec_cmd_xfer_status(st->ec, st->msg);
+	if (ret < 0)
+		dev_warn(st->ec_dev->dev, "Failed to stop PACs: %d\n", ret);
+}
+
+static void cros_ec_pwrmon_unregister_notifier(void *data)
+{
+	struct cros_ec_pwrmon_state *st =3D data;
+
+	blocking_notifier_chain_unregister(&st->ec->event_notifier,
+					   &st->notifier);
+}
+
+static int cros_ec_pwrmon_probe(struct platform_device *pdev)
+{
+	struct device *dev =3D &pdev->dev;
+	struct cros_ec_dev *ec_dev =3D dev_get_drvdata(dev->parent);
+	struct cros_ec_pwrmon_state *st;
+	struct ec_params_pwrmon *params;
+	struct pwrmon_dump_info *dump;
+	struct iio_dev *indio_dev;
+	size_t msg_size;
+	int ret, i;
+
+	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st =3D iio_priv(indio_dev);
+	st->ec_dev =3D ec_dev;
+	st->ec =3D ec_dev->ec_dev;
+
+	spin_lock_init(&st->event_lock);
+	init_waitqueue_head(&st->wq);
+
+	ret =3D devm_mutex_init(dev, &st->lock);
+	if (ret)
+		return ret;
+
+	msg_size =3D sizeof(*st->msg) + max(sizeof(struct ec_params_pwrmon),
+					  sizeof(struct ec_response_pwrmon));
+	st->msg =3D devm_kzalloc(dev, msg_size, GFP_KERNEL);
+	if (!st->msg)
+		return -ENOMEM;
+
+	st->msg->version =3D 0;
+	st->msg->command =3D EC_CMD_PWRMON + st->ec_dev->cmd_offset;
+	params =3D (struct ec_params_pwrmon *)st->msg->data;
+	st->msg->outsize =3D sizeof(*params);
+	st->msg->insize =3D sizeof(struct ec_response_pwrmon);
+
+	/* Start PACs */
+	params->cmd =3D EC_PWRMON_START;
+	ret =3D cros_ec_cmd_xfer_status(st->ec, st->msg);
+	if (ret < 0) {
+		dev_warn(dev, "Failed to start PACs: %d\n", ret);
+		return ret;
+	}
+	st->last_time_ms =3D ktime_to_ms(ktime_get_boottime());
+
+	ret =3D devm_add_action_or_reset(dev, cros_ec_pwrmon_stop, st);
+	if (ret)
+		return ret;
+
+	/* Get Channel Count */
+	params->cmd =3D EC_PWRMON_GET_CHANNEL_COUNT;
+	ret =3D cros_ec_cmd_xfer_status(st->ec, st->msg);
+	if (ret < 0) {
+		dev_warn(dev, "Failed to get channel count: %d\n", ret);
+		return ret;
+	}
+	st->num_channels =3D ((struct ec_response_pwrmon *)st->msg->data)->channe=
l_count;
+	if (st->num_channels > PWRMON_MAX_CHANNELS)
+		st->num_channels =3D PWRMON_MAX_CHANNELS;
+
+	st->accumulated_energy =3D devm_kcalloc(dev, st->num_channels,
+					      sizeof(*st->accumulated_energy),
+					      GFP_KERNEL);
+	st->channel_names =3D devm_kcalloc(dev, st->num_channels,
+					 sizeof(*st->channel_names),
+					 GFP_KERNEL);
+	if (!st->accumulated_energy || !st->channel_names)
+		return -ENOMEM;
+
+	/* Get Dump Info (Names) */
+	for (i =3D 0; i < st->num_channels; i++) {
+		params->cmd =3D EC_PWRMON_DUMP_INFO;
+		params->channel_id =3D i;
+		ret =3D cros_ec_cmd_xfer_status(st->ec, st->msg);
+		if (ret < 0) {
+			dev_warn(dev, "Failed to get dump info for channel %d: %d\n",
+				 i, ret);
+			continue;
+		}
+		dump =3D &((struct ec_response_pwrmon *)st->msg->data)->dump_info;
+		strscpy(st->channel_names[i], dump->channel_name,
+			sizeof(st->channel_names[i]));
+	}
+
+	indio_dev->name =3D dev_name(dev);
+	indio_dev->info =3D &cros_ec_pwrmon_info;
+	indio_dev->modes =3D INDIO_DIRECT_MODE;
+
+	/* Register MKBP event notifier */
+	st->notifier.notifier_call =3D cros_ec_pwrmon_notify;
+	ret =3D blocking_notifier_chain_register(&st->ec->event_notifier,
+					       &st->notifier);
+	if (ret < 0) {
+		dev_err(dev, "Failed to register notifier: %d\n", ret);
+		return ret;
+	}
+
+	ret =3D devm_add_action_or_reset(dev, cros_ec_pwrmon_unregister_notifier,
+				       st);
+	if (ret)
+		return ret;
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static const struct platform_device_id cros_ec_pwrmon_id[] =3D {
+	{ "cros-ec-pwrmon", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(platform, cros_ec_pwrmon_id);
+
+static struct platform_driver cros_ec_pwrmon_driver =3D {
+	.driver =3D {
+		.name =3D "cros-ec-pwrmon",
+	},
+	.probe =3D cros_ec_pwrmon_probe,
+	.id_table =3D cros_ec_pwrmon_id,
+};
+module_platform_driver(cros_ec_pwrmon_driver);
+
+MODULE_AUTHOR("Daniel Balint <dbalint@google.com>");
+MODULE_DESCRIPTION("ChromeOS EC Power Monitor Driver");
+MODULE_LICENSE("GPL");
--=20
2.56.0.455.g6c5a503b38-goog

