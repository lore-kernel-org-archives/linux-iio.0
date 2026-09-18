Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0DE528441
	for <linux-iio@vger.kernel.org>; Fri, 18 Sep 2026 18:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789755965; cv=none; b=NRENLYLHIcL5zPxtxazbBU7ERXMBajdjdt+Y2XG1tBbO/XdeSd9ZHmUe0FA7EAxqp3L26Bwj5J/Gg9739oBxeK5acmW/C1DQYodeCBmf62dbpiAHWwg6bEPlVnQOjG3JZvyLmRg7CtpH700ROdbUjWpoP/HWHOro2ew097knMEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789755965; c=relaxed/simple;
	bh=uP2zYyrVNhxR0F5wRNx8VTP3WfC+4MKI0Hisfj+rKY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fE1mFCIjIgcPx7TZjTV5NQkWe0V2d7nltU6tk67fqhAAyrZeGEi7f4p265BRba4yc5LS6sfWAwLCIpwTA1PO6uSthBPSiatiA+I5Ks9rijbM2d5jPb6X3LH3mYZRi7dqHqxx+uBVUz5wHV7JsKPexr2RvrvvVx44NE8kI1uxPxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rfw6TOSM; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rfw6TOSM"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d747f066d8so3875235ad.1
        for <linux-iio@vger.kernel.org>; Fri, 18 Sep 2026 11:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789755962; x=1790360762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ezND/MR9Dspsyc6ymR2jshkitQWvrthe2sHCr5Ma1SU=;
        b=rfw6TOSMZuuXMW2e7aVbmmH85ZFE5l77LhTMd7wt9kxS9aZyId9DjLgDnBhID45giq
         u6qgWmuGm38PEfTdGqrbEzYn5V4R3BiNUe7UvjfoaJN2wEO6lwEBYacMvLFcnIE8y7hl
         AiPZbe9U/gJVvjCcxW7a5Jghz+A/5AKzsfy2hyg4IjhPjRRXIIEawODmlQw8kpEsJk1K
         h1KYwkJdynHYOxq72IKNnD6x8VnfJCdunAQRv62yk/4glpPpQrXFyLBHFpoRLFzSMLJq
         wLYricIJe2tHIrRJz4Z2UzxizRVpsj5NNlGztPxODOiSyhB5Qcs3TpBGqAtAKEcDdBin
         O3Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789755962; x=1790360762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ezND/MR9Dspsyc6ymR2jshkitQWvrthe2sHCr5Ma1SU=;
        b=hiHvl0OK50JJbbncpKjhOoMnHRgd++06ZxFWkVTKwNxG1MPq4f40SJzUaSgfkU7GnH
         /n43RCYTzYq6Q+EJFWmCprc/PN4VkoWK07my3Bx1PcXxbw2+jNjn0mStvBhxP1FPIQlM
         L7vb1PY5AIckPVPwEO9w0UheI99YSyqIOdwXS6SlDVLxFHS3vPQUrrNt1wKN7fE7e27Y
         drPqMp1Uzm1353ofcX/DGhH0jAgrNiARvHa96NO9BSOrCUjB92IvJfRocEt9LWVHnTDC
         8Uhd2oinvPoMERaQ8FdvDxHNnoOCWWXrw21qAWocsLEfZbFn33n87iF2bjLYVOr7v9Hv
         k3qg==
X-Forwarded-Encrypted: i=1; AKwUvBw/lrE6viH7qK6/UdJYaIkB2/GHJ5b5zLcTKiYx0ujDPblaeyu0wEFXaHyZZauWeyw9LZhQYbCiR0Y=@vger.kernel.org
X-Gm-Message-State: AFuF++kRwhluIm9Oy4zm1U7Z5l+ym2Kkx5v/8sTJ/p1eVSsNS3o26YIe
	LNC3LcIRCaJFbBShS0PK5OqlK2lRNagLSv3tF/rZ83KqhNXM8s7v+del
