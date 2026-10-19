Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB9D331ED5
	for <linux-iio@vger.kernel.org>; Mon, 19 Oct 2026 01:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792373175; cv=none; b=OJ7+2g8PIv+jwxTRSixTXA7MQMUqg5ec2W/9OL3eYpoF/knOnxnS+kD2fg8AcKAq4PENXc8ze+t0YIeGKsIbkvKukVdbGPrcDL9Z3y6dl2sYpLpCpR/pzpW/wMM4wP2LvSgtLpKc+m7wJRxod1pBYDqZ38kdqGIdg67Lapykorg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792373175; c=relaxed/simple;
	bh=NY+5HrtsgYtbfd0FaM/TTBrGR78b8j+3T3SUMNPEH9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NavTPKMsU4KNWNFF4XnQcXiq37Df/e2VPhcKh05qncaQP19M/XMjuGvLWWYSgHOaXZBzAkE0/Eq213WMG18TIPvC9P7ugcImivA/aDVnO8oWQuIGRilOPa/Kc2AeR8a2kQvZZJ+7uIGyq9HnPO/MiPf8M/wnvM6/gOXPVb2t3cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CfEgv17a; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CfEgv17a"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8a06ca6e8f4so185823b3a.1
        for <linux-iio@vger.kernel.org>; Sun, 18 Oct 2026 18:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792373173; x=1792977973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SZHDX5ey4uf4SQU4jQA/UfKiXxlan8rYqcfys7t16LI=;
        b=CfEgv17asJt/TN/j6aP3FKjddvvV1JRy55osizqS9BoL/Eoikb6v31mTbc3BdfR++t
         iibhdXvA0i7IyI+9BOkte++8fMnbN7dDkKcfj0RzMA4o5+duMvQUk7Qav/QV6uYzkAuZ
         HQ7UQ7xIVVF85BVyZQ4fpOTu5cYsfXG0WW9AcHJhMUsss5oT0LjgKEpD012RHP98ejEi
         QlOC/DUPQlYIcAudaBnJyYX671sgnw7sH7fzHzWFgJ5C9J33u4NzIIheO3fOG8IA/3YL
         3KkibQZDv3BqPhtugxCmztfUwFPzc1hn8uF/WWxLe+imp0Be/zcNBnurJMQ/E9/z04tS
         uTFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792373173; x=1792977973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SZHDX5ey4uf4SQU4jQA/UfKiXxlan8rYqcfys7t16LI=;
        b=xHZzdn7H6dPA88ZhxcWry9cn1fWO0w1OVu56zjpWTeQZO+84o91zm3ojDuIISXxyur
         g0M4eV1N6U2Jku7IGUyyYDOrUkAr7SvJo12MWl/LI2WIEaIIq5ZxzPhI+LpbSP7AyS/B
         fQ4z9JLBPttEUySI9XyrRRKEy0pA0hs81DRRExfRQBIUCM5d68t8834atf4PnkzkGVE6
         cfhbN1BvbccqnJOtLyli1B1S6YB8TwpJf+eSHCM2WKIs02xA20E7CutQ4A73EPsFph6j
         aIJMpLMaRFgzyMya1J4ElsoZNA2XvjhsyZWQCwrimCC/Cizl9yeiPOHgDKVMbx6OgT6R
         ABJA==
X-Forwarded-Encrypted: i=1; AKwUvBxg3gg9XgnGzv2R/XZvVSCjpj8dgFP4/fa2uYXPnMEjfP9PVXJh6zC3ExPwbzwIl4rL4LF5lsl9vko=@vger.kernel.org
X-Gm-Message-State: AFq9FYKukNS1UxQrBx8+TXIuziurKxF9LsnQ2oAbJdcYxDZ87Jg7oUpv
	JF4/DTWVCX9JbXWbB1QSFooQeFO0tY4xN+jDzzYhlL921Ljaux8/WVJd
X-Gm-Gg: AYBFou2rP1IhQ+BVlE7EqjCj71bu2Q7BnMN39o44ipb3esQSarHjGtpet2L9Zrrt82Z
	qeDeTOiWWpJ0evQ8qNVSzn5le4DHlYkuWm3uqd+xJfo3Cm7DtDB3wpKiuoQ7W9vFAfZ0uTln61H
	00JPBl9yvmcF2lQSnC2vwVwa6PIkNSrkPvFyawWw7DMLTAKUsJTjY3MOvHYvuDQ/C3gI4lg9rdj
	kobg2MazfIidPbrHa8GKk96jhMDjN34mNa/niaoAIk1ky5yre782WRFtoDTKxdQ3d2GLpi0j6ht
	2dKVK8JItQIbWIWhFq+y7T7QzGKwwOFsh/w6WHC09nL/VwNAGQ3WjDBO3kzM+Y6Q0GHUjEAD/29
	hWYX8+J5zgpBbflDW3I0bcQLMo5amg70/5E4MKyFYTNdQeRItm3DbBhdEbkSigraMYIMHnn3kTw
	Tpa2esBfjXVq7+sAofaa4tYSaTpu/2oQQP9+ej3BPbaAVsLMCf0g03/eEbQAFLFzhveVEtssUer
	isTPEAFeoYJL2SEDdoSdPDI+AAFY8BlC04MemMSnKc51wFcW9/35BC6jlk1xuZ/R+zbm+5sY+Fa
	T8Kzi+k=
