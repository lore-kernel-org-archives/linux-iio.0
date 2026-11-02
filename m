Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793608469;
	b=hvLIwrvjrYIr6y+Tf1n06mvmccv2NZNBtYPs2xY6U63BHHsisvqtdCoO1okdxOTprN9p
	 0JnoAEoNE8JVpVJQ1lAtaIh0+vA4l/RUt7GQj6quZt1UlVQLsxkNib5HVIC88NC4y7dOT
	 TP3KvDZgerWxUuVM13xsiBc7zlGIDRXdeouC84C8BxJ4XTIAzqb1WhvxU7wEG/1mfS1hg
	 SC3H597gQ1jEzQABbzb3tFyIJExJcGdO7VZdtTUx9yuyiMvb25wXccLmM2k4LndqIYa09
	 L83wPvVgArZovTey3Y9o4xsfTp+3jSirNYHJyelDVqHfpzZcSayMxf/9d5AKCn5fBlQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793608469;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=boFFcpFnjyEzJo24rZUanw6C9QWlptqbhINfJloBLbY=;
	b=5TnQbnm0Frt1I8kFwLq6QFqMr3GXPaV3ElKLCSreeVLzcSXg5t6LOtv9K88WWY0xBB28
	 tu0MEOo2pUUP7KSrMU3iNtqLvwsfqa2Ds+KUJSiq8/L/gpSbIArcxasxMMY9v2Z8ebQP/
	 FApsU1AN8LyA7e2ADU+5wMBlfxvv4EaPcRavhjA0hNNSE57uj8Q6iIVLjEbP0YTh0RHdj
	 kfR4eAWCmGuDRNgz6RKmheSpkoNJpnwiMOS7MdD6DS4VXyoDM88q8EKtMcyjLbFNoIrdc
	 lCoxm7tOv7X90uSRXOcZlBd7greAZF/WNfdoic1LzLjzCSYEAjT/ZYg6k6xpkad3nCw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dozr78Ti;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF038606A326;
	Mon,  2 Nov 2026 08:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dozr78Ti
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793608468;
	b=3ShTwgTSx+KUw1ih0JcAgc5xZGTeL0XlkDEK894xvYiJfSztcNPKbs5eXtIZec7GARjw
	 ffnmuYfYhNkOzmIEteso4Kfuz29K3HCJPijzpu7Q/baeEPDlKyavZo89RwTtrHYkv1Im1
	 g3tTbjtSLfCm7pY80xSwD1tIRzmXAvMKo1qHzjbFEre+B5aLkjwxXDx//vjFrDBw5sI7L
	 jdBA3IYbouNV/4FCdOayzeogX3F5SWhDUaPzYSEt0tGmQoQd04sEIgP+kMbaKxMaDjIeW
	 2bOmwzUI84ysOpOgeURVAAnq9aUHQKmPN80fuXIGp60QPobJDWCSbsfrQvEKPHWjOrw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793608468;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=boFFcpFnjyEzJo24rZUanw6C9QWlptqbhINfJloBLbY=;
	b=zWAgSdBz1LrT5gNyxQiHirvuBi6PIRC6VmbdLFgv1LZYEitCZOqos0NHnYl8HayHMVNs
	 hbcj0zofMAQGFSVCP/1MTZCGkQpEx/Zpdzj+OOx85KDmrPt37KzLRzRGFIXwLb+eHGQ8H
	 2N1em9xKbWpLYeYm1b1clrbHtchYRQ3C6p6TJhKjsQymRH2Zis2QYSVaRGyAGv70sy4I5
	 NYOxEH4Rl12JdR5XS5BP7QGQfpDzq7gudUPOdN5Utn8wk2rW8H0lKrOlniIX8/C0yegp0
	 fYJsZLgZ16wl+/8p3BbJFHnfD0cO/xx6J4x+FuMfG+jB/ZGHiqNig7of8mD8Kehm5HQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 0F3871F0093A;
	Mon,  2 Nov 2026 08:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793608468;
	bh=boFFcpFnjyEzJo24rZUanw6C9QWlptqbhINfJloBLbY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=dozr78Ti9TR/ZzxwW57enkd5iBWSwLmVJofQjPb1vHGeiCiF4o/pxubowJKNjl6rY
	 Pyrlg2kcq90uyBzHG2HShWZlHXoOQxBaMCsJquTMGFAFO2MRJNFJ+4JAxpmQ768bFJ
	 ioi0ehsx4syT4Fo4uRtap2yn6aGc5x5/B7omSPGOlKhwyKvkI2XW4cLuapy8IKAGfw
	 lv3+SgYlyzxQ+WecpJAXRM+xeglyQaOG4ybZvxItbryHFJejmJyFBb8RggXkM0Q7sp
	 l33+QpwtNNqd2+EG+BlLfsAISPCqHPHYeih+B83zpVFDWcJPPVXgBpHwIY6L5ieoLJ
	 DZL1hE1YWhgXQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 7AE9A4640A;
	Mon,  2 Nov 2026 08:34:27 +0000 (UTC)
