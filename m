Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B1D3803DD;
	Thu, 20 Aug 2026 19:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787252564; cv=none; b=XDBERQthiUfw6GqGXaWsq9QxGb6xxxvFfWM8kxRx9R93+jmlr/05ehgHg4YgfIiG6HeqIjSsEURT6gDqIwUOH1v8fATFzo8SqdCvi6036eJ/gU2OxeLwnz3kXyo67zZV5QHo7+OF/7MgurKX6Ruc0XLF73+NAUtvZqYW2E0/p1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787252564; c=relaxed/simple;
	bh=rDMx9sIWGeeq9a56wl+tBY6uR9IDxUaz0FHi+kPxOxI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sr2L3lH8T8uNFV2TzcDAY+74CkjsTGmlW1wQoV2HF2t1wOho/6FtXkrdwVTha3/pGewT3DybHL7LX3hGBXYzGc2fE2FK5MkoTPJaTzAUyCw0ajNNcEfjxIw8JPtLZ3AUOgnbLEXsQ3qiVsNGRMZ66XOdOYivhMWdXewXboFYkSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C7nQ4VMl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C7nQ4VMl"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 239A5C2BCFB;
	Thu, 20 Aug 2026 19:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787252564;
	bh=rDMx9sIWGeeq9a56wl+tBY6uR9IDxUaz0FHi+kPxOxI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=C7nQ4VMlin0xstnLLrqY+9czwaNE3oQvpSY7uzH/bSxJzExeJVnZTyzml4hoTbjHK
	 YT7+O1M78z166OIaKNvqUdMCVMWEjKZvMHW8bWhF3IIV7QCo8xlStTsSGxF3St0JB5
	 kEi80RrxWuUBxY/+KuIB7TCLMhkYeldP9MoXSh4y7Q8Nu2CRh1pSQrByF/DIX9l649
	 4Q0Z+X0lE1aYVCvKI292jit0cZ3ihZ2C+6IRKWtU9YJMyJ9hEhsiyn69vglPljq3AA
	 MxRhq3uhjJCGPKsw1Jl9zMnbbLB2NkRH6RgorEsLZIlqfcPBitd3eMwKnn045CGvLq
	 EDvPx2K9M0hJg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0967AC5DF81;
	Thu, 20 Aug 2026 19:02:44 +0000 (UTC)
From: Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Date: Thu, 20 Aug 2026 21:02:39 +0200
Subject: [PATCH 3/4] iio: imu: inv_icm42600: simplify watermark computation
 by using gcd
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260820-inv-icm42600-enhacements-v1-3-075a881db557@tdk.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787252562; l=4645;
 i=jean-baptiste.maneyrol@tdk.com; s=20240923; h=from:subject:message-id;
 bh=bwjlmqmiKOXuuvGZcZK9+89VfoFOSDBn/75xuRvm4m8=;
 b=HCkBJxq7pHZwLvEyJrwdC5vX29IfILXzM2Lw+kKIyONM+hwKEgDpkfX192Z+LZoEFC2Fi029d
 a785lHuNu7jAacpP18AeH70iUoEhtnnTUenqcdNCf29gCGc0vHI0nYG
X-Developer-Key: i=jean-baptiste.maneyrol@tdk.com; a=ed25519;
 pk=bRqF1WYk0hR3qrnAithOLXSD0LvSu8DUd+quKLxCicI=
X-Endpoint-Received: by B4 Relay for
 jean-baptiste.maneyrol@tdk.com/20240923 with auth_id=218
X-Original-From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Reply-To: jean-baptiste.maneyrol@tdk.com

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

The watermark computation was in fact resulting in computing the gcd
of the latencies when both sensors are on. Gcd is required because
of the IIO buffer watermark. We need to use a divider of IIO buffer
watermark, otherwise we will overflow the requested watermark.

Move to use gcd and update documentation accordingly.

Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c | 47 ++++++++++------------
 1 file changed, 21 insertions(+), 26 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
index 043ae9deee65..1428f18408ce 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
@@ -5,6 +5,7 @@
 
 #include <linux/delay.h>
 #include <linux/device.h>
+#include <linux/gcd.h>
 #include <linux/kernel.h>
 #include <linux/minmax.h>
 #include <linux/mutex.h>
@@ -172,15 +173,14 @@ static unsigned int inv_icm42600_wm_truncate(unsigned int watermark,
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
+ * 2) Use the smallest period and the gcd of the latencies. Gcd is required
+ *    because of the IIO buffer watermark that will prevent send of data if not
+ *    crossed. Thus accel and gyro watermarks must be a multiple of the watermark
+ *    value. Computing the gcd gives us the biggest value that meets this criteria.
  * 3) Since all periods are multiple of each others, watermark is computed by
  *    dividing this computed latency by the smallest period, which corresponds
  *    to the FIFO frequency. Beware that this is only true because we are not
@@ -190,7 +190,7 @@ int inv_icm42600_buffer_update_watermark(struct inv_icm42600_state *st)
 {
 	size_t packet_size, wm_size;
 	unsigned int wm_gyro, wm_accel, watermark;
-	u32 period_gyro, period_accel;
+	u32 period_gyro, period_accel, period;
 	u32 latency_gyro, latency_accel, latency;
 	bool restore;
 	__le16 raw_wm;
@@ -218,22 +218,17 @@ int inv_icm42600_buffer_update_watermark(struct inv_icm42600_state *st)
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


