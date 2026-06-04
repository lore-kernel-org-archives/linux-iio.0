Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0C53FD943;
	Thu,  4 Jun 2026 09:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780567183; cv=none; b=KA3k7k3QebS2/ZMWreoPdLsE3uUwAS3kbM8cYYGXL/W6tZxTogzR4yUVBt0AiENwH9ciR+m+Z83/Gh1FBb/jFHFXh+HdpcjKSCe2xRpBlyh3nnPEf7uj4s6MIAc+eM1MYM+fxDwycvEfoLcfGmKFzudMhnQwFvEGC3UfFeqmICc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780567183; c=relaxed/simple;
	bh=FdJRCnHVURMIunMF4Ot+NgpLZuDFiIZlYrQLpVh0LIc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xet7KWWfD7sO1AGgh/mupjpKN7JbYX+wMZzCPicIudfRmAZ8EK+QDHL4k2SZ0rImYXICmZeRv5cbaXr19FHiTAbqtgVn6RFaj0tL6+iCZeMoocPdCXdobNBd6g7rgrsjXGHbtPm1pjPPpym/JSLQAMxmtR/MoYHI+e3zoSpOUNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rpb6aI35; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rpb6aI35"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6E59FC2BCB9;
	Thu,  4 Jun 2026 09:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780567183;
	bh=FdJRCnHVURMIunMF4Ot+NgpLZuDFiIZlYrQLpVh0LIc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Rpb6aI355CixjvfzjnslJSp/wAoF5GvnQ8jrJKC8/OUOgKcR6KzsIoVMOYO6n0uXN
	 pUajUSKjmRGb0dj0mKeq7OtGmrsSUfwrunR9FuYpyYQ8FboyJQheKTsRWPu+5zv5ym
	 yEeh5skZYEMPbxP/RajsmV0w9YnYZRkTI5RIRaAUOa3oFqcEOc0Oq4mglb3A4kaoJw
	 /Flpnzbr+oM0LvNdo/QruQoNnNLns/y2tTAGwkEH4c/UKSIPzgkokyUvO+TwaKgM2I
	 zdQnkVMrzxpK6r8o93VdMNJ90a5pyE+ZZIMbjeE1qHTlpbv+7k2WXAsWvzonU+Y86f
	 YjanTP35lQ9BQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64692CD6E6B;
	Thu,  4 Jun 2026 09:59:43 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Thu, 04 Jun 2026 10:59:03 +0100
Subject: [PATCH v16 09/14] iio: test: iio-test-format: add test case for
 decimal format
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-adf41513-iio-driver-v16-9-1a7d09143bc2@analog.com>
References: <20260604-adf41513-iio-driver-v16-0-1a7d09143bc2@analog.com>
In-Reply-To: <20260604-adf41513-iio-driver-v16-0-1a7d09143bc2@analog.com>
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux@analog.com
Cc: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780567181; l=6896;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=hzJoGujhATtf6gCUbu5gJeZzi6x/rX3Pp1g7bNPBJLw=;
 b=NemKaW8JR1fhTzPFpZL4ThI7YbGu9NKFGANK1nfswwXZK9wXNnqk5L9CxESGHv3rSE9h//6PQ
 6YUoMZKf/F6AoLfgsvBev8jNeTuik6r79RmrF7lTDiqzikNRE1dyYQk
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Add iio_test_iio_format_value_decimal_64() kunit test case for decimal
value formatting, exploring different scales types. Also, the same
iio_val_s64_decompose() helper used to populate local array is used in
iio_test_iio_format_value_integer_64().

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/test/iio-test-format.c | 97 +++++++++++++++++++++++++++++---------
 1 file changed, 75 insertions(+), 22 deletions(-)

diff --git a/drivers/iio/test/iio-test-format.c b/drivers/iio/test/iio-test-format.c
index 872dd8582003..e5d0a2ac4670 100644
--- a/drivers/iio/test/iio-test-format.c
+++ b/drivers/iio/test/iio-test-format.c
@@ -200,56 +200,108 @@ static void iio_test_iio_format_value_multiple(struct kunit *test)
 static void iio_test_iio_format_value_integer_64(struct kunit *test)
 {
 	int values[2];
-	s64 value;
 	char *buf;
 	int ret;
 
 	buf = kunit_kmalloc(test, PAGE_SIZE, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf);
 
-	value = 24;
-	values[0] = lower_32_bits(value);
-	values[1] = upper_32_bits(value);
+	iio_val_s64_decompose(24, &values[0], &values[1]);
 	ret = iio_format_value(buf, IIO_VAL_INT_64, ARRAY_SIZE(values), values);
 	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "24\n");
 
-	value = -24;
-	values[0] = lower_32_bits(value);
-	values[1] = upper_32_bits(value);
+	iio_val_s64_decompose(-24, &values[0], &values[1]);
 	ret = iio_format_value(buf, IIO_VAL_INT_64, ARRAY_SIZE(values), values);
 	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-24\n");
 
-	value = 0;
-	values[0] = lower_32_bits(value);
-	values[1] = upper_32_bits(value);
+	iio_val_s64_decompose(0, &values[0], &values[1]);
 	ret = iio_format_value(buf, IIO_VAL_INT_64, ARRAY_SIZE(values), values);
 	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "0\n");
 
-	value = UINT_MAX;
-	values[0] = lower_32_bits(value);
-	values[1] = upper_32_bits(value);
+	iio_val_s64_decompose(UINT_MAX, &values[0], &values[1]);
 	ret = iio_format_value(buf, IIO_VAL_INT_64, ARRAY_SIZE(values), values);
 	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "4294967295\n");
 
