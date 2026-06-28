Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B955313E07
	for <linux-iio@vger.kernel.org>; Sun, 28 Jun 2026 19:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782674083; cv=none; b=PB/ftu0FcxmPk4HW4kMaOOncpTBrBaviUlH53iqmLn7kOrMIIWqLiznIYCcPGQyGq3mUUYJKsTyeKSnieiwMxb4pYhevTwOqvokRbexk/QAAKEPfJbr4K8yrBpO0zkbt6cZ2ZMLuaaArJmLK04eA1wafCKbojoiYPlFvF2W/2GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782674083; c=relaxed/simple;
	bh=YVodrP6SP1ni2moBQfSWYaBy5fMfW2VSaTFLJJaWiSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Huo9dQRUwvSOHtWZWqfdYRVw2uksZmyYVcOEiYVhByi/aJm+vfkdIml4ko27lS88MNpWp1AF0wQ/XYNaS/NGNjw/6CzjlJR4rGEr3x4AUg2KM5kseYHP7haA1Dzr61kYHc04r/xpPOspeThxmhLFqoySiKaVKivcFir+ZRG4ofk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rl+jljJ3; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rl+jljJ3"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2c9878bbe88so5027295ad.0
        for <linux-iio@vger.kernel.org>; Sun, 28 Jun 2026 12:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782674080; x=1783278880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uHdLBi94X6p2LZ4TNp4dyIhiFiAKY5bAtCFoo1y8sK4=;
        b=rl+jljJ3H57tgbUH5cbDdO3QFzqdxFvJiR7vJLxTMMKAz5VdBreX7q7F2Obg8e9Yps
         WqtaPtECAGryQiZHCxZLh01KK3N5PiG1O6M1iXYlAMwufxSXGlffvzHZgM2shIVTbDfd
         j6IvE1RHgtOlc+kJi8+29Q2qRl23sQYDmMDpHiJBUVrE3E/wo/ygZMv9E6iCi12IZJZd
         GpC6wgrdfNFR/SBq2GOHT7HGZs4HX16k1+AK1KKy5yQ0xnUH6wtgesiQiVY4wV49cTgh
         X5bHdSMTbpV/SePOdXtA0ccnm5XZlL6OYiDx8EGbzczIPQtdL1jgfBzHoAgURf4cA0Fs
         SBNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782674080; x=1783278880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uHdLBi94X6p2LZ4TNp4dyIhiFiAKY5bAtCFoo1y8sK4=;
        b=I8VEdzWq/uN6CBeejDtQwMze36e4HbKFqNzZzauLYbzsedCQMA6Pk1vcngLNIut6C9
         96BTpXXlQLwFETIvTVv7fFsHUwA6DI0SU6SUgjAnVE8MnZNM518keTvDHdNVLLLkXj+1
         aCKzLmM9ZJOXR9fvm0bVSkXybKcksTeRmILthPukTsBUuck6Y0iQRu2UPG0oZabx27XJ
         +YuwN0/Ox+JAQzssMWJA5z2wQ21Onyk6jaw9+v0ujLurLWzpQIMECIbSQoH+bhgGnUYq
         fRXhEzSSmnDvNLL+Fsc35bk46TP474dBMm5JXkNF4loVyaDvf/0mprNjiQn4TD11HlMH
         mgBw==
X-Forwarded-Encrypted: i=1; AHgh+RokREtAOSG5dBixOUONfHEYoVSphxV4/0N0JE2Dxpz+u1mU0wiDZQ/lvl3LY+ULta/oy+8heWPXfqs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1JQST8w/SVlvCfUvR/3Ew5xtUeNoex7s0BDTvUHKoIQtRdoFx
	z8NAQei5AizDDew3hnd5gahtDYZ64XoOtwt+exAZWZnsISlqkUuojIOy
