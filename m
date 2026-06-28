Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAF8313E03
	for <linux-iio@vger.kernel.org>; Sun, 28 Jun 2026 19:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782674077; cv=none; b=N4FykeTSaAGOv+ktjS0Ya4Y1DYHIvxBPY5+WSDaPrKkQiPN7j3n2vz3JO2hT6pThY67cQr5AQEj3BVJr8rWK0vuzpwbassCtl3hbLReX4c5tBW/Z+EC4zhEZHW+F9yVEdv24ON78QlqP4EPElW08iep1NASSwx5CaZrJcWf3swk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782674077; c=relaxed/simple;
	bh=NuS+3+3TYGMxSpMgUHsnkmld7VT2jlfnkEqEyGdY7sE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=enXpSc6mdBM6CHrT8Wro8d28WWvOwXTKLMJSwuQ8U0iRNhNG1SevnoZp7flBS8KHZhljm9QCZHOQJPCHrb9l2o1z3eoM+t/bbrQMbvYMaFJ1trKUvJFY0m3XuPVy/oszkAx2c3NA88PQTvX11knwKuE8OIjlUyAzLe5+AVALQFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EQmAz3KG; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQmAz3KG"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2c825c88744so14992695ad.1
        for <linux-iio@vger.kernel.org>; Sun, 28 Jun 2026 12:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782674075; x=1783278875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E2ivlxlOriivjU5KVldE7/+Mf/JW60VDPxj9Is5GtI0=;
        b=EQmAz3KGyeEpE+W5HBEgxKpDuWU64vWK+YiwUNq0Bl+ugQ6iEwnHPYV1KgEFtUys/C
         rFf5RcwB5Uq4Q6ycIFUsUS/n+Cq07ttalSWHYabwbUy/Twr34vZloyxnTn44bc9+TpAF
         0EyAQDCYqY9jNXJT04pW69ZfAjgbEUAs9LfOjeikC8aMQVSabYY8Gx2kzGf6w/yS5/iE
         UfzI3EDRiRXdnDwYbEKIOyqhmVnUbymLOMUqqsflwg7CSLpPuOWu+IWeGzgLPinsd7r2
         5hbR99ToUomoDuWF0rHqWaxhxVaSMwFZ7h9tmEShcFyUOJgcmyiWsEiFsGsjKL9PWeKM
         NxPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782674075; x=1783278875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E2ivlxlOriivjU5KVldE7/+Mf/JW60VDPxj9Is5GtI0=;
        b=cSC/pyyMoaB2GJAiRskOPaX3/5G/IIc4I7WGwKIvsZ0ROTU3OZ2vQ/qWwttxUv9Qr2
         1Bdc9te6gHOzdYDMB3PAmBYZRe+KomAJ3UMILQ5pBa2ZWTYmZwOwXnOs87Jp/ZomfkU8
         9ZFNtfPa4JwEhqeac8e5UL9sbNgK/JRZdsN9VYjBUP69+VJ7tYhbekXRg4Zx+8MQ0IUP
         wfN93hNs2xrS/bzBySlTLi1fl8xbV772GuGKXWS8HziIadITDtvYgfeuIG2ptqVMjQ6x
         i1iRVsytZB4f6XUa8/TNxOCDjvIQKJ75lP6p0Sd0yDCM3TNdVVHBZ7q3DNYnQxdnTbc4
         CytA==
X-Forwarded-Encrypted: i=1; AHgh+Rrw41HOD5UUtsKP+4KoS4G3M9r35MHAe2Gv/Ot6YN7439sGs+gx52e3YipSYLhGJF1hQ0rM6jWneDk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxcf3GPfgtUPb//9qM975/7EAZRS8ML35LSWmHjcyyV09A+bEcg
	L8TZ6qmwunaBNZm8dnpsQKJ5WwiGI+VERxjfveU0AelT2ZBzacQdFMIl
