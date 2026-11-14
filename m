Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794665404;
	b=G4R1sn1P3atJ6gfHPypXoXnQvaXPVqS292WeJlex/RL+0xEsrDWbpunnyBTs3x+68/ap
	 f5MGPc1FL1fUmWes3pVsj97yQru8CtAnw6Cdefj4hIeLZ3rIiW2MhNTIYk72GoVdaW9xK
	 qyEUnGOxOd/TdN++jnlstkA3uChHwNBUFY1945yWLxffRkNeXMCet22kpXq5p3T7lPevj
	 DRDHd0cFhPo3bc22dgPTlb//W7LOhFQTA10pt7LeTDAfMIdR4yaKfaeyPmIkLGu+nTPAE
	 lp45Stff8KrpsYO+NZUwWW6VBq7ty6mMEzhum6HzxU8HcpVbwlYdJhatIG851Vly2Rg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794665404;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=SK3OcnJeWZ1Gqt5lgTdImk7CSXJ6HwPqlnwQCl+YS0g=;
	b=opTFXxbF1JMK9awP0AYXrEqr1O4iaAsfMH584cNCc7Lq9ak1Zcqu0DnmKdtanGhhZ9Z6
	 uCFP8MN3eRin3HaYQNyOEEgw6geCMxbLzxNALXQ+TAQZ2aRo8eg6p0xdJ7OUktX7qJucX
	 vYI3mF8atKR4cwuPEXh55SkBYvMQiHohaC33g+8QxrB0XXoya5LpBRRdla5aPLLylNEQn
	 Fq/xon/SlmBuB+f1SZXXkjxTvGLgueKUqG1mLMw3eL+hXdPHdu2RqiNohfPyPFXaCrt1P
	 uy0kqHqFmn1G/HW2Re0kzQxfVh7fQ5T2xhYVpHbX6wqNSrmXVhSqjHBMBNvuwemhESA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EEBlwEgQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D10606A8B2;
	Sat, 14 Nov 2026 14:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EEBlwEgQ
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794665404;
	b=mWk8EcNZMofZzCzQOtRF+am86cosQScfXpQM0Avp3ZJFmrMBUi2G/vQuk20+q8loDeoy
	 D+u2Pn6WKSggJvkrkiU99OgPLVJUfTbkCC1xf/ZYTq8ebqH+OfkqbfAqvULCt+A78WEPY
	 OEVSBTXru9AOpqiEbnK/3SRRZ4Sduy2AOcPGafvu3QC82iin/3y/IjfNV8jqoR1GgycB/
	 7pHVvYqfzlTJlQDYlOebMWL+gKbRkdEsq4tbFYuYpaQO+8LtfzzdSwN36vnLTHA62EYkT
	 KuYRcnbBQ9Fr1xMPVeYuYN+UfEcZwjArVHhhCV5KvzKsa4l8hEMDqsLKvOPriWiVBEA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794665404;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=SK3OcnJeWZ1Gqt5lgTdImk7CSXJ6HwPqlnwQCl+YS0g=;
	b=LKD4qaZ6FI4itNhB/Y998OF802X9UXCyR0KTeVV8VS0Qs/KKtDTGXOxBvdlcr1apLoZG
	 mvv670eZh3bZzS0rxdDcR2EjANHbYlGDuP/BmfWw85gcUJAgg0/sqDeE+0QSETOOb8Iyq
	 zm+PN+3eHWHAYEk/IfxJ5hrQY9p202qVcJiX/T5863Vv9b0tVUnDqszy0gQ4prIlZxvdJ
	 t+f8YOgCotHgM0CNlzqOhHW7CX7uPJbKir3MyGBBiE2TiFAVUtbFsBVw+c2x7XIskorTn
	 UctOzA1JiLLTw7TPtxCjhod21uIRHh6bTizBzPtgsRFBPRu+YQYGtrwFIi8cTRFNyQQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 6AB451F000C9;
	Sat, 14 Nov 2026 14:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794665403;
	bh=SK3OcnJeWZ1Gqt5lgTdImk7CSXJ6HwPqlnwQCl+YS0g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=EEBlwEgQVEPjXHeJIqB1kSAWZHFZQgpP62z2tVQcGBUhqtqO8fB9qNaX0xW2H/wKM
	 PMbPUMySmpLvDNi7fVnR3TiG2Dm/3pyQLVGF8/q9TfC5nGtTCO/3ceoEQPkae9QDku
	 4PvjweyFukyQCLuORXLa2HFls4LpjsDT5QIGVMAqARVfk3pZZ5gT32lYBtS4n2gdzV
	 qItv2DxEr1VqY6LFqPENoYIa75ZMQbscKoEkwycRygdbtD4kVrf/gMjf/gU/u5lTmi
	 Azfwu05Thn906Hpgny3/L8OpMgFhQWAfSkJeqRwW4drsyW3IUriskQ6xAEoy2qCKZ1
	 Cyi1XwY6X5bxA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 1612949E00;
	Sat, 14 Nov 2026 14:10:00 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Sat, 14 Nov 2026 14:09:59 +0000
