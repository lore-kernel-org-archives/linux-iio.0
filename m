Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912403D75AD;
	Mon, 20 Jul 2026 10:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784543938; cv=none; b=E9gSqDYI2t41F/po0Zjm6Ng977Zg+jEvkbdhHCcYLlvg1Uaea51NfVWCDQfYoCyWfKBL9lE5NpEZdgeq8BrdyD1Y//73mpaYjV3KEaq19OAspKycanma4PTRx/PVOd6TjcgdvLsCbdapoR3H+kDWkakhn7u+fqSYYh26Zlu4Q+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784543938; c=relaxed/simple;
	bh=jX3mT5ogBRPc8ytC7Ugls8/3fSIOYLzRplELLtwtuQU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NKTQzyVFqISEqibyd5d13zdmacmIqEQomVkASEoK2HO3Ckp31FVYjM9a2pt0KFJWEQfakOiLutFgaR/QPahoSdCX8IF0lkrIpEvCBFyGaZC4sKEk8OeUkQroHG5sJYQ9+VwFMcx2GxR1F4V9cNdbDuExc8lqz6WEVY3aEeuF3Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XJhC3sCY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJhC3sCY"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 52045C4AF09;
	Mon, 20 Jul 2026 10:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784543938;
	bh=jX3mT5ogBRPc8ytC7Ugls8/3fSIOYLzRplELLtwtuQU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=XJhC3sCYzmOwmXEUzB28FTHHOOorHJjUI06Udk7N3ydw0VteKFkqRJO547oMhJOma
	 VZZLehDLJq9ZspQQZqPce3ANXyG7uq91ozfSYuu+o8e5YCcHg5Ek8g509yR82HXwi5
	 R1s2K/JYoNuMsnWPLlQU/MgGGmUXYKbBunKk4jeqaVGfoczMyta3oi1PmniynXAMnr
	 7PNkJROMlLyO2OERqM863TQMvuZwZSPZZHLAjbMU/QMGnivWLRS3J/Cul/FnfqlhIe
	 OFUw8kjX+rhh/r63oDtmoC3Sze88++ln5uDOflNg5KxeUN5MddKC2yXNQioq3E2ekU
	 KsyELzlKF61FQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 396E2C44527;
	Mon, 20 Jul 2026 10:38:58 +0000 (UTC)
From: Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Date: Mon, 20 Jul 2026 12:38:33 +0200
Subject: [PATCH v2 2/3] iio: inv_sensors: better timestamp alignment when
 using watermark
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-iio-common-inv-sensors-timestamp-rework-v2-2-aec31446809c@tdk.com>
References: <20260720-iio-common-inv-sensors-timestamp-rework-v2-0-aec31446809c@tdk.com>
In-Reply-To: <20260720-iio-common-inv-sensors-timestamp-rework-v2-0-aec31446809c@tdk.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784543936; l=4065;
 i=jean-baptiste.maneyrol@tdk.com; s=20240923; h=from:subject:message-id;
 bh=5Y3d1x9lJj9xiAU5X4QM0jQxvh5zbPbgxHv2JS+TVXc=;
 b=HUoSLqp/O1HoKzpVGswc35/6WB9q8Ym55ZYuzOu48jcf6aM2SUx1QlPsedljAV5USwMcVlU5E
 pbMZgv3+h5SDYEBtTxGVLxr/+UU1kNorwUJNkJc06kcsC8YPumCFTEJ
X-Developer-Key: i=jean-baptiste.maneyrol@tdk.com; a=ed25519;
 pk=bRqF1WYk0hR3qrnAithOLXSD0LvSu8DUd+quKLxCicI=
X-Endpoint-Received: by B4 Relay for
 jean-baptiste.maneyrol@tdk.com/20240923 with auth_id=218
X-Original-From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Reply-To: jean-baptiste.maneyrol@tdk.com

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

Current interrupt timestamp alignment only changes the final timestamp.
When the watermark is in use, we have a batch of samples for each
interrupt. The current code doesn't manage to align the timestamp
because the jitter is too high.

Instead modify the estimated inter interrupt period and use that to
adjust the timestamp alignment over the batch in a linear fashion.

Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
 .../iio/common/inv_sensors/inv_sensors_timestamp.c | 51 ++++++++--------------
 1 file changed, 19 insertions(+), 32 deletions(-)

diff --git a/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c b/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
index ecfd54ffe7e9..2aaaa8df6d03 100644
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
+static u32 inv_align_timestamp_it(struct inv_sensors_timestamp *ts,
+				  unsigned int sample_nb)
 {
 	const s64 period_min = (s64)ts->min_period * ts->mult;
 	const s64 period_max = (s64)ts->max_period * ts->mult;
-	s64 add_max, sub_max;
-	s64 delta, jitter;
-	s64 adjust;
-
-	/* delta time between last sample and last interrupt */
-	delta = ts->it.lo - ts->timestamp;
-
-	/* adjust timestamp while respecting jitter */
-	add_max = period_max - (s64)ts->period;
-	sub_max = period_min - (s64)ts->period;
-	jitter = INV_SENSORS_TIMESTAMP_JITTER((s64)ts->period, ts->chip.jitter);
-	if (delta > jitter)
-		adjust = add_max;
-	else if (delta < -jitter)
-		adjust = sub_max;
-	else
-		adjust = 0;
+	s64 new_period;
+
+	/* compute new period aligning last timestamp with interrupt timestamp */
+	new_period = div_s64(ts->it.up - ts->timestamp, sample_nb);
 
-	ts->timestamp += adjust;
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
+		interval = (s64)ts->period * (s64)sample_nb;
+		ts->timestamp = timestamp - interval;
+	}
+
 	/* update interrupt timestamp and compute chip and sensor periods */
 	it = &ts->it;
 	it->lo = it->up;
@@ -154,17 +147,11 @@ void inv_sensors_timestamp_interrupt(struct inv_sensors_timestamp *ts,
 		valid = inv_update_chip_period(ts, period);
 	}
 
-	/* no previous data, compute theoretical value from interrupt */
-	if (ts->timestamp == 0) {
-		/* elapsed time: sensor period * sensor samples number */
-		interval = (s64)ts->period * (s64)sample_nb;
-		ts->timestamp = it->up - interval;
-		return;
-	}
-
 	/* if interrupt interval is valid, sync with interrupt timestamp */
 	if (valid)
-		inv_align_timestamp_it(ts);
+		ts->period = inv_align_timestamp_it(ts, sample_nb);
+	else
+		ts->period = ts->mult * ts->chip_period.val;
 }
 EXPORT_SYMBOL_NS_GPL(inv_sensors_timestamp_interrupt, "IIO_INV_SENSORS_TIMESTAMP");
 

-- 
2.54.0


