Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE0E385503;
	Sun, 10 May 2026 12:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778416955; cv=none; b=UiR4rRGMvxXNP3lS4HLCzvDhwByIaXNYRncfmEQ6Y0SOnlIwQJ3K/xEfNahCBEMQ2Wgqyrmaz6OpS2H6C7nHmvPWDp6J/KGj+TwUMIKyIGwgD6/QOw6lOu9AkIYsEUbwPDRqX0F31GxyUD5S+J8OCZCU0rFjy8ujgV3Zl+9/aco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778416955; c=relaxed/simple;
	bh=Gl8BKoBCF2V77XMlkR0lJ8OgLBba8DD++QnrWkI3lII=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tcqQ92R3X1DS8bfaKCZr49bgu5q8sAUKaYYZM5+ig67NzHa4xgZ4Br1LllbhS52KXhOTy+hpTKl+XYoOFsspG05EwfMRaz3tDv7RYrTPGITtci67VSU0v/0RZKZeE2SCCICS22mV0rjucmSRheCCN42m821NrYqrO49mMKYdaAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uyt3+HUL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uyt3+HUL"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CD538C2BCFF;
	Sun, 10 May 2026 12:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778416954;
	bh=Gl8BKoBCF2V77XMlkR0lJ8OgLBba8DD++QnrWkI3lII=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=uyt3+HULzb/ZvTir9w0MyJ6hGMGhPALucCsudUSIcGXat2phBDUtfqvudpmJ2zmdN
	 5IEuk6Wbf4k45a7fY0byeHZFJtYjnWTU42/UEFTRDxDlpYCP159GcP0mpWxQtCuzAp
	 vHqDNKymIbSzdGY5qXNI5Q1kZv8rk3BUNtoFCPJ6nzyr9yz0TpjLlwGCbwM9LQCE+2
	 Y59q5T50x6U2+RfJmFS0OdXYkImPflbTnOqYbRzVwra78dsE1qQwea94ixpxMIiG6I
	 9wJ/VcyStxUvWQUIgWd/N3xqP+6p2zg4lmqwOdlwexzfRPLbDTI2eyXbYt5z0bTLt6
	 tSnSa//KslV6Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C60C4CD37B2;
	Sun, 10 May 2026 12:42:34 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Sun, 10 May 2026 13:42:24 +0100
Subject: [PATCH v12 06/11] iio: test: iio-test-format: add test case for
 decimal format
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260510-adf41513-iio-driver-v12-6-34af2ed2779f@analog.com>
References: <20260510-adf41513-iio-driver-v12-0-34af2ed2779f@analog.com>
In-Reply-To: <20260510-adf41513-iio-driver-v12-0-34af2ed2779f@analog.com>
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778416952; l=6713;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=z+7GfhAI5DqW1tt8XtRcWYlfgn90H7P6U7JnxowjBIY=;
 b=rosVWnu/BVQ45ooeXPO0lM/LTnifqRhCbdPXxs/qkKJnvRAoiIs83Z6s+/h4y8lt5gnJ8dGNH
 5DJUpIe03vtBRJUEuEvK+S/e/EyC/vDIHYw7+X5Ds9Ai/p4bPWHkOtr
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Add iio_test_iio_format_value_decimal_64() kunit test case for decimal
value formatting, exploring different scales types. Also, the same
iio_val_s64_array_populate() macro used to populate local array is used in
iio_test_iio_format_value_integer_64().

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/test/iio-test-format.c | 97 +++++++++++++++++++++++++++++---------
 1 file changed, 75 insertions(+), 22 deletions(-)

diff --git a/drivers/iio/test/iio-test-format.c b/drivers/iio/test/iio-test-format.c
index 872dd8582003..a2a9b4360c92 100644
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
+	iio_val_s64_array_populate(24, values);
 	ret = iio_format_value(buf, IIO_VAL_INT_64, ARRAY_SIZE(values), values);
 	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "24\n");
 
-	value = -24;
-	values[0] = lower_32_bits(value);
-	values[1] = upper_32_bits(value);
+	iio_val_s64_array_populate(-24, values);
 	ret = iio_format_value(buf, IIO_VAL_INT_64, ARRAY_SIZE(values), values);
 	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-24\n");
 
