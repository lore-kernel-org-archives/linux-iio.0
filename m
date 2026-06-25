Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62593DE420;
	Thu, 25 Jun 2026 12:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782390312; cv=none; b=pnijiuwRHo0uQxjQ0ctnMCm1fMxIslqvLl/+Isn60t084y67nB+S8GHajRarTyAIG2PvRWbjVYT0yvbVlE9/lDjsvyDgy2nYLJaiV8ivlXn7IzaoLeXdmr+9qNYJjUWOukxUv+KWDMmzOwj+8/3jLmnn6nv2Cwna2jKvwkR4z24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782390312; c=relaxed/simple;
	bh=nuTMAqKNcl4oahvmqGsS9XKX2zIJ+Og/FMK1GzRqDSw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Up7n6skJv8ZROuiXs8Yadd/O29g4maSaYFXsFnef6B3PGEoAp4wmSTevXhjhEV68Mf8QwZD0bebAoS00V/ZZcwKXW0HBF730KHIzH7BtlgF0gnigLHu6qfPzn4x/k1hVbfPLVEO/DJQ9M6oOC9QQ3fXtu/Zw05crZ9FNJVNn+iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kTyd+fPx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kTyd+fPx"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7318EC2BCF5;
	Thu, 25 Jun 2026 12:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782390312;
	bh=nuTMAqKNcl4oahvmqGsS9XKX2zIJ+Og/FMK1GzRqDSw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=kTyd+fPxa8yGSsAiMdMJ2ITDMYVMfhXyIM77UtMrH8K1nBM3uhgdS1kp81SbtizWW
	 Uko346GiZz5ehjg243MIbp/b2b3+6fFFQsbH5HN7G/YUDmGWpJlpk9KAWfS4MfZprx
	 ghdtc/yHyp4eL0fBUa7vzRVTSeX46HniagNg8z2r2h9NjL/kuaBBs6u4dw1fuHaIIq
	 3a52G1DVHvGG1pLymCBggnExtNapfnCV46MgerjbDhLTXfAb15muLNLD/ky4aE6D5U
	 1YzcXVDHVqxGZopBRYz6Zo+Tr8xTW1VDF2KsO65DxYvXq4lk3mVK2wwR8qgR8A9ujp
	 K7YuYnLnXShUQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F04BCDE000;
	Thu, 25 Jun 2026 12:25:12 +0000 (UTC)
From: Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Date: Thu, 25 Jun 2026 14:24:53 +0200
Subject: [PATCH v4 2/2] iio: imu: inv_icm42600: add buffer hwfifo watermark
 attributes
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-inv-icm42600-add-buffer-hwfifo_attributes-v4-2-8b4c8bfa96d7@tdk.com>
References: <20260625-inv-icm42600-add-buffer-hwfifo_attributes-v4-0-8b4c8bfa96d7@tdk.com>
In-Reply-To: <20260625-inv-icm42600-add-buffer-hwfifo_attributes-v4-0-8b4c8bfa96d7@tdk.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782390310; l=5312;
 i=jean-baptiste.maneyrol@tdk.com; s=20240923; h=from:subject:message-id;
 bh=xTTypk63cfbs3ruz0DEPLY6CHuySY2XM5zYiCJd0h80=;
 b=3wW7qYfVXxlqZ1QyhOcGqDoJV8Ac9+oZ5XoWJ4IgG1oT+aTVhXY88UndEuHTYWM9kx5a6n3Qh
 fGCaPaO+I6BCqEoI2VEmsB/s3/Y0mexgYUMZbmYGm+eWPzFmsjWJwiW
X-Developer-Key: i=jean-baptiste.maneyrol@tdk.com; a=ed25519;
 pk=bRqF1WYk0hR3qrnAithOLXSD0LvSu8DUd+quKLxCicI=
X-Endpoint-Received: by B4 Relay for
 jean-baptiste.maneyrol@tdk.com/20240923 with auth_id=218
X-Original-From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Reply-To: jean-baptiste.maneyrol@tdk.com

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

Add hwfifo_watermark/min/max/enabled buffer attributes.
Hardware FIFO is always enabled and used.

Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600.h        |  2 ++
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c  |  5 +--
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c | 36 ++++++++++++++++++++++
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h |  1 +
 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c   |  5 +--
 5 files changed, 45 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
