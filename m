Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793015663;
	b=frnq7nBsGHwi4DK3iRyjsUewLQG5ZNmc2FNklTZT5XSUR9bEgH3LfpO9siSlz0BODDIA
	 KXhhrA99FKhVwSbIe0o5bm5XQBRq6RIIXsxwYrSWJhZg+/7DWq7Exl59okoPQ1YW8LhXZ
	 6PYJCwqvXVi8tIayPaFsq8loejz//8j7nWU+0WsPm52B8s6VOBHT/bGUP8d0hGDECuT3P
	 3bkOu5OS57TQqo+meWxygssiPy8yoodT3HUXO0RHlhX+PmUuVyNgdlltp+CHXUJNAiYTW
	 MLDCivjj8OiM1TSvMB5bU3Vqo7bEH2StAUuO0YliTh57LuRkFHSKTH5qKL7rbGpwC0g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793015663;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=7Z6QcafH4q69MTMj1n+q+kDS9Ee7x9hV3uOErHPDCYA=;
	b=gKF6jyLGpSJCwN4+MOToJTDixhL8sB2rcMu+NdCnYmCFPKjH9gr6CEGwDitrU7C9mpKn
	 34BdPwAHXzAsIqSRyrbzOsPP6BkOWtL9/NyzAhfQzbRziVUBAUY6cuqL+j1TccCjdCnm1
	 Wfc5ADymIBOYrrl9J0npOwgIKs+X1iHr6XPWiO4WkXVsqMVw13X/qBy67VNf4r/0Nz7gZ
	 HSyfetRNjT4Xo9EAXwwlRNGbubU2agvXgMM6NOgEech1HOhBElBCfi6zLXl+OgDu1mNfg
	 MGGj+ch/ZYAon6aDrxddg1CgLshemOGSbTW9FL84kkvsxm+v4k7eWbDYT1FPV4SJJNA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L9z8gQTh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FED606A331;
	Mon, 26 Oct 2026 11:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L9z8gQTh
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793015662;
	b=0WBu+RSWdwTTCjjzYVmZyWgGB2DfKUTSz7Dx16h5KnhPj0lVVaH9TJz4v0FdyqwfQTD5
	 33iGxiUrpqVDS/NUkIA0vy17rcHLzufzjpCZhRqrvaBnvKE7pcvltlhlZ3jfiknkEFCOI
	 JlCwNV/BPPy+974nSIf1rV17s+0o8aEkAXkL2VAUl6LKTkW5iXsXtqSaWG/4glO6jM5IK
	 ana5yKjUGhHoX/aXuSVnbnilGM6DiEqTRy26G2hqaGtG/stBnjTtVUAswfLz2fgWPN2At
	 8KSjnxonpSUS99oNDqrm9UszbEhvAb/4QRlK3P82GIdbllBQ1zDkYWipgiQmb/+/+Sg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793015662;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=7Z6QcafH4q69MTMj1n+q+kDS9Ee7x9hV3uOErHPDCYA=;
	b=vSf+v1WMtQUwMXjCaODGHJnrNHNdObJ4Nfwa6ofpcH7wrYjuFGxyobF2En0ndE1YmAql
	 E2/zw6k9gN1XNlEfyiAZ4ERVjlAv5dH5MLY2iPe5Q52tNx1f8ZeLrv/pXrmI0itf88g05
	 TGPmICEXqpDpa4L+Cy5wamwNkJ3o06OsZMHmmqW5huf2K+K76wYIAYvdFsRnbIjOdlRAc
	 kwDCIJvbvbDFguYgVtyIi/CM00hZNz57MZDOt/KwEJOBzOJ0CYaVRV+g4iLDldQ0wv6/C
	 zlmGoF/RnTNzhvhBF2Nkrory1JPRo3lO4TMmVyHsaXls1k5QAkvZCQEK3Jgx7tV+Trw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 7AC531F031E6;
	Mon, 26 Oct 2026 11:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793015662;
	bh=7Z6QcafH4q69MTMj1n+q+kDS9Ee7x9hV3uOErHPDCYA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=L9z8gQThF5vMsJBbKZ90ePBDJJt8TsVt4h4j7qmElvhOqFEpTfnJpH2CZd7sy1pIZ
	 5aB1gMAcNHpFXq/1DrEN6Wmdq2vHvGjnA8zEfzIwjISsQUQcT7ZELf2/sUTiI6ONaV
	 JwlxYOrAcTBDX8zjMVPK8pJtjIA92cDnuppsur39R0S/+jTvZAt18e3hCWI3oPEFiZ
	 3Vg7CGabctVbxu9lvqp3iAoPhZy9+j6cQJeddwI0GHonfCatoViRDDO2JwbfTxtxop
	 5diQA52OxQHAFlnwqbLYX8L0/Ek1zfuaFxzWvMwZ0WH3GE/4UVG143/lbXQ/P+U+ZA
	 WfFNlfOa8ArOg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 082AB44CF2;
	Mon, 26 Oct 2026 11:54:21 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Mon, 26 Oct 2026 08:54:08 -0300
