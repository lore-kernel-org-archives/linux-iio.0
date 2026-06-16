Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB33D39D3FD
	for <linux-iio@vger.kernel.org>; Tue, 16 Jun 2026 07:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781594618; cv=none; b=ng3jDm0BEogAnba522filEmPOm2ctkLEybjkMwU8WK8hihoW3WBZT/gYghzWmWnaE7heQUIDXVhubdCfSqEnQujxbA67MamnBjkQBwNfjJavZFQlGAqVuwfegZJmBAWARJFSfZPAIXsF5exB3BNroUThhdpzVuJNmoiPc2824xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781594618; c=relaxed/simple;
	bh=Tme9z3mIXkm35+ePESeO41NS2j/ffqS1F5extxkLogk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MqExuXNpMiIZ1KcBlmg7z24wUABzDgHV6s/a7xC53PGI5OtBb1lZUXbwzGIOJhCH7ogXSd1gNurwrgaAzmKQzmoiwIIEqnuss8J52nqjV7j2KNYYTWTtH6z0+MfSpzHLyOrWXvQqgqjPpzseeYgP0I+mc5+p8T9cxMTN2AkrJU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GVyqwcV4; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GVyqwcV4"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2bf1f074a12so42287095ad.0
        for <linux-iio@vger.kernel.org>; Tue, 16 Jun 2026 00:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781594616; x=1782199416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ICSW38N/nkIf6ONbEjMymd0LuEL8QR8iT3f8hKuxAd4=;
        b=GVyqwcV4hFLR25kAenYx2xWD/0X9kr4ERpPPescXP6pA3ZrXpXVycVuRJu/yz9IPGh
         mDmKlKEB9ZNvB5jsAro0MH8NIZj1yHa3UN2RHq8T0OwpVYOk1vp1cROgoGUAyta2W3f9
         hweQke6fV5PDrVuCbQIep33CESn74yg8qZnu8+tO9CgY36m5q3DtVkvQZZvv5B4mjUG1
         Tdtj5flKuhbQApDws27epEqddpcRvDEjwrpdXvDR3eAXONNnfzKzL3LqiL3O7vWUU11n
         SMnpuzDZo4SbEdMnfDPJ0GtII77gdw+TEpie4mg0NEHLWLBzP7iFRrMaKWSeaoUmb8Jt
         bMow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781594616; x=1782199416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ICSW38N/nkIf6ONbEjMymd0LuEL8QR8iT3f8hKuxAd4=;
        b=orCHKZ8VwFF1zrl6pgHjPOrSrDdoD2hTnjab2g87X2agURxQYKzY1X9/nZVwgxPkO3
         wTgh2EmNtGPyGNJ8+frTndITXjT8gdvblorkx4ttNa9DHiRpt2fnjeYJvG1PXmUDKEWv
         H1IbZT+BYkSgoaTG7vXGH1n3fr2+OsaC4HYSwUgsAxKr2lVbDg6khjbvPgkslbzipnVe
         jaG+/L90Sate3LdEHbsVTL8CXLSS4fsVylKcy9p3eP2eljNubOfcWfGxPx9UuOumEqlQ
         8whZRLYlsplmnI1kpHzW2HjY/+bIhdV4xmCyx6bAFFCySh+H6/1MoAvDYOx1e8a3IbsR
         9o2Q==
X-Forwarded-Encrypted: i=1; AFNElJ9dcRvxPdeD7bjXwX1AqT3hse9uFxQH4Bn19nVeyhpjD6ZO1OPLqqqF4i1h6yX9vVksS4FXET7bi48=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0p4I4Qpt/Y0lfyp4OjJ2fYFo3HHp6CnZ9Za8NnKJBxDYGfzST
	ysqDJBzw7J6XLFBgWlUGy3ASbgepwniHQGKDNiym08NVue0t7bEyTiM4
