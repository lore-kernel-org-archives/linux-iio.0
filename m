Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7B036DA15
	for <linux-iio@vger.kernel.org>; Wed, 20 May 2026 07:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779262159; cv=none; b=tikOrjCrwfAUkwi+d11g79KvD86tssaAQBc0y5e3cpr9DZma2hTSYQKptLaS8Z59bArD6GorSa+BFm3/mXVGnFU3Mj3XLVsw29HVxuS3cRnthWLAy7+O3Lsc/nAK+3fvyo6c2OI1esPWMnw1Vwzbh0iEKHofS9vZaHCUjWqVY4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779262159; c=relaxed/simple;
	bh=Gu27Dom3lyD2xAWq/J9qYhU3INYVUnIv5dHBpDjb4SY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bycnQWdvBnvq7ejrmFplRRadcwqNHDcfgdHfZ9mu+JHsPi8LfFGwoIh9j1UbgCO4GkrdhgoyU23kGejhempoqRAotgMVLNqPFDRrTq9jhriUC0zBfOlYj6Rbd7aFn9BJjIAW5gu9RjBuxZL9MkL1M9LqGQk29GpaHlb7bLoU+eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eDw6LSx9; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eDw6LSx9"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2baef9f5ecdso35954205ad.1
        for <linux-iio@vger.kernel.org>; Wed, 20 May 2026 00:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779262155; x=1779866955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fz5bVeel0FFil37S+isgnhG4r6yAXdYjxLmUxtppSew=;
        b=eDw6LSx9kjpM7qAj3NTft19BTN9s5dVb+Dw++oQY3YGw8p9rN7meHbD4JbIYqLxRVB
         IhxYMcWtysy1DuZ2o977YfFhScSK3bXA1MotBJ7sL3GfdXJ1pLEtHlHPgEwS6luU90F3
         82g7klu2mhF+N1J9VCQfrhOQYFTsojF0za9UrFRbJ4aiKWWfEUWYgWOFxhsEfx77DLBL
         8TV0qlJNIgkFAxEoY0j84BlDVklCJhsXNEGXbcLUXvscO0mcqKcDuczy+3kuQgzslpMG
         zoxRupPrPVOvwcgVQkJl8XwJ+UqKZFzzEXIAsGx9QnoMtqdMNF+b7a7cC3xTuTvt0MJR
         hauA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779262155; x=1779866955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Fz5bVeel0FFil37S+isgnhG4r6yAXdYjxLmUxtppSew=;
        b=j64st1xu9MbLQW7SBkb4xbmcMwQqx1VUDdLH+MexbLHViNsar1W88knkWZ7N2zIRcq
         NW1pMPHQzLldh4FGQx+dTVJ0Q0+2/lC0LhlMWiWcnWWjWQczS69JVCpuC5aeUxnFqFkP
         C+l2p0MYwCVtJhiIt/nN3LVH5mALqKFbq7E969p5ANT2AG22m+JsLAljRhZ5tFr2hJF2
         SwwhDeRSaBKQ/tp8BRPq4O79uvTRkFdKMmrLYhy4SrO9o7T3RJDy0lmGf8pQ3lA2E1eO
         09lZwkkeBM6qsH86z65D8NVgXMRwguKbV0XrxRtcCWxDZ6c5ILr7URh8ihS6oJlov63D
         GahQ==
X-Forwarded-Encrypted: i=1; AFNElJ+44dEj6lMmnZdSwn0LqC564UmrLfDAlr05UtEJp+hQi9QsqHLnjdPnVgP1fSrEjpDv4eHrsg81BkM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoSlpbu0MfQFIhF9fPcPAIWTDtuRpHDtwICVmy5z/C1V5/G5wM
	LrEuJSS37UEXF5jDilyID/LrxCb/VdxaMQvhYVAMRQC+oRYM41S9jzEl
X-Gm-Gg: Acq92OFOsHa7c1/1pRm4pqcH/zdw0PEESoRemtLzIXgbaD/mfNcU5piwUzmHUFqpGAV
	iZuNZ3auDEJXsh7CzNIeQOtLhBXDpGQWRA+eBWeO2juZgrc36CbKVIxJTHSFfUtYbekxLcREWe3
	/04E6aH3Rk4Nie+1pSXvoL103dohiOPiTkLSAWoqck05rpm/OXqOHAHwGI4/q6cHvolvDCCbGak
	1TJDceD8uIehfDEllUCKGJ7Td1NIT8nIHV+rDjdya+3dDm7xpdCjmzfUNlaj3t8Nuii2t+ENxR7
	7qxGUdwnjdyyRDU/qHmd47CaA2VhkEAP6G3hZshzFM0gS2rAA/2zd/hHIsCN7yLWBQjwN6ZIwmJ
	0QaXuzqQkkoct6ZFdFTGHe3d2JZ5En0570hNPcalWMXDbadHOJZ6dKN5593nx7qkgSI/yIdaRK4
	iJeynRUL+8K0mEePnIB4+Ns//uoisYAG0YrPxlIz7gNd35jJjnWXMsszeav2GoosuhxywLpEaAE
	Mz2qr8y0ufxROXe2XV/ZTZ2geBVIOlcHUfVYAgnmdbkS/AB1BOGhpjym9A=
X-Received: by 2002:a17:902:f144:b0:2bc:b141:8551 with SMTP id d9443c01a7336-2bd7e87ed77mr188200855ad.19.1779262154965;
        Wed, 20 May 2026 00:29:14 -0700 (PDT)
