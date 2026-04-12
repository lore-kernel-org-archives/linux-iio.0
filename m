Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CADEEC3
	for <linux-iio@vger.kernel.org>; Sun, 12 Apr 2026 15:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776008890; cv=none; b=qIOqVBxbeKQpqWpJWVtjdmBbTAeVfUCkWSG2PP60twyAw4whBBm8ltA/HlR/aDXwuEiR4QLcqbYpFGbku+vHXNMubffjrAGwsCKC+elMdgPerSR5zRiU/WEqRsdd3b1kLUYoJvjH+omj/uFdI6HqG2YzK1ZJYZL3Kdlf2JN5tOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776008890; c=relaxed/simple;
	bh=UVmeS6iniJduqFpUJAvxPU8hRBQo/JsjZhnTW4jDMlA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nSVVPiTjEdS4SYROdqYHfTQdg5XZXq93qLhmCJ8y9QL5vsNBtlbw/HGS6+/ICvQxbNB6kGOu5I6QcnTFV7ha/WpnWLB+jY11k6w6AmR3rUm++eJQsomPwcNDICrtqv4UNuocNSs9TUxwszDaPz1eDLa++ZilUP4UhcWsX+l0DA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nU6OHp8B; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nU6OHp8B"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2d8ffdc31d0so403054eec.0
        for <linux-iio@vger.kernel.org>; Sun, 12 Apr 2026 08:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776008889; x=1776613689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kUbQdvdf8km/rzPCn3acJIK+ibdfhCrcGrCDLCQq7kM=;
        b=nU6OHp8BpvuSL1wE2MRWeuESuQjIScbZWQUqNjgaxZyHOdWF6CphNzlvusYXf5yCwl
         ZU8ZObWApyrQIMJCw80gSDgl+qNIz1XSxiCA9UBhOvY8XEURJ5idcwULMbmQKRwn1Dwz
         pDUe5jIVLDEvsWXJiqew58HSwbfOEvfwcuZdfuRgzH9j8jwbasOM2kWFigoToCxD1OWe
         ezvGr4Y/ZPFl/iSAnbE78/M58DDbZZ0P+8iXijkXSt1+UTaQdhNvPyy8rOE9EYFYghSq
         iS5qvI0kSL7ovnDvWB/2wyZB+UIGKTBBkbwSnIcirhz0M3ZQ8NaoGgJHoLWJ5gLOt+83
         EOtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776008889; x=1776613689;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kUbQdvdf8km/rzPCn3acJIK+ibdfhCrcGrCDLCQq7kM=;
        b=sR+qWsNsaNCeoaVfjYCc7f++VfhRyZ9iTodOPw/PtL582ZtMv3gMPd72AsACGEQ+qz
         lGm7wnxm51fjLi5VFE/3O7wOhDnOtf4h4KufeurakaYfaMt5w2EtXp2+wcJkQ/O5CMsM
         MGV3SFcUNUdNeJn0cr8VkO9gM5uZimxwM5JK0zfSYaseB/4JPHL5LYp8ZImehvQaTlYY
         tTc7f+tP3iDomYkUmMWbIxuEegsuRxsKGqR1CskR+RFpRdFIfyOylFSE/527mxYKqLiY
         +UObJToQhcYQEN6eimb+jjDuQRjJgUBeC5CFYu/5XtiWzYK8JQzB888fLZ98x+f3kK5L
         ALAg==
X-Forwarded-Encrypted: i=1; AFNElJ8kzW2N2smDz1U9tXTZqGgIeYHH/FsEifioRKWuDYbhEan8yKOqhXPL1grtUAahlgM5VELrS48V6kQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF0sCaEypmk4dzmjiUsq4sFzsAn0yAISLbk2fPak0NyKG5BUzC
	GhH6DaBxJ9Nsg1fhQOGzC+K3vxZgAIyvGC5vuXHInxRmPQr3ySamg4N9
