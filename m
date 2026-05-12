Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4260317153
	for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 18:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778611671; cv=none; b=gx4Dbatirwt+NoDuiotI0KjifjnBOQR+Wf4w0udTOoYYtISoWnlkPNdXa57LRH3c1JXiMfrcq1jTThQf2f71YBi6QSXTpVy8u+hfRGMyG8yRCjzD9tjBJuferwEE1MfCD8cjRdakL43CWUJuLMlY+NrJ2asUSxvMSUqPAmWmb0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778611671; c=relaxed/simple;
	bh=BDsdMP+pjZG4vSXOF6ecFDXwYRlu+D0/7JwopaiEhcg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bpLPFgRImsBhIPx0G31Tf7fJrTXDXfCDd8YeKPHYOkw88vyskIxQ0duGXYAOTzNHqd5PlSpCQtpsj3CE5qKbml6k/SQO3ZD8T1hZ641SSLox/cMkmBR4z4x+fgYqNaHvx6XX6RO/uNgKm/KELNWH1VgKZyZCNpwhvIgUUjEUpS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=x8fC7wAz; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="x8fC7wAz"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-575267e3398so4134468e0c.1
        for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 11:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1778611667; x=1779216467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=isdotys3vsn+u1Oh8//bwlSjZMntjd7+ukLze9DPOz0=;
        b=x8fC7wAzDT9710lOa7ojh0J5vBz0xKV/PfMO0dK3YN7BnE+fIFZFTYDI7EyPjlW4C6
         3fH3F5MPaHLaNRa4hFItP02jBE8WCYVrPXX/CLEKNkAFCzgsJmvGbxxTmIj+ChelkKET
         0dn/JeWB1UR/qKsQJUNXLqCrIx3VqFh752NyAFr+H+vlJ11GAaY5brzhBaG7RNsKWLg1
         WC9Amm5e4aChRNwE7gR5M3Q0MpFA2Xo7vYRL/k8qGFDPY5mXkANi2kolLgOnvYkIe321
         iiWrKno0m92J49H+bZfVoJ6ASjX0s1qOkI504piUVkd6SGKD/H+gqvzx1CZMc4/jgTkS
         /+Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778611667; x=1779216467;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=isdotys3vsn+u1Oh8//bwlSjZMntjd7+ukLze9DPOz0=;
        b=YAgcHtq1g93i1nWpiCkwCwlsboTJVgy7HbJ/dOm6jBSraONE2Go4Wf29Z23nkfIqJ9
         aGuEopHtfs7ekohxZ+HQd/46ScIa4AYuGh2AH0qRfhwNgeForXdWmNxLK7OyGwP2Mqjf
         2nZ67hE4m4M7gDRyJvbVBcaQlTlz3F5F9TW0g2qtMjY5iu4w/kikLjx1YMlTFN4AI8x8
         /2KNC0tIx88v4kb6cWkij8pO6/FrBsfHUTkZAQ06nkali2OJ2eD6OIZfUZuvNbMZar+R
         qCehqTu2pQRa/oD8x0QEOQ7MMM+szN3qtLmWQiCBy6R6T0ZJWqxBxkFDKgfutr6bt70e
         C1VA==
X-Forwarded-Encrypted: i=1; AFNElJ94m+jlg4aR6crNx85yocFidr165Jz3QGTp35w/umpPROGi+Z2Eut9hW5Fql/PU1hIDbCn24aEXbqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOk8SDgSiXb7XbjuPcCQPEIxj13eQ7+Ti8zzcQCtVfr0paQqVs
	0CC7HP8CkHx2F3zof41/PL4zY5E6iOdgmUYvegOJetNEUPY7R1HvgHzMs23CEq/kWmA=
