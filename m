Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2466139022E
	for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 08:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779612832; cv=none; b=bs0J2MPoPVLG9lMdkVy5/4e8fz0k1qbA8jpM7MhV9KpgdNhusO/m+pxyQc5AD7u/KLinD29XVcMdITx7B+lB2QxDRg6MbtTht0svtrwygALD3GJu/Q4UxSjnbEPvB6jOS02w5sax5gI6mLuXfQ8ZKg3fdeJ2OouW+2LOjrC3F0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779612832; c=relaxed/simple;
	bh=ZCL6ezRfaQJ8MfsplAkjQLstX77U5p+nsINwl0rR2Zo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lOTpUJ45VLjIczeI5kAsfeVddvcaIDX+Vsj4C/LLNUd+rnmGsLSKq6FAv8R0jWz30D6ItIB6pgOCOgI/1AIFtlXAVY9v5k4Tk17ijdT6CQYVGPIAsGvFEqxd/U9tElbDAdXHQSgazKqwgcef5GVSXooScjdoVu317f3UUwgPRHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WuaqKoul; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WuaqKoul"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-83d31ac4017so4278502b3a.3
        for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 01:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779612829; x=1780217629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ymRZGCPEm3o47nC+8rZrU36hS8/8eEcKC15QEK7V6Do=;
        b=WuaqKoul7l731UTKxm3uJULxGHP3rIIBL+K8v4E94jihHHIyuTU7FgJ57FnDsrHaWx
         eeW3YPtcuZ3VpLvmQu5lnxOzhRRCyWdB37sf+6ILZJTHsTHtCsdFaceEyIxnSrvbV4at
         UXLZNfYae5Nus7jM0UuX8qtUePK2jALUwvR049R+jKfJpBpgUozwGdsCEhDitJuIxXoI
         61JVPenOUsfbq/yHPHyCBieJjSzRwCWdpKXfV0Is75al0mIugKdRBrfhCf2Pd9RCiyzV
         /17Pny8A0WIc6QgZmUYSxjUREis3s5+dZzeqekMN6q9IbFp3Y1tU6jRO3L/EPAcI6EyB
         OuOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779612829; x=1780217629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ymRZGCPEm3o47nC+8rZrU36hS8/8eEcKC15QEK7V6Do=;
        b=Z/7o/lfBpnFC2+EV7ob0M/aXAer0QauE+euW/30Qr+KLbPBVNjrTBfoPSrROKAZzlg
         uQDI0GPnwPxMJon/s9hJpriosNRMJTrW0YVPiTWIY2QoItql9SMDnDT4shYxC1573WIh
         9I7g/JpJ9yw4lArP5gOqRXRUAYZrQHLd8ONgz2NPch64ePd7n1qaXhJVJJxE+eUK/jnk
         xWRb4+d4HrnxwiB6EgouWAvNYQvORfuebnUDORlEuvdLPMRBIlbqHJFNknqyuI+yWbv1
         Ic6rki7mrgPKuXC50iLkWWS2PVnkKSuu3GIKIaYwN4QqY0UQwpwDUxKnz6PtG8JnzWU+
         a67A==
X-Forwarded-Encrypted: i=1; AFNElJ+5cDDxeCoWcHxmu9gsTsrZhH+3X1k0lW+s7iQHVPxIH7MgAx8MPg9FudkKjqDZ7QaMfoTtFyaQn3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPC6PCAsgjxO3elSJVsOMabgLP/Tc2UuSUUs9eHCE4AOo70Xsi
	oCFMvf3d0t2Vke/15MANTHmbOTyclNV80fGI8y/79krDVIhvyWNZ9Rxd
X-Gm-Gg: Acq92OFLl64+8NbVhf7QreVKV8mYfuQx57Uhxsb1PbS3H+geq2i7ZQi5O57d2GYGEYV
	8LjyuHen5CuscX0m17Qi0z55EyOrlTlh8zZMre6z0fZWQOegabwf2JS1dkTiGNkf7J3rwKWKfRf
	tH4qrkuF4sP/k354MfkuUavzLEA5L4LDhPGR7qWsXOAPon/UXSoT2Wnjll2eGHlSMESjjxvHL48
	rrZVyTxngfQ9qbZdgEYt8gFLgpgRObvJkfY8urN69xiSTy7dBv9GDVXtaUKQUCVm6Ui8KRcjehU
	vGGd/i51+YFYs2x/HVSTWcChAog5FUOKmBYQYaz1zU7hfo81ItSBcqaP1ALYxr5TpQa3phhyER9
	TBJkYPBuQYx8IOqayUP2j9c4m/RHNrplgf4EnGg4culgsege89HtpAFpYbm32QcoGX/kBCbqaEq
	R3g00ITPDTZnVZ+9rX/Cv+MnnqvYEJwha6T2JLTv9HvMHKoLvFLklZ6ptKi/IhILLLH35iLFA6N
	inUoYUyz0n9olqoPl1R3rIsTiouzC8ch05FD4c7zX2EAKT9/168VKOv+nA=