-	value = 0;
-	values[0] = lower_32_bits(value);
-	values[1] = upper_32_bits(value);
+	iio_val_s64_array_populate(0, values);
 	ret = iio_format_value(buf, IIO_VAL_INT_64, ARRAY_SIZE(values), values);
 	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "0\n");
 
-	value = UINT_MAX;
-	values[0] = lower_32_bits(value);
-	values[1] = upper_32_bits(value);
+	iio_val_s64_array_populate(UINT_MAX, values);
 	ret = iio_format_value(buf, IIO_VAL_INT_64, ARRAY_SIZE(values), values);
 	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "4294967295\n");
 
-	value = -((s64)UINT_MAX);
-	values[0] = lower_32_bits(value);
-	values[1] = upper_32_bits(value);
+	iio_val_s64_array_populate(-((s64)UINT_MAX), values);
 	ret = iio_format_value(buf, IIO_VAL_INT_64, ARRAY_SIZE(values), values);
 	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-4294967295\n");
 
-	value = LLONG_MAX;
-	values[0] = lower_32_bits(value);
-	values[1] = upper_32_bits(value);
+	iio_val_s64_array_populate(LLONG_MAX, values);
 	ret = iio_format_value(buf, IIO_VAL_INT_64, ARRAY_SIZE(values), values);
 	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "9223372036854775807\n");
 
-	value = LLONG_MIN;
-	values[0] = lower_32_bits(value);
-	values[1] = upper_32_bits(value);
+	iio_val_s64_array_populate(LLONG_MIN, values);
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
+	iio_val_s64_array_populate(1234, values);
+	ret = iio_format_value(buf, IIO_VAL_DECIMAL64_MILLI, ARRAY_SIZE(values), values);
+	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "1.234\n");
+
+	/* DECIMAL64_MICRO: positive >= 1, value 3.141592 */
+	iio_val_s64_array_populate(3141592, values);
+	ret = iio_format_value(buf, IIO_VAL_DECIMAL64_MICRO, ARRAY_SIZE(values), values);
+	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "3.141592\n");
+
+	/* DECIMAL64_MILLI: positive < 1, value 0.042 */
+	iio_val_s64_array_populate(42, values);
+	ret = iio_format_value(buf, IIO_VAL_DECIMAL64_MILLI, ARRAY_SIZE(values), values);
+	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "0.042\n");
+
+	/* DECIMAL64_MILLI: negative <= -1, value -1.234 */
+	iio_val_s64_array_populate(-1234, values);
+	ret = iio_format_value(buf, IIO_VAL_DECIMAL64_MILLI, ARRAY_SIZE(values), values);
+	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-1.234\n");
+
+	/* DECIMAL64_MILLI: negative > -1, value -0.123 */
+	iio_val_s64_array_populate(-123, values);
+	ret = iio_format_value(buf, IIO_VAL_DECIMAL64_MILLI, ARRAY_SIZE(values), values);
+	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-0.123\n");
+
+	/* DECIMAL64_MILLI: zero */
+	iio_val_s64_array_populate(0, values);
+	ret = iio_format_value(buf, IIO_VAL_DECIMAL64_MILLI, ARRAY_SIZE(values), values);
+	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "0.000\n");
+
+	/* DECIMAL64_NANO: value 1.000000001 */
+	iio_val_s64_array_populate(1000000001, values);
+	ret = iio_format_value(buf, IIO_VAL_DECIMAL64_NANO, ARRAY_SIZE(values), values);
+	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "1.000000001\n");
+
+	/* DECIMAL64_MICRO: large value using upper 32 bits */
+	iio_val_s64_array_populate(5000000000000042LL, values);
+	ret = iio_format_value(buf, IIO_VAL_DECIMAL64_MICRO, ARRAY_SIZE(values), values);
+	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "5000000000.000042\n");
+
+	/* limits */
+	iio_val_s64_array_populate(LLONG_MAX, values);
+	ret = iio_format_value(buf, IIO_VAL_DECIMAL64_PICO, ARRAY_SIZE(values), values);
+	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "9223372.036854775807\n");
+	ret = iio_format_value(buf, IIO_VAL_DECIMAL64_NANO, ARRAY_SIZE(values), values);
+	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "9223372036.854775807\n");
+	ret = iio_format_value(buf, IIO_VAL_DECIMAL64_MICRO, ARRAY_SIZE(values), values);
+	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "9223372036854.775807\n");
+
+	iio_val_s64_array_populate(LLONG_MIN, values);
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