X-Gm-Gg: AfdE7ckQFQv9vS/VHDPP9vBcgkCvbJ6VuGBCNZimjIafGSVjH8/2AhH1ThPOCZebBJH
	YDkLSb30fOvuPkocZ8VKrCgULJUvVIW+2PZCteIkE6uDTOPqpB9HBhQz5POt0uMrcTWUvfkEsmf
	C5a5f4pYmMAIq2F3BxdxlNpgQ7amVE3hqhexAOwJG8Yira/eon6dr+XzMRjT5ldwTkF4tlQ5Cd+
	N9lI3/XfFSQECFbF3oRFFkW/dLq4vtMcN09fbI7+56xKcBVQwZnUmOh9O05pkAL1INwBxFu9Cp+
	oNpymyb39ZTuX4Dexx0023ArAe6ynbYP3FCv0w/It6NOc41ZlYdcV3PD4Ry16oRQ7L+VYNIU9jD
	JESwy8EBKAQP0XSmi1IJpFIJ94RM6aArfDKbSWOfcMX70w/k3EAI3t2LOxEgzmB05OwEtKhQ9Z6
	PRCdwSHFH9LaEtjC9AEA+LpIH+iYIS0a2SM5EOKQR2Tx/ycHAm3oQeYc+HXe4W3wyxVfxxWqFvt
	QHIKUmxNjivueeVeN4pR0lZNGl1
X-Received: by 2002:a17:903:1c2:b0:2ba:838b:bfae with SMTP id d9443c01a7336-2c7fcfdaf93mr104488555ad.18.1782674079431;
        Sun, 28 Jun 2026 12:14:39 -0700 (PDT)
