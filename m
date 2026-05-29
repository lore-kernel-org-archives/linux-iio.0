Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F9E3D4103
	for <linux-iio@vger.kernel.org>; Fri, 29 May 2026 12:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780056669; cv=none; b=CWU4Uz7z7MvCcOZYjWAHrUw7KmWtOelODqt/KsheUqt7W3ecmljM7vrYGgjcr9IzyKUMu+6NTihVKw3FaKVe9xPDsl3LQHtVwwY/DnY6EuSKDRS5YQ4hDxshicqi2Y/Zw1GDyaePrg3xlfzmSTB/Num536Dcq9CaZrTiejhcOMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780056669; c=relaxed/simple;
	bh=uh3qnP80X/x/loXtZjwzEIOnD5Ul0YdqfJrFcHQprAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k3WGV5wsaofCoFqcjB3TbKdnr3Ur+CUURNHIQ2g3lTYnF+pIMK8FDMrfaU6pHmf2DE/wHL0ZvS2dXF6TqdV8o+eRQKxYW51nutRzQaxSZ68/pIQpAULXiszzUdl2GPRjCmoz1OX88tbQ9cJYzQVQ8RZMKJI0+dEjbMvhWOOmyag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ClMMxlp9; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ClMMxlp9"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-36b903567fdso1524582a91.1
        for <linux-iio@vger.kernel.org>; Fri, 29 May 2026 05:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780056667; x=1780661467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZDz79rsrbfxADkUstWv7Wa0YddM7uElqbIZ77wvpmyE=;
        b=ClMMxlp9SS+daTHWbgvSDe8Y8EhaUPQnXun7N3r2QR6l6edu3D+2MZq1u92pxtYnqn
         yAJcrMyuGOeY7RvAcLOXpHQ2VE9rZClWM29T2KMjcmKmuanZRaNmES1GbWxRZen/z/K3
         On1V2ZNY7W8NL3FqfaX+Rtrl+4LF1r1/wD1QSYfteDlrBjbpTisqmVvr1jyTkwU6fGo4
         uAZ0hkFP6OncA60A8V/cXVgADx9URKVa1jyum/b/LqR4VWHP1l8mcB+lSxwAjkJ/yrmB
         KJZ11FOy+UH8fhKS1r7kufpTx3/gT4P4VLODjhPS5Hin40BeSs7iqNPbc0ld72nUuSwy
         YP8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780056667; x=1780661467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZDz79rsrbfxADkUstWv7Wa0YddM7uElqbIZ77wvpmyE=;
        b=V8jFDfUfDDIOBKXqfivH3MylemeB0Cm8df7VtZrR7diqDHwk/pv6/ci7Yaf45mRw/p
         ja/0FJ7N5d+z7LiIw4eyFGl7Rg1MFmzKAc6pTeo9UGOaRyLQ5ILLBN5TMKa3WG40rddx
         BVkKv49iQI7RxSrPQ/GZqbHng31XnFx1KPNq9my51sz1W9xwfbVAvlBuORVXv3+4hiBX
         jzPWkeYdLywme10CHTIT+kkz9ZA/sdfxJZ/loOpfIIuW4nUqDKnb4rL8rALHnN3ZrQsI
         gJpmRsnZBQYDeGjy+UfvH4+JjtFcx1H4Jhf31mQ4ECDJ6dF7Ty8CrAo4YtHr2VeDkmjN
         pAaA==
X-Forwarded-Encrypted: i=1; AFNElJ88aLmuAVJbR9uBgJblNSzuT4uIvtEPwbjPaWf91emFcwDrsphlm4IxsM9K8iHJdJjJ+CZ5Td1g+94=@vger.kernel.org
X-Gm-Message-State: AOJu0YywtjY7tf9uqABAhyZX/BPQ2y0caj8vdXl+vRlH88D5dWkiaJaF
	AFgQQx+gCl+xx/2vmYSnVHJEW/6aSKYAQa8dLu6QkOJ1YyyB25+rs2cU
