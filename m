Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E12419FD2;
	Mon, 24 Aug 2026 12:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787574697; cv=none; b=jDxImEN2jey6RNYuhxEJpt93mGYOJR8uoPTTRqjQmcHgqbiMURbJg7CzzI1BHGQYMdF9WgERiywDwAZJO/E0hTq3OwfQnKOtIZqrmJ8Zq+5gkXAiRqWQG0IXGCqGWgW4q8TNyiEIhv1DV1xRQlY4HnQ9T8WfNchGI9m6RpJSfCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787574697; c=relaxed/simple;
	bh=HXue9k6IGMoL9cs3zdJLOVXFVMKEHYebO+iwEOkq7l4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eE56kK/9UIJAtRWnyRr2BU9W+Ax2xZQGxzzM8bc9PVXMjOtFPoEBEqmDwV4etO8vZcQgUya4Hn5I8r0Z5pVYbzGwN826Zv2H/AWYeZF91o10O24/EE5NJDP51N0iTlnBiGGk1Mp/L08rQ10KqYsfFF5AJEMOKIQw2X+ptKZwysY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vNxgjI29; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vNxgjI29"
Received: by smtp.kernel.org (Postfix) with ESMTPS id DF307C2BCFF;
	Mon, 24 Aug 2026 12:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787574696;
	bh=HXue9k6IGMoL9cs3zdJLOVXFVMKEHYebO+iwEOkq7l4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=vNxgjI29kyE94mqpZ/T9diRZJiu2pB9WDShGmEN2+agR+VVFIVNTPsIJqFYg4S4zX
	 oJJ/poWn2V0FWru62csIe4SN8xLV0yTviZzjWMnXnycycGJT7CyS4VGULVHXoRAYcO
	 Rm541Sb1gs3GvG+vu06xSTt8flDHFCKCeJ80ptBIJnXy/m0nqhDQKtTRfAE0wyzMFW
	 AbbtKJ0t2N92JNcmiprNncbDILKic00pn0b19qsqZVS04xU0G8iAnNcay7YHs6bomW
	 JHumbHiVG/WgFhxblzq5sr/klAZSWoDOOLYsuWlDDxYkoaLrNqJ+IcssWoEjtRUeH/
	 RID040JlS1kAw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C88CCC61DB4;
	Mon, 24 Aug 2026 12:31:36 +0000 (UTC)
From: Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Date: Mon, 24 Aug 2026 14:30:10 +0200
Subject: [PATCH v2 4/4] iio: imu: inv_icm42600: do not read FIFO count for
 watermark it
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-inv-icm42600-enhacements-v2-4-0040837fde12@tdk.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787574695; l=2389;
 i=jean-baptiste.maneyrol@tdk.com; s=20240923; h=from:subject:message-id;
 bh=Zm48u8KCXMBBkgQlt9czWfmZZ/N82LVph63qdI2PIO8=;
 b=azF5mX7dKXNNp3nyza0VdYJVC4Oo+5WI61bcFnkrbd8vQqx9RXLHAvJHwZNqLy/Cc6VyU3Rzg
 XNt//0Z58zdD/qh5KWJkNhPxeAZvO4kk2m2Gv5D+Asl/GXhsrXBNWtx
X-Developer-Key: i=jean-baptiste.maneyrol@tdk.com; a=ed25519;
 pk=bRqF1WYk0hR3qrnAithOLXSD0LvSu8DUd+quKLxCicI=
X-Endpoint-Received: by B4 Relay for
 jean-baptiste.maneyrol@tdk.com/20240923 with auth_id=218
X-Original-From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Reply-To: jean-baptiste.maneyrol@tdk.com

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

Optimize data reading for high frequencies by not reading FIFO
count in case of watermark interrupt.

We cannot already read more than watermark samples because of the
timestamping mechanism. It is required to not perturb the timing
between the watermark interrupts. Since we also know there is at
least watermark samples in the FIFO, let's just read these watermark
FIFO samples directly without reading FIFO count in this case.

Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c | 33 ++++++++++------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
index b1a43ca610c4..ded45dfe46a2 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
@@ -477,24 +477,21 @@ int inv_icm42600_buffer_fifo_read(struct inv_icm42600_state *st,
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


