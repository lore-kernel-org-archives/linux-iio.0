Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794665402;
	b=gDkvvrJxq7U9+KS0IAUjkmPGJCBFCrX2yCxgPvRau1aAarDbzdTXBF6Y6O8igPhVO+21
	 EdOkhfuNigsfBzsnk7vee4XzB9caOXJMZlXTdgxUMFFg3gfRLBV/S08r7pc1SiZGKT/L5
	 8ysfGTbo2T2BUF695dIrKyu6EaSnbgrEv6sctLgeoLe4Poizk1RQCVuOUS6mWVMtr3Fg0
	 huRxdrAWZh3XZPKKc2r6xMzzSGFQx0yqBynsLgjIfdSCiFWUSYUwcjMcSUqQS9qfDAVv+
	 DBJ3TJcyd98XuqM0X0X5TSDslsaovAhruwq2ykGRZ+wAWLM7RqJ6qAH+QbSPj8ruu+g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794665402;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=I+o7fn4Xi40F4aTgkVoEJlD0ZAwKqae1lOOgUTDSbC8=;
	b=ZkT1fJkMSIrFTR1OPWsQ8TMZJGCq1XtiahW8TEY4LvTjVYkKal2heY2u+AZs3ELFXCCU
	 n6I5tXi0CAGXdQ/c9exmrw3gwt9ZTKYSQZudG8n0f7RlmRBWXZndqnBJrOTvExEpwuFxD
	 2uuyMm+dW3mPjzyPfS5j11Jw68JlK1pO4MlS5etJDguPS4ubl3z7mWMn2hgtXnzeaCUhm
	 JXTOQfJ2hgckhABdx7P+q4mqaJ11AFbFR8tMCVxNYQWUQ2uvqTYUHl19rURWL8/ro2QQ9
	 smVYdWpy05sP01nbXKIvKBV9UNB9CuKftZND+c+TsVMoVA+mgSzYIZQDAFWoqv1UHSA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=km80JTmd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1BE606A880;
	Sat, 14 Nov 2026 14:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=km80JTmd
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794665402;
	b=SWI18KkPnOwpwqnGMq7xeM/oraEqVvham61/osqcsGtE9pC49pKUWIVH/dQFXQjVCV6l
	 BMkPTpXLFlCM+58DanTCnobYOigftWRrPT8wbOS/oF1ngj1EZ7dP3AFzOfGQgPCrNTUcG
	 XsWDq8Y3pZ+lYAsKutaWvkUgG6YzO6XFZ4Zhl0/nlhxGlkRy5zqWQ5igZosApXOopEsp2
	 6Ae+9Gtwdr5mTRaVb+66pR0Jzf1f295qhjZ5VojORBKl/jzjBefsMldUW3Y8xrXsIyToG
	 WJB4/w5JC2kOYgStU9TYivEMA+qeNX7zuvVo6saRoE4Zzvjdq9UTHpRW1qLNQCn10sA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794665402;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=I+o7fn4Xi40F4aTgkVoEJlD0ZAwKqae1lOOgUTDSbC8=;
	b=OjP4alNwBDm7cdFmf2vNjOLfogTbm/tQLhtWTB37/XTFuKvS+bGwilsvmQhqWzmAqjfl
	 sDCkvnsZMIAGhWb8Nz6DrelGdtxNSEUlFlpWEKGxJG1ZsM1VfGiJ1zEhnPEk9ii9fl1wS
	 /5dr/gMTtNLaSg62d8US1Np/mh1OPGsAZFKfmaVpktpzjxcvZ4WiZ/bd5NXSWp+mGekRS
	 HYJHh4oUjctY3M+I7rUJfEODBsvoA7YK3IMdtz99oUiJRR3UWrLgNyip3aEbxI9/vFNY/
	 847q0L9QS5w0j3G4dl1t5jjlJFazRr1omO6PuF3b9HhJQq9TNAwZAVSYHF8ELXFERhA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 165DA1F000C6;
	Sat, 14 Nov 2026 14:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794665402;
	bh=I+o7fn4Xi40F4aTgkVoEJlD0ZAwKqae1lOOgUTDSbC8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=km80JTmdQoNTPR8xbhGGjC5yhT6/sFBVZJfAHtdKUQAvZxW33m1t/4UIvN9WL2v+5
	 ZyAYAHdk5xPc7MBH1Fs/qq2AzGP1M2zTGOOyhIjicj1b1xuwdjawB5Zea9ZKxd7r74
	 1O6+C54e4bEaIa6s5WQTPiCsFX/FMIsYCdLQoOH8cnE+kBlZDQhPI11ObEuQMidudH
	 XGjRufReZzVW8z+CmKRfuYhkgQ23YSjop9X4lsK9T0vbdb2pvn7Tiy7+S2YzFWcb2R
	 3E1SRe2kHIX+kpxeDRI28j9uMt7gBUqi0MLSb8fmbRVHzJVS/xw6jIZrQwPC8SM7Rz
	 CNpIFczmVWMjA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 9081849DEC;
	Sat, 14 Nov 2026 14:09:59 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Sat, 14 Nov 2026 14:09:54 +0000
