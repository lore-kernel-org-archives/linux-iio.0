Received: from out-2z4y-a139.jellyfish.systems (out-2z4y-a139.jellyfish.systems [198.54.127.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C06D449EA0
	for <linux-iio@vger.kernel.org>; Mon, 31 Aug 2026 16:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788193627; cv=none; b=lReoIBvvjthytlRXF8Je8LrOV32O7Wmgtcoyb3Yowx88WYyNXAMpC3hfCewsgZdUx03q91PCtc3pI7oRbsMf+s8biwwND68IxZEkmq0DkzBjQbNdgmXNgDP+QEQe4LuuIOg8w4IsCEyH6P7hrWY3IbZJo0xQztSxSYRGF1OqoxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788193627; c=relaxed/simple;
	bh=u0ZYjtGavKENeI/zuz5EwiNMeDpPPUy2TMwMLV6oW/Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mX51pRce9jgveaKPhm8gHOhtX2Js3wGa6F8oVjc9ei/ih1nIzzomnwW1WJXGmqG8dyQDvNBTOtgUATflHTxvFW4sg/L0eSQ1WWWTgMH6PtN/KxMGl70qUCbGEcnZNga3JvAcBZ70ljS5QkFsPEJQLsoQxlRwcdh0KIGSqAFyhJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gurudas.dev; spf=pass smtp.mailfrom=gurudas.dev; dkim=pass (2048-bit key) header.d=gurudas.dev header.i=@gurudas.dev header.b=bchoTgCq; arc=none smtp.client-ip=198.54.127.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gurudas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gurudas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gurudas.dev header.i=@gurudas.dev header.b="bchoTgCq"
Received: from [192.168.1.106] (107-194-158-19.lightspeed.sntcca.sbcglobal.net [107.194.158.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4hYZBm0DLxz2xB6;
	Mon, 31 Aug 2026 16:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gurudas.dev;
	s=spacemail; t=1788193617;
	bh=4TrA4xk009bAyQNQJy3hZYrjYVb5oA/qPg/Plwj2IlA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bchoTgCqgtpnzSJgUlUawhsI5ypoQPgCJ2VeLI4l9ZxumhH1LUhDmKRjyjFDAI+nm
	 U5HcFAMV0LCmQt6ARF+0RjY4rLIbB6BOWF53KQmGad6nrj4Vok6X6I729CCljYxTBM
	 ksKDnm5TKJHjvzabxZDu5bH0TfByrIO/zGlL/hNHreZfRqw/xcbbyOIVZnbKYLH1ql
	 aS/+O0eleig1m2jQ0f0tRI2cUJ3Z/bJtTVjXkok7jHqAV02u/YOL7ggeYmz0S2Qu5F
	 AbEtCNhT8CHWPIBzLtkwXrQ5WuRmjToMXIdMtyZ2HXxWAkL2xNIIrao90i4xV/VTeY
	 pN+FVvMLix2Ow==
From: Guru Das Srinagesh <linux@gurudas.dev>
Date: Mon, 31 Aug 2026 09:26:28 -0700
Subject: [PATCH v3 1/3] minmax: Add in_range_inclusive() for inclusive
 range checks
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-minmax-in-range-incl-v3-1-30444a2fd2a5@gurudas.dev>
References: <20260831-minmax-in-range-incl-v3-0-30444a2fd2a5@gurudas.dev>
In-Reply-To: <20260831-minmax-in-range-incl-v3-0-30444a2fd2a5@gurudas.dev>
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

Extend the logic in in_range() to support checking for an inclusive
range [min, max].

The condition in the check is derived as follows, starting from the
in_range() macro with len = (max - min + 1):

    (val - min) <  (max - min + 1) // overflows for [0, U32/U64_MAX]
    (val - min) <= (max - min)     // no overflow

The behaviour of the macro from the signedness perspective is documented
in the kernel-doc and in the in_range_inclusive KUnit test suite.

Assisted-by: Claude-Code:claude-opus-5
Signed-off-by: Guru Das Srinagesh <linux@gurudas.dev>
---
 include/linux/minmax.h | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/include/linux/minmax.h b/include/linux/minmax.h
index a0158db54a04..dce3a8bea9e2 100644
--- a/include/linux/minmax.h
+++ b/include/linux/minmax.h
@@ -299,6 +299,45 @@ static inline bool in_range32(u32 val, u32 start, u32 len)
 	((sizeof(start) | sizeof(len) | sizeof(val)) <= sizeof(u32) ?	\
 		in_range32(val, start, len) : in_range64(val, start, len))
 
+static inline bool in_range_inclusive64(u64 val, u64 min, u64 max)
+{
+	return (val - min) <= (max - min);
+}
+
+static inline bool in_range_inclusive32(u32 val, u32 min, u32 max)
+{
+	return (val - min) <= (max - min);
+}
+
+/**
+ * in_range_inclusive - Determine if a value lies within an inclusive range.
+ * @val: Value to test.
+ * @min: First value in range.
+ * @max: Last value in range.
+ *
+ * This checks if a value lies within the closed range of [@min, @max]. Note that
+ * "range" refers to values counting up from @min with wraparound at
+ * unsigned-datatype max if encountered, continuing on till @max is reached.
+ *
+ * This macro is not a drop-in replacement for "if (val >= min && val <= max)".
+ * Unsigned arithmetic determines what the 'true' range exactly is depending on
+ * whether @min <= @max holds, and in which reading (signed vs unsigned) as follows::
+ *
+ *     Valid in reading   Example    'True' range is
+ *     Both readings      [5, 10]     interval as written in either reading
+ *     Signed only        [-10, 5]    signed interval
+ *     Unsigned only      [5, -10]    unsigned interval
+ *     Neither reading    [-5, -10]   neither; all values except [unsigned(-9), unsigned(-6)]
+ *
+ * The last two cases provide "surprising" results and are to be used carefully, if
+ * at all. Further, if @max = @min - 1, every @val is in range.
+ *
+ * Return: true or false as described above.
+ */
+#define in_range_inclusive(val, min, max)						\
+	((sizeof(val) | sizeof(min) | sizeof(max)) <= sizeof(u32) ?			\
+	 in_range_inclusive32(val, min, max) : in_range_inclusive64(val, min, max))
+
 /**
  * swap - swap values of @a and @b
  * @a: first value

-- 
2.55.0

