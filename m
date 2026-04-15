Received: from mail-244108.protonmail.ch (mail-244108.protonmail.ch [109.224.244.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2533264F3
	for <linux-iio@vger.kernel.org>; Wed, 15 Apr 2026 16:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776269357; cv=none; b=LEIGPDaIUPQ5ggUTrltTwKK2dy3rMb55Vv7bHfxFvVeZWBsq2FkD/kjLRg8L8FQj0ttl6cw3qcqY7hRPipaNt6aaj5Ch/ucYNKB6Gy0nbOgxBGZNlRH+mc6F4TEbNPiDSmmm/imR2DStv2XIkY5aylJ+VtivPGZvrPLqsg9LYRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776269357; c=relaxed/simple;
	bh=7Y1CBwNHDDsbDsvqFKnGK9gukn7Udrh9iJJpw/ZB2ZI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FieBc7fwIZDtTrtNsE6IyieVi5LsJ9mvSodR5ilS95vg7OiVatKo7RfT7SXATkrYD1QoTevAiTdOKj65g/z70Qz6Y1DZv8YAPpXmdIo3JdEyanoPza+G8EsGXNxvH7p58bgpHYZEIu18ztGxc6D0hGEmyPlVZB1xSuvftnn7k9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ciziks.com; spf=pass smtp.mailfrom=ciziks.com; dkim=pass (2048-bit key) header.d=ciziks.com header.i=@ciziks.com header.b=hprwZ5sc; arc=none smtp.client-ip=109.224.244.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ciziks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ciziks.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ciziks.com header.i=@ciziks.com header.b="hprwZ5sc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ciziks.com;
	s=protonmail; t=1776269344; x=1776528544;
	bh=Zs9GceeqQxB9GqUQDH+vH49Hs/Bo2gVnBObl4WLcvOo=;
	h=From:To:Cc:Subject:Date:Message-ID:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=hprwZ5scEghEwRSIgn4u5d1HQrLJX5765VhNfhv7aDugwK3prHz1yymjTkmM/rHSJ
	 SyxkWzR4noLq3fZ2eNjBvB+SlKiE2FK8rV0uK58iUglkNDzDf5AjA54FBfIHXi5G7R
	 0cqG3WZ9Dyx/I6szAJiVpjKIxfKKOOH+fq3p5VPyrWOtZ19RGmWh+/4tNwS6a/MVL7
	 2fOrY/MQ8RzYFcgueJ5pXkLM5ul2js7YCnyBTIb/rCWqcOjuh/v/CA87Eux7YjA3O8
	 EPYBNf2qcxwhyTqaLVTNDcryZBugc96QoPeQh192EAjhLiq8SsH9vxErhX706eMkxJ
	 V/07UzDmsDE1Q==
X-Pm-Submission-Id: 4fwmKm1R8Yz2SchM
From: Lucas Ivars Cadima Ciziks <lucas@ciziks.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: Felipe Ribeiro de Souza <felipers@usp.br>,
	linux-iio@vger.kernel.org
Subject: [PATCH v2] iio: adc: ad7280a: use cleanup helpers guard() and scoped_guard() for mutex locking
Date: Wed, 15 Apr 2026 13:08:38 -0300
Message-ID: <20260415160856.22231-1-lucas@ciziks.com>
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
v2:
  - Replace scoped_guard with guard as suggested by Andy Shevchenko (Code Legibility).
  - Fix indentation issues.
---
 drivers/iio/adc/ad7280a.c | 53 ++++++++++++++++-----------------------
 1 file changed, 22 insertions(+), 31 deletions(-)

diff --git a/drivers/iio/adc/ad7280a.c b/drivers/iio/adc/ad7280a.c
index ba12a3796e2b..89e1eda92851 100644
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
@@ -519,10 +519,9 @@ static ssize_t ad7280_show_balance_timer(struct iio_dev *indio_dev,
 	unsigned int msecs;
 	int ret;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 	ret = ad7280_read_reg(st, chan->address >> 8,
 			      (chan->address & 0xFF) + AD7280A_CB1_TIMER_REG);
-	mutex_unlock(&st->lock);
 
 	if (ret < 0)
 		return ret;
@@ -551,11 +550,11 @@ static ssize_t ad7280_store_balance_timer(struct iio_dev *indio_dev,
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
@@ -737,7 +736,8 @@ static int ad7280a_write_thresh(struct iio_dev *indio_dev,
 	if (val2 != 0)
 		return -EINVAL;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
+
 	switch (chan->type) {
 	case IIO_VOLTAGE:
 		value = ((val - 1000) * 100) / 1568; /* LSB 15.68mV */
@@ -748,22 +748,20 @@ static int ad7280a_write_thresh(struct iio_dev *indio_dev,
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
@@ -773,31 +771,23 @@ static int ad7280a_write_thresh(struct iio_dev *indio_dev,
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
@@ -884,14 +874,14 @@ static int ad7280_read_raw(struct iio_dev *indio_dev,
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
@@ -899,6 +889,7 @@ static int ad7280_read_raw(struct iio_dev *indio_dev,
 		*val = ret;
 
 		return IIO_VAL_INT;
+	}
 	case IIO_CHAN_INFO_SCALE:
 		if ((chan->address & 0xFF) <= AD7280A_CELL_VOLTAGE_6_REG)
 			*val = 4000;
-- 
2.47.3