X-Gm-Gg: AfdE7cmDV8eqHHuwa3VXHDDF4PWeYK7sXAd4A69PckueR9r6feAjrxHd7Y8LtSnDDfw
	4ji9ckF14KdfXs9jmrim4zCGxDvplTmYHwQT/E8f9Ls9UWoexkc08ylfUXdRbTfVCAc07TqqIv6
	pkGrpCGUXvcP2qWaddfa8m6KAdlcMKV1iMyvc1AZiIz/73OyITqerfZy16PC3G775wH2HlbqxYB
	gt59xBQ4Wr24XlWb0mKugUShW9AR8hzlw/f3WyoMoEUTPDAItWDiFN0OunOvHxQDfgWqzqsSiDq
	yTpAWD7TB75qiXWUIFkpoK8/8kBU5nobm4HEKpdKAsL4dwyCY2qb2CbGh9aCLBOLk4Ql3Y0j2pG
	xU09HZvzR97pdWKPDu9lCiWueLMzcxaBMHQIXsCCebKxbietTBJDmOf1lbfP+owDI5FKFahICk9
	/v+J9+6n311gGSDcMq2+bPrGcNADq3flAxcD4fxFe3zkUGwGdgn7nehzWWmWjFlXKjnKkKAOVMm
	PieaVE32al0u1t+IAucbKf4A04M
X-Received: by 2002:a17:902:ff8e:b0:2c9:cf41:adf9 with SMTP id d9443c01a7336-2c9cf41b14fmr37647505ad.47.1782674074904;
        Sun, 28 Jun 2026 12:14:34 -0700 (PDT)
Received: from DESKTOP-G3E0OSP.localdomain ([112.172.255.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca0b454815sm1354385ad.2.2026.06.28.12.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 12:14:34 -0700 (PDT)
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
	Jinseob Kim <kimjinseob88@gmail.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC v6 4/5] iio: osf: add authenticated stream parser
Date: Mon, 29 Jun 2026 04:13:36 +0900
Message-ID: <20260628191337.937-5-kimjinseob88@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260628191337.937-1-kimjinseob88@gmail.com>
References: <20260628191337.937-1-kimjinseob88@gmail.com>
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
candidate frames to the core decoder.

Rejected candidate frames drop only the current head byte before
resynchronizing, so a corrupted unauthenticated payload length cannot
make the parser skip later valid frames.

Signed-off-by: Jinseob Kim <kimjinseob88@gmail.com>
---
 MAINTAINERS                               |   1 +
 drivers/iio/opensensorfusion/osf_stream.c | 189 ++++++++++++++++++++++
 drivers/iio/opensensorfusion/osf_stream.h |  31 ++++
 3 files changed, 221 insertions(+)
 create mode 100644 drivers/iio/opensensorfusion/osf_stream.c
 create mode 100644 drivers/iio/opensensorfusion/osf_stream.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 32d3e7674..3d4199d9e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20017,6 +20017,7 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/opensensorfusion,osf.yaml
 F:	Documentation/iio/open-sensor-fusion.rst
 F:	drivers/iio/opensensorfusion/osf_protocol.*
+F:	drivers/iio/opensensorfusion/osf_stream.*
 K:	opensensorfusion
 
 OPENCOMPUTE PTP CLOCK DRIVER
diff --git a/drivers/iio/opensensorfusion/osf_stream.c b/drivers/iio/opensensorfusion/osf_stream.c
new file mode 100644
index 000000000..470b4ec1f
--- /dev/null
+++ b/drivers/iio/opensensorfusion/osf_stream.c
@@ -0,0 +1,189 @@
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
+		if (stream->len < OSF_FRAME_HEADER_LEN)
+			break;
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
+		if (stream->len < frame_len)
+			break;
+
+		ret = osf_core_receive_frame(stream->osf, stream->buf, frame_len);
+		if (ret) {
+			if (ret == -EBADMSG)
+				stream->stats.bad_crc_frames++;
+
+			/*
+			 * Until the decoder accepts the frame, payload_len is
+			 * untrusted. Drop only the current head and resynchronize.
+			 */
+			stream->stats.dropped_bytes++;
+			osf_stream_drop_invalid_head(stream);
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