X-Gm-Gg: Acq92OGi9yDhxvapiOcmU9QrJGaL437GvustD+dgjgJ4nyMfhfxAarPdyumE1beRiHj
	E6U/UbojHVpNN06LG+QCTOq0w31qrS4cxIzf4Vvoy4aU7e1+qGnuhHdial3F2ieAKnrVERQ6Gbv
	oVUj/Cy+3gPcfyUOzmbYqYI1X2wgIACnS0xGBXwmn71ksqqWhuTrRaaienRLb4vfznUwZQv5xKX
	W3gCdRa9oHUlk8v1SGK6dgk3gkn99GCWig18sEakaQDG5QBoc5PM9Xnh7USSxoXMVpmg/9Moha1
	1ZyJO7beA3qqkQfKOvnq6vdzZE7Cysqeh5WHgpl5r0hivBxrm/MmMf53sj+02QsyKG6bTghYK6N
	c6prPwYD5B+Q88Asum+7tKlvEwpSqQqz73heNu4zsLX3UwWqsTd+VcQZZzuk54HB63TQZ8Q==
X-Received: by 2002:a05:6122:a5c7:20b0:575:cbe6:8416 with SMTP id 71dfb90a1353d-575cbe6866fmr2952707e0c.14.1778611666611;
        Tue, 12 May 2026 11:47:46 -0700 (PDT)
Received: from yukhui ([2804:7f0:74c0:2c15:8112:b874:d72f:54f4])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-575869f2d08sm9429694e0c.0.2026.05.12.11.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 11:47:46 -0700 (PDT)
From: Raffael Raiel Trindade <raffaelraiel@usp.br>
X-Google-Original-From: Raffael Raiel Trindade
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: Raffael Raiel Trindade <raffaelraiel@usp.br>,
	Kim Carvalho <kim.ca@usp.br>,
	linux-iio@vger.kernel.org
Subject: [PATCH v5] iio: light: vcnl4000: use lock guard()
Date: Tue, 12 May 2026 15:46:43 -0300
Message-ID: <20260512184728.298680-1-raffaelraiel@usp.br>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Raffael Raiel Trindade <raffaelraiel@usp.br>

Use guard() and scoped_guard() for handling mutex lock instead of manually
locking and unlocking. Remove gotos in error handling logic. This prevents
forgotten locks on early exits.

Signed-off-by: Raffael Raiel Trindade <raffaelraiel@usp.br>
Co-developed-by: Kim Carvalho <kim.ca@usp.br>
Signed-off-by: Kim Carvalho <kim.ca@usp.br>
---
v5:
 - fix return ret introduced when return
   is always success

v4:
 - use guard() and scoped_guard() instead of
   lock() and unlock() in all functions
 - drop ret = -EINVAL initialization

v3:
 - fix indentation problems on line breaks

