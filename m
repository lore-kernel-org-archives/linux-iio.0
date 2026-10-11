Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5A8435502
	for <linux-iio@vger.kernel.org>; Sun, 11 Oct 2026 23:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791760528; cv=none; b=q7NM1hOqYv9Z91MSyEhautkmPvRrk0oXIOSbrcYUoUzszT7dUk9ZCcmWQPOHgp8ekU7A477o1V3fwlcGaTfslO6j+Yad7dI5YfWAAxIAcEEy26bzQoyqt70rwWM4b1pKqhiUv8VuhC5oJtEwtzKZmPgG+L9NXpffkp+rmbrCahk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791760528; c=relaxed/simple;
	bh=bHCaf2cQnvaSzG0n+2uBG1JAe8YLpZ0uK7FOK+C/9Uc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iHrytCx/0sFH7lp6Z8eEHrw46bPH11CAmBSXldfMT+PbeQlRDfC4k9zR0X5CMzi7SIRLbLPR/RhFtquhMtWNmzFiDRvZVSlKVx5fU9m6PDiLmyuDvEBYJ0ornTn2t8RJiWr7VqwDRkqs4klJukazxWKCR2U2gUf543eYwXZ9k4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pv84UUif; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pv84UUif"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-89a595332c7so368194b3a.0
        for <linux-iio@vger.kernel.org>; Sun, 11 Oct 2026 16:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791760525; x=1792365325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D03yh9hg4Z7p1LLplFSLrS9roWPWngYbJKfaB1ZVXjs=;
        b=Pv84UUif1C8oBJWfc/WEgClrKo1a2Z12gMM289ldK7MBD9x95YRqK2jGuOzIjac+Ch
         qn5O25YAwbtdo7AlzzGO7aSYZj1AtqZuOis1y1vBpL7cKqLlQvXs4J4hK6OkO0/ctpt3
         81JxG7Qlj7TTc1C+hQ2s0vF9dMXIRi9fuvlE8vIqEuAM6PPunDjbpV9HozgQ+zTPMqGA
         nmVQE+a6Al2uAn3j/xNM1phoNTZSLW6d1p7VAQcbWXUlsLwws6KmS/hvgQTjrimn9/kN
         dqGIEXpE+NWAgiTL3mVoWlKLg2/dbZokkBcL8cf6Zmu4ScxfxddD2829AtD45lYOzaOA
         8z6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791760525; x=1792365325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=D03yh9hg4Z7p1LLplFSLrS9roWPWngYbJKfaB1ZVXjs=;
        b=PfYtOv6ingHfLWpKvuL62vfDL+UOqMPr5kDTkpCGBGzPbWmOegygCJsSMrNjsAiZ0/
         1RoY5hy1OgvI2dUxo7JQGxAWJasmndgWQ3XZi7c0fYV8RBgNr8+XNLy+VvA8oHqJTkf4
         MdOe1CKa4ng4eEnoCCiEDt9ErX5+w/B3TDQkwZXxCVtlM05esJsTfR8Y0N2P/b0VNGGE
         NAY1Oa+u0v3vis9nJSvEPj7aid1jBY19UN3fAzTw4lVSEmILBGcsPlgo3OlQ0Y2nZEJO
         v/NM+lhhu6EPvUdnrSIHtzEysnmQ5ONozMZvS8e6MYYrGjnYk8u545iGEKJdOpoFUy2S
         1DGg==
X-Forwarded-Encrypted: i=1; AKwUvBzxh1EWtX2UwV52jvhl4bvf3bcu/pRFiilnJM2JOaxAxvsd00dxZ/CX04LyT7lUkwcWCZfnuQjH20I=@vger.kernel.org
X-Gm-Message-State: AFq9FYImUIQ30/uYUCi9HWyEHF5CCKHpaIfbiiN9dZDXyz4s8cTvqL0m
	lGqubvIfPaIn2Q/t+m+eaSqTllr8ZtUEl/fFRL8SrGCuOq5nE7EktYii
