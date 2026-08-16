Received: from out-2z4y-a134.jellyfish.systems (out-2z4y-a134.jellyfish.systems [198.54.127.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD55314D18
	for <linux-iio@vger.kernel.org>; Sun, 16 Aug 2026 03:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786850243; cv=none; b=IcYLc1wn2+inqKmhNM6jrEJLrE34LueER8z1Wg8A9MuzXtvKtZaF2QPZNYMRdHIzSC5cAMVMxtSFV84PSXXygADnrCp6IvksxCltD2/jZAfA7Q4TW3diiEqpObFMbKZDznB80E7QpLn4G2etEWu9RO4nUQsO/wXlOeKi2bXwc40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786850243; c=relaxed/simple;
	bh=NHh28Z/L+K1RIQLgI/89sIMruMYooHxghvdx04Ga85E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U4ABgYAJlj2nvCaQODPWHFOp0nKM7w/TURlDSIY4PBc3SbycTqf2d3u+k1TsAP555ufa3V6vzUVMrAaypzcBfMcGqB3ovN7Phi7pCsuNxLlX8eo0m4zvpmVqE/uVxhL2tnU95geGLfoUi07XH/8IumnCdLPLt+Yy54lK5KZ6EAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gurudas.dev; spf=pass smtp.mailfrom=gurudas.dev; dkim=pass (2048-bit key) header.d=gurudas.dev header.i=@gurudas.dev header.b=WtxMlwor; arc=none smtp.client-ip=198.54.127.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gurudas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gurudas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gurudas.dev header.i=@gurudas.dev header.b="WtxMlwor"
Received: from [192.168.1.103] (107-194-158-19.lightspeed.sntcca.sbcglobal.net [107.194.158.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4hN1NT4p99z8sWl;
	Sun, 16 Aug 2026 03:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gurudas.dev;
	s=spacemail; t=1786850235;
	bh=CnYGatwbfHvnqD597S0FvDh1toctwxoutBgYI1Nc/2A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WtxMlworaUQ4BbJQcNBQkTMxr0HSvh0SUJNSu7hvk2jj99qOG7Mure2KkBv3y8pBH
	 hIXQxMYa/DyaN1hLRDLadL8oXAufET0zcN64AAGWMob8M8JJKf1Of58YVrQEF8k1ZG
	 kwSBcdt1hQTHhOWKus3DIj/fqHeWC4zyq1vdUlvJGjcwIo8ER8oeRakfi8569k58zF
	 w3fGo3T3U/RTvaZYaEQlPI66A0AK2GGRqOalMEFjcpcGiRSnbzCNazbVqJAEuBoeRu
	 aFq1eTvePxZ/22tMFWyT940vCUGxpKsoVjGWUD4MxPlcVbzEjCkqtWwKKCBN2sFS7T
	 E701/UVC1pehw==
From: Guru Das Srinagesh <linux@gurudas.dev>
Date: Sat, 15 Aug 2026 20:17:09 -0700
Subject: [PATCH 1/2] minmax: Add in_range_incl() for inclusive range checks
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260815-minmax-in-range-incl-v1-1-a75f7d9ae92e@gurudas.dev>
References: <20260815-minmax-in-range-incl-v1-0-a75f7d9ae92e@gurudas.dev>
In-Reply-To: <20260815-minmax-in-range-incl-v1-0-a75f7d9ae92e@gurudas.dev>
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
no ready helper function/macro to reach for and either hand-roll the
comparison or convert it to in_range()'s (start, len) form themselves.

Add in_range_incl(val, start, end), computing len as end - start + 1
and forwarding to in_range() so it inherits the existing 32-bit/64-bit
type dispatch rather than risking silent truncation from a fresh
hand-rolled comparison.

val, start and end are each assigned to a temporary variable before use,
so each is evaluated exactly once regardless of how many times it
appears in the expansion (matching swap()'s __tmp below).

Assisted-by: Claude-Code:claude-sonnet-5
Signed-off-by: Guru Das Srinagesh <linux@gurudas.dev>
---
 include/linux/minmax.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/include/linux/minmax.h b/include/linux/minmax.h
index a0158db54a04..71900d688a06 100644
--- a/include/linux/minmax.h
+++ b/include/linux/minmax.h
@@ -299,6 +299,27 @@ static inline bool in_range32(u32 val, u32 start, u32 len)
 	((sizeof(start) | sizeof(len) | sizeof(val)) <= sizeof(u32) ?	\
 		in_range32(val, start, len) : in_range64(val, start, len))
 
+/**
+ * in_range_incl - Determine if a value lies within an inclusive range.
+ * @val: Value to test.
+ * @start: First value in range.
+ * @end: Last value in range.
+ *
+ * @val, @start and @end are each evaluated exactly once.
+ *
+ * Same caveats as in_range() apply. In particular, if @end sits at the
+ * maximum value representable by the common type of @start and @end,
+ * "@end - @start + 1" wraps to 0, silently rejecting every @val instead
+ * of accepting all of them. Callers must ensure @end - @start + 1 does
+ * not overflow, and that @end >= @start.
+ */
+#define in_range_incl(val, start, end) ({			\
+	typeof(val) __val = (val);				\
+	typeof(start) __start = (start);			\
+	typeof(end) __end = (end);				\
+	in_range(__val, __start, __end - __start + 1);	\
+})
+
 /**
  * swap - swap values of @a and @b
  * @a: first value

-- 
2.55.0

