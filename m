Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE63A39DBCC
	for <linux-iio@vger.kernel.org>; Tue, 16 Jun 2026 07:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781594615; cv=none; b=mS4KkXQ83hOFRJTZf9DRW4umm9pTDQSWzYUO4M7G6oWTr4f+Wx9gXhB68nXlGlP2YcE1iVDgvxUIQdWBc5VrvzJ0AuYAqcmeCVmipTru34hJsbV1Cl6OpXkOTKfGubSW6Z/6SfO1Fuy3c95XhfQqu/VSnFAGwExiC10aWkGVm34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781594615; c=relaxed/simple;
	bh=k2XhE31maj9rjjs9uA4fAtj9O9Hg7XMUcJoGe7JIMlA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m3nsnYfRdgPtMm1qzhrUunbuV0ynxfNHhhWM9WqoV8CX4fOVPk/JSlWcdhA4qT121RUJJiMuKtrCwkxG+bPNWdM1xiOEOcyRoWWzpYijZmWj6Ge/Ilm8XXwS6yF+35DPd6SLr6F5J9RrpputdBeYuq31SoY9YPwV8YuP7QFbz8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cNjWNJSC; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cNjWNJSC"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2bf1cda2b17so30294965ad.1
        for <linux-iio@vger.kernel.org>; Tue, 16 Jun 2026 00:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781594612; x=1782199412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hiB8ZKOuMKxX3kyJ04QolbI5ccLZMh8Rj/LKE5k032k=;
        b=cNjWNJSCCjzDt2UevGYpYn2WAp5meFHZb5lpO9n+rpFrlsgjJ4mH1SqzUq8myaVhQc
         hExgpnjn+YLfsUgzO6M0SVI2VFOxs4iWjBY5gmTWErRVXg4ILBRvxJxb5tvEcBB/2ovE
         +bZKE5uZ91GmoidyF86Jd2azWMdke0zzSMEaL9L7CnP0YZsUPLvfkYGALLLEi0xYwwV3
         JBsVVe6unRFFkFGatfhcnl+/cLAX3JnPEIcVktHuNuN8P5jxa7od47UV5oPFT8b1+6kM
         3odspl6wLS6xESzF4s+xbX1+fuqbu6TF+W3zL4AWYX/C8rkRPtBYE7zEsOE5J5tmePRp
         eChA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781594612; x=1782199412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hiB8ZKOuMKxX3kyJ04QolbI5ccLZMh8Rj/LKE5k032k=;
        b=SVjqKJDCtqW3/iIkUsRvXfZodrWnAnqwXnLoBi9/ZWRzcmJBhS725Rl4WlVY1v3r9t
         vcfkGX38RL3sCMvWSwnwErFLXvifMnkNPQ3eelxcS2wayibVcN5XjAvz6NTtPpu2IrJx
         EJZ+UjWVMyWtOZceehdx+1bbdq+Szw9cLJomUcIbTBl75tJXiXYrNZNlK3srcsxKsfrm
         WwDQS0gaV+TXdaA370TVFhG9piGB5GIwYRV7oPupZezWBXOEgtLfyMK7s0vbsF1A/w3p
         kt6LxpqaHM2dqohb32yW16DeZjxFo+2yzM1jjBHuKlTSBfEOWVqgCPliAisWWV8ENjzg
         jCzA==
X-Forwarded-Encrypted: i=1; AFNElJ8nDW26Hb0rpJPeT4fmHyeZZdMJBaEDy5anzegyGqAdR24Lk8r/OJg72YtEcybtckSBrN1kckj/PFk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk39boQxHVXTUvZSynDZyhCIX1g6TUi4c4anmM8zOYSvrtGwb6
	ziryAT6b+XotembFHDP77JxylMbmJtHsBcm3Jo138qkxLKJROWT198id
X-Gm-Gg: Acq92OGcxqevEdTMK9dp50TjOB5KMZGY/JTAItOv+mP45vgUZNsmiYDZxzayS4bEGaS
	GT70/OS1br7IZgiAERiWGsh1ISoCn+ncIPNOkWuC8DFz7nznhQPGJHoG8vGr8A4A9LK2WL5TB4e
	SpO0gPW+Hqoub90GP2IfMfxZoWSdNhMZe9sRlR06hNCqGr7Zr252NayjXInOjkJU4ex8dJssKFf
	hT5ZNqYgR4HsyAE3ShRJaKEu+lnY7+HW9mzCWlUr84jTubGLI5w7eH3rorW6noiiaEe6RVyNiUp
	9yjchzghT1GYp1goRgR0MxiXtltZfr2QYfDu/7JQcm2FwQ4QWGcB1RH42+7WeqvV8GjaLMI2obM
	oJplQfWzjdan4LIZmJ1gNHipfqrnT1+HvnpZq3E9PhH7NiOn2qquHWtr5Drjwr6HTFOuws4L0ec
	NuT4c201YkEUgWYSnMUXPsNQ8J9baa+ZX2jJsIq0oCALimCY8sUC1ih7loc5eIA3oabodvAKcIT
	1YcetC/czM061k/C1vKOiLO+oZwSgZyvgCXBn4=
X-Received: by 2002:a17:902:c411:b0:2c0:fa52:1c47 with SMTP id d9443c01a7336-2c699b8bdcbmr21957955ad.25.1781594612116;
        Tue, 16 Jun 2026 00:23:32 -0700 (PDT)
Received: from DESKTOP-G3E0OSP.localdomain ([112.172.255.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c42f1f1014sm123513435ad.16.2026.06.16.00.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 00:23:31 -0700 (PDT)
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
Subject: [PATCH RFC v5 5/6] iio: osf: add UART transport
Date: Tue, 16 Jun 2026 16:22:41 +0900
Message-ID: <20260616072242.3942-6-kimjinseob88@gmail.com>
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

Add the serdev UART transport and the initial OSF core receive path.

Enable the required vcc regulator with devm_regulator_get_enable()
before opening the UART, keeping power handling limited to the simple
probe-time requirement for this RFC.

Signed-off-by: Jinseob Kim <kimjinseob88@gmail.com>
---
 drivers/iio/Kconfig                       |   1 +
 drivers/iio/Makefile                      |   1 +
 drivers/iio/opensensorfusion/Kconfig      |  15 +++
 drivers/iio/opensensorfusion/Makefile     |   5 +
 drivers/iio/opensensorfusion/osf_core.c   |  99 ++++++++++++++++++
 drivers/iio/opensensorfusion/osf_core.h   |  18 ++++
 drivers/iio/opensensorfusion/osf_serdev.c | 117 ++++++++++++++++++++++
 7 files changed, 256 insertions(+)
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
index 000000000..d393eb3aa
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
+	  The driver receives OSF protocol frames over a serdev UART.
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
index 000000000..137fb7166
--- /dev/null
+++ b/drivers/iio/opensensorfusion/osf_core.c
@@ -0,0 +1,99 @@
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
+
+	return osf_protocol_decode_device_status(frame, &status);
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
index 000000000..624cb01fe
--- /dev/null
+++ b/drivers/iio/opensensorfusion/osf_serdev.c
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/of.h>
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
+	ret = devm_regulator_get_enable(&serdev->dev, "vcc");
+	if (ret)
+		return dev_err_probe(&serdev->dev, ret,
+				     "failed to enable vcc regulator\n");
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
+
+module_serdev_device_driver(osf_serdev_driver);
+
+MODULE_DESCRIPTION("Open Sensor Fusion IIO driver");
+MODULE_LICENSE("GPL");
-- 
2.43.0

