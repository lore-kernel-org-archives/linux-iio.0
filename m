Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB653A7F51
	for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2026 18:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776708311; cv=none; b=NUauHQwarcOJ/kxyriMrkxySMKOZY4/hHoixVYqybalxs6Hhgn9P2JCnjLAPN0zIGM2MJU8mNeq0CkFu25TPCLl7VQguckqTrQkla7THLhcP3Zt76hM3rfZNUeRCegmZN8c9Us+de/NpGALfq0wBpRoh9TgPQUIFg2h5HoagpIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776708311; c=relaxed/simple;
	bh=LuGnH4hzEMTnTS7YIjzxJFZgLsMnmktJZtMCLupbnxE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iF4xETOwk8edm9GZf52Uz3PK81iYCDF4J90n5L8JCOhrrqLPHqqgrtctDwQJmDBQBLNqex1G9CRL5LElG5HPVtgUNJYrTBhtfBmFyB2nofBZ+DsawPrm8JM0NmOyB9bI2zirS20KlZKbEjplgQNykQC8drvCnwL4qDbfQqkqUvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=VXyRVFYK; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="VXyRVFYK"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2e622a9da9cso483442eec.0
        for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2026 11:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1776708308; x=1777313108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4GGlMlvCzISt5vZFavV2ul+ySHoLmnzcFgXDFqIGnF0=;
        b=VXyRVFYKNkJl9pYZPpNt2zyDz1GFXDbG4zBIuPBm036q5OjUMf1KPpJG/rTdZ307Y6
         SKTvRErfq47Yc89KP0B+fWS3NWVJnzasX0aaS9GSjIM/S0L6LoLx+/J0vqCy5+EbLUz5
         Q1ssiPq5LG9o4fU+NJhDXSbodjK9ZJYXqLO3mRar/IvaCcFp0K18ESI2ePT5I3yly5SP
         DXlykVJkYW8/dNfZtzG+VJUBBCX/2HEjRxtUozwnugvhFohuLJHz7gXFfYzqNES0FMgX
         cqXXl+kWcKSnYZ3W1dleDJBDouOCnfDmNIpwAHnj/Nkx1qhE9azy9h1w11FUc+Wd5VYv
         VRHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776708308; x=1777313108;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4GGlMlvCzISt5vZFavV2ul+ySHoLmnzcFgXDFqIGnF0=;
        b=Q7XmzZKqy5t4pi8tNZ8s1rILP8Fgzw0TjyCle8f4DqF2zHcff3Hdv1O66iFlR4SFI/
         rDrbp8hnu1FQar7sFqTpwmTI/1xN3njmGUeRJVWPjjNuqUb3xrd4BkdmQTI/8kgA6P90
         c5OMS7W779blW6XJwq1zIbIoJ6msIkRkkw5lcBrOXLd95DHwqxdAP5KqUvfRSAHXo1Jo
         KwLdMs40jqasE8smUbx4pRrtNX+q3oJoHx6DE1YXp+QhQqlpXj4E+Z84YMG/2cOmANl9
         HaETq2+Jc+OnU45HtId7glV+134UfX89kARphtkC9YNak5b/nHay/B9H88MYbRay2VdC
         wtdw==
X-Forwarded-Encrypted: i=1; AFNElJ+BCm/D8bMxTeskBPq8uJqOZ+li/ilbaNLaYkOorAQEbO9c7GoKJFq+idefnfmqLPTGsdGWvJAn+04=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYkxMKgzCZNXEk0bOUQSxqDnT0Sp3MVIDrW2Yu53CqGM2gPC74
	rkbQs1/p4WoEMMk7ZlI4Mp8cTTsy3g7aFkU3UYoJLMCFmodjoUp1Yz+G92xoeSl2lyM=
X-Gm-Gg: AeBDietYSWwBzqd0ahoXfkwvxp5QUCTz8EwmxvS9a19xE54f7THYQk0eRP2E8rH6QFt
	s+PTUTeOftjW7+cyUtYkbQ55xn8szclpl5RrHRLH1hlZMpzYMx0bO2xNSNbqfIo7S9aepFGQhei
	329N6cXc/CkW9KY72sUyLjHLcMAL9axJ+242kYJsRFuzZztGoLrrhHV9oSwfudDX3kACVRk3ERR
	AvSdnXIOtBNaAkRpdPevB41BMfybA4WC+FPB+SfA1hpv10VstUjyRPhN3+j1bV6uDJseCKFD5KJ
	3OONmn27qLCUvJw3lDSLy2uD4QDgW6Ex37JWIpfHLS7R7GH09viIcYjc5/inTI4xUv3AlvxgFJU
	MF3Nqw0RW4L1PABNOhdLNBxNpueJuHbqKZGzkrIztg6Uort1Xf/IjZ19IN7qxzYgZ3auMZBWv8N
	g2NXI=
X-Received: by 2002:a05:7300:2203:b0:2d9:7bc4:9578 with SMTP id 5a478bee46e88-2e47951a762mr10687294eec.28.1776708307724;
        Mon, 20 Apr 2026 11:05:07 -0700 (PDT)
