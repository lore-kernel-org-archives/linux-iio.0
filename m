Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF2C38F93B
	for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 08:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779612835; cv=none; b=QwBmvBuRAqKOZhfxI/uBrBb2UibtFOnQ88+U/6q4sNpFaJgpR2d/FfJ4IkEU4F358vt2y/tPCbqcuCmfA+oO0ArPwYtjlqTEstpFA1yWIpRKRRa3A9XWdnkm2iRUuJHky/fauoRrnojzD9rjaN82miM7bIsJVZ/KqiTKla5zHKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779612835; c=relaxed/simple;
	bh=JQFcnG2hyCIPDGZsHUJKv/yfIWKH5QAMSCNMowNCIpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GHMbf158nPbNbA2e/VP5SUYdY6pZ9pOj1VkILwgVJMf2qZATsZ8c33qKOKqEfznE1xDlyYCj4iDVjzN1TKJpO4qvr2u0g+qz3d7TF7nPX1YIKz+zHZEjiEVxlDguk+0B72xikVMvzOPIRVb3jKLmVl2HjafPmbgMWIiQJ5FZX9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kTd3foSm; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kTd3foSm"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8353c9f24d2so4372395b3a.3
        for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 01:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779612833; x=1780217633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BLhf9NCIQR8/SjUY7PFqXJOHwil80+JfrtnhSO8qnWs=;
        b=kTd3foSm0iCzdujau42QPr8qmTHhTf7nPAjh8+QX1zR6heMKVD8BMTswOFkY9yEY7E
         OPnnpUuCYHG00yVXLElyv5vWk4Sg6cmNPe5ImQqN+256QWSpfYaKkoyNNZkn/6Cn66Zo
         U95zjM8FAhLonyZyeRBrZZqHbYwJ0pjO9xUSjul9rB+CLjeqa/U2PHh9RbakFJExsC1+
         w7GDIjJsf7Mu5CcATRlzJFvKbKZxJoxhYDaHMlBLRaNkU8a/OwsX8tpTVu1InqEMwqgq
         83M8ZKYSVdQd9PJOP7jtmTgQEMQyzeRk548wmzoYWDRgI2dGmxC3cuTHLU/AcwEwL8R0
         MbJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779612833; x=1780217633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BLhf9NCIQR8/SjUY7PFqXJOHwil80+JfrtnhSO8qnWs=;
        b=UHaaUpK4hrylgQH2+A37pVvbS95sgzRPWMxynFk/imFxgJuZh4CylwyaVyrLNRzu2U
         Csi6j0gOfGoWgQTJKSx60qcVwETRBlY4KS8hjstvedmIdxNmK53XSaU6+oxpjLxUKrFd
         y08iZJah1wGYDGzHOH/A237ltChyu1rHNJ7XRjo3qVQ0pxID0tKMA+1le6L9iNUE2j7G
         BrYrEdd7y7CHWc+BjclE9tuGpSGz3w3N4XYR5kkyyCyTu6l/mtXQJfZjSUrh5t3gihmv
         5Tk33Lj1CmeeUTHLXRv//UVbeLb/58K8OKdNkCQGFZxFNpKZWvXq3/oMReD3LLuwbOzi
         28Lg==
X-Forwarded-Encrypted: i=1; AFNElJ8O/uTTkJhVHmXP8CSiwMVkwZnqB3w2yFTEb77eqJ2J2+ZoTMOmKgZf/0vA8oVHKVESux6fo5y0Dpg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEOL5k3hsuqTgy8udPnrq2Lh/ywYeh1aO2TEAzkqcz5JIf4hyW
	8Ws4T8YM5LwUEmwexYDJ2j2RvRZP+qZus+PkVp+uJlDTlmKuRPwfR7b/
