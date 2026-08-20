Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379D43839B7
	for <linux-iio@vger.kernel.org>; Thu, 20 Aug 2026 05:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787202424; cv=none; b=Mzf3nLHsyLBbFXRJ3o4EtxboT+FOhSQTBfxxBypQIA5jmZJn0OvJ+IeNj8jDqZY/e51hCXENBFvjCn7+XI8FYH6pASPL6SHmZLOseHfVV5RjUJQZKHmKfSatU/XAWqW+1uTzKcnuTvEsqqREBc48yDb2+WnIZFx8H0gVcjSgzAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787202424; c=relaxed/simple;
	bh=ecSTldjYc0eR16zdrrb5tSVl+tYpovDnI51QRYeqz0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=soHwbGErujgL90RAlqhtDJMfnEDAAa+CqBSAUbKuK+vrgunS+SgDThx6QliYJrVWHRhY/5ldjuyRDgeqMbwSRzOY5FmFRVXlv5VpqnsemSYCnasI+sjJSH96A+xCuvT126NI0L2oBjv8JrldJ2JFCMLg+BImV4sx3BK8vhqU2uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TJ18RRSn; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJ18RRSn"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2d049069377so15416675ad.0
        for <linux-iio@vger.kernel.org>; Wed, 19 Aug 2026 22:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787202422; x=1787807222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QSDGHLGAZ9pEeCwkKi+EOe7Q+Big6asBd/SfdVgmiK8=;
        b=TJ18RRSnl335Zh6kZCRxVLC6NKN2pBk6IE+8DNx5+xP43Nu2RME8qGYP20IRYeG71E
         iVKAvAcr1ZGPQ7aAHzcBlK+f50p4x5AxJJcbQZGzxpp4sWn7Vm2/1X5qB+vzUv/0jgug
         5AFuJg2s7QeNNQLpU6kqeCzZEFrBfIiG3IP4QQWFk4mN76cL+bpsMF18BUbat3fBfki9
         Tasg8/j79DBocKth2V21tpC423ShyJIChWbQnSf+7HiXW6XQYCGnBX4Svl6Q4Wffi2UY
         edJGEdHkqVSzbyS1UulRjTd1acbx070rk0It8GqRD4uh47baVVra4KiEq42SlPfDNesH
         +LTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787202422; x=1787807222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QSDGHLGAZ9pEeCwkKi+EOe7Q+Big6asBd/SfdVgmiK8=;
        b=PnMBF3YjR6jnWCz+l1wtmE3wGn1VXR0XkJFs6L6FlcY0dNpFVynRVfz6BQ7ZuWese1
         VnRL4DoFNvI+aBivUKHjhyF3ipMhPahkhirQ+ZJ8RUxNz0eIg+Nh2tNlA+HLnzKaHtnU
         E8hzgYFb6WXv4g/KueOGhTXCDLQAQW1VYumqwT68EhBtg3LtHxhoLFf8C/OP0nibJFcM
         /+H85SqH2jEbfFSpp3TJRg3vEuogYoA4PYQSnxbyjHpcINvobm8ZNVfL2skHcmOnUFpc
         VnTeOW+G66TJtVN2ILZBOmeLrppdEH9MuOw6lC/NYQ8WwWyfs8jdZbqm+sZ9Ww0iOQSg
         Zgow==
X-Forwarded-Encrypted: i=1; AHgh+Rpt/DzEPbK8b6qU6VjEGCZQPF/FE1baMwTNF6+OMJOoxUe6JAaZCCjqDkJtPb4SHRoqbagvWPhzweQ=@vger.kernel.org
X-Gm-Message-State: AFuF++kDoy+WSzeJTvXcZPDaEfL+DwfGFOpP10X5109OCFOhtY0XctJ1
	8JAX0DQ8l6pv9sPtl7dA1Qp+XNNdvQaJiQE0SvggomtAimk16e9eqab4
X-Gm-Gg: AR+sD138W3QXgfKEmatrk2ZkZoq3pRAYbX2QFlGBkNO6tx84JaYR8JxD6zRUXp/e4Sb
	M63mUMG5sgb3k91Ey2kNmMF7yIIFkuPqJv8pqPrQVarh/xPItfLTH+PPaa8zG/xf9hKpXVFKLbN
	h1+kFGKwQWR8eUDybp9PoTdn8MOCBnl2T4H2OCe06USy+ZFHcJbkCnpZoVm0MFX8d3HFM+rS8nt
	rOw3p4ooWYAOo+juyDKVFsqAGpZoknlyIqrIu7zYFOQ2Cdvjd+J8sunUSl6Chb8TCsxdm/+HtIb
	k2zZHak/O5nQ33aIZX3N2G3s2VOcdvWIkDykaqZGu1WfTQp0dAJ55V4TqbZhOT9y0c/z+qaNlbr
	1SwqfJeAWiXVs9VQiqy41/EPjli28cgYSp3tNwASQUaEawDKqQa6h9GAgQcFipUQ4N94oKZmYcY
	JFb+EdUoDIsynI48a2tsViq/Md7emURLv/R5MfbWF5SEQV2WDScLt1BQM9druxAFZ9VfjaDto/V
	CLW62GK0a4CGX5H2s+hkFxVW4Ed3Ny9eN3SmIgGac8s9/eRJ0O55IoBlDGSTF1xBTnq4nZ/nHVL