X-Gm-Gg: Acq92OGVxsHpVnXzTYKs4uNMgtoDR/qMhpnD0WIzUR+ZQvAUUYBZP2KDkf1qIpotTpO
	Du+27BOZHJG7GOFhw37t8qUZ0m0SxJ/k2tW3ssGWb/ck6lkVKpYU1u1u2mqYA1fB/+RluAZVmtf
	2EgVJZOW+UXYbXqiA2JtE5a5q6Ye73W9nTPfpm1fef7MR/OdFCnwo7Wm8J+ArO1GVq0yNiyylwv
	2GmyDlBeJSgrksGgDnXdEDuRziTvUckA2TApsSkXx+gZUdNdlASxcF/2AC34LdCzZe0UxO+C6td
	oRiR3eGxG4eY754Y2UMv+fFT7UGkzvJ4hyqouRxLf1PEElUVy6WHEAis90QSygFdtTjhTOKj3xh
	RFOyMBAYl522ihx57oDpmy64MYibbXTpQ3qoPh9O9j0wH2OBl5sG2NEjzjls65KsoavswSTyX2h
	rmhMMCwaf+LybwXhF3aiszwOqMRvOoWpndIY7nmpUthvUj63lQKE8p/uNtIB+VlJ3XQ3BJVOcqN
	Y4AdkJcAp4Y4J1EkewuCUzD7LUuNbGdrpPytQoS2VuV+A//
X-Received: by 2002:a17:90b:3d0a:b0:364:8f64:49ea with SMTP id 98e67ed59e1d1-36bbd4488cfmr3323718a91.27.1780056666871;
        Fri, 29 May 2026 05:11:06 -0700 (PDT)
Received: from DESKTOP-G3E0OSP.localdomain ([112.172.255.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36bbdf3afc6sm942820a91.7.2026.05.29.05.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 05:11:06 -0700 (PDT)
From: Jinseob Kim <kimjinseob88@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC v3 6/6] iio: osf: register IIO devices from capabilities
Date: Fri, 29 May 2026 21:10:05 +0900
Message-ID: <20260529121005.1470-7-kimjinseob88@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260529121005.1470-1-kimjinseob88@gmail.com>
References: <20260529121005.1470-1-kimjinseob88@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the first capability report to create supported IIO devices.

Cache latest samples and push enabled buffers directly.

Signed-off-by: Jinseob Kim <kimjinseob88@gmail.com>
---
 MAINTAINERS                             |   1 +
 drivers/iio/opensensorfusion/Kconfig    |  11 +-
 drivers/iio/opensensorfusion/Makefile   |   3 +-
 drivers/iio/opensensorfusion/osf_core.c | 244 ++++++++++++++++++--
 drivers/iio/opensensorfusion/osf_core.h |  52 +++++
 drivers/iio/opensensorfusion/osf_iio.c  | 285 ++++++++++++++++++++++++
 drivers/iio/opensensorfusion/osf_iio.h  |  22 ++
 7 files changed, 588 insertions(+), 30 deletions(-)
 create mode 100644 drivers/iio/opensensorfusion/osf_iio.c
 create mode 100644 drivers/iio/opensensorfusion/osf_iio.h

diff --git a/MAINTAINERS b/MAINTAINERS
index ebbd82bf0..56181470d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19985,6 +19985,7 @@ F:	Documentation/iio/open-sensor-fusion-protocol-v0.rst
 F:	drivers/iio/opensensorfusion/Kconfig
 F:	drivers/iio/opensensorfusion/Makefile
 F:	drivers/iio/opensensorfusion/osf_core.*
+F:	drivers/iio/opensensorfusion/osf_iio.*
 F:	drivers/iio/opensensorfusion/osf_protocol.*
 F:	drivers/iio/opensensorfusion/osf_serdev.c
 F:	drivers/iio/opensensorfusion/osf_stream.*
diff --git a/drivers/iio/opensensorfusion/Kconfig b/drivers/iio/opensensorfusion/Kconfig
index 360f25b4f..957caed2b 100644
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
 
-	  The driver receives OSF0 frames over a serdev UART.
-	  Frames are decoded and validated before being passed to the
-	  driver core.
-	  This patch only adds the transport path.
-	  IIO device registration is added separately.
+	  The driver receives OSF0 frames over a serdev UART and registers
+	  IIO devices for supported capability entries.
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
index c867b3158..e0a12de01 100644
--- a/drivers/iio/opensensorfusion/osf_core.c
+++ b/drivers/iio/opensensorfusion/osf_core.c
@@ -5,7 +5,7 @@
 #include <linux/types.h>
 
 #include "osf_core.h"
-#include "osf_protocol.h"
+#include "osf_iio.h"
 
 #define OSF_RESERVED_MSG_FIRST		0x7f00
 #define OSF_RESERVED_MSG_LAST		0x7fff
@@ -13,23 +13,175 @@
 
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
 }
 
