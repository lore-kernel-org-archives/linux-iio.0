Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792499230;
	b=AxClioS6JmzmHmLlcUu4QYbzJ323V//i3qFZm6M6BetuXFdkiUM3JoGM4BfZfBPHrreN
	 PmCv/OrKenhOeE525LIeNepeUQcf8QJiOViehrG1raaY54970nXbEh7Tmb31o14C+IYC/
	 3/Do2gtRKulG+FN9CgvpMVot6m/ah0gGtLxfObsXzTjSGPDs3lFAuHfXXcI1j5GKJSSPn
	 nf/41qMmMznCO4BPoqB8C+LPXaTOAQiGWeb6sLpfjuK/PsWmU0qKGJRT57AWqDvh2f1WX
	 15j/vb4QdnyzPP7e8jCafQEcHc5q4JVfpSz+NmGQj66zlynd4mU8rcRQbTjn329eFZw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792499230;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=0h82PfgQBbqSHfWyaOJyENOFSzAzo2EdWY4+OAqKu+4=;
	b=ntguU9kp05aN4C0X4acXxhGA/t8J68OQQrvyHa6eGPGdI9skZOawJj7kxdrwMYxmqA7K
	 hdPqyM4wFofH1mDqesglFQpWhSwjd+2ikcCuNiqZESqzoDgrgumyrlpr1pi1Podtr/v/e
	 Uzc5eCFZrwTirZgsH8rMMb8/E3EI6UyWvEx3RuDdoZifDKSy2ASEmEBaFBfIHNDwBOshb
	 NrK06CcCD7SloKaHEiTD+yKxqcCzPUZiYFv/DJbRB0ikt5wz7BkLUQBgh1MWhl7BvWFT5
	 u4dJMBR4G5Ch1JvJXEGrMOYsySUESG+X3pzxTfP5L/LME36B6DPMJAn8ZaNmFWFvC7Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k2x8KSlD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0042606A330;
	Tue, 20 Oct 2026 12:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k2x8KSlD
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792499229;
	b=Uxi3pIP+N/YJ6ymOggJ1EU0FGl9Xkls7DAlV0FQBtRf0MXyMPeLXsdOgNvIocXZSpyDF
	 WzX9apfLVE7XWTH6Eq117spz8UdWPMAhAJe3T7JWzoloAdRecY29WRNG5A6YPMSuWzWMz
	 P2Eb1iD3WZxpDtbVEnhrFONEjM75zoVrfWA1rmMhPqXc0scSc1UGSYx1esJv1999VZDV+
	 RS11+yfkORE2Xw8YIifCkx9vnzn5GFDhhZxEIh9VS84LhmW4/7DSKzFwMIZGKcBoAjq83
	 ht9rMM+fjZyHVYZ7C7/mWkHM53VjYtHqfp8ZwbLRFoqAUhssLbkDS9x7V1OLdmAJi3g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792499229;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=0h82PfgQBbqSHfWyaOJyENOFSzAzo2EdWY4+OAqKu+4=;
	b=s+FZUIAEGW4hc4dtJGBxTiwCZ/QFzPUfsYyRMdcoGZBfspGM+LnikCmiZ1hf12CX2eTd
	 EOye3FTiGLR1PdZ3zwb18dryu5kwf29vIyl1+17QXJ+1B7pwt8ala5hHAZvpcmqfLp2zg
	 XsnCv59cDBHEg1gYdV94nUkNjSlSUL/tZlvZrqB4RbrW42cTQ7dQQgdk36ssh0NxNrvdr
	 Ucmo2AcUBQmLFmmrh3IPMPqX5vYQyqawN784YsXb2+Zt/u+Hn37V9lUbQw41ISy8d1hi6
	 7WTtGZbBugvzsaQ5lzir1nUqEQkWj5TIRMJMn1Y5QHJlFK2BpO3Ra8viTVAKSY0iqiQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C9AFC1F000CE;
	Tue, 20 Oct 2026 12:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792499229;
	bh=0h82PfgQBbqSHfWyaOJyENOFSzAzo2EdWY4+OAqKu+4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=k2x8KSlDIY15IRQ/Fny/YOsXPy1Z4uAaCiuT6U6ywPfR3m3HX4YIUFDN+dFBHGJ4F
	 yaCp5Lh7H3Wn4vMVgg/4rTHM/mBq758snHVy/CR47lt95CKPVQ+CdglzYT8PyFoDf/
	 ml8GsqipP4OX1R6VpfHZ+OGgiA4cws3zlwCgl0rpZgq9tIYTx+Wi+9pnJVMUTf4ODH
	 MltNvlBA4RoHAhFlCMpRc4pG9m2BUPyM+7C3iJphiURLP+HY56SJUUpBo6SKadd7Ib
	 yH05NyN+oC62lWYJ4Zr+FubXNn5YYLsHARa6bwl3JLYzAk46/1YKZuxOJsEkhh+wW1
	 lem2Q5FGhxeGQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 3735043120;
	Tue, 20 Oct 2026 12:27:08 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Tue, 20 Oct 2026 09:26:59 -0300
