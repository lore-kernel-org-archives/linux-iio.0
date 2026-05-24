Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E3F360ECB
	for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 08:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779612839; cv=none; b=WNcrH8j9PGOW13yPpCecxlnimHiyc1tA8XD4J6xXTxgcAbtTa0fhfujjuKs/2WQF8F+N7TMoEUwbGrmSZXTP+dU4CZpol/TNjihjv5uB5BAA1XNlLV6yvXo1TCT+GUaDYAqdvPYQnKqwBHBVVqE2pk1c4c/AT6AJFhij0KuBBIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779612839; c=relaxed/simple;
	bh=3gOpPRRNnJMdMSXvFzoMff2zE9qGPtKmEvX+FwSqOJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cRLhSbhZuM3dQ+G24GjRUgqCxG4dPmHPD9avEcDjEJlaIcFmZNtk39QDHKWEjX38+7n4EBHiqISLMRW5NcPqCp84eCePA9dRwySlFg4/WqjBF1aDqvHuMumBss7y5d57CI8jW13h1TryeAyq389t2RfwhZlbGwnMj+4lI3G3bKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dzyS7sRh; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dzyS7sRh"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8419ab3a297so17643b3a.2
        for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 01:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779612837; x=1780217637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ODoHNkdYEScxRBQ09YOSCqOJ+T3sjTnVlEMajTXRzCY=;
        b=dzyS7sRhz0bliFW18Ze+R7Dwbk8Z9PFFGiYLMFDm5AyPgyHie8IOZX2TrMja+mE8Pl
         4oil5bLtixrYOFjtKQZrrKrLTzjijG/M1/AzYJou8FBAHuou5/plgnN5sZwLLFQLNGhn
         bjvlHnyu/ruRoADamuQRzPVdefW+1dMcyBQZUjIyq3Wwyo6/eLR4ddnv5adjrhMzUyjB
         uL0uXC+AwDqt//j+MuIsffbESQiwfzhqS43CRuV6TXjtOWMCiGG303jZbvK+FRFK8qVa
         RGrsFNHxZlFbIstrye9f2FGERKrkSWi6WUNb9fkNGmjO0tP0ZWBCaUmHI/IsegPdXloH
         h6gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779612837; x=1780217637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ODoHNkdYEScxRBQ09YOSCqOJ+T3sjTnVlEMajTXRzCY=;
        b=BNXQEH2Sjmd45cvxqwWtkLdIbK4Eutet2QLyDMr4qfST6a+RrFAddDcUCPYWjjLpVx
         Qfy4A4vNiA+L+1V5bFFguNNNWpTHXeUfLyjBFEIYnv5FK13eydniVxnaCQJQbjIcLYjH
         MdI1rPwCtlypmzMlEqKnWX0LWIZN/Tu7QOoqiIqFhqW+o67fHSZLTdmTLa0zQrJYFMkz
         PGMH7C1Dcu3zm58ZuRwIn/P06vQVD40fzskJeUnCCdS+rAS9t3+A2pHZnEQLKN6ouwbn
         n6UL1XuNTM0jnSQIGF4apDb9Ra0tAQMSALu+QiiHSja8LHkdUYG72G+tDpWfBxd1/Svf
         MFXA==
X-Forwarded-Encrypted: i=1; AFNElJ/qAKXN9EM154WxEHULTL/7m1MIEgNUQ9xggH9WJ4JmH3MLy5SknpL+UdtOq6enuq5z8lKMSGj4FRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuK6DTzjP8/AZfh2ypmLQzR7W35WDxy/xwJq4NMfIqorU9THuA
	It15RXeVnRE17nyRWbjb2enkmzRBI6xoy4zsnODW4ufffqmHB50XApdK
