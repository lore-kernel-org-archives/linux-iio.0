Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10AD46D2D0
	for <linux-iio@vger.kernel.org>; Sun, 11 Oct 2026 23:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791760503; cv=none; b=eNOHCa9tQwOnRU14p5TOQmH3HqqfQM6PO31qjivP5wwsz6ix37DzWZROgZCNetzNxu4RVMhVJRTavwRuXK1wSSQdw6GWNVijGmrJbSllPkAuFhh9s0qsheuOOi+hKMIVx+ui/l7Zn7Dw3blGxeeZj7QqDhH+UEXpqsxKLYdlEZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791760503; c=relaxed/simple;
	bh=AqNDppzP83l7+YC5rFvwW0+TZ2VoILt230wkwAgmm4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WR5eirG156uFI7+ezxOlZMqUKgfkshpuJcBzdgmGgF52/tF5PSBKp/maVXiusk4VsNV6AFAz/yrTLMfjGyXA7+Q1gTnK2L8kgozGA1zO5kwl8KCpWglC44AWnh3LbLtmJ34KA0JT73UnTQuNziY/GZpftaHqR7z4/ZWLqtAk4bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a6r0Kn1d; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a6r0Kn1d"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8874539bccbso525991b3a.1
        for <linux-iio@vger.kernel.org>; Sun, 11 Oct 2026 16:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791760500; x=1792365300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/K6cmmJjeLoxSNNELurCPiOATAAYdkfL3cy3GSTeLKE=;
        b=a6r0Kn1dsmrIyQdMYaPvbSnCbauoS93GAHcmtcV3QnPQq4Xc+lE2a1lRfMZCAci8SF
         lUydl6nVUbgRPuychVmQr8mj6qvxJLwMjMzEO70gTkKdnu1U3O4f+FcDvglU3nlaA9oT
         u/Hqgx5ipe9W6ZHh18mht2dxB833V5f6iU48lv7jb9QeCX//rYIj6BIpgQ5DPHb5sQ+W
         FcpmqgI+4AarmXiYpmkbmQzJj62uSuUI7tbMkct/LcD+a9evkyeO82PHWdtOZF0lwzka
         zJmXnk2z3Ic8ZJdRpUfdAwPZ4rqI3BucoxOEkxH4mB7Xt+YtV28QSfEMcnauDO25kPVp
         U9mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791760500; x=1792365300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/K6cmmJjeLoxSNNELurCPiOATAAYdkfL3cy3GSTeLKE=;
        b=l849ZFYDf9l404WhxlyFgIrppyUu5igJRZ2rnI7BNVFyJpLpTfxnLrqMHAX/IAzQ+s
         5WOan7IIn0rz8tjl9dd+GwValZ6P6zcsm+D8oWUUVBV3ILYl+TVSFzdcjryLMOEQRqEe
         YwNyPmVTKLN6lYovrItkQ87/SG29DstGr3P9wVDM4ViUtMDwQ3h3enUZkKXZPriLpned
         tV27t3P+9JF7SbfdWBDuaiYsllzVFskYrAqYwT5/MSqRoT8kNSFO1os0xfdeVKV/u+wh
         fj9uGsDFbROmtNdzhKCyLuCNSWSHcg3UatUE77SeKj47lfftSL5ugvv7JDqQzQpysI9I
         fQPQ==
X-Forwarded-Encrypted: i=1; AKwUvByXrspXjEn1g7AIPz98fRvqrY3gLNtRTbEHywyi1m0tcM44g1TqLeC+ih0gbjnl7YCfVzLnq0GPdKI=@vger.kernel.org
X-Gm-Message-State: AFq9FYL1zYoDfFEOoDWC4JSyfRGHZLhkZxeMGUqeTZ/oaDz155gIUJ7Q
	Jwb0keCqzHeDwi8fm//oncSxrUZX9mKhQhMzylrKa0lFQB6et4XAPMTD
X-Gm-Gg: AYBFou05RL7aZ8Df0YTfe/mYOHCl9JClFeIcSASAi7NPTvLcXsSF3aaOwT6rCukt85W
	t+FK2FQEoSi73w8H/uCBJz5GOpp6+jaHSnOpAcr2BdyaXIGRmq7W7OWiuMt0+Okc8RwLGQTgbRh
	Ul5qEw01kTZ8ihpywv5I3n1TSPRn8cxNVrZjHzOQFvxuIIDOtDoSLx4RZ8qu8k1uIJ+08siWZBE
	Nns1p4QpstFqZ5GLTKDKoUakNTwd58tBen9gi+/dBqccQK0uY4J2joK3jIxARJXvbKwoyWAUrvG
	SjhdzCC1fVG4t9Dcz6SOayk1aCrNghP4/LecIepjDIudDVbbsD1218bo+SG2U4uH3al7z8l7wmP
	EGquroQIbBQ8WIWhTICg53qd7nR6ehD+lEJo8kMMsUQ2n2O7ll1BRazSGp68nn/j5j/fhkjGbh/
	VZ48VgBaQ8NZj5SxDqnDeQDlwrKhi/nQgJueZbzBWv9e3QJoE+Sn/IvOO4omYovQj1OdbEwotig
	pCQhUXuQOn56FN33t8WMZZMbiC4W5UxMxB+eqC29RUuavvud3/c+QXKs7uUAO/McMkHi26TBFgM
	E02S3/s=
