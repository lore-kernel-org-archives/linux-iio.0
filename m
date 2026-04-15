Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C172F38AC66
	for <linux-iio@vger.kernel.org>; Wed, 15 Apr 2026 20:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776285235; cv=none; b=lfcOz7eUpLntMC4mOjU5WsebNmLJA/oQ+SMJq3RJdqJkmv0f57Yn1n0qPP/eYMW6Qpi8w4s3pvsReR7IVuuL1ZYU/FiUYt09PsrJ2JiGkj1LFuVB0CT15NKV2u72dSrhHNQ0P/hMW5GQMi2S7+0Vb75okVDFUQi3QTfR6O9s4sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776285235; c=relaxed/simple;
	bh=GrFS+uhbYPLaoxRZXAiJLxRKsFf6jC5JrGJgLJ2vHv8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EmstCLrNcj0MHZQQc+dcjXe8cyfLZrmo37oVyKo9zkDJiRprTzB1KjaPFaEQA3RkFYLk93I9zbwIgY93hOU4dipuVq9tJJJXVnV4dVo53aj+i/Foi8mz4+6/JGmd+UrxdAyfgLTlT73+bstvvjArQEgd/wzRHrHr9N0dQJVGoxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=XcHUeuFX; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="XcHUeuFX"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-12c63e942f3so275430c88.0
        for <linux-iio@vger.kernel.org>; Wed, 15 Apr 2026 13:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1776285232; x=1776890032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uiN/YWo346AZJ4RgSuGvauRceV29UaujpWoY/FwbLo4=;
        b=XcHUeuFXCxTuzp/ySIiZRSpjKIVC1rdzqSCzXejgtd7yWQG04W9vQwVj1a21Acsz2q
         XVphODaQW5Ulj1tFDKSCeymorKD9x01KyYv9vK3qNYE0IKrwFkBeA8HBxv0HmtR/ybbw
         BYnrlU5FrbYOb5O3/1btp3LPCKVs8chBbk5Vh/FjRhzBXQa7bwruq9QoihVHeTnaRuhv
         F299jLMQO53q5xJLZ+5ZotbDUdJ1dwR+Qe+eRYQPKu41v1+h+xEPU6ak/0LLEEJJ7WiP
         3zzNVQgHKuMQ6pYtD9wrpfM28muqFVMgs9/Aqxtf1egB2P/TwPAqlFiFbJNIobsiR61A
         a4QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776285232; x=1776890032;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uiN/YWo346AZJ4RgSuGvauRceV29UaujpWoY/FwbLo4=;
        b=htXiKeGYSWSM8B5uTAuVLOTCUp/hsi0A3bXgKocRv9pVz4GTfPUVH8ct5kB877JBWJ
         jgswqPP2WZfoWP0piwpTEkffli/wwRKf8efymcauDNydvjoTpQFm4ifzhWZ3yZQeZT0H
         JCRfElOiYy1dguwDw0r88HMMjZz7nhb5zFv5AyVys/PMLIrV9HmPd605vuJmfrGhOHpv
         USYbzObYQV/soaz1YLz9aP7Gcg6HG/rOF4qj2OuoSouMSqYTIgvUvfJH8Deon4RWvy/u
         GQkX9dPTRaUFbnBK5ICpnT8p38sn5vt5NLOfpvjekQrFWEbx0A3aUaXqMpGmdviJcxgh
         37Nw==
X-Forwarded-Encrypted: i=1; AFNElJ+UyzU6/8oKR44gFZa1WBvvJfL5Bfac4r3WW6va2lqxz4c+3Zmplk7TgZPcbOWwPMhbCs4lP14chA8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ06g5mGouNNxLR3/qQqncvkY76zZcmgsVyOmQQKu00a6PQ9Tu
	cgO7Ir7bXxfkySBJtSA8ysr5qr/zfFldg3ybrE5M1+aDn4qnwt4n5wEip2X8PBp+ay53l68JWTP
	SEbcT0gY8yA==
