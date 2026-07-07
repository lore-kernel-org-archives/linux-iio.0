Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A6A38236E;
	Tue,  7 Jul 2026 14:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783433068; cv=none; b=FKOdihdJ/dMSUwFzxTSlloMrmU74zu8yC5j2qW0j5TRHthyRMDl1AP2OkYHZ1Mo+9BHRTe8sZAisB+SY6QK6zCHMG9ZqDWf58cBKpfAZQ665sOGMcJ621umXkHjiXWKF8IHTZ0f0EKuPwhQQnNA4ksbK1DjXd1XhNXZNZRUqsoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783433068; c=relaxed/simple;
	bh=hospj+EPB/ITaTtzEL8candjyeLeuElQSiA/hR6dzI4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fleZLwf0e5Ml2gLH5QOXiYn20iXkV7RbsY+uXD+kLi15+YwQeWxSQPSpw7y3+BrMacrWE/5kmcPf6QOFtrsRbkGQjjUyTgO8dN4uV7R6loHCJ6u5U5xLch7gM/lsVI4STXYiPkJjF2SnC4nzCq/M6Qo8wNI5WJnZEloUXGgcw1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CHUvahzn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CHUvahzn"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D4E79C4AF16;
	Tue,  7 Jul 2026 14:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783433067;
	bh=hospj+EPB/ITaTtzEL8candjyeLeuElQSiA/hR6dzI4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=CHUvahznzi7xaExQ1DK7XjiPrfNr8PuB41B/Dnktg4gjFfOwVxs3y0lWHaFCkjbUG
	 5Mx3yPkLlMv5Ob61sWYb4zxxigci84HpB0Vhavnb3FBdnXEg1LJ5KbLSCVrnUmLqD+
	 tQBXe2yGux07OeDXQiQ7ato/1mlZr7NBe81Bfch5bcK8EprWgzO0WsI+ZDSyZ4ZLCs
	 8Djz50VE1jSC+UxvAboEV6kI2BXkORCuAdOq0SzSlV8HDF2DBzIT4VLAowA6JTPyag
	 wsdHOA1wffOpI//HQEhZ4SoEe+vHNS0w+7yxZ14Km8U7Ph/ijeu+SMX/Y5byoVjwsw
	 oslS8q5GglVQw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2381C44501;
	Tue,  7 Jul 2026 14:04:27 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Tue, 07 Jul 2026 15:04:28 +0100
Subject: [PATCH v7 07/17] iio: test: add kunit tests for channel prefix
 naming generation
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-ad9910-iio-driver-v7-7-a4ec30f63700@analog.com>
References: <20260707-ad9910-iio-driver-v7-0-a4ec30f63700@analog.com>
In-Reply-To: <20260707-ad9910-iio-driver-v7-0-a4ec30f63700@analog.com>
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-hardening@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783433065; l=10364;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=3Noz7TEpTDrgZoPBHyZvQEWeqwFwHS8nbNk2dFiqCW0=;
 b=Yx9Wn1RlWgABqSegNERni0ajOW4oIxS+MtalMH4nSVDgkj7pmlbHEOu5rKQ4+C84p17r4UWvK
 x64iVPJ+7lCBUx1ORUuoeoRiyyaUwX0WBfLz2ruMTasMDxPpnR+XiHv
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Add a KUnit test suite covering __iio_chan_prefix_emit(), the helper
that builds IIO sysfs attribute name prefixes from an iio_chan_spec.
The suite groups cases by the enum iio_shared_by mode it exercises:

  - IIO_SHARED_BY_ALL: produces an empty prefix.
  - IIO_SHARED_BY_DIR: emits direction only ("in" / "out").
  - IIO_SHARED_BY_TYPE: emits "<dir>_<type>" and the differential
    "<dir>_<type>-<type>" variant.
  - IIO_SEPARATE: covers the full matrix of indexed, differential,
    modified, output and extend_name combinations, plus the two
    documented error paths (differential without indexed, differential
    with modifier).

A final case exercises the seq_buf overflow path by passing an
undersized buffer and expects -EOVERFLOW.

Because __iio_chan_prefix_emit() is static, the test translation unit
is pulled into industrialio-core.c.

