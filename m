Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794665401;
	b=tkLicE1hevtoS+JQjJLCHyYuJ93JLwRJqw4duI0oJBW/FD4Zt24z/RjdrkLNZHZpwnkH
	 IIsGwmJloOQA+2LfIO47HuM84zrgJu/EhJDEK6d8qz+J9NztB+j3L30rBR86R4b90m00i
	 9YjGdORViOr5MMXBIeXmz+1y/EtfqFAiTf/SYCp/YJMLnuVQ6rX+yPYb+4EBl4r3aSAAj
	 hB/dr4f8cIwyaDXrcAzWzltZe1uA8QxynQIoNAUa29Dmku/pnssl7kuV9lH80MCsBL4bm
	 tZgM8ATUNPdB1QKnM/m60m/I+BCQAgBH3WGIfN2Pe0Id/jfTMEDHm6+mxPp61VjIh+A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794665401;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=2s34LzMehDUpe/U13xTM9iVeSRtjf1Y8OjwwEYUdPa4=;
	b=OHuctmWmPHfiv9rWjVRJvWZ8aLG4l8epusTsCMUB7e1b+C/0y88h5ZAUks3vLFT9VS2+
	 bxTuSsIDClHz1G4LzGY58qRhBekeWtxQ0XTTt8Ot8LHMbGmjih4/rdSEP4SMKwTfrEMUC
	 kYxtGP5k9MlyT+lp7cF52oEZqITY2/Xoji5BEL653BDG2d0vLTu+C5siTNSVPDvbxx6tq
	 bIHufVUfjgaDRhLcIpePQRTX9o4IK99Jm16dO8sRHsXTUY2xUXPpAg9gxVE6d8OjjglBp
	 L+2aK/3PYPOPMK61lD9d76Depfn2g2qeNMGkHokLIy2M6IAXjZC4sP/GiaiqdbpGe1g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RO1tNiLb;
	arc=fail smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E50C606A327;
	Sat, 14 Nov 2026 14:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RO1tNiLb
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794665400;
	b=DeTspH94pYDE0j16Dne40P9RrKqR7/De0vOyYE6vJhsgECAkBRHO7MHxNJ66O1cw379O
	 aMb6aZkaXrniq/FBR3VVGVUup3OXE/HjVyptmRoj280bHOGVSj0reY+TDNpY/NOW3u1FC
	 hvZBGHZdMUEYd3Appy9e2Fk0mXIx9Iq77zBBkwHUCqb/TziTBrOQ7S3G3B/xgeIwB8Ny/
	 M9bUBy7FAdfy3BlDMIzqnI2fATbKZBYnYQP5Q0LpoXMDJA1DMKPG3ts5fn5n/YMVabfZS
	 MsajVB7iTYK0OZ23ZC6k0T+5K+l/9b1Ct80HoGVYfNigmfhEWtMJto2d1UCev9Wq+3A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794665400;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=2s34LzMehDUpe/U13xTM9iVeSRtjf1Y8OjwwEYUdPa4=;
	b=lTBt2G3v1Y+hzYSItdiuQOkCWXVjxLmCsVUWOLQu70HFmixOo8fm2/IDGfgs3Xm42LvZ
	 jBP6xanfdtetNfBdit5SFUWNye2UlSANvoLOIKY7USwYEc76MUGBAyfvr6MA91qMpY1kQ
	 wtJfwOS+KrtglXj4lHS0sXIcCLOyqp03iFWNbyNq+cycuRNn7XNBP0N/nnqz8PrjCr9Pl
	 G85d2p6503DbWc6TanFmnQESaMsOuUTenmr/GID6qzC91S1mm4Ct7xYA5b1Z6SZyJIgyz
	 A3sR+9XpemPo3wuelnUzLLk9K/JhR1RKHfr/WvnSUjagfr1eqM4Jw/vf8eIlxxIguZw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id F27371F000C5;
	Sat, 14 Nov 2026 14:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794665400;
	bh=2s34LzMehDUpe/U13xTM9iVeSRtjf1Y8OjwwEYUdPa4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=RO1tNiLb5QvowihATz+RHk5Ln4hkbxCKDWZHhq7xouVuqnEUaoR/OQnVDV441M1sd
	 WxmV4SlWAXBx9/3DKkOV4ZM+fh22vy9UeIEY+v9BeFL7ZtPY7XtK5c0bLzfYcoQQR8
	 NRgPE3BrU5o8V3XUkRNCiqWMLSAwgeUW2gJuAIrZIGkWdEmcpym6lK0J332xo+y7q5
	 Nw2qD4+tKkKspGtLrhCipGAbi1IJIsNIcoxE+a7rMCdDy9BoDdXoZqp21k5hgTos15
	 Kb3WkPsve1EuZIHa9ZXgcklZsr1t56+YD/FnRYg0Et0cjzQKe78B8cu8DJSVAnUN4m
	 wihiM1qOnHJ7g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 7AC0A49DDA;
	Sat, 14 Nov 2026 14:09:59 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Sat, 14 Nov 2026 14:09:53 +0000
