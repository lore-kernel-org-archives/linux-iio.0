Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2239548F018
	for <linux-iio@vger.kernel.org>; Wed,  9 Sep 2026 15:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788966426; cv=pass; b=YrfUmxHDnqw2+LlfpGgfMs/YncwX4DzCtgW3OEOLN1x3wOYGjag34OfE1cMZBW8+0c6WNWbyxMKhJC05GIN1vtxgwgIR2bCro3CwvWnUfkC4gMy+hQIxnSpm53VBDASfBZxSsZR9oy7Zg3V3OZoJY2RK0e1KlgujoFrxeXs54pc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788966426; c=relaxed/simple;
	bh=dc4HN6Jp8H2wsCYNj0MVVyevdvFTBFpnW8gJ3mIbmQs=;
	h=MIME-Version:From:In-Reply-To:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l5YkzEBN7Z0xk+znm7hoM+wBK0eiepr/9roapvCBa8S4dBG3Z7ki8OOn2RjIkTpoZVMwhvpDjw8/x5AVNABAYlr/JaW+SRIhTl7xnfy3w2eLuW2gNWWomUsOBfrCPxmTjg28Ons3fngiufyQo+P2SQupb6mxDSX1IKD9nLjVqsA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TJZd5wpv; arc=pass smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJZd5wpv"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-4765ce0573eso3112917fac.0
        for <linux-iio@vger.kernel.org>; Wed, 09 Sep 2026 08:07:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788966421; cv=none;
        d=google.com; s=arc-20260327;
        b=l3YON0/iW2MqGsXAyaaKIJ4r9rn+DCZILGDjZ7jzfLieoHOmQ+1fRGtGEtuEE9DScs
         AWzm06KlhnFD3zIvbUzqQsMz2iutAlVqcRIiLCBNfWR4B+Gd7AbQKoai98A9VqbvBCjl
         rLIHMm8XmjotFLbg6wVRfvphso8OUu24FZ3b5r+X4258sByfvieaxtLps3DxqPq5bP23
         2JiZ1ZmusIb8LOBzYLXfiwHNZVfFmIN4mCMeTrBhNqyrQL1VR9r/F2s+Ur2RTDrJmSwE
         sZly9VGQk3CXR2eH0NIAp8oa0RYnztp1UAfNveJFvwJvrNrA/XrWbFKF6+rxHNSGQUfG
         WyTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:references:in-reply-to:from
         :mime-version:dkim-signature;
        bh=NeLf6D1Riu1bxe9num4y0vk2Apay5Ac8RiKpR8O8mCM=;
        fh=rTgejpNieGTcINm+DeMoFVMRr5PRVD+jdA10GH6pvZg=;
        b=C76ZsEPZ+UZdJOCbk4aRY6s2VOXp6LrGuxuWS24uxBu2g0jMBpymK78UMxLybEk/dA
         A25NR0yAgCN9umz9k+bbxoHkIWLIvfJB/fDGi0+ZTeG99AZ1Chha12GMoz7UGn6Bd49y
         dQJQaIPh8WMansUpUFs50uyt02zc12YmoMtVztZAhyxonaLH35sHGM2PxpbNkkPrXpsG
         pTytMVnX8dFVi+dZqJPSjZrglCuy6qJF1+NxYYZCrmMaLKPjKEVslZ1VF6GUlz5APNxu
         UTB4ebFXQfyHI972cmAobs5+/EqPi5XN9EPwAGb8L2IcSy0uCB2ENi+qj8GtziyiQCpt
         l+OA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788966421; x=1789571221; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:references:in-reply-to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NeLf6D1Riu1bxe9num4y0vk2Apay5Ac8RiKpR8O8mCM=;
        b=TJZd5wpv677pi/YXOBIyljONexJHTiUB2LC9nQgzlksb9+4jlm8z8tqZOt1oP53QcQ
         NYMOUXvcwfYG8WezNq30sDG3B6oaB+LZ8zlkdCxY5VdUP5+R9TX3zWUUHBoOexUB6c7M
         YpIAOwN6Xr6dJzj99ADOjsVz9qBNKl0C7ebZF5oQVTi768ObKVLFYkvmcVOBWy2H2zMi
         w508h0DRIdFDVLtVgvzkmO+s+aRPDv2lS6pgGpL0UGlFEG+FbuNYQUaJ/2ygU+3QFh5W
         Jya4dCWLMwr8mtuokMHnONehJpTqgPQgv/4NWdjE+BjlpSX015F91BMwrhRxBG7/FCYI
         Rchg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788966421; x=1789571221;
        h=content-type:cc:to:subject:message-id:date:references:in-reply-to
         :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NeLf6D1Riu1bxe9num4y0vk2Apay5Ac8RiKpR8O8mCM=;
        b=MRSn8oQFw16SKqdn5v+e2cl1tIMQaskoiHTXAZLAIQ7d2E0PZDijMkWg1mxsxOLSlE
         BvvdYSSAaMjqh4RO0AsIoJqhcS5w6gFV+kImYVEYN742druZCzoZnSimOpBq0xIUdt19
         w69srNBJscnVUGId9yz2e3BbRl1SH1xhE/1VTXlJfVjFDsri7YjX+40FANP45sUk89F1
         cp82MSf/lMJY/7kKsbMtOBSXeRImBd81nSyGlDtEjty+Fscwvo7FyQvdt7PQ6XCLyUgl
         KEQ+OA+/lOAojb+ov6wlVJAiReh98nao4rtD6GKJabOnEsZGZ7cINmti5eKEnmT+zv9w
         1yxQ==