Subject: [PATCH v6 2/7] lib: kstrtox: round to nearest, ties to even in
 kstrto[u]dec64()
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
Message-Id: <20261114-e-notation-v6-2-205ca9a1438a@analog.com>
References: <20261114-e-notation-v6-0-205ca9a1438a@analog.com>
In-Reply-To: <20261114-e-notation-v6-0-205ca9a1438a@analog.com>
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794665398; l=8166;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=scyZwro+u7sqhzonXs9Nh8pZhA6YdfMjHj8TdDCPqu4=;
 b=GVuwQK3rpxGbzI6FRZPP6GYV93EVMW970q9GvRjh+h1BCeZjGH65pdm7catUiejNiucJA4jRh
 Q/zlCxTwSmwBEKfbLjfVSiI8BasgRVIDMMrWWBri526pdlE5GrGf+VH
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com
Content-Transfer-Encoding: 7bit

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

kstrtoudec64() and kstrtodec64() drop the digits beyond the requested
scale, which truncates the result toward zero. The error is up to one
unit in the last place and is always in the same direction.

This is easy to hit with values produced by userspace floating point
formatting. Printing 0.3 with "%.17g" gives "0.29999999999999999",
which is parsed as 299999 with a scale of 6 instead of 300000. With E
notation a negative exponent can also drop integer digits, so "19e-1"
with a scale of 0 gives 1 instead of 2. The same applies to negative
values: "-19e-1" with a scale of 0 gives -1 instead of -2.

Round the result to nearest instead, with ties to even. This is the
IEEE 754 default rounding mode, as used by strtod() and printf(), and it
does not bias results in either direction. The first discarded digit is
known from where parsing stopped, so no extra pass over the string is
needed: the remaining digits are only checked when the first discarded
digit is a 5. Since round-half-even is symmetric, kstrtodec64() keeps
rounding the magnitude and negates it.

Inputs that fit within the scale are parsed exactly as before. An input
that rounds up past the type limit, such as "18446744073.7095516155"
with a scale of 9, now returns -ERANGE.

Update the existing truncation test cases and add cases for ties and
for rounding at the type limits.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 lib/kstrtox.c      | 46 ++++++++++++++++++++++++++++++++++++++++------
 lib/test-kstrtox.c | 48 +++++++++++++++++++++++++++++++++++-------------
 2 files changed, 75 insertions(+), 19 deletions(-)

diff --git a/lib/kstrtox.c b/lib/kstrtox.c
index 4341e4cec1c8..4c1ec9223d63 100644
--- a/lib/kstrtox.c
+++ b/lib/kstrtox.c
@@ -405,9 +405,28 @@ static int skip_and_count_digits(const char **s)
 	return *s - start;
 }
 
