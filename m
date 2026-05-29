Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45B03DEFF7
	for <linux-iio@vger.kernel.org>; Fri, 29 May 2026 12:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780056661; cv=none; b=JXzwzEXp7/44nLvF32AEuApRdgVfhcmcBwN89FXCtXUU2Q4mOD6vT5VBgS5iF2HogeZsCP282zs7BkJ9iz2lwV6E/WCiOmUqoe2G0lU+raLifbehrnP4y6vsVBGxsFu/bLBTVKOzM1NP90Wk15339OhhH8FqkGL6I9Gb8QJFOAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780056661; c=relaxed/simple;
	bh=lNFULvOPvgrVMAHRIjbWwPfBe9IXIwaIEdD34oSFTD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qs8szyP2ZYHgSE1nAzIm0sG27Ycbj+PvZpba+7Y5rrPTlVVo6xHRYnl8wjSKAlnbyucumMuUq1DRpFKX3+p9RyEgEKe2gcllyGbLp2tbuq3do71+/41/tH+DQVTdHPEG6WltXFZhIG8DPj8CsrPuq85WXSn2n3NMx666qKq/9Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mVIq2xg2; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mVIq2xg2"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-36b95eb4bb4so770718a91.3
        for <linux-iio@vger.kernel.org>; Fri, 29 May 2026 05:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780056657; x=1780661457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OnVtfOUvffQvhhS/iftC/tK4tOsTF8ZY+RX/0peU1Yg=;
        b=mVIq2xg2mZ2CL6zgLOOTz481zX+XnEPRiZjg15ile2ePtGvS2MxI0e1DssBc3a7nSf
         nbPcDiIXiRyrUuZFj7edhPwmhA/1+ayR2iTb+aoyarS286Tvj/gYw5fHQjxtuFxkSYhx
         wXd0KHLta30X5dlVCpLB4NFaRcZmMugLz/A5QZj3nN01NaDd04Wu/WB8UqhwzSl+RW1K
         oBubaCXWNyi3p/V/SDleGMAU4CB5ZsPFym8vHQ8qkb5M76K8CZakqTWQHi5bgTIXpXS4
         iFKfR0hXHy6h6D8hdqD64RXqJudGbuDSwI/6AX3K9pOKO5MCBNAQSGzXxFzJiTZx1/gJ
         +luw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780056657; x=1780661457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OnVtfOUvffQvhhS/iftC/tK4tOsTF8ZY+RX/0peU1Yg=;
        b=tVUcqSV1i9nR02XqCKm535HEFDmvaFZ8qm0M6JDAF0sbDEQMVn1Z0sFISEh9H2ac43
         hCcjKGUMkTkxWA1/qUMrIyXan/UZK5NiODmstG/8pxAdX4+u0jEdPlvNuSw4SvKG1cNb
         4IPg38ouBDShl1YtINq4GFz24fbPa4HTuTXbKAAMlhQOhdo0hky8OGT/x7RnMyGh7r0t
         xcmKPW7CvvkXmb9R/pyPnQMAVB7NDzz3fauHBZ9uokr+VPXXbGyHblzK6F2vGvruUuji
         ODPR0o/E60eVbeD7AAiawAYQ1VMAuJI3J2hiAr22pBBke73MRIp3tJSo4W/MEuI+1PJQ
         K33Q==
X-Forwarded-Encrypted: i=1; AFNElJ8/fRJ+3bdn2wEvp6+z3IjdUM1QqOdFQk69B83vxNaVVInuccoPqxaSKG60CRGYQXMpfnaD6diK+4A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMDMBcWiseGIPYRRi54ewKJAPuFRNgpvNlUKsoq4rGJfonSq4F
	LQcMa9651tElflM+NRV/Ey9sn6mFE2rpFGGFLUdpgtLr/Yo64pZge00+
X-Gm-Gg: Acq92OH5qNsXmFj2PPWG4RBWlP/L/9XNv+l6BZdaHlAVXm9F1xvX5jOzS+MtCHIc8fZ
	d11DL1eMWJX8uLNY2nlIwaJv5VTA1NzONB9+NGm3O/zvpC86VpajwpzL1cVYzS3reIR3/y3sOmv
	7B48DIsIg7ahcVtZtd/bY7QTPrVU/J6C2myIRae2e6OCvY0px7qKicXzy+3YfCNELVFdZYAWrMc
	sX26dKfePQSiQSDNBhWTTJEtgWWNhZqAGJOvD5Xzv7DP734OljkyiqDi4zXEUeSf36TrzdP5is7
	PqcjQvLHNr3F9WQtfUt75MtYEtHWfUuEoJS5+I2R1PsrqL2Jomo6e4aTyxqt5HMTNd1VujJ5uDB
	vsJ0tY1TEVRy0m6a2tdCbBCx3X7x6/+VFQqE8shAdz8ECgN+vWEh45JxEAl2UsCgUj52UCjBElN
	o2sh5IHQtx5bBopMcv1wd1PNKYNrkxccmPYyYjtkooPtrPxY6Ook7QIdIkYASmmPRDQFx8Rni6B
	E6zQGUzpRnReDRQpuCTMFJov2OGYTj+WBloscee2v7gSZSE2ji02xRpyTY=
