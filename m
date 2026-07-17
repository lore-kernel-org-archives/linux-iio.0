Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E5B3998B1;
	Fri, 17 Jul 2026 12:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784291994; cv=none; b=HB+1D1smz21c+7TTkpU4sF1YLTblynY9mrL88sqkpBIqrsla8mu28Xu45PpA54lW7T2ymKtZWta7twTOLTwXaHfUt8fkQK+bE+0FhpYeUP7mPFV/tNhXVthvM6ZX9FxDFTOw/J9Oj6M4zp+4rhKS+lEgqxydaQOg42F2gBH1hgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784291994; c=relaxed/simple;
	bh=QBDKufXgajqn4DtRASDavNy7maqfFljBFPBJkbiaTxI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TbNQJ85n5zZWq6NVYGRGyWrQt8avnrqtA4p0ArOiLRhUy+14+mB/OF8Qs2EFv4fJ34VKR40QUsBLF/xiDbvdUkxBKWq1fUhE3q7qeEUXQFwbtgdr/AJrJT+EBcnk60A0vGSm4neletDBFCiC37ZP1cXpZp2Ex4dVeiNxtqqTWWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=chREGJh8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="chREGJh8"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9FAB6C2BCB9;
	Fri, 17 Jul 2026 12:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784291994;
	bh=QBDKufXgajqn4DtRASDavNy7maqfFljBFPBJkbiaTxI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=chREGJh8YBCBRvApjUMA1YZa/PZDveX5pph97lLXEwoZT8nf8dBOe8vUkYaODE91M
	 EGNAEpe6FrkRJgYG56fZrI8+gKijvy6Jeyaj8GOTcj4Tudv6IBSF0vTvBsxa/yrhgn
	 WZabl9hzKAa4KMGEJIv9ErcMnoN/iy/LiUDCy7QpipQjaTK7/xCfihHCMQsJXFo2T8
	 H6FoXLkCRVHn3uREayX5X+AGJh9BV7Cq/XVxW2V69dzcnJfd47E0G6FvfATUr9eXiM
	 Jg61V7kWtPvFH/WQo89aTLjwEb3h4UptrlOKW5R4L9cM8upSQihuR7rH+tvzw+VTnq
	 9blS1K+EU/y+g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C68EC4451C;
	Fri, 17 Jul 2026 12:39:54 +0000 (UTC)
From: Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Date: Fri, 17 Jul 2026 14:39:40 +0200
Subject: [PATCH 1/2] iio: invensense: better timestamp alignment when using
 watermark
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260717-iio-common-inv-sensors-timestamp-rework-v1-1-d1afee2805cd@tdk.com>
References: <20260717-iio-common-inv-sensors-timestamp-rework-v1-0-d1afee2805cd@tdk.com>
In-Reply-To: <20260717-iio-common-inv-sensors-timestamp-rework-v1-0-d1afee2805cd@tdk.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784291993; l=4319;
 i=jean-baptiste.maneyrol@tdk.com; s=20240923; h=from:subject:message-id;
 bh=CuzodI1iMOle4XQ64WKBjQvz2G3+BooQH4bpQ3wpLYY=;
 b=/zIaFrKHQx02nZE4pfeN8YFFlpvMXtgarZijbCKBcAVviuDEV488UHT2RTDIcmP/K7m5Dm7OT
 og81yPFMwmMCb1hm7c0wjsnrOs3VVDj48Pp1O40cllGlhww3LkLvMOB
X-Developer-Key: i=jean-baptiste.maneyrol@tdk.com; a=ed25519;
 pk=bRqF1WYk0hR3qrnAithOLXSD0LvSu8DUd+quKLxCicI=
X-Endpoint-Received: by B4 Relay for
 jean-baptiste.maneyrol@tdk.com/20240923 with auth_id=218
X-Original-From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Reply-To: jean-baptiste.maneyrol@tdk.com

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

Current interrupt timestamp alignment only change the next coming
timestamp. For watermark where we have a batch of samples per
interrupt, it doesn't manage to align timestamp since modification
is limited because of jitter.

Implement a better version that instead modify the period to align
to interrupt timestamp. Period is now computed by align timestamp
if interrupt interval is valid, or we use the computed estimation.

Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
 .../iio/common/inv_sensors/inv_sensors_timestamp.c | 55 ++++++++--------------
 1 file changed, 20 insertions(+), 35 deletions(-)

