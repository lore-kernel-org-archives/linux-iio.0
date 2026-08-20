Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8473938AC97
	for <linux-iio@vger.kernel.org>; Thu, 20 Aug 2026 05:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787202417; cv=none; b=Sft7Whpzl25Iic0yrdgRvoyBw9phT5LSTTU1cXEj1WEAo5+BcbUfTgSgY8ZKC6zsLpF60Qa2uyah5J/UKMyyYl6efQ0qceQnFfH492F2gIxdIGZ99i53DId4HF1kI/V4MeYtU8/PY/N9rXfSznNNvyui+K0N+yFW4r9bU48TEss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787202417; c=relaxed/simple;
	bh=PHnj/dfT6vEy4oPbOkjS+nst7WLFJOcvRlYae8WjvZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p7zNorFSkOJCDXQ4SGER9vLJhJYLOt4ZUUHI8EhOhmtK4FtoDwZavzBsFiNt20gbnmUpWfXL8wuuDmuCA9/kZ8K5G/c1xzEWb/gV+6ORwdpNreSUR+yqLs5SQzMJzIBGbkz23M8//cT41vEqHAJETKwGr8bTg3rLq8tLbImqp7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sTzaZd42; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sTzaZd42"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cab973140bso21887205ad.3
        for <linux-iio@vger.kernel.org>; Wed, 19 Aug 2026 22:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787202415; x=1787807215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RcY7gPI3vZpcX4ZcLMMx/Xe0zOqUh85eG6l6jt/xSzc=;
        b=sTzaZd427UYWI89l3o5IG27KEr+zTAXbJ+EKWlSq48b0z1NwC/LNDBdLr1M68Zf1i+
         s3tgrJBt5XkctLvwZiRbYNH+8WxSh6mkYEDgo7DhAzXckShokT3A2g5lNbl89tFpTBKW
         kncKWpVNFbJdlRMBjyeN6RqOU3uKwRi2nQwMvJY8OxvROMtlAfVeTi9jsojzbaeBnRV3
         cFDnp563mTyvou2Mij8HJJXRYoff7rGRtdkCCZj6BRMKxIfs3qQh1lnCFL4JgL6gc8D3
         T6wcp9EXpudTCIwdqqbwedABEAeOcQNkWcu1XuTOfNUaYS9oGggpSCnrQQzzPelpyAMP
         KPiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787202415; x=1787807215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RcY7gPI3vZpcX4ZcLMMx/Xe0zOqUh85eG6l6jt/xSzc=;
        b=ISiMfqBJ9tjtTKoPbrwFx3QGjYNVqcVdM75PTRqEex83xO0A4n5fofXanrs8OEGa5w
         BdkvvTF9l9TNBNQu571aC2wlPNa4IbOv53ZKtN2U4YsT2G36CKtA2DkDCgdVBMmWuIpk
         yz04OeL8hooH7wqLT86dogQYW4dWG7JBJCaueZC9nrv6Dk8hERA3ZAJUFrcDZqcQo1V0
         5wMc7he7WAl188TUmC7qL/kXMU/dhCJwnGouGfG7aslzTCqZtHUnV1QDcfdIdiWJK5Xi
         kT1fjJ7/f6cKtqlIbyFgBH9H79gH8LhQp4fWO4NK7/31FGIOKtTJdXL7cx1PIjzZMXx/
         wakA==
X-Forwarded-Encrypted: i=1; AHgh+RoH6deuj2jrsuZFTTecx7PiA2qWlWcQZo0Yp/H+jhPg7gCVr9ytVdxrpcCW+rrSanKwmFGNcb7z8Z0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlrS3WlZtHiC2XJJLF6oCIpM2PA/TvdyhyZRpLppSPoOubxItM
	zX6rutHZxK23X3n1jmRqLU5/l2a0FsaVzoVFicyuYhh2WBrAX3APAC79
X-Gm-Gg: AR+sD11jTukb4uV2S7UI91PEnswfrsEPBcai4xcKwUcAirbxwstnw1AirqYy8oSDxku
	wGMv+HtePHxCJuGpY3+X/54/kxybT0TBjH8Y4sIaAFDRa+dbptH23XAtZHNNNU1kNJgL0XYRV/r
	l7/k0S7nQ6sB7GvsdWE78xrMLgQ38tK6Q8kfM1uADk34dMCcmi39Yj004F6l63/cHZvz5RrT0Ia
	BMXtgycM2FdFGMnmBQHzps4E8mRqQq6+csZ98mG4KS6ghSJ4KFD7W4WNFDv44nyUzUJNxLmJThh
	78Ja+xLhiVRf9CUj923hpdHmDo2G7FY8RZmDjHzM0dHLf0AWdZJCq/WNRWwzf8N1uiwAmR4k0Ln
	mZpBBg7dnubMJNI1XaRXDEJv5d9d724HW6cTBksETN7UIIz5KABO7jrzodhbJo+06f1pe+YP/rp
	u32MZA8QeExL6CzFufQ9piQvy6AbVn9DKO9WFWsT8K6CFG4fyjCVIj5v/zfQtWH5TYMkqIrOrcA
	prpGff/0eduA+/SLuJLSRuxCbZvbgaBnjpTE4ZNWlzEZ5nIHtBqcCJTTCMyaEdffjG9ga8IAvtq