Subject: [PATCH RFC v3 1/5] lib: kstrtox: support E notation in
 kstrtoudec64() and kstrtodec64()
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
Message-Id: <20261020-e-notation-v3-1-fd385c0fbf65@analog.com>
References: <20261020-e-notation-v3-0-fd385c0fbf65@analog.com>
In-Reply-To: <20261020-e-notation-v3-0-fd385c0fbf65@analog.com>
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792499229; l=3107;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=eebegJE+PnC+75ynxisRvBtIu4ZnW2+u79LG/CGtXp0=;
 b=8JCrrpwhEYIlQwsk5rqPAOJWF2ia/+VnAN7UKwdQQBgICTs497DvEbEVSH/XMj8kMVaKDn8U7
 uOPUooU8wAgADguiPQoWB6d3YoJhYyodheuvA2WezRxKpkvdXH2zhMN
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
are consumed. A negative effective exponent drops integer digits. Digits
beyond the resulting precision are truncated, as before.

The digits are now scanned first and the string termination is checked
before any conversion. A missing or malformed exponent ("1e", "1e+")
returns -EINVAL. An exponent that overflows when added to the scale, or
that makes the result exceed 64 bits, returns -ERANGE.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 lib/kstrtox.c | 71 +++++++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 49 insertions(+), 22 deletions(-)

diff --git a/lib/kstrtox.c b/lib/kstrtox.c
index bac1c057e1b0..730b0c002d44 100644
--- a/lib/kstrtox.c
+++ b/lib/kstrtox.c
@@ -395,41 +395,68 @@ int kstrtobool(const char *s, bool *res)
 }
 EXPORT_SYMBOL(kstrtobool);
 
+static int _skip_digits(const char **s)
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
+	len_int = _skip_digits(&s);
 
 	if (*s == '.')
 		s++; /* skip decimal point */
 
-	rv_frac = _parse_integer(s, 10, &_res, scale, _res);
-	if (rv_frac & KSTRTOX_OVERFLOW)
+	s_frac = s;
+	len_frac = _skip_digits(&s);
+
+	if (!len_int && !len_frac)
+		return -EINVAL;
+
+	if (*s == 'e' || *s == 'E') { /* E Notation */
+		s++;
+		ret = kstrtoint(s, 10, &exp);
+		if (ret)
+			return ret;
+	} else { /* verify termination */
+		if (*s == '\n')
+			s++;
+		if (*s)
+			return -EINVAL;
+	}
+
+	if (check_add_overflow(exp, (int)scale, &exp))
 		return -ERANGE;
-	s += rv_frac;
 
-	/*
-	 * Check input beyond rv_int and rv_frac to cover cases like ".5" with
-	 * scale 0, which is considered a valid input, being parsed as 0.
-	 */
-	if (!rv_int && !rv_frac && !isdigit(*s))
-		return -EINVAL;
+	if (exp < 0) {
+		len_int = max(len_int + exp, 0);
+		exp = 0;
+	}
 
-	while (isdigit(*s)) /* truncate digits */
-		s++;
+	rv = _parse_integer(s_int, 10, &_res, len_int);
+	if (rv & KSTRTOX_OVERFLOW)
+		return -ERANGE;
 
-	if (*s == '\n')
-		s++;
-	if (*s)
-		return -EINVAL;
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