-	value = -((s64)UINT_MAX);
-	values[0] = lower_32_bits(value);
-	values[1] = upper_32_bits(value);
+	iio_val_s64_decompose(-((s64)UINT_MAX), &values[0], &values[1]);
 	ret = iio_format_value(buf, IIO_VAL_INT_64, ARRAY_SIZE(values), values);
 	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-4294967295\n");
 
-	value = LLONG_MAX;
-	values[0] = lower_32_bits(value);
-	values[1] = upper_32_bits(value);
+	iio_val_s64_decompose(LLONG_MAX, &values[0], &values[1]);
 	ret = iio_format_value(buf, IIO_VAL_INT_64, ARRAY_SIZE(values), values);
 	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "9223372036854775807\n");
 
-	value = LLONG_MIN;
-	values[0] = lower_32_bits(value);
-	values[1] = upper_32_bits(value);
+	iio_val_s64_decompose(LLONG_MIN, &values[0], &values[1]);
 	ret = iio_format_value(buf, IIO_VAL_INT_64, ARRAY_SIZE(values), values);
 	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-9223372036854775808\n");
 }
 
+static void iio_test_iio_format_value_decimal_64(struct kunit *test)
+{
+	int values[2];
+	char *buf;
+	int ret;
+
+	buf = kunit_kmalloc(test, PAGE_SIZE, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf);
+
+	/* DECIMAL64_MILLI: positive >= 1, value 1.234 */
+	iio_val_s64_decompose(1234, &values[0], &values[1]);
+	ret = iio_format_value(buf, IIO_VAL_DECIMAL64_MILLI, ARRAY_SIZE(values), values);
+	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "1.234\n");
+
+	/* DECIMAL64_MICRO: positive >= 1, value 3.141592 */
+	iio_val_s64_decompose(3141592, &values[0], &values[1]);
+	ret = iio_format_value(buf, IIO_VAL_DECIMAL64_MICRO, ARRAY_SIZE(values), values);
+	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "3.141592\n");
+
+	/* DECIMAL64_MILLI: positive < 1, value 0.042 */
+	iio_val_s64_decompose(42, &values[0], &values[1]);
+	ret = iio_format_value(buf, IIO_VAL_DECIMAL64_MILLI, ARRAY_SIZE(values), values);
+	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "0.042\n");
+
+	/* DECIMAL64_MILLI: negative <= -1, value -1.234 */
+	iio_val_s64_decompose(-1234, &values[0], &values[1]);
+	ret = iio_format_value(buf, IIO_VAL_DECIMAL64_MILLI, ARRAY_SIZE(values), values);
+	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-1.234\n");
+
+	/* DECIMAL64_MILLI: negative > -1, value -0.123 */
+	iio_val_s64_decompose(-123, &values[0], &values[1]);
+	ret = iio_format_value(buf, IIO_VAL_DECIMAL64_MILLI, ARRAY_SIZE(values), values);
+	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-0.123\n");
+
+	/* DECIMAL64_MILLI: zero */
+	iio_val_s64_decompose(0, &values[0], &values[1]);
+	ret = iio_format_value(buf, IIO_VAL_DECIMAL64_MILLI, ARRAY_SIZE(values), values);
+	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "0.000\n");
+
+	/* DECIMAL64_NANO: value 1.000000001 */
+	iio_val_s64_decompose(1000000001, &values[0], &values[1]);
+	ret = iio_format_value(buf, IIO_VAL_DECIMAL64_NANO, ARRAY_SIZE(values), values);
+	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "1.000000001\n");
+
+	/* DECIMAL64_MICRO: large value using upper 32 bits */
+	iio_val_s64_decompose(5000000000000042LL, &values[0], &values[1]);
+	ret = iio_format_value(buf, IIO_VAL_DECIMAL64_MICRO, ARRAY_SIZE(values), values);
+	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "5000000000.000042\n");
+
+	/* limits */
+	iio_val_s64_decompose(LLONG_MAX, &values[0], &values[1]);
+	ret = iio_format_value(buf, IIO_VAL_DECIMAL64_PICO, ARRAY_SIZE(values), values);
+	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "9223372.036854775807\n");
+	ret = iio_format_value(buf, IIO_VAL_DECIMAL64_NANO, ARRAY_SIZE(values), values);
+	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "9223372036.854775807\n");
+	ret = iio_format_value(buf, IIO_VAL_DECIMAL64_MICRO, ARRAY_SIZE(values), values);
+	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "9223372036854.775807\n");
+
+	iio_val_s64_decompose(LLONG_MIN, &values[0], &values[1]);
+	ret = iio_format_value(buf, IIO_VAL_DECIMAL64_PICO, ARRAY_SIZE(values), values);
+	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-9223372.036854775808\n");
+	ret = iio_format_value(buf, IIO_VAL_DECIMAL64_NANO, ARRAY_SIZE(values), values);
+	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-9223372036.854775808\n");
+	ret = iio_format_value(buf, IIO_VAL_DECIMAL64_MICRO, ARRAY_SIZE(values), values);
+	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-9223372036854.775808\n");
+}
+
 static struct kunit_case iio_format_test_cases[] = {
 		KUNIT_CASE(iio_test_iio_format_value_integer),
 		KUNIT_CASE(iio_test_iio_format_value_fixedpoint),
@@ -257,6 +309,7 @@ static struct kunit_case iio_format_test_cases[] = {
 		KUNIT_CASE(iio_test_iio_format_value_fractional_log2),
 		KUNIT_CASE(iio_test_iio_format_value_multiple),
 		KUNIT_CASE(iio_test_iio_format_value_integer_64),
+		KUNIT_CASE(iio_test_iio_format_value_decimal_64),
 		{ }
 };
 

-- 
2.43.0


