Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE972E92BA
	for <linux-iio@vger.kernel.org>; Mon, 19 Oct 2026 01:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792373172; cv=none; b=chxpH8DWK2Yuk5dLw9k44VxvWBadseCk1sXDu/tDSfnBpy0zIgKGCsAssKJQeWgByDpN/+ObvVH2n9OtDx4nWBqQvt6bWy0fJYZnLSoQdWe8rsa6JEUuz6+rCLZxyV/iu7FmWlrpik5n+dOgB/+2NHhXIBFzXBd2mHaq3YtmGFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792373172; c=relaxed/simple;
	bh=KniiHs2RQEa0esljzWVlNVcKpO3cnTm3EW2+17ESwkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WfrccBgFDbu0kUW0l5exWB00cYlo9INqnjRqY2auh0KeKPyl4m7IHG/FH2JJIx4vHafEzdBs4s1ldtqPBaCYeyNbOSCK/x0D36MKUCcVAI2pZ0IYhqzP1GQIygJQX6QNJh6o1ykjy9HzRP4Bv14J97vklHf6URCZAS3Qwc70/HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RdtYLt7J; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RdtYLt7J"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8a070781f63so30924b3a.1
        for <linux-iio@vger.kernel.org>; Sun, 18 Oct 2026 18:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792373169; x=1792977969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QygvKRfQF3eG/hwCy8WgjSG3+djPF0+E8RFIcTmqfPw=;
        b=RdtYLt7Jn6jmxXbtllz5w/ZAM8jwneE9GfZ0eNfI1wRHW0qWndpL9K7XiST2Q2UnXM
         h6uKWSPSGKhKtgoQcsd2e5o7Zp1mDa57TTiPH0KipJa5OtOanZMk7Ok4mYoxz5uj979F
         0zMLQcYoVVd9yjTrt37gW/ceuABGMuIaNs1JhJkFuWBB2wikKHbRjDQvWDg4pgDUPN2Y
         DAqRo0nQp0m+WTOW6JcDR14PSqOInUpLYhMRaYJj9ZA3vHzBEPeM6BjAFu8TzkK1eodB
         RqEUVASX80wGlIpNycKuNZwwSYb/6rREgimGekm7H2F2tRs4f+iE5lNZruDX9eq1kZte
         RrTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792373169; x=1792977969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QygvKRfQF3eG/hwCy8WgjSG3+djPF0+E8RFIcTmqfPw=;
        b=NJP80W+TNkj00mM2n5NYZRtnqGZ+a247ImDUwjOjUY/XHxe/v44aqsEre20HKmkP1X
         99NBMtyI3PUuOCabDAJzH/GiL9MRCnA3ob5uXvIfRvosSNDIhEWs4g52+Qy1WftKpwPD
         gFhXNiGoI2lE2LxY4JfxkueEJv107XZh+jOqCTNyts/jbCvCIArmrzR3bfwwpnBI5P9D
         j03H+Qho9G9CbWBNE/ioFkheo4cAsYblDs7wYcjP2ZgNRw0Ka6flY6+nHh2VUlzbbhXt
         UhqFFoVCNrhDLXL7yMkF720a35q7ZS6tvyAmx9Xa/M0MTrpamuiVaNe06lU4l7j3MGg0
         hhCQ==
X-Forwarded-Encrypted: i=1; AKwUvBz6GusKiLNFHG1zrxkncXeg3YpWTsx4udXFgdBOT+Uw/6OanD3Byb3rq3Bp1lsvNldTHXr5CEuihfs=@vger.kernel.org
X-Gm-Message-State: AFq9FYK6IhhPNOZMLzbicAhRZY+r2/rF+Ns2Wzzy5g4tYKu0AJ/i5i08
	FhVnM1t10L5NA4VfBGFHV2AQOUQkHe5qVF3ntoFbaTmrxLHReOSA/9+x
X-Gm-Gg: AYBFou1KeNXeqp2fmtAPIVSg59NEkGWEkCXqoMdsj96/reFlBUeYO6X42vUJHmzfx2z
	ji54FTrcKvw+w0JzSvKfvBAdXbkjOO0PXUkdQlnwm/oAiYoc2zfu3jQekJ94BwuIYjeRGD1LAO7
	+Gd6xXR4EoVQO1gjAPgITFwYyPk/K+cFYFEkmGZynD2ZMhF7tRyBB7XcKAgncarFKhNUIQq16Oy
	DT+dGY78eUohfYDtE1zYf2OWqi26PBKPOGHkp2XFE6iL2ydAV/kBhhKPcmvFdm4hBs92wcTgZsb
	kJ4udgnjHkXLsEhoeJ1BdwRro9sVGspJQC1rlhhBBzNnsCenUcIoZE8CxNJV1ntDRgvwQQyFTGg
	uz+l8S83v64UBayfWJ8cHjzWhnwj4Me51603C52DC9+lKVQEWkieZb03pID64BX5jY1YOctEnmj
	Ub0prOAOTKNZtsJf3qRycNU/sTxlq9lMLS0VoTJlgcjSiHlBiYA+LE1ig0zFg8fIaj8wFNJx+E8
	wkih7HvpyxJyg4rBSSEUlGpFAkNCzLNVlRu5Ik8AncpBD/AxAJLXMLSRV/7KsFNNo0t++hTkdnT
	Hj5VlLQ=
X-Received: by 2002:a05:6a00:23c3:b0:87a:3144:8c4c with SMTP id d2e1a72fcca58-8a04cd26409mr4644986b3a.59.1792373168484;
        Sun, 18 Oct 2026 18:26:08 -0700 (PDT)
Received: from DESKTOP-G3E0OSP.localdomain ([58.224.60.243])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89fcd67cf30sm2731309b3a.17.2026.10.18.18.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 18:26:07 -0700 (PDT)
From: Jinseob Kim <kimjinseob88@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH v12 1/2] iio: osf: add core KUnit tests
Date: Mon, 19 Oct 2026 10:24:46 +0900
Message-ID: <67ff667ccf23198928716ef658bfbf48ec0fd1ee.1792372045.git.kimjinseob88@gmail.com>
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

Exercise capability discovery, complete repeated inventories, sample-cache
admission, exact lengths, reserved wire bytes and session faults. Protect
producer lifetime with deferred cleanup and close the session mutex
lifecycle before reinitialization.

Include the tests in the existing composite driver so they also run when
OSF is a module, without exporting driver internals. Keep the test selector
boolean because it controls membership in that composite object, and
exclude a built-in driver with a modular KUnit framework.

Destroy pending-session and producer-serialization mutexes through KUnit
cleanup actions after their users have finished, including assertion exits.

Assisted-by: LLM
Signed-off-by: Jinseob Kim <kimjinseob88@gmail.com>
---
 drivers/iio/sensorhubs/osf/Kconfig         |   16 +
 drivers/iio/sensorhubs/osf/Makefile        |    1 +
 drivers/iio/sensorhubs/osf/osf_core_test.c | 1064 ++++++++++++++++++++
 3 files changed, 1081 insertions(+)
 create mode 100644 drivers/iio/sensorhubs/osf/osf_core_test.c

diff --git a/drivers/iio/sensorhubs/osf/Kconfig b/drivers/iio/sensorhubs/osf/Kconfig
index f955a1f2993d244369943efbd853b9d2c6d47139..6828b79c345092e20743b211b8ca753d51b3b80a 100644
--- a/drivers/iio/sensorhubs/osf/Kconfig
+++ b/drivers/iio/sensorhubs/osf/Kconfig
@@ -13,3 +13,19 @@ config OPEN_SENSOR_FUSION
 	  registers IIO devices for supported capability entries. It exposes
 	  accelerometer, gyroscope, magnetometer, and temperature samples
 	  through IIO direct reads and software buffers.