Subject: [PATCH v6 7/7] iio: test: add kunit tests for channel info writes
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
Message-Id: <20261114-e-notation-v6-7-205ca9a1438a@analog.com>
References: <20261114-e-notation-v6-0-205ca9a1438a@analog.com>
In-Reply-To: <20261114-e-notation-v6-0-205ca9a1438a@analog.com>
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794665398; l=18366;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=xG0V59BWBnTqgLQDR/JoTE5orjY4+bVakt0lsQc4yEw=;
 b=gWmHOmjJnkteEnRW8rBaNX4Qn1TxJ+AsbFHih94feCAXlauctjky5Yhp1g3sFTsK8zjs54Mfc
 7tEtC9/nh97AmOA/f+ohBKmf97dL8YvrMuq8rh4rUZixcLQ/GpWH1eD
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com
Content-Transfer-Encoding: 7bit

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Add a KUnit test suite covering iio_write_channel_info(), the sysfs
store handler that parses a channel info value according to the format
reported by write_raw_get_fmt() and hands it to write_raw(). The
function is made visible to KUnit through VISIBLE_IF_KUNIT and
EXPORT_SYMBOL_IF_KUNIT, so it stays static in regular builds.

The suite uses an unregistered iio_dev allocated on a KUnit device,
with stub write_raw_get_fmt() and write_raw() callbacks that select
the format under test and capture the parsed values. Cases are grouped
by format:

  - IIO_VAL_INT: decimal, hex and octal input, decimal fallback with
    rounding and E notation, and 32-bit range checks.
  - IIO_VAL_INT_PLUS_MICRO / IIO_VAL_INT_PLUS_NANO: sign handling,
    rounding of extra digits (ties to even), E notation and malformed
    input.
  - IIO_VAL_INT_PLUS_MICRO_DB: optional "dB" / " dB" suffix.
  - IIO_VAL_CHAR: single character input.
  - IIO_VAL_INT_64 and IIO_VAL_DECIMAL64_*: 64-bit values split into
    val/val2, including the S64_MAX / S64_MIN boundaries.

Further cases cover unsupported formats, the default micro precision
used when write_raw_get_fmt() is absent, a missing write_raw(), and
error propagation from write_raw().

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 MAINTAINERS                               |   1 +
 drivers/iio/iio_core.h                    |   3 +
 drivers/iio/industrialio-core.c           |   9 +-
 drivers/iio/test/Kconfig                  |  14 ++
 drivers/iio/test/Makefile                 |   1 +
 drivers/iio/test/iio-test-channel-write.c | 360 ++++++++++++++++++++++++++++++
 6 files changed, 384 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e2d2fba247f6..d27598e7b8c5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13014,6 +13014,7 @@ M:	Rodrigo Alencar <rodrigo.alencar@analog.com>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
 F:	drivers/iio/test/iio-test-channel-prefix.c
