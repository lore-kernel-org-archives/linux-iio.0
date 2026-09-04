Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0DB51D500
	for <linux-iio@vger.kernel.org>; Fri,  4 Sep 2026 19:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788549882; cv=none; b=Y/4zjvvPBT/BUKPtVBaYFmDAEgpHlmHHe/jEhrLSNyBGtNdVSx8rv+6sT8ZOu/qeFulYbCQCctdu8fVSrZQso6h1ssLTA8xWoLEI32chOLw81Cgv9cV3yZ1QFbXB1JVjYs9PURsZXODVFmVW31/jz1VbYYsZ+9Cvmh2cjmtyW/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788549882; c=relaxed/simple;
	bh=0klfIjaf7zykydJ3k9UBhWmCEM+Yj8xetMmukAaUuqU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SJZVi5AAJGIB5X9MkBYIQS3qfx9X8T1t9VJae9NpIG8U6vv/lS4M8Yv+YUGa0i6OsVSToCcKRjBBCiCvR5qUeBZwQNgbRlahWfDAlLKnTnjptp1GkgAj4TG3iusHXl5pt1OgOfEI7sirFWxPplObHzyeqaVhJGCroOKMjvO5r94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TUKDLj3z; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TUKDLj3z"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c252c7270faso204056166b.3
        for <linux-iio@vger.kernel.org>; Fri, 04 Sep 2026 12:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788549878; x=1789154678; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gjpIbTsWuK8K3J6Y9hpQzW+zaGTn2LteMfzW5ZZSrS4=;
        b=TUKDLj3z5b3QQbBWrxGdGWViBQkGMpwtiKKBB0R1UZFJDsnX/KLVDbsjTwKNWXuBuv
         +Fyg7Ww2JBmpw1eR13HeobbrdAzpimDU7tem3UQOO298GpVNrSP7yfFkpeRf3mhbyy5j
         fB40P0e2WKfas58BpGrTsiLEeWXWk8tBMvu8Ou4qcQ//uhExTPjnJIdWMb6r18doqWPh
         7f0tvL3SGX/Z77P4HnZqq9VuDe7pAqrAaHt6SFviu6JMeG5pveYQLb4zHK/UaKMXsW1/
         D/vFcJoy35F/xqtdlDUvk4gpRNcIvD+XSNG+lFuFdbWLQ+SAeAwgQVCYf8FJk5zq5YNW
         /pSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788549878; x=1789154678;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gjpIbTsWuK8K3J6Y9hpQzW+zaGTn2LteMfzW5ZZSrS4=;
        b=SBVVCrvciX4i0BM/wo/BrIHzVV4l0cDOfeSWrB/xbbC/kFsRg/PdAYTTUTt6gWhh3i
         IHEmfJ9MiTiG2oeGmMnKHCFZ29k4D0rqE3yHS5MIOPHsXL2gV+feOy+uhtb41RQLRm7/
         k6lqNLzMI6x6le+VHa8C/qjom3+IZr4BMN4vKn1gOjf95uO4LL+vVENVtAY4QfFEnxTH
         Zbse0Kwlbt5CX+bYQC7lZ/wLirnunN06AwCX1dXfCDW69lULcrLppLyhayRkA1cmkfAZ
         Rra097jaBcDOsUhjsiPSELVh3RdUcv01GjwbzNIitBHa34t7V4rvJx+pZw4rJjuQ2ngz
         q9qA==
X-Forwarded-Encrypted: i=1; AKwUvBxdEqiikDvCBIkBXKUE5vjG1zODtiYbbjnEbTmdCTNWp1/8BrDTE40hIwk7BwDP1hFZdpJzkPGH0vM=@vger.kernel.org
X-Gm-Message-State: AFuF++kjap0aNv+kwl6ttdgyYGMm67LACRPgeqZve0RciyZloN9eaFfp
	B7ItVYvuRZOkalq+6pnQcNgRYS2yz8nZpevfZ42lvcn86Cs74X3IJkXi
X-Gm-Gg: AYBFou2GkfQkpY76kVJPQaxVAx5xxfPlCqAprhw1M/hjow3kqp6iSNlSvSDTUcPhZ6a
	SU14u50oyM3p2chy2CySwx3d9PsnFk5a1TZUETLm5tbN/NRMHlT2K5mH+fBDGqL2AQ9FJrzdA//
	a9b26htk5ew6aliWED4+OzYUPtJlKV37iiJGUhkHwFPvsrrvE/p/gSEMJJGebGK9yneNqnSIzjI
	nXevO0IXBCSlDmVCJqCRVaBQNrDsYeJi7d2apnaMo883GJ3HA+2iQWsbIBC0drQMfPSIn5A3mVB
	IAVQAGKAzq54aoPFUF1yYLxrhySXqKPIXahv7G22mVzSmEe3XNYzuQj28kgl9Lw99BDHAHhbnU9
	AA+iH5dO8xn0MPcqj9KhufToRduji4xOHXrI1i3WsZnchLSP0rftGAEYhhg5nXHwEFC+81Ts6Iv
	U0qkru1onKpM9v/iWCGWUfjshcrmIOsIDemdG0xN0=