diff --git a/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c b/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
index e0b10366ed2b..2c89e0edc87d 100644
--- a/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
+++ b/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
@@ -10,9 +10,7 @@
 
 #include <linux/iio/common/inv_sensors_timestamp.h>
 
-/* compute jitter, min and max following jitter in per mille */
-#define INV_SENSORS_TIMESTAMP_JITTER(_val, _jitter)		\
-	(div_s64((_val) * (_jitter), 1000))
+/* compute min and max following jitter in per mille */
 #define INV_SENSORS_TIMESTAMP_MIN(_val, _jitter)		\
 	(((_val) * (1000 - (_jitter))) / 1000)
 #define INV_SENSORS_TIMESTAMP_MAX(_val, _jitter)		\
@@ -102,34 +100,22 @@ static bool inv_update_chip_period(struct inv_sensors_timestamp *ts,
 	/* update chip internal period estimation */
 	new_chip_period = period / ts->mult;
 	inv_update_acc(&ts->chip_period, new_chip_period);
-	ts->period = ts->mult * ts->chip_period.val;
 
 	return true;
 }
 
-static void inv_align_timestamp_it(struct inv_sensors_timestamp *ts)
+static uint32_t inv_align_timestamp_it(struct inv_sensors_timestamp *ts,
+				       unsigned int sample_nb)
 {
-	const int64_t period_min = (int64_t)ts->min_period * ts->mult;
-	const int64_t period_max = (int64_t)ts->max_period * ts->mult;
-	int64_t add_max, sub_max;
-	int64_t delta, jitter;
-	int64_t adjust;
-
-	/* delta time between last sample and last interrupt */
-	delta = ts->it.lo - ts->timestamp;
-
-	/* adjust timestamp while respecting jitter */
-	add_max = period_max - (int64_t)ts->period;
-	sub_max = period_min - (int64_t)ts->period;
-	jitter = INV_SENSORS_TIMESTAMP_JITTER((int64_t)ts->period, ts->chip.jitter);
-	if (delta > jitter)
-		adjust = add_max;
-	else if (delta < -jitter)
-		adjust = sub_max;
-	else
-		adjust = 0;
+	const uint64_t period_min = (uint64_t)ts->min_period * ts->mult;
+	const uint64_t period_max = (uint64_t)ts->max_period * ts->mult;
+	uint32_t new_period;
 
-	ts->timestamp += adjust;
+	/* compute new period aligning last timestamp with interrupt timestamp */
+	new_period = div_s64(ts->it.up - ts->timestamp, sample_nb);
+
+	/* ensure that period never overflows the jitter */
+	return clamp(new_period, period_min, period_max);
 }
 
 void inv_sensors_timestamp_interrupt(struct inv_sensors_timestamp *ts,
@@ -143,6 +129,13 @@ void inv_sensors_timestamp_interrupt(struct inv_sensors_timestamp *ts,
 	if (sample_nb == 0)
 		return;
 
+	/* no previous data, compute theoretical value from interrupt */
+	if (ts->timestamp == 0) {
+		/* elapsed time: sensor period * sensor samples number */
+		interval = (int64_t)ts->period * (int64_t)sample_nb;
+		ts->timestamp = timestamp - interval;
+	}
+
 	/* update interrupt timestamp and compute chip and sensor periods */
 	it = &ts->it;
 	it->lo = it->up;
@@ -154,17 +147,9 @@ void inv_sensors_timestamp_interrupt(struct inv_sensors_timestamp *ts,
 		valid = inv_update_chip_period(ts, period);
 	}
 
-	/* no previous data, compute theoretical value from interrupt */
-	if (ts->timestamp == 0) {
-		/* elapsed time: sensor period * sensor samples number */
-		interval = (int64_t)ts->period * (int64_t)sample_nb;
-		ts->timestamp = it->up - interval;
-		return;
-	}
-
 	/* if interrupt interval is valid, sync with interrupt timestamp */
-	if (valid)
-		inv_align_timestamp_it(ts);
+	ts->period = valid ? inv_align_timestamp_it(ts, sample_nb) :
+			     ts->mult * ts->chip_period.val;
 }
 EXPORT_SYMBOL_NS_GPL(inv_sensors_timestamp_interrupt, "IIO_INV_SENSORS_TIMESTAMP");
 

-- 
2.54.0