+F:	drivers/iio/test/iio-test-channel-write.c
 F:	drivers/iio/test/iio-test-format.c
 
 IIO UNIT CONVERTER
diff --git a/drivers/iio/iio_core.h b/drivers/iio/iio_core.h
index 59fa1bd9924b..08f0cc28ad8c 100644
--- a/drivers/iio/iio_core.h
+++ b/drivers/iio/iio_core.h
@@ -114,6 +114,9 @@ ssize_t __iio_chan_prefix_emit(struct device *dev,
 			       const struct iio_chan_spec *chan,
 			       enum iio_shared_by shared_by,
 			       char *buf, size_t len);
+ssize_t iio_write_channel_info(struct device *dev,
+			       struct device_attribute *attr,
+			       const char *buf, size_t len);
 #endif
 
 #endif
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 4214eb77f312..6c9a3c8027bc 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1130,10 +1130,10 @@ static int iio_str_to_fixpoint_units(const char *str, int fract_mult,
 	return iio_str_to_fixpoint(dec_str, fract_mult, integer, fract);
 }
 
-static ssize_t iio_write_channel_info(struct device *dev,
-				      struct device_attribute *attr,
-				      const char *buf,
-				      size_t len)
+VISIBLE_IF_KUNIT
+ssize_t iio_write_channel_info(struct device *dev,
+			       struct device_attribute *attr,
+			       const char *buf, size_t len)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
@@ -1220,6 +1220,7 @@ static ssize_t iio_write_channel_info(struct device *dev,
 
 	return len;
 }