X-Gm-Gg: Acq92OFyjNYPyHmbFyFoQ3h9m78+YNGPFLZNxR6irthR1D0tIEEHssWdICHB2h4Di5H
	drmI16bZXKAJQS0Tw4Gpv5W8wbnVprwmGPcW0KtFr6SxY2zovvvpH+PXor4a5S8ODSn2D/ysDM7
	xFC28rzhMEbFY1q0ZCt4+MgCqv4YQLw2qqOJStS/W2KFsxOVB5kHbi/2ww2U5u7xz+QUv7kEU5Z
	gKwJaiQph/AGo2wiepgKRBiFJvX45RlE09do7mWv4425qp508pihonpxj8dMAqcX8NZckDxe67k
	gdSb856Ys28FgfGD9srQ4ZUq2zF+6383cqIR8/jFv1wVBuMUM3euW6gK86sF680vBCtXS1KhszQ
	LPfSzcIdLkY/W7miAJsVIxeOyZeikVKcg967rHzT9sVaXIGf66DWnB0PHZRb320dKEIJlyThZcH
	PTKCErAX/Jqp8oJpCBkoJMZR/rla4HepN3r1nS2ICzJ2Ls4kG3xPLmwk0Jx+4KWfEilzebxfZRx
	Gkgy7MOXoCfMhpKOB1X3pkIKYKyPQQsOelCfHY=
X-Received: by 2002:a17:903:1ae7:b0:2c0:af09:f3c7 with SMTP id d9443c01a7336-2c69a1b08eamr26011765ad.30.1781594615960;
        Tue, 16 Jun 2026 00:23:35 -0700 (PDT)
