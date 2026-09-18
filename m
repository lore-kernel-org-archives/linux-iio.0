Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3A3526AB2
	for <linux-iio@vger.kernel.org>; Fri, 18 Sep 2026 18:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789755946; cv=none; b=IV3kRa9Is0jfYkPfnfWGXqwN9wS4DVSly3Yv7hbWAK6jfNCAc8v4geTa+dIFfxCD896azDKl0yLhkR2BJSvYsvpEjgTRavnOPCjwUWvnpdGHlTKdfPUhEpVMYKrufz85aQBpJ+GaFOyJWC+SzJBm1VuxK+W1H14wsU2ZyqGLDKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789755946; c=relaxed/simple;
	bh=MjMcqz6xoV0VSqRppIZ2oRmAw1qJ2BDvFPFFe5vuq00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZJxsasKyPdrcxuyILETCFHh1pJ4J0G5Ifb/gnqClcT2Ov+BhHIi5aqx+IuDyyNWvRMmFIPieAOKKXUYlgdWeZ3/Fy92zfbZl0Uy20t6LnB46r33zZNgHmk3SxF91SpuXG6eFc5clomLbKEqmxyANia6AoWZ6V9r3HCaXG4KyONg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OIX551gT; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OIX551gT"
Received: by mail-pj2-f43.google.com with SMTP id d9443c01a7336-2d747ec6188so7235685ad.3
        for <linux-iio@vger.kernel.org>; Fri, 18 Sep 2026 11:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789755943; x=1790360743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FW5+Vpv4nV1ZrPbbHCVgHohBuMbLnRMFYjUMGwx4I18=;
        b=OIX551gTwrPFFYz8JuScT1o+oFgUoUYuf6tTdArmXpicvRVvxrOcU5Fr7ce2Spjh2s
         xWQLOFV2EQn4pDkNEbBujCM7yHnM6VFDNS2PsN9SjopD/lEl/t9FFZ+O3DUjlz4s7Miv
         TNxlIRytXtFDt8mrkDAIsJzCwXQ5yRm8Sgbi6WAXfmCmQKPdYMeTSip49+dTl20se+8X
         PTDKE7/ObExqui7x5VCU2wToQWoAUe/s4yZA7bqsm6hekWo9Ny1OsaV9MHd3m26+1aC6
         KoRQI3WMAAhKxBxP1lst9Z+8nVNABgNoSXRwWjNzz4a9hHaJaIDrVtcYlE6IgU45QWuQ
         DVew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789755943; x=1790360743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FW5+Vpv4nV1ZrPbbHCVgHohBuMbLnRMFYjUMGwx4I18=;
        b=RgGnUq+nknH9i20w2eJGVtuEMYZ6M2wzCTA3O0p7HASzg8awZZ/5mnHoYu6JCTnHDI
         8CwOc4QcS46ZKHHNCbbRlKJx5sW7CHxwxqCgZEcVqbHwy/tcGG41wq8vD320sUiWeCC4
         beBd+fvO3teBiBfE27ytHgRa2nUW6qycFM+BjdgkpQVzM5+r+DP1VRK2oC98uRMaQiFe
         /EqcPVs9Iao0IZayhzq1TpxFipH2o3wQ/cmCfWXEUk8Oa2K4o6lgC1wBv5uFx9V2aYMA
         lU/QyaPC2/yFH7F+x7dnkqFC1+MqFuyW3Mdte8LHEIz3ml9xIFeHb7Lf0L7xGR9y/sn6
         d7Nw==
X-Forwarded-Encrypted: i=1; AKwUvBzb7AQdZSwpG+jnJzAK2Rx2QbxgnPZDg4Y94ft0LNGSg6llUTKFP8r/hFszzen1seVBk2AleSlT/ak=@vger.kernel.org
X-Gm-Message-State: AFuF++kZi/Fq9U5yEMJdCUGoKFUFDJYXU0v1/eNQ3efk7S0yS68JFcV+
	BPGGNuFDvSvYehQ8iSLikBwil8lxlsQKkgEU1o8WARyc9+chqJX73sa1