-static int osf_core_validate_sensor_sample(const struct osf_frame *frame)
+static struct iio_dev *osf_core_find_iio_dev(struct osf_device *osf,
+					     u16 sensor_type, u16 sensor_index)
 {
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
+}
+
+static int osf_core_register_capabilities(struct osf_device *osf,
+					  const struct osf_capability_cache *cache)
+{
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
 
-	return osf_protocol_decode_sensor_sample(frame, &sample);
+	for (i = 0; i < sample.channel_count; i++) {
+		ret = osf_protocol_sensor_sample_value(&sample, i, &values[i]);
+		if (ret)
+			return ret;
+	}
+
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
 	int ret;
 
@@ -37,15 +189,22 @@ static int osf_core_validate_device_status(const struct osf_frame *frame)
 	if (ret)
 		return ret;
 
-	if (status.reserved)
-		return -EPROTO;
+	cache.uptime_s = status.uptime_s;
+	cache.status_flags = status.status_flags;
+	cache.error_flags = status.error_flags;
+	cache.dropped_frames = status.dropped_frames;
+	cache.sequence = frame->sequence;
+	cache.valid = true;
+	osf->status_cache = cache;
+	osf->last_sequence = frame->sequence;
 
 	return 0;
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
@@ -54,12 +213,32 @@ static int osf_core_validate_capability_report(const struct osf_frame *frame)
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
 
@@ -81,27 +260,46 @@ int osf_core_receive_frame(struct osf_device *osf, const u8 *buf, size_t len)
 
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
+		if (latest->valid && channel < latest->channel_count) {
+			*value = latest->values[channel];
 			ret = 0;
-		else if (frame.message_type >= OSF_VENDOR_PRIVATE_FIRST)
-			ret = 0;
-		else
-			ret = -EOPNOTSUPP;
+		}
 		break;
 	}
-
-	if (!ret)
-		osf->last_sequence = frame.sequence;
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
index 000000000..5e5099878
--- /dev/null
+++ b/drivers/iio/opensensorfusion/osf_iio.c
@@ -0,0 +1,285 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/array_size.h>
+#include <linux/bitops.h>
+#include <linux/errno.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/kfifo_buf.h>
+#include <linux/string.h>
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
+static const unsigned long osf_temp_available_scan_masks[] = {
+	BIT(0),
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
+		.available_scan_masks = osf_temp_available_scan_masks,
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
+	s32 scan[OSF_MAX_SAMPLE_CHANNELS] = { };
+	s64 timestamp;
+
+	if (channel_count != state->spec->channel_count)
+		return -EPROTO;
+
+	memcpy(scan, values, channel_count * sizeof(*values));
+
+	/* Buffer state can change here; IIO rechecks it during the push path. */
+	if (!iio_buffer_enabled(indio_dev))
+		return 0;
+
+	timestamp = iio_get_time_ns(indio_dev);
+
+	return iio_push_to_buffers_with_ts_unaligned(indio_dev, scan,
+						     channel_count * sizeof(*scan),
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

