Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793616085;
	b=sicNN5lFGgsNgk+3O9gi/jLFtn+/TKIPNnClueYK+yAvVetiE/Fd8sbK8lPWWitbnMBd
	 Ow2pn67WBvkRG7zDpjpAmsLc2lUHSAljHhe/vf4dHmyka33Go6jnndZF2Uv84badOcBHk
	 K0P8nx/v5NSW7X7bFRJYDFJu6wlDe0+yG4RiBJEHz8e75odfdblLcsQTV6OCJ3SJfxbiv
	 WVVN6SunWtbLrROeW6Cp9pEaxS21CxgKXgddwJYLmv0d3FwmDFgH96I+kSVXwt89I/Yx8
	 LzYf8EC2yNn4ZJV2iE/Hc8tYYqB1o545mR7x3zcQT9qfPDxK4s+VjEZWbnRFCCnSBIw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793616085;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=hQdaApN8wCL1XS8RG/E8KSPYlZKoAadZqGW4uiQY/7M=;
	b=3DtNwXH+dtSwnTIBqqjLkwBhKXSfSNNHOf1cgPIxcQzy23YeXGMj5SIbwNVPUDExRBkS
	 F0a7wKFQVtD9+ml6aS517hkXUfS2cwXJQIUPudt0Y74I99U/OIp/Cg7k0vFbAmiah+js9
	 va00hnhYVuxncH+uF6eXK4ctDIaNeoS53b1igNur0XtTlf1iZkksmFYbWqwCP5mjHbjIX
	 G+gXwRiFxbPoYq+GQO2M/0ctmZ/NM2wZEe5sZIgV8Zd0uFktrXBYHsYxt+qpKD8ZGRQjl
	 FLihpSMJtG0XDEMHgRvliJ+9IFAuDtXvuV8aw5e3o7CzU8CcF+lxJ1EFFq46odH1iVw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EwllRZRs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DBB606A326;
	Mon,  2 Nov 2026 10:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EwllRZRs
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793616085;
	b=ooDjfNhiWEFk3fNu2KERWSunLN+gU3sJlQ1xO9H7VMJK0QrfVNJr8AgoSTZbBDPe6Xo/
	 RK3rUyI4YZn93tjbsd4d9ifTEwAhjGPkj5RmlmsaUEbtcKcqB+wUiWmhHNdcsiZ4bP5g3
	 yEh4vmIWMrFdfzyD2OSihvaaU6M4QdwLUPTUukCV288gn46mUgpi0sib4Ysqbs8wg/ADo
	 btbUQP6tffVU0zrk8U0VxxNSTW3gQfkn3ofzeaIlS0+N8CEQw8pPkz55uhXLPtOBuSkym
	 vwhsq4sb+ERjasfkxoO7i79uAreaLVhNvK0WWIH4hcSvCxDaBsDhax5jaMjBdu7zp2w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793616085;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=hQdaApN8wCL1XS8RG/E8KSPYlZKoAadZqGW4uiQY/7M=;
	b=QnrU6aBVHbbUejO5L2K/swZRi5legYSU6K8L+sGpTvmpz+VOgIPRa+klMnQ4lE49I7EE
	 ipp9S/QTxc0Li7BvjEvMOtoJacB0FQvoUi+uWtEIyX2wYOhbDyABxQP/9YuFQkTEqjH+m
	 47Bwf4KOfu06mD3FCdYwanOftXMkmr2BNmhktdokoEbA4ipav1a3Kr6cqz/638WCweP2a
	 Cnd6uf4xP2hFiTQh0CNrYm/lbW8t16r6vrkgPFe+jTHLwi6fkeo3rU24XxlMQUI26Vo6Q
	 ja57zwPueUDjsRMSgWKT7PQ+J8HbByqQ6fjowlGXtlIkk1Flzv9Tn6phwsTPvSEcR/g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 319831F000C1;
	Mon,  2 Nov 2026 10:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793616085;
	bh=hQdaApN8wCL1XS8RG/E8KSPYlZKoAadZqGW4uiQY/7M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=EwllRZRsx/gUPnZT9TZdHtUHiAhY9VLOuHKjhDc1vJ7rAfd4/eeKnvA8+agVm0pVt
	 NkZCsPo+OW3rALRvTwpjRwzXQ2DPLXQDzXFTHH49zvef5UJdkZPlrVVfIq48e6elgk
	 Zksz8LVx7pevBHqCVni3apHtFwOaFUlH1OwPw3per52JkIH3swAdPQho4paQygjJE5
	 eiHvHQ4q4/NMU5g2AKEkkPdSnfyCtZ+/ITB9PRwucXhVDXIdpX21klL1nzlqVBuH7G
	 OD++ZCx3MI2vP9JXtFPBiCjISgJdr2yBgMsW6sMWgurbRgxMbni46ogspLHqHhSMzr
	 8RR3kASbg/uDg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id A42E846484;
	Mon,  2 Nov 2026 10:41:23 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Mon, 02 Nov 2026 07:41:00 -0300
Subject: [PATCH v5 2/7] lib: kstrtox: round to nearest, ties to even in
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
Message-Id: <20261102-e-notation-v5-2-d399e544a982@analog.com>
References: <20261102-e-notation-v5-0-d399e544a982@analog.com>
In-Reply-To: <20261102-e-notation-v5-0-d399e544a982@analog.com>
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793616082; l=8057;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=1dMB63Cn47ITK8X1gqWsPx6EOJi5fsA+BpVS9jc67FI=;
 b=Vk8+fK/uM1OSTrKP3qKFnUa28FgV4nyNkJLL60yoLdqOrVOLaKf8mal0/YunQn5YYHwIGmf93
 pZLaasVMrKpAQaHmMFJG/3FX5D5BmYzn0dMDaaTtI8JYlBdOlLEXOAr
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
with a scale of 0 gives 1 instead of 2.

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
index 94f3399b3a9b..192f2067cad1 100644
--- a/lib/kstrtox.c
+++ b/lib/kstrtox.c
@@ -405,9 +405,28 @@ static int skip_digits(const char **s)
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
 	len_frac = skip_digits(&s);
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