X-Received: by 2002:a05:6a00:44c9:b0:851:c2a6:172f with SMTP id d2e1a72fcca58-897c3ef97b0mr6598477b3a.7.1791760500225;
        Sun, 11 Oct 2026 16:15:00 -0700 (PDT)
Received: from DESKTOP-G3E0OSP.localdomain ([58.224.60.243])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-896c48945dcsm3188917b3a.54.2026.10.11.16.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 16:14:59 -0700 (PDT)
From: Jinseob Kim <kimjinseob88@gmail.com>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Cc: kimjinseob88@gmail.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	neil.armstrong@linaro.org,
	andersson@kernel.org,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v11 4/8] iio: osf: add validated stream parser
Date: Mon, 12 Oct 2026 08:13:36 +0900
Message-ID: <20261011231340.42885-5-kimjinseob88@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261011231340.42885-1-kimjinseob88@gmail.com>
References: <20261011231340.42885-1-kimjinseob88@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a UART byte-stream parser for Open Sensor Fusion frames.

The parser searches for the OSF0 wire magic, keeps partial frames
buffered, checks header length and payload bounds, and passes complete
candidate frames to a registered frame callback.

Candidates rejected before validation drop only the current head
byte before resynchronizing, so a corrupted unvalidated payload length
cannot make the parser skip later valid frames. CRC-valid validated
frames are consumed in full and classified as handled, ignored, or
rejected.

Use a direct callback member with an opaque context and keep explicit
statistics for validated outcomes and framing failures.

Assisted-by: LLM
Signed-off-by: Jinseob Kim <kimjinseob88@gmail.com>
---
 drivers/iio/sensorhubs/osf/osf_stream.c | 230 ++++++++++++++++++++++++
 drivers/iio/sensorhubs/osf/osf_stream.h |  53 ++++++
 2 files changed, 283 insertions(+)
 create mode 100644 drivers/iio/sensorhubs/osf/osf_stream.c
 create mode 100644 drivers/iio/sensorhubs/osf/osf_stream.h

