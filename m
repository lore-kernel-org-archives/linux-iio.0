Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB913B7B98
	for <linux-iio@vger.kernel.org>; Thu, 14 May 2026 20:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778789606; cv=none; b=K/MP60ewhq7RTsv/ZnhopbTPWsU0tDuNf36ybGjNEYLqRMqtCe2SpfF7/AN7Dvp78w1FMKNHAMPUs8gHpNhRvgAtSjRzuKAaBsM3o3DRalq9NuKAtF4WY9wOrLZ/Os/zdiBzg1Phi9WfCTKwLh9aAL0PODaOYQebAAz3R8b3q0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778789606; c=relaxed/simple;
	bh=g2omP6OwwaVaZtqKMKo5bYDZDAuGobiaOQnmZa+vx08=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CR13K9a2t59rzw9mA3Pr5fBchPrtg7APayZ8N00JdtGeZ5MKZBpdY3+9rdAOzD6o2Wl2E9VKbgQs/SAapcpJ5r/BNNlQnfO6ENOy97u57rwnn362yNeKGRhABa3KakRmCPnnoPsQFs7k1YQsRTWOn/d2TnOAdcmEMnQSXDfAJAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=jvkUGHWk; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="jvkUGHWk"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1330d6bb78dso5249098c88.1
        for <linux-iio@vger.kernel.org>; Thu, 14 May 2026 13:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1778789602; x=1779394402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1b03IdG6d+k+oaakW+L7ThzKuIv82Zf07V1YgnSKHuM=;
        b=jvkUGHWkutmYa5HwcEfrjK8dR4cWyqBH7wuU68Qa4ni1JD4jU/gh+4nwSJUhZabVUR
         yf40R3T9ZLOX9sN1JmliJviX8e6pyyayx+MSKbPqxwE5bKleEA5KPOM6qplp0Nd+9J2R
         HXxbiFEyGHHr1112B2iGaBh2GVUrDIHe+aimCIM9Jq0hnfGLG/P60JJfJG1dd26zr4sZ
         JMYj89AxwGHzyNVTcrLcoINrQVFSwycXy2s8EbTa5EmI8+hDxhstXGNiTC5LJB/61StN
         46+Xz1CFbhezO3I5PWaK+6988XKKuhEG5O+ZGcRF/X44ctJdgWYTqU0jntAurrA+7FbL
         7DwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778789602; x=1779394402;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1b03IdG6d+k+oaakW+L7ThzKuIv82Zf07V1YgnSKHuM=;
        b=tAhYZrfffADQFgxgKE0Zt+waRhxg4S+nFJLjUgFxR6TWtpHxbGZuirypEcgwoe5/QM
         DvaVxz5EnmPFROmq6gphvueRSNHWMfFtgDUCZYsNYiD09bZlpYlq7xKpmzgJlZnKpFyM
         LdHDNARRiJdi+PtRRpAswo0h3waReK0CKgkPFtS0Muqr40q9ZoCV6ZhQ8zSNUb705gzp
         KkWla7m7iRxbJAqSpBgzXa/hs2bose9GxgW40V4WhCVj9JFZESNuOpRscfImkBzbH8Jb
         2CCDska+GffYL+vpzG4sW/sCMPp8J5Nu64jhwxl/6QDRqBEwn8q0wMcUcKbfd0BnwHgr
         yoDQ==
X-Forwarded-Encrypted: i=1; AFNElJ/JB9R/Mk93eChQ6uxddksb3Mm7fVbjtRvlLrI9CuGC5k11aT8+8o3IT0Ye7yokdej1ByXbK7ZrxsA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF/x1HU5t1qFlthd06qAxLo7XQO+oQFdg34bVz+Hf6JDDXDlew
	yozxSu3+bkQnkteLsdZufy6sgeNelQE36qK1poFQqnT2UAYbyo4EY2C270N1/8mVuuxmoVpkACT
	sGBgL1U0=
