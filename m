Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DCB3382C8
	for <linux-iio@vger.kernel.org>; Sun,  7 Jun 2026 23:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780875929; cv=none; b=LEpWETpPBtKcmisOPwJEU4ookMOLDbo1iK1+75deoUKL9ZHbWULIdtv+EEX70nF2RNV1stuX6d0phkiEaBJuLedhwHUl0Az2M14L7Got/BpemTHktyHpfoIEButlWGB3YZmVDdyUX6tCkJNWpzS0AIKZ2UcM4TUjc/AvoxPgTog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780875929; c=relaxed/simple;
	bh=KJTRCy7wNY+N6IrE/mRVGcB/+axShhI0D7cUwSRv3Es=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fuyme3PwUJOKsCpC2yvPSBCj14lDurB1iFdNc1NAAIGXmW7YYhz1jpxgRwLVCI1OHS3f63n0PEwNiVcze58WV3dPhW/5+AcFrA3WzCF7D9gMJ6t7eKfwOMTLqDU0fAy3vYxNiVPIdJZA2moh4mESU92mtrMUfv7ONSBq90l+Shk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NfXaCEIz; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NfXaCEIz"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-84229481d44so1368610b3a.0
        for <linux-iio@vger.kernel.org>; Sun, 07 Jun 2026 16:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780875927; x=1781480727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TaQl7dtgCPoeeJ0ksgq85IpZKAoo0yYD7cImexjDLms=;
        b=NfXaCEIzgPw9KMgLquOrieq1tveEjSb1X+Osk33RZeynIwunbKnR+mjfEhLYS0smB0
         2tnklm4n7mrS2qtsI2lMcDCPf5KFq46B4OsHHwO8+DHQWtpc4ccoXWi0rHxdwwQ7cmee
         aCRmpSq1ZGkXqWgq3mFOtuDc+cX/08mbTAzQFkdrt48q8CEza4MgJJy2zu0Zu8BtJI1C
         ngFpXkBSRrQhXD0pr8GbD/IzoDHVnTb+s2dXqrD5tsGkJZy6VhDNr1EMqy/P+OuE5iXS
         raUCeAZh4BiMb8VZj7btGI2iKdSAQCcX4xF5Hky7MQEEi81jbdzNQctkookv5ougt3Ry
         nkJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780875927; x=1781480727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TaQl7dtgCPoeeJ0ksgq85IpZKAoo0yYD7cImexjDLms=;
        b=GM9yv6MKin7aKJIJrJxWnBb4Z2TlwPEu95kWnnoamACArBoqnn+Pigxpq9AJr7NpJ+
         QIJhptNqmERx3VquviUpgeJbhEK4tTlITMDwOQPQGl/CSjN9xYZKefM4F64Sy1QPAxlo
         KW9+CmnjQU1d/YpoVloINGmuOguUjhGs9cWOsz9eN9GUOWcsCf60tTg0P87wqHqr2X+d
         LucaUQXh0bIwwiOXqJhXYctDu+sklSc2jYU3P8MiVPKflsyuxhw2giq6nrGFRHWu8EhP
         9hhOD1dhPcfEute5uE7aieoRMTMn/g1ygiXV5L7iKED7RwR1aBgezcmS0Dg0JVyuEXvP
         JPog==
X-Forwarded-Encrypted: i=1; AFNElJ+SYyIGh0wMhtmOFzqC/K9q3hOvo9XITMHnohYi+6438D6XYJD2cXBV7BmK8EL9m1u7m3tUMph/3IU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjTppGDOoBN+vvXH9Afx/CHadJtEDIDlPxl3fW305qHpk6YMBr
	I5xATow1I7FwioqICLedpLpJD4DrscbwmMcQYKhcCT+7qGUOvUPHZJDX
X-Gm-Gg: Acq92OHm6HQrtCr3VAwV/VSrtMYezHJkpBdx9w7YM3ppcsAwa4Ww/VtGSLk+xRLCjma
	MVnBA/OFwiyb1aqyqDjvpk+VzrgOvYupDIm1nyMO6BxJvGx0OgeF30RWulEF8Ad3IJ1qjABg4Zi
	M2yW4soC6Xkkh02jfht1iQR0Jzdw4kStmDR3itxBGO/QPqamYI/HDcfP4p9CH3X3V/sUwHIexi+
	FV38buipVF/s8a6Is3Hz2aV5PDHGpsnSdxtBcqXynFYdzzeQfmK8D5Tl9KW3MJU3URQt89vCS+R
	GbzsfrYjrjjRqqDXYeomaN7yqLwY2pir9IolUmqHUQ2NDH70KWt57wCB6/4tUoYbr2su9bElm72
	UiozfUhnLvfJMOzV7Sx4VO9G0Bo1Kihk4QSLf+oJZBb/Vt9+0v+UJWmXvYEJqzVs7N3AZVvUvUc
	t/dGkCwK6TYPuVZ4wMUiFPfo2D+bedAaGPC2l4hX03GOkOwRl0i3d2sQ534bwWGr5CZb8BDKr0M
	N5sc9AxGppKBpatYN5Ul0stmoVU+OHgMNJAO27StWVGvu0K