+
+config OPEN_SENSOR_FUSION_KUNIT_TEST
+	bool "KUnit tests for Open Sensor Fusion" if !KUNIT_ALL_TESTS
+	depends on OPEN_SENSOR_FUSION && KUNIT
+	depends on KUNIT=y || OPEN_SENSOR_FUSION=m
+	default KUNIT_ALL_TESTS
+	help
+	  Build focused unit tests for the Open Sensor Fusion core sample
+	  acceptance, direct-read cache, and capability/session handling. The tests
+	  exercise accepted, ignored, and rejected sample handling without
+	  exposing additional production interfaces.
+
+	  The tests are included in the driver, either built-in or in the same
+	  module. A built-in driver requires KUnit to be built-in as well.
+
+	  If unsure, say N.
diff --git a/drivers/iio/sensorhubs/osf/Makefile b/drivers/iio/sensorhubs/osf/Makefile
index b4e03b80cfa4cca6a67e6cd8228a4776a38dcb72..c2f5ba065a62fef2a4897034239b405ccdd69250 100644
--- a/drivers/iio/sensorhubs/osf/Makefile
+++ b/drivers/iio/sensorhubs/osf/Makefile
@@ -4,3 +4,4 @@ obj-$(CONFIG_OPEN_SENSOR_FUSION) += open-sensor-fusion.o
 
 open-sensor-fusion-y := osf_core.o osf_iio.o osf_protocol.o osf_serdev.o \
 			 osf_stream.o
