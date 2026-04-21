Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28ED374170
	for <linux-iio@vger.kernel.org>; Tue, 21 Apr 2026 19:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776798566; cv=none; b=biJMbJTFYmZ8Q1Yp2dT9eP0LgdKvUzdY6nvF1ZMROgPemC4BDLuYakiM7p57/kSzVfguBhZE/hud0V1hdLJyFLJOYNynrXbC+c02BEa8FjlRFNZSndIKtjAObRAuI5HWKbhqb+J4BAls3O+jcy5Jm29/sIqZA3eovzGrCTbvQfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776798566; c=relaxed/simple;
	bh=Cxajfpwj1FxUEXseN/wkwg/G8tMpTeDahSG4GUYNoX8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b2UY5FJBi/v0ohmnNRSAbU93hpXO5KraF0rGGgHidEpZYIfOljsVN3jFthVoMFakS3nrj3yV1FeqsEQ5kC7qOZ3wN9LXblY/qrplIEOpDh+nsfCGDDEMAvu80YvyXf707M6UsZdnM31l0imDaeGJW2MD9M/3ycYP0LaN4YJPh7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EMZkbzCH; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EMZkbzCH"
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-605def5b80cso1485376137.2
        for <linux-iio@vger.kernel.org>; Tue, 21 Apr 2026 12:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776798564; x=1777403364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p2lthb7hspRQdClr5z+ClimHJxMC7lWM10n6ZXy/Zv0=;
        b=EMZkbzCH9nIbS3Ns5YHVS2nE4JRekvIXzbMSkUwrAEwwz+dLqa7HUQ8iWZhrKRZYgI
         2dXNxujlstQeHAKP8AYYPcMGiJQPsiQMPKflIyMhlsR+y5NZOqEJt5eOlSMGxkuRQ2hU
         7Jn30LFCBClB5+ppCDUGIynKrFG9RXBRd9SOEPQuyGutidZYWN/cUT9PY1C+UwtoF6pK
         2hhfJyE/MrPU25bRZY4kjCZaJIxCQw9pnCCSlrWmSOjSsdwUEH7aJp+mB+RINGTPo+4A
         zXDxWC2ab42deEzuNs1sIcs90CwWJ01eyiNRoWefKw8/NE0kqO7SQ378B7Pu+Gt+v2x/
         Z9mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776798564; x=1777403364;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p2lthb7hspRQdClr5z+ClimHJxMC7lWM10n6ZXy/Zv0=;
        b=oFuKl6qO2+DoKGR49StaEcJojcYO35tpuqCiKFTotGc0aJvV6OMfCGNYh7ZI88dhA1
         sqOKiACfdPiMk+FquYNaPp2KmIpOfOTpYTuVGE9qpIl458yDdu1uN4veZkee14Pe75VP
         DTPrvf8gcYg7bau5v1QfAxntHoYQs0rrh/sjmHSo+QFDjhgRdv83kEMUk9kvshQlqYEP
         z6UsteGWhswGQ/hwpPxTHl3FOshG9+14PHpzkKjshci1M+lDWYuajGilz3iGrUzStoti
         iq0OLPFta8u/Ge+z95AmsXcqZOiUn1A+d8sGbpghDY1ieSxEQgXV995i8iQS3QrW1XIV
         daMg==
X-Forwarded-Encrypted: i=1; AFNElJ9o1QHaXIWqF0C2+ffxxtZ4sTJMZj14lwGzNqAEi/vE1BNmWynxyVBKr7Di/IB424xzmD4TH+9pfJY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkLMth/ZkIQaR8UTyG++rm5p8w4knMvO3UlnSdRSxSXTJXaLVi
	r83tWBeryFAl0B83EaDs80FxE/OQzaRdcsTU5q61ASrOy4cr2fakgDiV