Received: from yukhui ([2804:7f0:74c0:1181:3c74:f735:adc:a3a9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53ac84c38sm15880949eec.13.2026.04.20.11.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 11:05:07 -0700 (PDT)
From: Raffael Raiel Trindade <raffaelraiel@usp.br>
X-Google-Original-From: Raffael Raiel Trindade
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: Raffael Raiel Trindade <raffaelraiel@usp.br>,
	Kim Carvalho <kim.ca@usp.br>,
	linux-iio@vger.kernel.org
Subject: [PATCH v2] iio: light: vcnl4000: use lock guard()
Date: Mon, 20 Apr 2026 15:00:31 -0300
Message-ID: <20260420180454.90611-1-raffaelraiel@usp.br>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Raffael Raiel Trindade <raffaelraiel@usp.br>

Use guard() for handling mutex lock instead of manually locking and
unlocking. Remove gotos in error handling logic. This prevents forgotten
locks on early exits.

Signed-off-by: Raffael Raiel Trindade <raffaelraiel@usp.br>
Co-developed-by: Kim Carvalho <kim.ca@usp.br>
Signed-off-by: Kim Carvalho <kim.ca@usp.br>
---
v2:
 - use direct returns
 - remove unnecessary ret attributions
 - remove unnecessary breaks on switch

 drivers/iio/light/vcnl4000.c | 52 +++++++++++-------------------------
 1 file changed, 16 insertions(+), 36 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index c08927e34b4e..61428285c8b6 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -18,6 +18,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/i2c.h>
@@ -268,46 +269,36 @@ static ssize_t vcnl4000_write_als_enable(struct vcnl4000_data *data, bool en)
 {
 	int ret;
 
-	mutex_lock(&data->vcnl4000_lock);
+	guard(mutex)(&data->vcnl4000_lock);
 
 	ret = i2c_smbus_read_word_data(data->client, VCNL4200_AL_CONF);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	if (en)
 		ret &= ~VCNL4040_ALS_CONF_ALS_SHUTDOWN;
 	else
 		ret |= VCNL4040_ALS_CONF_ALS_SHUTDOWN;
 
-	ret = i2c_smbus_write_word_data(data->client, VCNL4200_AL_CONF, ret);
-
-out:
-	mutex_unlock(&data->vcnl4000_lock);
-
-	return ret;
+	return i2c_smbus_write_word_data(data->client, VCNL4200_AL_CONF, ret);
 }
 
 static ssize_t vcnl4000_write_ps_enable(struct vcnl4000_data *data, bool en)
 {
 	int ret;
 
-	mutex_lock(&data->vcnl4000_lock);
+	guard(mutex)(&data->vcnl4000_lock);
 
 	ret = i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF1);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	if (en)
 		ret &= ~VCNL4040_PS_CONF1_PS_SHUTDOWN;
 	else
 		ret |= VCNL4040_PS_CONF1_PS_SHUTDOWN;
 
-	ret = i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF1, ret);
-
-out:
-	mutex_unlock(&data->vcnl4000_lock);
-
-	return ret;
+	return i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF1, ret);
 }
 
 static int vcnl4200_set_power_state(struct vcnl4000_data *data, bool on)
@@ -660,20 +651,16 @@ static ssize_t vcnl4040_write_ps_it(struct vcnl4000_data *data, int val)
 
 	data->vcnl4200_ps.sampling_rate = ktime_set(0, val * 60 * NSEC_PER_USEC);
 
-	mutex_lock(&data->vcnl4000_lock);
+	guard(mutex)(&data->vcnl4000_lock);
 
 	ret = i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF1);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	regval = (ret & ~VCNL4040_PS_CONF2_PS_IT) |
 	    FIELD_PREP(VCNL4040_PS_CONF2_PS_IT, index);
-	ret = i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF1,
+	return i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF1,
 					regval);
-
-out:
-	mutex_unlock(&data->vcnl4000_lock);
-	return ret;
 }
 
 static ssize_t vcnl4040_read_als_period(struct vcnl4000_data *data, int *val, int *val2)
@@ -1480,13 +1467,13 @@ static int vcnl4040_write_event_config(struct iio_dev *indio_dev,
 	u16 val, mask;
 	struct vcnl4000_data *data = iio_priv(indio_dev);
 
-	mutex_lock(&data->vcnl4000_lock);
+	guard(mutex)(&data->vcnl4000_lock);
 
 	switch (chan->type) {
 	case IIO_LIGHT:
 		ret = i2c_smbus_read_word_data(data->client, VCNL4200_AL_CONF);
 		if (ret < 0)
-			goto out;
+			return ret;
 
 		mask = VCNL4040_ALS_CONF_INT_EN;
 		if (state)
@@ -1495,13 +1482,12 @@ static int vcnl4040_write_event_config(struct iio_dev *indio_dev,
 			val = (ret & ~mask);
 
 		data->als_int = FIELD_GET(VCNL4040_ALS_CONF_INT_EN, val);
-		ret = i2c_smbus_write_word_data(data->client, VCNL4200_AL_CONF,
+		return i2c_smbus_write_word_data(data->client, VCNL4200_AL_CONF,
 						val);
-		break;
 	case IIO_PROXIMITY:
 		ret = i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF1);
 		if (ret < 0)
-			goto out;
+			return ret;
 
 		if (dir == IIO_EV_DIR_RISING)
 			mask = VCNL4040_PS_IF_AWAY;
@@ -1511,17 +1497,11 @@ static int vcnl4040_write_event_config(struct iio_dev *indio_dev,
 		val = state ? (ret | mask) : (ret & ~mask);
 
 		data->ps_int = FIELD_GET(VCNL4040_PS_CONF2_PS_INT, val);
-		ret = i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF1,
+		return i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF1,
 						val);
-		break;
 	default:
-		break;
+		return ret;
 	}
-
-out:
-	mutex_unlock(&data->vcnl4000_lock);
-
-	return ret;
 }
 
 static irqreturn_t vcnl4040_irq_thread(int irq, void *p)
-- 
2.51.0

