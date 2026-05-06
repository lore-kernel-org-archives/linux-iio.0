Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E82480DF3;
	Wed,  6 May 2026 14:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778076530; cv=none; b=fl6KG5ol+LtJ/Hn6x8kKFwxw+xuevGMpne+czuCr72FqVDIKU0XXWAimnkl/9Cy4pBTGLDtoPfYG/onbop5tzSjOElCPIR/QoVfSEGtc0Ioa+vepaevOsPxy+8ozi0GL0kPQCnhRX+8sdBxkJC4UvaSHN7Xs/aVlUcajug6ZXo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778076530; c=relaxed/simple;
	bh=Gl8BKoBCF2V77XMlkR0lJ8OgLBba8DD++QnrWkI3lII=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xz/3GmmgrLNM3+N2ELL3nPcMfh4Scz4RPmtTSU+e5KLqJ8VG7fxq6SZRxE3cFG7AWWsPxwGQ1dNZq7w0vnkRwxU3VtEFr1f4fOhZA9rt/UDh0pplyAYXQPndkJ/UeGPY6hiVNvXlm0MvMSBgos10QM4VZBXXwbG9+zvPWBH4Bw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nvw/gF3h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nvw/gF3h"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E4347C2BCB8;
	Wed,  6 May 2026 14:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778076529;
	bh=Gl8BKoBCF2V77XMlkR0lJ8OgLBba8DD++QnrWkI3lII=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Nvw/gF3hfUynXz6tptg3S2E6fAzWksnmZoqvcKaXRUXGahYyxZNcg6eQdN+woXirW
	 xJqdywkHrgg6nhR7jWMEG6DPF93FrO+5DOXMbT7QLD61+ADplTryYmLSEfBnTtY7Pq
	 f8HtQzi0UgNwJxByxSzCzrBzSJNf8db6hQhjuCyV76l0BX2wHGImkQ420a8vqKAmcc
	 wAdksAYFzGFewBAMurriDFX5DDPCmWrThi5ZYDPMjGf/FSoyDNtNUWIMsWzVS6UsFw
	 ipI/S9ciLUgl5w0wHED0jAWEtGkau4jpgUwRKPnay9VOekR5ip4220RIp/POyiZ2rO
	 b0Uvp2xu5ZrSw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF94CD3440;
	Wed,  6 May 2026 14:08:49 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Wed, 06 May 2026 15:08:50 +0100
Subject: [PATCH v11 06/11] iio: test: iio-test-format: add test case for
 decimal format
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260506-adf41513-iio-driver-v11-6-2b7e99cfe8f2@analog.com>
References: <20260506-adf41513-iio-driver-v11-0-2b7e99cfe8f2@analog.com>
In-Reply-To: <20260506-adf41513-iio-driver-v11-0-2b7e99cfe8f2@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778076527; l=6713;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=z+7GfhAI5DqW1tt8XtRcWYlfgn90H7P6U7JnxowjBIY=;
 b=3taw+yRsVxNV6hfa4hTR+thxtTRKHmy1Zlu8TNvtDSsjdm0hDwExoqp7z3qcw20k09NqgGm/8
 fYqQdISVywfA5FqRRLayL1Kud0BKnZSEFdgO5v2btIpU9Mvam7L23KC
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