v2:
 - remove unnecessary ret attributions on non-error logic.
 - remove breaks on switch-case after return

 drivers/iio/light/vcnl4000.c | 148 +++++++++++------------------------
 1 file changed, 45 insertions(+), 103 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index c08927e34b4e..8800fa68edda 100644
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
@@ -442,18 +433,18 @@ static int vcnl4000_measure(struct vcnl4000_data *data, u8 req_mask,
 	int tries = 20;
 	int ret;
 
-	mutex_lock(&data->vcnl4000_lock);
+	guard(mutex)(&data->vcnl4000_lock);
 
 	ret = i2c_smbus_write_byte_data(data->client, VCNL4000_COMMAND,
 					req_mask);
 	if (ret < 0)
-		goto fail;
+		return ret;
 
 	/* wait for data to become ready */
 	while (tries--) {
 		ret = i2c_smbus_read_byte_data(data->client, VCNL4000_COMMAND);
 		if (ret < 0)
-			goto fail;
+			return ret;
 		if (ret & rdy_mask)
 			break;
 		msleep(20); /* measurement takes up to 100 ms */
@@ -462,21 +453,14 @@ static int vcnl4000_measure(struct vcnl4000_data *data, u8 req_mask,
 	if (tries < 0) {
 		dev_err(&data->client->dev,
 			"vcnl4000_measure() failed, data not ready\n");
-		ret = -EIO;
-		goto fail;
+		return -EIO;
 	}
 
 	ret = vcnl4000_read_data(data, data_reg, val);
 	if (ret < 0)
-		goto fail;
-
-	mutex_unlock(&data->vcnl4000_lock);
+		return ret;
 
 	return 0;
-
-fail:
-	mutex_unlock(&data->vcnl4000_lock);
-	return ret;
 }
 
 static int vcnl4200_measure(struct vcnl4000_data *data,
@@ -486,16 +470,14 @@ static int vcnl4200_measure(struct vcnl4000_data *data,
 	s64 delta;
 	ktime_t next_measurement;
 
-	mutex_lock(&chan->lock);
-
-	next_measurement = ktime_add(chan->last_measurement,
-			chan->sampling_rate);
-	delta = ktime_us_delta(next_measurement, ktime_get());
-	if (delta > 0)
-		usleep_range(delta, delta + 500);
-	chan->last_measurement = ktime_get();
-
-	mutex_unlock(&chan->lock);
+	scoped_guard(mutex, &chan->lock) {
+		next_measurement = ktime_add(chan->last_measurement,
+				chan->sampling_rate);
+		delta = ktime_us_delta(next_measurement, ktime_get());
+		if (delta > 0)
+			usleep_range(delta, delta + 500);
+		chan->last_measurement = ktime_get();
+	}
 
 	ret = i2c_smbus_read_word_data(data->client, chan->reg);
 	if (ret < 0)
@@ -606,21 +588,15 @@ static ssize_t vcnl4040_write_als_it(struct vcnl4000_data *data, int val)
 			 (*data->chip_spec->als_it_times)[0][1]),
 			 val);
 
-	mutex_lock(&data->vcnl4000_lock);
+	guard(mutex)(&data->vcnl4000_lock);
 
 	ret = i2c_smbus_read_word_data(data->client, VCNL4200_AL_CONF);
 	if (ret < 0)
-		goto out_unlock;
+		return ret;
 
 	regval = FIELD_PREP(VCNL4040_ALS_CONF_IT, i);
 	regval |= (ret & ~VCNL4040_ALS_CONF_IT);
-	ret = i2c_smbus_write_word_data(data->client,
-					VCNL4200_AL_CONF,
-					regval);
-
-out_unlock:
-	mutex_unlock(&data->vcnl4000_lock);
-	return ret;
+	return i2c_smbus_write_word_data(data->client, VCNL4200_AL_CONF, regval);
 }
 
 static int vcnl4040_read_ps_it(struct vcnl4000_data *data, int *val, int *val2)
@@ -660,20 +636,15 @@ static ssize_t vcnl4040_write_ps_it(struct vcnl4000_data *data, int val)
 
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
-					regval);
-
-out:
-	mutex_unlock(&data->vcnl4000_lock);
-	return ret;
+	return i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF1, regval);
 }
 
 static ssize_t vcnl4040_read_als_period(struct vcnl4000_data *data, int *val, int *val2)
@@ -721,20 +692,15 @@ static ssize_t vcnl4040_write_als_period(struct vcnl4000_data *data, int val, in
 			break;
 	}
 
-	mutex_lock(&data->vcnl4000_lock);
+	guard(mutex)(&data->vcnl4000_lock);
 
 	ret = i2c_smbus_read_word_data(data->client, VCNL4200_AL_CONF);
 	if (ret < 0)
-		goto out_unlock;
+		return ret;
 
 	regval = FIELD_PREP(VCNL4040_ALS_CONF_PERS, i);
 	regval |= (ret & ~VCNL4040_ALS_CONF_PERS);
-	ret = i2c_smbus_write_word_data(data->client, VCNL4200_AL_CONF,
-					regval);
-
-out_unlock:
-	mutex_unlock(&data->vcnl4000_lock);
-	return ret;
+	return i2c_smbus_write_word_data(data->client, VCNL4200_AL_CONF, regval);
 }
 
 static ssize_t vcnl4040_read_ps_period(struct vcnl4000_data *data, int *val, int *val2)
@@ -783,20 +749,15 @@ static ssize_t vcnl4040_write_ps_period(struct vcnl4000_data *data, int val, int
 		}
 	}
 