From: Raffaele Tranfaglia via B4 Relay <devnull+raffaele.tranfaglia.gmail.com@kernel.org>
Date: Mon, 02 Nov 2026 08:33:55 +0000
Subject: [PATCH v2 1/2] iio: test: iio-test-format: check that nothing is
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
Message-Id: <20261102-iio-test-format-char-v2-1-926100689e62@gmail.com>
References: <20261102-iio-test-format-char-v2-0-926100689e62@gmail.com>
In-Reply-To: <20261102-iio-test-format-char-v2-0-926100689e62@gmail.com>
To: Rodrigo Alencar <rodrigo.alencar@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793608466; l=4542;
 i=raffaele.tranfaglia@gmail.com; s=20261011; h=from:subject:message-id;
 bh=mjGIohs+VaxRspg/JVuGZhyysVoHzY7PwFWoazBDiao=;
 b=DrTAHWoJIjQ+wh1ssogPCRVkdw1Bbyuy081yyAvJWDELLz95kHWclXNAGif7zElEYfZxW+KtC
 TjqyUyOLGLOBiWgzyfpkce/FNXwOB13qegAR50hoa991LyOS8AMwzCI
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
 drivers/iio/test/iio-test-format.c | 50 +++++++++++++++++++++++++-------------
 1 file changed, 33 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/test/iio-test-format.c b/drivers/iio/test/iio-test-format.c
index e5d0a2ac4670..35b30420d995 100644
--- a/drivers/iio/test/iio-test-format.c
+++ b/drivers/iio/test/iio-test-format.c
@@ -6,20 +6,42 @@
 
 #include <kunit/test.h>
 #include <linux/iio/iio.h>
+#include <linux/string.h>
 
-#define IIO_TEST_FORMAT_EXPECT_EQ(_test, _buf, _ret, _val) do { \
-		KUNIT_EXPECT_EQ(_test, strlen(_buf), _ret); \
-		KUNIT_EXPECT_STREQ(_test, (_buf), (_val)); \
+#define IIO_TEST_FORMAT_POISON	0x5a
+
+/*
+ * Check the formatted string including its NUL terminator, and that nothing
+ * beyond it was written. _val must be a string literal. The buffer is poisoned
+ * again afterwards for the next check.
+ */
+#define IIO_TEST_FORMAT_EXPECT_EQ(_test, _buf, _ret, _val) do {		\
+		KUNIT_EXPECT_EQ(_test, _ret, (ssize_t)sizeof(_val) - 1);	\
+		KUNIT_EXPECT_MEMEQ(_test, _buf, _val, sizeof(_val));		\
+		KUNIT_EXPECT_NULL(_test, memchr_inv((_buf) + sizeof(_val),	\
+						    IIO_TEST_FORMAT_POISON,	\
+						    PAGE_SIZE - sizeof(_val)));	\
+		memset(_buf, IIO_TEST_FORMAT_POISON, PAGE_SIZE);		\
 	} while (0)
 
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
+
 static void iio_test_iio_format_value_integer(struct kunit *test)
 {
 	char *buf;
 	int val;
 	int ret;
 
-	buf = kunit_kmalloc(test, PAGE_SIZE, GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf);
+	buf = iio_test_format_alloc_buf(test);
 
 	val = 42;
 	ret = iio_format_value(buf, IIO_VAL_INT, 1, &val);
@@ -48,8 +70,7 @@ static void iio_test_iio_format_value_fixedpoint(struct kunit *test)
 	char *buf;
 	int ret;
 
-	buf = kunit_kmalloc(test, PAGE_SIZE, GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf);
+	buf = iio_test_format_alloc_buf(test);
 
 	/* positive >= 1 */
 	values[0] = 1;
@@ -109,8 +130,7 @@ static void iio_test_iio_format_value_fractional(struct kunit *test)
 	char *buf;
 	int ret;
 
-	buf = kunit_kmalloc(test, PAGE_SIZE, GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf);
+	buf = iio_test_format_alloc_buf(test);
 
 	/* positive < 1 */
 	values[0] = 1;
@@ -149,8 +169,7 @@ static void iio_test_iio_format_value_fractional_log2(struct kunit *test)
 	char *buf;
 	int ret;
 
-	buf = kunit_kmalloc(test, PAGE_SIZE, GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf);
+	buf = iio_test_format_alloc_buf(test);
 
 	/* positive < 1 */
 	values[0] = 123;
@@ -189,8 +208,7 @@ static void iio_test_iio_format_value_multiple(struct kunit *test)
 	char *buf;
 	int ret;
 
-	buf = kunit_kmalloc(test, PAGE_SIZE, GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf);
+	buf = iio_test_format_alloc_buf(test);
 
 	ret = iio_format_value(buf, IIO_VAL_INT_MULTIPLE,
 			       ARRAY_SIZE(values), values);
@@ -203,8 +221,7 @@ static void iio_test_iio_format_value_integer_64(struct kunit *test)
 	char *buf;
 	int ret;
 
-	buf = kunit_kmalloc(test, PAGE_SIZE, GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf);
+	buf = iio_test_format_alloc_buf(test);
 
 	iio_val_s64_decompose(24, &values[0], &values[1]);
 	ret = iio_format_value(buf, IIO_VAL_INT_64, ARRAY_SIZE(values), values);
@@ -241,8 +258,7 @@ static void iio_test_iio_format_value_decimal_64(struct kunit *test)
 	char *buf;
 	int ret;
 
-	buf = kunit_kmalloc(test, PAGE_SIZE, GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf);
+	buf = iio_test_format_alloc_buf(test);
 
 	/* DECIMAL64_MILLI: positive >= 1, value 1.234 */
 	iio_val_s64_decompose(1234, &values[0], &values[1]);

-- 
2.56.0


