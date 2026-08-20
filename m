Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F56038B15B
	for <linux-iio@vger.kernel.org>; Thu, 20 Aug 2026 05:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787202430; cv=none; b=YHmLFX79shyXpFnVdG9qsjr1da7B90VW18XRdN+dP7VsGFgF1o4YBu+UPw3H+lUukmowevQMKIhhlJRTBN26ZWcg6i9l3VezZqQiVbtjxyQ8xDwv/sBWN69EtgfBqFam991UH5vU77qG4mnIMEWl3ODuXse+U1QZ5HH4mqQBaBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787202430; c=relaxed/simple;
	bh=O6dfj4jHRRyCekryhkXJW4cmw4TeKNwQJkZXXsAVvDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lhb7Ycr7G6gf8GWZiIUghBsePPvUCAZi+txRSxPZqzs4RMYrg4FNcABiUj+7+WXAYEZy2gRxDGz39whQBxHmarhxy1OvRP32rRAkD7uqshnclVH495yMfcchKhpHF3GMepEvioqo2qWh4+1+GCIsxFooeeDxdztwJtcK/LFMWTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z5s70zV9; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z5s70zV9"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ce98cb8165so5542325ad.1
        for <linux-iio@vger.kernel.org>; Wed, 19 Aug 2026 22:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787202427; x=1787807227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KVpJHSxoiPG0ATViUZ3Q3SyRLlSa3yfZtvS25/l3T84=;
        b=Z5s70zV9CI/r2nadtWi9gHT7jcD1jax4lBIwQnkTHWtmuhUwcdY+t4IGJWlSu56up6
         lyduDOZyMG6O9n8SPCmMZrM3CkFBMFf+JBjxXzuIt6z7faGB6AA4avsWQzo5nkdsmUtU
         RmfaVqJMCSzaedspi1t6VT9ie6a7NjThV+M/VqXvNREWEHBdrDWQ8e+5Lg2xJDAPUcJN
         Y45k77OFxIdvBQIoD1Stody3+HpSAadqLoPtEWKAUda/fpFYYoX9IB5dVcuAIMjykwSl
         roH3wbojLs/poGXfGHCmCxYJp35NV+hZOVtwBHGsHa4tus4Xm3Nvc/0kSnivwv/bTHhV
         P2Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787202427; x=1787807227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KVpJHSxoiPG0ATViUZ3Q3SyRLlSa3yfZtvS25/l3T84=;
        b=s/CYW+wdvxHNOMKZA5hYqbs9NzRf5i5CJ7NIN0Y/mivQbVRGgeGqY2rgO90KrxxNsy
         4rqOYcKzCXsrAv/u9XrvrFy2exUZvPCjBDa9AsegaVUpcznWldLCwrENhg9imrCoN0DG
         tIhzchi+b5B6DPfXNkxio+ZWUOyM0jbjuRwDKNjO1C6mY7DafWN0SkPHpm2TTDCIxWea
         hxnYVz47lXQFlELSXUxhl60PUrCIDxOxJc4rV170y4wJL1kIGmcMcwa0VXR1rL6/BM1K
         9AB3SU55AFsZFqXgHwCCaXFjeSSdLcfAkdP15Ru1wcMfUtz5gVwuYVNiufA1qjod8E+W
         L+Jw==
X-Forwarded-Encrypted: i=1; AHgh+RoI9cKSAHftPQpWKDjqIC5/iwwmtcd/oDg7IgBv5jGwQ7VSa11Llp98D2ZwfCqmtEboPkvVCn7PpgE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywuf/Yg+bVvg3s11NcEalaVEkXzOge+7FW0zHptOtw4zOMdKoaw
	xQent8mJ5pBahWawdNw/DXdKHERK/EppSUYXFKA0IZwJp6agdIOYR+qS
X-Gm-Gg: AR+sD10nB9pXQz4TYNeBTizPMcY0bGEwmpfj62i3wdJ6CP5jrkHKFGx5URnjbW2KGIC
	MAeVpwdf5Dzvf6689hQIMEu5pEbIZx161bMdhgxRcbzuxqD4xbv+ZR6chgNzJ9bDXQe6TPkBjZ3
	FCH6nUZUkHc1GiNSFYL53eFmTJTxOJQUTzO7hYW3bsvcK/5ZJj6mBK6JaznFUlqY3rBrI3cTA0E
	koRD2AhdMf3oXF+XfdzFj/SBXkYNGDh/xLUOiFVG+DNQB87KpU5ooz9uBmUInOAomEcvDoRYXHW
	ypoF5Fq69I86YG71Vpo0BUu1/l1Tkswb9zl7hrG3hWCSvUftQpLTYbIQgqTPEkCKlrQDd4Wr1Q2
	MFEfa7z/LYTLbyoLnkS0x2pRC2G9k6w5WuWSdGLiUKVrBHfT5ZvqlwWaPr3k8N/SQPuzypYX8zl
	NMLb5GlSvfrT+/1YZRQsBUDEyyDVEqyevVQAgboAzmF8pHRBYXEuNP2/1I2rA/G8kppTAvxsAG5
	goj7mLBgBVlx8xAh0PmRAjV4hDCEXXr6dUCAPI168k/HZNfu1BNh7AUfjhfRfdcJNS8Lerdi4js
	c8Xpf5YYj/Q=
X-Received: by 2002:a17:902:f64a:b0:2cc:fa13:dcab with SMTP id d9443c01a7336-2d61a1748d0mr49127395ad.8.1787202426468;
        Wed, 19 Aug 2026 22:07:06 -0700 (PDT)