X-Forwarded-Encrypted: i=1; AKwUvBzAGky8IMr0qbVr8fKZsEWy3Un7ZVLNyaDiV3afCAZcLqyGjRtrgu/GZasQZDWVxYDKvDuOhoZLyKE=@vger.kernel.org
X-Gm-Message-State: AFuF++lDlLyh4QzFwcCSWhcdwfsHBIeLhg5NteNdpCTM5pFXC665jsa7
	tQ8DcVpXxHz1m+14OYs+x58lI7U+mV1GurZLIgrw+qIgr9tWatb76lfCcn3EsLO5tVdZb4md3vT
	U/niM7abg26Q+DctHShA5XYJzKwsDQTXOvKeE
X-Gm-Gg: AYBFou1ReLb3dinVH2LEYeeh7ZdpIxjwzzpiyqaQ230FKdqjaNJJKlvA+HbNVefpkBf
	+ikJ8q9Jxk6go8b/Qw5lyqloOkMxbGznzr0dvqc4xWDKFR1g3sforI02o4kXZzwadI0hJk+ai+S
	Q2QXSICt7Gh/LbEytGOVRREVoQmIE/1b7rexDkg+YcXF1yhz/Ir5ZAd+0/xEBQhRBAq4857DIyU
	TcZtKgR/zM0/62Pzi004U6t7yn44ZE/jIJx8C5QxWHsFlGKanlI5xNRpn4LmcRgOaJ7UqCceYCV
	bInru7VB09n/iEZxwSfj/dUfCWXuFr37Rwb7DPQVKh6H583hdI8fjx/p1IExHMxUsQerRD8l0DG
	O5hmf8TG7eeDzCaDOWQNMBVFjhc3JBkSViCxpgA==
X-Received: by 2002:a05:6820:c85:b0:6b3:619f:25ce with SMTP id
 006d021491bc7-6b6fdebe0cfmr20708741eaf.30.1788966420330; Wed, 09 Sep 2026
 08:07:00 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 9 Sep 2026 10:06:58 -0500
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 9 Sep 2026 10:06:58 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jinseob Kim <kimjinseob88@gmail.com>
In-Reply-To: <CALMSewJPfQXRX5q4X3gJf=LT6m2FnusTM=DBiWsBqRFiyNP_Gw@mail.gmail.com>
References: <CALMSewJPfQXRX5q4X3gJf=LT6m2FnusTM=DBiWsBqRFiyNP_Gw@mail.gmail.com>
Date: Wed, 9 Sep 2026 10:06:58 -0500
X-Gm-Features: AcwNN1V0BZwK1v2LCrfHkJMBobBPVuxVWfURBEpd-mGdoKHsszS2xpFmmEu-sWw
Message-ID: <CALMSewLVTiFww7hTBBw8jK+YL0ZC-E7wLx1TrBWUW5Ziutw8ww@mail.gmail.com>
Subject: [PATCH v9 5/5] iio: osf: add UART IIO driver
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	linux-kernel@vger.kernel.org, rdunlap@infradead.org, joshua.crofts1@gmail.com, 
	u.kleine-koenig@baylibre.com, julianbraha@gmail.com
Content-Type: text/plain; charset="UTF-8"

Add the Open Sensor Fusion serdev transport and runtime IIO registration
from capability reports. Configure UART before enabling vcc, and retain
early capabilities until the remaining probe setup succeeds.

Use initialized aligned scan storage, pack active channels, and quiesce
pushes before buffer reconfiguration. Only accepted samples update the
latest-sample cache used by direct reads.

Include KUnit coverage for cache integrity, scan bytes and timestamps,
buffer lifetime, and early capability ownership.

Assisted-by: LLM
Signed-off-by: Jinseob Kim <kimjinseob88@gmail.com>
---
 MAINTAINERS                                  |   3 +-
 drivers/iio/Kconfig                          |   1 +
 drivers/iio/Makefile                         |   1 +
 drivers/iio/opensensorfusion/Kconfig         |  27 +
 drivers/iio/opensensorfusion/Makefile        |   7 +
 drivers/iio/opensensorfusion/osf_core.c      | 414 +++++++++++++
 drivers/iio/opensensorfusion/osf_core.h      |  73 +++
 drivers/iio/opensensorfusion/osf_core_test.c | 577 +++++++++++++++++++
 drivers/iio/opensensorfusion/osf_iio.c       | 336 +++++++++++
 drivers/iio/opensensorfusion/osf_iio.h       |  22 +
 drivers/iio/opensensorfusion/osf_iio_test.c  | 325 +++++++++++
 drivers/iio/opensensorfusion/osf_serdev.c    | 162 ++++++
 12 files changed, 1946 insertions(+), 2 deletions(-)
 create mode 100644 drivers/iio/opensensorfusion/Kconfig
 create mode 100644 drivers/iio/opensensorfusion/Makefile
 create mode 100644 drivers/iio/opensensorfusion/osf_core.c
 create mode 100644 drivers/iio/opensensorfusion/osf_core.h
 create mode 100644 drivers/iio/opensensorfusion/osf_core_test.c
 create mode 100644 drivers/iio/opensensorfusion/osf_iio.c
 create mode 100644 drivers/iio/opensensorfusion/osf_iio.h
 create mode 100644 drivers/iio/opensensorfusion/osf_iio_test.c
 create mode 100644 drivers/iio/opensensorfusion/osf_serdev.c