+EXPORT_SYMBOL_IF_KUNIT(iio_write_channel_info);
 
 static
 int __iio_device_attr_init(struct device *dev,
diff --git a/drivers/iio/test/Kconfig b/drivers/iio/test/Kconfig
index 04930b4fdd5d..af75c032a330 100644
--- a/drivers/iio/test/Kconfig
+++ b/drivers/iio/test/Kconfig
@@ -17,6 +17,20 @@ config IIO_CHANNEL_PREFIX_KUNIT_TEST
 
 	  If unsure, say N.
 
+config IIO_CHANNEL_WRITE_KUNIT_TEST
+	tristate "Test IIO channel info write" if !KUNIT_ALL_TESTS
+	depends on KUNIT && IIO
+	default KUNIT_ALL_TESTS
+	help
+	  Build unit tests for iio_write_channel_info(), the sysfs store
+	  handler that parses channel info values according to the format
+	  reported by write_raw_get_fmt() and passes them to write_raw().
+
+	  For more information on KUnit and unit tests in general, please refer
+	  to the KUnit documentation in Documentation/dev-tools/kunit/.
+
+	  If unsure, say N.
+
 config IIO_GTS_KUNIT_TEST
 	tristate "Test IIO gain-time-scale helpers" if !KUNIT_ALL_TESTS
 	depends on KUNIT
diff --git a/drivers/iio/test/Makefile b/drivers/iio/test/Makefile
index ba08afa7f3f2..bcaf82ffd9c1 100644
--- a/drivers/iio/test/Makefile
+++ b/drivers/iio/test/Makefile
@@ -5,6 +5,7 @@
 
 # Keep in alphabetical order
 obj-$(CONFIG_IIO_CHANNEL_PREFIX_KUNIT_TEST) += iio-test-channel-prefix.o
+obj-$(CONFIG_IIO_CHANNEL_WRITE_KUNIT_TEST) += iio-test-channel-write.o
 obj-$(CONFIG_IIO_RESCALE_KUNIT_TEST) += iio-test-rescale.o
 obj-$(CONFIG_IIO_FORMAT_KUNIT_TEST) += iio-test-format.o
 obj-$(CONFIG_IIO_GTS_KUNIT_TEST) += iio-test-gts.o
diff --git a/drivers/iio/test/iio-test-channel-write.c b/drivers/iio/test/iio-test-channel-write.c
new file mode 100644
index 000000000000..9205a5674d0e
--- /dev/null
+++ b/drivers/iio/test/iio-test-channel-write.c
@@ -0,0 +1,360 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Unit tests for IIO channel info writes.
+ */
+
+#include <kunit/device.h>
+#include <kunit/test.h>
+#include <kunit/visibility.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/types.h>
+#include <linux/string.h>
+
+#include "../iio_core.h"
+
+#define IIO_TEST_UNSUPPORTED_FMT	IIO_VAL_FRACTIONAL
+
+struct iio_test_write_priv {
+	int fmt;
+	int ret;
+	int val;
+	int val2;
+	bool called;
+};
+
+struct iio_test_write_ctx {
+	struct iio_dev *indio_dev;
+	struct iio_dev_attr attr;
+};
+
+static int iio_test_write_raw_get_fmt(struct iio_dev *indio_dev,
+				      struct iio_chan_spec const *chan,
+				      long mask)
+{
+	struct iio_test_write_priv *priv = iio_priv(indio_dev);
+
+	return priv->fmt;
+}
+
+static int iio_test_write_raw(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      int val, int val2, long mask)
+{
+	struct iio_test_write_priv *priv = iio_priv(indio_dev);
+
+	priv->val = val;
+	priv->val2 = val2;
+	priv->called = true;
+
+	return priv->ret;
+}
+
+static const struct iio_info iio_test_write_info = {
+	.write_raw = iio_test_write_raw,
+	.write_raw_get_fmt = iio_test_write_raw_get_fmt,
+};
+
+static const struct iio_info iio_test_write_info_no_fmt = {
+	.write_raw = iio_test_write_raw,
+};
+
+static const struct iio_info iio_test_write_info_no_write = {
+};
+
+static const struct iio_chan_spec iio_test_write_chan = {
+	.type = IIO_VOLTAGE,
+	.indexed = 1,
+	.info_mask_separate = BIT(IIO_CHAN_INFO_SCALE),
+};
+
+static int iio_test_write_init(struct kunit *test)
+{
+	struct iio_test_write_ctx *ctx;
+	struct device *dev;
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	dev = kunit_device_register(test, "iio-test-channel-write");
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+
+	ctx->indio_dev = devm_iio_device_alloc(dev,
+					       sizeof(struct iio_test_write_priv));
+	KUNIT_ASSERT_NOT_NULL(test, ctx->indio_dev);
+	ctx->indio_dev->info = &iio_test_write_info;
+
+	ctx->attr.c = &iio_test_write_chan;
+	ctx->attr.address = IIO_CHAN_INFO_SCALE;
+
+	test->priv = ctx;
+
+	return 0;
+}
+
+static struct iio_test_write_priv *iio_test_write_priv(struct kunit *test)
+{
+	struct iio_test_write_ctx *ctx = test->priv;
+
+	return iio_priv(ctx->indio_dev);
+}
+
+static ssize_t iio_test_write(struct kunit *test, int fmt, const char *str)
+{
+	struct iio_test_write_ctx *ctx = test->priv;
+	struct iio_test_write_priv *priv = iio_priv(ctx->indio_dev);
+
+	priv->fmt = fmt;
+	priv->called = false;
+	priv->val = 0xdead;
+	priv->val2 = 0xbeef;
+
+	return iio_write_channel_info(&ctx->indio_dev->dev, &ctx->attr.dev_attr,
+				      str, strlen(str));
+}
+
+#define EXPECT_WRITE(_test, _fmt, _str, _val, _val2) do {			\
+		struct kunit *__test = (_test);					\
+		struct iio_test_write_priv *__priv;				\
+		const char *__str = (_str);					\
+		ssize_t __len = strlen(__str);					\
+		ssize_t __ret;							\
+										\
+		__ret = iio_test_write(__test, (_fmt), __str);			\
+		__priv = iio_test_write_priv(__test);				\
+		KUNIT_EXPECT_EQ_MSG(__test, __ret, __len,			\
+				    "input: \"%s\"", __str);			\
+		KUNIT_EXPECT_TRUE_MSG(__test, __priv->called,			\
+				      "input: \"%s\"", __str);			\
+		KUNIT_EXPECT_EQ_MSG(__test, __priv->val, (_val),		\
+				    "input: \"%s\"", __str);			\
+		KUNIT_EXPECT_EQ_MSG(__test, __priv->val2, (_val2),		\
+				    "input: \"%s\"", __str);			\
+	} while (0)
+
+#define EXPECT_WRITE_S64(_test, _fmt, _str, _expected) do {			\
+		s32 __lo, __hi;							\
+										\
+		iio_val_s64_decompose((_expected), &__lo, &__hi);		\
+		EXPECT_WRITE(_test, _fmt, _str, __lo, __hi);			\
+	} while (0)
+
+#define EXPECT_WRITE_ERR(_test, _fmt, _str, _err) do {				\
+		struct kunit *__test = (_test);					\
+		const char *__str = (_str);					\
+		ssize_t __ret;							\
+										\
+		__ret = iio_test_write(__test, (_fmt), __str);			\
+		KUNIT_EXPECT_EQ_MSG(__test, __ret, (ssize_t)(_err),		\
+				    "input: \"%s\"", __str);			\
+		KUNIT_EXPECT_FALSE_MSG(__test,					\
+				       iio_test_write_priv(__test)->called,	\
+				       "input: \"%s\"", __str);			\
+	} while (0)
+
+static void iio_test_write_int(struct kunit *test)
+{
+	EXPECT_WRITE(test, IIO_VAL_INT, "0", 0, 0);
+	EXPECT_WRITE(test, IIO_VAL_INT, "42\n", 42, 0);
+	EXPECT_WRITE(test, IIO_VAL_INT, "-7", -7, 0);
+	EXPECT_WRITE(test, IIO_VAL_INT, "+7", 7, 0);
+	EXPECT_WRITE(test, IIO_VAL_INT, "2147483647", INT_MAX, 0);
+	EXPECT_WRITE(test, IIO_VAL_INT, "-2147483648", INT_MIN, 0);
+
+	/* hex and octal are still accepted for integers */
+	EXPECT_WRITE(test, IIO_VAL_INT, "0x10", 16, 0);
+	EXPECT_WRITE(test, IIO_VAL_INT, "010", 8, 0);
+
+	/* decimal fallback: fractional digits are rounded, ties to even */
+	EXPECT_WRITE(test, IIO_VAL_INT, "1.9", 2, 0);
+	EXPECT_WRITE(test, IIO_VAL_INT, "-1.9", -2, 0);
+	EXPECT_WRITE(test, IIO_VAL_INT, "1e3", 1000, 0);
+	EXPECT_WRITE(test, IIO_VAL_INT, "15e-1", 2, 0);
+	EXPECT_WRITE(test, IIO_VAL_INT, "25e-1", 2, 0);
+
+	EXPECT_WRITE_ERR(test, IIO_VAL_INT, "2147483648", -ERANGE);
+	EXPECT_WRITE_ERR(test, IIO_VAL_INT, "-2147483649", -ERANGE);
+	EXPECT_WRITE_ERR(test, IIO_VAL_INT, "", -EINVAL);
+	EXPECT_WRITE_ERR(test, IIO_VAL_INT, "abc", -EINVAL);
+	EXPECT_WRITE_ERR(test, IIO_VAL_INT, "12abc", -EINVAL);
+}
+
+static void iio_test_write_int_plus_micro(struct kunit *test)
+{
+	EXPECT_WRITE(test, IIO_VAL_INT_PLUS_MICRO, "0", 0, 0);
+	EXPECT_WRITE(test, IIO_VAL_INT_PLUS_MICRO, "1.5\n", 1, 500000);
+	EXPECT_WRITE(test, IIO_VAL_INT_PLUS_MICRO, "-1.5", -1, 500000);
+	EXPECT_WRITE(test, IIO_VAL_INT_PLUS_MICRO, "-0.5", 0, -500000);
+	EXPECT_WRITE(test, IIO_VAL_INT_PLUS_MICRO, ".25", 0, 250000);
+	EXPECT_WRITE(test, IIO_VAL_INT_PLUS_MICRO, "3.", 3, 0);
+	EXPECT_WRITE(test, IIO_VAL_INT_PLUS_MICRO, "0.000001", 0, 1);
+	EXPECT_WRITE(test, IIO_VAL_INT_PLUS_MICRO, "-0.000001", 0, -1);
+
+	/* digits beyond the precision are rounded, ties to even */
+	EXPECT_WRITE(test, IIO_VAL_INT_PLUS_MICRO, "1.2345678", 1, 234568);
+	EXPECT_WRITE(test, IIO_VAL_INT_PLUS_MICRO, "0.0000009", 0, 1);
+	EXPECT_WRITE(test, IIO_VAL_INT_PLUS_MICRO, "0.0000005", 0, 0);
+	EXPECT_WRITE(test, IIO_VAL_INT_PLUS_MICRO, "0.0000015", 0, 2);
+	EXPECT_WRITE(test, IIO_VAL_INT_PLUS_MICRO, "-0.0000015", 0, -2);
+	EXPECT_WRITE(test, IIO_VAL_INT_PLUS_MICRO, "0.9999995", 1, 0);
+
+	/* E notation */
+	EXPECT_WRITE(test, IIO_VAL_INT_PLUS_MICRO, "1.5e3", 1500, 0);
+	EXPECT_WRITE(test, IIO_VAL_INT_PLUS_MICRO, "1e-3", 0, 1000);
+	EXPECT_WRITE(test, IIO_VAL_INT_PLUS_MICRO, "-25E-1\n", -2, 500000);
+
+	EXPECT_WRITE_ERR(test, IIO_VAL_INT_PLUS_MICRO, "2147483648", -ERANGE);
+	EXPECT_WRITE_ERR(test, IIO_VAL_INT_PLUS_MICRO, "", -EINVAL);
+	EXPECT_WRITE_ERR(test, IIO_VAL_INT_PLUS_MICRO, ".", -EINVAL);
+	EXPECT_WRITE_ERR(test, IIO_VAL_INT_PLUS_MICRO, "1.5x", -EINVAL);
+	EXPECT_WRITE_ERR(test, IIO_VAL_INT_PLUS_MICRO, "1.2.3", -EINVAL);
+	EXPECT_WRITE_ERR(test, IIO_VAL_INT_PLUS_MICRO, "0x10", -EINVAL);
+}
+
+static void iio_test_write_int_plus_nano(struct kunit *test)
+{
+	EXPECT_WRITE(test, IIO_VAL_INT_PLUS_NANO, "1.5", 1, 500000000);
+	EXPECT_WRITE(test, IIO_VAL_INT_PLUS_NANO, "0.000000001", 0, 1);
+	EXPECT_WRITE(test, IIO_VAL_INT_PLUS_NANO, "-0.000000001", 0, -1);
+	EXPECT_WRITE(test, IIO_VAL_INT_PLUS_NANO, "-2.000000001", -2, 1);
+	EXPECT_WRITE(test, IIO_VAL_INT_PLUS_NANO, "1.0000000019", 1, 2);
+	EXPECT_WRITE(test, IIO_VAL_INT_PLUS_NANO, "25e-10", 0, 2);
+}
+
+static void iio_test_write_int_plus_micro_db(struct kunit *test)
+{
+	EXPECT_WRITE(test, IIO_VAL_INT_PLUS_MICRO_DB, "-3.5 dB\n", -3, 500000);
+	EXPECT_WRITE(test, IIO_VAL_INT_PLUS_MICRO_DB, "-3.5dB", -3, 500000);
+	EXPECT_WRITE(test, IIO_VAL_INT_PLUS_MICRO_DB, "2dB", 2, 0);
+	EXPECT_WRITE(test, IIO_VAL_INT_PLUS_MICRO_DB, "-0.25 dB", 0, -250000);
+
+	/* the unit suffix is optional */
+	EXPECT_WRITE(test, IIO_VAL_INT_PLUS_MICRO_DB, "1.25", 1, 250000);
+	EXPECT_WRITE(test, IIO_VAL_INT_PLUS_MICRO_DB, "1.25\n", 1, 250000);
+
+	EXPECT_WRITE_ERR(test, IIO_VAL_INT_PLUS_MICRO_DB, "dB", -EINVAL);
+	EXPECT_WRITE_ERR(test, IIO_VAL_INT_PLUS_MICRO_DB, "1.5 db", -EINVAL);
+	EXPECT_WRITE_ERR(test, IIO_VAL_INT_PLUS_MICRO_DB, "2.5 dBm", -EINVAL);
+	EXPECT_WRITE_ERR(test, IIO_VAL_INT_PLUS_MICRO_DB, "7.3dBm", -EINVAL);
+	EXPECT_WRITE_ERR(test, IIO_VAL_INT_PLUS_MICRO_DB, "10 ddB", -EINVAL);
+	EXPECT_WRITE_ERR(test, IIO_VAL_INT_PLUS_MICRO_DB, "1.5 V", -EINVAL);
+}
+
+static void iio_test_write_char(struct kunit *test)
+{
+	EXPECT_WRITE(test, IIO_VAL_CHAR, "x", 'x', 0);
+	EXPECT_WRITE(test, IIO_VAL_CHAR, "K\n", 'K', 0);
+
+	EXPECT_WRITE_ERR(test, IIO_VAL_CHAR, "", -EINVAL);
+}
+
+static void iio_test_write_int_64(struct kunit *test)
+{
+	EXPECT_WRITE_S64(test, IIO_VAL_INT_64, "0", 0);
+	EXPECT_WRITE_S64(test, IIO_VAL_INT_64, "-1", -1);
+	EXPECT_WRITE_S64(test, IIO_VAL_INT_64, "4294967296\n", 4294967296LL);
+	EXPECT_WRITE_S64(test, IIO_VAL_INT_64, "0x100000000", 0x100000000LL);
+	EXPECT_WRITE_S64(test, IIO_VAL_INT_64, "9223372036854775807", S64_MAX);
+	EXPECT_WRITE_S64(test, IIO_VAL_INT_64, "-9223372036854775808", S64_MIN);
+
+	/* decimal fallback */
+	EXPECT_WRITE_S64(test, IIO_VAL_INT_64, "1.9", 2);
+	EXPECT_WRITE_S64(test, IIO_VAL_INT_64, "5e9", 5000000000LL);
+
+	EXPECT_WRITE_ERR(test, IIO_VAL_INT_64, "9223372036854775808", -ERANGE);
+	EXPECT_WRITE_ERR(test, IIO_VAL_INT_64, "abc", -EINVAL);
+}
+
+static void iio_test_write_decimal64(struct kunit *test)
+{
+	EXPECT_WRITE_S64(test, IIO_VAL_DECIMAL64_MILLI, "1.5", 1500);
+	EXPECT_WRITE_S64(test, IIO_VAL_DECIMAL64_MILLI, "-0.001", -1);
+	EXPECT_WRITE_S64(test, IIO_VAL_DECIMAL64_MILLI, "0.0009", 1);
+
+	EXPECT_WRITE_S64(test, IIO_VAL_DECIMAL64_MICRO, "1.5e3", 1500000000LL);
+	EXPECT_WRITE_S64(test, IIO_VAL_DECIMAL64_MICRO, "-0.000001\n", -1);
+	EXPECT_WRITE_S64(test, IIO_VAL_DECIMAL64_MICRO, "5000", 5000000000LL);
+
+	EXPECT_WRITE_S64(test, IIO_VAL_DECIMAL64_NANO, "1.000000001",
+			 1000000001LL);
+	EXPECT_WRITE_S64(test, IIO_VAL_DECIMAL64_PICO, "1e-12", 1);
+	EXPECT_WRITE_S64(test, IIO_VAL_DECIMAL64_PICO, "-2.5", -2500000000000LL);
+	EXPECT_WRITE_S64(test, IIO_VAL_DECIMAL64_FEMTO, "9223.372036854775807",
+			 S64_MAX);
+
+	/* no hex support when a decimal scale is set */
+	EXPECT_WRITE_ERR(test, IIO_VAL_DECIMAL64_MICRO, "0x10", -EINVAL);
+	EXPECT_WRITE_ERR(test, IIO_VAL_DECIMAL64_FEMTO, "9223.372036854775808",
+			 -ERANGE);
+	EXPECT_WRITE_ERR(test, IIO_VAL_DECIMAL64_MICRO, "1e20", -ERANGE);
+	EXPECT_WRITE_ERR(test, IIO_VAL_DECIMAL64_MICRO, "1.5 Hz", -EINVAL);
+}
+
+static void iio_test_write_unsupported_fmt(struct kunit *test)
+{
+	EXPECT_WRITE_ERR(test, IIO_TEST_UNSUPPORTED_FMT, "1", -EINVAL);
+	EXPECT_WRITE_ERR(test, -EBUSY, "1", -EINVAL);
+}
+
+static void iio_test_write_no_get_fmt(struct kunit *test)
+{
+	struct iio_test_write_ctx *ctx = test->priv;
+
+	/* without write_raw_get_fmt() values are parsed as IIO_VAL_INT_PLUS_MICRO */
+	ctx->indio_dev->info = &iio_test_write_info_no_fmt;
+
+	EXPECT_WRITE(test, 0, "1.5", 1, 500000);
+	EXPECT_WRITE(test, 0, "-0.000001", 0, -1);
+	EXPECT_WRITE(test, 0, "1.2345678", 1, 234568);
+	EXPECT_WRITE_ERR(test, 0, "0x10", -EINVAL);
+}
+
+static void iio_test_write_no_write_raw(struct kunit *test)
+{
+	struct iio_test_write_ctx *ctx = test->priv;
+
+	ctx->indio_dev->info = &iio_test_write_info_no_write;
+
+	EXPECT_WRITE_ERR(test, IIO_VAL_INT, "1", -EINVAL);
+}
+
+static void iio_test_write_raw_error(struct kunit *test)
+{
+	struct iio_test_write_priv *priv = iio_test_write_priv(test);
+	ssize_t ret;
+
+	priv->ret = -EBUSY;
+	ret = iio_test_write(test, IIO_VAL_INT, "1");
+	KUNIT_EXPECT_EQ(test, ret, (ssize_t)-EBUSY);
+	KUNIT_EXPECT_TRUE(test, priv->called);
+	KUNIT_EXPECT_EQ(test, priv->val, 1);
+}
+
+static struct kunit_case iio_channel_write_test_cases[] = {
+	KUNIT_CASE(iio_test_write_int),
+	KUNIT_CASE(iio_test_write_int_plus_micro),
+	KUNIT_CASE(iio_test_write_int_plus_nano),
+	KUNIT_CASE(iio_test_write_int_plus_micro_db),
+	KUNIT_CASE(iio_test_write_char),
+	KUNIT_CASE(iio_test_write_int_64),
+	KUNIT_CASE(iio_test_write_decimal64),
+	KUNIT_CASE(iio_test_write_unsupported_fmt),
+	KUNIT_CASE(iio_test_write_no_get_fmt),
+	KUNIT_CASE(iio_test_write_no_write_raw),
+	KUNIT_CASE(iio_test_write_raw_error),
+	{ }
+};
+
+static struct kunit_suite iio_channel_write_test_suite = {
+	.name = "iio-channel-write",
+	.init = iio_test_write_init,
+	.test_cases = iio_channel_write_test_cases,
+};
+
+kunit_test_suite(iio_channel_write_test_suite);
+
+MODULE_AUTHOR("Rodrigo Alencar <rodrigo.alencar@analog.com>");
+MODULE_DESCRIPTION("Test IIO channel info write parsing");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");

-- 
2.43.0


