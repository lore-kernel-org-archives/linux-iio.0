Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F14522682
	for <linux-iio@vger.kernel.org>; Fri, 18 Sep 2026 18:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789755950; cv=none; b=UPyGPcttr3e9DkosrR9pcGWTmgX7WCfa/2LAipp/sw7XMV1HDXTszQnu6Eyp3XpPs5CEIFLi8E/QzJl0+rx3NaTMhsPCDycFX46q0hpbf+A4OFHjfAU4dPu+fT6zLucBZnZ3k2zEw2YS92xIDeBO5vYfE1HOyTUK1jmRVHqUG3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789755950; c=relaxed/simple;
	bh=UenmADVUAUDfeXZXbonm0hu1Jl7PjlTML8crQpyheZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gg2qhl6eFT2h6f/NWEHkRH1tTSyS3dv00pnWxnmPZ+Ank8SEq/GYy6GOf6ZI6VJ5/OJv8rmS6D9jqJ2cxC482YKJvMy8NHJYYv+mrimR2Nf+ABBlw6eT4rVlmQAk/n6AGGttuDIgzoq/7P30Wm9r2HdbWEwFAY4R4+riW410nDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K3ojjENb; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K3ojjENb"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d8fb334ddcso9502675ad.0
        for <linux-iio@vger.kernel.org>; Fri, 18 Sep 2026 11:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789755948; x=1790360748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3lkqG4yWnBqwjVGs0AZjcoYifhcHekb9XrWlB8YylUU=;
        b=K3ojjENbD4gUIm4Q42E4dtn5rdGIqDQzx6NO1ADXSkvtRFXYuYCag6ST+GGANlBOoG
         vTL8Zv6zQpGYiGLW4KuwMwdhYY1fc5c+5CALygBo+tI1JycU16+0jRZu19I0RWjH9ZQq
         jccajotsaKxo9pn9/v/uDgvNbeoKNBHtrbazqDhUINkUH6ecVk59yQbTif1v/FVBifsb
         GNaFTQgD5r9NILi0Dv+fpzkuhEsVZ36qZeTGmIi1pSJjyBQRZtYOr4Le50kk9cgB+HpM
         g9DkV6ZiUCvkL49ZAa/5PW+kDNYCRMy594I/ToPdnMmldswRrLJ69gRWeDkpIwdkfbLG
         gPLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789755948; x=1790360748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3lkqG4yWnBqwjVGs0AZjcoYifhcHekb9XrWlB8YylUU=;
        b=PAD/1/GMh1hHzpVmphHEP/1z1I2YE6ydU0C/p3qHjk37kqtp9JpbQBxCEzcMTJmFCO
         ZADFFj5sgk8eKyQEBy2aJFsrz/LtvzMmVr6ZWGy+k2u07BJmrADlYWm/bdHRKzxsZjLJ
         lMVxe2Bph7nk3HK+TTlDBhSQTVioQftAP01NaddGfn6iy+5EGJumkR6xo0pr/xLYXkXs
         iX1NvWgmp0g6Bd1WTLdj+XepkLmKRF90LsIyeXgCnr/GeMYyNpBWH/0gemfkxIJ8eaXD
         GibuFlTwDqCjqeBM3NhyowA4/njDAxsC8Y88HJiU5Wj7Rz4+MLedAAvpBIydtSVPnieo
         KqnA==
X-Forwarded-Encrypted: i=1; AKwUvBw5bCNY0bEakHhNlXhw34H+QW80h3HvBrdIEAaO2fOWhSIc1fR8IicgoAm2uNEYA0Na3ocJ0E00w3E=@vger.kernel.org
X-Gm-Message-State: AFuF++nyG8dFB87NL0Y9C055FVLepoYc/MbEN4A89MUzN3M8VZTyLxmN
	Tu5bjORbz1S7/b/+eJU/2/8W7ZXDeWWL/ZXybeNm1WUIL9yZ4bGGAs5L