X-Gm-Gg: AYBFou3FTBYNJsbAVJCZsy6PPxjruPRvtb4nxlFoA//UVNf59Q2EvuhSWkVGtXQvu1e
	sItz3BZ5uyGzymsgHgtsUg9NyCw11TNl3s5mvUfOlQaeXJIShYycUCE0sy6k1XomadcKhjs1g6Z
	PY58M5+sERbjdg5zHYlkAdQguXm2PzDI+CsUySBU2uTnehg0GLpk/YHI2iD8ye4BMNv+a5JWqQ+
	qtrB8aZdKad4rV6p44LJPDF21TPt2cLUWkGXNB9vFeNW4pXubvbiKsCzvWu9nns/THvngVmAO3M
	FBgRx4tuTWL/jQusKYwOuKbMlib4TthC6qbKnzXADj7S9x0AiCfXaVJ5CgD215LVDv2FMsBuL1E
	vZvIAlfDJhgtieTu4sNHTFSW4mUSdElh+uVQMfltw6vbaOZVAxNKFE1V/VmOTHLXwtSWyLxz5fq
	5GBHtdwCZ4aZv8Q0oin3Fx2+y1ADq1WHe2w6oSyV8/S6GcWnSEmTKAKU2i5U4CLXSQNlZvrg5K8
	cgXdFTmIlpsLd5Qgcln89U3bW9ZU/R7B1seTp5mwkvjKhbm4J4JGTChlfePvd1b1DheVAhlbhpA
	rHuqF94=
X-Received: by 2002:a05:6a00:3d06:b0:886:a6f8:1f1b with SMTP id d2e1a72fcca58-897c6d1de98mr6831307b3a.37.1791760525040;
        Sun, 11 Oct 2026 16:15:25 -0700 (PDT)
Received: from DESKTOP-G3E0OSP.localdomain ([58.224.60.243])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-896c48945dcsm3188917b3a.54.2026.10.11.16.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 16:15:24 -0700 (PDT)
From: Jinseob Kim <kimjinseob88@gmail.com>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Cc: kimjinseob88@gmail.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	neil.armstrong@linaro.org,
	andersson@kernel.org,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v11 8/8] iio: osf: add IIO KUnit tests
Date: Mon, 12 Oct 2026 08:13:40 +0900
Message-ID: <20261011231340.42885-9-kimjinseob88@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261011231340.42885-1-kimjinseob88@gmail.com>
References: <20261011231340.42885-1-kimjinseob88@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Exercise active-scan packing, timestamp alignment and producer quiescence
during buffer reconfiguration and unregister. Check that a blocked OSF
push retains its active scan mask until its mode claim is released.

Use deferred actions for
workers, registered devices, temporary buffer callbacks and extra device
references so assertion aborts release resources in ownership order.

Assisted-by: LLM
Signed-off-by: Jinseob Kim <kimjinseob88@gmail.com>
---
 drivers/iio/sensorhubs/osf/Kconfig        |   2 +-
 drivers/iio/sensorhubs/osf/Makefile       |   2 +-
 drivers/iio/sensorhubs/osf/osf_iio_test.c | 386 ++++++++++++++++++++++
 3 files changed, 388 insertions(+), 2 deletions(-)
 create mode 100644 drivers/iio/sensorhubs/osf/osf_iio_test.c

diff --git a/drivers/iio/sensorhubs/osf/Kconfig b/drivers/iio/sensorhubs/osf/Kconfig
index 316f33be1327ca85eb18920b8d610a3e983439d2..b4a2cde9645e588703fd7f3f315a6d8b6a90f9c9 100644
--- a/drivers/iio/sensorhubs/osf/Kconfig
+++ b/drivers/iio/sensorhubs/osf/Kconfig
@@ -20,7 +20,7 @@ config OPEN_SENSOR_FUSION_KUNIT_TEST
 	default KUNIT_ALL_TESTS
 	help
 	  Build focused unit tests for the Open Sensor Fusion core sample
-	  acceptance, direct-read cache, and capability/session handling. The tests
+	  acceptance, direct-read cache, and IIO buffer paths. The tests
 	  exercise accepted, ignored, and rejected sample handling without
 	  exposing additional production interfaces.
 
diff --git a/drivers/iio/sensorhubs/osf/Makefile b/drivers/iio/sensorhubs/osf/Makefile
index c2f5ba065a62fef2a4897034239b405ccdd69250..6a28b14cae1f358d485cea67f44df3647939a560 100644
--- a/drivers/iio/sensorhubs/osf/Makefile
+++ b/drivers/iio/sensorhubs/osf/Makefile
@@ -4,4 +4,4 @@ obj-$(CONFIG_OPEN_SENSOR_FUSION) += open-sensor-fusion.o
 
 open-sensor-fusion-y := osf_core.o osf_iio.o osf_protocol.o osf_serdev.o \
 			 osf_stream.o