X-Gm-Gg: AYBFou2KEa8JSPaAzpMXAKf+Sw1+mVio9Ccr0eQ/bn6cpSkkM4tDys7AHQ2VHHSc+kl
	WCppIoQeogwAbLPR3dDXWnxz4+LYvvRoJm9J4DUDO09AtCcC34dbalK1YqEHAJtkv3NVK2ZjqgF
	1JtXpVuRjdDTyRyxfnrMwrpogzAZO035hgrVdR9VyiYvpukgypW48TBgA+4amWIdCIkfKDzi7cP
	D1CScNwMGjYkvWsJDox0Z2sH98livrCRJEruu4HaEYQQHV7nNkUlWdZ7PS0cZH3yEsIN3GLvQaC
	ZiiaYxry1ee+qS6oIR1ORjI33vHooquZwEEpGUowQq+D9Tw8hXQsvzEYG82tN8wXPvbb7poO6we
	pblNFLBhf2WcY1Huzd6FQQIPbfQvCx9WsIt1KMQREWZgjFAaKD4gjaXig6r78Y9Mp/81e6A0zTq
	meZKPmQF57xhJg0Y/lbM0mYurCUWUbnVMekO98Gu/3+kAxzsgk4tSUGCamzacq5KSRGcjPNvyaK
	UwEKS5Jc+BZZkDTtASayXIUQnDzfKqnMmHCnpJHWyw827qJjeFXw9fEjKizRN34AxSX4ASKv1oc
	ZnpKfCgx+0pob9RapYI=
X-Received: by 2002:a17:902:d487:b0:2dd:c053:b9c9 with SMTP id d9443c01a7336-2ddc053bab9mr8915495ad.26.1789755961647;
        Fri, 18 Sep 2026 11:26:01 -0700 (PDT)