index 2ab863c9d53a..b55d993f0264 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600.h
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
@@ -356,6 +356,8 @@ struct inv_icm42600_sensor_state {
 		cpu_to_le16((_wm) & GENMASK(11, 0))
 /* FIFO is 2048 bytes, let 12 samples for reading latency */
 #define INV_ICM42600_FIFO_WATERMARK_MAX			(2048 - 12 * 16)
+/* INV_ICM42600_FIFO_WATERMARK_MAX / 8 = 232 */
+#define INV_ICM42600_FIFO_WATERMARK_MAX_SAMPLES		232
 
 #define INV_ICM42600_REG_INT_CONFIG1			0x0064
 #define INV_ICM42600_INT_CONFIG1_TPULSE_DURATION	BIT(6)
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
index 87471e8c9bc7..2421de63f5bf 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
@@ -1187,8 +1187,9 @@ struct iio_dev *inv_icm42600_accel_init(struct inv_icm42600_state *st)
 	indio_dev->num_channels = ARRAY_SIZE(inv_icm42600_accel_channels);
 	indio_dev->available_scan_masks = inv_icm42600_accel_scan_masks;
 
-	ret = devm_iio_kfifo_buffer_setup(dev, indio_dev,
-					  &inv_icm42600_buffer_ops);
+	ret = devm_iio_kfifo_buffer_setup_ext(dev, indio_dev,
+					      &inv_icm42600_buffer_ops,
+					      inv_icm42600_buffer_attrs);
 	if (ret)
 		return ERR_PTR(ret);
 
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
index 26817158ec78..c3c2fbd8d9ce 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
@@ -10,9 +10,11 @@
 #include <linux/mutex.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
+#include <linux/stringify.h>
 
 #include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
 
 #include <linux/iio/common/inv_sensors_timestamp.h>
 
@@ -438,6 +440,40 @@ const struct iio_buffer_setup_ops inv_icm42600_buffer_ops = {
 	.postdisable = inv_icm42600_buffer_postdisable,
 };
 
+static ssize_t hwfifo_watermark_show(struct device *dev,
+				     struct device_attribute *attr,
+				     char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
+	unsigned int wm;
+
+	guard(mutex)(&st->lock);
+
+	if (indio_dev == st->indio_accel)
+		wm = st->fifo.watermark.eff_accel;
+	else if (indio_dev == st->indio_gyro)
+		wm = st->fifo.watermark.eff_gyro;
+	else
+		return -EINVAL;
+
+	return sysfs_emit(buf, "%u\n", wm);
+}
+
+IIO_STATIC_CONST_DEVICE_ATTR(hwfifo_watermark_min, "1");
+IIO_STATIC_CONST_DEVICE_ATTR(hwfifo_watermark_max,
+			     __stringify(INV_ICM42600_FIFO_WATERMARK_MAX_SAMPLES));
+static IIO_DEVICE_ATTR_RO(hwfifo_watermark, 0);
+IIO_STATIC_CONST_DEVICE_ATTR(hwfifo_enabled, "1");
+
+const struct iio_dev_attr *inv_icm42600_buffer_attrs[] = {
+	&iio_dev_attr_hwfifo_watermark_min,
+	&iio_dev_attr_hwfifo_watermark_max,
+	&iio_dev_attr_hwfifo_watermark,
+	&iio_dev_attr_hwfifo_enabled,
+	NULL
+};
+
 int inv_icm42600_buffer_fifo_read(struct inv_icm42600_state *st,
 				  unsigned int max)
 {
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h
index 6ab1eb1a0051..3b81dba4b7c4 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h
@@ -79,6 +79,7 @@ ssize_t inv_icm42600_fifo_decode_packet(const void *packet, const void **accel,
 					const void **timestamp, unsigned int *odr);
 
 extern const struct iio_buffer_setup_ops inv_icm42600_buffer_ops;
+extern const struct iio_dev_attr *inv_icm42600_buffer_attrs[];
 
 int inv_icm42600_buffer_init(struct inv_icm42600_state *st);
 
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
index ea8aa64a3f33..881612a8e92d 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
@@ -773,8 +773,9 @@ struct iio_dev *inv_icm42600_gyro_init(struct inv_icm42600_state *st)
 	indio_dev->available_scan_masks = inv_icm42600_gyro_scan_masks;
 	indio_dev->setup_ops = &inv_icm42600_buffer_ops;
 
-	ret = devm_iio_kfifo_buffer_setup(dev, indio_dev,
-					  &inv_icm42600_buffer_ops);
+	ret = devm_iio_kfifo_buffer_setup_ext(dev, indio_dev,
+					      &inv_icm42600_buffer_ops,
+					      inv_icm42600_buffer_attrs);
 	if (ret)
 		return ERR_PTR(ret);
 

-- 
2.54.0