-open-sensor-fusion-$(CONFIG_OPEN_SENSOR_FUSION_KUNIT_TEST) += osf_core_test.o
+open-sensor-fusion-$(CONFIG_OPEN_SENSOR_FUSION_KUNIT_TEST) += osf_core_test.o osf_iio_test.o
diff --git a/drivers/iio/sensorhubs/osf/osf_iio_test.c b/drivers/iio/sensorhubs/osf/osf_iio_test.c
new file mode 100644
index 0000000000000000000000000000000000000000..4c3fd8cfb2b2674bbb91a311afbab812a19db284
--- /dev/null
+++ b/drivers/iio/sensorhubs/osf/osf_iio_test.c
@@ -0,0 +1,386 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <kunit/device.h>
+#include <kunit/test.h>
+
+#include <linux/bitmap.h>
+#include <linux/completion.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/buffer_impl.h>
+#include <linux/iio/iio.h>
+#include <linux/kthread.h>
+#include <linux/string.h>
+
+#include "osf_core.h"
+#include "osf_iio.h"
+
+KUNIT_DEFINE_ACTION_WRAPPER(osf_iio_test_unregister, osf_iio_unregister_sensor,
+			    struct iio_dev *);
+
+KUNIT_DEFINE_ACTION_WRAPPER(osf_iio_test_put_device, put_device, struct device *);
+
+static noinline void osf_test_poison_stack(void)
+{
+	u8 bytes[1024];
+
+	memset(bytes, 0xa5, sizeof(bytes));
+	barrier_data(bytes);
+}
+
+static void osf_iio_check_scan(struct kunit *test, struct iio_dev *indio_dev,
+			       const s32 *values, unsigned int channels,
+			       unsigned int mask, bool ts)
+{
+	struct iio_buffer *buffer = indio_dev->buffer;
+	unsigned int data_bytes = hweight32(mask) * sizeof(s32);
+	unsigned int ts_offset = ALIGN(data_bytes, 8);
+	unsigned int scan_bytes = ts ? ts_offset + 8 : data_bytes;
+	unsigned int offset = 0;
+	u8 scan[24] __aligned(8);
+	s64 before, after, timestamp;
+	int ret;
+
+	bitmap_zero((unsigned long *)buffer->scan_mask, iio_get_masklength(indio_dev));
+	for (unsigned int i = 0; i < channels; i++)
+		if (mask & BIT(i))
+			set_bit(i, (unsigned long *)buffer->scan_mask);
+	buffer->scan_timestamp = ts;
+	ret = iio_update_buffers(indio_dev, buffer, NULL);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	kunit_info(test, "device=%s mask=%u ts=%u bytes=%u\n",
+		   indio_dev->name, mask, ts, scan_bytes);
+	memset(scan, 0xa5, sizeof(scan));
+	before = iio_get_time_ns(indio_dev);
+	osf_test_poison_stack();
+	ret = osf_iio_push_sample(indio_dev, values, channels);
+	after = iio_get_time_ns(indio_dev);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, buffer->bytes_per_datum, scan_bytes);
+	ret = iio_pop_from_buffer(buffer, scan);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	if (ret)
+		goto disable;
+
+	for (unsigned int i = 0; i < channels; i++) {
+		if (!(mask & BIT(i)))
+			continue;
+		KUNIT_EXPECT_MEMEQ(test, scan + offset, &values[i], sizeof(s32));
+		offset += sizeof(s32);
+	}
+	if (ts) {
+		for (unsigned int i = data_bytes; i < ts_offset; i++)
+			KUNIT_EXPECT_EQ(test, scan[i], (u8)0);
+		memcpy(&timestamp, scan + ts_offset, sizeof(timestamp));
+		KUNIT_EXPECT_GE(test, timestamp, before);
+		KUNIT_EXPECT_LE(test, timestamp, after);
+	}
+	/* Neither kfifo nor the producer may write outside the consumer stride. */
+	for (unsigned int i = scan_bytes; i < sizeof(scan); i++)
+		KUNIT_EXPECT_EQ(test, scan[i], (u8)0xa5);
+
+disable:
+	KUNIT_EXPECT_EQ(test, iio_update_buffers(indio_dev, NULL, buffer), 0);
+}
+
+/* Protect timestamp alignment holes and every supported scan layout. */
+static void osf_iio_scan_bytes_test(struct kunit *test)
+{
+	static const u16 types[] = {
+		OSF_SENSOR_ACCELEROMETER, OSF_SENSOR_GYROSCOPE,
+		OSF_SENSOR_MAGNETOMETER, OSF_SENSOR_TEMPERATURE,
+	};
+	const s32 values[] = { 101, -202, 303 };
+	struct osf_capability_entry entry = {
+		.sample_format = OSF_SAMPLE_FORMAT_S32,
+		.scale_nano = 1000000,
+	};
+	struct osf_device *osf;
+	struct device *dev;
+
+	dev = kunit_device_register(test, "osf-iio");
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+	osf = kunit_kzalloc(test, sizeof(*osf), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, osf);
+	osf_core_init(osf, dev);
+
+	for (unsigned int t = 0; t < ARRAY_SIZE(types); t++) {
+		unsigned int channels = t == 3 ? 1 : 3;
+		struct iio_dev *indio_dev;
+		int ret;
+
+		entry.sensor_type = types[t];
+		entry.channel_count = channels;
+		ret = osf_iio_register_sensor(dev, &entry, osf, &indio_dev);
+		KUNIT_ASSERT_EQ(test, ret, 0);
+		ret = kunit_add_action_or_reset(test, osf_iio_test_unregister, indio_dev);
+		KUNIT_ASSERT_EQ(test, ret, 0);
+		for (unsigned int mask = 1; mask < BIT(channels); mask++)
+			for (unsigned int ts = 0; ts < 2; ts++)
+				osf_iio_check_scan(test, indio_dev, values, channels, mask, ts);
+		kunit_release_action(test, osf_iio_test_unregister, indio_dev);
+	}
+}
+
+struct osf_iio_race {
+	struct iio_buffer_access_funcs access;
+	const struct iio_buffer_access_funcs *original;
+	struct iio_dev *indio_dev;
+	struct kunit *test;
+	struct task_struct *producer;
+	struct task_struct *config;
+	struct completion entered;
+	struct completion release;
+	struct completion config_started;
+	struct completion config_done;
+	atomic_t block_store;
+	atomic_t stores;
+	atomic_t disabled;
+	atomic_t bad_store;
+	int enable_error;
+	int disable_error;
+	int config_result;
+	bool unregister;
+};
+
+static void osf_iio_stop_producer(void *data)
+{
+	struct osf_iio_race *race = data;
+
+	atomic_set(&race->block_store, 0);
+	complete_all(&race->release);
+	kthread_stop(race->producer);
+}
+
+static void osf_iio_stop_config(void *data)
+{
+	struct osf_iio_race *race = data;
+
+	/* Configuration may be waiting for an admitted store to finish. */
+	atomic_set(&race->block_store, 0);
+	complete_all(&race->release);
+	kthread_stop(race->config);
+}
+
+static void osf_iio_restore_access(void *data)
+{
+	struct osf_iio_race *race = data;
+
+	race->indio_dev->buffer->access = race->original;
+}
+
+static struct osf_iio_race *osf_iio_race_from_buffer(struct iio_buffer *buffer)
+{
+	return container_of(buffer->access, struct osf_iio_race, access);
+}
+
+static int osf_iio_test_store(struct iio_buffer *buffer, const void *data)
+{
+	struct osf_iio_race *race = osf_iio_race_from_buffer(buffer);
+
+	if (atomic_xchg(&race->block_store, 0)) {
+		complete(&race->entered);
+		if (!wait_for_completion_timeout(&race->release, 5 * HZ))
+			return -ETIMEDOUT;
+	}
+	if (atomic_read(&race->disabled))
+		atomic_inc(&race->bad_store);
+	atomic_inc(&race->stores);
+	return race->original->store_to(buffer, data);
+}
+
+static int osf_iio_test_enable(struct iio_buffer *buffer, struct iio_dev *indio_dev)
+{
+	struct osf_iio_race *race = osf_iio_race_from_buffer(buffer);
+
+	if (race->enable_error)
+		return race->enable_error;
+	atomic_set(&race->disabled, 0);
+	return 0;
+}
+
+static int osf_iio_test_disable(struct iio_buffer *buffer, struct iio_dev *indio_dev)
+{
+	struct osf_iio_race *race = osf_iio_race_from_buffer(buffer);
+
+	atomic_set(&race->disabled, 1);
+	return race->disable_error;
+}
+
+static int osf_iio_test_producer(void *data)
+{
+	struct osf_iio_race *race = data;
+	const s32 values[] = { 101, -202, 303 };
+
+	while (!kthread_should_stop()) {
+		osf_iio_push_sample(race->indio_dev, values, ARRAY_SIZE(values));
+		cond_resched();
+	}
+	return 0;
+}
+
+static int osf_iio_test_configure(void *data)
+{
+	struct osf_iio_race *race = data;
+
+	complete(&race->config_started);
+	if (race->unregister) {
+		/* Consume the registered cleanup action exactly once. */
+		kunit_release_action(race->test, osf_iio_test_unregister, race->indio_dev);
+		race->config_result = 0;
+	} else {
+		race->config_result = iio_update_buffers(race->indio_dev, NULL,
+							 race->indio_dev->buffer);
+	}
+	complete(&race->config_done);
+	while (!kthread_should_stop())
+		msleep(20);
+	return 0;
+}
+
+static void osf_iio_expect_quiesce(struct kunit *test, struct osf_iio_race *race)
+{
+	struct iio_dev *indio_dev = race->indio_dev;
+	const unsigned long *scan_mask = indio_dev->active_scan_mask;
+	unsigned long mask;
+	unsigned long waited;
+	int ret;
+
+	KUNIT_ASSERT_NOT_NULL(test, scan_mask);
+	mask = *scan_mask;
+	race->config = kthread_run(osf_iio_test_configure, race, "osf-cfg-test");
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, race->config);
+	ret = kunit_add_action_or_reset(test, osf_iio_stop_config, race);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	KUNIT_EXPECT_NE(test, wait_for_completion_timeout(&race->config_started, HZ), 0UL);
+	waited = wait_for_completion_timeout(&race->config_done, msecs_to_jiffies(20));
+	KUNIT_EXPECT_EQ(test, waited, 0UL);
+	/* The blocked OSF push owns the mode claim until its store returns. */
+	KUNIT_EXPECT_TRUE(test, iio_buffer_enabled(indio_dev));
+	KUNIT_EXPECT_PTR_EQ(test, indio_dev->active_scan_mask, scan_mask);
+	if (indio_dev->active_scan_mask)
+		KUNIT_EXPECT_EQ(test, *indio_dev->active_scan_mask, mask);
+	complete(&race->release);
+	kunit_release_action(test, osf_iio_stop_config, race);
+	KUNIT_EXPECT_TRUE(test, completion_done(&race->config_done));
+	KUNIT_EXPECT_EQ(test, race->config_result, 0);
+	KUNIT_EXPECT_FALSE(test, iio_buffer_enabled(indio_dev));
+	KUNIT_EXPECT_NULL(test, indio_dev->active_scan_mask);
+}
+
+/* Run real IIO configuration and kfifo code against an independent producer. */
+static void osf_iio_buffer_lifetime_test(struct kunit *test)
+{
+	struct osf_capability_entry entry = {
+		.sensor_type = OSF_SENSOR_ACCELEROMETER,
+		.channel_count = 3,
+		.sample_format = OSF_SAMPLE_FORMAT_S32,
+		.scale_nano = 1000000,
+	};
+	const s32 values[] = { 101, -202, 303 };
+	struct osf_iio_race *race;
+	struct osf_device *osf;
+	struct iio_dev *indio_dev;
+	struct iio_buffer *buffer;
+	struct device *dev;
+	int stores, ret;
+
+	dev = kunit_device_register(test, "osf-race");
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+	osf = kunit_kzalloc(test, sizeof(*osf), GFP_KERNEL);
+	race = kunit_kzalloc(test, sizeof(*race), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, osf);
+	KUNIT_ASSERT_NOT_NULL(test, race);
+	osf_core_init(osf, dev);
+	ret = osf_iio_register_sensor(dev, &entry, osf, &indio_dev);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	ret = kunit_add_action_or_reset(test, osf_iio_test_unregister, indio_dev);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	buffer = indio_dev->buffer;
+	race->indio_dev = indio_dev;
+	race->test = test;
+	race->original = buffer->access;
+	race->access = *buffer->access;
+	race->access.store_to = osf_iio_test_store;
+	race->access.enable = osf_iio_test_enable;
+	race->access.disable = osf_iio_test_disable;
+	init_completion(&race->entered);
+	init_completion(&race->release);
+	init_completion(&race->config_started);
+	init_completion(&race->config_done);
+	atomic_set(&race->disabled, 1);
+	/* Keep the device and its attached buffer alive across unregister. */
+	get_device(&indio_dev->dev);
+	ret = kunit_add_action_or_reset(test, osf_iio_test_put_device, &indio_dev->dev);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	buffer->access = &race->access;
+	ret = kunit_add_action_or_reset(test, osf_iio_restore_access, race);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	set_bit(0, (unsigned long *)buffer->scan_mask);
+	KUNIT_EXPECT_EQ(test, iio_update_buffers(indio_dev, buffer, NULL), 0);
+
+	atomic_set(&race->block_store, 1);
+	race->producer = kthread_run(osf_iio_test_producer, race, "osf-rx-test");
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, race->producer);
+	ret = kunit_add_action_or_reset(test, osf_iio_stop_producer, race);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	KUNIT_EXPECT_NE(test, wait_for_completion_timeout(&race->entered, HZ), 0UL);
+	osf_iio_expect_quiesce(test, race);
+
+	for (unsigned int i = 0; i < 100; i++) {
+		bitmap_zero((unsigned long *)buffer->scan_mask, iio_get_masklength(indio_dev));
+		*(unsigned long *)buffer->scan_mask = (i % 7) + 1;
+		buffer->scan_timestamp = i & 1;
+		KUNIT_EXPECT_EQ(test, iio_update_buffers(indio_dev, buffer, NULL), 0);
+		cond_resched();
+		KUNIT_EXPECT_EQ(test, iio_update_buffers(indio_dev, NULL, buffer), 0);
+	}
+
+	race->enable_error = -EIO;
+	KUNIT_EXPECT_EQ(test, iio_update_buffers(indio_dev, buffer, NULL), -EIO);
+	stores = atomic_read(&race->stores);
+	KUNIT_EXPECT_EQ(test, osf_iio_push_sample(indio_dev, values, 3), 0);
+	KUNIT_EXPECT_EQ(test, atomic_read(&race->stores), stores);
+	race->enable_error = 0;
+	KUNIT_EXPECT_EQ(test, iio_update_buffers(indio_dev, buffer, NULL), 0);
+	race->disable_error = -EIO;
+	KUNIT_EXPECT_EQ(test, iio_update_buffers(indio_dev, NULL, buffer), -EIO);
+	stores = atomic_read(&race->stores);
+	KUNIT_EXPECT_EQ(test, osf_iio_push_sample(indio_dev, values, 3), 0);
+	KUNIT_EXPECT_EQ(test, atomic_read(&race->stores), stores);
+	race->disable_error = 0;
+
+	KUNIT_EXPECT_EQ(test, iio_update_buffers(indio_dev, buffer, NULL), 0);
+	/* Rearm only after the first blocked store and configuration have ended. */
+	reinit_completion(&race->entered);
+	reinit_completion(&race->release);
+	reinit_completion(&race->config_started);
+	reinit_completion(&race->config_done);
+	/* Publish the completions to the producer's fully ordered atomic_xchg(). */
+	atomic_set_release(&race->block_store, 1);
+	KUNIT_EXPECT_NE(test, wait_for_completion_timeout(&race->entered, HZ), 0UL);
+	race->unregister = true;
+	osf_iio_expect_quiesce(test, race);
+	kunit_release_action(test, osf_iio_stop_producer, race);
+	KUNIT_EXPECT_EQ(test, atomic_read(&race->bad_store), 0);
+	KUNIT_EXPECT_GT(test, atomic_read(&race->stores), 0);
+	kunit_release_action(test, osf_iio_restore_access, race);
+	kunit_release_action(test, osf_iio_test_put_device, &indio_dev->dev);
+}
+
+static struct kunit_case osf_iio_test_cases[] = {
+	KUNIT_CASE(osf_iio_scan_bytes_test),
+	KUNIT_CASE(osf_iio_buffer_lifetime_test),
+	{ }
+};
+
+static struct kunit_suite osf_iio_test_suite = {
+	.name = "osf-iio",
+	.test_cases = osf_iio_test_cases,
+};
+
+kunit_test_suite(osf_iio_test_suite);
+
+MODULE_LICENSE("GPL");