Received: from DESKTOP-G3E0OSP.localdomain ([58.224.60.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddc16b49casm871895ad.7.2026.09.18.11.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 11:26:00 -0700 (PDT)
From: Jinseob Kim <kimjinseob88@gmail.com>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andriy.shevchenko@intel.com,
	linux-kernel@vger.kernel.org,
	rdunlap@infradead.org,
	joshua.crofts1@gmail.com,
	u.kleine-koenig@baylibre.com,
	julianbraha@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v10 8/8] iio: osf: add IIO KUnit tests
Date: Sat, 19 Sep 2026 03:24:46 +0900
Message-ID: <59251baa5b1f53a72ac7a09afc334398e2e84db7.1789753020.git.kimjinseob88@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1789753020.git.kimjinseob88@gmail.com>
References: <cover.1789753020.git.kimjinseob88@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the existing IIO active-scan packing and buffer producer lifetime
tests. Extend the test build wiring and help text to cover both suites.

This changes no production source. The complete series retains the
production behavior of the combined-driver revision, with CRC
terminology clarified.

Assisted-by: LLM
Signed-off-by: Jinseob Kim <kimjinseob88@gmail.com>
---
 drivers/iio/opensensorfusion/Kconfig        |   2 +-
 drivers/iio/opensensorfusion/Makefile       |   2 +-
 drivers/iio/opensensorfusion/osf_iio_test.c | 325 ++++++++++++++++++++
 3 files changed, 327 insertions(+), 2 deletions(-)
 create mode 100644 drivers/iio/opensensorfusion/osf_iio_test.c

diff --git a/drivers/iio/opensensorfusion/Kconfig b/drivers/iio/opensensorfusion/Kconfig
index 316f33be1327..b4a2cde9645e 100644
--- a/drivers/iio/opensensorfusion/Kconfig
+++ b/drivers/iio/opensensorfusion/Kconfig
@@ -20,7 +20,7 @@ config OPEN_SENSOR_FUSION_KUNIT_TEST
 	default KUNIT_ALL_TESTS
 	help
 	  Build focused unit tests for the Open Sensor Fusion core sample
-	  acceptance, direct-read cache, and capability/session handling. The tests
+	  acceptance, direct-read cache, and IIO buffer paths. The tests
 	  exercise accepted, ignored, and rejected sample handling without
 	  exposing additional production interfaces.
 
diff --git a/drivers/iio/opensensorfusion/Makefile b/drivers/iio/opensensorfusion/Makefile
index c2f5ba065a62..6a28b14cae1f 100644
--- a/drivers/iio/opensensorfusion/Makefile
+++ b/drivers/iio/opensensorfusion/Makefile
@@ -4,4 +4,4 @@ obj-$(CONFIG_OPEN_SENSOR_FUSION) += open-sensor-fusion.o
 
 open-sensor-fusion-y := osf_core.o osf_iio.o osf_protocol.o osf_serdev.o \
 			 osf_stream.o
-open-sensor-fusion-$(CONFIG_OPEN_SENSOR_FUSION_KUNIT_TEST) += osf_core_test.o
+open-sensor-fusion-$(CONFIG_OPEN_SENSOR_FUSION_KUNIT_TEST) += osf_core_test.o osf_iio_test.o
diff --git a/drivers/iio/opensensorfusion/osf_iio_test.c b/drivers/iio/opensensorfusion/osf_iio_test.c
new file mode 100644
index 000000000000..63d3ca1af329
--- /dev/null
+++ b/drivers/iio/opensensorfusion/osf_iio_test.c
@@ -0,0 +1,325 @@
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
+		for (unsigned int mask = 1; mask < BIT(channels); mask++)
+			for (unsigned int ts = 0; ts < 2; ts++)
+				osf_iio_check_scan(test, indio_dev, values, channels, mask, ts);
+		osf_iio_unregister_sensor(indio_dev);
+	}
+}
+
+struct osf_iio_race {
+	struct iio_buffer_access_funcs access;
+	const struct iio_buffer_access_funcs *original;
+	struct iio_dev *indio_dev;
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
+		osf_iio_unregister_sensor(race->indio_dev);
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
+	struct task_struct *config;
+	unsigned long waited;
+
+	config = kthread_run(osf_iio_test_configure, race, "osf-cfg-test");
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, config);
+	KUNIT_EXPECT_NE(test, wait_for_completion_timeout(&race->config_started, HZ), 0UL);
+	waited = wait_for_completion_timeout(&race->config_done, msecs_to_jiffies(20));
+	KUNIT_EXPECT_EQ(test, waited, 0UL);
+	complete(&race->release);
+	KUNIT_EXPECT_NE(test, wait_for_completion_timeout(&race->config_done, HZ), 0UL);
+	kthread_stop(config);
+	KUNIT_EXPECT_EQ(test, race->config_result, 0);
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
+	struct task_struct *producer;
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
+	buffer = indio_dev->buffer;
+	race->indio_dev = indio_dev;
+	race->original = buffer->access;
+	race->access = *buffer->access;
+	race->access.store_to = osf_iio_test_store;
+	race->access.enable = osf_iio_test_enable;
+	race->access.disable = osf_iio_test_disable;
+	buffer->access = &race->access;
+	init_completion(&race->entered);
+	init_completion(&race->release);
+	init_completion(&race->config_started);
+	init_completion(&race->config_done);
+	atomic_set(&race->disabled, 1);
+	set_bit(0, (unsigned long *)buffer->scan_mask);
+	KUNIT_EXPECT_EQ(test, iio_update_buffers(indio_dev, buffer, NULL), 0);
+
+	atomic_set(&race->block_store, 1);
+	producer = kthread_run(osf_iio_test_producer, race, "osf-rx-test");
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, producer);
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
+	/* Retain ownership while testing unregister against an admitted push. */
+	get_device(&indio_dev->dev);
+	reinit_completion(&race->entered);
+	reinit_completion(&race->release);
+	reinit_completion(&race->config_started);
+	reinit_completion(&race->config_done);
+	atomic_set(&race->block_store, 1);
+	KUNIT_EXPECT_NE(test, wait_for_completion_timeout(&race->entered, HZ), 0UL);
+	race->unregister = true;
+	osf_iio_expect_quiesce(test, race);
+	kthread_stop(producer);
+	KUNIT_EXPECT_EQ(test, atomic_read(&race->bad_store), 0);
+	KUNIT_EXPECT_GT(test, atomic_read(&race->stores), 0);
+	buffer->access = race->original;
+	put_device(&indio_dev->dev);
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
-- 
2.43.0

