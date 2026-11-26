Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795690121;
	b=cpCuDsnHGLuCSNh7H3vUhyQcs88ZcXquTJwg8tZqgF7bY2gbVmeZhIOPCitDRFoGxw4q
	 GExYNfU5GIuei/dvIv5hqWORL6CZBhgm/1jBn7g2zcfaritVE5HzduTYM+t4DJgXfjgxj
	 3sELHhIyhktRJ7rLJegFrg990zDXLlg2fJYr8Jd87KmYNYMzwWOgYOVdBcGmaUwJ6CSf+
	 pzu2TlwaLs8hy2vEQj7ZvsOJlmIejU4wDDNkhFjGGJjx9oBJRqRBaatG52k+GdhhfctHS
	 /pP7RGhwMUYVGpk4DUTgAFzsadA8qpf5Boh+sEezqfa9z1BxLFhKOG4nYIenlpMWbaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795690121;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=Dx62uwDHG/IPARsl6iYmyIBBzCWGWf7BQnowcox+OtY=;
	b=gXl8DvbefJj8aUU2C/bEz24uBj+wNTU9dTAAhGxGCE+jcV2VPMugOcGdkCef8/0DhgvO
	 H/GLx/rvmAwSpfNSndE9SL7TbZmUY1QhQpH2qE9BPtIw6w7MHZeDFqj8suWMAXxDvFrvK
	 u9ScLLzRpdlGU1jPWq8NX/dPco+AuQN+z/waBbBS//JW3Rvo2yl8tZhUIdyBHpRhmJ3/a
	 1fAEFAuZQL/WxP7FxLN4vDD6dUu5tAd2TfOqbTFjhaKRR3mRNm4YkNFfFwkEwj/cCdtQB
	 rJPQ5cVipQQgpyKzhvFZjRo29gCztz3UP5ipC/on4jlRBhkvRYo4zBFLfPoXp6Ip4wA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dbalint.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BxzyPFSh;
	arc=none smtp.remote-ip=209.85.208.198
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com [209.85.208.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFDE606A33E
	for <linux-iio@vger.kernel.org>; Thu, 26 Nov 2026 10:48:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8AFDE606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dbalint.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BxzyPFSh
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-3ad907ca4b3so28610861fa.0
        for <linux-iio@vger.kernel.org>; Thu, 26 Nov 2026 02:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795690119; x=1796294919; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Dx62uwDHG/IPARsl6iYmyIBBzCWGWf7BQnowcox+OtY=;
        b=BxzyPFShvSMDati+ZC6unnlOseuxWBFEcHR4Q61uLsDdU9YLHNUaAXL8jAzI5cYjvF
         ioca8FQEK/dcR25yiGlzThmZVogQY96yY4I1cT55kKbc0r39SuED4B9IhpDyPdZcXepI
         kxSUO2FtwPukpmCVdAJASARljAELUrJGW2Jc62WzGG3Vd7SzmEd0PDg1blqs2+yanD2R
         YNGhLxIuYlx2JWaix9FldJP827TsVX64Akqywl859sdjV1je8EhKeaJt9JdPJztHxSQr
         I0M3VGACscRpcLSHbEBTut9kbUXxJL2rgbBQYa3Bj91x4sV52D4FTzogWVjekVzrMWnf
         mr/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795690119; x=1796294919;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dx62uwDHG/IPARsl6iYmyIBBzCWGWf7BQnowcox+OtY=;
        b=fntFfzDUCyTV1NOunynv/YUqLaJcE/CmwSP6HDojfzOlLvCLTsT2w1S0FfVrs7cU6t
         4fabr5ElnbRts/m4Jo2vlriW8kIxYIBZuYSclKpdjjISKL93BzRKM/kZM4rDeJJkrhco
         XydGvZgGC81cCK6zTr9jsOARbVZzstdW85wAbRofsIURyZcsgaoIN3OQrjXigNdKdWTd
         yTgT6sfjxgSW3hS1oz960x0k46gpecEn2RX1AKbpgGo8vRdTrEmUESOLK6Nbe10c6+E6
         I0dCAhwtfgPyNeGRD3tkuZ4PpHeb8lERTBhuYA+wfSVOWz91MKDhy/fOpJG4mo5xHoLJ
         OvTw==
X-Gm-Message-State: APuU4Z82Z3NHvObL56UVipMeXUy9CaAfja4nq6atho0SX45iv2wCiaH7
	Ex9Kd/wKxETOZhQPBH3U7YPb3AIh89u8/Cf6C4br4eHMMC71Xo+lOYbgGh1/luVhtCpkqTs+Haz
	B0F7KWIM9QA==
X-Received: from ljmq16.prod.google.com ([2002:a2e:b4b0:0:b0:3ac:ddab:70f2])
 (user=dbalint job=prod-delivery.src-stubby-dispatcher) by 2002:a05:651c:31c5:b0:3ae:25db:8a10
 with SMTP id 38308e7fff4ca-3ae7f9f4fc4mr54153531fa.18.1795690118567; Thu, 26
 Nov 2026 02:48:38 -0800 (PST)
Date: Thu, 26 Nov 2026 10:47:56 +0000
In-Reply-To: <20261126104757.2860272-1-dbalint@google.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261126104757.2860272-1-dbalint@google.com>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
Message-ID: <20261126104757.2860272-2-dbalint@google.com>
Subject: [PATCH v2 1/2] iio: adc: add cros_ec_pwrmon driver
From: Daniel Balint <dbalint@google.com>
To: Jonathan Cameron <jic23@kernel.org>, Lee Jones <lee@kernel.org>
Cc: linux-iio@vger.kernel.org, mfd@lists.linux.dev, 
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, mwojtas@google.com, 
	Daniel Balint <dbalint@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Add the ChromeOS EC On-Device Power Monitoring (ODPM) driver to read
onboard power-monitoring ADCs (such as PAC194x) wired through the EC.

The driver interfaces with the EC via the existing EC_CMD_PWRMON host
command API and EC_MKBP_EVENT_PWRMON events to start/stop accumulation,
latch ADC accumulators, and expose cumulative per-rail energy through
IIO energy channels and a triggered buffer.

The driver is intentionally buffer-only (no single-shot RAW reads), as
EC_PWRMON_LATCH snapshots all rails simultaneously into a timestamped
frame.

Signed-off-by: Daniel Balint <dbalint@google.com>
---
 MAINTAINERS                      |   7 +
 drivers/iio/adc/Kconfig          |  13 ++
 drivers/iio/adc/Makefile         |   1 +
 drivers/iio/adc/cros_ec_pwrmon.c | 370 +++++++++++++++++++++++++++++++
 4 files changed, 391 insertions(+)
 create mode 100644 drivers/iio/adc/cros_ec_pwrmon.c

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
index a802d8ee4dd9..9b98c28fe346 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -743,6 +743,19 @@ config CPCAP_ADC
 	  This driver can also be built as a module. If so, the module will be
 	  called cpcap-adc.
=20
+config CROS_EC_PWRMON
+	tristate "ChromeOS EC Power Monitor Driver"
+	depends on MFD_CROS_EC_DEV
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
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
index 000000000000..685a713dfee2
--- /dev/null
+++ b/drivers/iio/adc/cros_ec_pwrmon.c
@@ -0,0 +1,370 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * ChromeOS EC Power Monitor Driver
+ *
+ * Copyright (c) 2026 Google Inc.
+ */
+
+#include <linux/cleanup.h>
+#include <linux/completion.h>
+#include <linux/device.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/jiffies.h>
+#include <linux/ktime.h>
+#include <linux/math64.h>
+#include <linux/minmax.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/notifier.h>
+#include <linux/platform_data/cros_ec_commands.h>
+#include <linux/platform_data/cros_ec_proto.h>
+#include <linux/platform_device.h>
+#include <linux/spinlock.h>
+#include <linux/stddef.h>
+#include <linux/string.h>
+#include <linux/sysfs.h>
+#include <linux/types.h>
+#include <linux/unaligned.h>
+
+#define PWRMON_MAX_CHANNELS 64U
+#define PWRMON_MKBP_TIMEOUT_MS 1000
+
+struct cros_ec_pwrmon_chan {
+	u64 accumulated_energy;
+	s64 latched_power;
+	bool valid;
+	char name[sizeof_field(struct pwrmon_dump_info, channel_name)];
+};
+
+struct cros_ec_pwrmon_state {
+	struct device *dev;
+	struct cros_ec_dev *ec_dev;
+	/* Serializes EC host commands and energy accumulation state */
+	struct mutex lock;
+	/* Protects MKBP event results and collection state */
+	spinlock_t event_lock;
+	struct notifier_block notifier;
+	struct completion comp;
+	struct cros_ec_pwrmon_chan *chans;
+	unsigned int num_channels;
+	unsigned int results_received;
+	bool collecting;
+	u64 last_time_ms;
+	/* Buffer for enabled channel energies plus 64-bit soft timestamp */
+	aligned_u64 scan[PWRMON_MAX_CHANNELS + 1];
+};
+
+/*
+ * MKBP event handler -- called once per channel event from the EC.
+ */
+static int cros_ec_pwrmon_notify(struct notifier_block *nb,
+				 unsigned long queued_during_suspend,
+				 void *data)
+{
+	struct cros_ec_pwrmon_state *st =3D
+		container_of(nb, struct cros_ec_pwrmon_state, notifier);
+	struct cros_ec_device *cros_ec =3D st->ec_dev->ec_dev;
+	s64 val;
+	u8 ch;
+
+	if (cros_ec->event_data.event_type !=3D EC_MKBP_EVENT_PWRMON)
+		return NOTIFY_DONE;
+
+	if (cros_ec->event_size < sizeof(cros_ec->event_data.data.pwrmon_data))
+		return NOTIFY_OK;
+
+	ch =3D cros_ec->event_data.data.pwrmon_data.channel_id;
+	val =3D get_unaligned_le64(&cros_ec->event_data.data.pwrmon_data.value);
+
+	scoped_guard(spinlock, &st->event_lock) {
+		if (!st->collecting)
+			return NOTIFY_OK;
+
+		if (ch < st->num_channels && !st->chans[ch].valid) {
+			st->chans[ch].latched_power =3D val;
+			st->chans[ch].valid =3D true;
+			st->results_received++;
+			if (st->results_received =3D=3D st->num_channels)
+				complete(&st->comp);
+		}
+	}
+
+	return NOTIFY_OK;
+}
+
+static int cros_ec_pwrmon_latch(struct iio_dev *indio_dev, s64 *timestamp_=
ns)
+{
+	struct cros_ec_pwrmon_state *st =3D iio_priv(indio_dev);
+	struct cros_ec_dev *ec_dev =3D st->ec_dev;
+	struct cros_ec_device *cros_ec =3D ec_dev->ec_dev;
+	const struct ec_params_pwrmon params =3D {
+		.cmd =3D EC_PWRMON_LATCH,
+	};
+	unsigned int received;
+	u64 current_time_ms;
+	u64 duration_ms;
+	int ret;
+
+	/* Reset results and prepare for MKBP events */
+	scoped_guard(spinlock, &st->event_lock) {
+		for (unsigned int i =3D 0; i < st->num_channels; i++)
+			st->chans[i].valid =3D false;
+		st->results_received =3D 0;
+		reinit_completion(&st->comp);
+		st->collecting =3D true;
+	}
+
+	/* Latch all PACs -- this also triggers async MKBP delivery. */
+	ret =3D cros_ec_cmd(cros_ec, 0, EC_CMD_PWRMON + ec_dev->cmd_offset,
+			  &params, sizeof(params), NULL, 0);
+	if (ret < 0) {
+		scoped_guard(spinlock, &st->event_lock)
+			st->collecting =3D false;
+		dev_warn(st->dev, "Failed to latch PAC accumulators: %d\n", ret);
+		return ret;
+	}
+
+	current_time_ms =3D ktime_to_ms(ktime_get_boottime());
+	*timestamp_ns =3D iio_get_time_ns(indio_dev);
+
+	/* Wait for all MKBP events to arrive from the EC */
+	ret =3D wait_for_completion_timeout(&st->comp,
+					  msecs_to_jiffies(PWRMON_MKBP_TIMEOUT_MS));
+
+	scoped_guard(spinlock, &st->event_lock) {
+		st->collecting =3D false;
+		received =3D st->results_received;
+	}
+
+	duration_ms =3D current_time_ms - st->last_time_ms;
+	st->last_time_ms =3D current_time_ms;
+
+	if (!ret) {
+		dev_warn(st->dev,
+			 "Timed out waiting for PWRMON MKBP data (received %u/%u)\n",
+			 received, st->num_channels);
+		return -ETIMEDOUT;
+	}
+
+	for (unsigned int i =3D 0; i < st->num_channels; i++) {
+		/* The EC reports average power in microwatts over the latch window. */
+		if (st->chans[i].latched_power <=3D 0)
+			continue;
+
+		st->chans[i].accumulated_energy +=3D
+			div_u64((u64)st->chans[i].latched_power * duration_ms,
+				MSEC_PER_SEC);
+	}
+
+	return 0;
+}
+
+static irqreturn_t cros_ec_pwrmon_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf =3D p;
+	struct iio_dev *indio_dev =3D pf->indio_dev;
+	struct cros_ec_pwrmon_state *st =3D iio_priv(indio_dev);
+	s64 timestamp_ns;
+
+	scoped_guard(mutex, &st->lock) {
+		unsigned int bit, j =3D 0;
+
+		if (!cros_ec_pwrmon_latch(indio_dev, &timestamp_ns)) {
+			iio_for_each_active_channel(indio_dev, bit)
+				st->scan[j++] =3D st->chans[bit].accumulated_energy;
+
+			iio_push_to_buffers_with_ts(indio_dev, st->scan,
+						    sizeof(st->scan),
+						    timestamp_ns);
+		}
+	}
+
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
+static int cros_ec_pwrmon_read_raw(struct iio_dev *indio_dev,
+				   struct iio_chan_spec const *chan,
+				   int *val, int *val2, long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		/* Raw accumulated energy is in microjoules (1e-6 J). */
+		*val =3D 0;
+		*val2 =3D 1;
+		return IIO_VAL_INT_PLUS_MICRO;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int cros_ec_pwrmon_read_label(struct iio_dev *indio_dev,
+				     struct iio_chan_spec const *chan,
+				     char *label)
+{
+	struct cros_ec_pwrmon_state *st =3D iio_priv(indio_dev);
+
+	if (!st->chans[chan->channel].name[0])
+		return -EINVAL;
+
+	return sysfs_emit(label, "%s\n", st->chans[chan->channel].name);
+}
+
+static const struct iio_info cros_ec_pwrmon_info =3D {
+	.read_raw =3D cros_ec_pwrmon_read_raw,
+	.read_label =3D cros_ec_pwrmon_read_label,
+};
+
+static void cros_ec_pwrmon_stop(void *data)
+{
+	struct cros_ec_pwrmon_state *st =3D data;
+	struct cros_ec_dev *ec_dev =3D st->ec_dev;
+	struct cros_ec_device *cros_ec =3D ec_dev->ec_dev;
+	const struct ec_params_pwrmon params =3D {
+		.cmd =3D EC_PWRMON_STOP,
+	};
+	int ret;
+
+	guard(mutex)(&st->lock);
+
+	ret =3D cros_ec_cmd(cros_ec, 0, EC_CMD_PWRMON + ec_dev->cmd_offset,
+			  &params, sizeof(params), NULL, 0);
+	if (ret < 0)
+		dev_warn(st->dev, "Failed to stop PACs: %d\n", ret);
+}
+
+static int cros_ec_pwrmon_probe(struct platform_device *pdev)
+{
+	struct device *dev =3D &pdev->dev;
+	struct cros_ec_dev *ec_dev =3D dev_get_drvdata(dev->parent);
+	struct cros_ec_device *cros_ec =3D ec_dev->ec_dev;
+	struct ec_params_pwrmon params =3D {};
+	struct ec_response_pwrmon resp;
+	struct cros_ec_pwrmon_state *st;
+	struct iio_chan_spec *iio_chans;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st =3D iio_priv(indio_dev);
+	st->dev =3D dev;
+	st->ec_dev =3D ec_dev;
+
+	spin_lock_init(&st->event_lock);
+	init_completion(&st->comp);
+
+	ret =3D devm_mutex_init(dev, &st->lock);
+	if (ret)
+		return ret;
+
+	/* Start power accumulators */
+	params.cmd =3D EC_PWRMON_START;
+	ret =3D cros_ec_cmd(cros_ec, 0, EC_CMD_PWRMON + ec_dev->cmd_offset,
+			  &params, sizeof(params), NULL, 0);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to start PACs\n");
+	st->last_time_ms =3D ktime_to_ms(ktime_get_boottime());
+
+	ret =3D devm_add_action_or_reset(dev, cros_ec_pwrmon_stop, st);
+	if (ret)
+		return ret;
+
+	/* Get Channel Count */
+	params.cmd =3D EC_PWRMON_GET_CHANNEL_COUNT;
+	ret =3D cros_ec_cmd(cros_ec, 0, EC_CMD_PWRMON + ec_dev->cmd_offset,
+			  &params, sizeof(params), &resp, sizeof(resp));
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to get channel count\n");
+
+	st->num_channels =3D min(resp.channel_count, PWRMON_MAX_CHANNELS);
+	if (!st->num_channels)
+		return dev_err_probe(dev, -ENODEV, "No power monitor channels\n");
+
+	st->chans =3D devm_kcalloc(dev, st->num_channels, sizeof(*st->chans),
+				 GFP_KERNEL);
+	if (!st->chans)
+		return -ENOMEM;
+
+	iio_chans =3D devm_kcalloc(dev, st->num_channels + 1, sizeof(*iio_chans),
+				 GFP_KERNEL);
+	if (!iio_chans)
+		return -ENOMEM;
+
+	/* Get Dump Info (Names) */
+	for (unsigned int i =3D 0; i < st->num_channels; i++) {
+		iio_chans[i].type =3D IIO_ENERGY;
+		iio_chans[i].indexed =3D 1;
+		iio_chans[i].channel =3D i;
+		iio_chans[i].info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE);
+		iio_chans[i].scan_index =3D i;
+		iio_chans[i].scan_type.sign =3D 'u';
+		iio_chans[i].scan_type.realbits =3D 64;
+		iio_chans[i].scan_type.storagebits =3D 64;
+		iio_chans[i].scan_type.endianness =3D IIO_CPU;
+
+		params.cmd =3D EC_PWRMON_DUMP_INFO;
+		params.channel_id =3D i;
+		ret =3D cros_ec_cmd(cros_ec, 0,
+				  EC_CMD_PWRMON + ec_dev->cmd_offset,
+				  &params, sizeof(params), &resp, sizeof(resp));
+		if (ret < 0) {
+			dev_warn(dev, "Failed to get dump info for channel %u: %d\n",
+				 i, ret);
+			continue;
+		}
+		strscpy(st->chans[i].name, resp.dump_info.channel_name,
+			sizeof(st->chans[i].name));
+	}
+	iio_chans[st->num_channels] =3D IIO_CHAN_SOFT_TIMESTAMP(st->num_channels)=
;
+
+	indio_dev->name =3D "cros-ec-pwrmon";
+	indio_dev->info =3D &cros_ec_pwrmon_info;
+	indio_dev->channels =3D iio_chans;
+	indio_dev->num_channels =3D st->num_channels + 1;
+
+	ret =3D iio_device_set_clock(indio_dev, CLOCK_BOOTTIME);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to set timestamp clock\n");
+
+	/* Register MKBP event notifier */
+	st->notifier.notifier_call =3D cros_ec_pwrmon_notify;
+	ret =3D devm_blocking_notifier_chain_register(dev,
+						    &cros_ec->event_notifier,
+						    &st->notifier);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to register notifier\n");
+
+	ret =3D devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
+					      cros_ec_pwrmon_trigger_handler,
+					      NULL);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to setup triggered buffer\n");
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static const struct platform_device_id cros_ec_pwrmon_id[] =3D {
+	{ .name =3D "cros-ec-pwrmon" },
+	{ }
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
2.56.1.839.g22a8290db9-goog