+static u64 round_half_even(const char *p, const char *end, u64 res)
+{
+	if (p == end)
+		return 0;
+
+	if (*p < '5')
+		return 0;
+	if (*p > '5')
+		return 1;
+
+	/* tie: any nonzero digit after it breaks it, skipping the decimal point */
+	while (++p < end) {
+		if (*p != '0' && *p != '.')
+			return 1;
+	}
+
+	return res & 1;
+}
+
 static int _kstrtoudec64(const char *s, unsigned int scale, u64 *res)
 {
-	const char *s_int, *s_frac;
+	const char *s_int, *s_frac, *s_end, *s_round;
 	int len_int, len_frac;
 	unsigned int rv;
 	u64 _res = 0;
@@ -422,6 +441,7 @@ static int _kstrtoudec64(const char *s, unsigned int scale, u64 *res)
 
 	s_frac = s;
 	len_frac = skip_and_count_digits(&s);
+	s_end = s;
 
 	if (!len_int && !len_frac)
 		return -EINVAL;
@@ -442,8 +462,16 @@ static int _kstrtoudec64(const char *s, unsigned int scale, u64 *res)
 		return -ERANGE;
 
 	if (exp < 0) {
-		len_int = max(len_int + exp, 0);
+		len_int += exp;
 		exp = 0;
+		if (len_int < 0) {
+			s_round = s_end;
+			len_int = 0;
+		} else {
+			s_round = s_int + len_int;
+		}
+	} else {
+		s_round = s_frac;
 	}
 
 	rv = _parse_integer(s_int, 10, &_res, len_int);
@@ -454,6 +482,10 @@ static int _kstrtoudec64(const char *s, unsigned int scale, u64 *res)
 	if (rv & KSTRTOX_OVERFLOW)
 		return -ERANGE;
 
+	s_round += rv;
+	if (check_add_overflow(_res, round_half_even(s_round, s_end, _res), &_res))
+		return -ERANGE;
+
 	exp -= rv;
 	if (_res && (exp > 19 /* log10(2^64) = 19.26 */ ||
 		     check_mul_overflow(_res, int_pow(10, exp), &_res)))
@@ -473,7 +505,8 @@ static int _kstrtoudec64(const char *s, unsigned int scale, u64 *res)
  *
  * For example, a scale of 3 with input "123.45" results in 123450. Note that
  * trailing zeros in the fractional part input to match the scale are not
- * required. Also, digits beyond the specified scale are ignored.
+ * required. Also, digits beyond the specified scale are rounded to nearest,
+ * ties to even.
  *
  * Return: 0 on success, -ERANGE on overflow and -EINVAL on parsing error.
  */
@@ -494,9 +527,10 @@ EXPORT_SYMBOL(kstrtoudec64);
  * @scale: The number of digits to the right of the decimal point.
  * @res: Where to write the result of the conversion on success.
  *
- * For example, a scale of 4 with input "-3.141592" results in -31415. Note
- * that digits beyond the specified scale are ignored. Also, trailing zeros in
- * the fractional part input to match the scale are not required.
+ * For example, a scale of 4 with input "-3.141592" results in -31416. Note
+ * that digits beyond the specified scale are rounded to nearest, ties to
+ * even. Also, trailing zeros in the fractional part input to match the scale
+ * are not required.
  *
  * Return: 0 on success, -ERANGE on overflow and -EINVAL on parsing error.
  */
diff --git a/lib/test-kstrtox.c b/lib/test-kstrtox.c
index 9255234752db..1f176b232085 100644
--- a/lib/test-kstrtox.c
+++ b/lib/test-kstrtox.c
@@ -737,12 +737,23 @@ static void __init test_kstrtoudec64_ok(void)
 		{"0.01",		3,	10},
 		{"0.1",			9,	100000000ULL},
 		{"0.01",		9,	10000000},
-		/* truncation: more fractional digits than scale */
-		{"1.23456",		3,	1234},
-		{"3.1415926535",	6,	3141592},
-		{"0.999999999",		3,	999},
-		{"1.99",		1,	19},
+		/* rounding: more fractional digits than scale */
+		{"1.23456",		3,	1235},
+		{"3.1415926535",	6,	3141593},
+		{"0.999999999",		3,	1000},
+		{"1.99",		1,	20},
 		{"1.234",		0,	1},
+		/* rounding: ties to even */
+		{"0.5",			0,	0},
+		{"1.5",			0,	2},
+		{"2.5",			0,	2},
+		{"2.500000",		0,	2},
+		{"2.51",		0,	3},
+		{"2.5000001",		0,	3},
+		{"0.05",		1,	0},
+		{"0.15",		1,	2},
+		{"0.25",		1,	2},
+		{"99.5",		0,	100},
 		/* trailing newline */
 		{"1.5\n",		1,	15},
 		{"42\n",		3,	42000},
@@ -760,15 +771,16 @@ static void __init test_kstrtoudec64_ok(void)
 		{"18446744073.709551615",	9,	ULLONG_MAX},
 		{"18446744073709.551615",	6,	ULLONG_MAX},
 		{"0.18446744073709551615",	20,	ULLONG_MAX},
+		{"18446744073.7095516154",	9,	ULLONG_MAX},
 		/* scale > 19: representable when integer part is small */
 		{"0.00000000000000000001",	20,	1},
 		{"0.1",				20,	10000000000000000000ULL},
 		{"0.00000000000000000000001",	23,	1},
-		/* truncation with scale > 19 */
+		/* rounding with scale > 19 */
 		{"0.0000000000000000000012345",	23,	123},
-		/* truncation with many excess digits */
+		/* rounding with many excess digits */
 		{"0.00000000000000000000000000000000423",	34,	42},
-		{"1.99999999999999999999999999999999999",	3,	1999},
+		{"1.99999999999999999999999999999999999",	3,	2000},
 	};
 	TEST_OK(kstrtoudec64, u64, "%llu", test_udec64_ok);
 }
