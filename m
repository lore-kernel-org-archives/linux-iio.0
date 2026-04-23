Received: from mail-43171.protonmail.ch (mail-43171.protonmail.ch [185.70.43.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E959257459
	for <linux-iio@vger.kernel.org>; Thu, 23 Apr 2026 13:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776951225; cv=none; b=CqHhSCEyF0ZCgwLhVwF9dqBFooQzih4SeGQDiZUvLv84LnTm6PVFcqfMB9bA5Bt2zi4dJjHyQ8efZgG2d8TLus9Ouo3K+WHh8vb8WGL/tpj0PvqLTIgbOXz3W5K3oGPWnkZYn2+q4FP2gUMx0Q/MqGCWgoEevO/5cftxtB+OZ68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776951225; c=relaxed/simple;
	bh=vazhrI6LhY6Q57mIpf6u8Z1ZlpMUQjq84c/zPZU8n3k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lu2qPUFaHbtwod+PeP+OLRku1cPNuOUpYNoC2F0qyCyrRqJd3FQ9SehjWw9EIeIbGJTQk1UDwi/f7HDpaubjfdF0tfE46Uf1iyIB0A1iJnhEYCyYZnLI9nmglV45iFmIpVuDWSOB0Ul5rtnC5fWzJS3rVXGxnvIV9beq5tfbeBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ciziks.com; spf=pass smtp.mailfrom=ciziks.com; dkim=pass (2048-bit key) header.d=ciziks.com header.i=@ciziks.com header.b=kMLtRzWY; arc=none smtp.client-ip=185.70.43.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ciziks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ciziks.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ciziks.com header.i=@ciziks.com header.b="kMLtRzWY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ciziks.com;
	s=protonmail; t=1776951213; x=1777210413;
	bh=36akqmAn/E7nb31qwYoZ0fvhFNn+fbJMjvhB6Zx0Q4c=;
	h=From:To:Cc:Subject:Date:Message-ID:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=kMLtRzWYz44wh8kMxUnfkN5vV0PF5jSyvTBFACzNyZRGTrHSNSkY7+epV1CHpPW92
	 qdp4hYR4y1suOAp0qHAqrWWIHXPVaUke9XSxmfGh+TGwTml89hosNnUiaS3KZtmtvO
	 5ctoHixoNrZkUqpi0u6dXENTAm/XINaG0WJwiaQ4+QL5z/Q0+bAc9EqzTFQRhEXl3X
	 QoSCAcwPt2vlOWIiqqLfJqBFKuRJP/FIv37LiBHRnOU9eqYIxiYLREy+isb1exuDIo
	 kR53kM1RLEARJVhfm0zGqvySBSl1FUsgr8if4n1K400SXZgE45L+njJiSaMTPTScz/
	 XGH+4nOhlfgWw==
X-Pm-Submission-Id: 4g1cVZ4gRSz1DDs5
From: Lucas Ivars Cadima Ciziks <lucas@ciziks.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: Matheus Giarola <matheusgiarola@usp.br>,
	Felipe Ribeiro de Souza <felipers@usp.br>,
	linux-iio@vger.kernel.org
Subject: [PATCH v4] iio: adc: ad7280a: use cleanup helpers guard() and scoped_guard() for mutex locking
Date: Thu, 23 Apr 2026 10:26:48 -0300
Message-ID: <20260423133322.13298-1-lucas@ciziks.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace open-coded mutex_lock/unlock pairs with the cleanup-based
guard() and scoped_guard() helpers in ad7280a_write_thresh(),
ad7280_show_balance_timer(), ad7280_store_balance_sw(),
ad7280_store_balance_timer() and ad7280_read_raw().

This removes the need for the err_unlock label and explicit
mutex_unlock() calls, as the lock is now automatically released
when the function returns or the guarded scope exits, regardless
of the exit path.

Co-developed-by: Matheus Giarola <matheusgiarola@usp.br>
Signed-off-by: Matheus Giarola <matheusgiarola@usp.br>
Co-developed-by: Felipe Ribeiro de Souza <felipers@usp.br>
Signed-off-by: Felipe Ribeiro de Souza <felipers@usp.br>
Signed-off-by: Lucas Ivars Cadima Ciziks <lucas@ciziks.com>
---
v4:
  - Improve readability in ad7280_show_balance_timer() by extracting
    chan->address bit fields into named local variables, as suggested by Andy Shevchenko.

v3:
  - Restore scoped_guard() in ad7280_show_balance_timer() instead of
    guard() to avoid holding the mutex during post-processing, as
    suggested by Andy Shevchenko.

v2:
  - Replace scoped_guard with guard as suggested by Andy Shevchenko (Code Legibility).
  - Fix indentation issues.
---
 drivers/iio/adc/ad7280a.c | 58 +++++++++++++++++----------------------
 1 file changed, 25 insertions(+), 33 deletions(-)

diff --git a/drivers/iio/adc/ad7280a.c b/drivers/iio/adc/ad7280a.c
index ba12a3796e2b..a7807c681a12 100644
--- a/drivers/iio/adc/ad7280a.c
+++ b/drivers/iio/adc/ad7280a.c
@@ -496,7 +496,8 @@ static ssize_t ad7280_store_balance_sw(struct iio_dev *indio_dev,
 	devaddr = chan->address >> 8;
 	ch = chan->address & 0xFF;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
+
 	if (readin)
 		st->cb_mask[devaddr] |= BIT(ch);
 	else
@@ -505,7 +506,6 @@ static ssize_t ad7280_store_balance_sw(struct iio_dev *indio_dev,
 	ret = ad7280_write(st, devaddr, AD7280A_CELL_BALANCE_REG, 0,
 			   FIELD_PREP(AD7280A_CELL_BALANCE_CHAN_BITMAP_MSK,
 				      st->cb_mask[devaddr]));
-	mutex_unlock(&st->lock);
 
 	return ret ? ret : len;
 }
@@ -516,13 +516,13 @@ static ssize_t ad7280_show_balance_timer(struct iio_dev *indio_dev,
 					 char *buf)
 {
 	struct ad7280_state *st = iio_priv(indio_dev);
+	u8 devaddr = chan->address >> 8;
+	u8 ch = chan->address & 0xFF;
 	unsigned int msecs;
 	int ret;
 
-	mutex_lock(&st->lock);
-	ret = ad7280_read_reg(st, chan->address >> 8,
-			      (chan->address & 0xFF) + AD7280A_CB1_TIMER_REG);
-	mutex_unlock(&st->lock);
+	scoped_guard(mutex, &st->lock)
+		ret = ad7280_read_reg(st, devaddr, ch + AD7280A_CB1_TIMER_REG);
 
 	if (ret < 0)
 		return ret;
@@ -551,11 +551,11 @@ static ssize_t ad7280_store_balance_timer(struct iio_dev *indio_dev,
 	if (val > 31)
 		return -EINVAL;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
+
 	ret = ad7280_write(st, chan->address >> 8,
 			   (chan->address & 0xFF) + AD7280A_CB1_TIMER_REG, 0,
 			   FIELD_PREP(AD7280A_CB_TIMER_VAL_MSK, val));
-	mutex_unlock(&st->lock);
 
 	return ret ? ret : len;
 }
@@ -737,7 +737,8 @@ static int ad7280a_write_thresh(struct iio_dev *indio_dev,
 	if (val2 != 0)
 		return -EINVAL;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
+
 	switch (chan->type) {
 	case IIO_VOLTAGE:
 		value = ((val - 1000) * 100) / 1568; /* LSB 15.68mV */
@@ -748,22 +749,20 @@ static int ad7280a_write_thresh(struct iio_dev *indio_dev,
 			ret = ad7280_write(st, AD7280A_DEVADDR_MASTER, addr,
 					   1, value);
 			if (ret)
-				break;
+				return ret;
 			st->cell_threshhigh = value;
-			break;
+			return 0;
 		case IIO_EV_DIR_FALLING:
 			addr = AD7280A_CELL_UNDERVOLTAGE_REG;
 			ret = ad7280_write(st, AD7280A_DEVADDR_MASTER, addr,
 					   1, value);
 			if (ret)
-				break;
+				return ret;
 			st->cell_threshlow = value;
-			break;
+			return 0;
 		default:
-			ret = -EINVAL;
-			goto err_unlock;
+			return -EINVAL;
 		}
-		break;
 	case IIO_TEMP:
 		value = (val * 10) / 196; /* LSB 19.6mV */
 		value = clamp(value, 0L, 0xFFL);
@@ -773,31 +772,23 @@ static int ad7280a_write_thresh(struct iio_dev *indio_dev,
 			ret = ad7280_write(st, AD7280A_DEVADDR_MASTER, addr,
 					   1, value);
 			if (ret)
-				break;
+				return ret;
 			st->aux_threshhigh = value;
-			break;
+			return 0;
 		case IIO_EV_DIR_FALLING:
 			addr = AD7280A_AUX_ADC_UNDERVOLTAGE_REG;
 			ret = ad7280_write(st, AD7280A_DEVADDR_MASTER, addr,
 					   1, value);
 			if (ret)
-				break;
+				return ret;
 			st->aux_threshlow = value;
-			break;
+			return 0;
 		default:
-			ret = -EINVAL;
-			goto err_unlock;
+			return -EINVAL;
 		}
-		break;
 	default:
-		ret = -EINVAL;
-		goto err_unlock;
+		return -EINVAL;
 	}
-
-err_unlock:
-	mutex_unlock(&st->lock);
-
-	return ret;
 }
 
 static irqreturn_t ad7280_event_handler(int irq, void *private)
@@ -884,14 +875,14 @@ static int ad7280_read_raw(struct iio_dev *indio_dev,
 	int ret;
 
 	switch (m) {
-	case IIO_CHAN_INFO_RAW:
-		mutex_lock(&st->lock);
+	case IIO_CHAN_INFO_RAW: {
+		guard(mutex)(&st->lock);
+
 		if (chan->address == AD7280A_ALL_CELLS)
 			ret = ad7280_read_all_channels(st, st->scan_cnt, NULL);
 		else
 			ret = ad7280_read_channel(st, chan->address >> 8,
 						  chan->address & 0xFF);
-		mutex_unlock(&st->lock);
 
 		if (ret < 0)
 			return ret;
@@ -899,6 +890,7 @@ static int ad7280_read_raw(struct iio_dev *indio_dev,
 		*val = ret;
 
 		return IIO_VAL_INT;
+	}
 	case IIO_CHAN_INFO_SCALE:
 		if ((chan->address & 0xFF) <= AD7280A_CELL_VOLTAGE_6_REG)
 			*val = 4000;
-- 
2.47.3

