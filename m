Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793740631;
	b=nnWsBI5RD829ZmbMeSh46Iqfrvle2dEsynTxWPpvEs7WhGDPE9TsMPjLakDz7QB4Kkq/
	 GcAy2jBlTz5efZ6NznUiktVu21HxmBsStW8c++VGIPC1CjK09VJtyMiZLKrJCpMJXxosb
	 md7EOZSmpOEE089Htp26LB6iMiUWMzp1/FGMOyBJ0n1WJWW4kkijqLupbjBUodCZfomT9
	 db12qp5nQ30PoipwqTXqsoR0HO/TG5YoX0xSLI+s2mDFuxo6m/mlwgZRjQhQCyu0+ZYAh
	 WzZAS7xKZm4NFM+b5oF3sYks65PfDsxUePOMQLWZq+qrdBE3IU7EeRuO8WJx6Ug1tAg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793740631;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=KU9I4i4E/54jq4DTZIW07YCk6klu9D+8kZdbIy6OKeA=;
	b=OgTx27MjzQDBgTtcchkor13d1nnvgXsyEcSTu1GQExPWOISiQFU+W0f+YfmRkVPwHgmM
	 8o9HN3U0xZXQ6N2+tnP2ick/cGE6qzuNYby/dmbmDgFIxIujIP24kdJPc+zZ5UWEADGQd
	 1GRd/WzaC3qFljgAnb3iE6+H6OBjyVBu1jSSYT+jBADTM/pWjQeRbnEaq2QmhRuXPgUVh
	 d6thyoAgcsB5cGLrvIwHPAM71unIbgRQdp+KSUFv0kR38eu0eShSW3XA+1DUdId2AtOIl
	 qrWbmH5v4Gxb0XhJOICHNnEajElgi/9KPOrE9G+sDgN3JcXR8/n6H4/KDH4kfrve60w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="kOn6Dd/7";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C4D606A31B;
	Tue,  3 Nov 2026 21:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kOn6Dd/7
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793740630;
	b=z+IV4ef99Ph8L88kQO/YnH5M1DWozxYIM0ELZuX+0e0odxwg9oOUeV0xFu1oBkvP+Y32
	 EcY+SXwwfsSu6zxAob1tMF4NuJBAhZvbVGraqFF9rKb3DxZICrwLVkuzs/1WIlYo9ES1E
	 qgro+zM0kCbqPi5dzEelxdAWziV5lBP4XQO4SRFOImubIZ4rn+21MXIVo9DMGj+hGR59q
	 0UmVkibXvjLXunJT+pbkMUQhOj/7TniJudPSuK0j27v0gpzpud5NIlPOjnuSej4583wY0
	 nszUvoBW3gyxwF92L6E1Lhk2UGAHTuXr7n4cSAgE0DxzYrxFJ9lHgpEMggSt5YaFKcA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793740630;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=KU9I4i4E/54jq4DTZIW07YCk6klu9D+8kZdbIy6OKeA=;
	b=YzvmSbzfTCehOfv7dIYtxzgzriYNNUFlS7bisIQpmKT09IefSqqc5rMUWMR69QrpBntt
	 mfzxrFEBfkdIDiTBS2QRlydzEwLhRBDtssuE09ahBvHNlJ9T33+DQ2rpsiOriYdjO7RqT
	 0UCjqLw4v/29wTovPxTYXFl7eimmRJI9pCRsblhY96uM47C11pHfUzio0bpROyli4406q
	 TZ5xU80s5FO+aTdxteiN32xrRuhKwlWJ0s5YtqeRjQV5gSLB5+Nn8NnyKrTKgVc9eh5iz
	 7Mf7eVk2kTH1j/43DQ4c65QVWj7TPh75KV/87T+a2S+5qpD/myVcmPwPizPSjHL0QuA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 27E661F0093A;
	Tue,  3 Nov 2026 21:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793740630;
	bh=KU9I4i4E/54jq4DTZIW07YCk6klu9D+8kZdbIy6OKeA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=kOn6Dd/7G8J+KvcS0PieYAVAy+UeYlAZs7OSBuYWKVZMN2t/KlsDkvO7JdSy9WJeo
	 gDHbHVaCz0Ru+h6vO51XyBZbfvp1Q0LMN3Us7vrAkAnJUp5tE9TnYCPPvV9mlo/q/J
	 NqbQbSoLU1eKRVJ8YTcP4QdFTwN+EM+eCK0Ui9VJSXOLHoAYkaFdJNz/4N8jbPm3DM
	 BH5ER+H3f7oQYG33dC+ommsspuchX0omQgeUJEB0LQDSGPgPgCLIYUnOaFe8ldiQeQ
	 iHQvZC6CAzIavkHXyYlHBoJ8iRK78VdcnZ36ZnZ17tSgqHYnGugVGDdFfwOhvGl2Jq
	 OlZoVLvcIFkOQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 8DFF246B2B;
	Tue,  3 Nov 2026 21:17:09 +0000 (UTC)
