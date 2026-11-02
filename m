Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793616086;
	b=fcPQuiXsqquAJd4yvzUJ3SWcO9ScZzUcD5u8+eJKIUYQnavXOfp5AB8gTcG+ajMsw/2w
	 5rKK6VvHE+UgVbZV5o9fiy6Jl9WSLGxOu40KEJly56RtdLx92ZxX+Sbv83R6n0dlJxjGf
	 XhbFn3TrR3LrkK8PCAqOGFwqq98WdwD85S8oO1gl515SG4TiZ8iJhT45c8bfx56n38k08
	 GV+82T570oYHvfCYrxPQSmLYpV4ldEpAL9R26n+Z5IrkufnBXrgVCKHSl0SKseTM12ToE
	 VmnQRyy/yvQv8tXs4WOCdCODltVJctp/PIjNzwH2bakJbLzEpCHMGhxbePpppPGYRuA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793616086;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=EPzCbxKELMHtph57rw7uF87sPahx/3UDJZ6gvRafZVk=;
	b=EgECWCxVNReb45UgBUf1P/uyFnGi31eaMO2iCizT60wReOEsvna9rVl+Eurr09WpcF/m
	 +lyxUABWiXfNJK2NSavnHjFX3Yk18EvfbswAie3W06JVCelQFNTmE0yaRWdiewZ8oj+ME
	 elZBzfRQM81nzGGVcMxoXr+9pyZEOxRpZ05b2R8Z7ouYaEQz/wDh8BEa4SYDkYpJewGNi
	 B6awV0q11Cq3w74uE3zpOyPWcXujB7QH/NsN/Xb02o1hFTSbPJfbv4T6ciDCBWHIxHPX5
	 RyjLCcx9RRNCEgaEi16lFuxGA0RREg1NTsmWVDHD4kDLpRH6oSJSaFP5qx/NxlwQFtQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hTFlyjNd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B89606A33B;
	Mon,  2 Nov 2026 10:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hTFlyjNd
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793616086;
	b=wbHcHOmPA2oEKSEbDg5iNWEEgO/sUMPqYpeYWjlqlun2uyr0DHmKcQ8+UsK49TZ0eIpi
	 4zgUmJchUNB8LZ3lBTe6xOP1UY2k2q0XKmQ3eA3TIGoZtyl1fNsdrmdCM4KFWPOhi5Ylv
	 R+CCavKp3wctRRIIqHz67UhGkqjIyr+JzXEHIvpCkK5M5M3BcDD27EeSCvKoQs3wyZuxH
	 uquAKAAcQb9xvKZWn3kKMiJ15cOPOUUk32Maed3lS8tQmPeZtN5KSo1ydHnCOrrV/jkU8
	 b6M5Oxp3KBsapYLFh/MiOaWn94IZ6R7TjsC3rzYxoAB4rM3JCkiYISozNL/b3p/yPXw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793616086;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=EPzCbxKELMHtph57rw7uF87sPahx/3UDJZ6gvRafZVk=;
	b=tzyziyc1Uo1+8NoTyanTaMFDfWlUEH9IA5ESWGHVLYbaY1Xg1jM7AZc48Y8zYZWpBYX7
	 Qva3/dEfrwyHZhysUKHmV4vJRqyQ6WaD09vbPErVsaEop1NJ562rELIRWRGKsSFiF18mV
	 kpQE+LWH5hgexxN6Ojzmi6c7a4bZt6erb0j57PfRYQs5C2QvByrKj2srVHV67m/QxkGRO
	 co1JnkHshsDENAqJitxwgxMStx0OvTU/aqPkTNSvkg6EbNsgOLsKlOA+q1gsSQO+z8Age
	 IzcnaW/PXtQnW0wl5QtYZ+WuSf6adk5+wwIjSblSmvBO3hNEDJgQTNF6Xm3hGIZtB0Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 4F5C01F00A18;
	Mon,  2 Nov 2026 10:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793616086;
	bh=EPzCbxKELMHtph57rw7uF87sPahx/3UDJZ6gvRafZVk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=hTFlyjNd+HV4cR5zdo4fYsvlAY+H9tt3mmGHQoGjBFyRetGqXkl3xmEdcGuHNPXTk
	 NmcCNlNS7324GJX9POBTLmlxB9sJj3ZfyNPRkKldBj9jldYBQcOlXHYIFO1e1i8MJx
	 Tlvwhke2uhWudW0iXULHgydlhFawa+CvaVywwDGrqsiAjOGBYgRlS/KvoPReh0/jHL
	 IErCQnGbdQw1VRr+1ootXAlEY+YvR+2wzp/wGFlTqC0AAsiDs6OxARE9rp2nZfVzmO
	 TUZ8163QNhYkcvld3wjhiwMpKaHWpL4kOQId21Hhd/rlHDtmxVTi+ZB/if1yt6Qovf
	 Aa0hXeSKWVS/A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id C8DCB46490;
	Mon,  2 Nov 2026 10:41:23 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Mon, 02 Nov 2026 07:41:03 -0300