Subject: [PATCH v4 4/6] iio: test: rescale: compare scales against the
 precision of the output
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
Message-Id: <20261026-e-notation-v4-4-a366a6d14d57@analog.com>
References: <20261026-e-notation-v4-0-a366a6d14d57@analog.com>
In-Reply-To: <20261026-e-notation-v4-0-a366a6d14d57@analog.com>
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793015661; l=5598;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=nELWY96qckQqagFFtkhq4P+EyoDGOmFkXwKMJiZTz3c=;
 b=+pFNmFDSZK8OonTTZfUEuL6RhH8MRKjo2ez5MpxV5Fo9C8MQN/Cm+fbYqfeMWxD4//6AVunDF
 eEg3dd8v9u7D5QDUcTsNvE4CJcRa6zem3pQnuJznWyfnuvqtHcE+Nlu
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com
Content-Transfer-Encoding: 7bit

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

The scale tests format the rescaled value with iio_format_value(), which
prints at most nano precision, and require the relative error to the
expected value to be below 1 ppm. Both strings are parsed back with
iio_str_to_fixpoint() at nano precision, so for the small scale cases the
check only passes because the expected value, like the formatted one, is
truncated to nano. For example, "0.000000033594" is parsed as 33 nano,
equal to the formatted "0.000000033", although the actual error is about
1.8%. If the expected value were rounded instead, it would be parsed as
34 nano and the test would fail even though the output is as accurate as
the format allows.

Parse both values with kstrtodec64() at a scale of 10, one digit more
than the output precision, so the expected value keeps the digits lost
when formatting. Scale 10 is the largest that still fits the overflow
cases (about 2.1e8) in an s64. Compute the relative error with
mul_u64_u64_div_u64(), as the product with 10^6 no longer fits in 64 bits
for those cases.

Then allow a relative error up to the relative size of one nano of the
expected value, the precision of the formatted output. This is 0 ppm for
values of 0.01 and above, so those cases are checked as before, and it
accepts the formatting error for the small scale cases.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/test/iio-test-rescale.c | 59 ++++++++++++++-----------------------
 1 file changed, 22 insertions(+), 37 deletions(-)

diff --git a/drivers/iio/test/iio-test-rescale.c b/drivers/iio/test/iio-test-rescale.c
index de4a09f432c0..1347a9650355 100644
--- a/drivers/iio/test/iio-test-rescale.c
+++ b/drivers/iio/test/iio-test-rescale.c
@@ -6,6 +6,8 @@
  */
 
 #include <linux/gcd.h>
+#include <linux/kstrtox.h>
+#include <linux/math64.h>
 #include <linux/overflow.h>
 
 #include <linux/iio/afe/rescale.h>
@@ -581,55 +583,36 @@ static void case_to_desc(const struct rescale_tc_data *t, char *desc)
 KUNIT_ARRAY_PARAM(iio_rescale_scale, scale_cases, case_to_desc);
 KUNIT_ARRAY_PARAM(iio_rescale_offset, offset_cases, case_to_desc);
 
