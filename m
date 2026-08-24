Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173B741A4E4;
	Mon, 24 Aug 2026 12:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787574697; cv=none; b=Lvb3sC4873ouwPwAGfGhDSIqklUAJMhAITAYOC6MnTgocCteNDQV3GkE54ijuHAR8CeOW/MLf0d3nxNE2ncDHYQF9202jfNH6ApzNV8Tx6p7OJOzwmwPXx4+gDipStV1smZso7tO8RltqNRx1c4Bz0zGGpOFmeIhCN+8b4OAdyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787574697; c=relaxed/simple;
	bh=QVG2mL9l4+6bwR+PJ1wuVD2fZla4HMp8DiPKeNhew0s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BdPXiVLXpLqFPwQWPW0ikn7KAS/HnxUQpov9r0xwDVV8jENsSkrjFGfMTpLl14wo6Drv+MhVgqYPhKYEq7Fwr11nmVXpldbR2IsYxkSJIo5hTVM+W/9aerK0j1c1pFTZPb87F5/dZ7Q3UF8/sDSEhBYg3hU/w5yyjjcVsDmOKvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LeYLJfY2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LeYLJfY2"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C3755C2BCFA;
	Mon, 24 Aug 2026 12:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787574696;
	bh=QVG2mL9l4+6bwR+PJ1wuVD2fZla4HMp8DiPKeNhew0s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=LeYLJfY20XwHYh/RTsT8lxkoXP+DX/i3q72/3bdBLUV/Rq+Sexhwn3yEeR1PllVsN
	 uvuwDIQl1BqGJqffCzqv0D9CQZnGCAJkJRKhM/M0gwzfMvG2fkVEaSWxcDIYEJUC9K
	 yvW89GzEYauI/1VM/ccJdjX0j7DF1zfRLmo08hRvlWJL061x+F9jhFzTE8JcaCRF6e
	 wcGJ0dqxF8xzSdRDzm8ukiBtQnRsGvcK3DxOP147uIBA94JWDnKZKV5G11kzHlv8dU
	 8y+UKEDludfKyndtr6OVplabKFZ2Dcsfgvfcpn9yCMox1zg3rl7uhqplwFIS86tQSw
	 68Fhle2WfKDFQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A96C5DF9C;
	Mon, 24 Aug 2026 12:31:36 +0000 (UTC)
From: Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Date: Mon, 24 Aug 2026 14:30:08 +0200
Subject: [PATCH v2 2/4] iio: imu: inv_icm42600: use 2 sensors fixed packet
 size of 16 bytes
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-inv-icm42600-enhacements-v2-2-0040837fde12@tdk.com>
References: <20260824-inv-icm42600-enhacements-v2-0-0040837fde12@tdk.com>
In-Reply-To: <20260824-inv-icm42600-enhacements-v2-0-0040837fde12@tdk.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, 
 Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787574695; l=3984;
 i=jean-baptiste.maneyrol@tdk.com; s=20240923; h=from:subject:message-id;
 bh=mNAm8b4ddHbtiXu6xptZFNN+mbbMV5qtuBUPJ1NmHtE=;
 b=ZuL4YPV/Xrq9Y1ehBN8r95BCijfBgaf7uje8Z6cxyKE8/kyyF+rXybR/Rwpg67vtZII0mU03c
 AIZDCoUZ2evA0V3QOd8Gzpi15ViqRuJLt1WM9X5J4CKnZmf5WKR8RGl
X-Developer-Key: i=jean-baptiste.maneyrol@tdk.com; a=ed25519;
 pk=bRqF1WYk0hR3qrnAithOLXSD0LvSu8DUd+quKLxCicI=
X-Endpoint-Received: by B4 Relay for
 jean-baptiste.maneyrol@tdk.com/20240923 with auth_id=218
X-Original-From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Reply-To: jean-baptiste.maneyrol@tdk.com

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

Sometimes dynamic switch between 1 sensor frame to 2 sensors frame is
not working when there are too much frames already in the FIFO. By
moving accel/gyro on sleep before turning FIFO on, we are storing many
FIFO frames before updating the frame format hitting the bug everytime.

Fix that by always using the 2 sensors frame of 16 bytes. Also update
the hwfifo max watermark reported.

Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600.h        |  4 +--
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c | 34 ++++++++--------------
 2 files changed, 14 insertions(+), 24 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