Received: from DESKTOP-G3E0OSP.localdomain ([112.172.255.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5c05f27csm206258595ad.25.2026.05.20.00.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 00:29:14 -0700 (PDT)
From: Jinseob Kim <kimjinseob88@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC 2/3] iio: osf: add Open Sensor Fusion UART IIO driver
Date: Wed, 20 May 2026 16:28:42 +0900
Message-ID: <20260520072843.3593-3-kimjinseob88@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520072843.3593-1-kimjinseob88@gmail.com>
References: <20260520072843.3593-1-kimjinseob88@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the initial Open Sensor Fusion UART IIO driver.

This includes the protocol v0 parser, OSF0 stream assembler, core
capability/sample cache, serdev UART transport, IIO read_raw path, and
software kfifo buffer support.

The first RFC keeps the driver code in one patch to avoid intermediate
non-buildable states. The internal files still separate protocol, stream,
core, transport, and IIO code.

The tested path is STM32F405 test firmware OSF UART stream to Raspberry Pi
serdev, then IIO read_raw and buffered userspace reads.

Not included here: real sensor reads, USB transport, fusion/AHRS/Kalman,
runtime capability removal, or production timestamp correlation.

Signed-off-by: Jinseob Kim <kimjinseob88@gmail.com>
---
 drivers/iio/Kconfig                         |   1 +
 drivers/iio/Makefile                        |   1 +
 drivers/iio/opensensorfusion/Kconfig        |  15 +
 drivers/iio/opensensorfusion/Makefile       |   6 +
 drivers/iio/opensensorfusion/osf_core.c     | 334 ++++++++++++++++++
 drivers/iio/opensensorfusion/osf_core.h     |  81 +++++
 drivers/iio/opensensorfusion/osf_iio.c      | 268 +++++++++++++++
 drivers/iio/opensensorfusion/osf_iio.h      |  21 ++
 drivers/iio/opensensorfusion/osf_protocol.c | 234 +++++++++++++
 drivers/iio/opensensorfusion/osf_protocol.h | 100 ++++++
 drivers/iio/opensensorfusion/osf_serdev.c   | 354 ++++++++++++++++++++
 drivers/iio/opensensorfusion/osf_serdev.h   |   8 +
 drivers/iio/opensensorfusion/osf_stream.c   | 212 ++++++++++++
 drivers/iio/opensensorfusion/osf_stream.h   |  31 ++
 14 files changed, 1666 insertions(+)
 create mode 100644 drivers/iio/opensensorfusion/Kconfig
 create mode 100644 drivers/iio/opensensorfusion/Makefile
 create mode 100644 drivers/iio/opensensorfusion/osf_core.c
 create mode 100644 drivers/iio/opensensorfusion/osf_core.h
 create mode 100644 drivers/iio/opensensorfusion/osf_iio.c
 create mode 100644 drivers/iio/opensensorfusion/osf_iio.h
 create mode 100644 drivers/iio/opensensorfusion/osf_protocol.c
 create mode 100644 drivers/iio/opensensorfusion/osf_protocol.h
 create mode 100644 drivers/iio/opensensorfusion/osf_serdev.c
 create mode 100644 drivers/iio/opensensorfusion/osf_serdev.h
 create mode 100644 drivers/iio/opensensorfusion/osf_stream.c
 create mode 100644 drivers/iio/opensensorfusion/osf_stream.h

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
index 000000000..1db1dbe56
--- /dev/null
+++ b/drivers/iio/opensensorfusion/Kconfig
@@ -0,0 +1,15 @@
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
+	  This includes the serdev UART receive path for OSF0 protocol
+	  bring-up. It does not include real sensor reads, USB transport,
+	  or fusion/AHRS/Kalman output.
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
index 000000000..fd2eccefc
--- /dev/null
+++ b/drivers/iio/opensensorfusion/osf_core.c
@@ -0,0 +1,334 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/ktime.h>
+#include <linux/module.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+
+#include "osf_core.h"
+#include "osf_serdev.h"
+
+#define OSF_RESERVED_MSG_FIRST		0x7f00
+#define OSF_RESERVED_MSG_LAST		0x7fff
+#define OSF_VENDOR_PRIVATE_FIRST	0x8000
+
+static struct osf_latest_sample *
+osf_core_find_latest_sample(struct osf_device *osf, u16 sensor_type,
+			    u16 sensor_index, bool allocate)
+{
+	struct osf_latest_sample *free_slot = NULL;
+	struct osf_latest_sample *latest;
+	unsigned int i;
+
+	for (i = 0; i < OSF_MAX_LATEST_SAMPLES; i++) {
+		latest = &osf->latest_samples[i];
+		if (!latest->valid) {
+			if (!free_slot)
+				free_slot = latest;
+			continue;
+		}
+
+		if (latest->sensor_type == sensor_type &&
+		    latest->sensor_index == sensor_index)
+			return latest;
+	}
+
+	return allocate ? free_slot : NULL;
+}
+
+static void osf_core_store_latest_sample(struct osf_latest_sample *latest,
+					 const struct osf_sensor_sample *sample,
+					 const s32 *values,
+					 const struct osf_frame *frame)
+{
+	unsigned int i;
+
+	for (i = 0; i < sample->channel_count; i++)
+		latest->values[i] = values[i];
+
+	for (; i < OSF_MAX_SAMPLE_CHANNELS; i++)
+		latest->values[i] = 0;
+
+	latest->sensor_type = sample->sensor_type;
+	latest->sensor_index = sample->sensor_index;
+	latest->channel_count = sample->channel_count;
+	latest->sample_format = sample->sample_format;
+	latest->scale_nano = sample->scale_nano;
+	latest->sequence = frame->sequence;
+	latest->timestamp_us = frame->timestamp_us;
+	latest->valid = true;
+}
+
+static int osf_core_handle_sensor_sample(struct osf_device *osf,
+					 const struct osf_frame *frame)
+{
+	osf_sample_callback_t callback;
+	void *callback_context;
+	struct osf_latest_sample *latest;
+	struct osf_sample_event event = { };
+	struct osf_sensor_sample sample;
+	s32 values[OSF_MAX_SAMPLE_CHANNELS] = { };
+	unsigned long flags;
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
+
+	event.sensor_type = sample.sensor_type;
+	event.sensor_index = sample.sensor_index;
+	event.channel_count = sample.channel_count;
+	event.sample_format = sample.sample_format;
+	event.scale_nano = sample.scale_nano;
+	event.sequence = frame->sequence;
+	event.timestamp_us = frame->timestamp_us;
+	event.host_timestamp_ns = ktime_get_ns();
+	for (i = 0; i < sample.channel_count; i++)
+		event.values[i] = values[i];
+
+	spin_lock_irqsave(&osf->lock, flags);
+	latest = osf_core_find_latest_sample(osf, sample.sensor_type,
+					     sample.sensor_index, true);
+	if (!latest) {
+		spin_unlock_irqrestore(&osf->lock, flags);
+		return -ENOSPC;
+	}
+
+	osf_core_store_latest_sample(latest, &sample, values, frame);
+	osf_core_store_latest_sample(&osf->latest_sample, &sample, values,
+				     frame);
+	osf->last_sequence = frame->sequence;
+	callback = osf->sample_callback;
+	callback_context = osf->sample_callback_context;
+	spin_unlock_irqrestore(&osf->lock, flags);
+
+	if (callback)
+		callback(callback_context, &event);
+
+	return 0;
+}
+
+static int osf_core_handle_device_status(struct osf_device *osf,
+					 const struct osf_frame *frame)
+{
+	struct osf_status_cache cache = { };
+	struct osf_device_status status;
+	unsigned long flags;
+	int ret;
+
+	ret = osf_protocol_decode_device_status(frame, &status);
+	if (ret)
+		return ret;
+
+	if (status.reserved)
+		return -EPROTO;
+
+	cache.uptime_s = status.uptime_s;
+	cache.status_flags = status.status_flags;
+	cache.error_flags = status.error_flags;
+	cache.dropped_frames = status.dropped_frames;
+	cache.sequence = frame->sequence;
+	cache.valid = true;
+	spin_lock_irqsave(&osf->lock, flags);
+	osf->status_cache = cache;
+	osf->last_sequence = frame->sequence;
+	spin_unlock_irqrestore(&osf->lock, flags);
+
+	return 0;
+}
+
+static int osf_core_handle_capability_report(struct osf_device *osf,
+					     const struct osf_frame *frame)
+{
+	struct osf_capability_cache cache = { };
+	struct osf_capability_report report;
+	unsigned long flags;
+	unsigned int i;
+	int ret;
+
+	ret = osf_protocol_decode_capability_report(frame, &report);
+	if (ret)
+		return ret;
+
+	if (report.capability_count > OSF_MAX_CAPABILITIES)
+		return -E2BIG;
+
+	for (i = 0; i < report.capability_count; i++) {
+		ret = osf_protocol_decode_capability_entry(&report, i,
+							   &cache.entries[i]);
+		if (ret)
+			return ret;
+	}
+
+	cache.capability_count = report.capability_count;
+	cache.sequence = frame->sequence;
+	cache.valid = true;
+	spin_lock_irqsave(&osf->lock, flags);
+	osf->capability_cache = cache;
+	osf->last_sequence = frame->sequence;
+	spin_unlock_irqrestore(&osf->lock, flags);
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
+	if (!osf || !buf)
+		return -EINVAL;
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
+				u16 sensor_index, unsigned int channel,
+				s32 *value)
+{
+	const struct osf_latest_sample *latest;
+	unsigned long flags;
+	int ret = 0;
+
+	if (!osf || !value)
+		return -EINVAL;
+
+	spin_lock_irqsave(&osf->lock, flags);
+	latest = osf_core_find_latest_sample(osf, sensor_type,
+					     sensor_index, false);
+	if (!latest)
+		latest = &osf->latest_sample;
+
+	if (!latest->valid) {
+		ret = -ENODATA;
+		goto out_unlock;
+	}
+
+	if (latest->sensor_type != sensor_type ||
+	    latest->sensor_index != sensor_index) {
+		ret = -ENODATA;
+		goto out_unlock;
+	}
+
+	if (channel >= latest->channel_count) {
+		ret = -ENODATA;
+		goto out_unlock;
+	}
+
+	*value = latest->values[channel];
+
+out_unlock:
+	spin_unlock_irqrestore(&osf->lock, flags);
+
+	return ret;
+}
+
+void osf_core_init_device(struct osf_device *osf)
+{
+	if (!osf)
+		return;
+
+	spin_lock_init(&osf->lock);
+	osf->sample_callback = NULL;
+	osf->sample_callback_context = NULL;
+}
+
+bool osf_core_copy_capability_cache(struct osf_device *osf,
+				    struct osf_capability_cache *cache)
+{
+	unsigned long flags;
+	bool valid;
+
+	if (!osf || !cache)
+		return false;
+
+	spin_lock_irqsave(&osf->lock, flags);
+	valid = osf->capability_cache.valid;
+	if (valid)
+		*cache = osf->capability_cache;
+	spin_unlock_irqrestore(&osf->lock, flags);
+
+	return valid;
+}
+
+bool osf_core_capability_sequence(struct osf_device *osf, u64 *sequence)
+{
+	unsigned long flags;
+	bool valid;
+
+	if (!osf || !sequence)
+		return false;
+
+	spin_lock_irqsave(&osf->lock, flags);
+	valid = osf->capability_cache.valid;
+	if (valid)
+		*sequence = osf->capability_cache.sequence;
+	spin_unlock_irqrestore(&osf->lock, flags);
+
+	return valid;
+}
+
+void osf_core_set_sample_callback(struct osf_device *osf,
+				  osf_sample_callback_t callback,
+				  void *context)
+{
+	unsigned long flags;
+
+	if (!osf)
+		return;
+
+	spin_lock_irqsave(&osf->lock, flags);
+	osf->sample_callback = callback;
+	osf->sample_callback_context = context;
+	spin_unlock_irqrestore(&osf->lock, flags);
+}
+
+static int __init osf_core_init(void)
+{
+	return osf_serdev_register_driver();
+}
+
+static void __exit osf_core_exit(void)
+{
+	osf_serdev_unregister_driver();
+}
+
+module_init(osf_core_init);
+module_exit(osf_core_exit);
+
+MODULE_DESCRIPTION("Open Sensor Fusion IIO skeleton");
+MODULE_LICENSE("GPL");
diff --git a/drivers/iio/opensensorfusion/osf_core.h b/drivers/iio/opensensorfusion/osf_core.h
new file mode 100644
index 000000000..882683721
--- /dev/null
+++ b/drivers/iio/opensensorfusion/osf_core.h
@@ -0,0 +1,81 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _OSF_CORE_H
+#define _OSF_CORE_H
+
+#include <linux/spinlock.h>
+#include <linux/types.h>
+
+#include "osf_protocol.h"
+
+#define OSF_MAX_SAMPLE_CHANNELS	3
+#define OSF_MAX_CAPABILITIES	16
+#define OSF_MAX_LATEST_SAMPLES	OSF_MAX_CAPABILITIES
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
+struct osf_sample_event {
+	u16 sensor_type;
+	u16 sensor_index;
+	u16 channel_count;
+	u16 sample_format;
+	u32 scale_nano;
+	s32 values[OSF_MAX_SAMPLE_CHANNELS];
+	u64 sequence;
+	u64 timestamp_us;
+	s64 host_timestamp_ns;
+};
+
+typedef void (*osf_sample_callback_t)(void *context,
+				      const struct osf_sample_event *event);
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
+struct osf_device {
+	/* Protects latest sample, capability, status, and callback state. */
+	spinlock_t lock;
+	struct osf_latest_sample latest_sample;
+	struct osf_latest_sample latest_samples[OSF_MAX_LATEST_SAMPLES];
+	struct osf_capability_cache capability_cache;
+	struct osf_status_cache status_cache;
+	u64 last_sequence;
+	osf_sample_callback_t sample_callback;
+	void *sample_callback_context;
+};
+
+void osf_core_init_device(struct osf_device *osf);
+int osf_core_receive_frame(struct osf_device *osf, const u8 *buf, size_t len);
+int osf_core_read_latest_sample(struct osf_device *osf, u16 sensor_type,
+				u16 sensor_index, unsigned int channel,
+				s32 *value);
+bool osf_core_copy_capability_cache(struct osf_device *osf,
+				    struct osf_capability_cache *cache);
+bool osf_core_capability_sequence(struct osf_device *osf, u64 *sequence);
+void osf_core_set_sample_callback(struct osf_device *osf,
+				  osf_sample_callback_t callback,
+				  void *context);
+
+#endif
diff --git a/drivers/iio/opensensorfusion/osf_iio.c b/drivers/iio/opensensorfusion/osf_iio.c
new file mode 100644
index 000000000..3d2674e43
--- /dev/null
+++ b/drivers/iio/opensensorfusion/osf_iio.c
@@ -0,0 +1,268 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/bitops.h>
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/kfifo_buf.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+
+#include "osf_core.h"
+#include "osf_iio.h"
+
+#define OSF_SCALE_NANO		1000000000U
+#define OSF_IIO_SCAN_BYTES						\
+	(ALIGN(OSF_MAX_SAMPLE_CHANNELS * sizeof(s32), sizeof(s64)) +	\
+	 sizeof(s64))
+
+struct osf_iio_sensor_spec {
+	u16 sensor_type;
+	u16 channel_count;
+	const char *name;
+	const struct iio_chan_spec *channels;
+	unsigned int num_channels;
+};
+
+struct osf_iio_state {
+	const struct osf_iio_sensor_spec *spec;
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
+		.endianness = IIO_LE,					\
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
+static const struct osf_iio_sensor_spec osf_iio_sensor_specs[] = {
+	{
+		.sensor_type = OSF_SENSOR_ACCELEROMETER,
+		.channel_count = 3,
+		.name = "osf-accel",
+		.channels = osf_accel_channels,
+		.num_channels = ARRAY_SIZE(osf_accel_channels),
+	},
+	{
+		.sensor_type = OSF_SENSOR_GYROSCOPE,
+		.channel_count = 3,
+		.name = "osf-gyro",
+		.channels = osf_gyro_channels,
+		.num_channels = ARRAY_SIZE(osf_gyro_channels),
+	},
+	{
+		.sensor_type = OSF_SENSOR_MAGNETOMETER,
+		.channel_count = 3,
+		.name = "osf-magn",
+		.channels = osf_mag_channels,
+		.num_channels = ARRAY_SIZE(osf_mag_channels),
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
+		if (!state->osf)
+			return -ENODATA;
+
+		if (chan->scan_index < 0)
+			return -EINVAL;
+
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
+		*val = state->scale_nano / OSF_SCALE_NANO;
+		*val2 = state->scale_nano % OSF_SCALE_NANO;
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
+int osf_iio_push_sample(struct iio_dev *indio_dev,
+			const struct osf_sample_event *event)
+{
+	struct osf_iio_state *state;
+	u8 scan[OSF_IIO_SCAN_BYTES] __aligned(8) = { };
+	s32 *scan_values = (s32 *)scan;
+	unsigned int i;
+
+	if (!indio_dev || !event)
+		return -EINVAL;
+
+	if (!iio_buffer_enabled(indio_dev))
+		return 0;
+
+	state = iio_priv(indio_dev);
+	if (event->sensor_type != state->spec->sensor_type ||
+	    event->sensor_index != state->sensor_index)
+		return -EINVAL;
+
+	if (event->sample_format != OSF_SAMPLE_FORMAT_S32 ||
+	    event->channel_count != state->spec->channel_count ||
+	    event->channel_count > OSF_MAX_SAMPLE_CHANNELS)
+		return -EINVAL;
+
+	for (i = 0; i < event->channel_count; i++)
+		scan_values[i] = event->values[i];
+
+	return iio_push_to_buffers_with_timestamp(indio_dev, scan,
+						  event->host_timestamp_ns);
+}
+
+int osf_iio_register_sensor(struct device *dev,
+			    const struct osf_capability_entry *entry,
+			    void *driver_data, struct iio_dev **indio_dev)
+{
+	const struct osf_iio_sensor_spec *spec;
+	struct osf_iio_state *state;
+	struct iio_dev *iio_dev;
+	int ret;
+
+	if (!dev || !entry)
+		return -EINVAL;
+
+	spec = osf_iio_find_sensor_spec(entry->sensor_type,
+					entry->channel_count);
+	if (!spec)
+		return -EOPNOTSUPP;
+
+	if (entry->sample_format != OSF_SAMPLE_FORMAT_S32)
+		return -EOPNOTSUPP;
+
+	iio_dev = devm_iio_device_alloc(dev, sizeof(*state));
+	if (!iio_dev)
+		return -ENOMEM;
+
+	state = iio_priv(iio_dev);
+	state->spec = spec;
+	state->scale_nano = entry->scale_nano;
+	state->sensor_index = entry->sensor_index;
+	state->osf = driver_data;
+
+	iio_dev->name = spec->name;
+	iio_dev->info = &osf_iio_info;
+	iio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;
+	iio_dev->channels = spec->channels;
+	iio_dev->num_channels = spec->num_channels;
+
+	ret = devm_iio_kfifo_buffer_setup(dev, iio_dev, NULL);
+	if (ret)
+		return ret;
+
+	ret = devm_iio_device_register(dev, iio_dev);
+	if (ret)
+		return ret;
+
+	if (indio_dev)
+		*indio_dev = iio_dev;
+
+	return 0;
+}
diff --git a/drivers/iio/opensensorfusion/osf_iio.h b/drivers/iio/opensensorfusion/osf_iio.h
new file mode 100644
index 000000000..1e8d7a39b
--- /dev/null
+++ b/drivers/iio/opensensorfusion/osf_iio.h
@@ -0,0 +1,21 @@
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
+struct osf_sample_event;
+
+int osf_iio_register_sensor(struct device *dev,
+			    const struct osf_capability_entry *entry,
+			    void *driver_data, struct iio_dev **indio_dev);
+int osf_iio_push_sample(struct iio_dev *indio_dev,
+			const struct osf_sample_event *event);
+bool osf_iio_sensor_supported(u16 sensor_type, u16 channel_count);
+const char *osf_iio_sensor_name(u16 sensor_type);
+
+#endif
diff --git a/drivers/iio/opensensorfusion/osf_protocol.c b/drivers/iio/opensensorfusion/osf_protocol.c
new file mode 100644
index 000000000..8235d3af5
--- /dev/null
+++ b/drivers/iio/opensensorfusion/osf_protocol.c
@@ -0,0 +1,234 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/crc32.h>
+#include <linux/errno.h>
+#include <linux/types.h>
+
+#include "osf_protocol.h"
+
+#define OSF_CRC32_INIT		0xffffffffU
+#define OSF_CRC32_XOROUT	0xffffffffU
+
+static u16 osf_get_le16(const u8 *buf)
+{
+	return buf[0] | buf[1] << 8;
+}
+
+static u32 osf_get_le32(const u8 *buf)
+{
+	return (u32)buf[0] | (u32)buf[1] << 8 |
+	       (u32)buf[2] << 16 | (u32)buf[3] << 24;
+}
+
+static u64 osf_get_le64(const u8 *buf)
+{
+	return (u64)osf_get_le32(buf) | (u64)osf_get_le32(buf + 4) << 32;
+}
+
+static bool osf_sensor_type_valid(u16 sensor_type)
+{
+	return sensor_type >= OSF_SENSOR_ACCELEROMETER &&
+	       sensor_type <= OSF_SENSOR_PROXIMITY;
+}
+
+static u32 osf_crc32_ieee(const u8 *buf, size_t len)
+{
+	return crc32_le(OSF_CRC32_INIT, buf, len) ^ OSF_CRC32_XOROUT;
+}
+
+int osf_protocol_decode_frame(const u8 *buf, size_t len,
+			      struct osf_frame *frame, size_t *frame_len)
+{
+	u32 expected_crc;
+	u32 actual_crc;
+	u32 payload_len;
+	size_t total_len;
+	u8 major;
+
+	if (!buf || !frame || !frame_len)
+		return -EINVAL;
+
+	if (len < OSF_FRAME_MIN_LEN)
+		return -EMSGSIZE;
+
+	if (buf[0] != 'O' || buf[1] != 'S' || buf[2] != 'F' || buf[3] != '0')
+		return -EPROTO;
+
+	major = buf[4];
+	if (major != OSF_PROTOCOL_MAJOR)
+		return -EPROTO;
+
+	if (osf_get_le16(buf + 6) != OSF_FRAME_HEADER_LEN)
+		return -EPROTO;
+
+	payload_len = osf_get_le32(buf + 10);
+	if (payload_len > len - OSF_FRAME_MIN_LEN)
+		return -EMSGSIZE;
+
+	total_len = OSF_FRAME_HEADER_LEN + payload_len + OSF_FRAME_CRC_LEN;
+	expected_crc = osf_crc32_ieee(buf, OSF_FRAME_HEADER_LEN + payload_len);
+	actual_crc = osf_get_le32(buf + OSF_FRAME_HEADER_LEN + payload_len);
+
+	if (actual_crc != expected_crc)
+		return -EBADMSG;
+
+	frame->protocol_minor = buf[5];
+	frame->message_type = osf_get_le16(buf + 8);
+	frame->payload_len = payload_len;
+	frame->sequence = osf_get_le64(buf + 14);
+	frame->timestamp_us = osf_get_le64(buf + 22);
+	frame->flags = osf_get_le32(buf + 30);
+	frame->reserved = osf_get_le32(buf + 34);
+	frame->payload = buf + OSF_FRAME_HEADER_LEN;
+	frame->crc = actual_crc;
+	*frame_len = total_len;
+
+	return 0;
+}
+
+int osf_protocol_decode_sensor_sample(const struct osf_frame *frame,
+				      struct osf_sensor_sample *sample)
+{
+	u16 channel_count;
+	u16 sample_format;
+	u32 expected_len;
+	const u8 *payload;
+
+	if (!frame || !sample || !frame->payload)
+		return -EINVAL;
+
+	if (frame->message_type != OSF_MSG_SENSOR_SAMPLE)
+		return -EPROTO;
+
+	if (frame->payload_len < OSF_SENSOR_SAMPLE_BASE_LEN)
+		return -EMSGSIZE;
+
+	payload = frame->payload;
+	channel_count = osf_get_le16(payload + 4);
+	sample_format = osf_get_le16(payload + 6);
+
+	if (sample_format != OSF_SAMPLE_FORMAT_S32)
+		return -EPROTO;
+
+	expected_len = OSF_SENSOR_SAMPLE_BASE_LEN + channel_count * sizeof(s32);
+	if (frame->payload_len != expected_len)
+		return -EMSGSIZE;
+
+	sample->sensor_type = osf_get_le16(payload);
+	sample->sensor_index = osf_get_le16(payload + 2);
+	sample->channel_count = channel_count;
+	sample->sample_format = sample_format;
+	sample->scale_nano = osf_get_le32(payload + 8);
+	sample->reserved = osf_get_le32(payload + 12);
+	sample->samples = payload + OSF_SENSOR_SAMPLE_BASE_LEN;
+
+	return 0;
+}
+
+int osf_protocol_sensor_sample_value(const struct osf_sensor_sample *sample,
+				     unsigned int index, s32 *value)
+{
+	if (!sample || !sample->samples || !value)
+		return -EINVAL;
+
+	if (index >= sample->channel_count)
+		return -ERANGE;
+
+	*value = (s32)osf_get_le32(sample->samples + index * sizeof(s32));
+
+	return 0;
+}
+
+int osf_protocol_decode_device_status(const struct osf_frame *frame,
+				      struct osf_device_status *status)
+{
+	const u8 *payload;
+
+	if (!frame || !status || !frame->payload)
+		return -EINVAL;
+
+	if (frame->message_type != OSF_MSG_DEVICE_STATUS)
+		return -EPROTO;
+
+	if (frame->payload_len != OSF_DEVICE_STATUS_LEN)
+		return -EMSGSIZE;
+
+	payload = frame->payload;
+	status->uptime_s = osf_get_le32(payload);
+	status->status_flags = osf_get_le32(payload + 4);
+	status->error_flags = osf_get_le32(payload + 8);
+	status->dropped_frames = osf_get_le32(payload + 12);
+	status->reserved = osf_get_le32(payload + 16);
+
+	return 0;
+}
+
+int osf_protocol_decode_capability_report(const struct osf_frame *frame,
+					  struct osf_capability_report *report)
+{
+	u16 capability_count;
+	u32 expected_len;
+	const u8 *payload;
+
+	if (!frame || !report || !frame->payload)
+		return -EINVAL;
+
+	if (frame->message_type != OSF_MSG_CAPABILITY_REPORT)
+		return -EPROTO;
+
+	if (frame->payload_len < OSF_CAP_REPORT_BASE_LEN)
+		return -EMSGSIZE;
+
+	payload = frame->payload;
+	capability_count = osf_get_le16(payload);
+	expected_len = OSF_CAP_REPORT_BASE_LEN +
+		       capability_count * OSF_CAP_SENSOR_ENTRY_LEN;
+
+	if (frame->payload_len != expected_len)
+		return -EMSGSIZE;
+
+	report->capability_count = capability_count;
+	report->reserved = osf_get_le16(payload + 2);
+	if (report->reserved)
+		return -EPROTO;
+
+	report->entries = payload + OSF_CAP_REPORT_BASE_LEN;
+
+	return 0;
+}
+
+int osf_protocol_decode_capability_entry(const struct osf_capability_report *report,
+					 unsigned int index,
+					 struct osf_capability_entry *entry)
+{
+	const u8 *payload;
+
+	if (!report || !report->entries || !entry)
+		return -EINVAL;
+
+	if (index >= report->capability_count)
+		return -ERANGE;
+
+	payload = report->entries + index * OSF_CAP_SENSOR_ENTRY_LEN;
+	entry->sensor_type = osf_get_le16(payload);
+	entry->sensor_index = osf_get_le16(payload + 2);
+	entry->channel_count = osf_get_le16(payload + 4);
+	entry->sample_format = osf_get_le16(payload + 6);
+	entry->scale_nano = osf_get_le32(payload + 8);
+	entry->flags = osf_get_le32(payload + 12);
+	entry->reserved = osf_get_le32(payload + 16);
+
+	if (!osf_sensor_type_valid(entry->sensor_type))
+		return -EPROTO;
+
+	if (entry->sample_format != OSF_SAMPLE_FORMAT_S32)
+		return -EPROTO;
+
+	if (entry->flags & ~OSF_CAPABILITY_FLAGS_MASK)
+		return -EPROTO;
+
+	if (entry->reserved)
+		return -EPROTO;
+
+	return 0;
+}
diff --git a/drivers/iio/opensensorfusion/osf_protocol.h b/drivers/iio/opensensorfusion/osf_protocol.h
new file mode 100644
index 000000000..fd6e9581f
--- /dev/null
+++ b/drivers/iio/opensensorfusion/osf_protocol.h
@@ -0,0 +1,100 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _OSF_PROTOCOL_H
+#define _OSF_PROTOCOL_H
+
+#include <linux/types.h>
+
+#define OSF_PROTOCOL_MAJOR		0
+#define OSF_PROTOCOL_MINOR		0
+#define OSF_FRAME_HEADER_LEN		38
+#define OSF_FRAME_CRC_LEN		4
+#define OSF_FRAME_MIN_LEN		(OSF_FRAME_HEADER_LEN + OSF_FRAME_CRC_LEN)
+
+#define OSF_SENSOR_SAMPLE_BASE_LEN	16
+#define OSF_DEVICE_STATUS_LEN		20
+#define OSF_CAP_REPORT_BASE_LEN		4
+#define OSF_CAP_SENSOR_ENTRY_LEN		20
+#define OSF_CAPABILITY_FLAGS_MASK	0x00000003U
+
+enum osf_message_type {
+	OSF_MSG_SENSOR_SAMPLE		= 0x0001,
+	OSF_MSG_DEVICE_STATUS		= 0x0002,
+	OSF_MSG_CAPABILITY_REPORT	= 0x0003,
+};
+
+enum osf_sensor_type {
+	OSF_SENSOR_ACCELEROMETER		= 0x0001,
+	OSF_SENSOR_GYROSCOPE		= 0x0002,
+	OSF_SENSOR_MAGNETOMETER		= 0x0003,
+	OSF_SENSOR_BAROMETER		= 0x0004,
+	OSF_SENSOR_TEMPERATURE		= 0x0005,
+	OSF_SENSOR_HUMIDITY		= 0x0006,
+	OSF_SENSOR_AMBIENT_LIGHT		= 0x0007,
+	OSF_SENSOR_PROXIMITY		= 0x0008,
+};
+
+enum osf_sample_format {
+	OSF_SAMPLE_FORMAT_S32		= 0x0001,
+};
+
+struct osf_frame {
+	u8 protocol_minor;
+	u16 message_type;
+	u32 payload_len;
+	u64 sequence;
+	u64 timestamp_us;
+	u32 flags;
+	u32 reserved;
+	const u8 *payload;
+	u32 crc;
+};
+
+struct osf_sensor_sample {
+	u16 sensor_type;
+	u16 sensor_index;
+	u16 channel_count;
+	u16 sample_format;
+	u32 scale_nano;
+	u32 reserved;
+	const u8 *samples;
+};
+
+struct osf_device_status {
+	u32 uptime_s;
+	u32 status_flags;
+	u32 error_flags;
+	u32 dropped_frames;
+	u32 reserved;
+};
+
+struct osf_capability_report {
+	u16 capability_count;
+	u16 reserved;
+	const u8 *entries;
+};
+
+struct osf_capability_entry {
+	u16 sensor_type;
+	u16 sensor_index;
+	u16 channel_count;
+	u16 sample_format;
+	u32 scale_nano;
+	u32 flags;
+	u32 reserved;
+};
+
+int osf_protocol_decode_frame(const u8 *buf, size_t len,
+			      struct osf_frame *frame, size_t *frame_len);
+int osf_protocol_decode_sensor_sample(const struct osf_frame *frame,
+				      struct osf_sensor_sample *sample);
+int osf_protocol_decode_device_status(const struct osf_frame *frame,
+				      struct osf_device_status *status);
+int osf_protocol_decode_capability_report(const struct osf_frame *frame,
+					  struct osf_capability_report *report);
+int osf_protocol_decode_capability_entry(const struct osf_capability_report *report,
+					 unsigned int index,
+					 struct osf_capability_entry *entry);
+int osf_protocol_sensor_sample_value(const struct osf_sensor_sample *sample,
+				     unsigned int index, s32 *value);
+
+#endif
diff --git a/drivers/iio/opensensorfusion/osf_serdev.c b/drivers/iio/opensensorfusion/osf_serdev.c
new file mode 100644
index 000000000..1827760c2
--- /dev/null
+++ b/drivers/iio/opensensorfusion/osf_serdev.c
@@ -0,0 +1,354 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/atomic.h>
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/serdev.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+#include <linux/workqueue.h>
+
+#include "osf_core.h"
+#include "osf_iio.h"
+#include "osf_serdev.h"
+#include "osf_stream.h"
+
+#define OSF_SERDEV_BAUD		115200
+#define OSF_SERDEV_BUFFER_QUEUE_LEN	32
+
+struct osf_serdev_iio {
+	u16 sensor_type;
+	u16 sensor_index;
+	struct iio_dev *indio_dev;
+};
+
+struct osf_serdev {
+	struct serdev_device *serdev;
+	struct osf_device osf;
+	struct osf_stream stream;
+	struct work_struct iio_register_work;
+	struct work_struct buffer_push_work;
+	/* Serializes IIO device table access and registration work. */
+	struct mutex iio_lock;
+	/* Protects sample events queued from the receive path. */
+	spinlock_t sample_lock;
+	struct osf_serdev_iio iio[OSF_MAX_CAPABILITIES];
+	unsigned int iio_count;
+	struct osf_sample_event sample_queue[OSF_SERDEV_BUFFER_QUEUE_LEN];
+	unsigned int sample_queue_head;
+	unsigned int sample_queue_tail;
+	unsigned int sample_queue_count;
+	u64 sample_queue_drops;
+	atomic64_t capability_sequence_scheduled;
+};
+
+static struct iio_dev *osf_serdev_find_iio(struct osf_serdev *osf_uart,
+					   const struct osf_sample_event *event)
+{
+	unsigned int i;
+
+	for (i = 0; i < osf_uart->iio_count; i++) {
+		if (osf_uart->iio[i].sensor_type == event->sensor_type &&
+		    osf_uart->iio[i].sensor_index == event->sensor_index)
+			return osf_uart->iio[i].indio_dev;
+	}
+
+	return NULL;
+}
+
+static bool osf_serdev_iio_registered(struct osf_serdev *osf_uart,
+				      const struct osf_capability_entry *entry)
+{
+	unsigned int i;
+
+	for (i = 0; i < osf_uart->iio_count; i++) {
+		if (osf_uart->iio[i].sensor_type == entry->sensor_type &&
+		    osf_uart->iio[i].sensor_index == entry->sensor_index)
+			return true;
+	}
+
+	return false;
+}
+
+static int osf_serdev_register_iio(struct osf_serdev *osf_uart,
+				   const struct osf_capability_entry *entry)
+{
+	struct device *dev = &osf_uart->serdev->dev;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	if (osf_serdev_iio_registered(osf_uart, entry))
+		return 0;
+
+	if (!osf_iio_sensor_supported(entry->sensor_type, entry->channel_count) ||
+	    entry->sample_format != OSF_SAMPLE_FORMAT_S32) {
+		dev_dbg(dev,
+			"ignoring unsupported capability sensor=%u index=%u channels=%u format=%u\n",
+			entry->sensor_type, entry->sensor_index,
+			entry->channel_count, entry->sample_format);
+		return 0;
+	}
+
+	if (osf_uart->iio_count >= ARRAY_SIZE(osf_uart->iio)) {
+		dev_warn(dev, "IIO registration table full, ignoring sensor=%u index=%u\n",
+			 entry->sensor_type, entry->sensor_index);
+		return 0;
+	}
+
+	ret = osf_iio_register_sensor(dev, entry, &osf_uart->osf, &indio_dev);
+	if (ret)
+		return ret;
+
+	osf_uart->iio[osf_uart->iio_count].sensor_type = entry->sensor_type;
+	osf_uart->iio[osf_uart->iio_count].sensor_index = entry->sensor_index;
+	osf_uart->iio[osf_uart->iio_count].indio_dev = indio_dev;
+	osf_uart->iio_count++;
+
+	return 1;
+}
+
+static void osf_serdev_iio_register_work(struct work_struct *work)
+{
+	struct osf_serdev *osf_uart =
+		container_of(work, struct osf_serdev, iio_register_work);
+	struct device *dev = &osf_uart->serdev->dev;
+	struct osf_capability_cache cache;
+	unsigned int registered = 0;
+	unsigned int i;
+	int ret;
+
+	if (!osf_core_copy_capability_cache(&osf_uart->osf, &cache))
+		return;
+
+	mutex_lock(&osf_uart->iio_lock);
+	for (i = 0; i < cache.capability_count; i++) {
+		ret = osf_serdev_register_iio(osf_uart, &cache.entries[i]);
+		if (ret) {
+			if (ret > 0) {
+				registered++;
+				continue;
+			}
+
+			dev_err(dev,
+				"failed to register IIO sensor=%u index=%u: %d\n",
+				cache.entries[i].sensor_type,
+				cache.entries[i].sensor_index, ret);
+		}
+	}
+	mutex_unlock(&osf_uart->iio_lock);
+
+	if (registered)
+		dev_info(dev,
+			 "registered %u Open Sensor Fusion IIO devices from capability report seq=%llu\n",
+			 registered, (unsigned long long)cache.sequence);
+}
+
+static bool osf_serdev_dequeue_sample(struct osf_serdev *osf_uart,
+				      struct osf_sample_event *event)
+{
+	unsigned long flags;
+	bool valid = false;
+
+	spin_lock_irqsave(&osf_uart->sample_lock, flags);
+	if (osf_uart->sample_queue_count) {
+		*event = osf_uart->sample_queue[osf_uart->sample_queue_tail];
+		osf_uart->sample_queue_tail =
+			(osf_uart->sample_queue_tail + 1) %
+			ARRAY_SIZE(osf_uart->sample_queue);
+		osf_uart->sample_queue_count--;
+		valid = true;
+	}
+	spin_unlock_irqrestore(&osf_uart->sample_lock, flags);
+
+	return valid;
+}
+
+static void osf_serdev_buffer_push_work(struct work_struct *work)
+{
+	struct osf_serdev *osf_uart =
+		container_of(work, struct osf_serdev, buffer_push_work);
+	struct device *dev = &osf_uart->serdev->dev;
+	struct osf_sample_event event;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	while (osf_serdev_dequeue_sample(osf_uart, &event)) {
+		mutex_lock(&osf_uart->iio_lock);
+		indio_dev = osf_serdev_find_iio(osf_uart, &event);
+		if (indio_dev) {
+			ret = osf_iio_push_sample(indio_dev, &event);
+			if (ret)
+				dev_dbg_ratelimited(dev,
+						    "failed to push IIO buffer sample sensor=%u index=%u ret=%d\n",
+						    event.sensor_type,
+						    event.sensor_index, ret);
+		}
+		mutex_unlock(&osf_uart->iio_lock);
+	}
+}
+
+static void osf_serdev_sample_ready(void *context,
+				    const struct osf_sample_event *event)
+{
+	struct osf_serdev *osf_uart = context;
+	unsigned long flags;
+	u64 drops = 0;
+	bool queued = false;
+
+	if (!osf_uart || !event)
+		return;
+
+	spin_lock_irqsave(&osf_uart->sample_lock, flags);
+	if (osf_uart->sample_queue_count < ARRAY_SIZE(osf_uart->sample_queue)) {
+		osf_uart->sample_queue[osf_uart->sample_queue_head] = *event;
+		osf_uart->sample_queue_head =
+			(osf_uart->sample_queue_head + 1) %
+			ARRAY_SIZE(osf_uart->sample_queue);
+		osf_uart->sample_queue_count++;
+		queued = true;
+	} else {
+		osf_uart->sample_queue_drops++;
+		drops = osf_uart->sample_queue_drops;
+	}
+	spin_unlock_irqrestore(&osf_uart->sample_lock, flags);
+
+	if (queued) {
+		schedule_work(&osf_uart->buffer_push_work);
+		return;
+	}
+
+	dev_dbg_ratelimited(&osf_uart->serdev->dev,
+			    "dropping IIO buffer sample sensor=%u index=%u drops=%llu\n",
+			    event->sensor_type, event->sensor_index,
+			    (unsigned long long)drops);
+}
+
+static void osf_serdev_schedule_iio_registration(struct osf_serdev *osf_uart)
+{
+	s64 scheduled_seq;
+	u64 sequence;
+
+	if (!osf_core_capability_sequence(&osf_uart->osf, &sequence))
+		return;
+
+	scheduled_seq = atomic64_read(&osf_uart->capability_sequence_scheduled);
+	if (scheduled_seq == (s64)sequence)
+		return;
+
+	atomic64_set(&osf_uart->capability_sequence_scheduled, (s64)sequence);
+	schedule_work(&osf_uart->iio_register_work);
+}
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
+	osf_serdev_schedule_iio_registration(osf_uart);
+
+	if (ret || stats->valid_frames != valid_before)
+		dev_dbg_ratelimited(&serdev->dev,
+				    "rx count=%zu valid=%llu bad_magic=%llu bad_crc=%llu partial=%llu dropped=%llu ret=%d\n",
+				    count,
+				    (unsigned long long)stats->valid_frames,
+				    (unsigned long long)stats->bad_magic_resyncs,
+				    (unsigned long long)stats->bad_crc_frames,
+				    (unsigned long long)stats->partial_frames,
+				    (unsigned long long)stats->dropped_bytes,
+				    ret);
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
+	struct osf_serdev *osf_uart;
+	unsigned int baudrate;
+	int ret;
+
+	osf_uart = devm_kzalloc(&serdev->dev, sizeof(*osf_uart), GFP_KERNEL);
+	if (!osf_uart)
+		return -ENOMEM;
+
+	osf_uart->serdev = serdev;
+	osf_core_init_device(&osf_uart->osf);
+	osf_stream_init(&osf_uart->stream, &osf_uart->osf);
+	INIT_WORK(&osf_uart->iio_register_work, osf_serdev_iio_register_work);
+	INIT_WORK(&osf_uart->buffer_push_work, osf_serdev_buffer_push_work);
+	mutex_init(&osf_uart->iio_lock);
+	spin_lock_init(&osf_uart->sample_lock);
+	atomic64_set(&osf_uart->capability_sequence_scheduled, -1);
+	osf_core_set_sample_callback(&osf_uart->osf, osf_serdev_sample_ready,
+				     osf_uart);
+
+	serdev_device_set_drvdata(serdev, osf_uart);
+	serdev_device_set_client_ops(serdev, &osf_serdev_ops);
+
+	ret = serdev_device_open(serdev);
+	if (ret)
+		return ret;
+
+	baudrate = serdev_device_set_baudrate(serdev, OSF_SERDEV_BAUD);
+	if (baudrate != OSF_SERDEV_BAUD)
+		dev_warn(&serdev->dev, "requested %u baud, controller set %u\n",
+			 OSF_SERDEV_BAUD, baudrate);
+
+	serdev_device_set_flow_control(serdev, false);
+
+	dev_info(&serdev->dev, "Open Sensor Fusion UART opened at %u baud\n",
+		 OSF_SERDEV_BAUD);
+
+	return 0;
+}
+
+static void osf_serdev_remove(struct serdev_device *serdev)
+{
+	struct osf_serdev *osf_uart = serdev_device_get_drvdata(serdev);
+
+	osf_core_set_sample_callback(&osf_uart->osf, NULL, NULL);
+	serdev_device_close(serdev);
+	cancel_work_sync(&osf_uart->iio_register_work);
+	cancel_work_sync(&osf_uart->buffer_push_work);
+	osf_stream_reset(&osf_uart->stream);
+}
+
+static const struct of_device_id osf_serdev_of_match[] = {
+	{ .compatible = "opensensorfusion,osf-uart" },
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
+
+int osf_serdev_register_driver(void)
+{
+	return serdev_device_driver_register(&osf_serdev_driver);
+}
+
+void osf_serdev_unregister_driver(void)
+{
+	serdev_device_driver_unregister(&osf_serdev_driver);
+}
diff --git a/drivers/iio/opensensorfusion/osf_serdev.h b/drivers/iio/opensensorfusion/osf_serdev.h
new file mode 100644
index 000000000..278b088df
--- /dev/null
+++ b/drivers/iio/opensensorfusion/osf_serdev.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _OSF_SERDEV_H
+#define _OSF_SERDEV_H
+
+int osf_serdev_register_driver(void);
+void osf_serdev_unregister_driver(void);
+
+#endif
diff --git a/drivers/iio/opensensorfusion/osf_stream.c b/drivers/iio/opensensorfusion/osf_stream.c
new file mode 100644
index 000000000..e9addf70e
--- /dev/null
+++ b/drivers/iio/opensensorfusion/osf_stream.c
@@ -0,0 +1,212 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <linux/types.h>
+
+#include "osf_core.h"
+#include "osf_protocol.h"
+#include "osf_stream.h"
+
+#define OSF_STREAM_MAGIC_LEN	4
+#define OSF_STREAM_MAX_PAYLOAD_LEN				\
+	(OSF_STREAM_MAX_FRAME_LEN - OSF_FRAME_HEADER_LEN - OSF_FRAME_CRC_LEN)
+
+static const u8 osf_stream_magic[OSF_STREAM_MAGIC_LEN] = {
+	'O', 'S', 'F', '0',
+};
+
+static u16 osf_stream_get_le16(const u8 *buf)
+{
+	return buf[0] | buf[1] << 8;
+}
+
+static u32 osf_stream_get_le32(const u8 *buf)
+{
+	return (u32)buf[0] | (u32)buf[1] << 8 |
+	       (u32)buf[2] << 16 | (u32)buf[3] << 24;
+}
+
+static void osf_stream_discard(struct osf_stream *stream, size_t count)
+{
+	if (count >= stream->len) {
+		stream->len = 0;
+		return;
+	}
+
+	memmove(stream->buf, stream->buf + count, stream->len - count);
+	stream->len -= count;
+}
+
+static bool osf_stream_magic_match(const u8 *buf, size_t len)
+{
+	return !memcmp(buf, osf_stream_magic, len);
+}
+
+static size_t osf_stream_resync(struct osf_stream *stream)
+{
+	size_t old_len = stream->len;
+	size_t match_len;
+	size_t i;
+
+	for (i = 0; i < stream->len; i++) {
+		match_len = stream->len - i;
+		if (match_len > OSF_STREAM_MAGIC_LEN)
+			match_len = OSF_STREAM_MAGIC_LEN;
+
+		if (osf_stream_magic_match(stream->buf + i, match_len)) {
+			if (i)
+				osf_stream_discard(stream, i);
+			return i;
+		}
+	}
+
+	stream->len = 0;
+	return old_len;
+}
+
+static int osf_stream_process(struct osf_stream *stream)
+{
+	struct osf_frame frame;
+	size_t decoded_len;
+	size_t discarded;
+	size_t frame_len;
+	u32 payload_len;
+	int first_err = 0;
+	int ret;
+
+	while (stream->len) {
+		discarded = osf_stream_resync(stream);
+		if (discarded) {
+			stream->stats.bad_magic_resyncs++;
+			stream->stats.dropped_bytes += discarded;
+			if (!first_err)
+				first_err = -EPROTO;
+		}
+
+		if (!stream->len)
+			break;
+
+		if (stream->len < OSF_FRAME_HEADER_LEN) {
+			stream->stats.partial_frames++;
+			break;
+		}
+
+		if (osf_stream_get_le16(stream->buf + 6) !=
+		    OSF_FRAME_HEADER_LEN) {
+			stream->stats.dropped_bytes++;
+			osf_stream_discard(stream, 1);
+			if (!first_err)
+				first_err = -EPROTO;
+			continue;
+		}
+
+		payload_len = osf_stream_get_le32(stream->buf + 10);
+		if (payload_len > OSF_STREAM_MAX_PAYLOAD_LEN) {
+			stream->stats.dropped_bytes++;
+			osf_stream_discard(stream, 1);
+			if (!first_err)
+				first_err = -EMSGSIZE;
+			continue;
+		}
+
+		frame_len = OSF_FRAME_HEADER_LEN + payload_len + OSF_FRAME_CRC_LEN;
+		if (stream->len < frame_len) {
+			stream->stats.partial_frames++;
+			break;
+		}
+
+		ret = osf_protocol_decode_frame(stream->buf, frame_len, &frame,
+						&decoded_len);
+		if (ret) {
+			if (ret == -EBADMSG)
+				stream->stats.bad_crc_frames++;
+			stream->stats.dropped_bytes++;
+			osf_stream_discard(stream, 1);
+			if (!first_err)
+				first_err = ret;
+			continue;
+		}
+
+		if (decoded_len != frame_len) {
+			stream->stats.dropped_bytes++;
+			osf_stream_discard(stream, 1);
+			if (!first_err)
+				first_err = -EMSGSIZE;
+			continue;
+		}
+
+		ret = osf_core_receive_frame(stream->osf, stream->buf, frame_len);
+		if (ret) {
+			osf_stream_discard(stream, frame_len);
+			if (!first_err)
+				first_err = ret;
+			continue;
+		}
+
+		stream->stats.valid_frames++;
+		osf_stream_discard(stream, frame_len);
+	}
+
+	return first_err;
+}
+
+void osf_stream_init(struct osf_stream *stream, struct osf_device *osf)
+{
+	if (!stream)
+		return;
+
+	stream->osf = osf;
+	stream->len = 0;
+	memset(&stream->stats, 0, sizeof(stream->stats));
+}
+
+void osf_stream_reset(struct osf_stream *stream)
+{
+	if (stream) {
+		stream->len = 0;
+		memset(&stream->stats, 0, sizeof(stream->stats));
+	}
+}
+
+int osf_stream_receive_bytes(struct osf_stream *stream, const u8 *buf,
+			     size_t len)
+{
+	size_t copy_len;
+	size_t space;
+	int first_err = 0;
+	int ret;
+
+	if (!stream || !stream->osf || (!buf && len))
+		return -EINVAL;
+
+	if (!len) {
+		ret = osf_stream_process(stream);
+		if (ret && !first_err)
+			first_err = ret;
+		return first_err;
+	}
+
+	while (len) {
+		space = OSF_STREAM_MAX_FRAME_LEN - stream->len;
+		if (!space) {
+			stream->stats.dropped_bytes++;
+			osf_stream_discard(stream, 1);
+			if (!first_err)
+				first_err = -EMSGSIZE;
+			continue;
+		}
+
+		copy_len = len < space ? len : space;
+		memcpy(stream->buf + stream->len, buf, copy_len);
+		stream->len += copy_len;
+		buf += copy_len;
+		len -= copy_len;
+
+		ret = osf_stream_process(stream);
+		if (ret && !first_err)
+			first_err = ret;
+	}
+
+	return first_err;
+}
diff --git a/drivers/iio/opensensorfusion/osf_stream.h b/drivers/iio/opensensorfusion/osf_stream.h
new file mode 100644
index 000000000..f7f9477fe
--- /dev/null
+++ b/drivers/iio/opensensorfusion/osf_stream.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _OSF_STREAM_H
+#define _OSF_STREAM_H
+
+#include <linux/types.h>
+
+#define OSF_STREAM_MAX_FRAME_LEN	4096
+
+struct osf_device;
+
+struct osf_stream_stats {
+	u64 valid_frames;
+	u64 bad_magic_resyncs;
+	u64 bad_crc_frames;
+	u64 partial_frames;
+	u64 dropped_bytes;
+};
+
+struct osf_stream {
+	struct osf_device *osf;
+	u8 buf[OSF_STREAM_MAX_FRAME_LEN];
+	size_t len;
+	struct osf_stream_stats stats;
+};
+
+void osf_stream_init(struct osf_stream *stream, struct osf_device *osf);
+void osf_stream_reset(struct osf_stream *stream);
+int osf_stream_receive_bytes(struct osf_stream *stream, const u8 *buf,
+			     size_t len);
+
+#endif
-- 
2.43.0

