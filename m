Received: from out-2z4y-a139.jellyfish.systems (out-2z4y-a139.jellyfish.systems [198.54.127.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918AC44A3F3
	for <linux-iio@vger.kernel.org>; Mon, 31 Aug 2026 16:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788193629; cv=none; b=P9QPCsH2FDBXT3ZGkAmGRKPxleUyXmD45ySIIKS4P8A07Pu78TiTheQq30ZTdvXEokY3tsijXklNmgBnCpY9XFspYON9ackqocaWGCGvt+ApQ1Pft32KYp8jQB0nUvZICFPuYvKF7J5s//qNMQcgoSlEZlcUusrWvBwjTfzLFPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788193629; c=relaxed/simple;
	bh=cT4su7834oe1cDhDtm3Z1O0puBE9pZtp7GN8lB5AtNk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UsgkuGaqf4ZdMC1p+Yte/0gz85EJ05pdXStajrPzm3cx/wmwqyZehHhmQUvDdZ06GUYZLKQpFhtcEsArbNL0yO7CRMxNgU0P4KE1lpm6M/zRnHhUYbLQN/mdRPDT8q5d6RxuoIidipWOSmXVfZyfzAeP1qWmvj3JVzCB2wFLFbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gurudas.dev; spf=pass smtp.mailfrom=gurudas.dev; dkim=pass (2048-bit key) header.d=gurudas.dev header.i=@gurudas.dev header.b=Q53sFcUD; arc=none smtp.client-ip=198.54.127.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gurudas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gurudas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gurudas.dev header.i=@gurudas.dev header.b="Q53sFcUD"
Received: from [192.168.1.106] (107-194-158-19.lightspeed.sntcca.sbcglobal.net [107.194.158.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4hYZBn4W5mz2xB0;
	Mon, 31 Aug 2026 16:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gurudas.dev;
	s=spacemail; t=1788193619;
	bh=9/pnXXu42c1SsaCh/C97k7+pe5SrUF1Y0XulTf+Z6Sw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Q53sFcUDU9QoHj+3ujyMg5B+ZhjI5OOEraNNrB5lXiBnacWzeWB3FJg/uSNBsR7nY
	 vgy05s4W+4be6F9Z30XqrPbnGQYU+kxZQ2WTSCd5fu2nOseGSaeu2iTycZMd7FOhE2
	 kc1SJ2CRN8TisGYgQRuO5ke8dHKFAi93Xs4alzqVrVtdOL24wkADna/9OXUUYnDwDx
	 JwEcdMZPBP1jSsS65rWJBp5oHcyoxRfrA/i45NRQQba9MvEa9u6eVMEEQqV04FtTmd
	 YgyCD7nSSYbkpD+oo1Nh50YSGSw+sHbTfuZxxZyz4DWDY7ivCndZPCEV4/xwdRq7Rx
	 o77HyzrlZTUxQ==
From: Guru Das Srinagesh <linux@gurudas.dev>
Date: Mon, 31 Aug 2026 09:26:29 -0700
Subject: [PATCH v3 2/3] lib/tests: Add in_range_inclusive() KUnit test
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-minmax-in-range-incl-v3-2-30444a2fd2a5@gurudas.dev>
References: <20260831-minmax-in-range-incl-v3-0-30444a2fd2a5@gurudas.dev>
In-Reply-To: <20260831-minmax-in-range-incl-v3-0-30444a2fd2a5@gurudas.dev>
To: Alex Lanzano <lanzano.alex@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Gustavo Silva <gustavograzs@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 Guru Das Srinagesh <linux@gurudas.dev>
X-Mailer: b4 0.15.2
X-Envelope-From: linux@gurudas.dev

Add a KUnit test for the minmax.h in_range_inclusive() logic.

Assisted-by: Claude-Code:claude-opus-5
Signed-off-by: Guru Das Srinagesh <linux@gurudas.dev>
---
 lib/Kconfig.debug                    |  18 +++
 lib/tests/Makefile                   |   1 +
 lib/tests/in_range_inclusive_kunit.c | 249 +++++++++++++++++++++++++++++++++++
 3 files changed, 268 insertions(+)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 1244dcac2294..88f5abc70266 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -3031,6 +3031,24 @@ config MIN_HEAP_KUNIT_TEST
 
 	  If unsure, say N
 
+config IN_RANGE_INCLUSIVE_KUNIT_TEST
+	tristate "Test minmax in_range_inclusive() logic" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  Enable this option to build the in_range_inclusive KUnit module.
+	  It tests the in_range_inclusive() logic.
+
+	  KUnit tests run during boot and output the results to the debug log
+	  in TAP format (http://testanything.org/). Only useful for kernel devs
+	  running the KUnit test harness, and not intended for inclusion into a
+	  production build.
+
+	  For more information on KUnit and unit tests in general please refer
+	  to the KUnit documentation in Documentation/dev-tools/kunit/.
+
+	  If unsure, say N.
+
 config IS_SIGNED_TYPE_KUNIT_TEST
 	tristate "Test is_signed_type() macro" if !KUNIT_ALL_TESTS
 	depends on KUNIT
diff --git a/lib/tests/Makefile b/lib/tests/Makefile
index 4ead57602eac..866b6006413d 100644
--- a/lib/tests/Makefile
+++ b/lib/tests/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_GLOB_KUNIT_TEST) += glob_kunit.o
 obj-$(CONFIG_HASHTABLE_KUNIT_TEST) += hashtable_test.o
 obj-$(CONFIG_HASH_KUNIT_TEST) += test_hash.o
 obj-$(CONFIG_TEST_IOV_ITER) += kunit_iov_iter.o
+obj-$(CONFIG_IN_RANGE_INCLUSIVE_KUNIT_TEST) += in_range_inclusive_kunit.o
 obj-$(CONFIG_IS_SIGNED_TYPE_KUNIT_TEST) += is_signed_type_kunit.o
 obj-$(CONFIG_KPROBES_SANITY_TEST) += test_kprobes.o
 obj-$(CONFIG_LIST_KUNIT_TEST) += list-test.o
diff --git a/lib/tests/in_range_inclusive_kunit.c b/lib/tests/in_range_inclusive_kunit.c
new file mode 100644
index 000000000000..83e8d48684f2
--- /dev/null
+++ b/lib/tests/in_range_inclusive_kunit.c
@@ -0,0 +1,249 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Test cases for minmax in_range_inclusive() helpers.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <kunit/test.h>
+#include <linux/minmax.h>
+
+/*
+ * When @min <= @max is valid in:
+ *        Valid in reading   Example    'True' range is
+ * Case 1 Both readings      [5, 10]     interval as written in either reading
+ * Case 2 Signed only        [-10, 5]    signed interval
+ * Case 3 Unsigned only      [5, -10]    unsigned interval
+ * Case 4 Neither reading    [-5, -10]   neither; all values except [unsigned(-9), unsigned(-6)]
+ *
+ * Visualizing the wraparound-continuous unsigned number scale as a full circle with
+ * 0 at 12 o'clock and S32_MAX/S64_MAX at 6 o'clock, with ranges being calculated
+ * only clockwise starting from @min until @max might help greatly in understanding
+ * the following true and false ranges.
+ */
+static void u32_tests(struct kunit *test)
+{
+	/* Case 1 first true value */
+	KUNIT_EXPECT_TRUE(test, in_range_inclusive(5, 5, 10));
+	/* Case 1 last true value */
+	KUNIT_EXPECT_TRUE(test, in_range_inclusive(10, 5, 10));
+	/* Case 1 first false value */
+	KUNIT_EXPECT_FALSE(test, in_range_inclusive(11, 5, 10));
+	/* Case 1 last false value */
+	KUNIT_EXPECT_FALSE(test, in_range_inclusive(4, 5, 10));
+	/* Case 1 0 not in range */
+	KUNIT_EXPECT_FALSE(test, in_range_inclusive(0, 5, 10));
+	/* Case 1 U32_MAX not in range */
+	KUNIT_EXPECT_FALSE(test, in_range_inclusive(U32_MAX, 5, 10));
+
+	/* Case 2 first true value */
+	KUNIT_EXPECT_TRUE(test, in_range_inclusive(-10, -10, 5));
+	/* Case 2 last true value */
+	KUNIT_EXPECT_TRUE(test, in_range_inclusive(5, -10, 5));
+	/* Case 2 first false value */
+	KUNIT_EXPECT_FALSE(test, in_range_inclusive(6, -10, 5));
+	/* Case 2 last false value */
+	KUNIT_EXPECT_FALSE(test, in_range_inclusive(-11, -10, 5));
+	/* Case 2 0 in range */
+	KUNIT_EXPECT_TRUE(test, in_range_inclusive(0, -10, 5));
+	/* Case 2 U32_MAX in range */
+	KUNIT_EXPECT_TRUE(test, in_range_inclusive(U32_MAX, -10, 5));
+
+	/* Case 3 first true value */
+	KUNIT_EXPECT_TRUE(test, in_range_inclusive(5, 5, -10));
+	/* Case 3 last true value */
+	KUNIT_EXPECT_TRUE(test, in_range_inclusive(-10, 5, -10));
+	/* Case 3 first false value */
+	KUNIT_EXPECT_FALSE(test, in_range_inclusive(-9, 5, -10));
+	/* Case 3 last false value */
+	KUNIT_EXPECT_FALSE(test, in_range_inclusive(4, 5, -10));
+	/* Case 3 0 not in range */
+	KUNIT_EXPECT_FALSE(test, in_range_inclusive(0, 5, -10));
+	/* Case 3 U32_MAX not in range */
+	KUNIT_EXPECT_FALSE(test, in_range_inclusive(U32_MAX, 5, -10));
+
+	/* Case 4 first true value */
+	KUNIT_EXPECT_TRUE(test, in_range_inclusive(-5, -5, -10));
+	/* Case 4 last true value */
+	KUNIT_EXPECT_TRUE(test, in_range_inclusive(-10, -5, -10));
+	/* Case 4 first false value */
+	KUNIT_EXPECT_FALSE(test, in_range_inclusive(-9, -5, -10));
+	/* Case 4 last false value */
+	KUNIT_EXPECT_FALSE(test, in_range_inclusive(-6, -5, -10));
+	/* Case 4 0 in range */
+	KUNIT_EXPECT_TRUE(test, in_range_inclusive(0, -5, -10));
+	/* Case 4 U32_MAX in range */
+	KUNIT_EXPECT_TRUE(test, in_range_inclusive(U32_MAX, -5, -10));
+}
+
+static void u64_tests(struct kunit *test)
+{
+	/* Case 1 first true value */
+	KUNIT_EXPECT_TRUE(test, in_range_inclusive(5ULL, 5ULL, 10ULL));
+	/* Case 1 last true value */
+	KUNIT_EXPECT_TRUE(test, in_range_inclusive(10ULL, 5ULL, 10ULL));
+	/* Case 1 first false value */
+	KUNIT_EXPECT_FALSE(test, in_range_inclusive(11ULL, 5ULL, 10ULL));
+	/* Case 1 last false value */
+	KUNIT_EXPECT_FALSE(test, in_range_inclusive(4ULL, 5ULL, 10ULL));
+	/* Case 1 0 not in range */
+	KUNIT_EXPECT_FALSE(test, in_range_inclusive(0ULL, 5ULL, 10ULL));
+	/* Case 1 U64_MAX not in range */
+	KUNIT_EXPECT_FALSE(test, in_range_inclusive(U64_MAX, 5ULL, 10ULL));
+
+	/* Case 2 first true value */
+	KUNIT_EXPECT_TRUE(test, in_range_inclusive(-10ULL, -10ULL, 5ULL));
+	/* Case 2 last true value */
+	KUNIT_EXPECT_TRUE(test, in_range_inclusive(5ULL, -10ULL, 5ULL));
+	/* Case 2 first false value */
+	KUNIT_EXPECT_FALSE(test, in_range_inclusive(6ULL, -10ULL, 5ULL));
+	/* Case 2 last false value */
+	KUNIT_EXPECT_FALSE(test, in_range_inclusive(-11ULL, -10ULL, 5ULL));
+	/* Case 2 0 in range */
+	KUNIT_EXPECT_TRUE(test, in_range_inclusive(0ULL, -10ULL, 5ULL));
+	/* Case 2 U64_MAX in range */
+	KUNIT_EXPECT_TRUE(test, in_range_inclusive(U64_MAX, -10ULL, 5ULL));
+
+	/* Case 3 first true value */
+	KUNIT_EXPECT_TRUE(test, in_range_inclusive(5ULL, 5ULL, -10ULL));
+	/* Case 3 last true value */
+	KUNIT_EXPECT_TRUE(test, in_range_inclusive(-10ULL, 5ULL, -10ULL));
+	/* Case 3 first false value */
+	KUNIT_EXPECT_FALSE(test, in_range_inclusive(-9ULL, 5ULL, -10ULL));
+	/* Case 3 last false value */
+	KUNIT_EXPECT_FALSE(test, in_range_inclusive(4ULL, 5ULL, -10ULL));
+	/* Case 3 0 not in range */
+	KUNIT_EXPECT_FALSE(test, in_range_inclusive(0ULL, 5ULL, -10ULL));
+	/* Case 3 U64_MAX not in range */
+	KUNIT_EXPECT_FALSE(test, in_range_inclusive(U64_MAX, 5ULL, -10ULL));
+
+	/* Case 4 first true value */
+	KUNIT_EXPECT_TRUE(test, in_range_inclusive(-5ULL, -5ULL, -10ULL));
+	/* Case 4 last true value */
+	KUNIT_EXPECT_TRUE(test, in_range_inclusive(-10ULL, -5ULL, -10ULL));
+	/* Case 4 first false value */
+	KUNIT_EXPECT_FALSE(test, in_range_inclusive(-9ULL, -5ULL, -10ULL));
+	/* Case 4 last false value */
+	KUNIT_EXPECT_FALSE(test, in_range_inclusive(-6ULL, -5ULL, -10ULL));
+	/* Case 4 0 in range */
+	KUNIT_EXPECT_TRUE(test, in_range_inclusive(0ULL, -5ULL, -10ULL));
+	/* Case 4 U64_MAX in range */
+	KUNIT_EXPECT_TRUE(test, in_range_inclusive(U64_MAX, -5ULL, -10ULL));
+}
+
+/* Check whether sizeof logic to select 32- vs 64-bit comparisons works */
+static void sizeof_logic_tests(struct kunit *test)
+{
+	u64 u64_val    = BIT_ULL(32) | 7;
+	u64 u64_minval = BIT_ULL(32) | 5;
+	u64 u64_maxval = BIT_ULL(32) | 10;
+	u32 u32_minval = 5, u32_maxval = 10, u32_val = 100;
+
+	/* If sizeof trick does not work:
+	 * - u64_val will get truncated to 7
+	 * - 7 is in [5, 10] so test should pass.
+	 */
+	KUNIT_EXPECT_FALSE(test, in_range_inclusive(u64_val, u32_minval, u32_maxval));
+
+	/*
+	 * If sizeof trick does not work:
+	 * - u64_maxval will get truncated to 10
+	 * - 100 is not in [5, 10], so test should fail.
+	 */
+	KUNIT_EXPECT_TRUE(test, in_range_inclusive(u32_val, u32_minval, u64_maxval));
+
+	/*
+	 * If sizeof trick does not work:
+	 * - u64_minval gets truncated to 5
+	 * - 0 is not in [5, 10], so test should fail.
+	 * Otherwise:
+	 * - @min > @max here, so this is Case 4
+	 * - 0 should be in range and test should pass.
+	 */
+	KUNIT_EXPECT_TRUE(test, in_range_inclusive(0, u64_minval, u32_maxval));
+}
+
+/*
+ * Each argument is widened to the selected width according to its own type:
+ * signed arguments sign-extend, unsigned ones zero-extend. The same written
+ * values can therefore give opposite answers depending on the declared types.
+ */
+static void sign_extension_tests(struct kunit *test)
+{
+	u32 u32_val = -9;
+	s32 s32_val = -9;
+	s32 s32_minval = 5, s32_maxval = -10;
+	s64 s64_minval = 5, s64_maxval = -10;
+
+	/* Case 3 range. -9 is out of range in both readings */
+	KUNIT_EXPECT_FALSE(test, in_range_inclusive(u32_val, s32_minval, s32_maxval));
+	KUNIT_EXPECT_FALSE(test, in_range_inclusive(s32_val, s32_minval, s32_maxval));
+
+	/*
+	 * Sign extension kicks in due to sizeof logic. minval "stays in place"
+	 * because it is positive and maxval "moves" because it is negative and
+	 * signed, thereby increasing the True range.
+	 * Negative unsigned -9 "stays in place", so it becomes in range.
+	 * Negative signed -9 "moves", so it still remains out of range.
+	 */
+	KUNIT_EXPECT_TRUE(test, in_range_inclusive(u32_val, s64_minval, s64_maxval));
+	KUNIT_EXPECT_FALSE(test, in_range_inclusive(s32_val, s64_minval, s64_maxval));
+}
+
+#define TEST_RANGE_MIN 0
+#define TEST_RANGE_MAX 100
+static void misc_tests(struct kunit *test)
+{
+	s32 s32_val = -5;
+
+	/*
+	 * Test common device driver use case of rejecting negative input from
+	 * userspace.
+	 */
+	KUNIT_EXPECT_FALSE(test, in_range_inclusive(s32_val, TEST_RANGE_MIN, TEST_RANGE_MAX));
+
+	/* If min == max, only one true solution exists, val = min */
+	KUNIT_EXPECT_TRUE(test,  in_range_inclusive(5, 5, 5));
+	KUNIT_EXPECT_FALSE(test, in_range_inclusive(0, 5, 5));
+	KUNIT_EXPECT_FALSE(test, in_range_inclusive(U32_MAX, 5, 5));
+	KUNIT_EXPECT_FALSE(test, in_range_inclusive(U64_MAX, 5, 5));
+
+	/*
+	 * When max = (min - 1), Case 4 kicks in, and there is no 'false' range,
+	 * i.e. all values of val result in 'true'.
+	 */
+	KUNIT_EXPECT_TRUE(test,  in_range_inclusive(5, 5, 4));
+	KUNIT_EXPECT_TRUE(test,  in_range_inclusive(4, 5, 4));
+	KUNIT_EXPECT_TRUE(test,  in_range_inclusive(0, 5, 4));
+	KUNIT_EXPECT_TRUE(test,  in_range_inclusive(U32_MAX, 5, 4));
+	KUNIT_EXPECT_TRUE(test,  in_range_inclusive(U64_MAX, 5, 4));
+
+	/*
+	 * [0, U32_MAX] and [0, U64_MAX] are both the same case as above with
+	 * min = 0 and max = (min - 1)
+	 */
+	KUNIT_EXPECT_TRUE(test,  in_range_inclusive(0, 0, U32_MAX));
+	KUNIT_EXPECT_TRUE(test,  in_range_inclusive(U32_MAX, 0, U32_MAX));
+	KUNIT_EXPECT_TRUE(test,  in_range_inclusive(0, 0, U64_MAX));
+	KUNIT_EXPECT_TRUE(test,  in_range_inclusive(U64_MAX, 0, U64_MAX));
+}
+
+static struct kunit_case in_range_incl_test_cases[] = {
+	KUNIT_CASE(u32_tests),
+	KUNIT_CASE(u64_tests),
+	KUNIT_CASE(sizeof_logic_tests),
+	KUNIT_CASE(sign_extension_tests),
+	KUNIT_CASE(misc_tests),
+	{}
+};
+
+static struct kunit_suite in_range_incl_test_suite = {
+	.name = "in_range_inclusive",
+	.test_cases = in_range_incl_test_cases,
+};
+
+kunit_test_suites(&in_range_incl_test_suite);
+
+MODULE_AUTHOR("Guru Das Srinagesh <linux@gurudas.dev>");
+MODULE_DESCRIPTION("Test cases for in_range_inclusive()");
+MODULE_LICENSE("GPL");

-- 
2.55.0