X-Gm-Gg: AeBDiesYHxU28H1BBM+yY5Nnw1jmP8jOSdvpBKcK84BTX9uXwU1FgvfCC7fn4xMaChk
	r+fKfNG09bN39lTKKn/FhejnZmgd9kRdVVWE06SbJhs3XCBgTHq/HgYJeIJLdOv676Gmb5T4+ql
	AxZFX9Ig4Dy1xw3E3q0u+xMF8j1QwUrb6pdxoIRb47SAvTjnB4l5SiS5YHjeen9oVUY7wHH9o2D
	GkdUYOuGSS9+rNqoKPrdugn3R2N8fy0BKrSxLQx970hRwJPX0FFETGxm8C2jJGmiBrIzaY4Xn4M
	I6clLgGKikEbusEhIw1YGlIdcuKnRSSYT5FIDTzHruCspURn98OqaLUN9GUBcY7+QEUvbBmtg5i
	SXYfQNb/nF+YHmA+OX7prSEz/phkeJsL0DrKpNL+3ytkeEbIw6d8HJBSS4oRy1a8GfVOO/GDXEQ
	r4Q+NMMcxHJSnFLTlfH6wZQkmSLTVZQBpD0tNxmceYhaGQp64=
X-Received: by 2002:a05:6102:5e94:b0:610:1239:f6d7 with SMTP id ada2fe7eead31-616f772efecmr8777622137.18.1776798563733;
        Tue, 21 Apr 2026 12:09:23 -0700 (PDT)
Received: from localhost.localdomain ([177.72.23.165])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-61747cb52c9sm7009613137.9.2026.04.21.12.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 12:09:22 -0700 (PDT)
From: Matheus Giarola <matheustpgiarola@gmail.com>
X-Google-Original-From: Matheus Giarola <matheusgiarola@usp.br>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	matheusgiarola@usp.br,
	arthurpilone@usp.br,
	davidbtadokoro@ime.usp.br
Subject: [PATCH v5] iio: adc: ad7280a: replace mutex_lock() with guard(mutex)
Date: Tue, 21 Apr 2026 16:08:55 -0300
Message-ID: <20260421190855.24132-1-matheusgiarola@usp.br>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use guard(mutex) instead of mutex_lock()/mutex_unlock(),
ensuring the mutex is released automatically when leaving
the function scope. The change improves error handling and
avoids issues such as missing unlocks. It also simplifies the
code by removing 'err_unlock' label and several mutex_unlock()
calls.

As suggested, in ad7280_read_raw(), wrap the IIO_CHAN_INFO_RAW
case in braces, providing a scope for the implicit variable
declared by guard(mutex).

Also, limit guard(mutex) scope in ad7280_show_balance_timer()
to keep it locked just when necessary.

In ad7280a_write_thresh(), replace break with return on error.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Matheus Giarola <matheusgiarola@usp.br>
---
v5:
- replace braces with scoped_guard() in ad7280_show_balance_timer()
- replace breaks with return on error in ad7280a_write_thresh()

v4:
- limit guard(mutex) scope in ad7280_show_balance_timer()

v3:
- correct v2 patch tags

v2:
- fix missing scope in ad7280_read_raw() by wrapping IIO_CHAN_INFO_RAW
  case in braces so as to fix build errors.

 drivers/iio/adc/ad7280a.c | 43 ++++++++++++++++-----------------------
 1 file changed, 17 insertions(+), 26 deletions(-)