X-Received: by 2002:a17:902:ebc7:b0:2ca:e565:7b15 with SMTP id d9443c01a7336-2d5fd73d03dmr180793855ad.10.1787202414654;
        Wed, 19 Aug 2026 22:06:54 -0700 (PDT)
Received: from DESKTOP-G3E0OSP.localdomain ([112.172.255.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d62d58a82dsm2040685ad.18.2026.08.19.22.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 22:06:53 -0700 (PDT)
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
Subject: [PATCH v8 3/5] iio: osf: add protocol decoding
Date: Thu, 20 Aug 2026 14:06:06 +0900
Message-ID: <20260820050608.5440-4-kimjinseob88@gmail.com>
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

Add helpers for decoding Open Sensor Fusion frame headers and supported
message payloads.

The decoder validates framing, payload bounds and CRC before exposing
decoded frame contents to the rest of the driver. Framing validation
includes the OSF0 wire magic and fixed header length. Protocol version
and reserved header fields are exposed to the core so authenticated-frame
policy is handled after CRC validation.

Capability entries are decoded structurally, including their flags and
reserved fields. The core can then apply support policy without rejecting
an entire report solely because it contains future entry values.

Use explicit little-endian wire storage sizes and designated
initializers for decoded output structures.

Signed-off-by: Jinseob Kim <kimjinseob88@gmail.com>
---
 MAINTAINERS                                 |   1 +
 drivers/iio/opensensorfusion/osf_protocol.c | 224 ++++++++++++++++++++
 drivers/iio/opensensorfusion/osf_protocol.h | 101 +++++++++
 3 files changed, 326 insertions(+)
 create mode 100644 drivers/iio/opensensorfusion/osf_protocol.c
 create mode 100644 drivers/iio/opensensorfusion/osf_protocol.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 9550cf1900bd..76fa860a7b91 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20298,6 +20298,7 @@ M:	Jinseob Kim <kimjinseob88@gmail.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/iio/opensensorfusion,osf.yaml
 F:	Documentation/iio/open-sensor-fusion.rst
+F:	drivers/iio/opensensorfusion/osf_protocol.*
 K:	opensensorfusion
 
 OPENCOMPUTE PTP CLOCK DRIVER
diff --git a/drivers/iio/opensensorfusion/osf_protocol.c b/drivers/iio/opensensorfusion/osf_protocol.c
new file mode 100644
index 000000000000..cd7b8587f737
--- /dev/null
+++ b/drivers/iio/opensensorfusion/osf_protocol.c
@@ -0,0 +1,224 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/bits.h>
+#include <linux/crc32.h>
+#include <linux/errno.h>
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
+
+	if (!buf || !frame || !frame_len)
+		return -EINVAL;
+
+	if (len < OSF_FRAME_MIN_LEN)
+		return -EMSGSIZE;
+
+	if (get_unaligned_le32(buf) != OSF_FRAME_MAGIC)
+		return -EPROTO;
+
+	if (get_unaligned_le16(buf + 6) != OSF_FRAME_HEADER_LEN)
+		return -EPROTO;
+
+	payload_len = get_unaligned_le32(buf + 10);
+	if (payload_len > len - OSF_FRAME_MIN_LEN)
+		return -EMSGSIZE;
+
+	total_len = OSF_FRAME_HEADER_LEN + payload_len + OSF_FRAME_CRC_LEN;
+	expected_crc = osf_crc32_ieee(buf, OSF_FRAME_HEADER_LEN + payload_len);
+	actual_crc = get_unaligned_le32(buf + OSF_FRAME_HEADER_LEN + payload_len);
+
+	if (actual_crc != expected_crc)
+		return -EBADMSG;
+
+	frame->protocol_major = buf[4];
+	frame->protocol_minor = buf[5];
+	frame->message_type = get_unaligned_le16(buf + 8);
+	frame->payload_len = payload_len;
+	frame->sequence = get_unaligned_le64(buf + 14);
+	frame->timestamp_us = get_unaligned_le64(buf + 22);
+	frame->flags = get_unaligned_le32(buf + 30);
+	frame->reserved = get_unaligned_le32(buf + 34);
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
+	expected_len = OSF_SENSOR_SAMPLE_BASE_LEN + channel_count * sizeof(__le32);
+	if (frame->payload_len != expected_len)
+		return -EMSGSIZE;
+
+	*sample = (struct osf_sensor_sample) {
+		.sensor_type = sensor_type,
+		.sensor_index = get_unaligned_le16(payload + 2),
+		.channel_count = channel_count,
+		.sample_format = sample_format,
+		.scale_nano = get_unaligned_le32(payload + 8),
+		.samples = payload + OSF_SENSOR_SAMPLE_BASE_LEN,
+	};
+
+	return 0;
+}
+
+int osf_protocol_sensor_sample_value(const struct osf_sensor_sample *sample,
+				     u16 index, s32 *value)
+{
+	if (!sample || !sample->samples || !value)
+		return -EINVAL;
+
+	if (index >= sample->channel_count)
+		return -ERANGE;
+
+	/* Samples are little-endian two's-complement signed values. */
+	*value = get_unaligned_le32(sample->samples + index * sizeof(__le32));
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
+	*status = (struct osf_device_status) {
+		.uptime_s = get_unaligned_le32(payload),
+		.status_flags = get_unaligned_le32(payload + 4),
+		.error_flags = get_unaligned_le32(payload + 8),
+		.dropped_frames = get_unaligned_le32(payload + 12),
+	};
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
+	expected_len = OSF_CAP_REPORT_BASE_LEN +
+		       capability_count * OSF_CAP_SENSOR_ENTRY_LEN;
+	if (frame->payload_len != expected_len)
+		return -EMSGSIZE;
+
+	*report = (struct osf_capability_report) {
+		.capability_count = capability_count,
+		.entries = payload + OSF_CAP_REPORT_BASE_LEN,
+	};
+
+	return 0;
+}
+
+int osf_protocol_decode_capability_entry(const struct osf_capability_report
+					 *report, u16 index,
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
+	*entry = (struct osf_capability_entry) {
+		.sensor_type = get_unaligned_le16(payload),
+		.sensor_index = get_unaligned_le16(payload + 2),
+		.channel_count = get_unaligned_le16(payload + 4),
+		.sample_format = get_unaligned_le16(payload + 6),
+		.scale_nano = get_unaligned_le32(payload + 8),
+		.flags = get_unaligned_le32(payload + 12),
+		.reserved = get_unaligned_le32(payload + 16),
+	};
+
+	return 0;
+}
diff --git a/drivers/iio/opensensorfusion/osf_protocol.h b/drivers/iio/opensensorfusion/osf_protocol.h
new file mode 100644
index 000000000000..2b616f2d5197
--- /dev/null
+++ b/drivers/iio/opensensorfusion/osf_protocol.h
@@ -0,0 +1,101 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _OSF_PROTOCOL_H
+#define _OSF_PROTOCOL_H
+
+#include <linux/bits.h>
+#include <linux/types.h>
+
+#define OSF_PROTOCOL_MAJOR		0
+#define OSF_PROTOCOL_MINOR		0
+#define OSF_FRAME_HEADER_LEN		38
+#define OSF_FRAME_CRC_LEN		4
+#define OSF_FRAME_MIN_LEN		(OSF_FRAME_HEADER_LEN + OSF_FRAME_CRC_LEN)
+#define OSF_FRAME_MAGIC			0x3046534f /* "OSF0", little-endian */
+
+#define OSF_SENSOR_SAMPLE_BASE_LEN	16
+#define OSF_DEVICE_STATUS_LEN		20
+#define OSF_CAP_REPORT_BASE_LEN		4
+#define OSF_CAP_SENSOR_ENTRY_LEN		20
+#define OSF_CAPABILITY_FLAGS_MASK	GENMASK(1, 0)
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
+	u8 protocol_major;
+	u8 protocol_minor;
+	u16 message_type;
+	u32 payload_len;
+	u64 sequence;
+	u64 timestamp_us;
+	u32 flags;
+	u32 reserved;
+	/* payload points into the caller-owned frame buffer. */
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
+int osf_protocol_decode_capability_entry(const struct osf_capability_report
+					 *report, u16 index,
+					 struct osf_capability_entry *entry);
+int osf_protocol_sensor_sample_value(const struct osf_sensor_sample *sample,
+				     u16 index, s32 *value);
+
+#endif
-- 
2.43.0