From: Raffaele Tranfaglia via B4 Relay <devnull+raffaele.tranfaglia.gmail.com@kernel.org>
Date: Tue, 03 Nov 2026 21:17:07 +0000
Subject: [PATCH v3 1/2] iio: test: iio-test-format: check that nothing is
 written past the string
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
Message-Id: <20261103-iio-test-format-char-v3-1-d44074ecca70@gmail.com>
References: <20261103-iio-test-format-char-v3-0-d44074ecca70@gmail.com>
In-Reply-To: <20261103-iio-test-format-char-v3-0-d44074ecca70@gmail.com>
To: Rodrigo Alencar <rodrigo.alencar@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793740628; l=4652;
 i=raffaele.tranfaglia@gmail.com; s=20261011; h=from:subject:message-id;
 bh=11qfsxnC6C/M3CIJ94SWhENFa+Zey9Wn6fupPxQmHYA=;
 b=yurxFVgmlRO3NPeO8zZ9K5jm5HlMJEdp/2GfBvQWwhhdDiajhGTuYNbx4qiCyfUYM7RI9rx5L
 5a/roi0fzdxCfuAdG9MqqryPuZHQHRosFIgQVncX4r/B+mQQFRR/WPI
X-Developer-Key: i=raffaele.tranfaglia@gmail.com; a=ed25519;
 pk=mweuSGNM6vguCTdqa+aiHwMXdgk70suj2wolzCp6XGM=
X-Endpoint-Received: by B4 Relay for raffaele.tranfaglia@gmail.com/20261011
 with auth_id=1160
X-Original-From: Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>
Reply-To: raffaele.tranfaglia@gmail.com
Content-Transfer-Encoding: 7bit

From: Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>

IIO_TEST_FORMAT_EXPECT_EQ() compares the buffer only up to the first NUL
character. It does not notice if iio_format_value() writes past the end
of the formatted string, and it cannot check output that contains a NUL.

Poison the buffer before each call. Check the expected bytes, including
the NUL terminator, with KUNIT_EXPECT_MEMEQ(), and check that the rest of
the page still holds the poison value. Take the expected length from the
string literal instead of calling strlen() on the buffer.

Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>
---
 drivers/iio/test/iio-test-format.c | 54 +++++++++++++++++++++++++-------------
 1 file changed, 36 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/test/iio-test-format.c b/drivers/iio/test/iio-test-format.c
index e5d0a2ac4670..90cd23f25fd9 100644
--- a/drivers/iio/test/iio-test-format.c
+++ b/drivers/iio/test/iio-test-format.c
@@ -6,11 +6,36 @@
 
 #include <kunit/test.h>
 #include <linux/iio/iio.h>
+#include <linux/string.h>
 