+open-sensor-fusion-$(CONFIG_OPEN_SENSOR_FUSION_KUNIT_TEST) += osf_core_test.o
diff --git a/drivers/iio/sensorhubs/osf/osf_core_test.c b/drivers/iio/sensorhubs/osf/osf_core_test.c
new file mode 100644
index 0000000000000000000000000000000000000000..d50d020a96492885a0b54c33793ce56858759751
--- /dev/null
+++ b/drivers/iio/sensorhubs/osf/osf_core_test.c
@@ -0,0 +1,1064 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <kunit/device.h>
+#include <kunit/test.h>
+
+#include <linux/bitmap.h>
+#include <linux/crc32.h>
+#include <linux/completion.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/buffer_impl.h>
+#include <linux/iio/iio.h>
+#include <linux/module.h>
+#include <linux/kthread.h>
+#include <linux/string.h>
+#include <linux/types.h>
+#include <linux/unaligned.h>
+
+#include "osf_core.h"
+#include "osf_protocol.h"
+#include "osf_stream.h"
+
+#define OSF_TEST_SENSOR_INDEX		0
+#define OSF_TEST_UNSUPPORTED_INDEX	7
+#define OSF_TEST_SCALE_NANO		1000000
+#define OSF_TEST_FLOOD_COUNT		(OSF_MAX_CAPABILITIES + 4)
+#define OSF_TEST_MAX_PAYLOAD_LEN						\
+	(OSF_SENSOR_SAMPLE_BASE_LEN + OSF_MAX_SAMPLE_CHANNELS * sizeof(__le32))
+#define OSF_TEST_MAX_FRAME_LEN						\
+	(OSF_FRAME_HEADER_LEN + OSF_CAP_REPORT_BASE_LEN +			\
+	 3 * OSF_CAP_SENSOR_ENTRY_LEN + OSF_FRAME_CRC_LEN)
+
+struct osf_test_context {
+	struct osf_device osf;
+	struct device *dev;
+	struct iio_dev *indio_dev;
+	struct iio_buffer *buffer;
+	bool buffer_enabled;
+};
+
+struct osf_test_scan_3axis {
+	s32 values[3];
+};
+
+static size_t osf_test_build_frame(u8 *buf, size_t buf_size,
+				   u16 message_type, const u8 *payload,
+				   u32 payload_len, u64 sequence)
+{
+	size_t frame_len = OSF_FRAME_HEADER_LEN + payload_len +
+			   OSF_FRAME_CRC_LEN;
+	u32 crc;
+
+	if (frame_len > buf_size)
+		return 0;
+
+	memset(buf, 0, frame_len);
+	put_unaligned_le32(OSF_FRAME_MAGIC, buf);
+	buf[4] = OSF_PROTOCOL_MAJOR;
+	buf[5] = OSF_PROTOCOL_MINOR;
+	put_unaligned_le16(OSF_FRAME_HEADER_LEN, buf + 6);
+	put_unaligned_le16(message_type, buf + 8);
+	put_unaligned_le32(payload_len, buf + 10);
+	put_unaligned_le64(sequence, buf + 14);
+	put_unaligned_le64(sequence * 1000, buf + 22);
+	memcpy(buf + OSF_FRAME_HEADER_LEN, payload, payload_len);
+
+	crc = crc32_le(~0U, buf, OSF_FRAME_HEADER_LEN + payload_len) ^ ~0U;
+	put_unaligned_le32(crc, buf + OSF_FRAME_HEADER_LEN + payload_len);
+
+	return frame_len;
+}
+
+static size_t osf_test_build_capability_frame(u8 *buf, size_t buf_size,
+					      u64 sequence)
+{
+	u8 payload[OSF_CAP_REPORT_BASE_LEN +
+		   2 * OSF_CAP_SENSOR_ENTRY_LEN] = { };
+	u8 *supported = payload + OSF_CAP_REPORT_BASE_LEN;
+	u8 *unsupported = supported + OSF_CAP_SENSOR_ENTRY_LEN;
+
+	put_unaligned_le16(2, payload);
+	put_unaligned_le16(OSF_SENSOR_ACCELEROMETER, supported);
+	put_unaligned_le16(OSF_TEST_SENSOR_INDEX, supported + 2);
+	put_unaligned_le16(3, supported + 4);
+	put_unaligned_le16(OSF_SAMPLE_FORMAT_S32, supported + 6);
+	put_unaligned_le32(OSF_TEST_SCALE_NANO, supported + 8);
+
+	put_unaligned_le16(OSF_SENSOR_BAROMETER, unsupported);
+	put_unaligned_le16(OSF_TEST_UNSUPPORTED_INDEX, unsupported + 2);
+	put_unaligned_le16(1, unsupported + 4);
+	put_unaligned_le16(OSF_SAMPLE_FORMAT_S32, unsupported + 6);
+	put_unaligned_le32(OSF_TEST_SCALE_NANO, unsupported + 8);
+
+	return osf_test_build_frame(buf, buf_size, OSF_MSG_CAPABILITY_REPORT,
+				    payload, sizeof(payload), sequence);
+}
+
+static size_t osf_test_build_sample_frame(u8 *buf, size_t buf_size,
+					  u16 sensor_type, u16 sensor_index,
+					  u16 channel_count, u16 sample_format,
+					  const s32 *values, u64 sequence)
+{
+	u8 payload[OSF_TEST_MAX_PAYLOAD_LEN] = { };
+	u32 payload_len;
+
+	if (!channel_count || channel_count > OSF_MAX_SAMPLE_CHANNELS)
+		return 0;
+
+	put_unaligned_le16(sensor_type, payload);
+	put_unaligned_le16(sensor_index, payload + 2);
+	put_unaligned_le16(channel_count, payload + 4);
+	put_unaligned_le16(sample_format, payload + 6);
+	put_unaligned_le32(OSF_TEST_SCALE_NANO, payload + 8);
+
+	for (u16 i = 0; i < channel_count; i++)
+		put_unaligned_le32(values[i],
+				   payload + OSF_SENSOR_SAMPLE_BASE_LEN +
+				   i * sizeof(__le32));
+
+	payload_len = OSF_SENSOR_SAMPLE_BASE_LEN +
+		      channel_count * sizeof(__le32);
+
+	return osf_test_build_frame(buf, buf_size, OSF_MSG_SENSOR_SAMPLE,
+				    payload, payload_len, sequence);
+}
+
+static size_t osf_test_build_truncated_sample_frame(u8 *buf, size_t buf_size,
+						    u64 sequence)
+{
+	u8 payload[OSF_SENSOR_SAMPLE_BASE_LEN + sizeof(__le32)] = { };
+
+	put_unaligned_le16(OSF_SENSOR_ACCELEROMETER, payload);
+	put_unaligned_le16(OSF_TEST_SENSOR_INDEX, payload + 2);
+	put_unaligned_le16(3, payload + 4);
+	put_unaligned_le16(OSF_SAMPLE_FORMAT_S32, payload + 6);
+	put_unaligned_le32(OSF_TEST_SCALE_NANO, payload + 8);
+	put_unaligned_le32(42, payload + OSF_SENSOR_SAMPLE_BASE_LEN);
+
+	return osf_test_build_frame(buf, buf_size, OSF_MSG_SENSOR_SAMPLE,
+				    payload, sizeof(payload), sequence);
+}
+
+/* Keep frame-construction scratch out of the caller's KASAN stack frame. */
+static noinline int osf_test_submit_sample(struct osf_test_context *ctx,
+					   u16 sensor_type, u16 sensor_index,
+					   u16 channel_count, u16 sample_format,
+					   const s32 *values, u64 sequence)
+{
+	u8 frame[OSF_TEST_MAX_FRAME_LEN];
+	size_t frame_len;
+
+	frame_len = osf_test_build_sample_frame(frame, sizeof(frame),
+						sensor_type, sensor_index,
+						channel_count, sample_format,
+						values, sequence);
+	if (!frame_len)
+		return -EINVAL;
+
+	return osf_core_receive_frame(&ctx->osf, frame, frame_len);
+}
+
+static int osf_test_read_raw(struct osf_test_context *ctx,
+			     unsigned int channel, int *value)
+{
+	int value2 = 0;
+
+	return ctx->indio_dev->info->read_raw(ctx->indio_dev,
+					      &ctx->indio_dev->channels[channel],
+					      value, &value2,
+					      IIO_CHAN_INFO_RAW);
+}
+
+static int osf_test_remove_scan(struct osf_test_context *ctx,
+				struct osf_test_scan_3axis *scan)
+{
+	return iio_pop_from_buffer(ctx->buffer, scan);
+}
+
+static int osf_test_enable_buffer(struct osf_test_context *ctx)
+{
+	unsigned long *scan_mask;
+	int ret;
+
+	scan_mask = (unsigned long *)ctx->buffer->scan_mask;
+	for (unsigned int i = 0; i < 3; i++)
+		bitmap_set(scan_mask, ctx->indio_dev->channels[i].scan_index, 1);
+	ret = iio_update_buffers(ctx->indio_dev, ctx->buffer, NULL);
+	if (!ret)
+		ctx->buffer_enabled = true;
+
+	return ret;
+}
+
+static void osf_test_cleanup(void *data)
+{
+	struct osf_test_context *ctx = data;
+
+	if (ctx->buffer_enabled) {
+		iio_update_buffers(ctx->indio_dev, NULL, ctx->buffer);
+		ctx->buffer_enabled = false;
+	}
+
+	osf_core_unregister_iio(&ctx->osf);
+	mutex_destroy(&ctx->osf.latest_lock);
+}
+
+static int osf_test_init(struct kunit *test)
+{
+	struct osf_test_context *ctx;
+	u8 frame[OSF_TEST_MAX_FRAME_LEN];
+	size_t frame_len;
+	int ret;
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	test->priv = ctx;
+	ctx->dev = kunit_device_register(test, "osf-core");
+	if (IS_ERR(ctx->dev))
+		return PTR_ERR(ctx->dev);
+	if (!ctx->dev)
+		return -ENOMEM;
+
+	osf_core_init(&ctx->osf, ctx->dev);
+	osf_core_start(&ctx->osf);
+	ret = kunit_add_action_or_reset(test, osf_test_cleanup, ctx);
+	if (ret)
+		return ret;
+
+	frame_len = osf_test_build_capability_frame(frame, sizeof(frame), 1);
+	if (!frame_len)
+		return -EINVAL;
+
+	ret = osf_core_receive_frame(&ctx->osf, frame, frame_len);
+	if (ret != OSF_STREAM_FRAME_HANDLED)
+		return ret < 0 ? ret : -EINVAL;
+	if (ctx->osf.iio_dev_count != 1 ||
+	    ctx->osf.capability_cache.capability_count != 1)
+		return -EINVAL;
+
+	ctx->indio_dev = ctx->osf.iio_devs[0].indio_dev;
+	ctx->buffer = ctx->indio_dev->buffer;
+	if (!ctx->buffer)
+		return -EINVAL;
+
+	return 0;
+}
+
+static void osf_test_expect_direct_sample(struct kunit *test,
+					  struct osf_test_context *ctx,
+					  const s32 *expected)
+{
+	int value;
+	int ret;
+
+	for (unsigned int i = 0; i < 3; i++) {
+		value = 0;
+		ret = osf_test_read_raw(ctx, i, &value);
+		KUNIT_EXPECT_EQ(test, ret, IIO_VAL_INT);
+		KUNIT_EXPECT_EQ(test, value, expected[i]);
+	}
+}
+
+static void
+osf_rejected_channel_count_preserves_latest_test(struct kunit *test)
+{
+	struct osf_test_context *ctx = test->priv;
+	const s32 baseline_values[] = { 11, 22, 33 };
+	const s32 rejected_values[] = { -999 };
+	struct osf_sensor_sample decoded_sample;
+	struct osf_latest_sample baseline;
+	struct osf_test_scan_3axis scan;
+	struct osf_frame decoded_frame;
+	u8 rejected_frame[OSF_TEST_MAX_FRAME_LEN];
+	size_t decoded_len;
+	size_t frame_len;
+	u64 baseline_sequence;
+	int ret;
+
+	KUNIT_ASSERT_EQ(test, osf_test_enable_buffer(ctx), 0);
+	KUNIT_ASSERT_TRUE(test, iio_buffer_enabled(ctx->indio_dev));
+
+	ret = osf_test_submit_sample(ctx, OSF_SENSOR_ACCELEROMETER,
+				     OSF_TEST_SENSOR_INDEX, 3,
+				     OSF_SAMPLE_FORMAT_S32,
+				     baseline_values, 2);
+	KUNIT_ASSERT_EQ(test, ret, OSF_STREAM_FRAME_HANDLED);
+	KUNIT_ASSERT_EQ(test, ctx->osf.latest_sample_count, 1U);
+	osf_test_expect_direct_sample(test, ctx, baseline_values);
+
+	KUNIT_ASSERT_EQ(test, osf_test_remove_scan(ctx, &scan), 0);
+
+	baseline = ctx->osf.latest_samples[0];
+	baseline_sequence = ctx->osf.last_sequence;
+	frame_len = osf_test_build_sample_frame(rejected_frame,
+						sizeof(rejected_frame),
+						OSF_SENSOR_ACCELEROMETER,
+						OSF_TEST_SENSOR_INDEX, 1,
+						OSF_SAMPLE_FORMAT_S32,
+						rejected_values, 3);
+	KUNIT_ASSERT_NE(test, frame_len, (size_t)0);
+	KUNIT_ASSERT_EQ(test,
+			osf_protocol_decode_frame(rejected_frame, frame_len,
+						  &decoded_frame, &decoded_len), 0);
+	KUNIT_ASSERT_EQ(test, decoded_len, frame_len);
+	KUNIT_ASSERT_EQ(test,
+			osf_protocol_decode_sensor_sample(&decoded_frame,
+							  &decoded_sample), 0);
+	KUNIT_ASSERT_EQ(test, decoded_sample.channel_count, (u16)1);
+	ret = osf_core_receive_frame(&ctx->osf, rejected_frame, frame_len);
+	KUNIT_ASSERT_EQ(test, ret, OSF_STREAM_FRAME_REJECTED);
+	KUNIT_EXPECT_EQ(test, ctx->osf.latest_sample_count, 1U);
+	KUNIT_EXPECT_MEMEQ(test, &ctx->osf.latest_samples[0], &baseline,
+			   sizeof(baseline));
+	KUNIT_EXPECT_EQ(test, ctx->osf.last_sequence, baseline_sequence);
+	osf_test_expect_direct_sample(test, ctx, baseline_values);
+	KUNIT_EXPECT_EQ(test, osf_test_remove_scan(ctx, &scan), -EBUSY);
+}
+
+static void
+osf_valid_sample_updates_direct_and_buffer_test(struct kunit *test)
+{
+	struct osf_test_context *ctx = test->priv;
+	const s32 baseline_values[] = { 1, 2, 3 };
+	const s32 rejected_values[] = { -1 };
+	const s32 valid_values[] = { 101, -202, 303 };
+	struct osf_test_scan_3axis scan = { };
+	int ret;
+
+	KUNIT_ASSERT_EQ(test, osf_test_enable_buffer(ctx), 0);
+
+	ret = osf_test_submit_sample(ctx, OSF_SENSOR_ACCELEROMETER,
+				     OSF_TEST_SENSOR_INDEX, 3,
+				     OSF_SAMPLE_FORMAT_S32,
+				     baseline_values, 2);
+	KUNIT_ASSERT_EQ(test, ret, OSF_STREAM_FRAME_HANDLED);
+	KUNIT_ASSERT_EQ(test, osf_test_remove_scan(ctx, &scan), 0);
+
+	ret = osf_test_submit_sample(ctx, OSF_SENSOR_ACCELEROMETER,
+				     OSF_TEST_SENSOR_INDEX, 1,
+				     OSF_SAMPLE_FORMAT_S32,
+				     rejected_values, 3);
+	KUNIT_ASSERT_EQ(test, ret, OSF_STREAM_FRAME_REJECTED);
+	KUNIT_ASSERT_EQ(test, osf_test_remove_scan(ctx, &scan), -EBUSY);
+
+	ret = osf_test_submit_sample(ctx, OSF_SENSOR_ACCELEROMETER,
+				     OSF_TEST_SENSOR_INDEX, 3,
+				     OSF_SAMPLE_FORMAT_S32,
+				     valid_values, 4);
+	KUNIT_ASSERT_EQ(test, ret, OSF_STREAM_FRAME_HANDLED);
+	osf_test_expect_direct_sample(test, ctx, valid_values);
+	KUNIT_ASSERT_EQ(test, ctx->indio_dev->scan_bytes, (int)sizeof(scan));
+	KUNIT_ASSERT_EQ(test, osf_test_remove_scan(ctx, &scan), 0);
+	KUNIT_EXPECT_EQ(test, scan.values[0], valid_values[0]);
+	KUNIT_EXPECT_EQ(test, scan.values[1], valid_values[1]);
+	KUNIT_EXPECT_EQ(test, scan.values[2], valid_values[2]);
+	KUNIT_EXPECT_EQ(test, osf_test_remove_scan(ctx, &scan), -EBUSY);
+}
+
+static void osf_unregistered_sample_is_ignored_test(struct kunit *test)
+{
+	struct osf_test_context *ctx = test->priv;
+	const s32 baseline_values[] = { 10, 20, 30 };
+	const s32 ignored_values[] = { -10, -20, -30 };
+	struct osf_latest_sample baseline;
+	struct osf_test_scan_3axis scan;
+	s32 value;
+	int ret;
+
+	KUNIT_ASSERT_EQ(test, osf_test_enable_buffer(ctx), 0);
+	ret = osf_test_submit_sample(ctx, OSF_SENSOR_ACCELEROMETER,
+				     OSF_TEST_SENSOR_INDEX, 3,
+				     OSF_SAMPLE_FORMAT_S32,
+				     baseline_values, 2);
+	KUNIT_ASSERT_EQ(test, ret, OSF_STREAM_FRAME_HANDLED);
+	KUNIT_ASSERT_EQ(test, osf_test_remove_scan(ctx, &scan), 0);
+	baseline = ctx->osf.latest_samples[0];
+
+	ret = osf_test_submit_sample(ctx, OSF_SENSOR_ACCELEROMETER,
+				     OSF_TEST_SENSOR_INDEX + 1, 3,
+				     OSF_SAMPLE_FORMAT_S32,
+				     ignored_values, 3);
+	KUNIT_ASSERT_EQ(test, ret, OSF_STREAM_FRAME_IGNORED);
+	KUNIT_EXPECT_EQ(test, ctx->osf.iio_dev_count, 1U);
+	KUNIT_EXPECT_EQ(test, ctx->osf.latest_sample_count, 1U);
+	KUNIT_EXPECT_MEMEQ(test, &ctx->osf.latest_samples[0], &baseline,
+			   sizeof(baseline));
+	osf_test_expect_direct_sample(test, ctx, baseline_values);
+	ret = osf_core_read_latest_sample(&ctx->osf,
+					  OSF_SENSOR_ACCELEROMETER,
+					  OSF_TEST_SENSOR_INDEX + 1,
+					  0, &value);
+	KUNIT_EXPECT_EQ(test, ret, -ENODATA);
+	KUNIT_EXPECT_EQ(test, osf_test_remove_scan(ctx, &scan), -EBUSY);
+}
+
+static void
+osf_unaccepted_samples_do_not_exhaust_cache_test(struct kunit *test)
+{
+	struct osf_test_context *ctx = test->priv;
+	const s32 three_values[] = { 7, 8, 9 };
+	const s32 one_value[] = { 42 };
+	struct osf_latest_sample *empty_cache;
+	struct osf_sensor_sample decoded_sample;
+	struct osf_frame decoded_frame;
+	u8 malformed_frame[OSF_TEST_MAX_FRAME_LEN];
+	size_t decoded_len;
+	size_t frame_len;
+	int value;
+	int ret;
+
+	KUNIT_ASSERT_EQ(test, ctx->osf.latest_sample_count, 0U);
+	empty_cache = kunit_kzalloc(test, sizeof(ctx->osf.latest_samples), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, empty_cache);
+	memcpy(empty_cache, ctx->osf.latest_samples, sizeof(ctx->osf.latest_samples));
+
+	for (unsigned int i = 0; i < OSF_TEST_FLOOD_COUNT; i++) {
+		ret = osf_test_submit_sample(ctx, OSF_SENSOR_ACCELEROMETER,
+					     OSF_TEST_SENSOR_INDEX + i + 1,
+					     3, OSF_SAMPLE_FORMAT_S32,
+					     three_values, 100 + i);
+		KUNIT_ASSERT_EQ(test, ret, OSF_STREAM_FRAME_IGNORED);
+	}
+	KUNIT_ASSERT_EQ(test, ctx->osf.latest_sample_count, 0U);
+
+	for (unsigned int i = 0; i < OSF_TEST_FLOOD_COUNT; i++) {
+		ret = osf_test_submit_sample(ctx, OSF_SENSOR_BAROMETER,
+					     OSF_TEST_UNSUPPORTED_INDEX, 1,
+					     OSF_SAMPLE_FORMAT_S32,
+					     one_value, 200 + i);
+		KUNIT_ASSERT_EQ(test, ret, OSF_STREAM_FRAME_IGNORED);
+	}
+	KUNIT_ASSERT_EQ(test, ctx->osf.latest_sample_count, 0U);
+
+	for (unsigned int i = 0; i < OSF_TEST_FLOOD_COUNT; i++) {
+		ret = osf_test_submit_sample(ctx, OSF_SENSOR_ACCELEROMETER,
+					     OSF_TEST_SENSOR_INDEX, 1,
+					     OSF_SAMPLE_FORMAT_S32,
+					     one_value, 300 + i);
+		KUNIT_ASSERT_EQ(test, ret, OSF_STREAM_FRAME_REJECTED);
+	}
+	KUNIT_ASSERT_EQ(test, ctx->osf.latest_sample_count, 0U);
+
+	frame_len = osf_test_build_truncated_sample_frame(malformed_frame,
+							  sizeof(malformed_frame), 400);
+	KUNIT_ASSERT_NE(test, frame_len, (size_t)0);
+	KUNIT_ASSERT_EQ(test,
+			osf_protocol_decode_frame(malformed_frame, frame_len,
+						  &decoded_frame, &decoded_len), 0);
+	KUNIT_ASSERT_EQ(test, decoded_len, frame_len);
+	KUNIT_ASSERT_EQ(test,
+			osf_protocol_decode_sensor_sample(&decoded_frame,
+							  &decoded_sample),
+			-EMSGSIZE);
+
+	for (unsigned int i = 0; i < OSF_TEST_FLOOD_COUNT; i++) {
+		ret = osf_core_receive_frame(&ctx->osf, malformed_frame,
+					     frame_len);
+		KUNIT_ASSERT_EQ(test, ret, OSF_STREAM_FRAME_REJECTED);
+	}
+	KUNIT_ASSERT_EQ(test, ctx->osf.latest_sample_count, 0U);
+
+	KUNIT_EXPECT_MEMEQ(test, ctx->osf.latest_samples, empty_cache,
+			   sizeof(ctx->osf.latest_samples));
+	KUNIT_EXPECT_EQ(test, ctx->osf.last_sequence, (u64)1);
+
+	ret = osf_test_submit_sample(ctx, OSF_SENSOR_ACCELEROMETER,
+				     OSF_TEST_SENSOR_INDEX, 3,
+				     OSF_SAMPLE_FORMAT_S32,
+				     three_values, 500);
+	KUNIT_ASSERT_EQ(test, ret, OSF_STREAM_FRAME_HANDLED);
+	KUNIT_ASSERT_EQ(test, ctx->osf.latest_sample_count, 1U);
+
+	for (unsigned int i = 0; i < 3; i++) {
+		value = 0;
+		ret = osf_test_read_raw(ctx, i, &value);
+		KUNIT_ASSERT_EQ(test, ret, IIO_VAL_INT);
+		KUNIT_EXPECT_EQ(test, value, three_values[i]);
+	}
+}
+
+static void osf_test_cleanup_pending(void *data)
+{
+	struct osf_device *pending = data;
+
+	osf_core_unregister_iio(pending);
+	mutex_destroy(&pending->latest_lock);
+}
+
+static void osf_early_capability_is_owned_test(struct kunit *test)
+{
+	struct osf_test_context *ctx = test->priv;
+	struct osf_device *pending;
+	struct iio_dev *indio_dev;
+	u8 frame[OSF_TEST_MAX_FRAME_LEN];
+	size_t len;
+	int scale, nano, ret;
+
+	pending = kunit_kzalloc(test, sizeof(*pending), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, pending);
+	osf_core_init(pending, ctx->dev);
+	ret = kunit_add_action_or_reset(test, osf_test_cleanup_pending, pending);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	len = osf_test_build_capability_frame(frame, sizeof(frame), 10);
+	KUNIT_ASSERT_NE(test, len, (size_t)0);
+	KUNIT_EXPECT_EQ(test, osf_core_receive_frame(pending, frame, len),
+			OSF_STREAM_FRAME_HANDLED);
+	KUNIT_EXPECT_EQ(test, pending->iio_dev_count, 0U);
+	KUNIT_ASSERT_TRUE(test, pending->capability_cache.valid);
+	KUNIT_EXPECT_EQ(test, pending->capability_cache.capability_count, (u16)1);
+
+	/* The stream may reuse its storage before probe opens the registration gate. */
+	memset(frame, 0xa5, sizeof(frame));
+	osf_core_start(pending);
+	KUNIT_ASSERT_EQ(test, pending->iio_dev_count, 1U);
+	indio_dev = pending->iio_devs[0].indio_dev;
+	ret = indio_dev->info->read_raw(indio_dev, &indio_dev->channels[0],
+				       &scale, &nano, IIO_CHAN_INFO_SCALE);
+	KUNIT_EXPECT_EQ(test, ret, IIO_VAL_INT_PLUS_NANO);
+	KUNIT_EXPECT_EQ(test, scale, 0);
+	KUNIT_EXPECT_EQ(test, nano, OSF_TEST_SCALE_NANO);
+	osf_core_start(pending);
+	KUNIT_EXPECT_EQ(test, pending->iio_dev_count, 1U);
+	len = osf_test_build_capability_frame(frame, sizeof(frame), 11);
+	KUNIT_EXPECT_EQ(test, osf_core_receive_frame(pending, frame, len),
+			OSF_STREAM_FRAME_IGNORED);
+	KUNIT_EXPECT_EQ(test, pending->iio_dev_count, 1U);
+	KUNIT_EXPECT_EQ(test, pending->latest_sample_count, 0U);
+}
+
+static void osf_early_duplicate_capability_is_rejected_test(struct kunit *test)
+{
+	struct osf_test_context *ctx = test->priv;
+	struct osf_device *pending;
+	u8 payload[OSF_CAP_REPORT_BASE_LEN + 2 * OSF_CAP_SENSOR_ENTRY_LEN] = { };
+	u8 frame[OSF_TEST_MAX_FRAME_LEN];
+	u8 *entry = payload + OSF_CAP_REPORT_BASE_LEN;
+	size_t len;
+	int ret;
+
+	pending = kunit_kzalloc(test, sizeof(*pending), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, pending);
+	osf_core_init(pending, ctx->dev);
+	ret = kunit_add_action_or_reset(test, osf_test_cleanup_pending, pending);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	put_unaligned_le16(2, payload);
+	put_unaligned_le16(OSF_SENSOR_ACCELEROMETER, entry);
+	put_unaligned_le16(3, entry + 4);
+	put_unaligned_le16(OSF_SAMPLE_FORMAT_S32, entry + 6);
+	put_unaligned_le32(OSF_TEST_SCALE_NANO, entry + 8);
+	memcpy(entry + OSF_CAP_SENSOR_ENTRY_LEN, entry, OSF_CAP_SENSOR_ENTRY_LEN);
+	len = osf_test_build_frame(frame, sizeof(frame), OSF_MSG_CAPABILITY_REPORT,
+				   payload, sizeof(payload), 20);
+	KUNIT_EXPECT_EQ(test, osf_core_receive_frame(pending, frame, len),
+			OSF_STREAM_FRAME_REJECTED);
+	KUNIT_EXPECT_FALSE(test, pending->capability_cache.valid);
+	KUNIT_EXPECT_EQ(test, pending->iio_dev_count, 0U);
+
+	/* A failed early report must not prevent a subsequent valid report. */
+	len = osf_test_build_capability_frame(frame, sizeof(frame), 21);
+	KUNIT_EXPECT_EQ(test, osf_core_receive_frame(pending, frame, len),
+			OSF_STREAM_FRAME_HANDLED);
+	osf_core_start(pending);
+	KUNIT_EXPECT_EQ(test, pending->iio_dev_count, 1U);
+}
+
+static const struct osf_capability_entry osf_test_accel = {
+	.sensor_type = OSF_SENSOR_ACCELEROMETER,
+	.channel_count = 3,
+	.sample_format = OSF_SAMPLE_FORMAT_S32,
+	.scale_nano = OSF_TEST_SCALE_NANO,
+};
+
+static void osf_test_crc(u8 *frame, size_t len)
+{
+	put_unaligned_le32(crc32_le(~0U, frame, len - OSF_FRAME_CRC_LEN) ^ ~0U,
+			   frame + len - OSF_FRAME_CRC_LEN);
+}
+
+static size_t osf_test_report(u8 *frame,
+			      const struct osf_capability_entry *entries, u16 count)
+{
+	u8 payload[OSF_CAP_REPORT_BASE_LEN + 3 * OSF_CAP_SENSOR_ENTRY_LEN] = { };
+
+	put_unaligned_le16(count, payload);
+	for (u16 i = 0; i < count; i++) {
+		u8 *p = payload + OSF_CAP_REPORT_BASE_LEN + i * OSF_CAP_SENSOR_ENTRY_LEN;
+
+		put_unaligned_le16(entries[i].sensor_type, p);
+		put_unaligned_le16(entries[i].sensor_index, p + 2);
+		put_unaligned_le16(entries[i].channel_count, p + 4);
+		put_unaligned_le16(entries[i].sample_format, p + 6);
+		put_unaligned_le32(entries[i].scale_nano, p + 8);
+		put_unaligned_le32(entries[i].flags, p + 12);
+	}
+	return osf_test_build_frame(frame, OSF_TEST_MAX_FRAME_LEN,
+				    OSF_MSG_CAPABILITY_REPORT, payload,
+				    OSF_CAP_REPORT_BASE_LEN + count * OSF_CAP_SENSOR_ENTRY_LEN,
+				    10);
+}
+
+static int osf_test_submit_report(struct osf_test_context *ctx,
+				  const struct osf_capability_entry *entries, u16 count)
+{
+	u8 frame[OSF_TEST_MAX_FRAME_LEN];
+	size_t len = osf_test_report(frame, entries, count);
+
+	return osf_core_receive_frame(&ctx->osf, frame, len);
+}
+
+static void osf_test_new_session(struct osf_test_context *ctx)
+{
+	osf_test_cleanup(ctx);
+	osf_core_init(&ctx->osf, ctx->dev);
+	osf_core_start(&ctx->osf);
+	ctx->indio_dev = NULL;
+	ctx->buffer = NULL;
+}
+
+static void osf_test_bind_accel(struct kunit *test, struct osf_test_context *ctx)
+{
+	KUNIT_ASSERT_EQ(test, osf_test_submit_report(ctx, &osf_test_accel, 1),
+			OSF_STREAM_FRAME_HANDLED);
+	KUNIT_ASSERT_EQ(test, ctx->osf.iio_dev_count, 1U);
+	ctx->indio_dev = ctx->osf.iio_devs[0].indio_dev;
+	ctx->buffer = ctx->indio_dev->buffer;
+}
+
+static void osf_zero_scale_is_atomic_test(struct kunit *test)
+{
+	struct osf_test_context *ctx = test->priv;
+	struct osf_capability_entry entries[] = { osf_test_accel, osf_test_accel };
+
+	entries[1].sensor_index = 1;
+	entries[1].scale_nano = 0;
+	/* Even a repeat with a valid prefix must be rejected without a fault. */
+	KUNIT_EXPECT_EQ(test, osf_test_submit_report(ctx, entries, 2),
+			OSF_STREAM_FRAME_REJECTED);
+	KUNIT_EXPECT_FALSE(test, ctx->osf.session_fault);
+	KUNIT_EXPECT_EQ(test, ctx->osf.iio_dev_count, 1U);
+	osf_test_new_session(ctx);
+	KUNIT_EXPECT_EQ(test, osf_test_submit_report(ctx, entries, 2),
+			OSF_STREAM_FRAME_REJECTED);
+	KUNIT_EXPECT_EQ(test, ctx->osf.iio_dev_count, 0U);
+	KUNIT_EXPECT_FALSE(test, ctx->osf.capability_cache.valid);
+	osf_test_bind_accel(test, ctx);
+}
+
+static int osf_test_stream_frame(void *context, const u8 *buf, size_t len)
+{
+	return osf_core_receive_frame(context, buf, len);
+}
+
+static void osf_scale_mismatch_preserves_and_recovers_test(struct kunit *test)
+{
+	struct osf_test_context *ctx = test->priv;
+	const s32 values[] = { OSF_FRAME_MAGIC, -22, 33 };
+	const s32 next[] = { 101, 202, 303 };
+	struct osf_latest_sample baseline;
+	struct osf_test_scan_3axis scan;
+	struct osf_stream *stream;
+	u8 frame[OSF_TEST_MAX_FRAME_LEN];
+	size_t len;
+
+	stream = kunit_kzalloc(test, sizeof(*stream), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, stream);
+	osf_stream_init(stream, osf_test_stream_frame, &ctx->osf);
+	KUNIT_ASSERT_EQ(test, osf_test_enable_buffer(ctx), 0);
+	KUNIT_ASSERT_EQ(test, osf_test_submit_sample(ctx, OSF_SENSOR_ACCELEROMETER,
+						     0, 3, OSF_SAMPLE_FORMAT_S32, values, 2),
+				OSF_STREAM_FRAME_HANDLED);
+	KUNIT_ASSERT_EQ(test, osf_test_remove_scan(ctx, &scan), 0);
+	baseline = ctx->osf.latest_samples[0];
+	len = osf_test_build_sample_frame(frame, sizeof(frame), OSF_SENSOR_ACCELEROMETER,
+					  0, 3, OSF_SAMPLE_FORMAT_S32, values, 3);
+	put_unaligned_le32(OSF_TEST_SCALE_NANO + 1, frame + OSF_FRAME_HEADER_LEN + 8);
+	osf_test_crc(frame, len);
+	KUNIT_EXPECT_EQ(test, osf_stream_receive_bytes(stream, frame, len), 0);
+	KUNIT_EXPECT_EQ(test, stream->stats.rejected_frames, 1ULL);
+	KUNIT_EXPECT_EQ(test, stream->stats.validated_frames, 1ULL);
+	KUNIT_EXPECT_EQ(test, stream->stats.bad_magic_resyncs, 0ULL);
+	KUNIT_EXPECT_MEMEQ(test, &ctx->osf.latest_samples[0], &baseline, sizeof(baseline));
+	KUNIT_EXPECT_FALSE(test, ctx->osf.session_fault);
+	osf_test_expect_direct_sample(test, ctx, values);
+	KUNIT_EXPECT_EQ(test, osf_test_remove_scan(ctx, &scan), -EBUSY);
+	KUNIT_EXPECT_EQ(test, osf_test_submit_sample(ctx, OSF_SENSOR_ACCELEROMETER,
+						     0, 3, OSF_SAMPLE_FORMAT_S32, next, 4),
+				OSF_STREAM_FRAME_HANDLED);
+	osf_test_expect_direct_sample(test, ctx, next);
+	KUNIT_ASSERT_EQ(test, osf_test_remove_scan(ctx, &scan), 0);
+	KUNIT_EXPECT_MEMEQ(test, scan.values, next, sizeof(next));
+}
+
+static void osf_test_initial_recovery(struct kunit *test, bool unsupported)
+{
+	struct osf_test_context *ctx = test->priv;
+	struct osf_capability_entry entry = osf_test_accel;
+
+	osf_test_new_session(ctx);
+	entry.sensor_type = 0xffff;
+	KUNIT_EXPECT_EQ(test, osf_test_submit_report(ctx, &entry, unsupported ? 1 : 0),
+			OSF_STREAM_FRAME_IGNORED);
+	KUNIT_EXPECT_FALSE(test, ctx->osf.capability_cache.valid);
+	KUNIT_EXPECT_EQ(test, ctx->osf.iio_dev_count, 0U);
+	osf_test_bind_accel(test, ctx);
+	KUNIT_EXPECT_FALSE(test, ctx->osf.session_fault);
+}
+
+static void osf_initial_empty_recovers_test(struct kunit *test)
+{
+	osf_test_initial_recovery(test, false);
+}
+
+static void osf_initial_unsupported_recovers_test(struct kunit *test)
+{
+	osf_test_initial_recovery(test, true);
+}
+
+static void osf_equivalent_reports_test(struct kunit *test)
+{
+	struct osf_test_context *ctx = test->priv;
+	struct osf_capability_entry entries[] = { osf_test_accel, osf_test_accel,
+						osf_test_accel };
+	struct osf_capability_entry swap;
+	struct iio_dev *first;
+
+	osf_test_new_session(ctx);
+	entries[1].sensor_type = OSF_SENSOR_GYROSCOPE;
+	KUNIT_ASSERT_EQ(test, osf_test_submit_report(ctx, entries, 2), OSF_STREAM_FRAME_HANDLED);
+	first = ctx->osf.iio_devs[0].indio_dev;
+	KUNIT_EXPECT_EQ(test, osf_test_submit_report(ctx, entries, 2), OSF_STREAM_FRAME_IGNORED);
+	swap = entries[0];
+	entries[0] = entries[1];
+	entries[1] = swap;
+	KUNIT_EXPECT_EQ(test, osf_test_submit_report(ctx, entries, 2), OSF_STREAM_FRAME_IGNORED);
+	entries[0].flags = OSF_CAPABILITY_FLAGS_MASK;
+	entries[2].sensor_type = 0xffff;
+	KUNIT_EXPECT_EQ(test, osf_test_submit_report(ctx, entries, 3), OSF_STREAM_FRAME_IGNORED);
+	/* Unknown flags make the added key unsupported. */
+	entries[2] = osf_test_accel;
+	entries[2].sensor_index = 1;
+	entries[2].flags = BIT(7);
+	KUNIT_EXPECT_EQ(test, osf_test_submit_report(ctx, entries, 3), OSF_STREAM_FRAME_IGNORED);
+	KUNIT_EXPECT_EQ(test, ctx->osf.iio_dev_count, 2U);
+	KUNIT_EXPECT_PTR_EQ(test, ctx->osf.iio_devs[0].indio_dev, first);
+	KUNIT_EXPECT_FALSE(test, ctx->osf.session_fault);
+}
+
+static void osf_changed_reports_fault_test(struct kunit *test)
+{
+	struct osf_test_context *ctx = test->priv;
+	const s32 v[] = { 11, 22, 33 };
+	struct osf_test_scan_3axis scan;
+
+	for (unsigned int change = 0; change < 8; change++) {
+		struct osf_capability_entry entries[] = { osf_test_accel, osf_test_accel };
+		struct osf_latest_sample baseline;
+		struct iio_dev *child;
+		u16 count = 1;
+		int value = 0;
+
+		osf_test_new_session(ctx);
+		osf_test_bind_accel(test, ctx);
+		child = ctx->indio_dev;
+		KUNIT_ASSERT_EQ(test, osf_test_enable_buffer(ctx), 0);
+		KUNIT_ASSERT_EQ(test, osf_test_submit_sample(ctx, OSF_SENSOR_ACCELEROMETER,
+							     0, 3, OSF_SAMPLE_FORMAT_S32, v, 2),
+				OSF_STREAM_FRAME_HANDLED);
+		KUNIT_ASSERT_EQ(test, osf_test_remove_scan(ctx, &scan), 0);
+		baseline = ctx->osf.latest_samples[0];
+		switch (change) {
+		case 0:
+			entries[0].scale_nano++;
+			break;
+		case 1:
+			entries[0].channel_count = 1;
+			break;
+		case 2:
+			entries[0].sample_format = 2;
+			break;
+		case 3:
+			entries[0].sensor_index = 1;
+			break;
+		case 4:
+			count = 0;
+			break;
+		case 5:
+			entries[0].sensor_type = 0xffff;
+			break;
+		case 6:
+			entries[1].sensor_index = 1;
+			count = 2;
+			break;
+		case 7:
+			entries[0].flags = BIT(7);
+			break;
+		}
+		kunit_info(test, "meaning change=%u\n", change);
+		KUNIT_EXPECT_EQ(test, osf_test_submit_report(ctx, entries, count),
+				OSF_STREAM_FRAME_REJECTED);
+		KUNIT_EXPECT_TRUE(test, ctx->osf.session_fault);
+		KUNIT_EXPECT_EQ(test, ctx->osf.iio_dev_count, 1U);
+		KUNIT_EXPECT_PTR_EQ(test, ctx->osf.iio_devs[0].indio_dev, child);
+		KUNIT_EXPECT_EQ(test, osf_test_submit_sample(ctx, OSF_SENSOR_ACCELEROMETER,
+							     0, 3, OSF_SAMPLE_FORMAT_S32, v, 3),
+				OSF_STREAM_FRAME_REJECTED);
+		KUNIT_EXPECT_MEMEQ(test, &ctx->osf.latest_samples[0], &baseline, sizeof(baseline));
+		KUNIT_EXPECT_EQ(test, osf_test_remove_scan(ctx, &scan), -EBUSY);
+		KUNIT_EXPECT_EQ(test, osf_test_read_raw(ctx, 0, &value), -EPROTO);
+		/* Equivalent reports do not repair a faulted host session. */
+		KUNIT_EXPECT_EQ(test, osf_test_submit_report(ctx, &osf_test_accel, 1),
+				OSF_STREAM_FRAME_IGNORED);
+		KUNIT_EXPECT_EQ(test, osf_test_read_raw(ctx, 0, &value), -EPROTO);
+	}
+}
+
+static void osf_rebind_and_timestamp_restart_test(struct kunit *test)
+{
+	struct osf_test_context *ctx = test->priv;
+	struct osf_capability_entry entry = osf_test_accel;
+	const s32 values[] = { 101, -202, 303 };
+	u8 frame[OSF_TEST_MAX_FRAME_LEN];
+	size_t len;
+
+	entry.scale_nano++;
+	KUNIT_ASSERT_EQ(test, osf_test_submit_report(ctx, &entry, 1), OSF_STREAM_FRAME_REJECTED);
+	KUNIT_ASSERT_TRUE(test, ctx->osf.session_fault);
+	osf_test_new_session(ctx);
+	KUNIT_ASSERT_EQ(test, osf_test_submit_report(ctx, &entry, 1), OSF_STREAM_FRAME_HANDLED);
+	ctx->indio_dev = ctx->osf.iio_devs[0].indio_dev;
+	ctx->buffer = ctx->indio_dev->buffer;
+	KUNIT_EXPECT_FALSE(test, ctx->osf.session_fault);
+	KUNIT_EXPECT_EQ(test, ctx->osf.latest_sample_count, 0U);
+	for (unsigned int i = 0; i < 2; i++) {
+		len = osf_test_build_sample_frame(frame, sizeof(frame), OSF_SENSOR_ACCELEROMETER,
+						  0, 3, OSF_SAMPLE_FORMAT_S32, values, i ? 0 : 100);
+		put_unaligned_le32(entry.scale_nano, frame + OSF_FRAME_HEADER_LEN + 8);
+		osf_test_crc(frame, len);
+		KUNIT_EXPECT_EQ(test, osf_core_receive_frame(&ctx->osf, frame, len),
+				OSF_STREAM_FRAME_HANDLED);
+		KUNIT_EXPECT_EQ(test, osf_test_submit_report(ctx, &entry, 1),
+				OSF_STREAM_FRAME_IGNORED);
+	}
+	osf_test_expect_direct_sample(test, ctx, values);
+	KUNIT_EXPECT_FALSE(test, ctx->osf.session_fault);
+}
+
+static void osf_reserved_padding_is_ignored_test(struct kunit *test)
+{
+	struct osf_test_context *ctx = test->priv;
+	struct osf_capability_entry entry = osf_test_accel;
+	const s32 values[] = { 11, 22, 33 };
+	u8 status[OSF_DEVICE_STATUS_LEN] = { };
+	u8 frame[OSF_TEST_MAX_FRAME_LEN];
+	size_t len;
+
+	osf_test_new_session(ctx);
+	len = osf_test_report(frame, &entry, 1);
+	put_unaligned_le32(0xdeadbeef, frame + 34);
+	put_unaligned_le16(0x1234, frame + OSF_FRAME_HEADER_LEN + 2);
+	put_unaligned_le32(0xa5a5a5a5,
+			   frame + OSF_FRAME_HEADER_LEN + OSF_CAP_REPORT_BASE_LEN + 16);
+	osf_test_crc(frame, len);
+	KUNIT_ASSERT_EQ(test, osf_core_receive_frame(&ctx->osf, frame, len),
+			OSF_STREAM_FRAME_HANDLED);
+	KUNIT_EXPECT_EQ(test, osf_core_receive_frame(&ctx->osf, frame, len),
+			OSF_STREAM_FRAME_IGNORED);
+	KUNIT_ASSERT_EQ(test, ctx->osf.iio_dev_count, 1U);
+	ctx->indio_dev = ctx->osf.iio_devs[0].indio_dev;
+	ctx->buffer = ctx->indio_dev->buffer;
+	len = osf_test_build_sample_frame(frame, sizeof(frame), OSF_SENSOR_ACCELEROMETER,
+					  0, 3, OSF_SAMPLE_FORMAT_S32, values, 2);
+	put_unaligned_le32(0xaabbccdd, frame + OSF_FRAME_HEADER_LEN + 12);
+	osf_test_crc(frame, len);
+	KUNIT_EXPECT_EQ(test, osf_core_receive_frame(&ctx->osf, frame, len),
+			OSF_STREAM_FRAME_HANDLED);
+	osf_test_expect_direct_sample(test, ctx, values);
+	put_unaligned_le32(0x12345678, status + 16);
+	len = osf_test_build_frame(frame, sizeof(frame), OSF_MSG_DEVICE_STATUS,
+				   status, sizeof(status), 3);
+	KUNIT_EXPECT_EQ(test, osf_core_receive_frame(&ctx->osf, frame, len),
+			OSF_STREAM_FRAME_HANDLED);
+	KUNIT_EXPECT_TRUE(test, ctx->osf.status_cache.valid);
+}
+
+static void osf_bad_crc_bounds_and_extensions_test(struct kunit *test)
+{
+	struct osf_test_context *ctx = test->priv;
+	const s32 values[] = { 11, 22, 33 };
+	struct osf_latest_sample baseline;
+	u8 frame[OSF_TEST_MAX_FRAME_LEN];
+	u8 payload[OSF_TEST_MAX_PAYLOAD_LEN + 1] = { };
+	size_t len;
+
+	KUNIT_ASSERT_EQ(test, osf_test_submit_sample(ctx, OSF_SENSOR_ACCELEROMETER,
+						     0, 3, OSF_SAMPLE_FORMAT_S32, values, 2),
+				OSF_STREAM_FRAME_HANDLED);
+	baseline = ctx->osf.latest_samples[0];
+	len = osf_test_report(frame, &osf_test_accel, 1);
+	frame[34] = 1;
+	KUNIT_EXPECT_EQ(test, osf_core_receive_frame(&ctx->osf, frame, len), -EBADMSG);
+	osf_test_crc(frame, len);
+	put_unaligned_le32(U32_MAX, frame + 10);
+	KUNIT_EXPECT_EQ(test, osf_core_receive_frame(&ctx->osf, frame, len), -EMSGSIZE);
+	len = osf_test_report(frame, &osf_test_accel, 1);
+	put_unaligned_le16(2, frame + OSF_FRAME_HEADER_LEN);
+	osf_test_crc(frame, len);
+	KUNIT_EXPECT_EQ(test, osf_core_receive_frame(&ctx->osf, frame, len),
+			OSF_STREAM_FRAME_REJECTED);
+	/* A CRC-valid trailing byte is not an extension of any fixed baseline ID. */
+	for (u16 type = OSF_MSG_SENSOR_SAMPLE; type <= OSF_MSG_CAPABILITY_REPORT; type++) {
+		u32 size;
+
+		memset(payload, 0, sizeof(payload));
+		if (type == OSF_MSG_SENSOR_SAMPLE) {
+			put_unaligned_le16(OSF_SENSOR_ACCELEROMETER, payload);
+			put_unaligned_le16(3, payload + 4);
+			put_unaligned_le16(OSF_SAMPLE_FORMAT_S32, payload + 6);
+			put_unaligned_le32(OSF_TEST_SCALE_NANO, payload + 8);
+			size = OSF_TEST_MAX_PAYLOAD_LEN;
+		} else if (type == OSF_MSG_DEVICE_STATUS) {
+			size = OSF_DEVICE_STATUS_LEN;
+		} else {
+			size = OSF_CAP_REPORT_BASE_LEN;
+		}
+		len = osf_test_build_frame(frame, sizeof(frame), type, payload, size + 1, 3);
+		KUNIT_EXPECT_EQ(test, osf_core_receive_frame(&ctx->osf, frame, len),
+				OSF_STREAM_FRAME_REJECTED);
+	}
+	KUNIT_EXPECT_FALSE(test, ctx->osf.session_fault);
+	KUNIT_EXPECT_MEMEQ(test, &ctx->osf.latest_samples[0], &baseline, sizeof(baseline));
+}
+
+struct osf_session_race {
+	struct osf_test_context *ctx;
+	/* Model the transport serialization separately from IIO configuration. */
+	struct mutex rx_lock;
+	struct completion started;
+	struct completion fault_observed;
+	atomic_t faulted;
+	atomic_t rejected;
+	atomic_t errors;
+};
+
+static int osf_session_producer(void *data)
+{
+	struct osf_session_race *race = data;
+	const s32 values[] = { 101, 202, 303 };
+	u64 sequence = 100;
+	int ret, raw;
+
+	complete(&race->started);
+	while (!kthread_should_stop()) {
+		mutex_lock(&race->rx_lock);
+		ret = osf_test_submit_sample(race->ctx, OSF_SENSOR_ACCELEROMETER,
+					     0, 3, OSF_SAMPLE_FORMAT_S32, values, sequence++);
+		if (atomic_read(&race->faulted)) {
+			if (ret == OSF_STREAM_FRAME_REJECTED)
+				atomic_inc(&race->rejected);
+			else
+				atomic_inc(&race->errors);
+			complete(&race->fault_observed);
+		}
+		mutex_unlock(&race->rx_lock);
+		ret = osf_test_read_raw(race->ctx, 0, &raw);
+		if (ret != IIO_VAL_INT && ret != -EPROTO && ret != -ENODATA)
+			atomic_inc(&race->errors);
+		cond_resched();
+	}
+	return 0;
+}
+
+KUNIT_DEFINE_ACTION_WRAPPER(osf_test_destroy_mutex, mutex_destroy,
+			    struct mutex *);
+
+KUNIT_DEFINE_ACTION_WRAPPER(osf_test_stop_kthread, kthread_stop,
+			    struct task_struct *);
+
+static void osf_session_fault_buffer_race_test(struct kunit *test)
+{
+	struct osf_test_context *ctx = test->priv;
+	struct osf_capability_entry entry = osf_test_accel;
+	struct osf_latest_sample baseline;
+	struct osf_test_scan_3axis scan;
+	struct osf_session_race *race;
+	struct task_struct *producer;
+	int ret, raw;
+
+	race = kunit_kzalloc(test, sizeof(*race), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, race);
+	race->ctx = ctx;
+	mutex_init(&race->rx_lock);
+	ret = kunit_add_action_or_reset(test, osf_test_destroy_mutex, &race->rx_lock);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	init_completion(&race->started);
+	init_completion(&race->fault_observed);
+	KUNIT_ASSERT_EQ(test, osf_test_enable_buffer(ctx), 0);
+	producer = kthread_run(osf_session_producer, race, "osf-session-test");
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, producer);
+	ret = kunit_add_action_or_reset(test, osf_test_stop_kthread, producer);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	KUNIT_EXPECT_NE(test, wait_for_completion_timeout(&race->started, HZ), 0UL);
+	/* Exercise buffer reconfiguration against latest_lock -> IIO mlock. */
+	for (unsigned int i = 0; i < 100; i++) {
+		KUNIT_EXPECT_EQ(test, iio_update_buffers(ctx->indio_dev, NULL, ctx->buffer), 0);
+		KUNIT_EXPECT_EQ(test, iio_update_buffers(ctx->indio_dev, ctx->buffer, NULL), 0);
+		cond_resched();
+	}
+	mutex_lock(&race->rx_lock);
+	entry.scale_nano++;
+	ret = osf_test_submit_report(ctx, &entry, 1);
+	KUNIT_EXPECT_EQ(test, ret, OSF_STREAM_FRAME_REJECTED);
+	atomic_set(&race->faulted, 1);
+	baseline = ctx->osf.latest_samples[0];
+	while (!osf_test_remove_scan(ctx, &scan))
+		;
+	mutex_unlock(&race->rx_lock);
+	KUNIT_EXPECT_NE(test, wait_for_completion_timeout(&race->fault_observed,
+							  5 * HZ), 0UL);
+	kunit_release_action(test, osf_test_stop_kthread, producer);
+	KUNIT_EXPECT_GT(test, atomic_read(&race->rejected), 0);
+	KUNIT_EXPECT_EQ(test, atomic_read(&race->errors), 0);
+	KUNIT_EXPECT_MEMEQ(test, &ctx->osf.latest_samples[0], &baseline, sizeof(baseline));
+	KUNIT_EXPECT_EQ(test, osf_test_remove_scan(ctx, &scan), -EBUSY);
+	KUNIT_EXPECT_EQ(test, osf_test_read_raw(ctx, 0, &raw), -EPROTO);
+	/* Cleanup follows the real producer-stop -> child-unregister ordering. */
+	osf_test_new_session(ctx);
+	osf_test_bind_accel(test, ctx);
+	KUNIT_EXPECT_FALSE(test, ctx->osf.session_fault);
+}
+
+static struct kunit_case osf_core_test_cases[] = {
+	KUNIT_CASE(osf_zero_scale_is_atomic_test),
+	KUNIT_CASE(osf_scale_mismatch_preserves_and_recovers_test),
+	KUNIT_CASE(osf_initial_empty_recovers_test),
+	KUNIT_CASE(osf_initial_unsupported_recovers_test),
+	KUNIT_CASE(osf_equivalent_reports_test),
+	KUNIT_CASE(osf_changed_reports_fault_test),
+	KUNIT_CASE(osf_rebind_and_timestamp_restart_test),
+	KUNIT_CASE(osf_reserved_padding_is_ignored_test),
+	KUNIT_CASE(osf_bad_crc_bounds_and_extensions_test),
+	KUNIT_CASE(osf_session_fault_buffer_race_test),
+
+	KUNIT_CASE(osf_early_capability_is_owned_test),
+	KUNIT_CASE(osf_early_duplicate_capability_is_rejected_test),
+	KUNIT_CASE(osf_rejected_channel_count_preserves_latest_test),
+	KUNIT_CASE(osf_valid_sample_updates_direct_and_buffer_test),
+	KUNIT_CASE(osf_unregistered_sample_is_ignored_test),
+	KUNIT_CASE(osf_unaccepted_samples_do_not_exhaust_cache_test),
+	{ }
+};
+
+static struct kunit_suite osf_core_test_suite = {
+	.name = "osf-core",
+	.init = osf_test_init,
+	.test_cases = osf_core_test_cases,
+};
+
+kunit_test_suite(osf_core_test_suite);
+
+MODULE_LICENSE("GPL");
