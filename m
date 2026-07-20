Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914293D810D;
	Mon, 20 Jul 2026 10:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784543938; cv=none; b=ke7zCHkGmu0+enqYGC6sudf4Khx7uF2/uSYkkdaNv1qxJ9+IFmYDtq2rJ9hv/c/1jy7WGw8hMvigFXEegrZuJjDK1gyzRSzpIeDTaVUHkUzxT8NHUIt4llUa9zNv/tAXLje+ag/Bdqm7F2ErenHHCsNcwqMNPVAztiJfRMDzKbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784543938; c=relaxed/simple;
	bh=924OMq8kYlXr9KheiW/qgB0/Gvywmx/QBwEVOAd2OAw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZewGqFwqrW3LBk2HSiPh0Khk/yPF0o3J1DMOzVThFDedATTcFbsfiLgDOsq0hbc8ge8krzOC1P4ps1bxBZ0jlv2mhpA4oqz9eCxdmuwi2eWNWRdbM3hSgKBW3i9dpN2DaAF5TucEtwhQKeN8xui6SqZjY6j3sSyc6EWhDW3q29o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AOSRRO7q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AOSRRO7q"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 49F90C2BCFA;
	Mon, 20 Jul 2026 10:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784543938;
	bh=924OMq8kYlXr9KheiW/qgB0/Gvywmx/QBwEVOAd2OAw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=AOSRRO7q0p40z2iUAmhK4wKeYovFLlCJFKUUKq55g/XlZ2eTkpae56cOfkknaP7/o
	 CescOXc4f2Naqtz+0AVDlH+s1s93DzUvYtBOwCREKBJIAbC1fTQejfz/zOiOwK2pSY
	 2s+lLJcc+gLArjrm9ozSS6dnv/rXw/jeqnowtaZz0e2T5u+Y15HIRiQnSsNSPfmAX8
	 72AGpJA5PJo4vY1wEo1UJAP7sgFeT4ogF3WIg/5VachmE9n81wbB8fHwsiS/+p+Sp/
	 5QPvT5j5gt8eWOy+aMCFnUkbyKL0T8Kmbb7HtsUB6pAjrJ/xJMx7sE5VDyREI/obcJ
	 jELzk0gf8hwvg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A647C44515;
	Mon, 20 Jul 2026 10:38:58 +0000 (UTC)
From: Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Date: Mon, 20 Jul 2026 12:38:32 +0200
Subject: [PATCH v2 1/3] iio: inv_sensors: convert to kernel types
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-iio-common-inv-sensors-timestamp-rework-v2-1-aec31446809c@tdk.com>
References: <20260720-iio-common-inv-sensors-timestamp-rework-v2-0-aec31446809c@tdk.com>
In-Reply-To: <20260720-iio-common-inv-sensors-timestamp-rework-v2-0-aec31446809c@tdk.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784543936; l=7732;
 i=jean-baptiste.maneyrol@tdk.com; s=20240923; h=from:subject:message-id;
 bh=49yZuvcafugGR1ZfjYa5lzm+gj3Ua3pQf2fJ6haRP4k=;
 b=l/kAI2mzm47RR9ZxD9Hf26mxop0Xi0ZM9e2LSBNJTzdd1m2N73ENU3J1kjQElt1sU5EiKzLfD
 U1R5sLLDKQTB5Hfg4lCCeGy6hvwYx+J/p0RFhhK5SYgItPs9Rhx6xVQ
X-Developer-Key: i=jean-baptiste.maneyrol@tdk.com; a=ed25519;
 pk=bRqF1WYk0hR3qrnAithOLXSD0LvSu8DUd+quKLxCicI=
X-Endpoint-Received: by B4 Relay for
 jean-baptiste.maneyrol@tdk.com/20240923 with auth_id=218
X-Original-From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Reply-To: jean-baptiste.maneyrol@tdk.com

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

Convert standard types (u)intXX_t to kernel type u/sXX.

Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
 .../iio/common/inv_sensors/inv_sensors_timestamp.c | 48 +++++++++++-----------
 include/linux/iio/common/inv_sensors_timestamp.h   | 34 +++++++--------
 2 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c b/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
index e0b10366ed2b..ecfd54ffe7e9 100644
--- a/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
+++ b/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
@@ -19,9 +19,9 @@
 	(((_val) * (1000 + (_jitter))) / 1000)
 
 /* Add a new value inside an accumulator and update the estimate value */
