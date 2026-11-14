Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794665403;
	b=Z83LBSAo1lneX1y0lbQhZ+EcmrXLV6oHC/6fT+jIZNLWbAsMIGqaZta/3sxFOQrv4QsL
	 j/DEMxSUpSwwj57Hb5y26N04WvBfrIjCPNLXk9NCqL0u8YaEXmSbUVWa+VwP5xPAYqIyP
	 XiP0qR9KTIUPhErqxr1X9Lc7Jf1SyHUf624L9bKaAU4NfR1M6Tx5HrUGY57OuLFEMbPKA
	 Deqz/5gTHAcwUpCIRBjouVpkvOw7UTjuiQqW3rfUUIOWo7/fqSKqRJ9PHw9qXaJn5xS25
	 hMEzlmaDU9SPh2gjAv4bMdKhQsBj1zDXbCYmvh1x/9afUtOvylV3nPrzhvggshGkoFQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794665403;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=2e3WrXvF2jim20pK6IhPN24jJDYurW187lKPeAr7ysc=;
	b=4a/pb+CgXeMrK3cVDWMWEgeGBgIJkHVah94d5Ue88kihUodFeHzU3fSYD8IZm7X7Csmr
	 P1+eUOKPIY1gwzHzSaynKF6Bv+YewSXUpKTc9CzYGQgXi7AWbKcs5vnNgntWsbJQxAFXY
	 Qm1Nqy9dVmjJJ/LpK/HHPOlMFXOT7NR/IvO0eWFJkWN+vErIM7KH0JLaHHSbFJI3X3p1P
	 AroyCtAvEEp0W4CabrjXEt71EuQhcJJJgaR3sHLyfMtyHDfaCyBBcpSzwy16g6tp12EKT
	 D0m4mBqgJvWpM1Qj/Sfq1Fx8wahUKHk4H15utrnKXIg0gJfF3Ls+2tf8RUZliNZ+4gg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FwhtEuK1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B8F606A89E;
	Sat, 14 Nov 2026 14:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FwhtEuK1
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794665403;
	b=efrdIS3jPhPFJxifqze7He7JvFUvZU3iTPdkEjoKSG/pQc0NqXlUlg0xGuHil8pgtViR
	 x0cVhi24zzwIuIbxwWpyiopptAotg9TO8R6bzyCC7lzQRXg2+mqjNEc5gfH9ZikgHgdvZ
	 7uoW/ukYRe4fe/4VCa+RikY/omsWiNJJuPR74tzfPy3hNdkPIYuAdlb2L+vGGrpgDl6XP
	 OmrxM1GlYfJMP+urOBgJA/DLbs+UEEtftNJ5LYsVVjukoulokNJ9cX/YTQh1EQ7nDyFGe
	 wVOEr4aasJhv+3dkuFIp0bEN0f8xAIubimNQaLHqUqPvJT1fcfuCZ/Vun4oa6dWgOEw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794665403;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=2e3WrXvF2jim20pK6IhPN24jJDYurW187lKPeAr7ysc=;
	b=A2mEXH9hZNP2+dX2VbPPkFxWHtYa+UiJe14AfL+kpOiGZM218pYHO01adI7vNg/bYkvX
	 4ig+ghBZZ3+DO6EJyR84qR/DXt9y2dMeunPJEZDXQ2+4LUCswNGJCMNLiJhDF4PYCHIjc
	 xzSXNBi5P8ay+sSMa6W53chGqJ7JkjqyIyymrTsNWJlWUPozMbzJ4cSL97GoEKt92mC+9
	 wTfk0EI8N6aN/YMHDVlEnvmPctUbMOzcK6ZA1M5Pu7AgcGr00ZEkVDDd8luXSPf6tPDJD
	 cpjxOSNF4ilrkQuazoFiqs1zJM0sYecpHdgn8Izee64gII9pCVk0xLm/2rCwx8w9eyA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 2EED21F000C7;
	Sat, 14 Nov 2026 14:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794665403;
	bh=2e3WrXvF2jim20pK6IhPN24jJDYurW187lKPeAr7ysc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=FwhtEuK1zlTm2AvZE8mehWsg2/tVpqsy0EVDatq0xDhZx1uuIkhRyCMzoQiVs+RxT
	 AGQNnq+LNJ+dIorrxjsvJLznRF6a40wCxMBORwRboetziemWrI9qzYs6czuVhRBwUM
	 dskKzKaRSGAFstw9DoXFyX1EpI3dUN4hrsn0GZUOV+UPB6yghuE7LxjohvVMVeVIth
	 eXCtm5X0noMz215Z0qFvxW1YjJ68ANOwduvWK/LNmlVA/pTjzGQY7YwbITZ+ucVkbH
	 MyEa5MvStu15BjYZRjsbGzv+1zjS7/aiTdzbJHVOLzig8W4PDvvJ5nP1BwbvyzLVGA
	 hYAwaY8yEFpDA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id A53C549DF0;
	Sat, 14 Nov 2026 14:09:59 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Sat, 14 Nov 2026 14:09:55 +0000