X-Gm-Gg: AeBDiesRqf/hlzeysX9Q9oNIb1mjfK/Ui7hqIe3BfY+3afEQOsVNmr+ZfrgO8p7eSep
	TjSALDsponQjxFwog8+Zria2z2B89vQVlRq6A822Vvki34/re+msB/vaCCKTzpYOn7xxouSfSOZ
	lxk5WIing2h72ArWTK0aAsUmJ/ixmsbPIinkNNuIqd1Cy62oTwg6DtvNX8qOT9NDGDLjGYYcch9
	J0/GW41zcMUgup+8e1cs4vJblVt6UBRHqeYk6+14czpOSrItVXrF4TVOvy9ubQA5z4hUYSsVeV2
	bv7MmQiZeN9L3N9M+GNDa4ZTT700hETk4Iw+egV0ZQh36qZGeEkW07snPoI7AH0ZRBKyefSdl2M
	91hNajVndaEfA3qr8jD5/RD6v/WffPuv7y2vV75P/fto8XU6PC9yiwT+ZuKnLZZ9YwzREVGe8+H
	5E/tEKzsYFoyzakFhEjsfRtM9K8dESwUtD7odeiqE/pPgb
X-Received: by 2002:a05:7300:d4ce:b0:2dd:5641:ef2 with SMTP id 5a478bee46e88-2dd5641154bmr4105967eec.25.1776285231577;
        Wed, 15 Apr 2026 13:33:51 -0700 (PDT)