-static void inv_update_acc(struct inv_sensors_timestamp_acc *acc, uint32_t val)
+static void inv_update_acc(struct inv_sensors_timestamp_acc *acc, u32 val)
 {
-	uint64_t sum = 0;
+	u64 sum = 0;
 	size_t i;
 
 	acc->values[acc->idx++] = val;
@@ -58,9 +58,9 @@ void inv_sensors_timestamp_init(struct inv_sensors_timestamp *ts,
 EXPORT_SYMBOL_NS_GPL(inv_sensors_timestamp_init, "IIO_INV_SENSORS_TIMESTAMP");
 
 int inv_sensors_timestamp_update_odr(struct inv_sensors_timestamp *ts,
-				     uint32_t period, bool fifo)
+				     u32 period, bool fifo)
 {
-	uint32_t mult;
+	u32 mult;
 
 	/* when FIFO is on, prevent odr change if one is already pending */
 	if (fifo && ts->new_mult != 0)
@@ -78,9 +78,9 @@ int inv_sensors_timestamp_update_odr(struct inv_sensors_timestamp *ts,
 }
 EXPORT_SYMBOL_NS_GPL(inv_sensors_timestamp_update_odr, "IIO_INV_SENSORS_TIMESTAMP");
 
-static bool inv_validate_period(struct inv_sensors_timestamp *ts, uint32_t period)
+static bool inv_validate_period(struct inv_sensors_timestamp *ts, u32 period)
 {
-	uint32_t period_min, period_max;
+	u32 period_min, period_max;
 
 	/* check that period is acceptable */
 	period_min = ts->min_period * ts->mult;
@@ -92,9 +92,9 @@ static bool inv_validate_period(struct inv_sensors_timestamp *ts, uint32_t perio
 }
 
 static bool inv_update_chip_period(struct inv_sensors_timestamp *ts,
-				   uint32_t period)
+				   u32 period)
 {
-	uint32_t new_chip_period;
+	u32 new_chip_period;
 
 	if (!inv_validate_period(ts, period))
 		return false;
@@ -109,19 +109,19 @@ static bool inv_update_chip_period(struct inv_sensors_timestamp *ts,
 
 static void inv_align_timestamp_it(struct inv_sensors_timestamp *ts)
 {
-	const int64_t period_min = (int64_t)ts->min_period * ts->mult;
-	const int64_t period_max = (int64_t)ts->max_period * ts->mult;
-	int64_t add_max, sub_max;
-	int64_t delta, jitter;
-	int64_t adjust;
+	const s64 period_min = (s64)ts->min_period * ts->mult;
+	const s64 period_max = (s64)ts->max_period * ts->mult;
+	s64 add_max, sub_max;
+	s64 delta, jitter;
+	s64 adjust;
 
 	/* delta time between last sample and last interrupt */
 	delta = ts->it.lo - ts->timestamp;
 
 	/* adjust timestamp while respecting jitter */
-	add_max = period_max - (int64_t)ts->period;
-	sub_max = period_min - (int64_t)ts->period;
-	jitter = INV_SENSORS_TIMESTAMP_JITTER((int64_t)ts->period, ts->chip.jitter);
+	add_max = period_max - (s64)ts->period;
+	sub_max = period_min - (s64)ts->period;
+	jitter = INV_SENSORS_TIMESTAMP_JITTER((s64)ts->period, ts->chip.jitter);
 	if (delta > jitter)
 		adjust = add_max;
 	else if (delta < -jitter)
@@ -133,11 +133,11 @@ static void inv_align_timestamp_it(struct inv_sensors_timestamp *ts)
 }
 
 void inv_sensors_timestamp_interrupt(struct inv_sensors_timestamp *ts,
-				     size_t sample_nb, int64_t timestamp)
+				     size_t sample_nb, s64 timestamp)
 {
 	struct inv_sensors_timestamp_interval *it;
-	int64_t delta, interval;
-	uint32_t period;
+	s64 delta, interval;
+	u32 period;
 	bool valid = false;
 
 	if (sample_nb == 0)
@@ -157,7 +157,7 @@ void inv_sensors_timestamp_interrupt(struct inv_sensors_timestamp *ts,
 	/* no previous data, compute theoretical value from interrupt */
 	if (ts->timestamp == 0) {
 		/* elapsed time: sensor period * sensor samples number */
-		interval = (int64_t)ts->period * (int64_t)sample_nb;
+		interval = (s64)ts->period * (s64)sample_nb;
 		ts->timestamp = it->up - interval;
 		return;
 	}
@@ -169,11 +169,11 @@ void inv_sensors_timestamp_interrupt(struct inv_sensors_timestamp *ts,
 EXPORT_SYMBOL_NS_GPL(inv_sensors_timestamp_interrupt, "IIO_INV_SENSORS_TIMESTAMP");
 
 void inv_sensors_timestamp_apply_odr(struct inv_sensors_timestamp *ts,
-				     uint32_t fifo_period, size_t fifo_nb,
+				     u32 fifo_period, size_t fifo_nb,
 				     unsigned int fifo_no)
 {
-	int64_t interval;
-	uint32_t fifo_mult;
+	s64 interval;
+	u32 fifo_mult;
 
 	if (ts->new_mult == 0)
 		return;
@@ -194,7 +194,7 @@ void inv_sensors_timestamp_apply_odr(struct inv_sensors_timestamp *ts,
 		fifo_mult = fifo_period / ts->chip.clock_period;
 		fifo_period = fifo_mult * ts->chip_period.val;
 		/* computes time interval between interrupt and this sample */
-		interval = (int64_t)(fifo_nb - fifo_no) * (int64_t)fifo_period;
+		interval = (s64)(fifo_nb - fifo_no) * (s64)fifo_period;
 		ts->timestamp = ts->it.up - interval;
 	}
 }
diff --git a/include/linux/iio/common/inv_sensors_timestamp.h b/include/linux/iio/common/inv_sensors_timestamp.h
index 8d506f1e9df2..e4e720e6f4b7 100644
--- a/include/linux/iio/common/inv_sensors_timestamp.h
+++ b/include/linux/iio/common/inv_sensors_timestamp.h
@@ -13,9 +13,9 @@
  * @init_period:	chip initial period at reset in ns
  */
 struct inv_sensors_timestamp_chip {
-	uint32_t clock_period;
-	uint32_t jitter;
-	uint32_t init_period;
+	u32 clock_period;
+	u32 jitter;
+	u32 init_period;
 };
 
 /**
@@ -24,8 +24,8 @@ struct inv_sensors_timestamp_chip {
  * @up:	interval upper bound
  */
 struct inv_sensors_timestamp_interval {
-	int64_t lo;
-	int64_t up;
+	s64 lo;
+	s64 up;
 };
 
 /**
@@ -35,9 +35,9 @@ struct inv_sensors_timestamp_interval {
  * @values:	table of all measured values, use for computing the mean
  */
 struct inv_sensors_timestamp_acc {
-	uint32_t val;
+	u32 val;
 	size_t idx;
-	uint32_t values[32];
+	u32 values[32];
 };
 
 /**
@@ -54,13 +54,13 @@ struct inv_sensors_timestamp_acc {
  */
 struct inv_sensors_timestamp {
 	struct inv_sensors_timestamp_chip chip;
-	uint32_t min_period;
-	uint32_t max_period;
+	u32 min_period;
+	u32 max_period;
 	struct inv_sensors_timestamp_interval it;
-	int64_t timestamp;
-	uint32_t mult;
-	uint32_t new_mult;
-	uint32_t period;
+	s64 timestamp;
+	u32 mult;
+	u32 new_mult;
+	u32 period;
 	struct inv_sensors_timestamp_acc chip_period;
 };
 
@@ -68,19 +68,19 @@ void inv_sensors_timestamp_init(struct inv_sensors_timestamp *ts,
 				const struct inv_sensors_timestamp_chip *chip);
 
 int inv_sensors_timestamp_update_odr(struct inv_sensors_timestamp *ts,
-				     uint32_t period, bool fifo);
+				     u32 period, bool fifo);
 
 void inv_sensors_timestamp_interrupt(struct inv_sensors_timestamp *ts,
-				     size_t sample_nb, int64_t timestamp);
+				     size_t sample_nb, s64 timestamp);
 
-static inline int64_t inv_sensors_timestamp_pop(struct inv_sensors_timestamp *ts)
+static inline s64 inv_sensors_timestamp_pop(struct inv_sensors_timestamp *ts)
 {
 	ts->timestamp += ts->period;
 	return ts->timestamp;
 }
 
 void inv_sensors_timestamp_apply_odr(struct inv_sensors_timestamp *ts,
-				     uint32_t fifo_period, size_t fifo_nb,
+				     u32 fifo_period, size_t fifo_nb,
 				     unsigned int fifo_no);
 
 static inline void inv_sensors_timestamp_reset(struct inv_sensors_timestamp *ts)

-- 
2.54.0


