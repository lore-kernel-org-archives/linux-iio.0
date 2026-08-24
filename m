Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136EA4195DA;
	Mon, 24 Aug 2026 12:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787574697; cv=none; b=kfdzS3mcLCxjDtvTZn3TqN12ySTeCAMgjySCftlFdR4JlW5CgWL9XGwMz8q8ah/jGJgnbblvZ5P1d4F6WIiZLGCX4gz7vKfkrlfQ2U6ATGJBLM5guhu2X1bu5GPwrHH6Rx1eN5Vhb5u1hn3rLJbTfgvVv0u20GlPRf4FFI2JpGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787574697; c=relaxed/simple;
	bh=zh7Rco5/rcIpTtHldYR1Wtd48uDL2MN7LmZkjJu263Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Svw488Bk70YqWvECHqdHiayBpTSLoZ5F0wV4BZIYPv7qsWOY2rrVRWx8HbggcDTEQRYtznQFZ3kS5O5ubNSEXFqZbmRbE5KZdUWtzQThYQwT0/+ra6fFefWsaJDpbM4HwTC2XKAHG9lVT/69behPjHzcOrGsOzdKbhZyA6mROZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A4XKQcrz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A4XKQcrz"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CC80BC2BCFD;
	Mon, 24 Aug 2026 12:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787574696;
	bh=zh7Rco5/rcIpTtHldYR1Wtd48uDL2MN7LmZkjJu263Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=A4XKQcrzwbGjrVtSlfcy07oYR2+HHpysuIhimdWG95Gs8JLiR1Xmvg89lC70tj2fX
	 EJtgWG7o6/s76GhvaEjH1j89XcZxEVOaOgMWNFHhmy6gaI/6MJ/Rb7dYjIMcYpx8zQ
	 mWTW823yTHXXmdfwU6o+K3QJI7zzA3e3GQscfRpRDbJJJAF66QL4hDrObQ+4E3FBMS
	 t9PwHOCGvpJzhUg4rKT7R/xeRPYE/BK/qNsHp+cr+iw6w+4dUg4xy766kgelFtdHZA
	 lEzxSCCINWrJIVUul0ifuQx23DxLGilVFYLb7tQB8/Crl7qRhF8hv3lu8ckAf0FhWS
	 nUWkbGh97duhg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C00C5DF94;
	Mon, 24 Aug 2026 12:31:36 +0000 (UTC)
From: Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Date: Mon, 24 Aug 2026 14:30:09 +0200
Subject: [PATCH v2 3/4] iio: imu: inv_icm42600: simplify watermark
 computation by using GCD
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-inv-icm42600-enhacements-v2-3-0040837fde12@tdk.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787574695; l=4544;
 i=jean-baptiste.maneyrol@tdk.com; s=20240923; h=from:subject:message-id;
 bh=w5ahhNMA8cXSfMKpbubZjHPf7yCjR67wSh0jwhlYIrU=;
 b=PmKyqFklwTcYKXeF9TWpEI2eb+9t2fmQb8+oi1GHMPDy8zgiA58BaD6yyi1O9sNNfrHFX1mfh
 YqYtIr34fTECKR0ZHKwWOmaKkvxKN5RM6oHOqmQKj2OZosMXYCECaAC
X-Developer-Key: i=jean-baptiste.maneyrol@tdk.com; a=ed25519;
 pk=bRqF1WYk0hR3qrnAithOLXSD0LvSu8DUd+quKLxCicI=
X-Endpoint-Received: by B4 Relay for
 jean-baptiste.maneyrol@tdk.com/20240923 with auth_id=218
X-Original-From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Reply-To: jean-baptiste.maneyrol@tdk.com

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

The watermark computation was in fact resulting in computing the GCD
of the latencies when both sensors are on. GCD is required because
of the IIO buffer watermark.

Move to use gcd() and update documentation accordingly.

Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c | 47 ++++++++++------------
 1 file changed, 21 insertions(+), 26 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