Received: from DESKTOP-G3E0OSP.localdomain ([112.172.255.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca0b454815sm1354385ad.2.2026.06.28.12.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 12:14:39 -0700 (PDT)
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
	Jinseob Kim <kimjinseob88@gmail.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC v6 5/5] iio: osf: add UART IIO driver
Date: Mon, 29 Jun 2026 04:13:37 +0900
Message-ID: <20260628191337.937-6-kimjinseob88@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260628191337.937-1-kimjinseob88@gmail.com>
References: <20260628191337.937-1-kimjinseob88@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the Open Sensor Fusion serdev transport, driver core, and IIO
registration path as one complete driver patch.

The driver enables the required vcc regulator, receives OSF frames over
UART, registers IIO devices from capability reports, supports direct raw
reads from the latest sample cache, and pushes buffered samples into
software kfifo buffers.

Use final Kconfig and Makefile contents from the start, claim IIO buffer
mode while pushing samples, and use zeroed scan storage with explicit
timestamp alignment so the driver does not depend on IIO core
bounce-buffer padding behavior.

Signed-off-by: Jinseob Kim <kimjinseob88@gmail.com>
---
 MAINTAINERS                               |   5 +
 drivers/iio/Kconfig                       |   1 +
 drivers/iio/Makefile                      |   1 +
 drivers/iio/opensensorfusion/Kconfig      |  16 ++
 drivers/iio/opensensorfusion/Makefile     |   6 +
 drivers/iio/opensensorfusion/osf_core.c   | 291 ++++++++++++++++++++
 drivers/iio/opensensorfusion/osf_core.h   |  70 +++++
 drivers/iio/opensensorfusion/osf_iio.c    | 308 ++++++++++++++++++++++
 drivers/iio/opensensorfusion/osf_iio.h    |  22 ++
 drivers/iio/opensensorfusion/osf_serdev.c | 114 ++++++++
 10 files changed, 834 insertions(+)
 create mode 100644 drivers/iio/opensensorfusion/Kconfig
 create mode 100644 drivers/iio/opensensorfusion/Makefile
 create mode 100644 drivers/iio/opensensorfusion/osf_core.c
 create mode 100644 drivers/iio/opensensorfusion/osf_core.h
 create mode 100644 drivers/iio/opensensorfusion/osf_iio.c
 create mode 100644 drivers/iio/opensensorfusion/osf_iio.h
 create mode 100644 drivers/iio/opensensorfusion/osf_serdev.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 3d4199d9e..6ce18ad92 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20016,7 +20016,12 @@ M:	Jinseob Kim <kimjinseob88@gmail.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/iio/opensensorfusion,osf.yaml
 F:	Documentation/iio/open-sensor-fusion.rst
+F:	drivers/iio/opensensorfusion/Kconfig
+F:	drivers/iio/opensensorfusion/Makefile
+F:	drivers/iio/opensensorfusion/osf_core.*
+F:	drivers/iio/opensensorfusion/osf_iio.*
 F:	drivers/iio/opensensorfusion/osf_protocol.*
+F:	drivers/iio/opensensorfusion/osf_serdev.c
 F:	drivers/iio/opensensorfusion/osf_stream.*
 K:	opensensorfusion
 
diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
index 661127aed..939f6c546 100644
--- a/drivers/iio/Kconfig
+++ b/drivers/iio/Kconfig
@@ -101,6 +101,7 @@ source "drivers/iio/light/Kconfig"
 source "drivers/iio/magnetometer/Kconfig"
 source "drivers/iio/multiplexer/Kconfig"
 source "drivers/iio/orientation/Kconfig"
+source "drivers/iio/opensensorfusion/Kconfig"
 source "drivers/iio/test/Kconfig"
 if IIO_TRIGGER
    source "drivers/iio/trigger/Kconfig"
diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
index cb80ef837..d864fe17b 100644
--- a/drivers/iio/Makefile
+++ b/drivers/iio/Makefile
@@ -37,6 +37,7 @@ obj-y += light/
 obj-y += magnetometer/
 obj-y += multiplexer/
 obj-y += orientation/
+obj-y += opensensorfusion/
 obj-y += position/
 obj-y += potentiometer/
 obj-y += potentiostat/
diff --git a/drivers/iio/opensensorfusion/Kconfig b/drivers/iio/opensensorfusion/Kconfig
new file mode 100644
index 000000000..6da44f91c
--- /dev/null
+++ b/drivers/iio/opensensorfusion/Kconfig
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config OPEN_SENSOR_FUSION
+	tristate "Open Sensor Fusion UART IIO driver"
+	depends on IIO
+	depends on SERIAL_DEV_BUS
+	select CRC32
+	select IIO_BUFFER
+	select IIO_KFIFO_BUF
+	help
+	  Build the Open Sensor Fusion UART IIO driver.
+
+	  The driver receives OSF protocol frames over a serdev UART and
+	  registers IIO devices for supported capability entries. It exposes
+	  accelerometer, gyroscope, magnetometer, and temperature samples
+	  through IIO direct reads and software buffers.
diff --git a/drivers/iio/opensensorfusion/Makefile b/drivers/iio/opensensorfusion/Makefile
new file mode 100644
index 000000000..b4e03b80c
--- /dev/null
+++ b/drivers/iio/opensensorfusion/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+obj-$(CONFIG_OPEN_SENSOR_FUSION) += open-sensor-fusion.o
+
+open-sensor-fusion-y := osf_core.o osf_iio.o osf_protocol.o osf_serdev.o \
+			 osf_stream.o
diff --git a/drivers/iio/opensensorfusion/osf_core.c b/drivers/iio/opensensorfusion/osf_core.c
new file mode 100644
index 000000000..207de03db
--- /dev/null
+++ b/drivers/iio/opensensorfusion/osf_core.c
@@ -0,0 +1,291 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/cleanup.h>
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <linux/types.h>
+
+#include "osf_core.h"
+#include "osf_iio.h"
+
+#define OSF_RESERVED_MSG_FIRST		0x7f00
+#define OSF_RESERVED_MSG_LAST		0x7fff
+#define OSF_VENDOR_PRIVATE_FIRST	0x8000
+
+void osf_core_init(struct osf_device *osf, struct device *dev)
+{
+	*osf = (struct osf_device) {
+		.dev = dev,
+	};
+	mutex_init(&osf->latest_lock);
+}
+
+void osf_core_unregister_iio(struct osf_device *osf)
+{
+	for (unsigned int i = 0; i < osf->iio_dev_count; i++)
+		osf_iio_unregister_sensor(osf->iio_devs[i].indio_dev);
+
+	osf->iio_dev_count = 0;
+}
+
+static struct iio_dev *osf_core_find_iio_dev(struct osf_device *osf,
+					     u16 sensor_type, u16 sensor_index)
+{
+	const struct osf_iio_binding *binding;
+
+	for (unsigned int i = 0; i < osf->iio_dev_count; i++) {
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
+
+	for (unsigned int i = 0; i < osf->latest_sample_count; i++) {
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
+					     u16 index)
+{
+	const struct osf_capability_entry *entry = &cache->entries[index];
+
+	for (u16 i = 0; i < index; i++) {
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
+}
+
+static int osf_core_register_capabilities(struct osf_device *osf,
+					  const struct osf_capability_cache *cache)
+{
+	struct iio_dev *indio_dev;
+	int ret;
+
+	if (osf->capability_cache.valid)
+		return 0;
+
+	for (u16 i = 0; i < cache->capability_count; i++) {
+		if (!osf_iio_sensor_supported(cache->entries[i].sensor_type,
+					      cache->entries[i].channel_count))
+			continue;
+
+		if (osf_core_capability_is_duplicate(cache, i))
+			return -EEXIST;
+	}
+
+	for (u16 i = 0; i < cache->capability_count; i++) {
+		if (!osf_iio_sensor_supported(cache->entries[i].sensor_type,
+					      cache->entries[i].channel_count))
+			continue;
+
+		ret = osf_iio_register_sensor(osf->dev, &cache->entries[i],
+					      osf, &indio_dev);
+		if (ret)
+			goto err_unregister;
+
+		osf->iio_devs[osf->iio_dev_count++] = (struct osf_iio_binding) {
+			.sensor_type = cache->entries[i].sensor_type,
+			.sensor_index = cache->entries[i].sensor_index,
+			.indio_dev = indio_dev,
+		};
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
+	struct osf_sensor_sample sample;
+	struct iio_dev *indio_dev;
+	s32 values[OSF_MAX_SAMPLE_CHANNELS] = { };
+	int ret;
+
+	ret = osf_protocol_decode_sensor_sample(frame, &sample);
+	if (ret)
+		return ret;
+
+	if (sample.channel_count > OSF_MAX_SAMPLE_CHANNELS)
+		return -E2BIG;
+
+	for (u16 i = 0; i < sample.channel_count; i++) {
+		ret = osf_protocol_sensor_sample_value(&sample, i, &values[i]);
+		if (ret)
+			return ret;
+	}
+
+	scoped_guard(mutex, &osf->latest_lock) {
+		latest = osf_core_find_latest_sample(osf, sample.sensor_type,
+						     sample.sensor_index);
+		if (!latest)
+			return -E2BIG;
+
+		memcpy(latest->values, values, sizeof(values));
+		latest->sensor_type = sample.sensor_type;
+		latest->sensor_index = sample.sensor_index;
+		latest->channel_count = sample.channel_count;
+		latest->sample_format = sample.sample_format;
+		latest->scale_nano = sample.scale_nano;
+		latest->sequence = frame->sequence;
+		latest->timestamp_us = frame->timestamp_us;
+		latest->valid = true;
+		osf->last_sequence = frame->sequence;
+	}
+
+	indio_dev = osf_core_find_iio_dev(osf, sample.sensor_type,
+					  sample.sensor_index);
+	if (!indio_dev)
+		return 0;
+
+	return osf_iio_push_sample(indio_dev, values, sample.channel_count);
+}
+
+static int osf_core_handle_device_status(struct osf_device *osf,
+					 const struct osf_frame *frame)
+{
+	struct osf_device_status status;
+	int ret;
+
+	ret = osf_protocol_decode_device_status(frame, &status);
+	if (ret)
+		return ret;
+
+	osf->status_cache = (struct osf_status_cache) {
+		.uptime_s = status.uptime_s,
+		.status_flags = status.status_flags,
+		.error_flags = status.error_flags,
+		.dropped_frames = status.dropped_frames,
+		.sequence = frame->sequence,
+		.valid = true,
+	};
+	osf->last_sequence = frame->sequence;
+
+	return 0;
+}
+
+static int osf_core_handle_capability_report(struct osf_device *osf,
+					     const struct osf_frame *frame)
+{
+	struct osf_capability_cache cache = { };
+	struct osf_capability_report report;
+	int ret;
+
+	ret = osf_protocol_decode_capability_report(frame, &report);
+	if (ret)
+		return ret;
+
+	if (report.capability_count > OSF_MAX_CAPABILITIES)
+		return -E2BIG;
+
+	if (osf->capability_cache.valid) {
+		osf->last_sequence = frame->sequence;
+		return 0;
+	}
+
+	for (u16 i = 0; i < report.capability_count; i++) {
+		ret = osf_protocol_decode_capability_entry(&report, i,
+							   &cache.entries[i]);
+		if (ret)
+			return ret;
+	}
+
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
+	return 0;
+}
+
+int osf_core_receive_frame(struct osf_device *osf, const u8 *buf, size_t len)
+{
+	struct osf_frame frame;
+	size_t frame_len;
+	int ret;
+
+	ret = osf_protocol_decode_frame(buf, len, &frame, &frame_len);
+	if (ret)
+		return ret;
+
+	if (frame_len != len)
+		return -EMSGSIZE;
+
+	switch (frame.message_type) {
+	case OSF_MSG_SENSOR_SAMPLE:
+		return osf_core_handle_sensor_sample(osf, &frame);
+	case OSF_MSG_DEVICE_STATUS:
+		return osf_core_handle_device_status(osf, &frame);
+	case OSF_MSG_CAPABILITY_REPORT:
+		return osf_core_handle_capability_report(osf, &frame);
+	default:
+		if (frame.message_type >= OSF_RESERVED_MSG_FIRST &&
+		    frame.message_type <= OSF_RESERVED_MSG_LAST)
+			return 0;
+		if (frame.message_type >= OSF_VENDOR_PRIVATE_FIRST)
+			return 0;
+		return -EOPNOTSUPP;
+	}
+}
+
+int osf_core_read_latest_sample(struct osf_device *osf, u16 sensor_type,
+				u16 sensor_index, u16 channel,
+				s32 *value)
+{
+	const struct osf_latest_sample *latest;
+
+	if (!osf || !value)
+		return -EINVAL;
+
+	guard(mutex)(&osf->latest_lock);
+	for (unsigned int i = 0; i < osf->latest_sample_count; i++) {
+		latest = &osf->latest_samples[i];
+		if (latest->sensor_type != sensor_type ||
+		    latest->sensor_index != sensor_index)
+			continue;
+
+		if (!latest->valid || channel >= latest->channel_count)
+			break;
+
+		*value = latest->values[channel];
+		return 0;
+	}
+
+	return -ENODATA;
+}
diff --git a/drivers/iio/opensensorfusion/osf_core.h b/drivers/iio/opensensorfusion/osf_core.h
new file mode 100644
index 000000000..5744a39cf
--- /dev/null
+++ b/drivers/iio/opensensorfusion/osf_core.h
@@ -0,0 +1,70 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _OSF_CORE_H
+#define _OSF_CORE_H
+
+#include <linux/mutex.h>
+#include <linux/types.h>
+
+#include "osf_protocol.h"
+
+#define OSF_MAX_SAMPLE_CHANNELS	3
+#define OSF_MAX_CAPABILITIES	16
+
+struct device;
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
+
+struct osf_device {
+	struct device *dev;
+	/* Protects latest_samples and latest_sample_count. */
+	struct mutex latest_lock;
+	struct osf_latest_sample latest_samples[OSF_MAX_CAPABILITIES];
+	unsigned int latest_sample_count;
+	struct osf_capability_cache capability_cache;
+	struct osf_status_cache status_cache;
+	struct osf_iio_binding iio_devs[OSF_MAX_CAPABILITIES];
+	unsigned int iio_dev_count;
+	u64 last_sequence;
+};
+
+void osf_core_init(struct osf_device *osf, struct device *dev);
+void osf_core_unregister_iio(struct osf_device *osf);
+int osf_core_receive_frame(struct osf_device *osf, const u8 *buf, size_t len);
+int osf_core_read_latest_sample(struct osf_device *osf, u16 sensor_type,
+				u16 sensor_index, u16 channel,
+				s32 *value);
+
+#endif
diff --git a/drivers/iio/opensensorfusion/osf_iio.c b/drivers/iio/opensensorfusion/osf_iio.c
new file mode 100644
index 000000000..91afcf3b8
--- /dev/null
+++ b/drivers/iio/opensensorfusion/osf_iio.c
@@ -0,0 +1,308 @@
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
+struct osf_iio_scan_3axis {
+	s32 values[3];
+	aligned_s64 timestamp;
+};
+
+struct osf_iio_scan_1axis {
+	s32 value;
+	aligned_s64 timestamp;
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
+	for (unsigned int i = 0; i < ARRAY_SIZE(osf_iio_sensor_specs); i++) {
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
+	if (osf_iio_find_sensor_spec(sensor_type, channel_count))
+		return true;
+
+	return false;
+}
+
+const char *osf_iio_sensor_name(u16 sensor_type)
+{
+	for (unsigned int i = 0; i < ARRAY_SIZE(osf_iio_sensor_specs); i++) {
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
+			u16 channel_count)
+{
+	struct osf_iio_state *state = iio_priv(indio_dev);
+	s64 timestamp;
+	int ret;
+
+	if (channel_count != state->spec->channel_count)
+		return -EPROTO;
+
+	if (!iio_device_try_claim_buffer_mode(indio_dev))
+		return 0;
+
+	timestamp = iio_get_time_ns(indio_dev);
+
+	switch (channel_count) {
+	case 1: {
+		struct osf_iio_scan_1axis scan = { };
+
+		scan.value = values[0];
+		ret = iio_push_to_buffers_with_ts(indio_dev, &scan,
+						  sizeof(scan), timestamp);
+		break;
+	}
+	case 3: {
+		struct osf_iio_scan_3axis scan = { };
+
+		scan.values[0] = values[0];
+		scan.values[1] = values[1];
+		scan.values[2] = values[2];
+		ret = iio_push_to_buffers_with_ts(indio_dev, &scan,
+						  sizeof(scan), timestamp);
+		break;
+	}
+	default:
+		ret = -EPROTO;
+		break;
+	}
+
+	iio_device_release_buffer_mode(indio_dev);
+
+	return ret;
+}
diff --git a/drivers/iio/opensensorfusion/osf_iio.h b/drivers/iio/opensensorfusion/osf_iio.h
new file mode 100644
index 000000000..d0745167f
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
+			u16 channel_count);
+bool osf_iio_sensor_supported(u16 sensor_type, u16 channel_count);
+const char *osf_iio_sensor_name(u16 sensor_type);
+
+#endif
diff --git a/drivers/iio/opensensorfusion/osf_serdev.c b/drivers/iio/opensensorfusion/osf_serdev.c
new file mode 100644
index 000000000..474fa251f
--- /dev/null
+++ b/drivers/iio/opensensorfusion/osf_serdev.c
@@ -0,0 +1,114 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/regulator/consumer.h>
+#include <linux/serdev.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+
+#include "osf_core.h"
+#include "osf_stream.h"
+
+#define OSF_SERDEV_BAUD		115200
+
+struct osf_serdev {
+	struct serdev_device *serdev;
+	struct osf_device osf;
+	struct osf_stream stream;
+};
+
+static size_t osf_serdev_receive_buf(struct serdev_device *serdev,
+				     const u8 *buf, size_t count)
+{
+	struct osf_serdev *osf_uart = serdev_device_get_drvdata(serdev);
+	const struct osf_stream_stats *stats;
+	u64 valid_before;
+	int ret;
+
+	valid_before = osf_uart->stream.stats.valid_frames;
+	ret = osf_stream_receive_bytes(&osf_uart->stream, buf, count);
+	stats = &osf_uart->stream.stats;
+
+	if (ret || stats->valid_frames != valid_before)
+		dev_dbg_ratelimited(&serdev->dev,
+				    "rx count=%zu valid=%llu bad_magic=%llu bad_crc=%llu partial=%llu dropped=%llu ret=%d\n",
+				    count, stats->valid_frames,
+				    stats->bad_magic_resyncs,
+				    stats->bad_crc_frames, stats->partial_frames,
+				    stats->dropped_bytes, ret);
+
+	return count;
+}
+
+static const struct serdev_device_ops osf_serdev_ops = {
+	.receive_buf = osf_serdev_receive_buf,
+};
+
+static int osf_serdev_probe(struct serdev_device *serdev)
+{
+	struct device *dev = &serdev->dev;
+	struct osf_serdev *osf_uart;
+	unsigned int baudrate;
+	int ret;
+
+	osf_uart = devm_kzalloc(dev, sizeof(*osf_uart), GFP_KERNEL);
+	if (!osf_uart)
+		return -ENOMEM;
+
+	osf_uart->serdev = serdev;
+	osf_core_init(&osf_uart->osf, dev);
+	osf_stream_init(&osf_uart->stream, &osf_uart->osf);
+
+	serdev_device_set_drvdata(serdev, osf_uart);
+	serdev_device_set_client_ops(serdev, &osf_serdev_ops);
+
+	ret = devm_regulator_get_enable(dev, "vcc");
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to enable vcc regulator\n");
+
+	ret = serdev_device_open(serdev);
+	if (ret)
+		return ret;
+
+	baudrate = serdev_device_set_baudrate(serdev, OSF_SERDEV_BAUD);
+	if (baudrate != OSF_SERDEV_BAUD)
+		dev_warn(dev, "requested %u baud, controller set %u\n",
+			 OSF_SERDEV_BAUD, baudrate);
+
+	serdev_device_set_flow_control(serdev, false);
+
+	return 0;
+}
+
+static void osf_serdev_remove(struct serdev_device *serdev)
+{
+	struct osf_serdev *osf_uart = serdev_device_get_drvdata(serdev);
+
+	/* Stop the RX producer before unregistering IIO consumers. */
+	serdev_device_close(serdev);
+	osf_stream_reset(&osf_uart->stream);
+	osf_core_unregister_iio(&osf_uart->osf);
+}
+
+static const struct of_device_id osf_serdev_of_match[] = {
+	{ .compatible = "opensensorfusion,osf" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, osf_serdev_of_match);
+
+static struct serdev_device_driver osf_serdev_driver = {
+	.probe = osf_serdev_probe,
+	.remove = osf_serdev_remove,
+	.driver = {
+		.name = "open-sensor-fusion-uart",
+		.of_match_table = osf_serdev_of_match,
+	},
+};
+module_serdev_device_driver(osf_serdev_driver);
+
+MODULE_DESCRIPTION("Open Sensor Fusion IIO driver");
+MODULE_LICENSE("GPL");
-- 
2.43.0

