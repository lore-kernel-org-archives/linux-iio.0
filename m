Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A9337F8DA;
	Thu, 20 Aug 2026 19:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787252564; cv=none; b=H9/dQI4CumukZKUIIj3xRGj/x/VrpEkEvQJiey9+vlNsdYZneIOIHQAPsjWYrkA2ue9MOXpXPx3EwXnoOxkIWCT7oJcnWYtBcV9Az52M8rrOuMqxqfVY6C2ehYju4pjO0u9y9A/vZrnqHSiGJ1ql9Tgag7XgLVkHWHcpmabH+fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787252564; c=relaxed/simple;
	bh=W9WzyYMOrIHWPalTMijgMMlFoiy6Z9oo9VFEI+WQ96M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=epF1eCL8Il0fTXOAI17jS0FeZPcA1bC8+YR6CxJEtS7CMYL/V9Tt+OtirJl+aHjOvXcInuj0TSnERy+fFhgmsuNpugVYH+de0Llk5pLXcfBMEj5zmtHu+PqGjnFxOYDUBI8Hk5d5gaHuXoqat8/B06iDuSpxhnuFvh0hZWfO5LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GNudyh4a; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GNudyh4a"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2FD85C2BD01;
	Thu, 20 Aug 2026 19:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787252564;
	bh=W9WzyYMOrIHWPalTMijgMMlFoiy6Z9oo9VFEI+WQ96M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=GNudyh4aU95XCUSkxUpUx9Ye6JHg76zGF3c2ImtXNQEzZInU4rrJhZdjq4P+akWSt
	 NpjZRXwIvf1dmY/lDQLMuVJQWQmMfxth+jUox59YBgs4H6xhQTBPMNE7SwtVllzkV8
	 MWoJp6RsRF1FoN2aIEHJyfg3WjP74ydlL7wqMRXhRLkbBnEHEQ/bwC+b+4acA/rCSM
	 hXDpWqOSao6+ugOKiGX7EgDXCYRSZ6kVXsvCxwBRGqyRfuJCpbq/fbkc43Hw+qr/xc
	 taG2Urn7iCiYpukPpC4JlDbGxHLuJq9wiqaEXuR/mgE+NjNlsH2i4oeb67jhM7QWrc
	 0/M/5tGPczvSA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C398C5DF8E;
	Thu, 20 Aug 2026 19:02:44 +0000 (UTC)
From: Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Date: Thu, 20 Aug 2026 21:02:40 +0200
Subject: [PATCH 4/4] iio: imu: inv_icm42600: do not read FIFO count for
 watermark it
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260820-inv-icm42600-enhacements-v1-4-075a881db557@tdk.com>
References: <20260820-inv-icm42600-enhacements-v1-0-075a881db557@tdk.com>
In-Reply-To: <20260820-inv-icm42600-enhacements-v1-0-075a881db557@tdk.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, 
 Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787252562; l=2268;
 i=jean-baptiste.maneyrol@tdk.com; s=20240923; h=from:subject:message-id;
 bh=OQmQVi4yJ7lu/WvxADoFhgDSPCmfaq3lgsQjBlIiMZo=;
 b=0NCK0EjmfbIqD3uY37VDeTKqiWGqEGfKSkBe6nBp2xvo0aFvRx1fwMmbFe7DbuSnLaq31+GPU
 zHEwQo7Fp/nDmacOz6dhgNo95FOHblt5Ci8yi6FOWW4Y2PVjI8n3u5K
X-Developer-Key: i=jean-baptiste.maneyrol@tdk.com; a=ed25519;
 pk=bRqF1WYk0hR3qrnAithOLXSD0LvSu8DUd+quKLxCicI=
X-Endpoint-Received: by B4 Relay for
 jean-baptiste.maneyrol@tdk.com/20240923 with auth_id=218
X-Original-From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Reply-To: jean-baptiste.maneyrol@tdk.com

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

Optimize data reading for high frequencies by not reading FIFO
count in case of watermark interrupt. We already know there is
watermark samples in the FIFO and we need to not read more than
watermark samples for timestamping mechanism. Let's just read FIFO
data directly without reading FIFO count in this case.

Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c | 33 ++++++++++------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
index 1428f18408ce..1410096f6e6d 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
@@ -474,24 +474,21 @@ int inv_icm42600_buffer_fifo_read(struct inv_icm42600_state *st,
 	st->fifo.nb.accel = 0;
 	st->fifo.nb.total = 0;
 
-	/* compute maximum FIFO read size (watermark for max = 0 interrupt case) */
-	if (max == 0)
-		max = st->fifo.watermark.value;
-	max_count = max * INV_ICM42600_FIFO_2SENSORS_PACKET_SIZE;
-
-	/* read FIFO count value */
-	raw_fifo_count = (__be16 *)st->buffer;
-	ret = regmap_bulk_read(st->map, INV_ICM42600_REG_FIFO_COUNT,
-			       raw_fifo_count, sizeof(*raw_fifo_count));
-	if (ret)
-		return ret;
-	st->fifo.count = be16_to_cpup(raw_fifo_count);
-
-	/* check and clamp FIFO count value */
-	if (st->fifo.count == 0)
-		return 0;
-	if (st->fifo.count > max_count)
-		st->fifo.count = max_count;
+	/* read watermark samples for interrupt case (max = 0) or read FIFO count */
+	if (max == 0) {
+		st->fifo.count = st->fifo.watermark.value *
+				 INV_ICM42600_FIFO_2SENSORS_PACKET_SIZE;
+	} else {
+		raw_fifo_count = (__be16 *)st->buffer;
+		ret = regmap_bulk_read(st->map, INV_ICM42600_REG_FIFO_COUNT,
+					raw_fifo_count, sizeof(*raw_fifo_count));
+		if (ret)
+			return ret;
+		max_count = max * INV_ICM42600_FIFO_2SENSORS_PACKET_SIZE;
+		st->fifo.count = min(be16_to_cpup(raw_fifo_count), max_count);
+		if (st->fifo.count == 0)
+			return 0;
+	}
 
 	/* read all FIFO data in internal buffer */
 	ret = regmap_noinc_read(st->map, INV_ICM42600_REG_FIFO_DATA,

-- 
2.55.0