index b55d993f0264..f6c7c84c7e45 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600.h
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
@@ -356,8 +356,8 @@ struct inv_icm42600_sensor_state {
 		cpu_to_le16((_wm) & GENMASK(11, 0))
 /* FIFO is 2048 bytes, let 12 samples for reading latency */
 #define INV_ICM42600_FIFO_WATERMARK_MAX			(2048 - 12 * 16)
-/* INV_ICM42600_FIFO_WATERMARK_MAX / 8 = 232 */
-#define INV_ICM42600_FIFO_WATERMARK_MAX_SAMPLES		232
+/* INV_ICM42600_FIFO_WATERMARK_MAX / 16 = 116 */
+#define INV_ICM42600_FIFO_WATERMARK_MAX_SAMPLES		116
 
 #define INV_ICM42600_REG_INT_CONFIG1			0x0064
 #define INV_ICM42600_INT_CONFIG1_TPULSE_DURATION	BIT(6)
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
index 998d312f7bde..5421122057ee 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
@@ -131,13 +131,16 @@ int inv_icm42600_buffer_set_fifo_en(struct inv_icm42600_state *st,
 		INV_ICM42600_FIFO_CONFIG1_GYRO_EN |
 		INV_ICM42600_FIFO_CONFIG1_ACCEL_EN;
 
-	val = 0;
-	if (fifo_en & INV_ICM42600_SENSOR_GYRO)
-		val |= INV_ICM42600_FIFO_CONFIG1_GYRO_EN;
-	if (fifo_en & INV_ICM42600_SENSOR_ACCEL)
-		val |= INV_ICM42600_FIFO_CONFIG1_ACCEL_EN;
-	if (fifo_en & INV_ICM42600_SENSOR_TEMP)
-		val |= INV_ICM42600_FIFO_CONFIG1_TEMP_EN;
+	/*
+	 * Always enable/disable all bits to ensure we can flawlessly add
+	 * accel/gyro data in the FIFO while it is running.
+	 */
+	if (fifo_en)
+		val = INV_ICM42600_FIFO_CONFIG1_TEMP_EN |
+		      INV_ICM42600_FIFO_CONFIG1_GYRO_EN |
+		      INV_ICM42600_FIFO_CONFIG1_ACCEL_EN;
+	else
+		val = 0;
 
 	ret = regmap_update_bits(st->map, INV_ICM42600_REG_FIFO_CONFIG1, mask, val);
 	if (ret)
@@ -149,19 +152,6 @@ int inv_icm42600_buffer_set_fifo_en(struct inv_icm42600_state *st,
 	return 0;
 }
 
-static size_t inv_icm42600_get_packet_size(unsigned int fifo_en)
-{
-	size_t packet_size;
-
-	if ((fifo_en & INV_ICM42600_SENSOR_GYRO) &&
-	    (fifo_en & INV_ICM42600_SENSOR_ACCEL))
-		packet_size = INV_ICM42600_FIFO_2SENSORS_PACKET_SIZE;
-	else
-		packet_size = INV_ICM42600_FIFO_1SENSOR_PACKET_SIZE;
-
-	return packet_size;
-}
-
 static unsigned int inv_icm42600_wm_truncate(unsigned int watermark,
 					     size_t packet_size)
 {
@@ -209,7 +199,7 @@ int inv_icm42600_buffer_update_watermark(struct inv_icm42600_state *st)
 	__le16 raw_wm;
 	int ret;
 
-	packet_size = inv_icm42600_get_packet_size(st->fifo.en);
+	packet_size = INV_ICM42600_FIFO_2SENSORS_PACKET_SIZE;
 
 	/* compute sensors latency, depending on sensor watermark and odr */
 	wm_gyro = inv_icm42600_wm_truncate(st->fifo.watermark.gyro, packet_size);
@@ -495,7 +485,7 @@ int inv_icm42600_buffer_fifo_read(struct inv_icm42600_state *st,
 	/* compute maximum FIFO read size (watermark for max = 0 interrupt case) */
 	if (max == 0)
 		max = st->fifo.watermark.value;
-	max_count = max * inv_icm42600_get_packet_size(st->fifo.en);
+	max_count = max * INV_ICM42600_FIFO_2SENSORS_PACKET_SIZE;
 
 	/* read FIFO count value */
 	raw_fifo_count = (__be16 *)st->buffer;

-- 
2.55.0