X-Gm-Gg: Acq92OE1wC5ani4eiMCspDohkVEZdUasMcN6BtrDbrchcm4CWtSb2Y0mV2amjlLfff8
	ZGMvDDVBo4dalkpWKRn3PdPZMn6F+IXMzFQJy4oHeJ5axaxOwxWXOFdGxFsLeAmGidtFJ1BGVL0
	jxfzF0zYA1xtEEH+Slamjb1rlc5befxHeBXWA0r02EjiyBMonrSuR9Qvxzw8MyzUzcUGKKrICoC
	9LprtGJaENeg9LZhHsb0Ycbot1w+ZLycnztuoZMOrI5eToZKYdd00Gs9FlD4pkJDnSKRgekK5SG
	2FEwIdDVk1dkaf7nI7OqDFyGs66kpXIBnjpFrdig+EcRR8+slNYi9PsJxtf8Du/lbS+r9gXAvwg
	SdvyU72dSNSDDPmK8yKzMdH72l7XxDIHr4ArjisfjbogYVhipUJA0wwHbOI2/LmpKUSodCA==
X-Received: by 2002:a05:7022:4a2:b0:134:e90f:7cd5 with SMTP id a92af1059eb24-13504744749mr317541c88.21.1778789601671;
        Thu, 14 May 2026 13:13:21 -0700 (PDT)
Received: from yukhui ([2804:7f0:74c0:2c15:3034:1970:7d6a:12b6])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cc33a618sm5943167c88.12.2026.05.14.13.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 13:13:21 -0700 (PDT)
From: Raffael Raiel Trindade <raffaelraiel@usp.br>
X-Google-Original-From: Raffael Raiel Trindade
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: Raffael Raiel Trindade <raffaelraiel@usp.br>,
	Kim Carvalho <kim.ca@usp.br>,
	linux-iio@vger.kernel.org
Subject: [PATCH v6] iio: light: vcnl4000: use lock guard()
Date: Thu, 14 May 2026 17:11:49 -0300
Message-ID: <20260514201312.678131-1-raffaelraiel@usp.br>
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
v6:
 - remove unnecessary ret < 0 check
 - direct return on vcnl400_measure

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

 drivers/iio/light/vcnl4000.c | 152 +++++++++++------------------------
 1 file changed, 45 insertions(+), 107 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index c08927e34b4e..88fc7424ae35 100644
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
@@ -462,21 +453,10 @@ static int vcnl4000_measure(struct vcnl4000_data *data, u8 req_mask,
 	if (tries < 0) {
 		dev_err(&data->client->dev,
 			"vcnl4000_measure() failed, data not ready\n");
-		ret = -EIO;
-		goto fail;
+		return -EIO;
 	}
 
-	ret = vcnl4000_read_data(data, data_reg, val);
-	if (ret < 0)
-		goto fail;
-
-	mutex_unlock(&data->vcnl4000_lock);
-
-	return 0;
-
-fail:
-	mutex_unlock(&data->vcnl4000_lock);
-	return ret;
+	return vcnl4000_read_data(data, data_reg, val);
 }
 
 static int vcnl4200_measure(struct vcnl4000_data *data,
@@ -486,16 +466,14 @@ static int vcnl4200_measure(struct vcnl4000_data *data,
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
@@ -606,21 +584,15 @@ static ssize_t vcnl4040_write_als_it(struct vcnl4000_data *data, int val)
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
@@ -660,20 +632,15 @@ static ssize_t vcnl4040_write_ps_it(struct vcnl4000_data *data, int val)
 
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
@@ -721,20 +688,15 @@ static ssize_t vcnl4040_write_als_period(struct vcnl4000_data *data, int val, in
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
@@ -783,20 +745,15 @@ static ssize_t vcnl4040_write_ps_period(struct vcnl4000_data *data, int val, int
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
@@ -830,20 +787,15 @@ static ssize_t vcnl4040_write_ps_oversampling_ratio(struct vcnl4000_data *data,
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
@@ -878,20 +830,15 @@ static ssize_t vcnl4040_write_ps_calibbias(struct vcnl4000_data *data, int val)
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
@@ -1476,17 +1423,17 @@ static int vcnl4040_write_event_config(struct iio_dev *indio_dev,
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
@@ -1495,13 +1442,11 @@ static int vcnl4040_write_event_config(struct iio_dev *indio_dev,
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
@@ -1511,17 +1456,10 @@ static int vcnl4040_write_event_config(struct iio_dev *indio_dev,
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