X-Received: by 2002:a17:90b:3d50:b0:368:1064:62f7 with SMTP id 98e67ed59e1d1-36bbcc14a21mr3334283a91.6.1780056657109;
        Fri, 29 May 2026 05:10:57 -0700 (PDT)
Received: from DESKTOP-G3E0OSP.localdomain ([112.172.255.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36bbdf3afc6sm942820a91.7.2026.05.29.05.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 05:10:56 -0700 (PDT)
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
Subject: [PATCH RFC v3 3/6] iio: osf: add protocol v0 decoding
Date: Fri, 29 May 2026 21:10:02 +0900
Message-ID: <20260529121005.1470-4-kimjinseob88@gmail.com>
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

Add OSF0 frame validation and payload decoders.

Extend MAINTAINERS to cover the protocol decoder.

Signed-off-by: Jinseob Kim <kimjinseob88@gmail.com>
---
 MAINTAINERS                                 |   1 +
 drivers/iio/opensensorfusion/osf_protocol.c | 247 ++++++++++++++++++++
 drivers/iio/opensensorfusion/osf_protocol.h |  95 ++++++++
 3 files changed, 343 insertions(+)
 create mode 100644 drivers/iio/opensensorfusion/osf_protocol.c
 create mode 100644 drivers/iio/opensensorfusion/osf_protocol.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 6ccaaa738..9fab72689 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19982,6 +19982,7 @@ M:	Jinseob Kim <kimjinseob88@gmail.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/iio/imu/opensensorfusion,osf-green.yaml
 F:	Documentation/iio/open-sensor-fusion-protocol-v0.rst
+F:	drivers/iio/opensensorfusion/osf_protocol.*
 
 OPEN FIRMWARE AND FLATTENED DEVICE TREE
 M:	Rob Herring <robh@kernel.org>
diff --git a/drivers/iio/opensensorfusion/osf_protocol.c b/drivers/iio/opensensorfusion/osf_protocol.c
new file mode 100644
index 000000000..ed91d3dd5
--- /dev/null
+++ b/drivers/iio/opensensorfusion/osf_protocol.c
@@ -0,0 +1,247 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/bits.h>
+#include <linux/crc32.h>
+#include <linux/errno.h>
+#include <linux/limits.h>
+#include <linux/types.h>
+#include <linux/unaligned.h>
+
+#include "osf_protocol.h"
+
+#define OSF_CRC32_INIT		GENMASK(31, 0)
+#define OSF_CRC32_XOROUT	GENMASK(31, 0)
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
+	if (get_unaligned_le16(buf + 6) != OSF_FRAME_HEADER_LEN)
+		return -EPROTO;
+
+	payload_len = get_unaligned_le32(buf + 10);
+	if (payload_len > len - OSF_FRAME_MIN_LEN)
+		return -EMSGSIZE;
+
+	if (get_unaligned_le32(buf + 34))
+		return -EPROTO;
+
+	total_len = OSF_FRAME_HEADER_LEN + payload_len + OSF_FRAME_CRC_LEN;
+	expected_crc = osf_crc32_ieee(buf, OSF_FRAME_HEADER_LEN + payload_len);
+	actual_crc = get_unaligned_le32(buf + OSF_FRAME_HEADER_LEN + payload_len);
+
+	if (actual_crc != expected_crc)
+		return -EBADMSG;
+
+	frame->protocol_minor = buf[5];
+	frame->message_type = get_unaligned_le16(buf + 8);
+	frame->payload_len = payload_len;
+	frame->sequence = get_unaligned_le64(buf + 14);
+	frame->timestamp_us = get_unaligned_le64(buf + 22);
+	frame->flags = get_unaligned_le32(buf + 30);
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
+	u16 sensor_type;
+	size_t expected_len;
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
+	sensor_type = get_unaligned_le16(payload);
+	channel_count = get_unaligned_le16(payload + 4);
+	sample_format = get_unaligned_le16(payload + 6);
+
+	if (!osf_sensor_type_valid(sensor_type))
+		return -EPROTO;
+
+	if (!channel_count)
+		return -EPROTO;
+
+	if (sample_format != OSF_SAMPLE_FORMAT_S32)
+		return -EPROTO;
+
+	if (get_unaligned_le32(payload + 12))
+		return -EPROTO;
+
+	if (channel_count > (SIZE_MAX - OSF_SENSOR_SAMPLE_BASE_LEN) / sizeof(s32))
+		return -EOVERFLOW;
+
+	expected_len = OSF_SENSOR_SAMPLE_BASE_LEN + channel_count * sizeof(s32);
+	if (frame->payload_len != expected_len)
+		return -EMSGSIZE;
+
+	sample->sensor_type = sensor_type;
+	sample->sensor_index = get_unaligned_le16(payload + 2);
+	sample->channel_count = channel_count;
+	sample->sample_format = sample_format;
+	sample->scale_nano = get_unaligned_le32(payload + 8);
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
+	*value = (s32)get_unaligned_le32(sample->samples + index * sizeof(s32));
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
+	if (get_unaligned_le32(payload + 16))
+		return -EPROTO;
+
+	status->uptime_s = get_unaligned_le32(payload);
+	status->status_flags = get_unaligned_le32(payload + 4);
+	status->error_flags = get_unaligned_le32(payload + 8);
+	status->dropped_frames = get_unaligned_le32(payload + 12);
+
+	return 0;
+}
+
+int osf_protocol_decode_capability_report(const struct osf_frame *frame,
+					  struct osf_capability_report *report)
+{
+	u16 capability_count;
+	size_t expected_len;
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
+	capability_count = get_unaligned_le16(payload);
+
+	if (get_unaligned_le16(payload + 2))
+		return -EPROTO;
+
+	if (capability_count > (SIZE_MAX - OSF_CAP_REPORT_BASE_LEN) /
+	    OSF_CAP_SENSOR_ENTRY_LEN)
+		return -EOVERFLOW;
+
+	expected_len = OSF_CAP_REPORT_BASE_LEN +
+		       capability_count * OSF_CAP_SENSOR_ENTRY_LEN;
+	if (frame->payload_len != expected_len)
+		return -EMSGSIZE;
+
+	report->capability_count = capability_count;
+	report->entries = payload + OSF_CAP_REPORT_BASE_LEN;
+
+	return 0;
+}
+
+int osf_protocol_decode_capability_entry(const struct osf_capability_report *report,
+					 unsigned int index,
+					 struct osf_capability_entry *entry)
+{
+	u16 sample_format;
+	u16 sensor_type;
+	u32 flags;
+	const u8 *payload;
+
+	if (!report || !report->entries || !entry)
+		return -EINVAL;
+
+	if (index >= report->capability_count)
+		return -ERANGE;
+
+	payload = report->entries + index * OSF_CAP_SENSOR_ENTRY_LEN;
+	sensor_type = get_unaligned_le16(payload);
+	sample_format = get_unaligned_le16(payload + 6);
+	flags = get_unaligned_le32(payload + 12);
+
+	if (!osf_sensor_type_valid(sensor_type))
+		return -EPROTO;
+
+	if (sample_format != OSF_SAMPLE_FORMAT_S32)
+		return -EPROTO;
+
+	if (flags & ~OSF_CAPABILITY_FLAGS_MASK)
+		return -EPROTO;
+
+	if (get_unaligned_le32(payload + 16))
+		return -EPROTO;
+
+	entry->sensor_type = sensor_type;
+	entry->sensor_index = get_unaligned_le16(payload + 2);
+	entry->channel_count = get_unaligned_le16(payload + 4);
+	entry->sample_format = sample_format;
+	entry->scale_nano = get_unaligned_le32(payload + 8);
+	entry->flags = flags;
+
+	return 0;
+}
diff --git a/drivers/iio/opensensorfusion/osf_protocol.h b/drivers/iio/opensensorfusion/osf_protocol.h
new file mode 100644
index 000000000..4b6fb131a
--- /dev/null
+++ b/drivers/iio/opensensorfusion/osf_protocol.h
@@ -0,0 +1,95 @@
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
+	const u8 *samples;
+};
+
+struct osf_device_status {
+	u32 uptime_s;
+	u32 status_flags;
+	u32 error_flags;
+	u32 dropped_frames;
+};
+
+struct osf_capability_report {
+	u16 capability_count;
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
-- 
2.43.0