Subject: [PATCH v6 3/7] lib: kstrtox: allow a negative scale in
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
Message-Id: <20261114-e-notation-v6-3-205ca9a1438a@analog.com>
References: <20261114-e-notation-v6-0-205ca9a1438a@analog.com>
In-Reply-To: <20261114-e-notation-v6-0-205ca9a1438a@analog.com>
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794665398; l=9933;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=bJbqKEr3jK38hEmgNGpehvwD4Fwz3Sx12qMMeSpzWhA=;
 b=k8XSChN1DFjjDi3xcuvEhvu8h5NqoRDSSMyVBNkWk03hvu6QtUZBcXwKbOOeswq0anEXHXaOj
 cbefESqpFyWCwAG2fqLRyM+o+hFgDOqLCElbAK8N7ma4jz4Ri3Jk4lT
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com
Content-Transfer-Encoding: 7bit

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

With E notation support, the scale is added to the exponent, and a
negative effective exponent already drops integer digits with rounding
to nearest, ties to even. A negative scale could be handled the same
way, but the scale is declared unsigned int.

Change the scale parameter of kstrtoudec64() and kstrtodec64() to int
and describe a negative scale in the kernel-doc. For example, a scale of
-2 with input "12355" results in 124. This lets callers parse a value
into a coarser unit than the input, such as Hz into kHz, without a
separate division and rounding step.

Behavior doesn't change for any existing caller, since they all pass a
non-negative scale.

Add dedicated test macros for kstrto[u]dec64() with a signed scale
field, as the generic ones carry an unsigned base, and add test cases
for negative scales: dropped integer digits with ties to even, results
at the type limits, rounding past them, and exponents that overflow when
added to the scale.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 include/linux/kstrtox.h |   4 +-
 lib/kstrtox.c           |  20 +++++-----
 lib/test-kstrtox.c      | 101 ++++++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 106 insertions(+), 19 deletions(-)

diff --git a/include/linux/kstrtox.h b/include/linux/kstrtox.h
index b41b9736886f..e2d5870c979b 100644
--- a/include/linux/kstrtox.h
+++ b/include/linux/kstrtox.h
@@ -97,8 +97,8 @@ int __must_check kstrtou8(const char *s, unsigned int base, u8 *res);
 int __must_check kstrtos8(const char *s, unsigned int base, s8 *res);
 int __must_check kstrtobool(const char *s, bool *res);
 
-int __must_check kstrtoudec64(const char *s, unsigned int scale, u64 *res);
-int __must_check kstrtodec64(const char *s, unsigned int scale, s64 *res);
+int __must_check kstrtoudec64(const char *s, int scale, u64 *res);
+int __must_check kstrtodec64(const char *s, int scale, s64 *res);
 
 int __must_check kstrtoull_from_user(const char __user *s, size_t count, unsigned int base, unsigned long long *res);
 int __must_check kstrtoll_from_user(const char __user *s, size_t count, unsigned int base, long long *res);
diff --git a/lib/kstrtox.c b/lib/kstrtox.c
index 4c1ec9223d63..4962c70abf32 100644
--- a/lib/kstrtox.c
+++ b/lib/kstrtox.c
@@ -424,7 +424,7 @@ static u64 round_half_even(const char *p, const char *end, u64 res)
 	return res & 1;
 }
 
