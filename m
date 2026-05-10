Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902E7382F2C;
	Sun, 10 May 2026 12:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778416954; cv=none; b=mkaTtndeuwGnRQsPy1ZMljeX3vO2hRFxXifBe/T9RU8f8kfhfTYbTCynamjkKgPhKwJRPDP/TMCxuyeo/SFtlVtkeU9sVyeb1J+UveekvL16/3gQpk9dcngADR59mgtNxVrrUqRnLuAif4AYImiWdlQ0prcV2aZLfncasG4yC7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778416954; c=relaxed/simple;
	bh=tYSiChWY60UEfjkPSWHZ7WrCYK8Mvc1/d8kd0bxtPTE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R7jtJr0hJ6zlwRsU/kgm5N9ySQ0PIBSjhl9et6Uu/ozucYuFFmNYjtWtK6Su3Yo60UagqAeGN4QHPrLw7UEN34GaA7eRXh2kZv7vcBVrqHrz6XacoyC2IYXs9+y/22t5XBLgi9ZT2cBN8BhPnvCgKmFB8uG/+w+PgnHqKq01mmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VrZN5J1a; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VrZN5J1a"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6AD5AC2BCF6;
	Sun, 10 May 2026 12:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778416954;
	bh=tYSiChWY60UEfjkPSWHZ7WrCYK8Mvc1/d8kd0bxtPTE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=VrZN5J1alRyS+zmf6zlktVp3hcGSc2bqY7HayZqGzuu8TY+7H/qthbGelDRa5IIpu
	 V2PxV33bwGYzDTB2O2ORFwxxJ45u+FJX5/DqdK8FWuJH5ntEtnTIMB8MH7t4vFyNvZ
	 BFuAiE5AL+rIuuzIQ4FANLbXSOVPtQh13aCO2lzCC5Vwi09+AsFBZb44xpX/3l4tov
	 aR1fKwqWnIsSBAnMDJcoDWuzrJRl8Tnp06yIaNOHqq08EE8zV+vdux9R/TE5Yx8bir
	 9y5RNSApmCzUSskN+zebW054F2ihYmz8nxt18BVG8bNpxny/305OIbb3leRJVJJbKW
	 bpQ9xFuy+OicQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C18CD37B2;
	Sun, 10 May 2026 12:42:34 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Sun, 10 May 2026 13:42:21 +0100
Subject: [PATCH v12 03/11] lib: test-kstrtox: tests for kstrtodec64() and
 kstrtoudec64()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260510-adf41513-iio-driver-v12-3-34af2ed2779f@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778416952; l=4968;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=tp8hvAbYc3biI7q7ogMTaReytHsO+RY7GLMjwvwZ1gQ=;
 b=RlX373AAEsBs94YJMspcrz/WSoeNdrtvbjWD/f9Mk5Mq4BGITzHRhwa+l19NmP+kta7gdQFrY
 N5BCUlN9IkeBRt6IHNICbm7tcaKvqbQN8QhdcwkjGjK/r/PqNCMW3RQ
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Add tests for decimal parsing helpers kstrtodec64() and kstrtoudec64().
The test infrastructure is reused from other kstrto*() functions, i.e.,
the decimal parsers have fixed base of 10, so base field is used as
scale input for the helpers.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 lib/test-kstrtox.c | 156 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 156 insertions(+)

diff --git a/lib/test-kstrtox.c b/lib/test-kstrtox.c
index ee87fef66cb5..ee9b535bcf1c 100644
--- a/lib/test-kstrtox.c
+++ b/lib/test-kstrtox.c
@@ -703,6 +703,156 @@ static void __init test_kstrtos8_fail(void)
 	TEST_FAIL(kstrtos8, s8, "%hhd", test_s8_fail);
 }
 