Subject: [PATCH v6 1/7] lib: kstrtox: support E notation in kstrtoudec64()
 and kstrtodec64()
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261114-e-notation-v6-1-205ca9a1438a@analog.com>
References: <20261114-e-notation-v6-0-205ca9a1438a@analog.com>
In-Reply-To: <20261114-e-notation-v6-0-205ca9a1438a@analog.com>
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794665398; l=3052;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=kN5sHtdSNqiEelslYEeblS5GAeoqa616PDYicm/1NJs=;
 b=R2sADFAULyjSQMsvZPoUb94Pht0swzFQhnrE2v8uvDrZfLF7VtVEOvQPcwBnDYZooMTxo82Bb
 MZXlSasiuQVD6Ge3zn8HGVMwvF5UP4KlB/7NqUNWXqcHQenOrPWf1nF
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com
Content-Transfer-Encoding: 7bit

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Allow decimal strings to carry an exponent suffix, such as "2.7e10" or
"271828e-5", in kstrtoudec64() and kstrtodec64(). The exponent is added
to the requested scale to work out how many integer and fractional digits
are consumed. A negative effective exponent drops integer digits.

The digits are now scanned first and the string termination is checked
before any conversion. A missing or malformed exponent ("1e", "1e+")
returns -EINVAL. An exponent that overflows when added to the scale, or
that makes the result exceed 64 bits, returns -ERANGE.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 lib/kstrtox.c | 69 +++++++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 48 insertions(+), 21 deletions(-)

diff --git a/lib/kstrtox.c b/lib/kstrtox.c
index 1b3f0d3fff37..4341e4cec1c8 100644
--- a/lib/kstrtox.c
+++ b/lib/kstrtox.c
@@ -395,41 +395,68 @@ int kstrtobool(const char *s, bool *res)
 }
 EXPORT_SYMBOL(kstrtobool);
 
+static int skip_and_count_digits(const char **s)
+{
+	const char *start = *s;
+
+	while (isdigit(**s))
+		(*s)++;
+
+	return *s - start;
+}
+
 static int _kstrtoudec64(const char *s, unsigned int scale, u64 *res)
 {
-	unsigned int rv_int, rv_frac;
+	const char *s_int, *s_frac;
+	int len_int, len_frac;
+	unsigned int rv;
 	u64 _res = 0;
+	int exp = 0;
+	int ret;
 
-	rv_int = _parse_integer(s, 10, &_res);
-	if (rv_int & KSTRTOX_OVERFLOW)
-		return -ERANGE;
-	s += rv_int;
+	s_int = s;
+	len_int = skip_and_count_digits(&s);
 
 	if (*s == '.')
 		s++; /* skip decimal point */
 
-	rv_frac = _parse_integer(s, 10, &_res, scale, _res);
-	if (rv_frac & KSTRTOX_OVERFLOW)
-		return -ERANGE;
-	s += rv_frac;
+	s_frac = s;
+	len_frac = skip_and_count_digits(&s);
 
-	/*
-	 * Check input beyond rv_int and rv_frac to cover cases like ".5" with
-	 * scale 0, which is considered a valid input, being parsed as 0.
-	 */
-	if (!rv_int && !rv_frac && !isdigit(*s))
+	if (!len_int && !len_frac)
 		return -EINVAL;
 
-	while (isdigit(*s)) /* truncate digits */
+	if (_tolower(*s) == 'e') { /* E Notation */
 		s++;
+		ret = kstrtoint(s, 10, &exp);
+		if (ret)
+			return ret;
+	} else { /* verify termination */
+		if (*s == '\n')
+			s++;
+		if (*s)
+			return -EINVAL;
+	}
 
-	if (*s == '\n')
-		s++;
-	if (*s)
-		return -EINVAL;
+	if (check_add_overflow(exp, scale, &exp))
+		return -ERANGE;
+
+	if (exp < 0) {
+		len_int = max(len_int + exp, 0);
+		exp = 0;
+	}
+
+	rv = _parse_integer(s_int, 10, &_res, len_int);
+	if (rv & KSTRTOX_OVERFLOW)
+		return -ERANGE;
+
+	rv = _parse_integer(s_frac, 10, &_res, exp, _res);
+	if (rv & KSTRTOX_OVERFLOW)
+		return -ERANGE;
 
-	if (_res && ((scale - rv_frac) > 19 /* log10(2^64) = 19.26 */ ||
-		     check_mul_overflow(_res, int_pow(10, scale - rv_frac), &_res)))
+	exp -= rv;
+	if (_res && (exp > 19 /* log10(2^64) = 19.26 */ ||
+		     check_mul_overflow(_res, int_pow(10, exp), &_res)))
 		return -ERANGE;
 
 	*res = _res;

-- 
2.43.0