-/**
- * iio_str_to_nano() - Parse a fixed-point string to get an
- *                      IIO_VAL_INT_PLUS_NANO value
- * @str: The string to parse
- * @nano: The number as an integer
- *
- * Returns 0 on success, or a negative error code if the string could not be
- * parsed.
+/*
+ * iio_format_value() prints scales with up to nano precision. Parse values
+ * with one more digit, so the expected values keep the precision lost there.
+ * Scale 10 is the largest that fits the overflow test cases in an s64.
  */
-static int iio_str_to_nano(const char *str, s64 *nano)
-{
-	int tmp, tmp2;
-	int ret = 0;
-
-	/*
-	 * iio_str_to_fixpoint() uses 10^8 here instead of 10^9 as fract_mult is
-	 * the multiplier for the first decimal place.
-	 */
-	ret = iio_str_to_fixpoint(str, 100000000, &tmp, &tmp2);
-	if (ret < 0)
-		return ret;
-
-	if (tmp < 0)
-		tmp2 *= -1;
-
-	*nano = (s64)tmp * 1000000000UL + tmp2;
-
-	return ret;
-}
+#define IIO_TEST_DEC_SCALE	10
+#define IIO_TEST_NANO		10	/* one nano at IIO_TEST_DEC_SCALE */
 
 /**
  * iio_test_relative_error_ppm() - Compute relative error (in parts-per-million)
  *                                 between two fixed-point strings
  * @real_str: The real value as a string
  * @exp_str: The expected value as a string
+ * @max_ppm: The relative size (in parts-per-million) of one nano of the
+ *           expected value, the precision of iio_format_value()
  *
  * Returns a negative error code if the strings could not be parsed, or the
  * relative error in parts-per-million.
  */
-static int iio_test_relative_error_ppm(const char *real_str, const char *exp_str)
+static int iio_test_relative_error_ppm(const char *real_str, const char *exp_str,
+				       int *max_ppm)
 {
-	s64 real, exp, err;
+	s64 real, exp;
 	int ret;
 
-	ret = iio_str_to_nano(real_str, &real);
+	ret = kstrtodec64(real_str, IIO_TEST_DEC_SCALE, &real);
 	if (ret < 0)
 		return ret;
 
-	ret = iio_str_to_nano(exp_str, &exp);
+	ret = kstrtodec64(exp_str, IIO_TEST_DEC_SCALE, &exp);
 	if (ret < 0)
 		return ret;
 
@@ -638,9 +621,9 @@ static int iio_test_relative_error_ppm(const char *real_str, const char *exp_str
 		return -EINVAL;
 	}
 
-	err = 1000000UL * abs(exp - real);
+	*max_ppm = (int)div64_u64(IIO_TEST_NANO * 1000000ULL, abs(exp));
 
-	return (int)div64_u64(err, abs(exp));
+	return (int)mul_u64_u64_div_u64(abs(exp - real), 1000000, abs(exp));
 }
 
 static void iio_rescale_test_scale(struct kunit *test)
@@ -650,6 +633,7 @@ static void iio_rescale_test_scale(struct kunit *test)
 	struct rescale rescale;
 	int values[2];
 	int rel_ppm;
+	int max_ppm;
 	int ret;
 
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buff);
@@ -666,10 +650,11 @@ static void iio_rescale_test_scale(struct kunit *test)
 	ret = iio_format_value(buff, ret, 2, values);
 	KUNIT_EXPECT_EQ(test, (int)strlen(buff), ret);
 
-	rel_ppm = iio_test_relative_error_ppm(buff, t->expected);
-	KUNIT_EXPECT_GE_MSG(test, rel_ppm, 0, "failed to compute ppm\n");
+	rel_ppm = iio_test_relative_error_ppm(buff, t->expected, &max_ppm);
+	KUNIT_ASSERT_GE_MSG(test, rel_ppm, 0, "failed to compute ppm\n");
 
-	KUNIT_EXPECT_EQ_MSG(test, rel_ppm, 0,
+	/* allow the error of the nano precision used to format the value */
+	KUNIT_EXPECT_LE_MSG(test, rel_ppm, max_ppm,
 			    "\t    real=%s"
 			    "\texpected=%s\n",
 			    buff, t->expected);

-- 
2.43.0