+static void __init test_kstrtoudec64_ok(void)
+{
+	DECLARE_TEST_OK(u64, struct test_udec64);
+	static DEFINE_TEST_OK(struct test_udec64, test_udec64_ok) = {
+		/* basic: integer.fraction, exact digits */
+		{"0.0",			1,	0},
+		{"1.5",			1,	15},
+		{"1.234",		3,	1234},
+		{"42.0",		1,	420},
+		/* zero */
+		{"0.0",			1,	0},
+		{"0.000",		3,	0},
+		/* integer only (no decimal point) */
+		{"0",			1,	0},
+		{"42",			3,	42000},
+		{"1",			1,	10},
+		/* fractional only (leading dot) */
+		{".5",			1,	5},
+		{".123",		3,	123},
+		{".001",		3,	1},
+		/* zero padding: fewer fractional digits than scale */
+		{"1.2",			3,	1200},
+		{"1.2",			6,	1200000},
+		{"0.01",		3,	10},
+		{"0.1",			9,	100000000ULL},
+		{"0.01",		9,	10000000},
+		/* truncation: more fractional digits than scale */
+		{"1.23456",		3,	1234},
+		{"3.1415926535",	6,	3141592},
+		{"0.999999999",		3,	999},
+		{"1.99",		1,	19},
+		/* trailing newline */
+		{"1.5\n",		1,	15},
+		{"42\n",		3,	42000},
+		/* plus sign */
+		{"+1.5",		1,	15},
+		{"+.5",			1,	5},
+		/* scale progression */
+		{"1.0",			1,	10},
+		{"1.00",		2,	100},
+		{"1.000",		3,	1000},
+		{"1.000000",		6,	1000000},
+		{"1.000000000",		9,	1000000000ULL},
+		/* large values spanning u64 range */
+		{"9223372036.854775807",	9,	9223372036854775807ULL},
+		{"18446744073709.551615",	6,	18446744073709551615ULL},
+	};
+	TEST_OK(kstrtoudec64, u64, "%llu", test_udec64_ok);
+}
+
+static void __init test_kstrtoudec64_fail(void)
+{
+	static DEFINE_TEST_FAIL(test_udec64_fail) = {
+		/* empty / whitespace */
+		{"",		3},
+		{"\n",		3},
+		/* invalid scale */
+		{"1.0",		21},
+		/* minus sign (unsigned) */
+		{"-1.5",	1},
+		{"-0.5",	1},
+		/* no digits after dot */
+		{"1.",		3},
+		{".",		3},
+		/* no digits at all */
+		{"+",		3},
+		/* non-digit characters */
+		{"abc",		3},
+		{"1.2x",	3},
+		/* leading/trailing space */
+		{" 1.5",	1},
+		{"1.5 ",	1},
+		/* overflow */
+		{"18446744073710.551615",	6},
+		{"99999999999999999999",	1},
+	};
+	TEST_FAIL(kstrtoudec64, u64, "%llu", test_udec64_fail);
+}
+
+static void __init test_kstrtodec64_ok(void)
+{
+	DECLARE_TEST_OK(s64, struct test_dec64);
+	static DEFINE_TEST_OK(struct test_dec64, test_dec64_ok) = {
+		/* basic positive */
+		{"0.0",			1,	0},
+		{"1.5",			1,	15},
+		{"1.234",		3,	1234},
+		/* basic negative */
+		{"-1.5",		1,	-15},
+		{"-1.234",		3,	-1234},
+		{"-0.5",		1,	-5},
+		{"-0.001",		3,	-1},
+		/* zero (signed) */
+		{"-0",			1,	0},
+		{"-0.0",		1,	0},
+		{"0.000",		3,	0},
+		/* integer only */
+		{"42",			3,	42000},
+		{"-42",			3,	-42000},
+		/* fractional only */
+		{".5",			1,	5},
+		{"-.5",			1,	-5},
+		/* zero padding */
+		{"1.2",			3,	1200},
+		{"-1.2",		3,	-1200},
+		{"0.01",		3,	10},
+		{"-0.01",		3,	-10},
+		/* truncation */
+		{"1.23456",		3,	1234},
+		{"-1.23456",		3,	-1234},
+		{"0.999999999",		3,	999},
+		{"-0.999999999",	3,	-999},
+		/* trailing newline */
+		{"1.5\n",		1,	15},
+		{"-1.5\n",		1,	-15},
+		/* plus sign */
+		{"+1.5",		1,	15},
+		/* limits */
+		{"9223372036.854775807",	9,	LLONG_MAX},
+		{"-9223372036.854775808",	9,	LLONG_MIN},
+	};
+	TEST_OK(kstrtodec64, s64, "%lld", test_dec64_ok);
+}
+
+static void __init test_kstrtodec64_fail(void)
+{
+	static DEFINE_TEST_FAIL(test_dec64_fail) = {
+		/* empty / whitespace */
+		{"",		3},
+		{"\n",		3},
+		/* invalid scale */
+		{"1.0",		21},
+		/* no digits after dot */
+		{"1.",		3},
+		{".",		3},
+		{"-.",		3},
+		/* no digits at all */
+		{"+",		3},
+		{"-",		3},
+		/* non-digit characters */
+		{"abc",		3},
+		{"-1.2x",	3},
+		/* signed overflow */
+		{"9223372036.854775808",	9},
+		{"-9223372036.854775809",	9},
+		{"99999999999999999999",	1},
+	};
+	TEST_FAIL(kstrtodec64, s64, "%lld", test_dec64_fail);
+}
+
 static int __init test_kstrtox_init(void)
 {
 	test_kstrtoull_ok();
@@ -729,6 +879,12 @@ static int __init test_kstrtox_init(void)
 	test_kstrtou8_fail();
 	test_kstrtos8_ok();
 	test_kstrtos8_fail();
+
+	test_kstrtoudec64_ok();
+	test_kstrtoudec64_fail();
+	test_kstrtodec64_ok();
+	test_kstrtodec64_fail();
+
 	return -EINVAL;
 }
 module_init(test_kstrtox_init);

-- 
2.43.0