Also, an entry is created under MAINTAINERS dedicated to tests for IIO
core helpers.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 MAINTAINERS                                |   8 +
 drivers/iio/industrialio-core.c            |   4 +
 drivers/iio/test/Kconfig                   |  14 ++
 drivers/iio/test/iio-test-channel-prefix.c | 246 +++++++++++++++++++++++++++++
 4 files changed, 272 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2b1ec46c5919..57ffc0dcfdb6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12634,6 +12634,14 @@ F:	include/dt-bindings/iio/
 F:	include/linux/iio/
 F:	tools/iio/
 
+IIO CORE KUNIT TESTS
+M:	Lars-Peter Clausen <lars@metafoo.de>
+M:	Rodrigo Alencar <rodrigo.alencar@analog.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	drivers/iio/test/iio-test-channel-prefix.c
+F:	drivers/iio/test/iio-test-format.c
+
 IIO UNIT CONVERTER
 M:	Peter Rosin <peda@lysator.liu.se>
 L:	linux-iio@vger.kernel.org
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index ecc69adf61de..78a3c27d17a1 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -2232,6 +2232,10 @@ EXPORT_SYMBOL_GPL(iio_device_get_current_mode);
 subsys_initcall(iio_init);
 module_exit(iio_exit);
 
+#if IS_ENABLED(CONFIG_IIO_CHANNEL_PREFIX_KUNIT_TEST)
+#include "test/iio-test-channel-prefix.c"
+#endif
+
 MODULE_AUTHOR("Jonathan Cameron <jic23@kernel.org>");
 MODULE_DESCRIPTION("Industrial I/O core");
 MODULE_LICENSE("GPL");
diff --git a/drivers/iio/test/Kconfig b/drivers/iio/test/Kconfig
index 4fc17dd0dcd7..c355b0abd580 100644
--- a/drivers/iio/test/Kconfig
+++ b/drivers/iio/test/Kconfig
@@ -4,6 +4,20 @@
 #
 
 # Keep in alphabetical order
+config IIO_CHANNEL_PREFIX_KUNIT_TEST
+	bool "Test IIO channel prefix" if !KUNIT_ALL_TESTS
+	depends on KUNIT && IIO
+	default KUNIT_ALL_TESTS
+	help
+	  Build unit tests for __iio_chan_prefix_emit(), the helper that
+	  builds IIO sysfs attribute name prefixes from an iio_chan_spec.
+	  The tests are compiled into the IIO core module.
+
+	  For more information on KUnit and unit tests in general, please refer
+	  to the KUnit documentation in Documentation/dev-tools/kunit/.
+
+	  If unsure, say N.
+
 config IIO_GTS_KUNIT_TEST
 	tristate "Test IIO gain-time-scale helpers" if !KUNIT_ALL_TESTS
 	depends on KUNIT
