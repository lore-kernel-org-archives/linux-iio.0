Received: from mail-07.mail-europe.com (mail-07.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABE53B9D84
	for <linux-iio@vger.kernel.org>; Fri, 24 Apr 2026 12:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777035036; cv=none; b=bbEOYLRGDykQlKK9tTFjqcWNi8TfRhfbt1Q2W8QoDet9dQ28lSg/lOFJigF01fUG6IdJd6dv/y+8MRr0QiUrAfiajZurNQ3e5gkNP4Vd5w++T0EDu+m1+l6FUIzPMLZWlBV9MCo1aDzc2VDwu8/TOkFnydmirZ/tvKSic/LDN9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777035036; c=relaxed/simple;
	bh=ZAOHR8CCiI/nVJfVL2j1otgRqQxRwP8M6rkl7ZHgfDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EG5lGu7IKLQbKN6CCFcYPYUSCMT3Fo+t1pUJJzEqHHKXwzu8VTz9NzlNOIkmIwvNhcJRlyN3CZErRyZZNkAhO6I5S+pGA0ZKudrC7EE7zvzTCznWPikoQGuYOfcKJ8LR7+VRYYRWCcsN8yp74MZketZA+uK1CBoanHOZOvmvxak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ciziks.com; spf=pass smtp.mailfrom=ciziks.com; dkim=pass (2048-bit key) header.d=ciziks.com header.i=@ciziks.com header.b=t4MVcgDP; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ciziks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ciziks.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ciziks.com header.i=@ciziks.com header.b="t4MVcgDP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ciziks.com;
	s=protonmail; t=1777035017; x=1777294217;
	bh=yiJLd6TrtAID9D5JzFxvxqlMBR99IohrddbNCYgQTak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=t4MVcgDPzNE11omJMJihuRZV81RzD9xx7IwuIqMH8VRICY/BVH0WUxfQEEfiFi7wZ
	 Y9TlTG/TAhI75bpA4/KmnzOm8ZEmQ29tzhRztOBVeqfcc73HOItRUNSciE3VYzuMXZ
	 rvUseA9d0tQIvW0kvmMC4URdosCSuPl4RdAxWHSN5etLUB7ucukW4J9vWct6ofUz7o
	 fnOgAIBlp6ThoZXmFzAl3ZqEz+VWXRPA2u7HmgZkImYBfPDWTPoicCTh1w+TXueEcG
	 1kNapv8Ybdiuu7mIhrOv7IcK4riM5xcSD9ajHGSWAhmPIUN4tv4bm+SEmsdV/5ZHZB
	 n0mrXltBjdgZg==
X-Pm-Submission-Id: 4g2CVG13kDz1DDry
From: Lucas Ivars Cadima Ciziks <lucas@ciziks.com>
To: andy@kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	nuno.sa@analog.com
Cc: Matheus Giarola <matheusgiarola@usp.br>,
	Felipe Ribeiro de Souza <felipers@usp.br>,
	linux-iio@vger.kernel.org
Subject: [PATCH v5 2/2] iio: adc: ad7280a: use cleanup helpers guard() and scoped_guard() for mutex locking
Date: Fri, 24 Apr 2026 09:43:40 -0300
Message-ID: <20260424125001.17822-3-lucas@ciziks.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260424125001.17822-1-lucas@ciziks.com>
References: <20260424125001.17822-1-lucas@ciziks.com>
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
Co-developed-by: Matheus Giarola <matheusgiarola@usp.br>
Signed-off-by: Matheus Giarola <matheusgiarola@usp.br>
Co-developed-by: Felipe Ribeiro de Souza <felipers@usp.br>
Signed-off-by: Felipe Ribeiro de Souza <felipers@usp.br>
---
v5:
  - Add preparatory patch extracting chan->address bit fields into
    named local variables, as suggested by Andy Shevchenko.
  - Link to v4: https://lore.kernel.org/linux-iio/20260423133322.13298-1-lucas@ciziks.com/

v4:
  - Improve readability in ad7280_show_balance_timer() by extracting
    chan->address bit fields into named local variables, as suggested by Andy Shevchenko.
  - Link to v3: https://lore.kernel.org/linux-iio/20260417131029.12568-1-lucas@ciziks.com/

v3:
  - Restore scoped_guard() in ad7280_show_balance_timer() instead of
    guard() to avoid holding the mutex during post-processing, as
    suggested by Andy Shevchenko.
  - Link to v2: https://lore.kernel.org/linux-iio/20260415160856.22231-1-lucas@ciziks.com/

v2:
  - Replace scoped_guard with guard as suggested by Andy Shevchenko (Code Legibility).
  - Fix indentation issues.
  - Link to v1: https://lore.kernel.org/linux-iio/20260415112602.3938-1-lucas@ciziks.com/
---
 drivers/iio/adc/ad7280a.c | 55 ++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 32 deletions(-)

diff --git a/drivers/iio/adc/ad7280a.c b/drivers/iio/adc/ad7280a.c
index 7f43da8e3340..56258b1118a4 100644
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
@@ -521,9 +521,8 @@ static ssize_t ad7280_show_balance_timer(struct iio_dev *indio_dev,
 	unsigned int msecs;
 	int ret;
 
-	mutex_lock(&st->lock);
-	ret = ad7280_read_reg(st, devaddr, ch + AD7280A_CB1_TIMER_REG);
-	mutex_unlock(&st->lock);
+	scoped_guard(mutex, &st->lock)
+		ret = ad7280_read_reg(st, devaddr, ch + AD7280A_CB1_TIMER_REG);
 
 	if (ret < 0)
 		return ret;
@@ -554,10 +553,10 @@ static ssize_t ad7280_store_balance_timer(struct iio_dev *indio_dev,
 	if (val > 31)
 		return -EINVAL;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
+
 	ret = ad7280_write(st, devaddr, ch + AD7280A_CB1_TIMER_REG, 0,
 			   FIELD_PREP(AD7280A_CB_TIMER_VAL_MSK, val));
-	mutex_unlock(&st->lock);
 
 	return ret ? ret : len;
 }
@@ -739,7 +738,8 @@ static int ad7280a_write_thresh(struct iio_dev *indio_dev,
 	if (val2 != 0)
 		return -EINVAL;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
+
 	switch (chan->type) {
 	case IIO_VOLTAGE:
 		value = ((val - 1000) * 100) / 1568; /* LSB 15.68mV */
@@ -750,22 +750,20 @@ static int ad7280a_write_thresh(struct iio_dev *indio_dev,
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
@@ -775,31 +773,23 @@ static int ad7280a_write_thresh(struct iio_dev *indio_dev,
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
@@ -888,13 +878,13 @@ static int ad7280_read_raw(struct iio_dev *indio_dev,
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
 			ret = ad7280_read_channel(st, devaddr, ch);
-		mutex_unlock(&st->lock);
 
 		if (ret < 0)
 			return ret;
@@ -902,6 +892,7 @@ static int ad7280_read_raw(struct iio_dev *indio_dev,
 		*val = ret;
 
 		return IIO_VAL_INT;
+	}
 	case IIO_CHAN_INFO_SCALE:
 		if (ch <= AD7280A_CELL_VOLTAGE_6_REG)
 			*val = 4000;
-- 
2.47.3