diff --git a/MAINTAINERS b/MAINTAINERS
index a1117459ebd9..41609e2f2929 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20516,8 +20516,7 @@ M:	Jinseob Kim <kimjinseob88@gmail.com>
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
diff --git a/drivers/iio/opensensorfusion/Kconfig
b/drivers/iio/opensensorfusion/Kconfig
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
diff --git a/drivers/iio/opensensorfusion/Makefile
b/drivers/iio/opensensorfusion/Makefile
new file mode 100644
index 000000000000..6a28b14cae1f
--- /dev/null
+++ b/drivers/iio/opensensorfusion/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+obj-$(CONFIG_OPEN_SENSOR_FUSION) += open-sensor-fusion.o
+
+open-sensor-fusion-y := osf_core.o osf_iio.o osf_protocol.o osf_serdev.o \
+			 osf_stream.o
+open-sensor-fusion-$(CONFIG_OPEN_SENSOR_FUSION_KUNIT_TEST) +=
osf_core_test.o osf_iio_test.o
diff --git a/drivers/iio/opensensorfusion/osf_core.c
b/drivers/iio/opensensorfusion/osf_core.c
new file mode 100644
index 000000000000..b4d359706279
--- /dev/null
+++ b/drivers/iio/opensensorfusion/osf_core.c
@@ -0,0 +1,414 @@
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
+static bool osf_core_capability_is_duplicate(const struct
osf_capability_cache *cache,
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
+void osf_core_start(struct osf_device *osf)
+{
+	int ret;
+
+	if (osf->iio_ready)
+		return;
+
+	osf->iio_ready = true;
+	if (!osf->capability_cache.valid ||
+	    !osf->capability_cache.capability_count)
+		return;
+
+	ret = osf_core_register_capabilities(osf, &osf->capability_cache);
+	if (ret) {
+		/* As with RX discovery failure, a later report may retry. */
+		osf->capability_cache.valid = false;
+		dev_err_ratelimited(osf->dev,
+				    "failed to register pending capabilities: %d\n",
+				    ret);
+	}
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
+		cache.entries[cache.capability_count] = entry;
+		if (osf_core_capability_is_duplicate(&cache, cache.capability_count)) {
+			dev_warn_ratelimited(osf->dev,
+					     "rejecting duplicate capability\n");
+			return -EEXIST;
+		}
+		cache.capability_count++;
+	}
+
+	cache.sequence = frame->sequence;
+	cache.valid = true;
+
+	frame_result = OSF_STREAM_FRAME_IGNORED;
+	if (cache.capability_count) {
+		if (osf->iio_ready) {
+			ret = osf_core_register_capabilities(osf, &cache);
+			if (ret) {
+				dev_err_ratelimited(osf->dev,
+						    "failed to register capabilities: %d\n",
+						    ret);
+				return ret;
+			}
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
diff --git a/drivers/iio/opensensorfusion/osf_core.h
b/drivers/iio/opensensorfusion/osf_core.h
new file mode 100644
index 000000000000..21f37dcd0781
--- /dev/null
+++ b/drivers/iio/opensensorfusion/osf_core.h
@@ -0,0 +1,73 @@
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
+	bool iio_ready;
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
+/* Serialize start with receive_frame; pending entries own their data. */
+void osf_core_start(struct osf_device *osf);
+void osf_core_unregister_iio(struct osf_device *osf);
+int osf_core_receive_frame(struct osf_device *osf, const u8 *buf, size_t len);
+int osf_core_read_latest_sample(struct osf_device *osf, u16 sensor_type,
+				u16 sensor_index, u16 channel,
+				s32 *value);
+
+#endif
diff --git a/drivers/iio/opensensorfusion/osf_core_test.c
b/drivers/iio/opensensorfusion/osf_core_test.c
new file mode 100644
index 000000000000..16121d512cb1
--- /dev/null
+++ b/drivers/iio/opensensorfusion/osf_core_test.c
@@ -0,0 +1,577 @@
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
+					      &ctx->indio_dev->channels[channel],
+					      value, &value2,
+					      IIO_CHAN_INFO_RAW);
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
+	osf_core_start(&ctx->osf);
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
+static void osf_test_unregister_pending(void *data)
+{
+	osf_core_unregister_iio(data);
+}
+
+static void osf_early_capability_is_owned_test(struct kunit *test)
+{
+	struct osf_test_context *ctx = test->priv;
+	struct osf_device *pending;
+	struct iio_dev *indio_dev;
+	u8 frame[OSF_TEST_MAX_FRAME_LEN];
+	size_t len;
+	int scale, nano, ret;
+
+	pending = kunit_kzalloc(test, sizeof(*pending), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, pending);
+	osf_core_init(pending, ctx->dev);
+	ret = kunit_add_action_or_reset(test, osf_test_unregister_pending, pending);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	len = osf_test_build_capability_frame(frame, sizeof(frame), 10);
+	KUNIT_ASSERT_NE(test, len, (size_t)0);
+	KUNIT_EXPECT_EQ(test, osf_core_receive_frame(pending, frame, len),
+			OSF_STREAM_FRAME_HANDLED);
+	KUNIT_EXPECT_EQ(test, pending->iio_dev_count, 0U);
+	KUNIT_ASSERT_TRUE(test, pending->capability_cache.valid);
+	KUNIT_EXPECT_EQ(test, pending->capability_cache.capability_count, (u16)1);
+
+	/* The stream may reuse its storage before probe opens the
registration gate. */
+	memset(frame, 0xa5, sizeof(frame));
+	osf_core_start(pending);
+	KUNIT_ASSERT_EQ(test, pending->iio_dev_count, 1U);
+	indio_dev = pending->iio_devs[0].indio_dev;
+	ret = indio_dev->info->read_raw(indio_dev, &indio_dev->channels[0],
+				       &scale, &nano, IIO_CHAN_INFO_SCALE);
+	KUNIT_EXPECT_EQ(test, ret, IIO_VAL_INT_PLUS_NANO);
+	KUNIT_EXPECT_EQ(test, scale, 0);
+	KUNIT_EXPECT_EQ(test, nano, OSF_TEST_SCALE_NANO);
+	osf_core_start(pending);
+	KUNIT_EXPECT_EQ(test, pending->iio_dev_count, 1U);
+	len = osf_test_build_capability_frame(frame, sizeof(frame), 11);
+	KUNIT_EXPECT_EQ(test, osf_core_receive_frame(pending, frame, len),
+			OSF_STREAM_FRAME_IGNORED);
+	KUNIT_EXPECT_EQ(test, pending->iio_dev_count, 1U);
+	KUNIT_EXPECT_EQ(test, pending->latest_sample_count, 0U);
+}
+
+static void osf_early_duplicate_capability_is_rejected_test(struct kunit *test)
+{
+	struct osf_test_context *ctx = test->priv;
+	struct osf_device *pending;
+	u8 payload[OSF_CAP_REPORT_BASE_LEN + 2 * OSF_CAP_SENSOR_ENTRY_LEN] = { };
+	u8 frame[OSF_TEST_MAX_FRAME_LEN];
+	u8 *entry = payload + OSF_CAP_REPORT_BASE_LEN;
+	size_t len;
+	int ret;
+
+	pending = kunit_kzalloc(test, sizeof(*pending), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, pending);
+	osf_core_init(pending, ctx->dev);
+	ret = kunit_add_action_or_reset(test, osf_test_unregister_pending, pending);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	put_unaligned_le16(2, payload);
+	put_unaligned_le16(OSF_SENSOR_ACCELEROMETER, entry);
+	put_unaligned_le16(3, entry + 4);
+	put_unaligned_le16(OSF_SAMPLE_FORMAT_S32, entry + 6);
+	memcpy(entry + OSF_CAP_SENSOR_ENTRY_LEN, entry, OSF_CAP_SENSOR_ENTRY_LEN);
+	len = osf_test_build_frame(frame, sizeof(frame), OSF_MSG_CAPABILITY_REPORT,
+				   payload, sizeof(payload), 20);
+	KUNIT_EXPECT_EQ(test, osf_core_receive_frame(pending, frame, len),
+			OSF_STREAM_FRAME_REJECTED);
+	KUNIT_EXPECT_FALSE(test, pending->capability_cache.valid);
+	KUNIT_EXPECT_EQ(test, pending->iio_dev_count, 0U);
+
+	/* A failed early report must not prevent a subsequent valid report. */
+	len = osf_test_build_capability_frame(frame, sizeof(frame), 21);
+	KUNIT_EXPECT_EQ(test, osf_core_receive_frame(pending, frame, len),
+			OSF_STREAM_FRAME_HANDLED);
+	osf_core_start(pending);
+	KUNIT_EXPECT_EQ(test, pending->iio_dev_count, 1U);
+}
+
+static struct kunit_case osf_core_test_cases[] = {
+	KUNIT_CASE(osf_early_capability_is_owned_test),
+	KUNIT_CASE(osf_early_duplicate_capability_is_rejected_test),
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
diff --git a/drivers/iio/opensensorfusion/osf_iio.c
b/drivers/iio/opensensorfusion/osf_iio.c
new file mode 100644
index 000000000000..936d7ed7843f
--- /dev/null
+++ b/drivers/iio/opensensorfusion/osf_iio.c
@@ -0,0 +1,336 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/array_size.h>
+#include <linux/bitmap.h>
+#include <linux/bitops.h>
+#include <linux/cleanup.h>
+#include <linux/errno.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/kfifo_buf.h>
+#include <linux/mutex.h>
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
+};
+
+struct osf_iio_state {
+	const struct osf_iio_sensor_spec *spec;
+	struct iio_buffer *buffer;
+	/* Serializes pushes with buffer activation and quiescence. */
+	struct mutex buffer_lock;
+	bool buffer_active;
+	u32 scale_nano;
+	u16 sensor_index;
+	struct osf_device *osf;
+};
+
+struct osf_iio_scan_3axis {
+	s32 values[3];
+	u32 padding;
+	aligned_s64 timestamp;
+};
+
+struct osf_iio_scan_1axis {
+	s32 value;
+	u32 padding;
+	aligned_s64 timestamp;
+};
+
+#define OSF_MOD_CHAN(_type, _mod, _idx)				\
+	{								\
+		.type = (_type),					\
+		.modified = 1,						\
+		.channel2 = (_mod),					\
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
+		.scan_index = (_idx),					\
+		.scan_type = {						\
+			.sign = 's',					\
+			.realbits = 32,					\
+			.storagebits = 32,				\
+			.endianness = IIO_CPU,				\
+		},							\
+	}
+
+#define OSF_CHAN(_type, _idx)					\
+	{								\
+		.type = (_type),					\
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
+		.scan_index = (_idx),					\
+		.scan_type = {						\
+			.sign = 's',					\
+			.realbits = 32,					\
+			.storagebits = 32,				\
+			.endianness = IIO_CPU,				\
+		},							\
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
+static int osf_iio_buffer_postenable(struct iio_dev *indio_dev)
+{
+	struct osf_iio_state *state = iio_priv(indio_dev);
+
+	guard(mutex)(&state->buffer_lock);
+	state->buffer_active = true;
+
+	return 0;
+}
+
+static int osf_iio_buffer_predisable(struct iio_dev *indio_dev)
+{
+	struct osf_iio_state *state = iio_priv(indio_dev);
+
+	/* Wait for the current push before the IIO core changes its buffers. */
+	guard(mutex)(&state->buffer_lock);
+	state->buffer_active = false;
+
+	return 0;
+}
+
+static const struct iio_buffer_setup_ops osf_iio_buffer_ops = {
+	.postenable = osf_iio_buffer_postenable,
+	.predisable = osf_iio_buffer_predisable,
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
+	mutex_init(&state->buffer_lock);
+
+	iio_dev->name = spec->name;
+	iio_dev->info = &osf_iio_info;
+	iio_dev->setup_ops = &osf_iio_buffer_ops;
+	iio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;
+	iio_dev->channels = spec->channels;
+	iio_dev->num_channels = spec->num_channels;
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
+	guard(mutex)(&state->buffer_lock);
+	if (!state->buffer_active || !iio_buffer_enabled(indio_dev))
+		return 0;
+
+	timestamp = iio_get_time_ns(indio_dev);
+
+	switch (channel_count) {
+	case 1: {
+		struct osf_iio_scan_1axis scan = {
+			.value = values[0],
+		};
+
+		return iio_push_to_buffers_with_ts(indio_dev, &scan,
+						   sizeof(scan), timestamp);
+	}
+	case 3: {
+		struct osf_iio_scan_3axis scan = {
+			.values = { },
+		};
+		unsigned int channel, index = 0;
+
+		/* Pack the active channels; unused storage remains initialized. */
+		for_each_set_bit(channel, indio_dev->active_scan_mask, channel_count)
+			scan.values[index++] = values[channel];
+
+		return iio_push_to_buffers_with_ts(indio_dev, &scan,
+						   sizeof(scan), timestamp);
+	}
+	default:
+		return -EPROTO;
+	}
+}
diff --git a/drivers/iio/opensensorfusion/osf_iio.h
b/drivers/iio/opensensorfusion/osf_iio.h
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
diff --git a/drivers/iio/opensensorfusion/osf_iio_test.c
b/drivers/iio/opensensorfusion/osf_iio_test.c
new file mode 100644
index 000000000000..63d3ca1af329
--- /dev/null
+++ b/drivers/iio/opensensorfusion/osf_iio_test.c
@@ -0,0 +1,325 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <kunit/device.h>
+#include <kunit/test.h>
+
+#include <linux/bitmap.h>
+#include <linux/completion.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/buffer_impl.h>
+#include <linux/iio/iio.h>
+#include <linux/kthread.h>
+#include <linux/string.h>
+
+#include "osf_core.h"
+#include "osf_iio.h"
+
+static noinline void osf_test_poison_stack(void)
+{
+	u8 bytes[1024];
+
+	memset(bytes, 0xa5, sizeof(bytes));
+	barrier_data(bytes);
+}
+
+static void osf_iio_check_scan(struct kunit *test, struct iio_dev *indio_dev,
+			       const s32 *values, unsigned int channels,
+			       unsigned int mask, bool ts)
+{
+	struct iio_buffer *buffer = indio_dev->buffer;
+	unsigned int data_bytes = hweight32(mask) * sizeof(s32);
+	unsigned int ts_offset = ALIGN(data_bytes, 8);
+	unsigned int scan_bytes = ts ? ts_offset + 8 : data_bytes;
+	unsigned int offset = 0;
+	u8 scan[24] __aligned(8);
+	s64 before, after, timestamp;
+	int ret;
+
+	bitmap_zero((unsigned long *)buffer->scan_mask,
iio_get_masklength(indio_dev));
+	for (unsigned int i = 0; i < channels; i++)
+		if (mask & BIT(i))
+			set_bit(i, (unsigned long *)buffer->scan_mask);
+	buffer->scan_timestamp = ts;
+	ret = iio_update_buffers(indio_dev, buffer, NULL);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	kunit_info(test, "device=%s mask=%u ts=%u bytes=%u\n",
+		   indio_dev->name, mask, ts, scan_bytes);
+	memset(scan, 0xa5, sizeof(scan));
+	before = iio_get_time_ns(indio_dev);
+	osf_test_poison_stack();
+	ret = osf_iio_push_sample(indio_dev, values, channels);
+	after = iio_get_time_ns(indio_dev);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, buffer->bytes_per_datum, scan_bytes);
+	ret = iio_pop_from_buffer(buffer, scan);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	if (ret)
+		goto disable;
+
+	for (unsigned int i = 0; i < channels; i++) {
+		if (!(mask & BIT(i)))
+			continue;
+		KUNIT_EXPECT_MEMEQ(test, scan + offset, &values[i], sizeof(s32));
+		offset += sizeof(s32);
+	}
+	if (ts) {
+		for (unsigned int i = data_bytes; i < ts_offset; i++)
+			KUNIT_EXPECT_EQ(test, scan[i], (u8)0);
+		memcpy(&timestamp, scan + ts_offset, sizeof(timestamp));
+		KUNIT_EXPECT_GE(test, timestamp, before);
+		KUNIT_EXPECT_LE(test, timestamp, after);
+	}
+	/* Neither kfifo nor the producer may write outside the consumer stride. */
+	for (unsigned int i = scan_bytes; i < sizeof(scan); i++)
+		KUNIT_EXPECT_EQ(test, scan[i], (u8)0xa5);
+
+disable:
+	KUNIT_EXPECT_EQ(test, iio_update_buffers(indio_dev, NULL, buffer), 0);
+}
+
+/* Protect timestamp alignment holes and every supported scan layout. */
+static void osf_iio_scan_bytes_test(struct kunit *test)
+{
+	static const u16 types[] = {
+		OSF_SENSOR_ACCELEROMETER, OSF_SENSOR_GYROSCOPE,
+		OSF_SENSOR_MAGNETOMETER, OSF_SENSOR_TEMPERATURE,
+	};
+	const s32 values[] = { 101, -202, 303 };
+	struct osf_capability_entry entry = {
+		.sample_format = OSF_SAMPLE_FORMAT_S32,
+		.scale_nano = 1000000,
+	};
+	struct osf_device *osf;
+	struct device *dev;
+
+	dev = kunit_device_register(test, "osf-iio");
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+	osf = kunit_kzalloc(test, sizeof(*osf), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, osf);
+	osf_core_init(osf, dev);
+
+	for (unsigned int t = 0; t < ARRAY_SIZE(types); t++) {
+		unsigned int channels = t == 3 ? 1 : 3;
+		struct iio_dev *indio_dev;
+		int ret;
+
+		entry.sensor_type = types[t];
+		entry.channel_count = channels;
+		ret = osf_iio_register_sensor(dev, &entry, osf, &indio_dev);
+		KUNIT_ASSERT_EQ(test, ret, 0);
+		for (unsigned int mask = 1; mask < BIT(channels); mask++)
+			for (unsigned int ts = 0; ts < 2; ts++)
+				osf_iio_check_scan(test, indio_dev, values, channels, mask, ts);
+		osf_iio_unregister_sensor(indio_dev);
+	}
+}
+
+struct osf_iio_race {
+	struct iio_buffer_access_funcs access;
+	const struct iio_buffer_access_funcs *original;
+	struct iio_dev *indio_dev;
+	struct completion entered;
+	struct completion release;
+	struct completion config_started;
+	struct completion config_done;
+	atomic_t block_store;
+	atomic_t stores;
+	atomic_t disabled;
+	atomic_t bad_store;
+	int enable_error;
+	int disable_error;
+	int config_result;
+	bool unregister;
+};
+
+static struct osf_iio_race *osf_iio_race_from_buffer(struct iio_buffer *buffer)
+{
+	return container_of(buffer->access, struct osf_iio_race, access);
+}
+
+static int osf_iio_test_store(struct iio_buffer *buffer, const void *data)
+{
+	struct osf_iio_race *race = osf_iio_race_from_buffer(buffer);
+
+	if (atomic_xchg(&race->block_store, 0)) {
+		complete(&race->entered);
+		if (!wait_for_completion_timeout(&race->release, 5 * HZ))
+			return -ETIMEDOUT;
+	}
+	if (atomic_read(&race->disabled))
+		atomic_inc(&race->bad_store);
+	atomic_inc(&race->stores);
+	return race->original->store_to(buffer, data);
+}
+
+static int osf_iio_test_enable(struct iio_buffer *buffer, struct
iio_dev *indio_dev)
+{
+	struct osf_iio_race *race = osf_iio_race_from_buffer(buffer);
+
+	if (race->enable_error)
+		return race->enable_error;
+	atomic_set(&race->disabled, 0);
+	return 0;
+}
+
+static int osf_iio_test_disable(struct iio_buffer *buffer, struct
iio_dev *indio_dev)
+{
+	struct osf_iio_race *race = osf_iio_race_from_buffer(buffer);
+
+	atomic_set(&race->disabled, 1);
+	return race->disable_error;
+}
+
+static int osf_iio_test_producer(void *data)
+{
+	struct osf_iio_race *race = data;
+	const s32 values[] = { 101, -202, 303 };
+
+	while (!kthread_should_stop()) {
+		osf_iio_push_sample(race->indio_dev, values, ARRAY_SIZE(values));
+		cond_resched();
+	}
+	return 0;
+}
+
+static int osf_iio_test_configure(void *data)
+{
+	struct osf_iio_race *race = data;
+
+	complete(&race->config_started);
+	if (race->unregister) {
+		osf_iio_unregister_sensor(race->indio_dev);
+		race->config_result = 0;
+	} else {
+		race->config_result = iio_update_buffers(race->indio_dev, NULL,
+							 race->indio_dev->buffer);
+	}
+	complete(&race->config_done);
+	while (!kthread_should_stop())
+		msleep(20);
+	return 0;
+}
+
+static void osf_iio_expect_quiesce(struct kunit *test, struct
osf_iio_race *race)
+{
+	struct task_struct *config;
+	unsigned long waited;
+
+	config = kthread_run(osf_iio_test_configure, race, "osf-cfg-test");
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, config);
+	KUNIT_EXPECT_NE(test,
wait_for_completion_timeout(&race->config_started, HZ), 0UL);
+	waited = wait_for_completion_timeout(&race->config_done,
msecs_to_jiffies(20));
+	KUNIT_EXPECT_EQ(test, waited, 0UL);
+	complete(&race->release);
+	KUNIT_EXPECT_NE(test,
wait_for_completion_timeout(&race->config_done, HZ), 0UL);
+	kthread_stop(config);
+	KUNIT_EXPECT_EQ(test, race->config_result, 0);
+}
+
+/* Run real IIO configuration and kfifo code against an independent
producer. */
+static void osf_iio_buffer_lifetime_test(struct kunit *test)
+{
+	struct osf_capability_entry entry = {
+		.sensor_type = OSF_SENSOR_ACCELEROMETER,
+		.channel_count = 3,
+		.sample_format = OSF_SAMPLE_FORMAT_S32,
+		.scale_nano = 1000000,
+	};
+	const s32 values[] = { 101, -202, 303 };
+	struct task_struct *producer;
+	struct osf_iio_race *race;
+	struct osf_device *osf;
+	struct iio_dev *indio_dev;
+	struct iio_buffer *buffer;
+	struct device *dev;
+	int stores, ret;
+
+	dev = kunit_device_register(test, "osf-race");
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+	osf = kunit_kzalloc(test, sizeof(*osf), GFP_KERNEL);
+	race = kunit_kzalloc(test, sizeof(*race), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, osf);
+	KUNIT_ASSERT_NOT_NULL(test, race);
+	osf_core_init(osf, dev);
+	ret = osf_iio_register_sensor(dev, &entry, osf, &indio_dev);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	buffer = indio_dev->buffer;
+	race->indio_dev = indio_dev;
+	race->original = buffer->access;
+	race->access = *buffer->access;
+	race->access.store_to = osf_iio_test_store;
+	race->access.enable = osf_iio_test_enable;
+	race->access.disable = osf_iio_test_disable;
+	buffer->access = &race->access;
+	init_completion(&race->entered);
+	init_completion(&race->release);
+	init_completion(&race->config_started);
+	init_completion(&race->config_done);
+	atomic_set(&race->disabled, 1);
+	set_bit(0, (unsigned long *)buffer->scan_mask);
+	KUNIT_EXPECT_EQ(test, iio_update_buffers(indio_dev, buffer, NULL), 0);
+
+	atomic_set(&race->block_store, 1);
+	producer = kthread_run(osf_iio_test_producer, race, "osf-rx-test");
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, producer);
+	KUNIT_EXPECT_NE(test, wait_for_completion_timeout(&race->entered, HZ), 0UL);
+	osf_iio_expect_quiesce(test, race);
+
+	for (unsigned int i = 0; i < 100; i++) {
+		bitmap_zero((unsigned long *)buffer->scan_mask,
iio_get_masklength(indio_dev));
+		*(unsigned long *)buffer->scan_mask = (i % 7) + 1;
+		buffer->scan_timestamp = i & 1;
+		KUNIT_EXPECT_EQ(test, iio_update_buffers(indio_dev, buffer, NULL), 0);
+		cond_resched();
+		KUNIT_EXPECT_EQ(test, iio_update_buffers(indio_dev, NULL, buffer), 0);
+	}
+
+	race->enable_error = -EIO;
+	KUNIT_EXPECT_EQ(test, iio_update_buffers(indio_dev, buffer, NULL), -EIO);
+	stores = atomic_read(&race->stores);
+	KUNIT_EXPECT_EQ(test, osf_iio_push_sample(indio_dev, values, 3), 0);
+	KUNIT_EXPECT_EQ(test, atomic_read(&race->stores), stores);
+	race->enable_error = 0;
+	KUNIT_EXPECT_EQ(test, iio_update_buffers(indio_dev, buffer, NULL), 0);
+	race->disable_error = -EIO;
+	KUNIT_EXPECT_EQ(test, iio_update_buffers(indio_dev, NULL, buffer), -EIO);
+	stores = atomic_read(&race->stores);
+	KUNIT_EXPECT_EQ(test, osf_iio_push_sample(indio_dev, values, 3), 0);
+	KUNIT_EXPECT_EQ(test, atomic_read(&race->stores), stores);
+	race->disable_error = 0;
+
+	KUNIT_EXPECT_EQ(test, iio_update_buffers(indio_dev, buffer, NULL), 0);
+	/* Retain ownership while testing unregister against an admitted push. */
+	get_device(&indio_dev->dev);
+	reinit_completion(&race->entered);
+	reinit_completion(&race->release);
+	reinit_completion(&race->config_started);
+	reinit_completion(&race->config_done);
+	atomic_set(&race->block_store, 1);
+	KUNIT_EXPECT_NE(test, wait_for_completion_timeout(&race->entered, HZ), 0UL);
+	race->unregister = true;
+	osf_iio_expect_quiesce(test, race);
+	kthread_stop(producer);
+	KUNIT_EXPECT_EQ(test, atomic_read(&race->bad_store), 0);
+	KUNIT_EXPECT_GT(test, atomic_read(&race->stores), 0);
+	buffer->access = race->original;
+	put_device(&indio_dev->dev);
+}
+
+static struct kunit_case osf_iio_test_cases[] = {
+	KUNIT_CASE(osf_iio_scan_bytes_test),
+	KUNIT_CASE(osf_iio_buffer_lifetime_test),
+	{ }
+};
+
+static struct kunit_suite osf_iio_test_suite = {
+	.name = "osf-iio",
+	.test_cases = osf_iio_test_cases,
+};
+
+kunit_test_suite(osf_iio_test_suite);
+
+MODULE_LICENSE("GPL");
diff --git a/drivers/iio/opensensorfusion/osf_serdev.c
b/drivers/iio/opensensorfusion/osf_serdev.c
new file mode 100644
index 000000000000..ae983b5557c6
--- /dev/null
+++ b/drivers/iio/opensensorfusion/osf_serdev.c
@@ -0,0 +1,162 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/cleanup.h>
+#include <linux/device-id/of.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
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
+	/* Serializes early capability delivery with the registration gate. */
+	struct mutex rx_lock;
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
+	guard(mutex)(&osf_uart->rx_lock);
+	authenticated_before = osf_uart->stream.stats.authenticated_frames;
+	ret = osf_stream_receive_bytes(&osf_uart->stream, buf, count);
+	stats = &osf_uart->stream.stats;
+
+	if (ret || stats->authenticated_frames != authenticated_before)
+		dev_dbg_ratelimited(&serdev->dev,
+				    "rx count=%zu authenticated=%llu handled=%llu ignored=%llu
rejected=%llu bad_magic=%llu bad_crc=%llu dropped=%llu ret=%d\n",
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
+static void osf_serdev_disable_vcc(void *vcc)
+{
+	regulator_disable(vcc);
+}
+
+static int osf_serdev_probe(struct serdev_device *serdev)
+{
+	struct device *dev = &serdev->dev;
+	struct osf_serdev *osf_uart;
+	struct regulator *vcc;
+	unsigned int baudrate;
+	int ret;
+
+	osf_uart = devm_kzalloc(dev, sizeof(*osf_uart), GFP_KERNEL);
+	if (!osf_uart)
+		return -ENOMEM;
+
+	vcc = devm_regulator_get(dev, "vcc");
+	if (IS_ERR(vcc))
+		return dev_err_probe(dev, PTR_ERR(vcc),
+				     "failed to get vcc regulator\n");
+
+	mutex_init(&osf_uart->rx_lock);
+	osf_uart->serdev = serdev;
+	osf_core_init(&osf_uart->osf, dev);
+	osf_stream_init(&osf_uart->stream, osf_serdev_receive_frame,
+			&osf_uart->osf);
+
+	serdev_device_set_drvdata(serdev, osf_uart);
+	serdev_device_set_client_ops(serdev, &osf_serdev_ops);
+
+	ret = serdev_device_open(serdev);
+	if (ret) {
+		osf_stream_reset(&osf_uart->stream);
+		osf_core_unregister_iio(&osf_uart->osf);
+
+		return ret;
+	}
+
+	baudrate = serdev_device_set_baudrate(serdev, OSF_SERDEV_BAUD);
+	if (baudrate != OSF_SERDEV_BAUD)
+		dev_warn(dev, "requested %u baud, controller set %u\n",
+			 OSF_SERDEV_BAUD, baudrate);
+
+	serdev_device_set_flow_control(serdev, false);
+
+	ret = regulator_enable(vcc);
+	if (ret) {
+		dev_err_probe(dev, ret, "failed to enable vcc regulator\n");
+		goto err_close;
+	}
+
+	ret = devm_add_action_or_reset(dev, osf_serdev_disable_vcc, vcc);
+	if (ret)
+		goto err_close;
+
+	/* No fallible probe steps remain when IIO children become visible. */
+	scoped_guard(mutex, &osf_uart->rx_lock)
+		osf_core_start(&osf_uart->osf);
+
+	return 0;
+
+err_close:
+	serdev_device_close(serdev);
+	osf_stream_reset(&osf_uart->stream);
+	osf_core_unregister_iio(&osf_uart->osf);
+
+	return ret;
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