X-Received: by 2002:a05:6a00:3d4a:b0:842:5712:c2c2 with SMTP id d2e1a72fcca58-842b0fb6d60mr11804229b3a.41.1780875927308;
        Sun, 07 Jun 2026 16:45:27 -0700 (PDT)
Received: from DESKTOP-G3E0OSP.localdomain ([112.172.255.242])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842828d6bd1sm19257732b3a.44.2026.06.07.16.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 16:45:27 -0700 (PDT)
From: Jinseob Kim <kimjinseob88@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH RFC v4 4/6] iio: osf: add stream parser
Date: Mon,  8 Jun 2026 08:43:41 +0900
Message-ID: <20260607234343.22109-5-kimjinseob88@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260607234343.22109-1-kimjinseob88@gmail.com>
References: <20260607234343.22109-1-kimjinseob88@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Keep the parser focused on frame assembly.

Let the core decode complete frames once.

Signed-off-by: Jinseob Kim <kimjinseob88@gmail.com>
---
 drivers/iio/opensensorfusion/osf_stream.c | 38 ++++++-----------------
 1 file changed, 9 insertions(+), 29 deletions(-)

diff --git a/drivers/iio/opensensorfusion/osf_stream.c b/drivers/iio/opensensorfusion/osf_stream.c
index a2739c987..957f73716 100644
--- a/drivers/iio/opensensorfusion/osf_stream.c
+++ b/drivers/iio/opensensorfusion/osf_stream.c
@@ -62,8 +62,6 @@ static size_t osf_stream_discard_to_magic(struct osf_stream *stream)
 
 static int osf_stream_process(struct osf_stream *stream)
 {
-	struct osf_frame frame;
-	size_t decoded_len;
 	size_t discarded;
 	size_t frame_len;
 	u32 payload_len;
@@ -82,10 +80,8 @@ static int osf_stream_process(struct osf_stream *stream)
 		if (!stream->len)
 			break;
 
-		if (stream->len < OSF_FRAME_HEADER_LEN) {
-			stream->stats.partial_frames++;
+		if (stream->len < OSF_FRAME_HEADER_LEN)
 			break;
-		}
 
 		if (get_unaligned_le16(stream->buf + 6) !=
 		    OSF_FRAME_HEADER_LEN) {
@@ -106,34 +102,18 @@ static int osf_stream_process(struct osf_stream *stream)
 		}
 
 		frame_len = OSF_FRAME_HEADER_LEN + payload_len + OSF_FRAME_CRC_LEN;
-		if (stream->len < frame_len) {
-			stream->stats.partial_frames++;
+		if (stream->len < frame_len)
 			break;
-		}
-
-		ret = osf_protocol_decode_frame(stream->buf, frame_len, &frame,
-						&decoded_len);
-		if (ret) {
-			if (ret == -EBADMSG)
-				stream->stats.bad_crc_frames++;
-			stream->stats.dropped_bytes++;
-			osf_stream_drop_invalid_head(stream);
-			if (!first_err)
-				first_err = ret;
-			continue;
-		}
-
-		if (decoded_len != frame_len) {
-			stream->stats.dropped_bytes++;
-			osf_stream_drop_invalid_head(stream);
-			if (!first_err)
-				first_err = -EMSGSIZE;
-			continue;
-		}
 
 		ret = osf_core_receive_frame(stream->osf, stream->buf, frame_len);
 		if (ret) {
-			osf_stream_discard(stream, frame_len);
+			if (ret == -EBADMSG) {
+				stream->stats.bad_crc_frames++;
+				stream->stats.dropped_bytes++;
+				osf_stream_drop_invalid_head(stream);
+			} else {
+				osf_stream_discard(stream, frame_len);
+			}
 			if (!first_err)
 				first_err = ret;
 			continue;
-- 
2.43.0