X-Gm-Gg: AYBFou1Rg5PZ8cKQkY6ARb0w9sPhIWX0tGYYWwli3bUvKAd9QFIL2C8onvMlIkb12fA
	dYVRZ1g7Lw80o8kx/Tj030v1j/D0uQ45Ol4y+0nLPCfg1bN5rbA1x8eAX/T4n0JAzgR9boM7Q0O
	fo1HTyB8oft3EzRFfLNh8NZNGAP9+UhrQbN6Ahl/eTjmBrFwXw1q9JW3j6ceaYfUz83SjQ2OgM0
	A3LFtoh7+vwsSjIbZYe2jfRYfvNcrq6l+zQuPj+pnJgy1lmzd3d7RjfrWNlgq1Z/nCyviLv61lV
	BQZiK5pi8L2q04AAE1i52xm5x2n+6VZCWEeFxsH3lRWSBXwDeIiDpBHr+UAaY6yK3gNyOETi7js
	pAlXUwVSrgYjVPWfogVe1kymK2dGgV2l8YObyP8qPp0oXNR5MGbIvjt1fKCYeSDVdKd2k/oXzFf
	Y1CNx+jprAPJAiAfaM4GAXbHazOI6AopMKKNg91XCwRXM6uQTj7HqYK8WzwwQPTReLhMGpvbByu
	1clBFYA8oojEjPPr27lclutFIMiIgpkFWBKJi4HJDhmd2AQ9gHN6J40c9nubqlVvzEhP2UOXzpG
	2L7kgWlZ
X-Received: by 2002:a17:903:b87:b0:2dd:ad73:c93c with SMTP id d9443c01a7336-2ddb1bed468mr73811075ad.29.1789755947743;
        Fri, 18 Sep 2026 11:25:47 -0700 (PDT)
