Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9DE569F19
	for <linux-iio@vger.kernel.org>; Wed,  9 Sep 2026 15:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788966413; cv=pass; b=YsFeEqKfU6U5O/pXgiFCYD+7vP7i1jVkytdEdfH7RD7aYhaSBGFUR5awijqceu/c/fY+4u6Q42Oe2kd9sanURftEfqbDew55gwwE94f1/sSGQ5LKBHYhuxDXmGZgoF1bEv9qkp2evQXoUIbBNbhVwKHEzLnIOaZT2HzNiOO9P+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788966413; c=relaxed/simple;
	bh=k2qfzy4hErs+vQGwIONiuwFv8cd9e9/OCLbxweTDTGU=;
	h=MIME-Version:From:In-Reply-To:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GkaDTtY9S66UShvuf2Ui0xQiW4Cqn1+/oWkIqL/VvMu1qSfWMSCAhkowAaNew2P1Li/c/YDwTRR8DbSyxaxkJ/gm27zm4oEppKKs6QkOJe1k9knbhC8a9akYkrZ/fmmfLkc8HOrhhZie3XPfvpVY1FuUzepkzepOUq5VD3vPMYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VZKxfi67; arc=pass smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZKxfi67"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6b1c75f0049so4466734eaf.3
        for <linux-iio@vger.kernel.org>; Wed, 09 Sep 2026 08:06:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788966409; cv=none;
        d=google.com; s=arc-20260327;
        b=CGCvSAODa3GoWVRgCXMhbU3d2ecmhW1UEPe4u/vtckhZGNU5/5Ev8FoiGT4elMy2nV
         UtsvwyTkj4xpdrCrm0/nkt5tYlsFsjc7ZSmtFU4ZhfxBdIPyK9OwbkYZ3LFPma8riVIo
         b1wNo3p6kDbeEBI17041agUdDkiij4s/DjSwexmAVn9yUbKgvoZMc6ookIeQDqxB10ff
         suoNftS/Zcwz37rBLN5u1VXyQggIhwiT5AbjItavkSlEZCHeVL5w8xQs0E/ykeTBvZ57
         dud+UJNLbZM4SqqyNGVLwacFgxGp53c+faq5QSsdFq7fi1CLOlWhYqQZfx0T/T9gRY3H
         UxvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:references:in-reply-to:from
         :mime-version:dkim-signature;
        bh=c31/Tnh+sbAxB7gCPzYWt77jlxu/AsDNJ4xDcUYAnY8=;
        fh=r0htLYH/pkvG6tXCW+G2MaWvvt7gZlex43v+V/gb7EQ=;
        b=U8noITyOCrNWM+FF1W/MQwpZ4fGeKJkeXBzJetZH26KHrVcA7Z1C4wUokiKw2o/K2+
         gDaB8NtRTeoG30NRBglb4frR+Rx7M1cmMy3gNfYDzLIBrzf3QhgtUYwR2sbj4HShNrOh
         wwSGiVQkYvj1UBK0NB9vcd3tLxVGxNukecjFBH2Ugvjtn+disMMRRn+3L6uDCaSbvE2u
         nP8rv87uZ3rx7F+Joek5WY78cLhHzvixRuJTlmlwjcIrvE9wJJ8woaU2pPGl2Gly+qLS
         mVrc350cZ8CjZiI03GnbMx9NjXCH6DVkec6jGHnCCoK30qxXRkTAJyT8lfLKh6GtDeAY
         NySQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788966409; x=1789571209; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:references:in-reply-to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c31/Tnh+sbAxB7gCPzYWt77jlxu/AsDNJ4xDcUYAnY8=;
        b=VZKxfi676YfOO3TyjzLTgME+SuoKbHABuVPPQsxdNhFI0lS8l7WrLxn4L+0SZQV7jh
         xuiZWqWPP+/zCXYb/mDmMnMXX6zJ46v8UocDfAKhOoepEB7wF8CflioFQxQkJYwYxKi5
         En2wQ0tS/sZJoRHY2MViUdkIdyeSpS5x+ZVPkWPm0pEJaYiIMbSqOegcQgiY+QEFNk5/
         IVjS9ILt85TTDqJJNsKJFeIEqO0iNBT+IowxwcMrogsDfFx2uYMZ2NtyuZbmCPsk2RdL
         jOkojlkZe+tRm4+FXedabyHsaKzccRer7chRNWppmZrscu0lz0AhhT+JqkjFs3fLH6fi
         ywLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788966409; x=1789571209;
        h=content-type:cc:to:subject:message-id:date:references:in-reply-to
         :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=c31/Tnh+sbAxB7gCPzYWt77jlxu/AsDNJ4xDcUYAnY8=;
        b=mOZcJQ20GFBE1BBGdRvJ6WgsSKZ2C8hdLBN0Ja6dGFea0KsvyvvxjQVWN2E/3nSnHR
         Ia83NmcfLAJU16kJ6GEjE0k/w7rgncQSmwu2jvISDLsI4KRydOy4R183H2TvX7CX1LXV
         lcJXN+wCWnCmJJ7JU3ihsaABIAaRXPc3wTuEIePi8W43U6GT9uQqFP0rI0+7dieWhNE5
         yH7EmnPVhxE09l8eIyGdcNMDorjLV19ysXdrTIgR+gaeP/2itvKZFUMvk3DxfKc6iL8+
         BX2QJx7BCb9r2KVgzhyiB9T0H/ZZePOuUZnOvihcPsSb92Ua6W7eeq7FNvdeTeHPNKSt
         11Xw==