Subject: [PATCH v5 5/7] iio: test: rescale: compare scales against the
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
Message-Id: <20261102-e-notation-v5-5-d399e544a982@analog.com>
References: <20261102-e-notation-v5-0-d399e544a982@analog.com>
In-Reply-To: <20261102-e-notation-v5-0-d399e544a982@analog.com>
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793616082; l=5689;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=MYurB/fu0EGmpzdutFErjw1ab4qsWqsloaJ03rKS+2A=;
 b=qhf2ARb0TQ8CjcmXWdasgktDpNzaPWHOzNUMTOCGx3EdJM0Gi9GdrQfaNkW3K3ZLn6uUIikJ6
 YtB+IqqFczMDQcxgVHIiZADRvFWCcBI4cYYMe+rsgBF1PzExFrKf3pC
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
 drivers/iio/test/iio-test-rescale.c | 60 ++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 37 deletions(-)

diff --git a/drivers/iio/test/iio-test-rescale.c b/drivers/iio/test/iio-test-rescale.c
index de4a09f432c0..e37a20ea1ca6 100644
--- a/drivers/iio/test/iio-test-rescale.c
+++ b/drivers/iio/test/iio-test-rescale.c
@@ -6,6 +6,8 @@
  */
 
 #include <linux/gcd.h>
+#include <linux/kstrtox.h>
+#include <linux/math64.h>
 #include <linux/overflow.h>
 
 #include <linux/iio/afe/rescale.h>
@@ -581,55 +583,37 @@ static void case_to_desc(const struct rescale_tc_data *t, char *desc)
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
+#define IIO_TEST_EXTRA_DEC_SCALE	1
+#define IIO_TEST_DEC_SCALE		(9 + IIO_TEST_EXTRA_DEC_SCALE)
+#define IIO_TEST_NANO_PER_DEC_SCALE	int_pow(10, IIO_TEST_EXTRA_DEC_SCALE)
 
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
 
@@ -638,9 +622,9 @@ static int iio_test_relative_error_ppm(const char *real_str, const char *exp_str
 		return -EINVAL;
 	}
 
-	err = 1000000UL * abs(exp - real);
+	*max_ppm = (int)div64_u64(IIO_TEST_NANO_PER_DEC_SCALE * 1000000ULL, abs(exp));
 
-	return (int)div64_u64(err, abs(exp));
+	return (int)mul_u64_u64_div_u64(abs(exp - real), 1000000, abs(exp));
 }
 
 static void iio_rescale_test_scale(struct kunit *test)
@@ -650,6 +634,7 @@ static void iio_rescale_test_scale(struct kunit *test)
 	struct rescale rescale;
 	int values[2];
 	int rel_ppm;
+	int max_ppm;
 	int ret;
 
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buff);
@@ -666,10 +651,11 @@ static void iio_rescale_test_scale(struct kunit *test)
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