X-Gm-Gg: AYBFou2fzkXIQ1HqU1iWprhCssl2+NgeIQvyxmGhdcqpEdkeME8pV83cHeqUuokBcMd
	1ApEwBD8mDAhEGgfHeGjq5iSViynJKGTf4HlfEFI7UAEY/HgZW1mg9Pptti9Cc+2RdMwphrDu2V
	CW5d+r3psWNAegDX+DL2yoweIDAA81aQW4wrjFkZn5cY0+fvZrbyogZczd8cLxKCEm9po50y2I+
	2o91jw1gezS6YEKBTX/DeuV2jMsBsVqULAM1zPhAkAqRtL5gPzhHhm+I/lE8zJy6ifwMq0pe8jv
	r835qbwddt4MKn0KFYUOaA1AV6XonNOZGAect/TVW9byDCofQ3RcP9x7lsC7KQ2FQNQReDnT8hw
	1v4wdCLOdxONdHAcC5tJkgtCmjxD/1zRsahEuTELBTnc4in7OZnTs4zuCZfCx9CUfDu+4wz8w05
	g8ZZFV3/YF/078nsbXUD2p495mkuTNclA/ovxZKl2H9gmcCasl0TzCRqfp3M24OIPVv7KxG3pp8
	6Ws6t3Q/iYQma1pt75blD6EM4meq+Fhyf5Os/5ssxWUS6Ck78ujIvebJEWKYR9jYuDCkiUSOuBY
	IKET/uPX
X-Received: by 2002:a17:902:f705:b0:2dd:ad74:ac34 with SMTP id d9443c01a7336-2ddb1bbeb4bmr69721235ad.29.1789755943296;
        Fri, 18 Sep 2026 11:25:43 -0700 (PDT)
Received: from DESKTOP-G3E0OSP.localdomain ([58.224.60.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddc16b49casm871895ad.7.2026.09.18.11.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 11:25:42 -0700 (PDT)
From: Jinseob Kim <kimjinseob88@gmail.com>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andriy.shevchenko@intel.com,
	linux-kernel@vger.kernel.org,
	rdunlap@infradead.org,
	joshua.crofts1@gmail.com,
	u.kleine-koenig@baylibre.com,
	julianbraha@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v10 4/8] iio: osf: add validated stream parser
Date: Sat, 19 Sep 2026 03:24:42 +0900
Message-ID: <e9d1f8f8d69b76797d617965f263df97b2b586e0.1789753020.git.kimjinseob88@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1789753020.git.kimjinseob88@gmail.com>
References: <cover.1789753020.git.kimjinseob88@gmail.com>
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
 MAINTAINERS                               |   1 +
 drivers/iio/opensensorfusion/osf_stream.c | 231 ++++++++++++++++++++++
 drivers/iio/opensensorfusion/osf_stream.h |  53 +++++
 3 files changed, 285 insertions(+)
 create mode 100644 drivers/iio/opensensorfusion/osf_stream.c
 create mode 100644 drivers/iio/opensensorfusion/osf_stream.h

diff --git a/MAINTAINERS b/MAINTAINERS
index bf56918efc00..bad05db854cf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20517,6 +20517,7 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/opensensorfusion,osf.yaml
 F:	Documentation/iio/open-sensor-fusion.rst
 F:	drivers/iio/opensensorfusion/osf_protocol.*
+F:	drivers/iio/opensensorfusion/osf_stream.*
 K:	opensensorfusion
 
 OPENCOMPUTE PTP CLOCK DRIVER
diff --git a/drivers/iio/opensensorfusion/osf_stream.c b/drivers/iio/opensensorfusion/osf_stream.c
new file mode 100644
index 000000000000..e262415e69b7
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
diff --git a/drivers/iio/opensensorfusion/osf_stream.h b/drivers/iio/opensensorfusion/osf_stream.h
new file mode 100644
index 000000000000..9087533b2d04
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
-- 
2.43.0