Received: from DESKTOP-G3E0OSP.localdomain ([58.224.60.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddc16b49casm871895ad.7.2026.09.18.11.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 11:25:47 -0700 (PDT)
From: Jinseob Kim <kimjinseob88@gmail.com>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andriy.shevchenko@intel.com,
	linux-kernel@vger.kernel.org,
	rdunlap@infradead.org,
	joshua.crofts1@gmail.com,
	u.kleine-koenig@baylibre.com,
	julianbraha@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v10 5/8] iio: osf: add UART transport and core receive path
Date: Sat, 19 Sep 2026 03:24:43 +0900
Message-ID: <5eaeefa79fc2ba956bf34f691c0dc65592e5c4c8.1789753020.git.kimjinseob88@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1789753020.git.kimjinseob88@gmail.com>
References: <cover.1789753020.git.kimjinseob88@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Connect the stream parser to a serdev receiver and add core frame dispatch
with an owned device-status cache. Preserve the distinction between
unvalidated candidates and validated application rejections, so
malformed status payloads do not cause byte-wise resynchronization.

Open and configure the UART before enabling the supply. A managed release
action closes and drains the receive producer before resetting the parser
and disabling a successfully enabled supply.

This transport base processes device-status frames and ignores message
types without an application handler. It does not register IIO sensor
devices. The following patch adds capability discovery and sample
publication to IIO, including the publication gate and IIO teardown.

Assisted-by: LLM
Signed-off-by: Jinseob Kim <kimjinseob88@gmail.com>
---
 MAINTAINERS                               |   3 +-
 drivers/iio/Kconfig                       |   1 +
 drivers/iio/Makefile                      |   1 +
 drivers/iio/opensensorfusion/Kconfig      |  12 ++
 drivers/iio/opensensorfusion/Makefile     |   5 +
 drivers/iio/opensensorfusion/osf_core.c   | 101 +++++++++++++++
 drivers/iio/opensensorfusion/osf_core.h   |  29 +++++
 drivers/iio/opensensorfusion/osf_serdev.c | 143 ++++++++++++++++++++++
 8 files changed, 293 insertions(+), 2 deletions(-)
 create mode 100644 drivers/iio/opensensorfusion/Kconfig
 create mode 100644 drivers/iio/opensensorfusion/Makefile
 create mode 100644 drivers/iio/opensensorfusion/osf_core.c
 create mode 100644 drivers/iio/opensensorfusion/osf_core.h
 create mode 100644 drivers/iio/opensensorfusion/osf_serdev.c

diff --git a/MAINTAINERS b/MAINTAINERS
index bad05db854cf..fbbf5f06f1a5 100644
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
diff --git a/drivers/iio/opensensorfusion/Kconfig b/drivers/iio/opensensorfusion/Kconfig
new file mode 100644
index 000000000000..fa25ad24bef6
--- /dev/null
+++ b/drivers/iio/opensensorfusion/Kconfig
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config OPEN_SENSOR_FUSION
+	tristate "Open Sensor Fusion UART receiver"
+	depends on SERIAL_DEV_BUS
+	select CRC32
+	help
+	  Build the Open Sensor Fusion UART receive path.
+
+	  The driver receives and validates OSF protocol frames over a serdev
+	  UART and caches device status reported by the sensor hub.
+	  Message types without an application handler are ignored.
diff --git a/drivers/iio/opensensorfusion/Makefile b/drivers/iio/opensensorfusion/Makefile
new file mode 100644
index 000000000000..940c82eddc2e
--- /dev/null
+++ b/drivers/iio/opensensorfusion/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+obj-$(CONFIG_OPEN_SENSOR_FUSION) += open-sensor-fusion.o
+
+open-sensor-fusion-y := osf_core.o osf_protocol.o osf_serdev.o osf_stream.o
diff --git a/drivers/iio/opensensorfusion/osf_core.c b/drivers/iio/opensensorfusion/osf_core.c
new file mode 100644
index 000000000000..e6812cef4d8c
--- /dev/null
+++ b/drivers/iio/opensensorfusion/osf_core.c
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/types.h>
+
+#include "osf_core.h"
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
+	switch (frame.message_type) {
+	case OSF_MSG_DEVICE_STATUS:
+		ret = osf_core_handle_device_status(osf, &frame);
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
+	 * Handler failures are validated application rejections. Keep the
+	 * trusted frame boundary and let the stream consume the complete frame.
+	 */
+	if (ret < 0)
+		return OSF_STREAM_FRAME_REJECTED;
+
+	return ret;
+}
diff --git a/drivers/iio/opensensorfusion/osf_core.h b/drivers/iio/opensensorfusion/osf_core.h
new file mode 100644
index 000000000000..7095e3f967fc
--- /dev/null
+++ b/drivers/iio/opensensorfusion/osf_core.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _OSF_CORE_H
+#define _OSF_CORE_H
+
+#include <linux/types.h>
+
+#include "osf_protocol.h"
+
+struct device;
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
+	struct device *dev;
+	struct osf_status_cache status_cache;
+	u64 last_sequence;
+};
+
+void osf_core_init(struct osf_device *osf, struct device *dev);
+int osf_core_receive_frame(struct osf_device *osf, const u8 *buf, size_t len);
+
+#endif
diff --git a/drivers/iio/opensensorfusion/osf_serdev.c b/drivers/iio/opensensorfusion/osf_serdev.c
new file mode 100644
index 000000000000..8a747c01ff9d
--- /dev/null
+++ b/drivers/iio/opensensorfusion/osf_serdev.c
@@ -0,0 +1,143 @@
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
+	struct regulator *vcc;
+	bool vcc_enabled;
+	struct osf_device osf;
+	struct osf_stream stream;
+	/* Protects the parser and all RX counters. */
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
+	u64 validated_before;
+	int ret;
+
+	guard(mutex)(&osf_uart->rx_lock);
+	validated_before = osf_uart->stream.stats.validated_frames;
+	ret = osf_stream_receive_bytes(&osf_uart->stream, buf, count);
+	stats = &osf_uart->stream.stats;
+
+	if (ret || stats->validated_frames != validated_before)
+		dev_dbg_ratelimited(&serdev->dev,
+				    "rx count=%zu validated=%llu handled=%llu ignored=%llu rejected=%llu bad_magic=%llu bad_crc=%llu dropped=%llu ret=%d\n",
+				    count, stats->validated_frames,
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
+static void osf_serdev_release(void *data)
+{
+	struct osf_serdev *osf_uart = data;
+
+	/* The TTY controller drains RX work on close; hold no RX lock. */
+	serdev_device_close(osf_uart->serdev);
+	osf_stream_reset(&osf_uart->stream);
+	if (osf_uart->vcc_enabled)
+		regulator_disable(osf_uart->vcc);
+}
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
+	osf_uart->vcc = devm_regulator_get(dev, "vcc");
+	if (IS_ERR(osf_uart->vcc))
+		return dev_err_probe(dev, PTR_ERR(osf_uart->vcc),
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
+	if (ret)
+		return ret;
+
+	ret = devm_add_action_or_reset(dev, osf_serdev_release, osf_uart);
+	if (ret)
+		return ret;
+
+	baudrate = serdev_device_set_baudrate(serdev, OSF_SERDEV_BAUD);
+	if (baudrate != OSF_SERDEV_BAUD)
+		/* Keep accepting controller rounding after reporting the mismatch. */
+		dev_warn_probe(dev, -EINVAL, "requested %u baud, controller set %u\n",
+			       OSF_SERDEV_BAUD, baudrate);
+
+	serdev_device_set_flow_control(serdev, false);
+
+	ret = regulator_enable(osf_uart->vcc);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to enable vcc regulator\n");
+	osf_uart->vcc_enabled = true;
+
+	return 0;
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
+	.driver = {
+		.name = "open-sensor-fusion-uart",
+		.of_match_table = osf_serdev_of_match,
+	},
+};
+module_serdev_device_driver(osf_serdev_driver);
+
+MODULE_DESCRIPTION("Open Sensor Fusion UART receiver");
+MODULE_LICENSE("GPL");
-- 
2.43.0

