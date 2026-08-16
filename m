Received: from out-93wp-a30.jellyfish.systems (out-93wp-a30.jellyfish.systems [104.207.68.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011293C09F3
	for <linux-iio@vger.kernel.org>; Sun, 16 Aug 2026 19:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.207.68.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786908409; cv=none; b=UXsUzyu+2Snt50oqdJvuLA9u3mwG1cXn/bbBhFGuWidKVLMDKS3miTv8hKMuCwao6qWleAlE/6zd1aDrONQ06CccvREi1jncpMT1snvZ87/OpHnTuUf4hF0cGLl7AVY1w6cG98fBDGwKAMTNmShRMQnohGR3RaGKU5kOyqIzdKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786908409; c=relaxed/simple;
	bh=kNJE/p5U/Ut621rcQKUq/XB68draGwrEOaQCAgmxvSI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pRkCWPXhUKLly1gtNvZz80LjzXhRnI1//HPYd5hA4SsLtJb+B/9q/VtD7Q/olxFYG9AdUFs36gqJoe+UULz0wK2pDoeY8/udxESFQjEKMqsZ/yXJ34KV+lyxtRjQ1/qCiK089UIvi+D1R8s0yKPaKxXKrTHKrGJ9HCc6maYd2Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gurudas.dev; spf=pass smtp.mailfrom=gurudas.dev; dkim=pass (2048-bit key) header.d=gurudas.dev header.i=@gurudas.dev header.b=PiUFTqRK; arc=none smtp.client-ip=104.207.68.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gurudas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gurudas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gurudas.dev header.i=@gurudas.dev header.b="PiUFTqRK"
Received: from [192.168.1.104] (107-194-158-19.lightspeed.sntcca.sbcglobal.net [107.194.158.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4hNQtl3sT5z2xBv;
	Sun, 16 Aug 2026 19:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gurudas.dev;
	s=spacemail; t=1786908384;
	bh=0O8s60OxVMHSptmXEcJ3WO3W3gjMt4Y0FZu7UvHQCQA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PiUFTqRKFOlAFdq0lpobv2UHyHSWIrXYIFmuwtzpv2VtQ5c+pK6I5Z05HHafDBw/d
	 PRiqpJKAwRrjjBJrkPMhH3SFcoEw+139NC7oh5J6XCKv6Zyh0WOO48bXj6oV5iFQWe
	 FXpBFY67eH+yV/hSND00klw5Eh9jdOZtzHB4C2XP6JQqUZZif7Vrtg2RRfJGGnXs1z
	 CUyaP8EZjB4Zend7wn52/kpjPlG/eFukJRlmhpY/jYZuoTVe4408neHmYHI5iH/Kmu
	 GvhP6IXXCEIcQgflOF7DlTgxlrWqXAVaNjeYbCcLYFP5ilORBg7pj9jAL6qiWyQT0v
	 4xjGiYdDXbQHQ==
From: Guru Das Srinagesh <linux@gurudas.dev>
Date: Sun, 16 Aug 2026 12:26:20 -0700
Subject: [PATCH v2 1/2] minmax: Add in_range_inclusive() for inclusive
 range checks
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260816-minmax-in-range-incl-v2-1-766f737dd6bf@gurudas.dev>
References: <20260816-minmax-in-range-incl-v2-0-766f737dd6bf@gurudas.dev>
In-Reply-To: <20260816-minmax-in-range-incl-v2-0-766f737dd6bf@gurudas.dev>
To: Alex Lanzano <lanzano.alex@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Gustavo Silva <gustavograzs@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 Guru Das Srinagesh <linux@gurudas.dev>
X-Mailer: b4 0.15.2
X-Envelope-From: linux@gurudas.dev

in_range(val, start, len) takes a start and a length, i.e. a half-open
range. Callers that instead have an inclusive [start, end] bound have
no ready helper to reach for and either hand-roll the comparison or
convert it to in_range()'s (start, len) form themselves.

Add in_range_inclusive(val, start, end) as a direct comparison rather
than a wrapper around in_range(): computing len as end - start + 1 and
forwarding it to in_range() subverts in_range()'s 32-bit/64-bit dispatch
for sub-32-bit types via integer promotion, and overflows to 0 when @end
is the type's maximum value, silently rejecting every input instead of
accepting all of them.

val, start and end are each assigned to a __UNIQUE_ID()-generated
temporary before use, matching the __cmp_once()/__cmp_once_unique()
pattern: each argument is evaluated exactly once, and the temporary
can't be shadowed by a caller's own same-named local variable.

Assisted-by: Claude-Code:claude-sonnet-5
Signed-off-by: Guru Das Srinagesh <linux@gurudas.dev>
---
 include/linux/minmax.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/linux/minmax.h b/include/linux/minmax.h
index a0158db54a04..cb042733f253 100644
--- a/include/linux/minmax.h
+++ b/include/linux/minmax.h
@@ -299,6 +299,25 @@ static inline bool in_range32(u32 val, u32 start, u32 len)
 	((sizeof(start) | sizeof(len) | sizeof(val)) <= sizeof(u32) ?	\
 		in_range32(val, start, len) : in_range64(val, start, len))
 
+#define __in_range_inclusive(val, start, end, uval, ustart, uend) ({	\
+	typeof(val) uval = (val);					\
+	typeof(start) ustart = (start);					\
+	typeof(end) uend = (end);					\
+	uval >= ustart && uval <= uend;					\
+})
+
+/**
+ * in_range_inclusive - Determine if a value lies within an inclusive range.
+ * @val: Value to test.
+ * @start: First value in range.
+ * @end: Last value in range.
+ *
+ * @val, @start and @end are each evaluated exactly once.
+ */
+#define in_range_inclusive(val, start, end)				\
+	__in_range_inclusive(val, start, end, __UNIQUE_ID(val_),	\
+			     __UNIQUE_ID(start_), __UNIQUE_ID(end_))
+
 /**
  * swap - swap values of @a and @b
  * @a: first value

-- 
2.55.0