diff --git a/drivers/iio/sensorhubs/osf/osf_stream.c b/drivers/iio/sensorhubs/osf/osf_stream.c
new file mode 100644
index 0000000000000000000000000000000000000000..c9c1284a88e772ec88f357e74120e22ebf440a13
--- /dev/null
+++ b/drivers/iio/sensorhubs/osf/osf_stream.c
@@ -0,0 +1,230 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/errno.h>
+#include <linux/minmax.h>
+#include <linux/string.h>
+#include <linux/types.h>
+#include <linux/unaligned.h>
+
+#include "osf_protocol.h"
+#include "osf_stream.h"
+
+#define OSF_STREAM_MAGIC_LEN	sizeof(__le32)
+#define OSF_STREAM_MAX_PAYLOAD_LEN				\
+	(OSF_STREAM_MAX_FRAME_LEN - OSF_FRAME_HEADER_LEN - OSF_FRAME_CRC_LEN)
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
+static bool osf_stream_magic_prefix_match(const u8 *buf, size_t len)
+{
+	for (size_t i = 0; i < len; i++) {
+		if (buf[i] != (u8)(OSF_FRAME_MAGIC >> (i * 8)))
+			return false;
+	}
+
+	return true;
+}
+
+static size_t osf_stream_discard_to_magic(struct osf_stream *stream)
+{
+	size_t old_len = stream->len;
+	size_t keep_len;
+
+	for (size_t i = 0; i + OSF_STREAM_MAGIC_LEN <= stream->len; i++) {
+		if (get_unaligned_le32(stream->buf + i) == OSF_FRAME_MAGIC) {
+			if (i)
+				osf_stream_discard(stream, i);
+			return i;
+		}
+	}
+
+	/*
+	 * Keep a final 1-3 byte OSF_FRAME_MAGIC prefix so a magic split
+	 * across receive_buf() calls can be completed by the next chunk.
+	 */
+	keep_len = min(stream->len, OSF_STREAM_MAGIC_LEN - 1);
+	while (keep_len) {
+		size_t offset = stream->len - keep_len;
+
+		if (osf_stream_magic_prefix_match(stream->buf + offset, keep_len)) {
+			if (offset)
+				osf_stream_discard(stream, offset);
+			return offset;
+		}
+		keep_len--;
+	}
+
+	stream->len = 0;
+	return old_len;
+}
+
+static int osf_stream_process(struct osf_stream *stream)
+{
+	size_t discarded;
+	size_t frame_len;
+	u32 payload_len;
+	int frame_result;
+	int first_err = 0;
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
+		if (stream->len < OSF_FRAME_HEADER_LEN)
+			break;
+
+		if (get_unaligned_le16(stream->buf + 6) != OSF_FRAME_HEADER_LEN) {
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
+		if (stream->len < frame_len)
+			break;
+
+		frame_result = stream->receive_frame(stream->frame_context,
+						     stream->buf, frame_len);
+		if (frame_result < 0) {
+			if (frame_result == -EBADMSG)
+				stream->stats.bad_crc_frames++;
+
+			/*
+			 * Decoding failed before the frame was validated;
+			 * payload_len is still untrusted. Drop only the current
+			 * head and resynchronize.
+			 */
+			stream->stats.dropped_bytes++;
+			osf_stream_drop_invalid_head(stream);
+			if (!first_err)
+				first_err = frame_result;
+			continue;
+		}
+
+		/* Count exactly one outcome for every validated frame. */
+		stream->stats.validated_frames++;
+		switch (frame_result) {
+		case OSF_STREAM_FRAME_HANDLED:
+			stream->stats.handled_frames++;
+			break;
+		case OSF_STREAM_FRAME_IGNORED:
+			stream->stats.ignored_frames++;
+			break;
+		case OSF_STREAM_FRAME_REJECTED:
+			stream->stats.rejected_frames++;
+			break;
+		default:
+			/*
+			 * Preserve the validated boundary without scanning the
+			 * payload for another magic value.
+			 */
+			stream->stats.rejected_frames++;
+			if (!first_err)
+				first_err = -EPROTO;
+			break;
+		}
+		osf_stream_discard(stream, frame_len);
+	}
+
+	return first_err;
+}
+
+void osf_stream_reset(struct osf_stream *stream)
+{
+	if (!stream)
+		return;
+
+	stream->len = 0;
+	memset(&stream->stats, 0, sizeof(stream->stats));
+}
+
+void osf_stream_init(struct osf_stream *stream,
+		     int (*receive_frame)(void *context, const u8 *buf,
+					  size_t len),
+		     void *frame_context)
+{
+	if (!stream)
+		return;
+
+	stream->receive_frame = receive_frame;
+	stream->frame_context = frame_context;
+	osf_stream_reset(stream);
+}
+
+int osf_stream_receive_bytes(struct osf_stream *stream,
+			     const u8 *buf, size_t len)
+{
+	size_t copy_len;
+	size_t space;
+	int first_err = 0;
+	int ret;
+
+	if (!stream || !stream->receive_frame || (!buf && len))
+		return -EINVAL;
+
+	if (!len)
+		return osf_stream_process(stream);
+
+	/*
+	 * Continue processing this receive_buf() chunk after recoverable
+	 * framing errors so later valid frames do not wait for another callback.
+	 * first_err retains the first diagnostic return, while the serdev
+	 * callback reports the full byte count consumed. Every validated
+	 * callback result is consumed in full by osf_stream_process().
+	 */
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
+		copy_len = min(len, space);
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
diff --git a/drivers/iio/sensorhubs/osf/osf_stream.h b/drivers/iio/sensorhubs/osf/osf_stream.h
new file mode 100644
index 0000000000000000000000000000000000000000..9087533b2d04124e52ae5dbaa564a7ddad31499c
--- /dev/null
+++ b/drivers/iio/sensorhubs/osf/osf_stream.h
@@ -0,0 +1,53 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _OSF_STREAM_H
+#define _OSF_STREAM_H
+
+#include <linux/types.h>
+
+#define OSF_STREAM_MAX_FRAME_LEN	4096
+
+/**
+ * enum osf_stream_frame_result - validated frame callback result
+ * @OSF_STREAM_FRAME_HANDLED: frame was processed successfully
+ * @OSF_STREAM_FRAME_IGNORED: frame was valid but unsupported or ignored
+ * @OSF_STREAM_FRAME_REJECTED: validated application processing failed
+ *
+ * A frame callback returns a negative errno only when a candidate could not
+ * be validated and the parser may perform one-byte resynchronization.
+ * Every nonnegative result must be one of these values. Such a result means
+ * the CRC-valid frame boundary is trusted, so the parser must consume the
+ * full frame.
+ */
+enum osf_stream_frame_result {
+	OSF_STREAM_FRAME_HANDLED,
+	OSF_STREAM_FRAME_IGNORED,
+	OSF_STREAM_FRAME_REJECTED,
+};
+
+struct osf_stream_stats {
+	u64 validated_frames;
+	u64 handled_frames;
+	u64 ignored_frames;
+	u64 rejected_frames;
+	u64 bad_magic_resyncs;
+	u64 bad_crc_frames;
+	u64 dropped_bytes;
+};
+
+struct osf_stream {
+	int (*receive_frame)(void *context, const u8 *buf, size_t len);
+	void *frame_context;
+	u8 buf[OSF_STREAM_MAX_FRAME_LEN];
+	size_t len;
+	struct osf_stream_stats stats;
+};
+
+void osf_stream_init(struct osf_stream *stream,
+		     int (*receive_frame)(void *context, const u8 *buf,
+					  size_t len),
+		     void *frame_context);
+void osf_stream_reset(struct osf_stream *stream);
+int osf_stream_receive_bytes(struct osf_stream *stream,
+			     const u8 *buf, size_t len);
+
+#endif