Received: from sales-arch.semfio.usp.br (nat.ime.usp.br. [143.107.45.1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2de8c605883sm4135448eec.10.2026.04.15.13.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 13:33:51 -0700 (PDT)
From: rafasales@usp.br
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: "Rafael B. Sales" <rafasales@usp.br>,
	"Gustavo C. Arakaki" <gustavo.arakaki@usp.br>,
	linux-iio@vger.kernel.org
Subject: [PATCH] iio: light: ltr501: Use automatic cleanup of locks
Date: Wed, 15 Apr 2026 17:33:30 -0300
Message-ID: <20260415203345.195557-1-rafasales@usp.br>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Rafael B. Sales" <rafasales@usp.br>

Replace `mutex_lock` and `mutex_unlock` with `guard(mutex)` and
scoped_guard(mutex)` to reduce boilerplate and allow for
easy-to-read code blocks.

Signed-off-by: Rafael B. Sales <rafasales@usp.br>
Co-developed-by: Gustavo C. Arakaki <gustavo.arakaki@usp.br>
Signed-off-by: Gustavo C. Arakaki <gustavo.arakaki@usp.br>
---
 drivers/iio/light/ltr501.c | 44 +++++++++++++-------------------------
 1 file changed, 15 insertions(+), 29 deletions(-)

diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index 4d99ae336f61..b9aae948ad3b 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -242,9 +242,8 @@ static int ltr501_als_write_samp_freq(struct ltr501_data *data,
 	if (i < 0)
 		return i;
 
-	mutex_lock(&data->lock_als);
+	guard(mutex)(&data->lock_als);
 	ret = regmap_field_write(data->reg_als_rate, i);
-	mutex_unlock(&data->lock_als);
 
 	return ret;
 }
@@ -261,9 +260,8 @@ static int ltr501_ps_write_samp_freq(struct ltr501_data *data,
 	if (i < 0)
 		return i;
 
-	mutex_lock(&data->lock_ps);
+	guard(mutex)(&data->lock_ps);
 	ret = regmap_field_write(data->reg_ps_rate, i);
-	mutex_unlock(&data->lock_ps);
 
 	return ret;
 }
@@ -487,9 +485,8 @@ static int ltr501_write_intr_prst(struct ltr501_data *data,
 		if (new_val < 0 || new_val > 0x0f)
 			return -EINVAL;
 
-		mutex_lock(&data->lock_als);
+		guard(mutex)(&data->lock_als);
 		ret = regmap_field_write(data->reg_als_prst, new_val);
-		mutex_unlock(&data->lock_als);
 		if (ret >= 0)
 			data->als_period = period;
 
@@ -507,9 +504,8 @@ static int ltr501_write_intr_prst(struct ltr501_data *data,
 		if (new_val < 0 || new_val > 0x0f)
 			return -EINVAL;
 
-		mutex_lock(&data->lock_ps);
+		guard(mutex)(&data->lock_ps);
 		ret = regmap_field_write(data->reg_ps_prst, new_val);
-		mutex_unlock(&data->lock_ps);
 		if (ret >= 0)
 			data->ps_period = period;
 
@@ -651,18 +647,16 @@ static int ltr501_read_info_raw(struct ltr501_data *data,
 
 	switch (chan->type) {
 	case IIO_INTENSITY:
-		mutex_lock(&data->lock_als);
+		guard(mutex)(&data->lock_als);
 		ret = ltr501_read_als(data, buf);
-		mutex_unlock(&data->lock_als);
 		if (ret < 0)
 			return ret;
 		*val = le16_to_cpu(chan->address == LTR501_ALS_DATA1 ?
 				   buf[0] : buf[1]);
 		return IIO_VAL_INT;
 	case IIO_PROXIMITY:
-		mutex_lock(&data->lock_ps);
+		guard(mutex)(&data->lock_ps);
 		ret = ltr501_read_ps(data);
-		mutex_unlock(&data->lock_ps);
 		if (ret < 0)
 			return ret;
 		*val = ret & LTR501_PS_DATA_MASK;
@@ -687,9 +681,8 @@ static int ltr501_read_raw(struct iio_dev *indio_dev,
 			if (!iio_device_claim_direct(indio_dev))
 				return -EBUSY;
 
-			mutex_lock(&data->lock_als);
-			ret = ltr501_read_als(data, buf);
-			mutex_unlock(&data->lock_als);
+			scoped_guard(mutex, &data->lock_als)
+				ret = ltr501_read_als(data, buf);
 			iio_device_release_direct(indio_dev);
 			if (ret < 0)
 				return ret;
@@ -802,9 +795,8 @@ static int __ltr501_write_raw(struct iio_dev *indio_dev,
 			if (val != 0)
 				return -EINVAL;
 
-			mutex_lock(&data->lock_als);
+			guard(mutex)(&data->lock_als);
 			ret = ltr501_set_it_time(data, val2);
-			mutex_unlock(&data->lock_als);
 			return ret;
 		default:
 			return -EINVAL;
@@ -953,18 +945,16 @@ static int ltr501_write_thresh(struct iio_dev *indio_dev,
 			return -EINVAL;
 		switch (dir) {
 		case IIO_EV_DIR_RISING:
-			mutex_lock(&data->lock_als);
+			guard(mutex)(&data->lock_als);
 			ret = regmap_bulk_write(data->regmap,
 						LTR501_ALS_THRESH_UP,
 						&val, 2);
-			mutex_unlock(&data->lock_als);
 			return ret;
 		case IIO_EV_DIR_FALLING:
-			mutex_lock(&data->lock_als);
+			guard(mutex)(&data->lock_als);
 			ret = regmap_bulk_write(data->regmap,
 						LTR501_ALS_THRESH_LOW,
 						&val, 2);
-			mutex_unlock(&data->lock_als);
 			return ret;
 		default:
 			return -EINVAL;
@@ -974,18 +964,16 @@ static int ltr501_write_thresh(struct iio_dev *indio_dev,
 			return -EINVAL;
 		switch (dir) {
 		case IIO_EV_DIR_RISING:
-			mutex_lock(&data->lock_ps);
+			guard(mutex)(&data->lock_ps);
 			ret = regmap_bulk_write(data->regmap,
 						LTR501_PS_THRESH_UP,
 						&val, 2);
-			mutex_unlock(&data->lock_ps);
 			return ret;
 		case IIO_EV_DIR_FALLING:
-			mutex_lock(&data->lock_ps);
+			guard(mutex)(&data->lock_ps);
 			ret = regmap_bulk_write(data->regmap,
 						LTR501_PS_THRESH_LOW,
 						&val, 2);
-			mutex_unlock(&data->lock_ps);
 			return ret;
 		default:
 			return -EINVAL;
@@ -1082,14 +1070,12 @@ static int ltr501_write_event_config(struct iio_dev *indio_dev,
 
 	switch (chan->type) {
 	case IIO_INTENSITY:
-		mutex_lock(&data->lock_als);
+		guard(mutex)(&data->lock_als);
 		ret = regmap_field_write(data->reg_als_intr, state);
-		mutex_unlock(&data->lock_als);
 		return ret;
 	case IIO_PROXIMITY:
-		mutex_lock(&data->lock_ps);
+		guard(mutex)(&data->lock_ps);
 		ret = regmap_field_write(data->reg_ps_intr, state);
-		mutex_unlock(&data->lock_ps);
 		return ret;
 	default:
 		return -EINVAL;
-- 
2.53.0

