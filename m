Received: from mail-244106.protonmail.ch (mail-244106.protonmail.ch [109.224.244.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8214E342524
	for <linux-iio@vger.kernel.org>; Wed, 15 Apr 2026 11:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776252384; cv=none; b=HZYLnFN22/SWmAgSOc+wdKGIqnBqNC1cfdI8uYWG9iE45GyYxa1JQ3CB162gr9fezKfLYAwaP19blrOUi/mWMDKU78nnVavrcVPIWyK3hQpEbOZeAzRURBaH2siM/2RSJjETDiYxUQ8RiS7N41IoJQHAtAepD1sGympYORmUwz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776252384; c=relaxed/simple;
	bh=/xMMw1Qd5SM52H0mQuA5dqekWMfR325nIEShNlC7UDM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UTCXG+IPX/x46wuqLbEGZwhZqt/2xQeI2t9itOKZiAQjmidK8eOox/znizxb8+rlrhaifSGykU1qjKaxqNLDsqfNilrb3pvE+HSszmjL1Yh2zVASI8jKLKvfKDz5VVStKHugRSRv9w6pgDAXP+Zw4lQqJN7bXelCyGJHxTSIptA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ciziks.com; spf=pass smtp.mailfrom=ciziks.com; dkim=pass (2048-bit key) header.d=ciziks.com header.i=@ciziks.com header.b=LO9UYgCp; arc=none smtp.client-ip=109.224.244.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ciziks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ciziks.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ciziks.com header.i=@ciziks.com header.b="LO9UYgCp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ciziks.com;
	s=protonmail; t=1776252372; x=1776511572;
	bh=8hk6Z5BZiy08dUMJOA0QX1KJPb6mSJoNL4bVnWxdHkU=;
	h=From:To:Cc:Subject:Date:Message-ID:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=LO9UYgCpQNNlLQSIZxaVF1Uh+OhBsHk3m/PaJOp2IUXlch9pLleQsy2KTRMj4hbC9
	 wyPUj4Ed2S87QTMZpdEduZesGtsaXzKcg/NYJvfR9QxFE2b7g3PWQP9TLdU9AZzynl
	 gXne9H7LBMMMHCL5QzLqI+fRDAWz1jA6sybdWt4LRayJjHsSqGA/RwQi3ZdLQETEOe
	 lMhAxuMbXdz3gVcITNRMhNcZFdGGWbh2D8O5fhiv3rugrlksiUKJs4RkvPCOOKJg0a
	 7lR9T7+LMgG4Z1hzsnivZP1M7mpiUeUi7yjTOqW3gPluDdRHNcO1pkOlY+UsK51AiC
	 cNrlBu4o950/g==
X-Pm-Submission-Id: 4fwf3L2YMHz2Schl
From: Lucas Ivars Cadima Ciziks <lucas@ciziks.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: Felipe Ribeiro de Souza <felipers@usp.br>,
	linux-iio@vger.kernel.org
Subject: [PATCH] iio: adc: ad7280a: use cleanup helpers guard() and scoped_guard() for mutex locking
Date: Wed, 15 Apr 2026 08:25:48 -0300
Message-ID: <20260415112602.3938-1-lucas@ciziks.com>
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

Signed-off-by: Lucas Ivars Cadima Ciziks <lucas@ciziks.com>
Co-developed-by: Felipe Ribeiro de Souza <felipers@usp.br>
Signed-off-by: Felipe Ribeiro de Souza <felipers@usp.br>
---
 drivers/iio/adc/ad7280a.c | 68 +++++++++++++++++----------------------
 1 file changed, 29 insertions(+), 39 deletions(-)

diff --git a/drivers/iio/adc/ad7280a.c b/drivers/iio/adc/ad7280a.c
index ba12a3796e2b..904ef815a5f1 100644
--- a/drivers/iio/adc/ad7280a.c
+++ b/drivers/iio/adc/ad7280a.c
@@ -496,7 +496,7 @@ static ssize_t ad7280_store_balance_sw(struct iio_dev *indio_dev,
 	devaddr = chan->address >> 8;
 	ch = chan->address & 0xFF;
 
-	mutex_lock(&st->lock);
+	scoped_guard(mutex, &st->lock) {
 	if (readin)
 		st->cb_mask[devaddr] |= BIT(ch);
 	else
@@ -505,7 +505,7 @@ static ssize_t ad7280_store_balance_sw(struct iio_dev *indio_dev,
 	ret = ad7280_write(st, devaddr, AD7280A_CELL_BALANCE_REG, 0,
 			   FIELD_PREP(AD7280A_CELL_BALANCE_CHAN_BITMAP_MSK,
 				      st->cb_mask[devaddr]));
-	mutex_unlock(&st->lock);
+	}
 
 	return ret ? ret : len;
 }
@@ -519,10 +519,10 @@ static ssize_t ad7280_show_balance_timer(struct iio_dev *indio_dev,
 	unsigned int msecs;
 	int ret;
 
-	mutex_lock(&st->lock);
+	scoped_guard(mutex, &st->lock) {
 	ret = ad7280_read_reg(st, chan->address >> 8,
 			      (chan->address & 0xFF) + AD7280A_CB1_TIMER_REG);
-	mutex_unlock(&st->lock);
+	}
 
 	if (ret < 0)
 		return ret;
@@ -551,11 +551,11 @@ static ssize_t ad7280_store_balance_timer(struct iio_dev *indio_dev,
 	if (val > 31)
 		return -EINVAL;
 
-	mutex_lock(&st->lock);
-	ret = ad7280_write(st, chan->address >> 8,
-			   (chan->address & 0xFF) + AD7280A_CB1_TIMER_REG, 0,
-			   FIELD_PREP(AD7280A_CB_TIMER_VAL_MSK, val));
-	mutex_unlock(&st->lock);
+	scoped_guard(mutex, &st->lock) {
+		ret = ad7280_write(st, chan->address >> 8,
+					(chan->address & 0xFF) + AD7280A_CB1_TIMER_REG, 0,
+					FIELD_PREP(AD7280A_CB_TIMER_VAL_MSK, val));
+	}
 
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
@@ -885,14 +876,13 @@ static int ad7280_read_raw(struct iio_dev *indio_dev,
 
 	switch (m) {
 	case IIO_CHAN_INFO_RAW:
-		mutex_lock(&st->lock);
-		if (chan->address == AD7280A_ALL_CELLS)
-			ret = ad7280_read_all_channels(st, st->scan_cnt, NULL);
-		else
-			ret = ad7280_read_channel(st, chan->address >> 8,
-						  chan->address & 0xFF);
-		mutex_unlock(&st->lock);
-
+		scoped_guard(mutex, &st->lock) {
+			if (chan->address == AD7280A_ALL_CELLS)
+				ret = ad7280_read_all_channels(st, st->scan_cnt, NULL);
+			else
+				ret = ad7280_read_channel(st, chan->address >> 8,
+					chan->address & 0xFF);
+		}
 		if (ret < 0)
 			return ret;
 
-- 
2.47.3