diff --git a/drivers/iio/adc/ad7280a.c b/drivers/iio/adc/ad7280a.c
index f50e2b3121bf..156309d2449c 100644
--- a/drivers/iio/adc/ad7280a.c
+++ b/drivers/iio/adc/ad7280a.c
@@ -496,7 +496,7 @@ static ssize_t ad7280_store_balance_sw(struct iio_dev *indio_dev,
 	devaddr = chan->address >> 8;
 	ch = chan->address & 0xFF;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 	if (readin)
 		st->cb_mask[devaddr] |= BIT(ch);
 	else
@@ -505,7 +505,6 @@ static ssize_t ad7280_store_balance_sw(struct iio_dev *indio_dev,
 	ret = ad7280_write(st, devaddr, AD7280A_CELL_BALANCE_REG, 0,
 			   FIELD_PREP(AD7280A_CELL_BALANCE_CHAN_BITMAP_MSK,
 				      st->cb_mask[devaddr]));
-	mutex_unlock(&st->lock);
 
 	return ret ? ret : len;
 }
@@ -519,10 +518,10 @@ static ssize_t ad7280_show_balance_timer(struct iio_dev *indio_dev,
 	unsigned int msecs;
 	int ret;
 
-	mutex_lock(&st->lock);
-	ret = ad7280_read_reg(st, chan->address >> 8,
+	scoped_guard(mutex, &st->lock) {
+		ret = ad7280_read_reg(st, chan->address >> 8,
 			      (chan->address & 0xFF) + AD7280A_CB1_TIMER_REG);
-	mutex_unlock(&st->lock);
+	}
 
 	if (ret < 0)
 		return ret;
@@ -551,11 +550,10 @@ static ssize_t ad7280_store_balance_timer(struct iio_dev *indio_dev,
 	if (val > 31)
 		return -EINVAL;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 	ret = ad7280_write(st, chan->address >> 8,
 			   (chan->address & 0xFF) + AD7280A_CB1_TIMER_REG, 0,
 			   FIELD_PREP(AD7280A_CB_TIMER_VAL_MSK, val));
-	mutex_unlock(&st->lock);
 
 	return ret ? ret : len;
 }
@@ -737,7 +735,7 @@ static int ad7280a_write_thresh(struct iio_dev *indio_dev,
 	if (val2 != 0)
 		return -EINVAL;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 	switch (chan->type) {
 	case IIO_VOLTAGE:
 		value = ((val - 1000) * 100) / 1568; /* LSB 15.68mV */
@@ -748,7 +746,7 @@ static int ad7280a_write_thresh(struct iio_dev *indio_dev,
 			ret = ad7280_write(st, AD7280A_DEVADDR_MASTER, addr,
 					   1, value);
 			if (ret)
-				break;
+				return ret;
 			st->cell_threshhigh = value;
 			break;
 		case IIO_EV_DIR_FALLING:
@@ -756,12 +754,11 @@ static int ad7280a_write_thresh(struct iio_dev *indio_dev,
 			ret = ad7280_write(st, AD7280A_DEVADDR_MASTER, addr,
 					   1, value);
 			if (ret)
-				break;
+				return ret;
 			st->cell_threshlow = value;
 			break;
 		default:
-			ret = -EINVAL;
-			goto err_unlock;
+			return -EINVAL;
 		}
 		break;
 	case IIO_TEMP:
@@ -773,7 +770,7 @@ static int ad7280a_write_thresh(struct iio_dev *indio_dev,
 			ret = ad7280_write(st, AD7280A_DEVADDR_MASTER, addr,
 					   1, value);
 			if (ret)
-				break;
+				return ret;
 			st->aux_threshhigh = value;
 			break;
 		case IIO_EV_DIR_FALLING:
@@ -781,23 +778,17 @@ static int ad7280a_write_thresh(struct iio_dev *indio_dev,
 			ret = ad7280_write(st, AD7280A_DEVADDR_MASTER, addr,
 					   1, value);
 			if (ret)
-				break;
+				return ret;
 			st->aux_threshlow = value;
 			break;
 		default:
-			ret = -EINVAL;
-			goto err_unlock;
+			return -EINVAL;
 		}
 		break;
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
+	return 0;
 }
 
 static irqreturn_t ad7280_event_handler(int irq, void *private)
@@ -884,14 +875,13 @@ static int ad7280_read_raw(struct iio_dev *indio_dev,
 	int ret;
 
 	switch (m) {
-	case IIO_CHAN_INFO_RAW:
-		mutex_lock(&st->lock);
+	case IIO_CHAN_INFO_RAW: {
+		guard(mutex)(&st->lock);
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