Received: from DESKTOP-G3E0OSP.localdomain ([112.172.255.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c42f1f1014sm123513435ad.16.2026.06.16.00.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 00:23:35 -0700 (PDT)
From: Jinseob Kim <kimjinseob88@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jinseob Kim <kimjinseob88@gmail.com>
Subject: [PATCH RFC v5 6/6] iio: osf: register IIO devices from capabilities
Date: Tue, 16 Jun 2026 16:22:42 +0900
Message-ID: <20260616072242.3942-7-kimjinseob88@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616072242.3942-1-kimjinseob88@gmail.com>
References: <20260616072242.3942-1-kimjinseob88@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Register IIO devices for supported Open Sensor Fusion capability entries
and push received samples into IIO buffers when enabled.

Signed-off-by: Jinseob Kim <kimjinseob88@gmail.com>
---
 drivers/iio/opensensorfusion/Kconfig    |  11 +-
 drivers/iio/opensensorfusion/Makefile   |   3 +-
 drivers/iio/opensensorfusion/osf_core.c | 253 ++++++++++++++++++++--
 drivers/iio/opensensorfusion/osf_core.h |  52 +++++
 drivers/iio/opensensorfusion/osf_iio.c  | 275 ++++++++++++++++++++++++
 drivers/iio/opensensorfusion/osf_iio.h  |  22 ++
 6 files changed, 586 insertions(+), 30 deletions(-)
 create mode 100644 drivers/iio/opensensorfusion/osf_iio.c
 create mode 100644 drivers/iio/opensensorfusion/osf_iio.h

diff --git a/drivers/iio/opensensorfusion/Kconfig b/drivers/iio/opensensorfusion/Kconfig
index d393eb3aa..8b9376d28 100644
--- a/drivers/iio/opensensorfusion/Kconfig
+++ b/drivers/iio/opensensorfusion/Kconfig
@@ -5,11 +5,10 @@ config OPEN_SENSOR_FUSION
 	depends on IIO
 	depends on SERIAL_DEV_BUS
 	select CRC32
+	select IIO_BUFFER
+	select IIO_KFIFO_BUF
 	help
-	  Build the Open Sensor Fusion UART receive path.
+	  Build the Open Sensor Fusion UART IIO driver.
 
-	  The driver receives OSF protocol frames over a serdev UART.
-	  Frames are decoded and validated before being passed to the
-	  driver core.
-	  This patch only adds the transport path.
-	  IIO device registration is added separately.
+	  The driver receives OSF protocol frames over a serdev UART and
+	  registers IIO devices for supported capability entries.
diff --git a/drivers/iio/opensensorfusion/Makefile b/drivers/iio/opensensorfusion/Makefile
index 940c82edd..b4e03b80c 100644
--- a/drivers/iio/opensensorfusion/Makefile
+++ b/drivers/iio/opensensorfusion/Makefile
@@ -2,4 +2,5 @@
 
 obj-$(CONFIG_OPEN_SENSOR_FUSION) += open-sensor-fusion.o
 
-open-sensor-fusion-y := osf_core.o osf_protocol.o osf_serdev.o osf_stream.o
+open-sensor-fusion-y := osf_core.o osf_iio.o osf_protocol.o osf_serdev.o \
+			 osf_stream.o
diff --git a/drivers/iio/opensensorfusion/osf_core.c b/drivers/iio/opensensorfusion/osf_core.c
index 137fb7166..61ef55646 100644
--- a/drivers/iio/opensensorfusion/osf_core.c
+++ b/drivers/iio/opensensorfusion/osf_core.c
@@ -5,7 +5,7 @@
 #include <linux/types.h>
 
 #include "osf_core.h"
-#include "osf_protocol.h"
+#include "osf_iio.h"
 
 #define OSF_RESERVED_MSG_FIRST		0x7f00
 #define OSF_RESERVED_MSG_LAST		0x7fff
@@ -13,31 +13,198 @@
 
 void osf_core_init(struct osf_device *osf, struct device *dev)
 {
-	memset(osf, 0, sizeof(*osf));
+	mutex_init(&osf->latest_lock);
 	osf->dev = dev;
 }
 
 void osf_core_unregister_iio(struct osf_device *osf)
 {
+	unsigned int i;
+
+	for (i = 0; i < osf->iio_dev_count; i++)
+		osf_iio_unregister_sensor(osf->iio_devs[i].indio_dev);
+
+	osf->iio_dev_count = 0;
+}
+
+static struct iio_dev *osf_core_find_iio_dev(struct osf_device *osf,
+					     u16 sensor_type, u16 sensor_index)
+{
+	const struct osf_iio_binding *binding;
+	unsigned int i;
+
+	for (i = 0; i < osf->iio_dev_count; i++) {
+		binding = &osf->iio_devs[i];
+		if (binding->sensor_type == sensor_type &&
+		    binding->sensor_index == sensor_index)
+			return binding->indio_dev;
+	}
+
+	return NULL;
+}
+
+static struct osf_latest_sample *
+osf_core_find_latest_sample(struct osf_device *osf, u16 sensor_type,
+			    u16 sensor_index)
+{
+	struct osf_latest_sample *latest;
+	unsigned int i;
+
+	for (i = 0; i < osf->latest_sample_count; i++) {
+		latest = &osf->latest_samples[i];
+		if (latest->sensor_type == sensor_type &&
+		    latest->sensor_index == sensor_index)
+			return latest;
+	}
+
+	if (osf->latest_sample_count >= OSF_MAX_CAPABILITIES)
+		return NULL;
+
+	return &osf->latest_samples[osf->latest_sample_count++];
+}
+
+static bool osf_core_capability_is_duplicate(const struct osf_capability_cache *cache,
+					     unsigned int index)
+{
+	const struct osf_capability_entry *entry = &cache->entries[index];
+	unsigned int i;
+
+	for (i = 0; i < index; i++) {
+		if (!osf_iio_sensor_supported(cache->entries[i].sensor_type,
+					      cache->entries[i].channel_count))
+			continue;
+
+		if (cache->entries[i].sensor_type == entry->sensor_type &&
+		    cache->entries[i].sensor_index == entry->sensor_index)
+			return true;
+	}
+
+	return false;
 }
 
-static int osf_core_validate_sensor_sample(const struct osf_frame *frame)
+static int osf_core_register_capabilities(struct osf_device *osf,
+					  const struct osf_capability_cache *cache)
 {
+	struct iio_dev *indio_dev;
+	unsigned int i;
+	int ret;
+
+	if (osf->capability_cache.valid)
+		return 0;
+
+	for (i = 0; i < cache->capability_count; i++) {
+		if (!osf_iio_sensor_supported(cache->entries[i].sensor_type,
+					      cache->entries[i].channel_count))
+			continue;
+
+		if (osf_core_capability_is_duplicate(cache, i))
+			return -EEXIST;
+	}
+
+	for (i = 0; i < cache->capability_count; i++) {
+		if (!osf_iio_sensor_supported(cache->entries[i].sensor_type,
+					      cache->entries[i].channel_count))
+			continue;
+
+		ret = osf_iio_register_sensor(osf->dev, &cache->entries[i],
+					      osf, &indio_dev);
+		if (ret)
+			goto err_unregister;
+
+		osf->iio_devs[osf->iio_dev_count].sensor_type =
+			cache->entries[i].sensor_type;
+		osf->iio_devs[osf->iio_dev_count].sensor_index =
+			cache->entries[i].sensor_index;
+		osf->iio_devs[osf->iio_dev_count].indio_dev = indio_dev;
+		osf->iio_dev_count++;
+	}
+
+	return 0;
+
+err_unregister:
+	osf_core_unregister_iio(osf);
+
+	return ret;
+}
+
+static int osf_core_handle_sensor_sample(struct osf_device *osf,
+					 const struct osf_frame *frame)
+{
+	struct osf_latest_sample *latest;
 	struct osf_sensor_sample sample;
+	struct iio_dev *indio_dev;
+	s32 values[OSF_MAX_SAMPLE_CHANNELS] = { };
+	unsigned int i;
+	int ret;
+
+	ret = osf_protocol_decode_sensor_sample(frame, &sample);
+	if (ret)
+		return ret;
+
+	if (sample.channel_count > OSF_MAX_SAMPLE_CHANNELS)
+		return -E2BIG;
+
+	for (i = 0; i < sample.channel_count; i++) {
+		ret = osf_protocol_sensor_sample_value(&sample, i, &values[i]);
+		if (ret)
+			return ret;
+	}
 
-	return osf_protocol_decode_sensor_sample(frame, &sample);
+	mutex_lock(&osf->latest_lock);
+	latest = osf_core_find_latest_sample(osf, sample.sensor_type,
+					     sample.sensor_index);
+	if (!latest) {
+		mutex_unlock(&osf->latest_lock);
+		return -E2BIG;
+	}
+
+	memcpy(latest->values, values, sizeof(values));
+	latest->sensor_type = sample.sensor_type;
+	latest->sensor_index = sample.sensor_index;
+	latest->channel_count = sample.channel_count;
+	latest->sample_format = sample.sample_format;
+	latest->scale_nano = sample.scale_nano;
+	latest->sequence = frame->sequence;
+	latest->timestamp_us = frame->timestamp_us;
+	latest->valid = true;
+	osf->last_sequence = frame->sequence;
+	mutex_unlock(&osf->latest_lock);
+
+	indio_dev = osf_core_find_iio_dev(osf, sample.sensor_type,
+					  sample.sensor_index);
+	if (!indio_dev)
+		return 0;
+
+	return osf_iio_push_sample(indio_dev, values, sample.channel_count);
 }
 
-static int osf_core_validate_device_status(const struct osf_frame *frame)
+static int osf_core_handle_device_status(struct osf_device *osf,
+					 const struct osf_frame *frame)
 {
+	struct osf_status_cache cache = { };
 	struct osf_device_status status;
+	int ret;
 
-	return osf_protocol_decode_device_status(frame, &status);
+	ret = osf_protocol_decode_device_status(frame, &status);
+	if (ret)
+		return ret;
+
+	cache.uptime_s = status.uptime_s;
+	cache.status_flags = status.status_flags;
+	cache.error_flags = status.error_flags;
+	cache.dropped_frames = status.dropped_frames;
+	cache.sequence = frame->sequence;
+	cache.valid = true;
+	osf->status_cache = cache;
+	osf->last_sequence = frame->sequence;
+
+	return 0;
 }
 
-static int osf_core_validate_capability_report(const struct osf_frame *frame)
+static int osf_core_handle_capability_report(struct osf_device *osf,
+					     const struct osf_frame *frame)
 {
-	struct osf_capability_entry entry;
+	struct osf_capability_cache cache = { };
 	struct osf_capability_report report;
 	unsigned int i;
 	int ret;
@@ -46,12 +213,32 @@ static int osf_core_validate_capability_report(const struct osf_frame *frame)
 	if (ret)
 		return ret;
 
+	if (report.capability_count > OSF_MAX_CAPABILITIES)
+		return -E2BIG;
+
+	if (osf->capability_cache.valid) {
+		osf->last_sequence = frame->sequence;
+		return 0;
+	}
+
 	for (i = 0; i < report.capability_count; i++) {
-		ret = osf_protocol_decode_capability_entry(&report, i, &entry);
+		ret = osf_protocol_decode_capability_entry(&report, i,
+							   &cache.entries[i]);
 		if (ret)
 			return ret;
 	}
 
+	cache.capability_count = report.capability_count;
+	cache.sequence = frame->sequence;
+	cache.valid = true;
+
+	ret = osf_core_register_capabilities(osf, &cache);
+	if (ret)
+		return ret;
+
+	osf->capability_cache = cache;
+	osf->last_sequence = frame->sequence;
+
 	return 0;
 }
 
@@ -73,27 +260,47 @@ int osf_core_receive_frame(struct osf_device *osf, const u8 *buf, size_t len)
 
 	switch (frame.message_type) {
 	case OSF_MSG_SENSOR_SAMPLE:
-		ret = osf_core_validate_sensor_sample(&frame);
-		break;
+		return osf_core_handle_sensor_sample(osf, &frame);
 	case OSF_MSG_DEVICE_STATUS:
-		ret = osf_core_validate_device_status(&frame);
-		break;
+		return osf_core_handle_device_status(osf, &frame);
 	case OSF_MSG_CAPABILITY_REPORT:
-		ret = osf_core_validate_capability_report(&frame);
-		break;
+		return osf_core_handle_capability_report(osf, &frame);
 	default:
 		if (frame.message_type >= OSF_RESERVED_MSG_FIRST &&
 		    frame.message_type <= OSF_RESERVED_MSG_LAST)
-			ret = 0;
-		else if (frame.message_type >= OSF_VENDOR_PRIVATE_FIRST)
-			ret = 0;
-		else
-			ret = -EOPNOTSUPP;
-		break;
+			return 0;
+		if (frame.message_type >= OSF_VENDOR_PRIVATE_FIRST)
+			return 0;
+		return -EOPNOTSUPP;
 	}
+}
+
+int osf_core_read_latest_sample(struct osf_device *osf, u16 sensor_type,
+				u16 sensor_index, unsigned int channel,
+				s32 *value)
+{
+	const struct osf_latest_sample *latest;
+	unsigned int i;
+	int ret = -ENODATA;
+
+	if (!osf || !value)
+		return -EINVAL;
+
+	mutex_lock(&osf->latest_lock);
+	for (i = 0; i < osf->latest_sample_count; i++) {
+		latest = &osf->latest_samples[i];
+		if (latest->sensor_type != sensor_type ||
+		    latest->sensor_index != sensor_index)
+			continue;
+
+		if (!latest->valid || channel >= latest->channel_count)
+			break;
 
-	if (!ret)
-		osf->last_sequence = frame.sequence;
+		*value = latest->values[channel];
+		ret = 0;
+		break;
+	}
+	mutex_unlock(&osf->latest_lock);
 
 	return ret;
 }
diff --git a/drivers/iio/opensensorfusion/osf_core.h b/drivers/iio/opensensorfusion/osf_core.h
index 3680c8c9b..04dd2a367 100644
--- a/drivers/iio/opensensorfusion/osf_core.h
+++ b/drivers/iio/opensensorfusion/osf_core.h
@@ -2,17 +2,69 @@
 #ifndef _OSF_CORE_H
 #define _OSF_CORE_H
 
+#include <linux/mutex.h>
 #include <linux/types.h>
 
+#include "osf_protocol.h"
+
+#define OSF_MAX_SAMPLE_CHANNELS	3
+#define OSF_MAX_CAPABILITIES	16
+
 struct device;
+struct iio_dev;
+
+struct osf_latest_sample {
+	u16 sensor_type;
+	u16 sensor_index;
+	u16 channel_count;
+	u16 sample_format;
+	u32 scale_nano;
+	s32 values[OSF_MAX_SAMPLE_CHANNELS];
+	u64 sequence;
+	u64 timestamp_us;
+	bool valid;
+};
+
+struct osf_capability_cache {
+	u16 capability_count;
+	struct osf_capability_entry entries[OSF_MAX_CAPABILITIES];
+	u64 sequence;
+	bool valid;
+};
+
+struct osf_status_cache {
+	u32 uptime_s;
+	u32 status_flags;
+	u32 error_flags;
+	u32 dropped_frames;
+	u64 sequence;
+	bool valid;
+};
+
+struct osf_iio_binding {
+	u16 sensor_type;
+	u16 sensor_index;
+	struct iio_dev *indio_dev;
+};
 
 struct osf_device {
 	struct device *dev;
+	/* Protects latest_samples and latest_sample_count. */
+	struct mutex latest_lock;
+	struct osf_latest_sample latest_samples[OSF_MAX_CAPABILITIES];
+	unsigned int latest_sample_count;
+	struct osf_capability_cache capability_cache;
+	struct osf_status_cache status_cache;
+	struct osf_iio_binding iio_devs[OSF_MAX_CAPABILITIES];
+	unsigned int iio_dev_count;
 	u64 last_sequence;
 };
 
 void osf_core_init(struct osf_device *osf, struct device *dev);
 void osf_core_unregister_iio(struct osf_device *osf);
 int osf_core_receive_frame(struct osf_device *osf, const u8 *buf, size_t len);
+int osf_core_read_latest_sample(struct osf_device *osf, u16 sensor_type,
+				u16 sensor_index, unsigned int channel,
+				s32 *value);
 
 #endif
diff --git a/drivers/iio/opensensorfusion/osf_iio.c b/drivers/iio/opensensorfusion/osf_iio.c
new file mode 100644
index 000000000..862a797f4
--- /dev/null
+++ b/drivers/iio/opensensorfusion/osf_iio.c
@@ -0,0 +1,275 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/array_size.h>
+#include <linux/bitops.h>
+#include <linux/errno.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/kfifo_buf.h>
+#include <linux/types.h>
+#include <linux/units.h>
+
+#include "osf_core.h"
+#include "osf_iio.h"
+
+struct osf_iio_sensor_spec {
+	u16 sensor_type;
+	u16 channel_count;
+	const char *name;
+	const struct iio_chan_spec *channels;
+	unsigned int num_channels;
+	const unsigned long *available_scan_masks;
+};
+
+struct osf_iio_state {
+	const struct osf_iio_sensor_spec *spec;
+	struct iio_buffer *buffer;
+	u32 scale_nano;
+	u16 sensor_index;
+	struct osf_device *osf;
+};
+
+#define OSF_SCAN_TYPE_S32						\
+	{								\
+		.sign = 's',						\
+		.realbits = 32,					\
+		.storagebits = 32,					\
+		.endianness = IIO_CPU,					\
+	}
+
+#define OSF_MOD_CHAN(_type, _mod, _idx)				\
+	{								\
+		.type = (_type),					\
+		.modified = 1,					\
+		.channel2 = (_mod),					\
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
+		.scan_index = (_idx),					\
+		.scan_type = OSF_SCAN_TYPE_S32,			\
+	}
+
+#define OSF_CHAN(_type, _idx)					\
+	{								\
+		.type = (_type),					\
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
+		.scan_index = (_idx),					\
+		.scan_type = OSF_SCAN_TYPE_S32,			\
+	}
+
+static const struct iio_chan_spec osf_accel_channels[] = {
+	OSF_MOD_CHAN(IIO_ACCEL, IIO_MOD_X, 0),
+	OSF_MOD_CHAN(IIO_ACCEL, IIO_MOD_Y, 1),
+	OSF_MOD_CHAN(IIO_ACCEL, IIO_MOD_Z, 2),
+	IIO_CHAN_SOFT_TIMESTAMP(3),
+};
+
+static const struct iio_chan_spec osf_gyro_channels[] = {
+	OSF_MOD_CHAN(IIO_ANGL_VEL, IIO_MOD_X, 0),
+	OSF_MOD_CHAN(IIO_ANGL_VEL, IIO_MOD_Y, 1),
+	OSF_MOD_CHAN(IIO_ANGL_VEL, IIO_MOD_Z, 2),
+	IIO_CHAN_SOFT_TIMESTAMP(3),
+};
+
+static const struct iio_chan_spec osf_mag_channels[] = {
+	OSF_MOD_CHAN(IIO_MAGN, IIO_MOD_X, 0),
+	OSF_MOD_CHAN(IIO_MAGN, IIO_MOD_Y, 1),
+	OSF_MOD_CHAN(IIO_MAGN, IIO_MOD_Z, 2),
+	IIO_CHAN_SOFT_TIMESTAMP(3),
+};
+
+static const struct iio_chan_spec osf_temp_channels[] = {
+	OSF_CHAN(IIO_TEMP, 0),
+	IIO_CHAN_SOFT_TIMESTAMP(1),
+};
+
+static const unsigned long osf_3axis_available_scan_masks[] = {
+	GENMASK(2, 0),
+	0
+};
+
+static const struct osf_iio_sensor_spec osf_iio_sensor_specs[] = {
+	{
+		.sensor_type = OSF_SENSOR_ACCELEROMETER,
+		.channel_count = 3,
+		.name = "osf-accel",
+		.channels = osf_accel_channels,
+		.num_channels = ARRAY_SIZE(osf_accel_channels),
+		.available_scan_masks = osf_3axis_available_scan_masks,
+	},
+	{
+		.sensor_type = OSF_SENSOR_GYROSCOPE,
+		.channel_count = 3,
+		.name = "osf-gyro",
+		.channels = osf_gyro_channels,
+		.num_channels = ARRAY_SIZE(osf_gyro_channels),
+		.available_scan_masks = osf_3axis_available_scan_masks,
+	},
+	{
+		.sensor_type = OSF_SENSOR_MAGNETOMETER,
+		.channel_count = 3,
+		.name = "osf-magn",
+		.channels = osf_mag_channels,
+		.num_channels = ARRAY_SIZE(osf_mag_channels),
+		.available_scan_masks = osf_3axis_available_scan_masks,
+	},
+	{
+		.sensor_type = OSF_SENSOR_TEMPERATURE,
+		.channel_count = 1,
+		.name = "osf-temp",
+		.channels = osf_temp_channels,
+		.num_channels = ARRAY_SIZE(osf_temp_channels),
+	},
+};
+
+static const struct osf_iio_sensor_spec *
+osf_iio_find_sensor_spec(u16 sensor_type, u16 channel_count)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(osf_iio_sensor_specs); i++) {
+		if (osf_iio_sensor_specs[i].sensor_type == sensor_type &&
+		    osf_iio_sensor_specs[i].channel_count == channel_count)
+			return &osf_iio_sensor_specs[i];
+	}
+
+	return NULL;
+}
+
+bool osf_iio_sensor_supported(u16 sensor_type, u16 channel_count)
+{
+	return !!osf_iio_find_sensor_spec(sensor_type, channel_count);
+}
+
+const char *osf_iio_sensor_name(u16 sensor_type)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(osf_iio_sensor_specs); i++) {
+		if (osf_iio_sensor_specs[i].sensor_type == sensor_type)
+			return osf_iio_sensor_specs[i].name;
+	}
+
+	return NULL;
+}
+
+static int osf_iio_read_raw(struct iio_dev *indio_dev,
+			    const struct iio_chan_spec *chan, int *val,
+			    int *val2, long mask)
+{
+	struct osf_iio_state *state = iio_priv(indio_dev);
+	s32 raw;
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = osf_core_read_latest_sample(state->osf,
+						  state->spec->sensor_type,
+						  state->sensor_index,
+						  chan->scan_index, &raw);
+		if (ret)
+			return ret;
+
+		*val = raw;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		*val = state->scale_nano / NANO;
+		*val2 = state->scale_nano % NANO;
+		return IIO_VAL_INT_PLUS_NANO;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info osf_iio_info = {
+	.read_raw = osf_iio_read_raw,
+};
+
+int osf_iio_register_sensor(struct device *dev,
+			    const struct osf_capability_entry *entry,
+			    struct osf_device *osf, struct iio_dev **indio_dev)
+{
+	const struct osf_iio_sensor_spec *spec;
+	struct osf_iio_state *state;
+	struct iio_dev *iio_dev;
+	int ret;
+
+	spec = osf_iio_find_sensor_spec(entry->sensor_type,
+					entry->channel_count);
+	if (!spec)
+		return -EOPNOTSUPP;
+
+	if (entry->sample_format != OSF_SAMPLE_FORMAT_S32)
+		return -EOPNOTSUPP;
+
+	iio_dev = iio_device_alloc(dev, sizeof(*state));
+	if (!iio_dev)
+		return -ENOMEM;
+
+	state = iio_priv(iio_dev);
+	state->spec = spec;
+	state->scale_nano = entry->scale_nano;
+	state->sensor_index = entry->sensor_index;
+	state->osf = osf;
+
+	iio_dev->name = spec->name;
+	iio_dev->info = &osf_iio_info;
+	iio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;
+	iio_dev->channels = spec->channels;
+	iio_dev->num_channels = spec->num_channels;
+	iio_dev->available_scan_masks = spec->available_scan_masks;
+
+	state->buffer = iio_kfifo_allocate();
+	if (!state->buffer) {
+		ret = -ENOMEM;
+		goto err_free_iio;
+	}
+
+	ret = iio_device_attach_buffer(iio_dev, state->buffer);
+	if (ret)
+		goto err_free_buffer;
+
+	ret = iio_device_register(iio_dev);
+	if (ret)
+		goto err_free_buffer;
+
+	*indio_dev = iio_dev;
+
+	return 0;
+
+err_free_buffer:
+	iio_kfifo_free(state->buffer);
+err_free_iio:
+	iio_device_free(iio_dev);
+
+	return ret;
+}
+
+void osf_iio_unregister_sensor(struct iio_dev *indio_dev)
+{
+	struct osf_iio_state *state = iio_priv(indio_dev);
+
+	iio_device_unregister(indio_dev);
+	iio_kfifo_free(state->buffer);
+	iio_device_free(indio_dev);
+}
+
+int osf_iio_push_sample(struct iio_dev *indio_dev, const s32 *values,
+			unsigned int channel_count)
+{
+	struct osf_iio_state *state = iio_priv(indio_dev);
+	s64 timestamp;
+
+	if (channel_count != state->spec->channel_count)
+		return -EPROTO;
+
+	/* This is only a fast path; IIO rechecks buffer state while pushing. */
+	if (!iio_buffer_enabled(indio_dev))
+		return 0;
+
+	timestamp = iio_get_time_ns(indio_dev);
+
+	return iio_push_to_buffers_with_ts_unaligned(indio_dev, values,
+						     channel_count * sizeof(*values),
+						     timestamp);
+}
diff --git a/drivers/iio/opensensorfusion/osf_iio.h b/drivers/iio/opensensorfusion/osf_iio.h
new file mode 100644
index 000000000..d90c58fc4
--- /dev/null
+++ b/drivers/iio/opensensorfusion/osf_iio.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _OSF_IIO_H
+#define _OSF_IIO_H
+
+#include <linux/types.h>
+
+#include "osf_protocol.h"
+
+struct device;
+struct iio_dev;
+struct osf_device;
+
+int osf_iio_register_sensor(struct device *dev,
+			    const struct osf_capability_entry *entry,
+			    struct osf_device *osf, struct iio_dev **indio_dev);
+void osf_iio_unregister_sensor(struct iio_dev *indio_dev);
+int osf_iio_push_sample(struct iio_dev *indio_dev, const s32 *values,
+			unsigned int channel_count);
+bool osf_iio_sensor_supported(u16 sensor_type, u16 channel_count);
+const char *osf_iio_sensor_name(u16 sensor_type);
+
+#endif
-- 
2.43.0