-#define IIO_TEST_FORMAT_EXPECT_EQ(_test, _buf, _ret, _val) do { \
-		KUNIT_EXPECT_EQ(_test, strlen(_buf), _ret); \
-		KUNIT_EXPECT_STREQ(_test, (_buf), (_val)); \
-	} while (0)
+#define IIO_TEST_FORMAT_POISON	0x5a
+
+/*
+ * Check the formatted string including its NUL terminator, and that nothing
+ * beyond it was written. _val must be a string literal. The buffer is poisoned
+ * again afterwards for the next check.
+ */
+#define IIO_TEST_FORMAT_EXPECT_EQ(_test, _buf, _ret, _val)			  \
+do {										  \
+	size_t sz = sizeof(_val);						  \
+										  \
+	KUNIT_EXPECT_EQ(_test, _ret, (ssize_t)sz - 1);				  \
+	KUNIT_EXPECT_MEMEQ(_test, _buf, _val, sz);				  \
+	KUNIT_EXPECT_NULL(_test,						  \
+		memchr_inv((_buf) + sz, IIO_TEST_FORMAT_POISON, PAGE_SIZE - sz)); \
+	memset(_buf, IIO_TEST_FORMAT_POISON, PAGE_SIZE);			  \
+} while (0)
+
+static char *iio_test_format_alloc_buf(struct kunit *test)
+{
+	char *buf;
+
+	buf = kunit_kmalloc(test, PAGE_SIZE, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf);
+	memset(buf, IIO_TEST_FORMAT_POISON, PAGE_SIZE);
+
+	return buf;
+}
 
 static void iio_test_iio_format_value_integer(struct kunit *test)
 {
@@ -18,8 +43,7 @@ static void iio_test_iio_format_value_integer(struct kunit *test)
 	int val;
 	int ret;
 
-	buf = kunit_kmalloc(test, PAGE_SIZE, GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf);
+	buf = iio_test_format_alloc_buf(test);
 
 	val = 42;
 	ret = iio_format_value(buf, IIO_VAL_INT, 1, &val);
@@ -48,8 +72,7 @@ static void iio_test_iio_format_value_fixedpoint(struct kunit *test)
 	char *buf;
 	int ret;
 
-	buf = kunit_kmalloc(test, PAGE_SIZE, GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf);
+	buf = iio_test_format_alloc_buf(test);
 
 	/* positive >= 1 */
 	values[0] = 1;
@@ -109,8 +132,7 @@ static void iio_test_iio_format_value_fractional(struct kunit *test)
 	char *buf;
 	int ret;
 
-	buf = kunit_kmalloc(test, PAGE_SIZE, GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf);
+	buf = iio_test_format_alloc_buf(test);
 
 	/* positive < 1 */
 	values[0] = 1;
@@ -149,8 +171,7 @@ static void iio_test_iio_format_value_fractional_log2(struct kunit *test)
 	char *buf;
 	int ret;
 
-	buf = kunit_kmalloc(test, PAGE_SIZE, GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf);
+	buf = iio_test_format_alloc_buf(test);
 
 	/* positive < 1 */
 	values[0] = 123;
@@ -189,8 +210,7 @@ static void iio_test_iio_format_value_multiple(struct kunit *test)
 	char *buf;
 	int ret;
 
-	buf = kunit_kmalloc(test, PAGE_SIZE, GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf);
+	buf = iio_test_format_alloc_buf(test);
 
 	ret = iio_format_value(buf, IIO_VAL_INT_MULTIPLE,
 			       ARRAY_SIZE(values), values);
@@ -203,8 +223,7 @@ static void iio_test_iio_format_value_integer_64(struct kunit *test)
 	char *buf;
 	int ret;
 
-	buf = kunit_kmalloc(test, PAGE_SIZE, GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf);
+	buf = iio_test_format_alloc_buf(test);
 
 	iio_val_s64_decompose(24, &values[0], &values[1]);
 	ret = iio_format_value(buf, IIO_VAL_INT_64, ARRAY_SIZE(values), values);
@@ -241,8 +260,7 @@ static void iio_test_iio_format_value_decimal_64(struct kunit *test)
 	char *buf;
 	int ret;
 
-	buf = kunit_kmalloc(test, PAGE_SIZE, GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf);
+	buf = iio_test_format_alloc_buf(test);
 
 	/* DECIMAL64_MILLI: positive >= 1, value 1.234 */
 	iio_val_s64_decompose(1234, &values[0], &values[1]);

-- 
2.56.0