index 5421122057ee..b1a43ca610c4 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
@@ -5,6 +5,7 @@
 
 #include <linux/delay.h>
 #include <linux/device.h>
+#include <linux/gcd.h>
 #include <linux/kernel.h>
 #include <linux/minmax.h>
 #include <linux/mutex.h>
@@ -175,15 +176,14 @@ static unsigned int inv_icm42600_wm_truncate(unsigned int watermark,
  *
  * FIFO watermark threshold is computed based on the required watermark values
  * set for gyro and accel sensors. Since watermark is all about acceptable data
- * latency, use the smallest setting between the 2. It means choosing the
- * smallest latency but this is not as simple as choosing the smallest watermark
- * value. Latency depends on watermark and ODR. It requires several steps:
- * 1) compute gyro and accel latencies and choose the smallest value.
- * 2) adapt the chosen latency so that it is a multiple of both gyro and accel
- *    ones. Otherwise it is possible that you don't meet a requirement. (for
- *    example with gyro @100Hz wm 4 and accel @100Hz with wm 6, choosing the
- *    value of 4 will not meet accel latency requirement because 6 is not a
- *    multiple of 4. You need to use the value 2.)
+ * latency, we should need to use the smallest latency value. But it is not as
+ * simple as choosing the smallest watermark value. Latency depends on watermark
+ * and ODR and IIO buffer watermark adds another requirement. The required steps:
+ * 1) compute gyro and accel periods and latencies
+ * 2) Use the smallest period and the GCD of the latencies. GCD is required
+ *    because of the IIO buffer watermark that will prevent send of data if not
+ *    crossed. Thus accel and gyro watermarks must be a multiple of the watermark
+ *    value. Computing the GCD gives us the biggest value that meets this criteria.
  * 3) Since all periods are multiple of each others, watermark is computed by
  *    dividing this computed latency by the smallest period, which corresponds
  *    to the FIFO frequency. Beware that this is only true because we are not
@@ -193,7 +193,7 @@ int inv_icm42600_buffer_update_watermark(struct inv_icm42600_state *st)
 {
 	size_t packet_size, wm_size;
 	unsigned int wm_gyro, wm_accel, watermark;
-	u32 period_gyro, period_accel;
+	u32 period_gyro, period_accel, period;
 	u32 latency_gyro, latency_accel, latency;
 	bool restore;
 	__le16 raw_wm;
@@ -221,22 +221,17 @@ int inv_icm42600_buffer_update_watermark(struct inv_icm42600_state *st)
 		watermark = wm_gyro;
 		st->fifo.watermark.eff_gyro = wm_gyro;
 	} else {
-		/* compute the smallest latency that is a multiple of both */
-		if (latency_gyro <= latency_accel)
-			latency = latency_gyro - (latency_accel % latency_gyro);
-		else
-			latency = latency_accel - (latency_gyro % latency_accel);
-		/* all this works because periods are multiple of each others */
-		watermark = latency / min(period_gyro, period_accel);
-		if (watermark < 1)
-			watermark = 1;
-		/* update effective watermark */
-		st->fifo.watermark.eff_gyro = latency / period_gyro;
-		if (st->fifo.watermark.eff_gyro < 1)
-			st->fifo.watermark.eff_gyro = 1;
-		st->fifo.watermark.eff_accel = latency / period_accel;
-		if (st->fifo.watermark.eff_accel < 1)
-			st->fifo.watermark.eff_accel = 1;
+		/*
+		 * In case of both accel and gyro enabled, we need to use the
+		 * shortest period and the gcd of the latencies. Gcd is required
+		 * because of the IIO buffer watermark that will prevent data
+		 * sending if we are not crossing the watermark level.
+		 */
+		period = min(period_gyro, period_accel);
+		latency = gcd(latency_gyro, latency_accel);
+		watermark = max(latency / period, 1);
+		st->fifo.watermark.eff_gyro = max(latency / period_gyro, 1);
+		st->fifo.watermark.eff_accel = max(latency / period_accel, 1);
 	}
 
 	/* compute watermark value in bytes */

-- 
2.55.0