X-Received: by 2002:a05:6a00:949d:b0:841:6414:44ce with SMTP id d2e1a72fcca58-84164147ca5mr7923029b3a.22.1779612829486;
        Sun, 24 May 2026 01:53:49 -0700 (PDT)
Received: from DESKTOP-G3E0OSP.localdomain ([112.172.255.242])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164ea4de4sm6353116b3a.35.2026.05.24.01.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 01:53:49 -0700 (PDT)
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
Subject: [PATCH RFC v2 3/7] iio: osf: add protocol v0 decoding
Date: Sun, 24 May 2026 17:53:08 +0900
Message-ID: <20260524085312.15369-4-kimjinseob88@gmail.com>
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

Add OSF0 frame and payload decoders for device-to-host messages.

Signed-off-by: Jinseob Kim <kimjinseob88@gmail.com>
---
 drivers/iio/opensensorfusion/osf_protocol.c | 220 ++++++++++++++++++++
 drivers/iio/opensensorfusion/osf_protocol.h | 100 +++++++++
 2 files changed, 320 insertions(+)
 create mode 100644 drivers/iio/opensensorfusion/osf_protocol.c
 create mode 100644 drivers/iio/opensensorfusion/osf_protocol.h

diff --git a/drivers/iio/opensensorfusion/osf_protocol.c b/drivers/iio/opensensorfusion/osf_protocol.c
new file mode 100644
index 000000000..ac3c37ae2
--- /dev/null
+++ b/drivers/iio/opensensorfusion/osf_protocol.c
@@ -0,0 +1,220 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/crc32.h>
+#include <linux/errno.h>
+#include <linux/bits.h>
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
+	channel_count = get_unaligned_le16(payload + 4);
+	sample_format = get_unaligned_le16(payload + 6);
+
+	if (sample_format != OSF_SAMPLE_FORMAT_S32)
+		return -EPROTO;
+
+	expected_len = OSF_SENSOR_SAMPLE_BASE_LEN + channel_count * sizeof(s32);
+	if (frame->payload_len != expected_len)
+		return -EMSGSIZE;
+
+	sample->sensor_type = get_unaligned_le16(payload);
+	sample->sensor_index = get_unaligned_le16(payload + 2);
+	sample->channel_count = channel_count;
+	sample->sample_format = sample_format;
+	sample->scale_nano = get_unaligned_le32(payload + 8);
+	sample->reserved = get_unaligned_le32(payload + 12);
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
+	status->uptime_s = get_unaligned_le32(payload);
+	status->status_flags = get_unaligned_le32(payload + 4);
+	status->error_flags = get_unaligned_le32(payload + 8);
+	status->dropped_frames = get_unaligned_le32(payload + 12);
+	status->reserved = get_unaligned_le32(payload + 16);
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
+	capability_count = get_unaligned_le16(payload);
+	expected_len = OSF_CAP_REPORT_BASE_LEN +
+		       capability_count * OSF_CAP_SENSOR_ENTRY_LEN;
+
+	if (frame->payload_len != expected_len)
+		return -EMSGSIZE;
+
+	report->capability_count = capability_count;
+	report->reserved = get_unaligned_le16(payload + 2);
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
+	entry->sensor_type = get_unaligned_le16(payload);
+	entry->sensor_index = get_unaligned_le16(payload + 2);
+	entry->channel_count = get_unaligned_le16(payload + 4);
+	entry->sample_format = get_unaligned_le16(payload + 6);
+	entry->scale_nano = get_unaligned_le32(payload + 8);
+	entry->flags = get_unaligned_le32(payload + 12);
+	entry->reserved = get_unaligned_le32(payload + 16);
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
-- 
2.43.0