X-Received: by 2002:a05:6a00:22ca:b0:89e:259c:cd77 with SMTP id d2e1a72fcca58-8a04d338ef2mr4884143b3a.57.1792373172843;
        Sun, 18 Oct 2026 18:26:12 -0700 (PDT)
Received: from DESKTOP-G3E0OSP.localdomain ([58.224.60.243])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89fcd67cf30sm2731309b3a.17.2026.10.18.18.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 18:26:11 -0700 (PDT)
From: Jinseob Kim <kimjinseob88@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH v12 2/2] iio: osf: add IIO KUnit tests
Date: Mon, 19 Oct 2026 10:24:47 +0900
Message-ID: <7742750366c62d203ad5d2b7231971a7e43cfa72.1792372045.git.kimjinseob88@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1792372045.git.kimjinseob88@gmail.com>
References: <cover.1792372045.git.kimjinseob88@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Exercise active-scan packing, timestamp alignment and producer quiescence
during buffer reconfiguration and unregister. Retain device references and
deferred worker, sensor and mutex cleanup on assertion exits. Require the
producer and configuration handshakes before checking the claimed state.

The unregister race coverage requires the IIO core to serialize teardown
with mode claims, as fixed by mainline commit 84bb0fc46ccf ("iio: buffer:
serialize buffer teardown with mode claims"). That fix is absent from this
testing base and is a runtime prerequisite, not part of these test patches.

Assisted-by: LLM
Signed-off-by: Jinseob Kim <kimjinseob88@gmail.com>
---
 drivers/iio/sensorhubs/osf/Kconfig        |   2 +-
 drivers/iio/sensorhubs/osf/Makefile       |   2 +-
 drivers/iio/sensorhubs/osf/osf_iio_test.c | 395 ++++++++++++++++++++++
 3 files changed, 397 insertions(+), 2 deletions(-)
 create mode 100644 drivers/iio/sensorhubs/osf/osf_iio_test.c

diff --git a/drivers/iio/sensorhubs/osf/Kconfig b/drivers/iio/sensorhubs/osf/Kconfig
index 6828b79c345092e20743b211b8ca753d51b3b80a..b116e304e24c1549f80cd7a62c14047bfd22f08a 100644
--- a/drivers/iio/sensorhubs/osf/Kconfig
+++ b/drivers/iio/sensorhubs/osf/Kconfig
@@ -21,7 +21,7 @@ config OPEN_SENSOR_FUSION_KUNIT_TEST
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
index 0000000000000000000000000000000000000000..ba2e0117a4709afcb00d13989253ceffd400d57e
--- /dev/null
+++ b/drivers/iio/sensorhubs/osf/osf_iio_test.c
@@ -0,0 +1,395 @@
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
+KUNIT_DEFINE_ACTION_WRAPPER(osf_iio_test_destroy_mutex, mutex_destroy,
+			    struct mutex *);
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
+	int ret;
+
+	dev = kunit_device_register(test, "osf-iio");
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+	osf = kunit_kzalloc(test, sizeof(*osf), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, osf);
+	osf_core_init(osf, dev);
+	ret = kunit_add_action_or_reset(test, osf_iio_test_destroy_mutex,
+					&osf->latest_lock);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	for (unsigned int t = 0; t < ARRAY_SIZE(types); t++) {
+		unsigned int channels = t == 3 ? 1 : 3;
+		struct iio_dev *indio_dev;
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
+	KUNIT_ASSERT_NE(test, wait_for_completion_timeout(&race->config_started, HZ), 0UL);
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
+	ret = kunit_add_action_or_reset(test, osf_iio_test_destroy_mutex,
+					&osf->latest_lock);
+	KUNIT_ASSERT_EQ(test, ret, 0);
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
+	KUNIT_ASSERT_NE(test, wait_for_completion_timeout(&race->entered, HZ), 0UL);
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
+	KUNIT_ASSERT_NE(test, wait_for_completion_timeout(&race->entered, HZ), 0UL);
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