X-Gm-Gg: AeBDievjAwOKl5fzZmmndRfrtd9RS/KIl1PVt1dTTOF6k88TF7f9BhUIAm8Mk15FiDJ
	U7ZE1dd+el6Fapjk3oGNvlXYAwgDFvhkZPlrhOQnigDijd3z7IWMQDFDOUWCjGVygJRFPLuRmFK
	jzaB/Zzlvn2PzU8Holzy9wNB2D8kmnbmLL8SISJMl0G8JaV1g9GbfOe7NCwFdKdkViSgC00Erd1
	MntZzLjixd6pIaPK6OkPb+4oFir2kIpHRsfa+nud0UEY2SVZn1O1qN5ItZtYkIYuQq6dDPHv+k7
	RLWS9K6j4+5Pp4LW2psu5a950h6o1FmYg8HcPBvQdTXwIKxy31++qKdOaPE8cLmzwOROe3BInQt
	Ni9khlXz8agF5ANTcY1XJ4UNTEbnV31cvV/MseKg+hUYfXaXQ1kuxSj8TkHjRxT0H6gO0eK4UTL
	2BHT/RrJIfN4xccTTF1iqC7+McDB3i4RW5SHr8
X-Received: by 2002:a05:693c:2c8d:b0:2d1:93b8:bc81 with SMTP id 5a478bee46e88-2d5893632cfmr5331946eec.31.1776008888590;
        Sun, 12 Apr 2026 08:48:08 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:38:8c29:c41:ee70:537c:acf5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d5627c44fcsm13272910eec.23.2026.04.12.08.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 08:48:07 -0700 (PDT)
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
Subject: [PATCH v4] iio: adc: ad7280a: replace mutex_lock() with guard(mutex)
Date: Sun, 12 Apr 2026 12:47:48 -0300
Message-ID: <20260412154748.24937-1-matheusgiarola@usp.br>
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

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Matheus Giarola <matheusgiarola@usp.br>
---
v4:
- limit guard(mutex) scope in ad7280_show_balance_timer()

v3:
- correct v2 patch tags

v2:
- fix missing scope in ad7280_read_raw() by wrapping IIO_CHAN_INFO_RAW
  case in braces so as to fix build errors.

 drivers/iio/adc/ad7280a.c | 34 +++++++++++++---------------------
 1 file changed, 13 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/adc/ad7280a.c b/drivers/iio/adc/ad7280a.c
index ba12a3796e2b..f3cbf8810daa 100644
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
@@ -519,10 +518,11 @@ static ssize_t ad7280_show_balance_timer(struct iio_dev *indio_dev,
 	unsigned int msecs;
 	int ret;
 
-	mutex_lock(&st->lock);
-	ret = ad7280_read_reg(st, chan->address >> 8,
+	{
+		guard(mutex)(&st->lock);
+		ret = ad7280_read_reg(st, chan->address >> 8,
 			      (chan->address & 0xFF) + AD7280A_CB1_TIMER_REG);
-	mutex_unlock(&st->lock);
+	}
 
 	if (ret < 0)
 		return ret;
@@ -551,11 +551,10 @@ static ssize_t ad7280_store_balance_timer(struct iio_dev *indio_dev,
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
@@ -737,7 +736,7 @@ static int ad7280a_write_thresh(struct iio_dev *indio_dev,
 	if (val2 != 0)
 		return -EINVAL;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 	switch (chan->type) {
 	case IIO_VOLTAGE:
 		value = ((val - 1000) * 100) / 1568; /* LSB 15.68mV */
@@ -760,8 +759,7 @@ static int ad7280a_write_thresh(struct iio_dev *indio_dev,
 			st->cell_threshlow = value;
 			break;
 		default:
-			ret = -EINVAL;
-			goto err_unlock;
+			return -EINVAL;
 		}
 		break;
 	case IIO_TEMP:
@@ -785,18 +783,12 @@ static int ad7280a_write_thresh(struct iio_dev *indio_dev,
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
 	return ret;
 }
 
@@ -884,14 +876,13 @@ static int ad7280_read_raw(struct iio_dev *indio_dev,
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
@@ -899,6 +890,7 @@ static int ad7280_read_raw(struct iio_dev *indio_dev,
 		*val = ret;
 
 		return IIO_VAL_INT;
+	}
 	case IIO_CHAN_INFO_SCALE:
 		if ((chan->address & 0xFF) <= AD7280A_CELL_VOLTAGE_6_REG)
 			*val = 4000;
-- 
2.47.3