X-Gm-Gg: Acq92OFx1GVjpv9vqrE/ea1gfywj408BBUn5xjIogUCMps1D1CgJXvQ3wGYI+T/u2cH
	IkIDvLecfWgXlJ3uOgUNyXdpgZc3F0UKeCFPdP1kDk2sHSype2X2e42LlbaAxMHHYCXDdsvUKoE
	HGed6o2Yjymf/fgBC4fzyk01Q+Q/UV5cZ+/W1g1VAGLx/zb/WwD/q4gt8p7gme0gyOfmWZIoqJP
	i70yEoDlRB3OFexkbe+UMvr9hGEwQW2ZBhgUC9mBKKquM240cvPy+ofBlyLHuT87RHdUXJ1hcGy
	hCaMTo7T7oz3rAA21Q7lkuwuqUJvS0D22t/Mz2LWxruPYiluaPbZq9sBtyPgGM5qdW70WzS241Z
	aA3GlUzWarepa+VwztH5mGflCDw/K8YRb452cQtdxOAtJqoRYuJQpcqBX9qANdRUVEb7m6EkdQ/
	vcGlCYXWrrM/MN6/IIkVikAjhhaw/FAgKDfrTwNm6VS1+AKduHPoFwVBlctT+Fkch/9/q791N8f
	AvBZwyfHnnX/YAO/NF4pBVe6K7QMWD3NYN3Cit+W5iVK2hl
X-Received: by 2002:a05:6a00:849:b0:83e:f228:b112 with SMTP id d2e1a72fcca58-8415f3799aemr9623045b3a.34.1779612836985;
        Sun, 24 May 2026 01:53:56 -0700 (PDT)
Received: from DESKTOP-G3E0OSP.localdomain ([112.172.255.242])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164ea4de4sm6353116b3a.35.2026.05.24.01.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 01:53:56 -0700 (PDT)
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
	linux-kernel@vger.kernel.org,
	Jinseob Kim <kimjinseob88@gmail.com>
Subject: [PATCH RFC v2 5/7] iio: osf: add UART serdev transport
Date: Sun, 24 May 2026 17:53:10 +0900
Message-ID: <20260524085312.15369-6-kimjinseob88@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260524085312.15369-1-kimjinseob88@gmail.com>
References: <20260524085312.15369-1-kimjinseob88@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the serdev receive path that feeds decoded OSF0 frames to the core.