diff --git a/drivers/iio/test/iio-test-channel-prefix.c b/drivers/iio/test/iio-test-channel-prefix.c
new file mode 100644
index 000000000000..e6f2739331f2
--- /dev/null
+++ b/drivers/iio/test/iio-test-channel-prefix.c
@@ -0,0 +1,246 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Unit tests for IIO channel prefix generation.
+ */
+
+#include <kunit/test.h>
+
+#include <linux/iio/iio.h>
+#include <linux/limits.h>
+#include <linux/string.h>
+
+#define PREFIX_BUF_SIZE		(NAME_MAX + 1)
+
+#define EXPECT_PREFIX(_test, _buf, _ret, _expected) do {			\
+		struct kunit *__test = (_test);					\
+		const char *__expected = (_expected);				\
+										\
+		KUNIT_EXPECT_EQ(__test, (_ret), (ssize_t)strlen(__expected));	\
+		KUNIT_EXPECT_STREQ(__test, (_buf), __expected);			\
+	} while (0)
+
+static char *iio_test_prefix_alloc(struct kunit *test)
+{
+	char *buf = kunit_kzalloc(test, PREFIX_BUF_SIZE, GFP_KERNEL);
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf);
+	return buf;
+}
+
+static void iio_test_prefix_shared_by_all(struct kunit *test)
+{
+	const struct iio_chan_spec chan = {
+		.type = IIO_VOLTAGE,
+	};
+	char *buf = iio_test_prefix_alloc(test);
+	ssize_t ret;
+
+	ret = __iio_chan_prefix_emit(NULL, &chan, IIO_SHARED_BY_ALL,
+				     buf, PREFIX_BUF_SIZE);
+	EXPECT_PREFIX(test, buf, ret, "");
+}
+
+static void iio_test_prefix_shared_by_dir(struct kunit *test)
+{
+	const struct iio_chan_spec chan_in = {
+		.type = IIO_VOLTAGE,
+		.output = 0,
+	};
+	const struct iio_chan_spec chan_out = {
+		.type = IIO_VOLTAGE,
+		.output = 1,
+	};
+	char *buf = iio_test_prefix_alloc(test);
+	ssize_t ret;
+
+	ret = __iio_chan_prefix_emit(NULL, &chan_in, IIO_SHARED_BY_DIR,
+				     buf, PREFIX_BUF_SIZE);
+	EXPECT_PREFIX(test, buf, ret, "in");
+
+	memset(buf, 0, PREFIX_BUF_SIZE);
+	ret = __iio_chan_prefix_emit(NULL, &chan_out, IIO_SHARED_BY_DIR,
+				     buf, PREFIX_BUF_SIZE);
+	EXPECT_PREFIX(test, buf, ret, "out");
+}
+
+static void iio_test_prefix_shared_by_type(struct kunit *test)
+{
+	const struct iio_chan_spec chan = {
+		.type = IIO_VOLTAGE,
+	};
+	const struct iio_chan_spec chan_diff = {
+		.type = IIO_VOLTAGE,
+		.differential = 1,
+	};
+	char *buf = iio_test_prefix_alloc(test);
+	ssize_t ret;
+
+	ret = __iio_chan_prefix_emit(NULL, &chan, IIO_SHARED_BY_TYPE,
+				     buf, PREFIX_BUF_SIZE);
+	EXPECT_PREFIX(test, buf, ret, "in_voltage");
+
+	memset(buf, 0, PREFIX_BUF_SIZE);
+	ret = __iio_chan_prefix_emit(NULL, &chan_diff, IIO_SHARED_BY_TYPE,
+				     buf, PREFIX_BUF_SIZE);
+	EXPECT_PREFIX(test, buf, ret, "in_voltage-voltage");
+}
+
+static void iio_test_prefix_separate_simple(struct kunit *test)
+{
+	const struct iio_chan_spec chan = {
+		.type = IIO_TEMP,
+	};
+	char *buf = iio_test_prefix_alloc(test);
+	ssize_t ret;
+
+	ret = __iio_chan_prefix_emit(NULL, &chan, IIO_SEPARATE,
+				     buf, PREFIX_BUF_SIZE);
+	EXPECT_PREFIX(test, buf, ret, "in_temp");
+}
+
+static void iio_test_prefix_separate_indexed(struct kunit *test)
+{
+	const struct iio_chan_spec chan = {
+		.type = IIO_VOLTAGE,
+		.indexed = 1,
+		.channel = 3,
+	};
+	char *buf = iio_test_prefix_alloc(test);
+	ssize_t ret;
+
+	ret = __iio_chan_prefix_emit(NULL, &chan, IIO_SEPARATE,
+				     buf, PREFIX_BUF_SIZE);
+	EXPECT_PREFIX(test, buf, ret, "in_voltage3");
+}
+
+static void iio_test_prefix_separate_indexed_diff(struct kunit *test)
+{
+	const struct iio_chan_spec chan = {
+		.type = IIO_VOLTAGE,
+		.indexed = 1,
+		.differential = 1,
+		.channel = 0,
+		.channel2 = 1,
+	};
+	char *buf = iio_test_prefix_alloc(test);
+	ssize_t ret;
+
+	ret = __iio_chan_prefix_emit(NULL, &chan, IIO_SEPARATE,
+				     buf, PREFIX_BUF_SIZE);
+	EXPECT_PREFIX(test, buf, ret, "in_voltage0-voltage1");
+}
+
+static void iio_test_prefix_separate_modified(struct kunit *test)
+{
+	const struct iio_chan_spec chan = {
+		.type = IIO_ACCEL,
+		.modified = 1,
+		.channel2 = IIO_MOD_X,
+	};
+	char *buf = iio_test_prefix_alloc(test);
+	ssize_t ret;
+
+	ret = __iio_chan_prefix_emit(NULL, &chan, IIO_SEPARATE,
+				     buf, PREFIX_BUF_SIZE);
+	EXPECT_PREFIX(test, buf, ret, "in_accel_x");
+}
+
+static void iio_test_prefix_separate_extend_name(struct kunit *test)
+{
+	const struct iio_chan_spec chan = {
+		.type = IIO_VOLTAGE,
+		.indexed = 1,
+		.channel = 2,
+		.extend_name = "supply",
+	};
+	char *buf = iio_test_prefix_alloc(test);
+	ssize_t ret;
+
+	ret = __iio_chan_prefix_emit(NULL, &chan, IIO_SEPARATE,
+				     buf, PREFIX_BUF_SIZE);
+	EXPECT_PREFIX(test, buf, ret, "in_voltage2_supply");
+}
+
+static void iio_test_prefix_output_separate(struct kunit *test)
+{
+	const struct iio_chan_spec chan = {
+		.type = IIO_VOLTAGE,
+		.output = 1,
+		.indexed = 1,
+		.channel = 0,
+	};
+	char *buf = iio_test_prefix_alloc(test);
+	ssize_t ret;
+
+	ret = __iio_chan_prefix_emit(NULL, &chan, IIO_SEPARATE,
+				     buf, PREFIX_BUF_SIZE);
+	EXPECT_PREFIX(test, buf, ret, "out_voltage0");
+}
+
+static void iio_test_prefix_diff_unindexed_fails(struct kunit *test)
+{
+	const struct iio_chan_spec chan = {
+		.type = IIO_VOLTAGE,
+		.differential = 1,
+	};
+	char *buf = iio_test_prefix_alloc(test);
+	ssize_t ret;
+
+	ret = __iio_chan_prefix_emit(NULL, &chan, IIO_SEPARATE,
+				     buf, PREFIX_BUF_SIZE);
+	KUNIT_EXPECT_EQ(test, ret, -EINVAL);
+}
+
+static void iio_test_prefix_diff_modified_fails(struct kunit *test)
+{
+	const struct iio_chan_spec chan = {
+		.type = IIO_VOLTAGE,
+		.indexed = 1,
+		.differential = 1,
+		.modified = 1,
+		.channel = 0,
+		.channel2 = 1,
+	};
+	char *buf = iio_test_prefix_alloc(test);
+	ssize_t ret;
+
+	ret = __iio_chan_prefix_emit(NULL, &chan, IIO_SEPARATE,
+				     buf, PREFIX_BUF_SIZE);
+	KUNIT_EXPECT_EQ(test, ret, -EINVAL);
+}
+
+static void iio_test_prefix_overflow(struct kunit *test)
+{
+	const struct iio_chan_spec chan = {
+		.type = IIO_VOLTAGE,
+	};
+	char small[4];
+	ssize_t ret;
+
+	ret = __iio_chan_prefix_emit(NULL, &chan, IIO_SHARED_BY_TYPE,
+				     small, sizeof(small));
+	KUNIT_EXPECT_EQ(test, ret, -EOVERFLOW);
+}
+
+static struct kunit_case iio_chan_prefix_test_cases[] = {
+	KUNIT_CASE(iio_test_prefix_shared_by_all),
+	KUNIT_CASE(iio_test_prefix_shared_by_dir),
+	KUNIT_CASE(iio_test_prefix_shared_by_type),
+	KUNIT_CASE(iio_test_prefix_separate_simple),
+	KUNIT_CASE(iio_test_prefix_separate_indexed),
+	KUNIT_CASE(iio_test_prefix_separate_indexed_diff),
+	KUNIT_CASE(iio_test_prefix_separate_modified),
+	KUNIT_CASE(iio_test_prefix_separate_extend_name),
+	KUNIT_CASE(iio_test_prefix_output_separate),
+	KUNIT_CASE(iio_test_prefix_diff_unindexed_fails),
+	KUNIT_CASE(iio_test_prefix_diff_modified_fails),
+	KUNIT_CASE(iio_test_prefix_overflow),
+	{ }
+};
+
+static struct kunit_suite iio_channel_prefix_test_suite = {
+	.name = "iio-channel-prefix",
+	.test_cases = iio_chan_prefix_test_cases,
+};
+
+kunit_test_suite(iio_channel_prefix_test_suite);

-- 
2.43.0