X-Received: by 2002:a17:903:144b:b0:2c8:f34c:82c0 with SMTP id d9443c01a7336-2d5fd64499emr189066325ad.2.1787202422040;
        Wed, 19 Aug 2026 22:07:02 -0700 (PDT)
Received: from DESKTOP-G3E0OSP.localdomain ([112.172.255.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d62d58a82dsm2040685ad.18.2026.08.19.22.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 22:07:01 -0700 (PDT)
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
Subject: [PATCH v8 4/5] iio: osf: add authenticated stream parser
Date: Thu, 20 Aug 2026 14:06:07 +0900
Message-ID: <20260820050608.5440-5-kimjinseob88@gmail.com>
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

Add a UART byte-stream parser for Open Sensor Fusion frames.

The parser searches for the OSF0 wire magic, keeps partial frames
buffered, checks header length and payload bounds, and passes complete
candidate frames to a registered frame callback.

Candidates rejected before authentication drop only the current head
byte before resynchronizing, so a corrupted unauthenticated payload length
cannot make the parser skip later valid frames. CRC-valid authenticated
frames are consumed in full and classified as handled, ignored, or
rejected.

Use a direct callback member with an opaque context and keep explicit
statistics for authenticated outcomes and framing failures.

Signed-off-by: Jinseob Kim <kimjinseob88@gmail.com>
---
 MAINTAINERS                               |   1 +
 drivers/iio/opensensorfusion/osf_stream.c | 231 ++++++++++++++++++++++
 drivers/iio/opensensorfusion/osf_stream.h |  53 +++++
 3 files changed, 285 insertions(+)
 create mode 100644 drivers/iio/opensensorfusion/osf_stream.c
 create mode 100644 drivers/iio/opensensorfusion/osf_stream.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 76fa860a7b91..093b569de12e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20299,6 +20299,7 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/opensensorfusion,osf.yaml
 F:	Documentation/iio/open-sensor-fusion.rst
 F:	drivers/iio/opensensorfusion/osf_protocol.*
+F:	drivers/iio/opensensorfusion/osf_stream.*
 K:	opensensorfusion
 
 OPENCOMPUTE PTP CLOCK DRIVER
diff --git a/drivers/iio/opensensorfusion/osf_stream.c b/drivers/iio/opensensorfusion/osf_stream.c
new file mode 100644
index 000000000000..7ce45e631648
--- /dev/null
+++ b/drivers/iio/opensensorfusion/osf_stream.c
@@ -0,0 +1,231 @@
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
+					     stream->buf, frame_len);
+		if (frame_result < 0) {
+			if (frame_result == -EBADMSG)
+				stream->stats.bad_crc_frames++;
+
+			/*
+			 * Decoding failed before the frame was authenticated;
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
+		/* Count exactly one outcome for every authenticated frame. */
+		stream->stats.authenticated_frames++;
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
+			 * Preserve the authenticated boundary without scanning the
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
+	stream->len = 0;
+	memset(&stream->stats, 0, sizeof(stream->stats));
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
+	 * callback reports the full byte count consumed. Every authenticated
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
diff --git a/drivers/iio/opensensorfusion/osf_stream.h b/drivers/iio/opensensorfusion/osf_stream.h
new file mode 100644
index 000000000000..c13f4e3af18f
--- /dev/null
+++ b/drivers/iio/opensensorfusion/osf_stream.h
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
+ * enum osf_stream_frame_result - authenticated frame callback result
+ * @OSF_STREAM_FRAME_HANDLED: frame was processed successfully
+ * @OSF_STREAM_FRAME_IGNORED: frame was valid but unsupported or ignored
+ * @OSF_STREAM_FRAME_REJECTED: authenticated application processing failed
+ *
+ * A frame callback returns a negative errno only when a candidate could not
+ * be authenticated and the parser may perform one-byte resynchronization.
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
+	u64 authenticated_frames;
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
-- 
2.43.0