Signed-off-by: Jinseob Kim <kimjinseob88@gmail.com>
---
 drivers/iio/Kconfig                       |   1 +
 drivers/iio/Makefile                      |   1 +
 drivers/iio/opensensorfusion/Kconfig      |  15 +++
 drivers/iio/opensensorfusion/Makefile     |   5 +
 drivers/iio/opensensorfusion/osf_core.c   | 107 +++++++++++++++++++++
 drivers/iio/opensensorfusion/osf_core.h   |  18 ++++
 drivers/iio/opensensorfusion/osf_serdev.c | 111 ++++++++++++++++++++++
 7 files changed, 258 insertions(+)
 create mode 100644 drivers/iio/opensensorfusion/Kconfig
 create mode 100644 drivers/iio/opensensorfusion/Makefile
 create mode 100644 drivers/iio/opensensorfusion/osf_core.c
 create mode 100644 drivers/iio/opensensorfusion/osf_core.h
 create mode 100644 drivers/iio/opensensorfusion/osf_serdev.c

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
index 000000000..360f25b4f
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
+	help
+	  Build the Open Sensor Fusion UART receive path.
+
+	  The driver receives OSF0 frames over a serdev UART.
+	  Frames are decoded and validated before being passed to the
+	  driver core.
+	  This patch only adds the transport path.
+	  IIO device registration is added separately.
diff --git a/drivers/iio/opensensorfusion/Makefile b/drivers/iio/opensensorfusion/Makefile
new file mode 100644
index 000000000..940c82edd
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
index 000000000..c867b3158
--- /dev/null
+++ b/drivers/iio/opensensorfusion/osf_core.c
@@ -0,0 +1,107 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <linux/types.h>
+
+#include "osf_core.h"
+#include "osf_protocol.h"
+
+#define OSF_RESERVED_MSG_FIRST		0x7f00
+#define OSF_RESERVED_MSG_LAST		0x7fff
+#define OSF_VENDOR_PRIVATE_FIRST	0x8000
+
+void osf_core_init(struct osf_device *osf, struct device *dev)
+{
+	memset(osf, 0, sizeof(*osf));
+	osf->dev = dev;
+}
+
+void osf_core_unregister_iio(struct osf_device *osf)
+{
+}
+
+static int osf_core_validate_sensor_sample(const struct osf_frame *frame)
+{
+	struct osf_sensor_sample sample;
+
+	return osf_protocol_decode_sensor_sample(frame, &sample);
+}
+
+static int osf_core_validate_device_status(const struct osf_frame *frame)
+{
+	struct osf_device_status status;
+	int ret;
+
+	ret = osf_protocol_decode_device_status(frame, &status);
+	if (ret)
+		return ret;
+
+	if (status.reserved)
+		return -EPROTO;
+
+	return 0;
+}
+
+static int osf_core_validate_capability_report(const struct osf_frame *frame)
+{
+	struct osf_capability_entry entry;
+	struct osf_capability_report report;
+	unsigned int i;
+	int ret;
+
+	ret = osf_protocol_decode_capability_report(frame, &report);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < report.capability_count; i++) {
+		ret = osf_protocol_decode_capability_entry(&report, i, &entry);
+		if (ret)
+			return ret;
+	}
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
+		ret = osf_core_validate_sensor_sample(&frame);
+		break;
+	case OSF_MSG_DEVICE_STATUS:
+		ret = osf_core_validate_device_status(&frame);
+		break;
+	case OSF_MSG_CAPABILITY_REPORT:
+		ret = osf_core_validate_capability_report(&frame);
+		break;
+	default:
+		if (frame.message_type >= OSF_RESERVED_MSG_FIRST &&
+		    frame.message_type <= OSF_RESERVED_MSG_LAST)
+			ret = 0;
+		else if (frame.message_type >= OSF_VENDOR_PRIVATE_FIRST)
+			ret = 0;
+		else
+			ret = -EOPNOTSUPP;
+		break;
+	}
+
+	if (!ret)
+		osf->last_sequence = frame.sequence;
+
+	return ret;
+}
diff --git a/drivers/iio/opensensorfusion/osf_core.h b/drivers/iio/opensensorfusion/osf_core.h
new file mode 100644
index 000000000..3680c8c9b
--- /dev/null
+++ b/drivers/iio/opensensorfusion/osf_core.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _OSF_CORE_H
+#define _OSF_CORE_H
+
+#include <linux/types.h>
+
+struct device;
+
+struct osf_device {
+	struct device *dev;
+	u64 last_sequence;
+};
+
+void osf_core_init(struct osf_device *osf, struct device *dev);
+void osf_core_unregister_iio(struct osf_device *osf);
+int osf_core_receive_frame(struct osf_device *osf, const u8 *buf, size_t len);
+
+#endif
diff --git a/drivers/iio/opensensorfusion/osf_serdev.c b/drivers/iio/opensensorfusion/osf_serdev.c
new file mode 100644
index 000000000..f121089ed
--- /dev/null
+++ b/drivers/iio/opensensorfusion/osf_serdev.c
@@ -0,0 +1,111 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/of.h>
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
+	osf_core_init(&osf_uart->osf, &serdev->dev);
+	osf_stream_init(&osf_uart->stream, &osf_uart->osf);
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
+	return 0;
+}
+
+static void osf_serdev_remove(struct serdev_device *serdev)
+{
+	struct osf_serdev *osf_uart = serdev_device_get_drvdata(serdev);
+
+	serdev_device_close(serdev);
+	osf_stream_reset(&osf_uart->stream);
+	osf_core_unregister_iio(&osf_uart->osf);
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
+module_serdev_device_driver(osf_serdev_driver);
+
+MODULE_DESCRIPTION("Open Sensor Fusion IIO driver");
+MODULE_LICENSE("GPL");
-- 
2.43.0