Received: from DESKTOP-G3E0OSP.localdomain ([112.172.255.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d62d58a82dsm2040685ad.18.2026.08.19.22.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 22:07:05 -0700 (PDT)
From: Jinseob Kim <kimjinseob88@gmail.com>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-kernel@vger.kernel.org,
	rdunlap@infradead.org,
	joshua.crofts1@gmail.com,
	u.kleine-koenig@baylibre.com,
	julianbraha@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	grondon@gmail.com,
	devicetree@vger.kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v8 5/5] iio: osf: add UART IIO driver
Date: Thu, 20 Aug 2026 14:06:08 +0900
Message-ID: <20260820050608.5440-6-kimjinseob88@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260820050608.5440-1-kimjinseob88@gmail.com>
References: <20260820050608.5440-1-kimjinseob88@gmail.com>
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

Wire the stream parser frame callback to the OSF core, use final Kconfig
and Makefile contents from the start, check iio_buffer_enabled() before
pushing samples, and use zero-initialized scan storage with explicit
timestamp alignment.

Classify authenticated application outcomes as handled, ignored, or
rejected so the parser consumes every CRC-valid frame in full. Decode
capability entries structurally, skip unsupported entries individually,
and register the supported entries from the same report. Allocate latest
sample cache slots only for sensors with registered IIO devices.

Deliver sensor samples to IIO before committing the latest-sample
cache, so a frame rejected by the registered channel layout or buffer
path cannot change direct-read state or the last accepted sequence.
Add focused KUnit coverage for rejected, valid, ignored, and malformed
sample paths and cache-slot exhaustion.

Signed-off-by: Jinseob Kim <kimjinseob88@gmail.com>
---
 MAINTAINERS                                  |   3 +-
 drivers/iio/Kconfig                          |   1 +
 drivers/iio/Makefile                         |   1 +
 drivers/iio/opensensorfusion/Kconfig         |  27 +
 drivers/iio/opensensorfusion/Makefile        |   7 +
 drivers/iio/opensensorfusion/osf_core.c      | 393 +++++++++++++++
 drivers/iio/opensensorfusion/osf_core.h      |  70 +++
 drivers/iio/opensensorfusion/osf_core_test.c | 493 +++++++++++++++++++
 drivers/iio/opensensorfusion/osf_iio.c       | 304 ++++++++++++
 drivers/iio/opensensorfusion/osf_iio.h       |  22 +
 drivers/iio/opensensorfusion/osf_serdev.c    | 124 +++++
 11 files changed, 1443 insertions(+), 2 deletions(-)
 create mode 100644 drivers/iio/opensensorfusion/Kconfig
 create mode 100644 drivers/iio/opensensorfusion/Makefile
 create mode 100644 drivers/iio/opensensorfusion/osf_core.c
 create mode 100644 drivers/iio/opensensorfusion/osf_core.h
 create mode 100644 drivers/iio/opensensorfusion/osf_core_test.c
 create mode 100644 drivers/iio/opensensorfusion/osf_iio.c
 create mode 100644 drivers/iio/opensensorfusion/osf_iio.h
 create mode 100644 drivers/iio/opensensorfusion/osf_serdev.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 093b569de12e..ec1e86718015 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20298,8 +20298,7 @@ M:	Jinseob Kim <kimjinseob88@gmail.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/iio/opensensorfusion,osf.yaml
 F:	Documentation/iio/open-sensor-fusion.rst
-F:	drivers/iio/opensensorfusion/osf_protocol.*
-F:	drivers/iio/opensensorfusion/osf_stream.*
+F:	drivers/iio/opensensorfusion/
 K:	opensensorfusion
 
 OPENCOMPUTE PTP CLOCK DRIVER
diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
index 652557a5b851..89bb5b65c761 100644
--- a/drivers/iio/Kconfig
+++ b/drivers/iio/Kconfig
@@ -102,6 +102,7 @@ source "drivers/iio/light/Kconfig"
 source "drivers/iio/magnetometer/Kconfig"
 source "drivers/iio/multiplexer/Kconfig"
 source "drivers/iio/orientation/Kconfig"
+source "drivers/iio/opensensorfusion/Kconfig"
 source "drivers/iio/test/Kconfig"
 if IIO_TRIGGER
    source "drivers/iio/trigger/Kconfig"
diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
index f03a4100c800..a51c4446ee09 100644
--- a/drivers/iio/Makefile
+++ b/drivers/iio/Makefile
@@ -38,6 +38,7 @@ obj-y += light/
 obj-y += magnetometer/
 obj-y += multiplexer/
 obj-y += orientation/
+obj-y += opensensorfusion/
 obj-y += position/
 obj-y += potentiometer/
 obj-y += potentiostat/
diff --git a/drivers/iio/opensensorfusion/Kconfig b/drivers/iio/opensensorfusion/Kconfig
new file mode 100644
index 000000000000..b4a2cde9645e
--- /dev/null
+++ b/drivers/iio/opensensorfusion/Kconfig
@@ -0,0 +1,27 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config OPEN_SENSOR_FUSION
+	tristate "Open Sensor Fusion UART IIO driver"
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
+
+config OPEN_SENSOR_FUSION_KUNIT_TEST
+	bool "KUnit tests for Open Sensor Fusion" if !KUNIT_ALL_TESTS
+	depends on OPEN_SENSOR_FUSION=y && KUNIT=y
+	default KUNIT_ALL_TESTS
+	help
+	  Build focused unit tests for the Open Sensor Fusion core sample
+	  acceptance, direct-read cache, and IIO buffer paths. The tests
+	  exercise accepted, ignored, and rejected sample handling without
+	  exposing additional production interfaces.
+
+	  If unsure, say N.
diff --git a/drivers/iio/opensensorfusion/Makefile b/drivers/iio/opensensorfusion/Makefile
new file mode 100644
index 000000000000..c2f5ba065a62
--- /dev/null
+++ b/drivers/iio/opensensorfusion/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+obj-$(CONFIG_OPEN_SENSOR_FUSION) += open-sensor-fusion.o
+
+open-sensor-fusion-y := osf_core.o osf_iio.o osf_protocol.o osf_serdev.o \
+			 osf_stream.o
+open-sensor-fusion-$(CONFIG_OPEN_SENSOR_FUSION_KUNIT_TEST) += osf_core_test.o
diff --git a/drivers/iio/opensensorfusion/osf_core.c b/drivers/iio/opensensorfusion/osf_core.c
new file mode 100644
index 000000000000..1b8434afb873
--- /dev/null
+++ b/drivers/iio/opensensorfusion/osf_core.c
@@ -0,0 +1,393 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/cleanup.h>
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <linux/types.h>
+
+#include "osf_core.h"
+#include "osf_iio.h"
+#include "osf_stream.h"
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
+static bool
+osf_core_capability_supported(const struct osf_capability_entry *entry)
+{
+	return osf_iio_sensor_supported(entry->sensor_type,
+					entry->channel_count) &&
+	       entry->sample_format == OSF_SAMPLE_FORMAT_S32 &&
+	       !(entry->flags & ~OSF_CAPABILITY_FLAGS_MASK) &&
+	       !entry->reserved;
+}
+
+static bool osf_core_capability_is_duplicate(const struct osf_capability_cache *cache,
+					     u16 index)
+{
+	const struct osf_capability_entry *entry = &cache->entries[index];
+
+	for (u16 i = 0; i < index; i++) {
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
+	for (u16 i = 0; i < cache->capability_count; i++) {
+		if (osf_core_capability_is_duplicate(cache, i))
+			return -EEXIST;
+	}
+
+	for (u16 i = 0; i < cache->capability_count; i++) {
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
+	if (ret) {
+		dev_warn_ratelimited(osf->dev,
+				     "rejecting malformed sensor sample: %d\n",
+				     ret);
+		return ret;
+	}
+
+	indio_dev = osf_core_find_iio_dev(osf, sample.sensor_type,
+					  sample.sensor_index);
+	if (!indio_dev) {
+		dev_dbg_ratelimited(osf->dev,
+				    "ignoring sample for unregistered sensor %#x:%u\n",
+				    sample.sensor_type, sample.sensor_index);
+		return OSF_STREAM_FRAME_IGNORED;
+	}
+
+	if (sample.channel_count > OSF_MAX_SAMPLE_CHANNELS) {
+		dev_warn_ratelimited(osf->dev,
+				     "rejecting sensor sample with %u channels\n",
+				     sample.channel_count);
+		return -E2BIG;
+	}
+
+	for (u16 i = 0; i < sample.channel_count; i++) {
+		ret = osf_protocol_sensor_sample_value(&sample, i, &values[i]);
+		if (ret) {
+			dev_warn_ratelimited(osf->dev,
+					     "rejecting malformed sample value: %d\n",
+					     ret);
+			return ret;
+		}
+	}
+
+	ret = osf_iio_push_sample(indio_dev, values, sample.channel_count);
+	if (ret) {
+		dev_err_ratelimited(osf->dev,
+				    "failed to push sensor %#x:%u sample: %d\n",
+				    sample.sensor_type, sample.sensor_index, ret);
+		return ret;
+	}
+
+	scoped_guard(mutex, &osf->latest_lock) {
+		latest = osf_core_find_latest_sample(osf, sample.sensor_type,
+						     sample.sensor_index);
+		if (!latest) {
+			dev_err_ratelimited(osf->dev,
+					    "latest sample cache full for sensor %#x:%u\n",
+					    sample.sensor_type,
+					    sample.sensor_index);
+			return -ENOSPC;
+		}
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
+	return OSF_STREAM_FRAME_HANDLED;
+}
+
+static int osf_core_handle_device_status(struct osf_device *osf,
+					 const struct osf_frame *frame)
+{
+	struct osf_device_status status;
+	int ret;
+
+	ret = osf_protocol_decode_device_status(frame, &status);
+	if (ret) {
+		dev_warn_ratelimited(osf->dev,
+				     "rejecting malformed device status: %d\n",
+				     ret);
+		return ret;
+	}
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
+	return OSF_STREAM_FRAME_HANDLED;
+}
+
+static int osf_core_handle_capability_report(struct osf_device *osf,
+					     const struct osf_frame *frame)
+{
+	struct osf_capability_cache cache = { };
+	struct osf_capability_report report;
+	int frame_result;
+	int ret;
+
+	ret = osf_protocol_decode_capability_report(frame, &report);
+	if (ret) {
+		dev_warn_ratelimited(osf->dev,
+				     "rejecting malformed capability report: %d\n",
+				     ret);
+		return ret;
+	}
+
+	if (osf->capability_cache.valid) {
+		dev_dbg_ratelimited(osf->dev,
+				    "ignoring repeated capability report\n");
+		osf->last_sequence = frame->sequence;
+		return OSF_STREAM_FRAME_IGNORED;
+	}
+
+	for (u16 i = 0; i < report.capability_count; i++) {
+		struct osf_capability_entry entry;
+
+		ret = osf_protocol_decode_capability_entry(&report, i, &entry);
+		if (ret) {
+			dev_warn_ratelimited(osf->dev,
+					     "rejecting malformed capability entry: %d\n",
+					     ret);
+			return ret;
+		}
+
+		if (!osf_core_capability_supported(&entry))
+			continue;
+
+		if (cache.capability_count >= OSF_MAX_CAPABILITIES) {
+			dev_warn_ratelimited(osf->dev,
+					     "too many supported capabilities\n");
+			return -E2BIG;
+		}
+
+		cache.entries[cache.capability_count++] = entry;
+	}
+
+	cache.sequence = frame->sequence;
+	cache.valid = true;
+
+	frame_result = OSF_STREAM_FRAME_IGNORED;
+	if (cache.capability_count) {
+		ret = osf_core_register_capabilities(osf, &cache);
+		if (ret) {
+			if (ret == -EEXIST)
+				dev_warn_ratelimited(osf->dev,
+						     "rejecting duplicate capability\n");
+			else
+				dev_err_ratelimited(osf->dev,
+						    "failed to register capabilities: %d\n",
+						    ret);
+			return ret;
+		}
+		frame_result = OSF_STREAM_FRAME_HANDLED;
+	} else {
+		dev_dbg_ratelimited(osf->dev,
+				    "ignoring report without supported capabilities\n");
+	}
+
+	osf->capability_cache = cache;
+	osf->last_sequence = frame->sequence;
+
+	return frame_result;
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
+	if (frame.protocol_major != OSF_PROTOCOL_MAJOR) {
+		dev_dbg_ratelimited(osf->dev,
+				    "ignoring unsupported protocol major %u\n",
+				    frame.protocol_major);
+		return OSF_STREAM_FRAME_IGNORED;
+	}
+
+	if (frame.reserved) {
+		dev_dbg_ratelimited(osf->dev,
+				    "ignoring frame with reserved field %#x\n",
+				    frame.reserved);
+		return OSF_STREAM_FRAME_IGNORED;
+	}
+
+	switch (frame.message_type) {
+	case OSF_MSG_SENSOR_SAMPLE:
+		ret = osf_core_handle_sensor_sample(osf, &frame);
+		break;
+	case OSF_MSG_DEVICE_STATUS:
+		ret = osf_core_handle_device_status(osf, &frame);
+		break;
+	case OSF_MSG_CAPABILITY_REPORT:
+		ret = osf_core_handle_capability_report(osf, &frame);
+		break;
+	default:
+		if (frame.message_type >= OSF_RESERVED_MSG_FIRST &&
+		    frame.message_type <= OSF_RESERVED_MSG_LAST) {
+			dev_dbg_ratelimited(osf->dev,
+					    "ignoring reserved message type %#x\n",
+					    frame.message_type);
+			return OSF_STREAM_FRAME_IGNORED;
+		}
+		if (frame.message_type >= OSF_VENDOR_PRIVATE_FIRST) {
+			dev_dbg_ratelimited(osf->dev,
+					    "ignoring vendor message type %#x\n",
+					    frame.message_type);
+			return OSF_STREAM_FRAME_IGNORED;
+		}
+
+		dev_dbg_ratelimited(osf->dev,
+				    "ignoring unsupported message type %#x\n",
+				    frame.message_type);
+		return OSF_STREAM_FRAME_IGNORED;
+	}
+
+	/*
+	 * Handler failures are authenticated application rejections. Keep the
+	 * trusted frame boundary and let the stream consume the complete frame.
+	 */
+	if (ret < 0)
+		return OSF_STREAM_FRAME_REJECTED;
+
+	return ret;
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
index 000000000000..5744a39cfd9d
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
diff --git a/drivers/iio/opensensorfusion/osf_core_test.c b/drivers/iio/opensensorfusion/osf_core_test.c
new file mode 100644
index 000000000000..e59c0458f945
--- /dev/null
+++ b/drivers/iio/opensensorfusion/osf_core_test.c
@@ -0,0 +1,493 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <kunit/device.h>
+#include <kunit/test.h>
+
+#include <linux/bitmap.h>
+#include <linux/crc32.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/buffer_impl.h>
+#include <linux/iio/iio.h>
+#include <linux/module.h>
+#include <linux/string.h>
+#include <linux/types.h>
+#include <linux/unaligned.h>
+
+#include "osf_core.h"
+#include "osf_protocol.h"
+#include "osf_stream.h"
+
+#define OSF_TEST_SENSOR_INDEX		0
+#define OSF_TEST_UNSUPPORTED_INDEX	7
+#define OSF_TEST_SCALE_NANO		1000000
+#define OSF_TEST_FLOOD_COUNT		(OSF_MAX_CAPABILITIES + 4)
+#define OSF_TEST_MAX_PAYLOAD_LEN						\
+	(OSF_SENSOR_SAMPLE_BASE_LEN + OSF_MAX_SAMPLE_CHANNELS * sizeof(__le32))
+#define OSF_TEST_MAX_FRAME_LEN						\
+	(OSF_FRAME_HEADER_LEN + OSF_CAP_REPORT_BASE_LEN +			\
+	 2 * OSF_CAP_SENSOR_ENTRY_LEN + OSF_FRAME_CRC_LEN)
+
+struct osf_test_context {
+	struct osf_device osf;
+	struct device *dev;
+	struct iio_dev *indio_dev;
+	struct iio_buffer *buffer;
+	bool buffer_enabled;
+};
+
+struct osf_test_scan_3axis {
+	s32 values[3];
+};
+
+static size_t osf_test_build_frame(u8 *buf, size_t buf_size,
+				   u16 message_type, const u8 *payload,
+				   u32 payload_len, u64 sequence)
+{
+	size_t frame_len = OSF_FRAME_HEADER_LEN + payload_len +
+			   OSF_FRAME_CRC_LEN;
+	u32 crc;
+
+	if (frame_len > buf_size)
+		return 0;
+
+	memset(buf, 0, frame_len);
+	put_unaligned_le32(OSF_FRAME_MAGIC, buf);
+	buf[4] = OSF_PROTOCOL_MAJOR;
+	buf[5] = OSF_PROTOCOL_MINOR;
+	put_unaligned_le16(OSF_FRAME_HEADER_LEN, buf + 6);
+	put_unaligned_le16(message_type, buf + 8);
+	put_unaligned_le32(payload_len, buf + 10);
+	put_unaligned_le64(sequence, buf + 14);
+	put_unaligned_le64(sequence * 1000, buf + 22);
+	memcpy(buf + OSF_FRAME_HEADER_LEN, payload, payload_len);
+
+	crc = crc32_le(~0U, buf, OSF_FRAME_HEADER_LEN + payload_len) ^ ~0U;
+	put_unaligned_le32(crc, buf + OSF_FRAME_HEADER_LEN + payload_len);
+
+	return frame_len;
+}
+
+static size_t osf_test_build_capability_frame(u8 *buf, size_t buf_size,
+					      u64 sequence)
+{
+	u8 payload[OSF_CAP_REPORT_BASE_LEN +
+		   2 * OSF_CAP_SENSOR_ENTRY_LEN] = { };
+	u8 *supported = payload + OSF_CAP_REPORT_BASE_LEN;
+	u8 *unsupported = supported + OSF_CAP_SENSOR_ENTRY_LEN;
+
+	put_unaligned_le16(2, payload);
+	put_unaligned_le16(OSF_SENSOR_ACCELEROMETER, supported);
+	put_unaligned_le16(OSF_TEST_SENSOR_INDEX, supported + 2);
+	put_unaligned_le16(3, supported + 4);
+	put_unaligned_le16(OSF_SAMPLE_FORMAT_S32, supported + 6);
+	put_unaligned_le32(OSF_TEST_SCALE_NANO, supported + 8);
+
+	put_unaligned_le16(OSF_SENSOR_BAROMETER, unsupported);
+	put_unaligned_le16(OSF_TEST_UNSUPPORTED_INDEX, unsupported + 2);
+	put_unaligned_le16(1, unsupported + 4);
+	put_unaligned_le16(OSF_SAMPLE_FORMAT_S32, unsupported + 6);
+	put_unaligned_le32(OSF_TEST_SCALE_NANO, unsupported + 8);
+
+	return osf_test_build_frame(buf, buf_size, OSF_MSG_CAPABILITY_REPORT,
+				    payload, sizeof(payload), sequence);
+}
+
+static size_t osf_test_build_sample_frame(u8 *buf, size_t buf_size,
+					  u16 sensor_type, u16 sensor_index,
+					  u16 channel_count, u16 sample_format,
+					  const s32 *values, u64 sequence)
+{
+	u8 payload[OSF_TEST_MAX_PAYLOAD_LEN] = { };
+	u32 payload_len;
+
+	if (!channel_count || channel_count > OSF_MAX_SAMPLE_CHANNELS)
+		return 0;
+
+	put_unaligned_le16(sensor_type, payload);
+	put_unaligned_le16(sensor_index, payload + 2);
+	put_unaligned_le16(channel_count, payload + 4);
+	put_unaligned_le16(sample_format, payload + 6);
+	put_unaligned_le32(OSF_TEST_SCALE_NANO, payload + 8);
+
+	for (u16 i = 0; i < channel_count; i++)
+		put_unaligned_le32(values[i],
+				   payload + OSF_SENSOR_SAMPLE_BASE_LEN +
+				   i * sizeof(__le32));
+
+	payload_len = OSF_SENSOR_SAMPLE_BASE_LEN +
+		      channel_count * sizeof(__le32);
+
+	return osf_test_build_frame(buf, buf_size, OSF_MSG_SENSOR_SAMPLE,
+				    payload, payload_len, sequence);
+}
+
+static size_t osf_test_build_truncated_sample_frame(u8 *buf, size_t buf_size,
+						    u64 sequence)
+{
+	u8 payload[OSF_SENSOR_SAMPLE_BASE_LEN + sizeof(__le32)] = { };
+
+	put_unaligned_le16(OSF_SENSOR_ACCELEROMETER, payload);
+	put_unaligned_le16(OSF_TEST_SENSOR_INDEX, payload + 2);
+	put_unaligned_le16(3, payload + 4);
+	put_unaligned_le16(OSF_SAMPLE_FORMAT_S32, payload + 6);
+	put_unaligned_le32(OSF_TEST_SCALE_NANO, payload + 8);
+	put_unaligned_le32(42, payload + OSF_SENSOR_SAMPLE_BASE_LEN);
+
+	return osf_test_build_frame(buf, buf_size, OSF_MSG_SENSOR_SAMPLE,
+				    payload, sizeof(payload), sequence);
+}
+
+static int osf_test_submit_sample(struct osf_test_context *ctx,
+				  u16 sensor_type, u16 sensor_index,
+				  u16 channel_count, u16 sample_format,
+				  const s32 *values, u64 sequence)
+{
+	u8 frame[OSF_TEST_MAX_FRAME_LEN];
+	size_t frame_len;
+
+	frame_len = osf_test_build_sample_frame(frame, sizeof(frame),
+						sensor_type, sensor_index,
+						channel_count, sample_format,
+						values, sequence);
+	if (!frame_len)
+		return -EINVAL;
+
+	return osf_core_receive_frame(&ctx->osf, frame, frame_len);
+}
+
+static int osf_test_read_raw(struct osf_test_context *ctx,
+			     unsigned int channel, int *value)
+{
+	int value2 = 0;
+
+	return ctx->indio_dev->info->read_raw(ctx->indio_dev,
+					     &ctx->indio_dev->channels[channel],
+					     value, &value2,
+					     IIO_CHAN_INFO_RAW);
+}
+
+static int osf_test_remove_scan(struct osf_test_context *ctx,
+				struct osf_test_scan_3axis *scan)
+{
+	return iio_pop_from_buffer(ctx->buffer, scan);
+}
+
+static int osf_test_enable_buffer(struct osf_test_context *ctx)
+{
+	unsigned long *scan_mask;
+	int ret;
+
+	scan_mask = (unsigned long *)ctx->buffer->scan_mask;
+	for (unsigned int i = 0; i < 3; i++)
+		bitmap_set(scan_mask, ctx->indio_dev->channels[i].scan_index, 1);
+	ret = iio_update_buffers(ctx->indio_dev, ctx->buffer, NULL);
+	if (!ret)
+		ctx->buffer_enabled = true;
+
+	return ret;
+}
+
+static void osf_test_cleanup(void *data)
+{
+	struct osf_test_context *ctx = data;
+
+	if (ctx->buffer_enabled) {
+		iio_update_buffers(ctx->indio_dev, NULL, ctx->buffer);
+		ctx->buffer_enabled = false;
+	}
+
+	osf_core_unregister_iio(&ctx->osf);
+}
+
+static int osf_test_init(struct kunit *test)
+{
+	struct osf_test_context *ctx;
+	u8 frame[OSF_TEST_MAX_FRAME_LEN];
+	size_t frame_len;
+	int ret;
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	test->priv = ctx;
+	ctx->dev = kunit_device_register(test, "osf-core");
+	if (IS_ERR(ctx->dev))
+		return PTR_ERR(ctx->dev);
+	if (!ctx->dev)
+		return -ENOMEM;
+
+	osf_core_init(&ctx->osf, ctx->dev);
+	ret = kunit_add_action_or_reset(test, osf_test_cleanup, ctx);
+	if (ret)
+		return ret;
+
+	frame_len = osf_test_build_capability_frame(frame, sizeof(frame), 1);
+	if (!frame_len)
+		return -EINVAL;
+
+	ret = osf_core_receive_frame(&ctx->osf, frame, frame_len);
+	if (ret != OSF_STREAM_FRAME_HANDLED)
+		return ret < 0 ? ret : -EINVAL;
+	if (ctx->osf.iio_dev_count != 1 ||
+	    ctx->osf.capability_cache.capability_count != 1)
+		return -EINVAL;
+
+	ctx->indio_dev = ctx->osf.iio_devs[0].indio_dev;
+	ctx->buffer = ctx->indio_dev->buffer;
+	if (!ctx->buffer)
+		return -EINVAL;
+
+	return 0;
+}
+
+static void osf_test_expect_direct_sample(struct kunit *test,
+					  struct osf_test_context *ctx,
+					  const s32 *expected)
+{
+	int value;
+	int ret;
+
+	for (unsigned int i = 0; i < 3; i++) {
+		value = 0;
+		ret = osf_test_read_raw(ctx, i, &value);
+		KUNIT_EXPECT_EQ(test, ret, IIO_VAL_INT);
+		KUNIT_EXPECT_EQ(test, value, expected[i]);
+	}
+}
+
+static void
+osf_rejected_channel_count_preserves_latest_test(struct kunit *test)
+{
+	struct osf_test_context *ctx = test->priv;
+	const s32 baseline_values[] = { 11, 22, 33 };
+	const s32 rejected_values[] = { -999 };
+	struct osf_sensor_sample decoded_sample;
+	struct osf_latest_sample baseline;
+	struct osf_test_scan_3axis scan;
+	struct osf_frame decoded_frame;
+	u8 rejected_frame[OSF_TEST_MAX_FRAME_LEN];
+	size_t decoded_len;
+	size_t frame_len;
+	u64 baseline_sequence;
+	int ret;
+
+	KUNIT_ASSERT_EQ(test, osf_test_enable_buffer(ctx), 0);
+	KUNIT_ASSERT_TRUE(test, iio_buffer_enabled(ctx->indio_dev));
+
+	ret = osf_test_submit_sample(ctx, OSF_SENSOR_ACCELEROMETER,
+				     OSF_TEST_SENSOR_INDEX, 3,
+				     OSF_SAMPLE_FORMAT_S32,
+				     baseline_values, 2);
+	KUNIT_ASSERT_EQ(test, ret, OSF_STREAM_FRAME_HANDLED);
+	KUNIT_ASSERT_EQ(test, ctx->osf.latest_sample_count, 1U);
+	osf_test_expect_direct_sample(test, ctx, baseline_values);
+
+	KUNIT_ASSERT_EQ(test, osf_test_remove_scan(ctx, &scan), 0);
+
+	baseline = ctx->osf.latest_samples[0];
+	baseline_sequence = ctx->osf.last_sequence;
+	frame_len = osf_test_build_sample_frame(rejected_frame,
+						sizeof(rejected_frame),
+						OSF_SENSOR_ACCELEROMETER,
+						OSF_TEST_SENSOR_INDEX, 1,
+						OSF_SAMPLE_FORMAT_S32,
+						rejected_values, 3);
+	KUNIT_ASSERT_NE(test, frame_len, (size_t)0);
+	KUNIT_ASSERT_EQ(test,
+			osf_protocol_decode_frame(rejected_frame, frame_len,
+						  &decoded_frame, &decoded_len), 0);
+	KUNIT_ASSERT_EQ(test, decoded_len, frame_len);
+	KUNIT_ASSERT_EQ(test,
+			osf_protocol_decode_sensor_sample(&decoded_frame,
+							  &decoded_sample), 0);
+	KUNIT_ASSERT_EQ(test, decoded_sample.channel_count, (u16)1);
+	ret = osf_core_receive_frame(&ctx->osf, rejected_frame, frame_len);
+	KUNIT_ASSERT_EQ(test, ret, OSF_STREAM_FRAME_REJECTED);
+	KUNIT_EXPECT_EQ(test, ctx->osf.latest_sample_count, 1U);
+	KUNIT_EXPECT_MEMEQ(test, &ctx->osf.latest_samples[0], &baseline,
+			   sizeof(baseline));
+	KUNIT_EXPECT_EQ(test, ctx->osf.last_sequence, baseline_sequence);
+	osf_test_expect_direct_sample(test, ctx, baseline_values);
+	KUNIT_EXPECT_EQ(test, osf_test_remove_scan(ctx, &scan), -EBUSY);
+}
+
+static void
+osf_valid_sample_updates_direct_and_buffer_test(struct kunit *test)
+{
+	struct osf_test_context *ctx = test->priv;
+	const s32 baseline_values[] = { 1, 2, 3 };
+	const s32 rejected_values[] = { -1 };
+	const s32 valid_values[] = { 101, -202, 303 };
+	struct osf_test_scan_3axis scan = { };
+	int ret;
+
+	KUNIT_ASSERT_EQ(test, osf_test_enable_buffer(ctx), 0);
+
+	ret = osf_test_submit_sample(ctx, OSF_SENSOR_ACCELEROMETER,
+				     OSF_TEST_SENSOR_INDEX, 3,
+				     OSF_SAMPLE_FORMAT_S32,
+				     baseline_values, 2);
+	KUNIT_ASSERT_EQ(test, ret, OSF_STREAM_FRAME_HANDLED);
+	KUNIT_ASSERT_EQ(test, osf_test_remove_scan(ctx, &scan), 0);
+
+	ret = osf_test_submit_sample(ctx, OSF_SENSOR_ACCELEROMETER,
+				     OSF_TEST_SENSOR_INDEX, 1,
+				     OSF_SAMPLE_FORMAT_S32,
+				     rejected_values, 3);
+	KUNIT_ASSERT_EQ(test, ret, OSF_STREAM_FRAME_REJECTED);
+	KUNIT_ASSERT_EQ(test, osf_test_remove_scan(ctx, &scan), -EBUSY);
+
+	ret = osf_test_submit_sample(ctx, OSF_SENSOR_ACCELEROMETER,
+				     OSF_TEST_SENSOR_INDEX, 3,
+				     OSF_SAMPLE_FORMAT_S32,
+				     valid_values, 4);
+	KUNIT_ASSERT_EQ(test, ret, OSF_STREAM_FRAME_HANDLED);
+	osf_test_expect_direct_sample(test, ctx, valid_values);
+	KUNIT_ASSERT_EQ(test, ctx->indio_dev->scan_bytes, (int)sizeof(scan));
+	KUNIT_ASSERT_EQ(test, osf_test_remove_scan(ctx, &scan), 0);
+	KUNIT_EXPECT_EQ(test, scan.values[0], valid_values[0]);
+	KUNIT_EXPECT_EQ(test, scan.values[1], valid_values[1]);
+	KUNIT_EXPECT_EQ(test, scan.values[2], valid_values[2]);
+	KUNIT_EXPECT_EQ(test, osf_test_remove_scan(ctx, &scan), -EBUSY);
+}
+
+static void osf_unregistered_sample_is_ignored_test(struct kunit *test)
+{
+	struct osf_test_context *ctx = test->priv;
+	const s32 baseline_values[] = { 10, 20, 30 };
+	const s32 ignored_values[] = { -10, -20, -30 };
+	struct osf_latest_sample baseline;
+	struct osf_test_scan_3axis scan;
+	s32 value;
+	int ret;
+
+	KUNIT_ASSERT_EQ(test, osf_test_enable_buffer(ctx), 0);
+	ret = osf_test_submit_sample(ctx, OSF_SENSOR_ACCELEROMETER,
+				     OSF_TEST_SENSOR_INDEX, 3,
+				     OSF_SAMPLE_FORMAT_S32,
+				     baseline_values, 2);
+	KUNIT_ASSERT_EQ(test, ret, OSF_STREAM_FRAME_HANDLED);
+	KUNIT_ASSERT_EQ(test, osf_test_remove_scan(ctx, &scan), 0);
+	baseline = ctx->osf.latest_samples[0];
+
+	ret = osf_test_submit_sample(ctx, OSF_SENSOR_ACCELEROMETER,
+				     OSF_TEST_SENSOR_INDEX + 1, 3,
+				     OSF_SAMPLE_FORMAT_S32,
+				     ignored_values, 3);
+	KUNIT_ASSERT_EQ(test, ret, OSF_STREAM_FRAME_IGNORED);
+	KUNIT_EXPECT_EQ(test, ctx->osf.iio_dev_count, 1U);
+	KUNIT_EXPECT_EQ(test, ctx->osf.latest_sample_count, 1U);
+	KUNIT_EXPECT_MEMEQ(test, &ctx->osf.latest_samples[0], &baseline,
+			   sizeof(baseline));
+	osf_test_expect_direct_sample(test, ctx, baseline_values);
+	ret = osf_core_read_latest_sample(&ctx->osf,
+					  OSF_SENSOR_ACCELEROMETER,
+					  OSF_TEST_SENSOR_INDEX + 1,
+					  0, &value);
+	KUNIT_EXPECT_EQ(test, ret, -ENODATA);
+	KUNIT_EXPECT_EQ(test, osf_test_remove_scan(ctx, &scan), -EBUSY);
+}
+
+static void
+osf_unaccepted_samples_do_not_exhaust_cache_test(struct kunit *test)
+{
+	struct osf_test_context *ctx = test->priv;
+	const s32 three_values[] = { 7, 8, 9 };
+	const s32 one_value[] = { 42 };
+	struct osf_latest_sample empty_cache[OSF_MAX_CAPABILITIES];
+	struct osf_sensor_sample decoded_sample;
+	struct osf_frame decoded_frame;
+	u8 malformed_frame[OSF_TEST_MAX_FRAME_LEN];
+	size_t decoded_len;
+	size_t frame_len;
+	int value;
+	int ret;
+
+	KUNIT_ASSERT_EQ(test, ctx->osf.latest_sample_count, 0U);
+	memcpy(empty_cache, ctx->osf.latest_samples, sizeof(empty_cache));
+
+	for (unsigned int i = 0; i < OSF_TEST_FLOOD_COUNT; i++) {
+		ret = osf_test_submit_sample(ctx, OSF_SENSOR_ACCELEROMETER,
+					     OSF_TEST_SENSOR_INDEX + i + 1,
+					     3, OSF_SAMPLE_FORMAT_S32,
+					     three_values, 100 + i);
+		KUNIT_ASSERT_EQ(test, ret, OSF_STREAM_FRAME_IGNORED);
+	}
+	KUNIT_ASSERT_EQ(test, ctx->osf.latest_sample_count, 0U);
+
+	for (unsigned int i = 0; i < OSF_TEST_FLOOD_COUNT; i++) {
+		ret = osf_test_submit_sample(ctx, OSF_SENSOR_BAROMETER,
+					     OSF_TEST_UNSUPPORTED_INDEX, 1,
+					     OSF_SAMPLE_FORMAT_S32,
+					     one_value, 200 + i);
+		KUNIT_ASSERT_EQ(test, ret, OSF_STREAM_FRAME_IGNORED);
+	}
+	KUNIT_ASSERT_EQ(test, ctx->osf.latest_sample_count, 0U);
+
+	for (unsigned int i = 0; i < OSF_TEST_FLOOD_COUNT; i++) {
+		ret = osf_test_submit_sample(ctx, OSF_SENSOR_ACCELEROMETER,
+					     OSF_TEST_SENSOR_INDEX, 1,
+					     OSF_SAMPLE_FORMAT_S32,
+					     one_value, 300 + i);
+		KUNIT_ASSERT_EQ(test, ret, OSF_STREAM_FRAME_REJECTED);
+	}
+	KUNIT_ASSERT_EQ(test, ctx->osf.latest_sample_count, 0U);
+
+	frame_len = osf_test_build_truncated_sample_frame(malformed_frame,
+							  sizeof(malformed_frame), 400);
+	KUNIT_ASSERT_NE(test, frame_len, (size_t)0);
+	KUNIT_ASSERT_EQ(test,
+			osf_protocol_decode_frame(malformed_frame, frame_len,
+						  &decoded_frame, &decoded_len), 0);
+	KUNIT_ASSERT_EQ(test, decoded_len, frame_len);
+	KUNIT_ASSERT_EQ(test,
+			osf_protocol_decode_sensor_sample(&decoded_frame,
+							  &decoded_sample),
+			-EMSGSIZE);
+
+	for (unsigned int i = 0; i < OSF_TEST_FLOOD_COUNT; i++) {
+		ret = osf_core_receive_frame(&ctx->osf, malformed_frame,
+					     frame_len);
+		KUNIT_ASSERT_EQ(test, ret, OSF_STREAM_FRAME_REJECTED);
+	}
+	KUNIT_ASSERT_EQ(test, ctx->osf.latest_sample_count, 0U);
+
+	KUNIT_EXPECT_MEMEQ(test, ctx->osf.latest_samples, empty_cache,
+			   sizeof(empty_cache));
+	KUNIT_EXPECT_EQ(test, ctx->osf.last_sequence, (u64)1);
+
+	ret = osf_test_submit_sample(ctx, OSF_SENSOR_ACCELEROMETER,
+				     OSF_TEST_SENSOR_INDEX, 3,
+				     OSF_SAMPLE_FORMAT_S32,
+				     three_values, 500);
+	KUNIT_ASSERT_EQ(test, ret, OSF_STREAM_FRAME_HANDLED);
+	KUNIT_ASSERT_EQ(test, ctx->osf.latest_sample_count, 1U);
+
+	for (unsigned int i = 0; i < 3; i++) {
+		value = 0;
+		ret = osf_test_read_raw(ctx, i, &value);
+		KUNIT_ASSERT_EQ(test, ret, IIO_VAL_INT);
+		KUNIT_EXPECT_EQ(test, value, three_values[i]);
+	}
+}
+
+static struct kunit_case osf_core_test_cases[] = {
+	KUNIT_CASE(osf_rejected_channel_count_preserves_latest_test),
+	KUNIT_CASE(osf_valid_sample_updates_direct_and_buffer_test),
+	KUNIT_CASE(osf_unregistered_sample_is_ignored_test),
+	KUNIT_CASE(osf_unaccepted_samples_do_not_exhaust_cache_test),
+	{ }
+};
+
+static struct kunit_suite osf_core_test_suite = {
+	.name = "osf-core",
+	.init = osf_test_init,
+	.test_cases = osf_core_test_cases,
+};
+
+kunit_test_suite(osf_core_test_suite);
+
+MODULE_LICENSE("GPL");
diff --git a/drivers/iio/opensensorfusion/osf_iio.c b/drivers/iio/opensensorfusion/osf_iio.c
new file mode 100644
index 000000000000..56030b4d6a9f
--- /dev/null
+++ b/drivers/iio/opensensorfusion/osf_iio.c
@@ -0,0 +1,304 @@
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
+#define OSF_MOD_CHAN(_type, _mod, _idx)                         \
+	{                                                               \
+		.type = (_type),                                           \
+		.modified = 1,                                             \
+		.channel2 = (_mod),                                        \
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),              \
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),      \
+		.scan_index = (_idx),                                      \
+		.scan_type = {                                             \
+			.sign = 's',                                         \
+			.realbits = 32,                                      \
+			.storagebits = 32,                                   \
+			.endianness = IIO_CPU,                               \
+		},                                                        \
+	}
+
+#define OSF_CHAN(_type, _idx)                                     \
+	{                                                               \
+		.type = (_type),                                           \
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),              \
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),      \
+		.scan_index = (_idx),                                      \
+		.scan_type = {                                             \
+			.sign = 's',                                         \
+			.realbits = 32,                                      \
+			.storagebits = 32,                                   \
+			.endianness = IIO_CPU,                               \
+		},                                                        \
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
+	if (entry->sample_format != OSF_SAMPLE_FORMAT_S32 ||
+	    (entry->flags & ~OSF_CAPABILITY_FLAGS_MASK) ||
+	    entry->reserved)
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
+
+	if (channel_count != state->spec->channel_count)
+		return -EPROTO;
+
+	if (!iio_buffer_enabled(indio_dev))
+		return 0;
+
+	timestamp = iio_get_time_ns(indio_dev);
+
+	switch (channel_count) {
+	case 1: {
+		struct osf_iio_scan_1axis scan = { };
+
+		scan.value = values[0];
+		return iio_push_to_buffers_with_ts(indio_dev, &scan,
+						       sizeof(scan), timestamp);
+	}
+	case 3: {
+		struct osf_iio_scan_3axis scan = { };
+
+		scan.values[0] = values[0];
+		scan.values[1] = values[1];
+		scan.values[2] = values[2];
+		return iio_push_to_buffers_with_ts(indio_dev, &scan,
+						       sizeof(scan), timestamp);
+	}
+	default:
+		return -EPROTO;
+	}
+}
diff --git a/drivers/iio/opensensorfusion/osf_iio.h b/drivers/iio/opensensorfusion/osf_iio.h
new file mode 100644
index 000000000000..d0745167f8e0
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
index 000000000000..d21f2f27a6de
--- /dev/null
+++ b/drivers/iio/opensensorfusion/osf_serdev.c
@@ -0,0 +1,124 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/device-id/of.h>
+#include <linux/device.h>
+#include <linux/errno.h>
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
+static int osf_serdev_receive_frame(void *context, const u8 *buf, size_t len)
+{
+	struct osf_device *osf = context;
+
+	return osf_core_receive_frame(osf, buf, len);
+}
+
+static size_t osf_serdev_receive_buf(struct serdev_device *serdev,
+				     const u8 *buf, size_t count)
+{
+	struct osf_serdev *osf_uart = serdev_device_get_drvdata(serdev);
+	const struct osf_stream_stats *stats;
+	u64 authenticated_before;
+	int ret;
+
+	authenticated_before = osf_uart->stream.stats.authenticated_frames;
+	ret = osf_stream_receive_bytes(&osf_uart->stream, buf, count);
+	stats = &osf_uart->stream.stats;
+
+	if (ret || stats->authenticated_frames != authenticated_before)
+		dev_dbg_ratelimited(&serdev->dev,
+				    "rx count=%zu authenticated=%llu handled=%llu ignored=%llu rejected=%llu bad_magic=%llu bad_crc=%llu dropped=%llu ret=%d\n",
+				    count, stats->authenticated_frames,
+				    stats->handled_frames, stats->ignored_frames,
+				    stats->rejected_frames,
+				    stats->bad_magic_resyncs,
+				    stats->bad_crc_frames,
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
+	osf_stream_init(&osf_uart->stream, osf_serdev_receive_frame,
+			&osf_uart->osf);
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

