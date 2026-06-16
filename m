Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CCB397E92
	for <linux-iio@vger.kernel.org>; Tue, 16 Jun 2026 07:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781594606; cv=none; b=SWCD+usNZSyyLSRqLrgV+YxmdzHLZKW4w6ViMCaH8v94/Eln5m8xT3shE5lO3tWPHGn0ed8hijk0i4qWF9RYGh0rBT+LqM2nFc9YRuNWe1YnR/r4q2xeMf/ZjGbzbhcWrAGwi6syn9RenhJ/k27Tx4ezGd86p1jBsc0kKx80HaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781594606; c=relaxed/simple;
	bh=hBYZvXYUxDj1NDEjxlusa42W3QL0r+XRo/UKd6jJZFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hpx2RvwL5vMPizJYLmbxq/mnIeK2cnQPrG2wE11SyE1REt+kckO1Uo2TWjYGyeWrnKMQnbKe0VZ2pn74jHIaokjvl/xrZvQAbk8UCHhAWAVs71p/zBMyEZILhmAY5YcX1Cyv082o2lDE8/fobpf6HU8JTkawBnveZEARW03wjHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T4zw125m; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T4zw125m"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2c0c32f6ce1so28822425ad.2
        for <linux-iio@vger.kernel.org>; Tue, 16 Jun 2026 00:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781594604; x=1782199404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+FlVGvRg4oyYENJ+PxSIijzssKGVL/rwEXrhhfYCiGY=;
        b=T4zw125mCSh5FbkpzpFQFn69GMsqv8R6z0SmKs29QeKAcckCT0EsuhBtcGqAd4fjeG
         ILf4JJLrxTQdwm9e5/pVj0cIbh3ewrkICSudCaT/ws3mOo/5tDSjFghPty7W7fD3Zf7a
         0271GRQxQ7Q8R+v/mmph51u65BT1NMl7BOhqZfa0/75mxgYjxH9eu6c/+bYpUQbAmsp1
         dDWC8+xbJMphAZzxkGffyf7KjOzUwVsOuAPZPfOcFTdtUbKR6BMxpSGvHQOlbqiCbWaS
         +I4CzeMZEUZNy30ecKcwfRvSaUtFfBqyOfwvjiZOLrLxaA9I8ELVeMJ99s/jRhzAh7Y3
         dbfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781594604; x=1782199404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+FlVGvRg4oyYENJ+PxSIijzssKGVL/rwEXrhhfYCiGY=;
        b=BQRGQibs2SoPsfDm02890eSskVJgn8k/IhxhTSBHYydge/LTe7lEDjW4nTk3TSWPpT
         37b/Oq72HcqNpIux3a0BWCpAQsAKzi7y7rZFH+KOEL9G/KJapvPmlzhVIlaB3YwWV5im
         aM27qWlEzDuFQi+eb21wdjH/FgK88mDEtu2/fTQiNR2dluVXvRVBBGwsylmNAutymjyg
         Dm2+++vnnu9LbF07rrOCx49wXMHmONLbR1RQNb01ep8CUbRptbPFRhbEUeUV0lsMLYDZ
         zIpyiaZMd06xbHZivjejxutm23GBsjcAKe4HTeIlrmmnLLlTWrcl6uXLdZ/0ZglWaxAa
         OFzw==
X-Forwarded-Encrypted: i=1; AFNElJ8BjbKcCG3XEzdnx7fsHUGGFORYusVpRUTXcp845Je9Bvl4DQ01oCly6sdW9WC6FK4wHp5gy8uA8tA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzByvWJL22tLEnXor2A4X7XZzjog/oD/Rdc5pPs+s4vCDCWreJd
	bJOi87vnAdEcaLr/139IcRIoZrTwZz3fgTkBX3mb9OOTg2mqDiXZYz6n
X-Gm-Gg: Acq92OFBVstT4Rlr9F/mg+zL3eqBFF4JlgkR/FqMB7hHaMyer/B8+/lz2TqJRbV3bQ1
	v8P/MMEIp5PLolUEU1xXBW+zJa92bFqS/y3D43fNLl91eMK4MDGeJm2xEnjBxtFfH4jx1CY5XTc
	tj1uuw6LzK4Q/+x5iRJi1av2sbS/1MnrgK79wfgGX7FKP0pbs9f9eRLkkJuXoIo3vp0N80d/dkC
	ruhnTyLT9szANMKgJdwePy9n9KHO8p9yk/sGbUsuTBESEhzX9Yms566upXcrhyqO/UvSdHBLXP2
	dbEtzbRR4w2zgAQCgO9OxY7FtD6E8FT4D3coee5hNTljr6KozSj08rCRIbPda20FUDZkdwtYEtW
	85nxi+tX0KmPgLknqB5XnPYrsUJ8zw2CtjIIyfzzrEJqxbcjT24UCu6zNk71OFqNTKSSmoG8eHs
	qATczhi+t2KpTaKpe7QayC5TYHWpu1u99JYOzTbnw8UZddlXnZH3givBaxwmH8pu/5npQ7EigaD
	ngiXimK9Qy1Dg4/tjVjhfEUOVhe4dpwfev6by0=
X-Received: by 2002:a17:902:f543:b0:2be:3850:297e with SMTP id d9443c01a7336-2c664216d17mr148855815ad.31.1781594604238;
        Tue, 16 Jun 2026 00:23:24 -0700 (PDT)
Received: from DESKTOP-G3E0OSP.localdomain ([112.172.255.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c42f1f1014sm123513435ad.16.2026.06.16.00.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 00:23:23 -0700 (PDT)
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
Subject: [PATCH RFC v5 3/6] iio: osf: add protocol decoding
Date: Tue, 16 Jun 2026 16:22:39 +0900
Message-ID: <20260616072242.3942-4-kimjinseob88@gmail.com>
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

Add helpers for validating and decoding Open Sensor Fusion frames and the
message payloads used by the initial receive path.

Signed-off-by: Jinseob Kim <kimjinseob88@gmail.com>
---
 drivers/iio/opensensorfusion/osf_protocol.c | 249 ++++++++++++++++++++
 drivers/iio/opensensorfusion/osf_protocol.h |  97 ++++++++
 2 files changed, 346 insertions(+)
 create mode 100644 drivers/iio/opensensorfusion/osf_protocol.c
 create mode 100644 drivers/iio/opensensorfusion/osf_protocol.h

diff --git a/drivers/iio/opensensorfusion/osf_protocol.c b/drivers/iio/opensensorfusion/osf_protocol.c
new file mode 100644
index 000000000..5bee545f3
--- /dev/null
+++ b/drivers/iio/opensensorfusion/osf_protocol.c
@@ -0,0 +1,249 @@
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
+#define OSF_FRAME_MAGIC		0x3046534f /* "OSF0" little-endian */
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
+	if (get_unaligned_le32(buf) != OSF_FRAME_MAGIC)
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
+	/* Samples are little-endian two's-complement signed values. */
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
index 000000000..c62c2c254
--- /dev/null
+++ b/drivers/iio/opensensorfusion/osf_protocol.h
@@ -0,0 +1,97 @@
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
+	u8 protocol_minor;
+	u16 message_type;
+	u32 payload_len;
+	u64 sequence;
+	u64 timestamp_us;
+	u32 flags;
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