X-Received: by 2002:a17:907:c5cf:b0:c24:d6f0:1223 with SMTP id a640c23a62f3a-c260cbd2e42mr597329466b.12.1788549877708;
        Fri, 04 Sep 2026 12:24:37 -0700 (PDT)
Received: from localhost ([2a02:8071:50c5:5c0::48d4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d5bd618sm159605766b.56.2026.09.04.12.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 12:24:37 -0700 (PDT)
From: Wadim Mueller <wafgo01@gmail.com>
Date: Fri, 04 Sep 2026 21:24:26 +0200
Subject: [PATCH 2/2] iio: flow: slf3s: add KUnit tests for the PM regulator
 balance
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-iio-slf3s-pm-regulator-kunit-v1-2-5ea61e6d6db2@gmail.com>
References: <20260904-iio-slf3s-pm-regulator-kunit-v1-0-5ea61e6d6db2@gmail.com>
In-Reply-To: <20260904-iio-slf3s-pm-regulator-kunit-v1-0-5ea61e6d6db2@gmail.com>
To: Maxwell Doose <maxwell@maxwelld.cc>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Li Youhong <dayou5941@163.com>, Li Youhong <liyouhong@kylinos.cn>, 
 Brendan Higgins <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>, 
 Rae Moar <raemoar63@gmail.com>, linux-kselftest@vger.kernel.org, 
 kunit-dev@googlegroups.com, Wadim Mueller <wafgo01@gmail.com>
X-Mailer: b4 0.14.3

Bind the driver to an emulated SLF3S on a fake I2C adapter, back it with
a regulator whose enable and disable callbacks are counted, and check
that the two stay paired across suspend and resume - including the cycles
in which the sensor NACKs a command or the supply refuses to come up.

The suspend/resume helpers reproduce the PM core's rule that a resume
callback only runs after a suspend callback that returned 0, so that the
tests cannot construct an ordering the core never produces.  One of the
tests relies on it: it cycles the device ten times with rotating failure
injection and asserts that the driver's enable count never climbs above
one.

Signed-off-by: Wadim Mueller <wafgo01@gmail.com>
---
 MAINTAINERS                    |   2 +
 drivers/iio/flow/.kunitconfig  |   6 +
 drivers/iio/flow/Kconfig       |  15 +
 drivers/iio/flow/Makefile      |   1 +
 drivers/iio/flow/slf3s-kunit.c | 734 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 758 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 627595e245f3..5f87c0542700 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24835,6 +24835,8 @@ R:	Maxwell Doose <maxwell@maxwelld.cc>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/iio/flow/sensirion,slf3s.yaml
+F:	drivers/iio/flow/.kunitconfig
+F:	drivers/iio/flow/slf3s-kunit.c
 F:	drivers/iio/flow/slf3s.c
 
 SENSIRION SPS30 AIR POLLUTION SENSOR DRIVER
diff --git a/drivers/iio/flow/.kunitconfig b/drivers/iio/flow/.kunitconfig
new file mode 100644
index 000000000000..20b177a241d0
--- /dev/null
+++ b/drivers/iio/flow/.kunitconfig
@@ -0,0 +1,6 @@
+CONFIG_KUNIT=y
+CONFIG_I2C=y
+CONFIG_REGULATOR=y
+CONFIG_IIO=y
+CONFIG_SENSIRION_SLF3S=y
+CONFIG_SENSIRION_SLF3S_KUNIT_TEST=y
diff --git a/drivers/iio/flow/Kconfig b/drivers/iio/flow/Kconfig
index e0e1a8e3654a..cb56f9d8395e 100644
--- a/drivers/iio/flow/Kconfig
+++ b/drivers/iio/flow/Kconfig
@@ -19,4 +19,19 @@ config SENSIRION_SLF3S
 	  To compile this driver as a module, choose M here: the module
 	  will be called slf3s.
 
+config SENSIRION_SLF3S_KUNIT_TEST
+	tristate "KUnit tests for the Sensirion SLF3S driver" if !KUNIT_ALL_TESTS
+	depends on KUNIT && SENSIRION_SLF3S && REGULATOR
+	default KUNIT_ALL_TESTS
+	help
+	  Build KUnit tests for the Sensirion SLF3S driver.  The tests bind
+	  the driver to an emulated sensor and check that its suspend and
+	  resume callbacks keep the supply regulator balanced, including on
+	  the error paths.
+
+	  For more information on KUnit and unit tests in general, please
+	  refer to the KUnit documentation in Documentation/dev-tools/kunit/.
+
+	  If unsure, say N.
+
 endmenu
diff --git a/drivers/iio/flow/Makefile b/drivers/iio/flow/Makefile
index 3cf4ab95c69c..70c9054da4b6 100644
--- a/drivers/iio/flow/Makefile
+++ b/drivers/iio/flow/Makefile
@@ -5,3 +5,4 @@
 
 # When adding new entries keep the list in alphabetical order
 obj-$(CONFIG_SENSIRION_SLF3S) += slf3s.o
+obj-$(CONFIG_SENSIRION_SLF3S_KUNIT_TEST) += slf3s-kunit.o
diff --git a/drivers/iio/flow/slf3s-kunit.c b/drivers/iio/flow/slf3s-kunit.c
new file mode 100644
index 000000000000..d5e2db855838
--- /dev/null
+++ b/drivers/iio/flow/slf3s-kunit.c
@@ -0,0 +1,734 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit tests for the Sensirion SLF3S driver's power management.
+ *
+ * The tests bind the real driver to a fake I2C device backed by a
+ * programmable regulator, so that every regulator_enable() and
+ * regulator_disable() the driver issues can be counted.  The point of the
+ * suite is the balance of those calls across suspend/resume cycles,
+ * including the cycles in which the sensor or the supply fails.
+ *
+ * Copyright (c) 2026
+ */
+
+#include <kunit/device.h>
+#include <kunit/resource.h>
+#include <kunit/test.h>
+
+#include <linux/cleanup.h>
+#include <linux/crc8.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/mutex.h>
+#include <linux/pm.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
+#include <linux/sprintf.h>
+#include <linux/string.h>
+
+#define SLF3S_TEST_ADDR			0x08
+#define SLF3S_TEST_CRC8_POLY		0x31
+#define SLF3S_TEST_CRC8_INIT		0xff
+#define SLF3S_TEST_PID_LEN		18
+/* "%d-%04x" for an adapter number and a 16-bit address, plus the nul. */
+#define SLF3S_TEST_CONSUMER_LEN		16
+
+/*
+ * Family byte 0x03 and sub-type byte 0x03 make slf3s_detect_variant()
+ * settle on the SLF3S-0600F.  The bytes sit at offsets 1 and 3 of the
+ * product-info block, i.e. in the low half of the first word and the high
+ * half of the second one.
+ */
+#define SLF3S_TEST_PID_WORD0		0x0003
+#define SLF3S_TEST_PID_WORD1		0x0300
+
+enum slf3s_fake_state {
+	SLF3S_FAKE_OFF,
+	SLF3S_FAKE_IDLE,
+	SLF3S_FAKE_MEASURING,
+};
+
+enum slf3s_fake_cmd {
+	SLF3S_FAKE_CMD_NONE,
+	SLF3S_FAKE_CMD_PREP_PID,
+	SLF3S_FAKE_CMD_READ_PID,
+	SLF3S_FAKE_CMD_START_WATER,
+	SLF3S_FAKE_CMD_START_IPA,
+	SLF3S_FAKE_CMD_STOP,
+	SLF3S_FAKE_CMD_UNKNOWN,
+	SLF3S_FAKE_CMD_COUNT,
+};
+
+/**
+ * struct slf3s_fake - protocol-level emulation of an SLF3S sensor
+ * @adap:	I2C adapter the emulated sensor answers on
+ * @lock:	serialises state against the driver's transfers
+ * @state:	power/measurement state of the emulated part
+ * @pid_armed:	a product-id read command was accepted, a read may follow
+ * @fail_cmd:	command whose next occurrence is rejected
+ * @fail_err:	error returned for @fail_cmd
+ * @n_cmd:	per-command counters, indexed by enum slf3s_fake_cmd
+ * @crc_table:	CRC-8 table used to sign the emulated responses
+ */
+struct slf3s_fake {
+	struct i2c_adapter adap;
+	struct mutex lock; /* serialises state against the driver's transfers */
+	enum slf3s_fake_state state;
+	bool pid_armed;
+	enum slf3s_fake_cmd fail_cmd;
+	int fail_err;
+	unsigned int n_cmd[SLF3S_FAKE_CMD_COUNT];
+	u8 crc_table[CRC8_TABLE_SIZE];
+};
+
+/**
+ * struct slf3s_test_reg - regulator that counts what the driver does to it
+ * @rdev:	registered regulator device
+ * @lock:	protects the counters against concurrent callbacks
+ * @n_enable:	successful regulator_enable() calls seen
+ * @n_disable:	successful regulator_disable() calls seen
+ * @enabled:	current state of the emulated supply
+ * @fail_enable: error returned by the next enable, then cleared
+ */
+struct slf3s_test_reg {
+	struct regulator_dev *rdev;
+	struct mutex lock; /* protects the counters against concurrent callbacks */
+	unsigned int n_enable;
+	unsigned int n_disable;
+	bool enabled;
+	int fail_enable;
+};
+
+/**
+ * struct slf3s_test_ctx - per-test fixture
+ * @fake:	emulated sensor
+ * @reg:	emulated supply
+ * @client:	I2C client the driver is bound to
+ * @suspended:	mirrors dev->power.is_suspended for the PM sequencer
+ */
+struct slf3s_test_ctx {
+	struct slf3s_fake fake;
+	struct slf3s_test_reg reg;
+	struct i2c_client *client;
+	bool suspended;
+};
+
+/* --- emulated sensor ---------------------------------------------------- */
+
+static enum slf3s_fake_cmd slf3s_fake_decode(const u8 *buf)
+{
+	static const struct {
+		u8 bytes[2];
+		enum slf3s_fake_cmd cmd;
+	} cmds[] = {
+		{ { 0x36, 0x7c }, SLF3S_FAKE_CMD_PREP_PID },
+		{ { 0xe1, 0x02 }, SLF3S_FAKE_CMD_READ_PID },
+		{ { 0x36, 0x08 }, SLF3S_FAKE_CMD_START_WATER },
+		{ { 0x36, 0x15 }, SLF3S_FAKE_CMD_START_IPA },
+		{ { 0x3f, 0xf9 }, SLF3S_FAKE_CMD_STOP },
+	};
+
+	for (unsigned int i = 0; i < ARRAY_SIZE(cmds); i++) {
+		if (!memcmp(buf, cmds[i].bytes, sizeof(cmds[i].bytes)))
+			return cmds[i].cmd;
+	}
+
+	return SLF3S_FAKE_CMD_UNKNOWN;
+}
+
+static int slf3s_fake_write(struct slf3s_fake *f, struct i2c_msg *msg)
+{
+	enum slf3s_fake_cmd cmd;
+
+	if (msg->len != 2)
+		return -EIO;
+
+	cmd = slf3s_fake_decode(msg->buf);
+	f->n_cmd[cmd]++;
+
+	if (f->fail_cmd == cmd) {
+		f->fail_cmd = SLF3S_FAKE_CMD_NONE;
+		return f->fail_err;
+	}
+
+	switch (cmd) {
+	case SLF3S_FAKE_CMD_PREP_PID:
+	case SLF3S_FAKE_CMD_READ_PID:
+		if (f->state != SLF3S_FAKE_IDLE)
+			return -ENXIO;
+		f->pid_armed = cmd == SLF3S_FAKE_CMD_READ_PID;
+		return 0;
+	case SLF3S_FAKE_CMD_START_WATER:
+	case SLF3S_FAKE_CMD_START_IPA:
+		if (f->state != SLF3S_FAKE_IDLE)
+			return -ENXIO;
+		f->state = SLF3S_FAKE_MEASURING;
+		return 0;
+	case SLF3S_FAKE_CMD_STOP:
+		/* The real part NACKs a stop when it is already idle. */
+		if (f->state != SLF3S_FAKE_MEASURING)
+			return -ENXIO;
+		f->state = SLF3S_FAKE_IDLE;
+		return 0;
+	default:
+		return -ENXIO;
+	}
+}
+
+static void slf3s_fake_put_word(struct slf3s_fake *f, u8 *dst, u16 val)
+{
+	dst[0] = val >> 8;
+	dst[1] = val & 0xff;
+	dst[2] = crc8(f->crc_table, dst, 2, SLF3S_TEST_CRC8_INIT);
+}
+
+/*
+ * Only the product-info block is emulated.  Sample reads are not part of
+ * these tests, and the driver never issues one on its own.
+ */
+static int slf3s_fake_read(struct slf3s_fake *f, struct i2c_msg *msg)
+{
+	u8 buf[SLF3S_TEST_PID_LEN];
+
+	if (!f->pid_armed)
+		return -ENXIO;
+
+	f->pid_armed = false;
+
+	if (msg->len != sizeof(buf))
+		return -EIO;
+
+	slf3s_fake_put_word(f, &buf[0], SLF3S_TEST_PID_WORD0);
+	slf3s_fake_put_word(f, &buf[3], SLF3S_TEST_PID_WORD1);
+	for (unsigned int i = 6; i < sizeof(buf); i += 3)
+		slf3s_fake_put_word(f, &buf[i], 0);
+
+	memcpy(msg->buf, buf, sizeof(buf));
+
+	return 0;
+}
+
+static int slf3s_fake_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
+			   int num)
+{
+	struct slf3s_fake *f = i2c_get_adapdata(adap);
+
+	guard(mutex)(&f->lock);
+
+	for (int i = 0; i < num; i++) {
+		int ret;
+
+		if (msgs[i].addr != SLF3S_TEST_ADDR)
+			return -ENXIO;
+
+		if (f->state == SLF3S_FAKE_OFF)
+			return -ENXIO;
+
+		if (msgs[i].flags & I2C_M_RD)
+			ret = slf3s_fake_read(f, &msgs[i]);
+		else
+			ret = slf3s_fake_write(f, &msgs[i]);
+
+		if (ret)
+			return ret;
+	}
+
+	return num;
+}
+
+static u32 slf3s_fake_func(struct i2c_adapter *adap)
+{
+	return I2C_FUNC_I2C;
+}
+
+static const struct i2c_algorithm slf3s_fake_algo = {
+	.xfer = slf3s_fake_xfer,
+	.functionality = slf3s_fake_func,
+};
+
+static void slf3s_fake_fail_next(struct slf3s_fake *f,
+				 enum slf3s_fake_cmd cmd, int err)
+{
+	guard(mutex)(&f->lock);
+
+	f->fail_cmd = cmd;
+	f->fail_err = err;
+}
+
+static enum slf3s_fake_state slf3s_fake_state(struct slf3s_fake *f)
+{
+	guard(mutex)(&f->lock);
+
+	return f->state;
+}
+
+/* --- emulated supply ---------------------------------------------------- */
+
+static int slf3s_test_reg_enable(struct regulator_dev *rdev)
+{
+	struct slf3s_test_reg *reg = rdev_get_drvdata(rdev);
+
+	guard(mutex)(&reg->lock);
+
+	if (reg->fail_enable) {
+		int err = reg->fail_enable;
+
+		reg->fail_enable = 0;
+		return err;
+	}
+
+	reg->n_enable++;
+	reg->enabled = true;
+
+	return 0;
+}
+
+static int slf3s_test_reg_disable(struct regulator_dev *rdev)
+{
+	struct slf3s_test_reg *reg = rdev_get_drvdata(rdev);
+
+	guard(mutex)(&reg->lock);
+
+	reg->n_disable++;
+	reg->enabled = false;
+
+	return 0;
+}
+
+static int slf3s_test_reg_is_enabled(struct regulator_dev *rdev)
+{
+	struct slf3s_test_reg *reg = rdev_get_drvdata(rdev);
+
+	guard(mutex)(&reg->lock);
+
+	return reg->enabled;
+}
+
+static void slf3s_test_reg_fail_enable(struct slf3s_test_reg *reg, int err)
+{
+	guard(mutex)(&reg->lock);
+
+	reg->fail_enable = err;
+}
+
+static const struct regulator_ops slf3s_test_reg_ops = {
+	.enable = slf3s_test_reg_enable,
+	.disable = slf3s_test_reg_disable,
+	.is_enabled = slf3s_test_reg_is_enabled,
+};
+
+static const struct regulator_desc slf3s_test_reg_desc = {
+	.name = "slf3s-test-vdd",
+	.id = -1,
+	.type = REGULATOR_VOLTAGE,
+	.owner = THIS_MODULE,
+	.ops = &slf3s_test_reg_ops,
+};
+
+/* --- PM sequencer ------------------------------------------------------- */
+
+/*
+ * device_suspend() sets dev->power.is_suspended only when the callback
+ * returned 0, and device_resume() bails out before running any callback
+ * when the flag is clear.  The resume callback therefore runs if and only
+ * if the immediately preceding suspend callback succeeded.  The helpers
+ * below reproduce that rule so the tests cannot construct a sequence the
+ * PM core never produces.
+ */
+static int slf3s_test_suspend(struct kunit *test, struct slf3s_test_ctx *ctx)
+{
+	struct device *dev = &ctx->client->dev;
+	int ret;
+
+	KUNIT_ASSERT_FALSE_MSG(test, ctx->suspended,
+			       "suspend called twice without a resume");
+	KUNIT_ASSERT_NOT_NULL(test, dev->driver);
+	KUNIT_ASSERT_NOT_NULL(test, dev->driver->pm);
+	KUNIT_ASSERT_NOT_NULL(test, dev->driver->pm->suspend);
+
+	ret = dev->driver->pm->suspend(dev);
+	ctx->suspended = ret == 0;
+
+	return ret;
+}
+
+static int slf3s_test_resume(struct kunit *test, struct slf3s_test_ctx *ctx)
+{
+	struct device *dev = &ctx->client->dev;
+
+	KUNIT_ASSERT_TRUE_MSG(test, ctx->suspended,
+			      "resume after a failed suspend: the PM core does not do this");
+	KUNIT_ASSERT_NOT_NULL(test, dev->driver->pm->resume);
+
+	ctx->suspended = false;
+
+	return dev->driver->pm->resume(dev);
+}
+
+/*
+ * After a resume whose start command failed, the sensor is powered but
+ * idle.  A test that wants to continue cycling has to put it back into a
+ * measuring state; doing so through the fake rather than through the
+ * driver keeps the driver's call counts untouched.
+ */
+static void slf3s_test_resume_sensor(struct kunit *test,
+				     struct slf3s_test_ctx *ctx)
+{
+	guard(mutex)(&ctx->fake.lock);
+
+	if (ctx->fake.state == SLF3S_FAKE_IDLE)
+		ctx->fake.state = SLF3S_FAKE_MEASURING;
+}
+
+#define KUNIT_EXPECT_REG_BALANCED(test, ctx) do {			\
+	KUNIT_EXPECT_EQ((test), (ctx)->reg.n_enable,			\
+			(ctx)->reg.n_disable);				\
+	KUNIT_EXPECT_FALSE((test), (ctx)->reg.enabled);		\
+} while (0)
+
+/* --- fixture ------------------------------------------------------------ */
+
+static void slf3s_test_del_adapter(void *ptr)
+{
+	i2c_del_adapter(ptr);
+}
+
+static void slf3s_test_unregister_reg(void *ptr)
+{
+	regulator_unregister(ptr);
+}
+
+static void slf3s_test_unregister_client(void *ptr)
+{
+	i2c_unregister_device(ptr);
+}
+
+static void slf3s_test_destroy_mutex(void *data)
+{
+	mutex_destroy(data);
+}
+
+static int slf3s_test_init(struct kunit *test)
+{
+	struct regulator_consumer_supply *supply;
+	struct regulator_init_data *init_data;
+	struct i2c_board_info info = { };
+	struct regulator_config config = { };
+	struct slf3s_test_ctx *ctx;
+	struct device *parent;
+	char *consumer;
+	int ret;
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+	test->priv = ctx;
+
+	/* Actions run in reverse, so destroy after the unbind takes the locks. */
+	mutex_init(&ctx->fake.lock);
+	ret = kunit_add_action_or_reset(test, slf3s_test_destroy_mutex,
+					&ctx->fake.lock);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	mutex_init(&ctx->reg.lock);
+	ret = kunit_add_action_or_reset(test, slf3s_test_destroy_mutex,
+					&ctx->reg.lock);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	crc8_populate_msb(ctx->fake.crc_table, SLF3S_TEST_CRC8_POLY);
+	ctx->fake.state = SLF3S_FAKE_OFF;
+
+	parent = kunit_device_register(test, "slf3s-test");
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, parent);
+
+	strscpy(ctx->fake.adap.name, "slf3s-test-adapter",
+		sizeof(ctx->fake.adap.name));
+	ctx->fake.adap.owner = THIS_MODULE;
+	ctx->fake.adap.algo = &slf3s_fake_algo;
+	ctx->fake.adap.dev.parent = parent;
+	i2c_set_adapdata(&ctx->fake.adap, &ctx->fake);
+
+	ret = i2c_add_adapter(&ctx->fake.adap);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	ret = kunit_add_action_or_reset(test, slf3s_test_del_adapter,
+					&ctx->fake.adap);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	/*
+	 * The supply has to be resolvable by the time the client probes, and
+	 * without a device tree that means a consumer map keyed on the client
+	 * name.  The name is "<bus>-<addr>", so the adapter has to exist
+	 * first.
+	 */
+	consumer = kunit_kzalloc(test, SLF3S_TEST_CONSUMER_LEN, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, consumer);
+	scnprintf(consumer, SLF3S_TEST_CONSUMER_LEN, "%d-%04x",
+		  ctx->fake.adap.nr, SLF3S_TEST_ADDR);
+
+	supply = kunit_kzalloc(test, sizeof(*supply), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, supply);
+	supply->supply = "vdd";
+	supply->dev_name = consumer;
+
+	init_data = kunit_kzalloc(test, sizeof(*init_data), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, init_data);
+	init_data->constraints.valid_ops_mask = REGULATOR_CHANGE_STATUS;
+	init_data->num_consumer_supplies = 1;
+	init_data->consumer_supplies = supply;
+
+	config.dev = parent;
+	config.init_data = init_data;
+	config.driver_data = &ctx->reg;
+
+	ctx->reg.rdev = regulator_register(parent, &slf3s_test_reg_desc,
+					   &config);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->reg.rdev);
+	ret = kunit_add_action_or_reset(test, slf3s_test_unregister_reg,
+					ctx->reg.rdev);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	/* Powered but idle, like a part that has just been given its supply. */
+	ctx->fake.state = SLF3S_FAKE_IDLE;
+
+	strscpy(info.type, "slf3s-0600f", sizeof(info.type));
+	info.addr = SLF3S_TEST_ADDR;
+
+	ctx->client = i2c_new_client_device(&ctx->fake.adap, &info);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->client);
+	ret = kunit_add_action_or_reset(test, slf3s_test_unregister_client,
+					ctx->client);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	KUNIT_ASSERT_NOT_NULL_MSG(test, ctx->client->dev.driver,
+				  "the slf3s driver did not bind");
+	/* One enable proves we got this regulator, not the dummy one. */
+	KUNIT_ASSERT_EQ_MSG(test, ctx->reg.n_enable, 1,
+			    "driver did not enable the test regulator");
+
+	return 0;
+}
+
+/* --- tests -------------------------------------------------------------- */
+
+/* T1: a clean cycle pairs every enable with a disable. */
+static void slf3s_test_cycle_balanced(struct kunit *test)
+{
+	struct slf3s_test_ctx *ctx = test->priv;
+
+	KUNIT_EXPECT_EQ(test, slf3s_fake_state(&ctx->fake),
+			SLF3S_FAKE_MEASURING);
+
+	KUNIT_EXPECT_EQ(test, slf3s_test_suspend(test, ctx), 0);
+	KUNIT_EXPECT_EQ(test, slf3s_fake_state(&ctx->fake), SLF3S_FAKE_IDLE);
+	KUNIT_EXPECT_FALSE(test, ctx->reg.enabled);
+	KUNIT_EXPECT_EQ(test, ctx->reg.n_disable, 1);
+
+	KUNIT_EXPECT_EQ(test, slf3s_test_resume(test, ctx), 0);
+	KUNIT_EXPECT_EQ(test, slf3s_fake_state(&ctx->fake),
+			SLF3S_FAKE_MEASURING);
+	KUNIT_EXPECT_TRUE(test, ctx->reg.enabled);
+	KUNIT_EXPECT_EQ(test, ctx->reg.n_enable, 2);
+
+	kunit_release_action(test, slf3s_test_unregister_client, ctx->client);
+
+	KUNIT_EXPECT_EQ(test, ctx->reg.n_enable, 2);
+	KUNIT_EXPECT_EQ(test, ctx->reg.n_disable, 2);
+	KUNIT_EXPECT_REG_BALANCED(test, ctx);
+}
+
+/*
+ * T5: the proof for the question raised on the list.  The PM core never
+ * runs two resumes in a row, so the driver's enable count can never climb
+ * above one, no matter how often the sensor fails.  The sequencer refuses
+ * illegal orderings, so this loop is the legal worst case.
+ */
+static void slf3s_test_cycles_never_leak(struct kunit *test)
+{
+	struct slf3s_test_ctx *ctx = test->priv;
+
+	for (unsigned int i = 0; i < 10; i++) {
+		int ret;
+
+		switch (i % 3) {
+		case 1:
+			slf3s_fake_fail_next(&ctx->fake,
+					     SLF3S_FAKE_CMD_START_WATER,
+					     -ENXIO);
+			break;
+		case 2:
+			slf3s_fake_fail_next(&ctx->fake, SLF3S_FAKE_CMD_STOP,
+					     -ENXIO);
+			break;
+		default:
+			break;
+		}
+
+		ret = slf3s_test_suspend(test, ctx);
+		KUNIT_EXPECT_LE_MSG(test, ctx->reg.n_enable - ctx->reg.n_disable,
+				    1, "supply enabled more than once, cycle %u",
+				    i);
+		if (ret)
+			continue;
+
+		slf3s_test_resume(test, ctx);
+		KUNIT_EXPECT_LE_MSG(test, ctx->reg.n_enable - ctx->reg.n_disable,
+				    1, "supply enabled more than once, cycle %u",
+				    i);
+
+		/* Put the sensor back into a measuring state for the next round. */
+		if (slf3s_fake_state(&ctx->fake) != SLF3S_FAKE_MEASURING &&
+		    !ctx->suspended)
+			slf3s_test_resume_sensor(test, ctx);
+	}
+}
+
+/* T6: unbinding after a failed resume must not leave the supply on. */
+static void slf3s_test_unbind_after_failed_resume(struct kunit *test)
+{
+	struct slf3s_test_ctx *ctx = test->priv;
+
+	KUNIT_EXPECT_EQ(test, slf3s_test_suspend(test, ctx), 0);
+
+	slf3s_fake_fail_next(&ctx->fake, SLF3S_FAKE_CMD_START_WATER, -ENXIO);
+	KUNIT_EXPECT_LT(test, slf3s_test_resume(test, ctx), 0);
+
+	kunit_release_action(test, slf3s_test_unregister_client, ctx->client);
+
+	KUNIT_EXPECT_REG_BALANCED(test, ctx);
+}
+
+/* T7: a probe that fails must not leave the supply enabled. */
+static void slf3s_test_probe_failure(struct kunit *test)
+{
+	struct slf3s_test_ctx *ctx = test->priv;
+	struct i2c_board_info info = { };
+	struct i2c_client *client;
+
+	/* Start from a clean slate: drop the client the fixture bound. */
+	kunit_release_action(test, slf3s_test_unregister_client, ctx->client);
+	ctx->client = NULL;
+	KUNIT_ASSERT_FALSE(test, ctx->reg.enabled);
+
+	slf3s_fake_fail_next(&ctx->fake, SLF3S_FAKE_CMD_PREP_PID, -ENXIO);
+
+	strscpy(info.type, "slf3s-0600f", sizeof(info.type));
+	info.addr = SLF3S_TEST_ADDR;
+
+	client = i2c_new_client_device(&ctx->fake.adap, &info);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, client);
+
+	KUNIT_EXPECT_NULL_MSG(test, client->dev.driver,
+			      "probe was expected to fail");
+	KUNIT_EXPECT_REG_BALANCED(test, ctx);
+
+	i2c_unregister_device(client);
+}
+
+/* T2: a resume whose start command fails must switch the supply back off. */
+static void slf3s_test_resume_start_failure(struct kunit *test)
+{
+	struct slf3s_test_ctx *ctx = test->priv;
+
+	KUNIT_ASSERT_EQ(test, slf3s_test_suspend(test, ctx), 0);
+
+	slf3s_fake_fail_next(&ctx->fake, SLF3S_FAKE_CMD_START_WATER, -ENXIO);
+	KUNIT_EXPECT_LT(test, slf3s_test_resume(test, ctx), 0);
+
+	KUNIT_EXPECT_FALSE_MSG(test, ctx->reg.enabled,
+			       "supply left on after a failed resume");
+	KUNIT_EXPECT_REG_BALANCED(test, ctx);
+}
+
+/* T3: a stop command that fails is no reason to keep the supply on. */
+static void slf3s_test_suspend_stop_failure(struct kunit *test)
+{
+	struct slf3s_test_ctx *ctx = test->priv;
+
+	slf3s_fake_fail_next(&ctx->fake, SLF3S_FAKE_CMD_STOP, -ENXIO);
+	slf3s_test_suspend(test, ctx);
+
+	KUNIT_EXPECT_FALSE_MSG(test, ctx->reg.enabled,
+			       "supply left on after a failed stop command");
+	KUNIT_EXPECT_REG_BALANCED(test, ctx);
+}
+
+/*
+ * T4: if the supply itself refuses to come up, the next suspend must not
+ * call regulator_disable() on a supply that was never enabled.  Doing so
+ * trips "unbalanced disables" in the regulator core and aborts the whole
+ * system suspend with -EIO.
+ */
+static void slf3s_test_resume_enable_failure(struct kunit *test)
+{
+	struct slf3s_test_ctx *ctx = test->priv;
+	unsigned int n_disable;
+
+	KUNIT_ASSERT_EQ(test, slf3s_test_suspend(test, ctx), 0);
+	n_disable = ctx->reg.n_disable;
+
+	slf3s_test_reg_fail_enable(&ctx->reg, -EIO);
+	KUNIT_EXPECT_EQ(test, slf3s_test_resume(test, ctx), -EIO);
+	KUNIT_EXPECT_FALSE(test, ctx->reg.enabled);
+
+	/* The sensor answers even though the driver's supply never came up. */
+	slf3s_test_resume_sensor(test, ctx);
+
+	KUNIT_EXPECT_EQ_MSG(test, slf3s_test_suspend(test, ctx), 0,
+			    "suspend failed after a resume that could not enable the supply");
+	KUNIT_EXPECT_EQ_MSG(test, ctx->reg.n_disable, n_disable,
+			    "driver disabled a supply it never enabled");
+	KUNIT_EXPECT_REG_BALANCED(test, ctx);
+}
+
+/*
+ * T8: the devm cleanup must not disable a supply that is already off.
+ *
+ * An unbalanced regulator_disable() WARNs and returns before the fake's
+ * disable op runs, so n_disable cannot tell buggy from correct here.
+ * Count the WARN() instead.
+ */
+static void slf3s_test_unbind_after_enable_failure(struct kunit *test)
+{
+	struct slf3s_test_ctx *ctx = test->priv;
+	unsigned int n_disable;
+
+	KUNIT_ASSERT_EQ(test, slf3s_test_suspend(test, ctx), 0);
+	n_disable = ctx->reg.n_disable;
+
+	slf3s_test_reg_fail_enable(&ctx->reg, -EIO);
+	KUNIT_EXPECT_EQ(test, slf3s_test_resume(test, ctx), -EIO);
+
+	kunit_warning_suppress(test) {
+		kunit_release_action(test, slf3s_test_unregister_client,
+				     ctx->client);
+		KUNIT_EXPECT_EQ_MSG(test, KUNIT_SUPPRESSED_WARNING_COUNT(), 0,
+				    "unbind triggered \"unbalanced disables\" for a supply that was already off");
+	}
+
+	KUNIT_EXPECT_EQ_MSG(test, ctx->reg.n_disable, n_disable,
+			    "unbind disabled a supply that was already off");
+	KUNIT_EXPECT_REG_BALANCED(test, ctx);
+}
+
+static struct kunit_case slf3s_test_cases[] = {
+	KUNIT_CASE(slf3s_test_cycle_balanced),
+	KUNIT_CASE(slf3s_test_cycles_never_leak),
+	KUNIT_CASE(slf3s_test_unbind_after_failed_resume),
+	KUNIT_CASE(slf3s_test_probe_failure),
+	KUNIT_CASE(slf3s_test_resume_start_failure),
+	KUNIT_CASE(slf3s_test_suspend_stop_failure),
+	KUNIT_CASE(slf3s_test_resume_enable_failure),
+	KUNIT_CASE(slf3s_test_unbind_after_enable_failure),
+	{ }
+};
+
+static struct kunit_suite slf3s_test_suite = {
+	.name = "slf3s-pm",
+	.init = slf3s_test_init,
+	.test_cases = slf3s_test_cases,
+};
+
+kunit_test_suite(slf3s_test_suite);
+
+MODULE_DESCRIPTION("KUnit tests for the Sensirion SLF3S driver");
+MODULE_LICENSE("GPL");

-- 
2.55.0