X-Gm-Gg: Acq92OG7TYL0KtZ+ZoEb1Qn0TE1f5+mEggE+WLesYgUpYrVYPBa5Ly+rZOtmAEYmqcb
	8B+x08f4cg2usEtJgWYgwAY3tGJfuJv40QdBfdJJp7pK4f8Y1DAO/NaoAnWzS0EbsAA+xVcK52o
	WK1aqrznh5vRS8K5YsM4KB9NBDwkbvze6SGSkYeTpKiZ+8mZzH70MHTn04K6ut7g0irIU1Y8ZbE
	IuIWPjQRBKU/Jf1Y6KFHc4erYi3kRc1px6WmKVbpHj7yooZ8eCUT/EIB7ecuEPnV6VI+75jzndu
	TZGhx91DYCIdqH4scb/eDGGPbnsPVdJA9Ih5gDGQ5h1brZQTsjJKr6pITV36sM63S2/WYeO6ILI
	y+i7Hiqx6N+7w+j+C8Ka4cYryYkhn/5aIb27lezrFfwqwBet5FrPCOFvzta8lEkEEqKCWBxNGxC
	uB//LEiKbzafV6i0XSRZ//LZuU1xhBf5YY3ciqjCDWC5BVgi2v1CWtg+PRCHMdA6O47cjEyhsMs
	9ABz0b7OG3/6JVAig7LzYg2zzdRcV4fGSqZXg==
X-Received: by 2002:a05:6a00:3923:b0:82c:e60c:f36d with SMTP id d2e1a72fcca58-8415f5983ecmr10120508b3a.48.1779612833389;
        Sun, 24 May 2026 01:53:53 -0700 (PDT)
Received: from DESKTOP-G3E0OSP.localdomain ([112.172.255.242])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164ea4de4sm6353116b3a.35.2026.05.24.01.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 01:53:53 -0700 (PDT)
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
Subject: [PATCH RFC v2 4/7] iio: osf: add stream parser
Date: Sun, 24 May 2026 17:53:09 +0900
Message-ID: <20260524085312.15369-5-kimjinseob88@gmail.com>
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

Add byte stream assembly and resync for OSF0 frames.

Signed-off-by: Jinseob Kim <kimjinseob88@gmail.com>
---
 drivers/iio/opensensorfusion/osf_stream.c | 207 ++++++++++++++++++++++
 drivers/iio/opensensorfusion/osf_stream.h |  31 ++++
 2 files changed, 238 insertions(+)
 create mode 100644 drivers/iio/opensensorfusion/osf_stream.c
 create mode 100644 drivers/iio/opensensorfusion/osf_stream.h

diff --git a/drivers/iio/opensensorfusion/osf_stream.c b/drivers/iio/opensensorfusion/osf_stream.c
new file mode 100644
index 000000000..a2739c987
--- /dev/null
+++ b/drivers/iio/opensensorfusion/osf_stream.c
@@ -0,0 +1,207 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <linux/types.h>
+#include <linux/unaligned.h>
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
+static void osf_stream_drop_invalid_head(struct osf_stream *stream)
+{
+	osf_stream_discard(stream, 1);
+}
+
+static bool osf_stream_magic_match(const u8 *buf, size_t len)
+{
+	return !memcmp(buf, osf_stream_magic, len);
+}
+
+static size_t osf_stream_discard_to_magic(struct osf_stream *stream)
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
+		discarded = osf_stream_discard_to_magic(stream);
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
+		if (get_unaligned_le16(stream->buf + 6) !=
+		    OSF_FRAME_HEADER_LEN) {
+			stream->stats.dropped_bytes++;
+			osf_stream_drop_invalid_head(stream);
+			if (!first_err)
+				first_err = -EPROTO;
+			continue;
+		}
+
+		payload_len = get_unaligned_le32(stream->buf + 10);
+		if (payload_len > OSF_STREAM_MAX_PAYLOAD_LEN) {
+			stream->stats.dropped_bytes++;
+			osf_stream_drop_invalid_head(stream);
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
+			osf_stream_drop_invalid_head(stream);
+			if (!first_err)
+				first_err = ret;
+			continue;
+		}
+
+		if (decoded_len != frame_len) {
+			stream->stats.dropped_bytes++;
+			osf_stream_drop_invalid_head(stream);
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