-static int _kstrtoudec64(const char *s, unsigned int scale, u64 *res)
+static int _kstrtoudec64(const char *s, int scale, u64 *res)
 {
 	const char *s_int, *s_frac, *s_end, *s_round;
 	int len_int, len_frac;
@@ -500,18 +500,19 @@ static int _kstrtoudec64(const char *s, unsigned int scale, u64 *res)
  * @s: The start of the string. The string must be null-terminated, and may also
  *  include a single newline before its terminating null. The first character
  *  may also be a plus sign, but not a minus sign.
- * @scale: The number of digits to the right of the decimal point.
+ * @scale: The number of digits to the right of the decimal point. A negative
+ *  scale drops digits to the left of the decimal point instead.
  * @res: Where to write the result of the conversion on success.
  *
- * For example, a scale of 3 with input "123.45" results in 123450. Note that
- * trailing zeros in the fractional part input to match the scale are not
- * required. Also, digits beyond the specified scale are rounded to nearest,
- * ties to even.
+ * For example, a scale of 3 with input "123.45" results in 123450, and a
+ * scale of -2 with input "12355" results in 124. Note that trailing zeros in
+ * the fractional part input to match the scale are not required. Also, digits
+ * beyond the specified scale are rounded to nearest, ties to even.
  *
  * Return: 0 on success, -ERANGE on overflow and -EINVAL on parsing error.
  */
 noinline
-int kstrtoudec64(const char *s, unsigned int scale, u64 *res)
+int kstrtoudec64(const char *s, int scale, u64 *res)
 {
 	if (s[0] == '+')
 		s++;
@@ -524,7 +525,8 @@ EXPORT_SYMBOL(kstrtoudec64);
  * @s: The start of the string. The string must be null-terminated, and may also
  *  include a single newline before its terminating null. The first character
  *  may also be a plus sign or a minus sign.
- * @scale: The number of digits to the right of the decimal point.
+ * @scale: The number of digits to the right of the decimal point. A negative
+ *  scale drops digits to the left of the decimal point instead.
  * @res: Where to write the result of the conversion on success.
  *
  * For example, a scale of 4 with input "-3.141592" results in -31416. Note
@@ -535,7 +537,7 @@ EXPORT_SYMBOL(kstrtoudec64);
  * Return: 0 on success, -ERANGE on overflow and -EINVAL on parsing error.
  */
 noinline
-int kstrtodec64(const char *s, unsigned int scale, s64 *res)
+int kstrtodec64(const char *s, int scale, s64 *res)
 {
 	u64 tmp;
 	int rv;
diff --git a/lib/test-kstrtox.c b/lib/test-kstrtox.c
index 1f176b232085..8ba0f23bb8ef 100644
--- a/lib/test-kstrtox.c
+++ b/lib/test-kstrtox.c
@@ -709,9 +709,66 @@ static void __init test_kstrtos8_fail(void)
 	TEST_FAIL(kstrtos8, s8, "%hhd", test_s8_fail);
 }
 
+struct test_dec_fail {
+	const char *str;
+	int scale;
+};
+
+#define DEFINE_TEST_DEC_FAIL(test)	\
+	const struct test_dec_fail test[] __initconst
+
+#define DECLARE_TEST_DEC_OK(type, test_type)	\
+	struct test_type {			\
+		const char *str;		\
+		int scale;			\
+		type expected_res;		\
+	}
+
+#define TEST_DEC_FAIL(fn, type, fmt, test)				\
+{									\
+	unsigned int i;							\
+									\
+	for_each_test(i, test) {					\
+		const struct test_dec_fail *t = &test[i];		\
+		type tmp;						\
+		int rv;							\
+									\
+		tmp = 0;						\
+		rv = fn(t->str, t->scale, &tmp);			\
+		if (rv >= 0) {						\
+			WARN(1, "str '%s', scale %d, expected -E, got %d/" fmt "\n",	\
+				t->str, t->scale, rv, tmp);		\
+			continue;					\
+		}							\
+	}								\
+}
+
+#define TEST_DEC_OK(fn, type, fmt, test)				\
+{									\
+	unsigned int i;							\
+									\
+	for_each_test(i, test) {					\
+		const typeof(test[0]) *t = &test[i];			\
+		type res;						\
+		int rv;							\
+									\
+		rv = fn(t->str, t->scale, &res);			\
+		if (rv != 0) {						\
+			WARN(1, "str '%s', scale %d, expected 0/" fmt ", got %d\n",	\
+				t->str, t->scale, t->expected_res, rv);	\
+			continue;					\
+		}							\
+		if (res != t->expected_res) {				\
+			WARN(1, "str '%s', scale %d, expected " fmt ", got " fmt "\n",	\
+				t->str, t->scale, t->expected_res, res);	\
+			continue;					\
+		}							\
+	}								\
+}
+
 static void __init test_kstrtoudec64_ok(void)
 {
-	DECLARE_TEST_OK(u64, struct test_udec64);
+	DECLARE_TEST_DEC_OK(u64, test_udec64);
 	static DEFINE_TEST_OK(struct test_udec64, test_udec64_ok) = {
 		/* basic: integer.fraction, exact digits */
 		{"0.0",			1,	0},
@@ -781,13 +838,25 @@ static void __init test_kstrtoudec64_ok(void)
 		/* rounding with many excess digits */
 		{"0.00000000000000000000000000000000423",	34,	42},
 		{"1.99999999999999999999999999999999999",	3,	2000},
+		/* negative scale: drops integer digits */
+		{"12345",		-2,	123ULL},
+		{"12355",		-2,	124ULL},
+		{"1250",		-2,	12ULL},
+		{"1350",		-2,	14ULL},
+		{"123.45",		-3,	0ULL},
+		{"500",			-3,	0ULL},
+		{"500.1",		-3,	1ULL},
+		{"999",			-3,	1ULL},
+		{"999",			-4,	0ULL},
+		{"2.7e10",		-9,	27ULL},
+		{"18446744073709551615000",	-3,	ULLONG_MAX},
 	};
-	TEST_OK(kstrtoudec64, u64, "%llu", test_udec64_ok);
+	TEST_DEC_OK(kstrtoudec64, u64, "%llu", test_udec64_ok);
 }
 
 static void __init test_kstrtoudec64_fail(void)
 {
-	static DEFINE_TEST_FAIL(test_udec64_fail) = {
+	static DEFINE_TEST_DEC_FAIL(test_udec64_fail) = {
 		/* empty / whitespace */
 		{"",		3},
 		{"\n",		3},
@@ -814,13 +883,17 @@ static void __init test_kstrtoudec64_fail(void)
 		{"0.2",				20},
 		{"0.18446744073709551616",	20},
 		{"1",				20},
+		/* negative scale: rounds up past the limit */
+		{"18446744073709551615500",	-3},
+		/* negative scale: exponent overflows when added to it */
+		{"1e-2147483648",		-1},
 	};
-	TEST_FAIL(kstrtoudec64, u64, "%llu", test_udec64_fail);
+	TEST_DEC_FAIL(kstrtoudec64, u64, "%llu", test_udec64_fail);
 }
 
 static void __init test_kstrtodec64_ok(void)
 {
-	DECLARE_TEST_OK(s64, struct test_dec64);
+	DECLARE_TEST_DEC_OK(s64, test_dec64);
 	static DEFINE_TEST_OK(struct test_dec64, test_dec64_ok) = {
 		/* basic positive */
 		{"0.0",			1,	0},
@@ -873,13 +946,20 @@ static void __init test_kstrtodec64_ok(void)
 		{"-0.00000000000000000001",	20,	-1},
 		{"0.009223372036854775807",	21,	LLONG_MAX},
 		{"-0.009223372036854775808",	21,	LLONG_MIN},
+		/* negative scale: drops integer digits */
+		{"-12345",		-2,	-123LL},
+		{"-12355",		-2,	-124LL},
+		{"-1250",		-2,	-12LL},
+		{"-1350",		-2,	-14LL},
+		{"-999",		-4,	0LL},
+		{"-9223372036854775808000",	-3,	LLONG_MIN},
 	};
-	TEST_OK(kstrtodec64, s64, "%lld", test_dec64_ok);
+	TEST_DEC_OK(kstrtodec64, s64, "%lld", test_dec64_ok);
 }
 
 static void __init test_kstrtodec64_fail(void)
 {
-	static DEFINE_TEST_FAIL(test_dec64_fail) = {
+	static DEFINE_TEST_DEC_FAIL(test_dec64_fail) = {
 		/* empty / whitespace */
 		{"",		3},
 		{"\n",		3},
@@ -903,8 +983,13 @@ static void __init test_kstrtodec64_fail(void)
 		{"-0.1",			20},
 		{"0.09223372036854775808",	20},
 		{"-0.09223372036854775809",	20},
+		/* negative scale: rounds up past the limit */
+		{"9223372036854775807500",	-3},
+		{"-9223372036854775808501",	-3},
+		/* negative scale: exponent overflows when added to it */
+		{"-1e-2147483648",		-1},
 	};
-	TEST_FAIL(kstrtodec64, s64, "%lld", test_dec64_fail);
+	TEST_DEC_FAIL(kstrtodec64, s64, "%lld", test_dec64_fail);
 }
 
 static int __init test_kstrtox_init(void)

-- 
2.43.0