X-Forwarded-Encrypted: i=1; AKwUvBwVj5HEKHPtt20LWYT6A/3BpxdO3zPDdhoSzMeMVvZV1qPBrBqcGoLsomJKT1TX23p7f1DTgt41mo4=@vger.kernel.org
X-Gm-Message-State: AFuF++lwNAS3v5zaS/zsaMnq8jmUoeUykUIeMxCaSuwcSjwbUfD/BorM
	M4Te9kl/5cHDfh1cXMvI9/vk0/3O6q2CH3Goo9HSdrqmWD1qsfz7Vi9OYKlnpnKE8IqHfoyf2HV
	wsUXNMQ+yczvluFZVlFt80CsQoFKGHtsbxBRN
X-Gm-Gg: AYBFou08vy1t0QcpkKMGebuy79v3pRj6KuM85QeWVBndL9kW4J/F0zfnS0lZJSPOhXP
	5Zd8W8RT3RkRASRboKA1sY3Hb0kpx9GXrXnoVgV30Okv8maMdKYzygAqAlrAqDT/7kKjod/cSZa
	RvQX+g5rmKQlElnHEeLAXyThWA5jQlxNaZQnawZjZBFk30lgioA43l2n4gBPrhxTnD4sQbznZMO
	6+Yay6uCZt4MofcfyRoo2lLKQ11NBzr/oVwT6HuXiVoNxGGgeoGNTBTgf4f81HzKhmMeAVU0hhS
	iQz53TGxEpySc8YKFZTvZ03XYsXkZtMelEg+ATnBx6ST8t02Hl7mPjSfeSlrrmBVncNIVihRCxF
	4Mg/g8GGb9gvz/BMIrNbVGjVoqcKres1lciZNzg==
X-Received: by 2002:a05:6820:4ccb:b0:6be:31b7:e684 with SMTP id
 006d021491bc7-6be31b7f404mr2750410eaf.34.1788966408409; Wed, 09 Sep 2026
 08:06:48 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 9 Sep 2026 08:06:47 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 9 Sep 2026 08:06:47 -0700
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jinseob Kim <kimjinseob88@gmail.com>
In-Reply-To: <CALMSewJPfQXRX5q4X3gJf=LT6m2FnusTM=DBiWsBqRFiyNP_Gw@mail.gmail.com>
References: <CALMSewJPfQXRX5q4X3gJf=LT6m2FnusTM=DBiWsBqRFiyNP_Gw@mail.gmail.com>
Date: Wed, 9 Sep 2026 08:06:47 -0700
X-Gm-Features: AcwNN1XFlQtgrH-fU4DEoQF7whI63Qa144Fp304SoCenIf7iGcNQ5my1HL_QW-w
Message-ID: <CALMSewJw0yOGOqoqevZotsq1-BBSENCZXr_-3=FxqtbyeYL_JQ@mail.gmail.com>
Subject: [PATCH v9 4/5] iio: osf: add authenticated stream parser
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	linux-kernel@vger.kernel.org, rdunlap@infradead.org, joshua.crofts1@gmail.com, 
	u.kleine-koenig@baylibre.com, julianbraha@gmail.com
Content-Type: text/plain; charset="UTF-8"

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
index f7ead365f946..a1117459ebd9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20517,6 +20517,7 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/opensensorfusion,osf.yaml
 F:	Documentation/iio/open-sensor-fusion.rst
 F:	drivers/iio/opensensorfusion/osf_protocol.*
+F:	drivers/iio/opensensorfusion/osf_stream.*
 K:	opensensorfusion

 OPENCOMPUTE PTP CLOCK DRIVER
diff --git a/drivers/iio/opensensorfusion/osf_stream.c
b/drivers/iio/opensensorfusion/osf_stream.c
new file mode 100644
index 000000000000..4e2a1deffbaa
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
+						     stream->buf, frame_len);
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
diff --git a/drivers/iio/opensensorfusion/osf_stream.h
b/drivers/iio/opensensorfusion/osf_stream.h
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