-	mutex_lock(&data->vcnl4000_lock);
+	guard(mutex)(&data->vcnl4000_lock);
 
 	ret = i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF1);
 	if (ret < 0)
-		goto out_unlock;
+		return ret;
 
 	regval = FIELD_PREP(VCNL4040_CONF1_PS_PERS, i);
 	regval |= (ret & ~VCNL4040_CONF1_PS_PERS);
-	ret = i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF1,
-					regval);
-
-out_unlock:
-	mutex_unlock(&data->vcnl4000_lock);
-	return ret;
+	return i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF1, regval);
 }
 
 static ssize_t vcnl4040_read_ps_oversampling_ratio(struct vcnl4000_data *data, int *val)
@@ -830,20 +791,15 @@ static ssize_t vcnl4040_write_ps_oversampling_ratio(struct vcnl4000_data *data,
 	if (i >= ARRAY_SIZE(vcnl4040_ps_oversampling_ratio))
 		return -EINVAL;
 
-	mutex_lock(&data->vcnl4000_lock);
+	guard(mutex)(&data->vcnl4000_lock);
 
 	ret = i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF3);
 	if (ret < 0)
-		goto out_unlock;
+		return ret;
 
 	regval = FIELD_PREP(VCNL4040_PS_CONF3_MPS, i);
 	regval |= (ret & ~VCNL4040_PS_CONF3_MPS);
-	ret = i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF3,
-					regval);
-
-out_unlock:
-	mutex_unlock(&data->vcnl4000_lock);
-	return ret;
+	return i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF3, regval);
 }
 
 static ssize_t vcnl4040_read_ps_calibbias(struct vcnl4000_data *data, int *val, int *val2)
@@ -878,20 +834,15 @@ static ssize_t vcnl4040_write_ps_calibbias(struct vcnl4000_data *data, int val)
 	if (i >= ARRAY_SIZE(vcnl4040_ps_calibbias_ua))
 		return -EINVAL;
 
-	mutex_lock(&data->vcnl4000_lock);
+	guard(mutex)(&data->vcnl4000_lock);
 
 	ret = i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF3);
 	if (ret < 0)
-		goto out_unlock;
+		return ret;
 
 	regval = (ret & ~VCNL4040_PS_MS_LED_I);
 	regval |= FIELD_PREP(VCNL4040_PS_MS_LED_I, i);
-	ret = i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF3,
-					regval);
-
-out_unlock:
-	mutex_unlock(&data->vcnl4000_lock);
-	return ret;
+	return i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF3, regval);
 }
 
 static int vcnl4000_read_raw(struct iio_dev *indio_dev,
@@ -1476,17 +1427,17 @@ static int vcnl4040_write_event_config(struct iio_dev *indio_dev,
 				       enum iio_event_direction dir,
 				       bool state)
 {
-	int ret = -EINVAL;
+	int ret;
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
@@ -1495,13 +1446,11 @@ static int vcnl4040_write_event_config(struct iio_dev *indio_dev,
 			val = (ret & ~mask);
 
 		data->als_int = FIELD_GET(VCNL4040_ALS_CONF_INT_EN, val);
-		ret = i2c_smbus_write_word_data(data->client, VCNL4200_AL_CONF,
-						val);
-		break;
+		return i2c_smbus_write_word_data(data->client, VCNL4200_AL_CONF, val);
 	case IIO_PROXIMITY:
 		ret = i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF1);
 		if (ret < 0)
-			goto out;
+			return ret;
 
 		if (dir == IIO_EV_DIR_RISING)
 			mask = VCNL4040_PS_IF_AWAY;
@@ -1511,17 +1460,10 @@ static int vcnl4040_write_event_config(struct iio_dev *indio_dev,
 		val = state ? (ret | mask) : (ret & ~mask);
 
 		data->ps_int = FIELD_GET(VCNL4040_PS_CONF2_PS_INT, val);
-		ret = i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF1,
-						val);
-		break;
+		return i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF1, val);
 	default:
-		break;
+		return -EINVAL;
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