@@ -795,6 +807,7 @@ static void __init test_kstrtoudec64_fail(void)
 		{"1.5 ",	1},
 		/* overflow */
 		{"18446744073710.551615",	6},
+		{"18446744073.7095516155",	9},
 		{"99999999999999999999",	1},
 		/* overflow with scale > 19 */
 		{"1.0",				21},
@@ -833,11 +846,16 @@ static void __init test_kstrtodec64_ok(void)
 		{"-1.2",		3,	-1200},
 		{"0.01",		3,	10},
 		{"-0.01",		3,	-10},
-		/* truncation */
-		{"1.23456",		3,	1234},
-		{"-1.23456",		3,	-1234},
-		{"0.999999999",		3,	999},
-		{"-0.999999999",	3,	-999},
+		/* rounding */
+		{"1.23456",		3,	1235},
+		{"-1.23456",		3,	-1235},
+		{"0.999999999",		3,	1000},
+		{"-0.999999999",	3,	-1000},
+		/* rounding: ties to even */
+		{"2.5",			0,	2},
+		{"-2.5",		0,	-2},
+		{"-3.5",		0,	-4},
+		{"-3.141592",		4,	-31416},
 		/* trailing newline */
 		{"1.5\n",		1,	15},
 		{"-1.5\n",		1,	-15},
@@ -846,6 +864,8 @@ static void __init test_kstrtodec64_ok(void)
 		/* limits */
 		{"9223372036.854775807",	9,	LLONG_MAX},
 		{"-9223372036.854775808",	9,	LLONG_MIN},
+		{"9223372036.8547758074",	9,	LLONG_MAX},
+		{"-9223372036.8547758085",	9,	LLONG_MIN},
 		/* scale > 19 */
 		{"0.0",				20,	0},
 		{"-0.0",			20,	0},
@@ -875,6 +895,8 @@ static void __init test_kstrtodec64_fail(void)
 		/* signed overflow */
 		{"9223372036.854775808",	9},
 		{"-9223372036.854775809",	9},
+		{"9223372036.8547758075",	9},
+		{"-9223372036.8547758085001",	9},
 		{"99999999999999999999",	1},
 		/* signed overflow with scale > 19 */
 		{"0.1",				20},

-- 
2.43.0


