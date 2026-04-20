Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3DF33F385
	for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2026 20:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776715261; cv=none; b=n4vngZbSWopsFUbZqt52bB6uleHp96hOQkLLheE82C8P6EelrmeznJEN4TKB4HCaauKyRdyCUMmj86CX9Eqr1wnu4E/1VvGjl7LsbCg9vvpKlNDPXE1C6f/AmXFnEPv40ZJnkdYc4HxPUBhTk6nhbfVv7xm5d7iXRSCk89B8SAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776715261; c=relaxed/simple;
	bh=LKlaOiMFEgmLyI1s/JjShhRwkUIIPh7cB3jKf5T0Ztg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ucW456VIzA3Irx6gM4xVVh6MhI1kNNelpC6ENkdOm+WXEBzLFfEbUc+CaFqu4x7ccMLWZ/6UZ0412RYyxVIJgxe0VjV4/Z4nJYpnF6JB7wJ2YOIVxd6EUjp01wVJt9rXXWuIbUP4FQCfj0fxrHz9AudFOqy0aIPx/Kvx41QkE/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=A9mKKWDA; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="A9mKKWDA"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2d8ffdc31d0so8345359eec.0
        for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2026 13:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1776715256; x=1777320056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OO8fAGSOyCTwLo8twqF8kwkTxT3aSS2/mpXahL4wHEU=;
        b=A9mKKWDAnOoa1O/5ZpHtHudnx5kxPAjx1po61Sjr3B7Gnw13FRJU8qPowmdyov31cY
         /jh+gjdIej4WZWlHrosVWVHqj91a2WbbN+Jn6YtJy/VjBldqNP0XtQgRyYwjPH2CirWp
         t0DvuUntwg+n82oc+HBJgvph1xJlGutbw3u5rLXOK9ANapvyXaMbcBNO1Ie1oawUinPE
         Mrgvx9f/IAZSOn9Lv/w4VZ0tLyKEp5DGixm2VP0/bNBBtKTXa93K2Htnbr9x2D4I8Kvb
         FIzWuFIZD22mnsEBu/wziElwL7ldp/7xK5BjvZ2KMAAObVgHPf8q69g9bDl/GcKBc2AF
         E1cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776715256; x=1777320056;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OO8fAGSOyCTwLo8twqF8kwkTxT3aSS2/mpXahL4wHEU=;
        b=fCYNB1RzVUCvoPsIi0NNpM81iPA6s8ujqGz8Rl25KWIEcXDXxRcNAQg8OyuUYokole
         qbY0LmM+a4vGWICYWUVaGFJdChvfzvpJIW9GtZYsuhvUG83sAJ1mGNE2xWIW90Qz1pAd
         t64YcEpsJ2RbDbFGG94+cAckawsY0rzh9pzVmMzspDuKQQzKnozxNxChajho1v80uP8H
         OCsBh8ULtGiWASGpluVJoG4CIYtEOOklnc5d+n40ZBBLbb1BU83mSgrlQZT6Tod9lFQ3
         b9TWSGJwpwJz2ri2HUOk3etumVDnk1+HNMbYUATbPu6BXYCul2ShyH3NmaZqCVq7H7YV
         2IZA==
X-Forwarded-Encrypted: i=1; AFNElJ8qyv2ezDooghYOMnOC94gjksvBN1wMVB69gZ5vFyXCavtsRcjx6j+EucIZg+Trx5R4K0ARWu+L1v4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEm5YGTZDrSiViMe49CEQEtSEgXnLuvvBjQ/YFqRY8fOUY3Gt1
	ka4c2Hsswuz44N5tkRnhbo+K/lkr8GXBMem7Plgur+DyRuevGW+B5SmaBBMNbK4JlwkOCwYbFvE
	1LBAf1aSxfg==
X-Gm-Gg: AeBDiesgYje54CYKdXARI3eexBrd8smBFPSIpv/ukYuJynitpWNH1Ww8j2KifyLRzOM
	Ll9EQPWG4I50cVyOcBnw582v2fLpcSwgny8ZYQwaiJnbZFnXc2zaKx212REN0KWSBQcQXqGigav
	WM9Yxujg/sPaqMdQx6vdBtSQWsRJ3ChY6xz5lkhnNKPfp7uLUfUVr9bam4U+pOCHLOA9cYDyAZY
	LHfs650TEZLp/LEaIwdT0ZdQOiP00B4lXrRhfbPQ9uVEp6h5xzUv7L/EXYwjWBim1OEy60QJRJm
	e2ydt69K7iG5xCV4fX0G8HQ9/c7fDSxo2C/T5mhsjtdnJTOMnQoqtNgr9hQpfNvvUbt7/2LBIcp
	9vC3SvEhhjvImspzhNLo9yVqtnsycgkx7Y9Aup8nOmVnsEBXJPtjrIPVGC73ze2FXYT2Li5I3OJ
	f5+t6y
X-Received: by 2002:a05:693c:3007:b0:2be:2cfe:68b7 with SMTP id 5a478bee46e88-2e465293e13mr8021757eec.11.1776715256104;
        Mon, 20 Apr 2026 13:00:56 -0700 (PDT)
Received: from yukhui ([2804:7f0:74c0:1181:8d7a:8c3b:6536:b13a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53ccce0f5sm15880016eec.17.2026.04.20.13.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 13:00:55 -0700 (PDT)
From: Raffael Raiel Trindade <raffaelraiel@usp.br>
X-Google-Original-From: Raffael Raiel Trindade
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: Raffael Raiel Trindade <raffaelraiel@usp.br>,
	Kim Carvalho <kim.ca@usp.br>,
	linux-iio@vger.kernel.org
Subject: [PATCH v3] iio: light: vcnl4000: use lock guard()
Date: Mon, 20 Apr 2026 16:59:33 -0300
Message-ID: <20260420200047.102159-1-raffaelraiel@usp.br>
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
v3:
 - fix indentation problems on line breaks

v2:
 - remove unnecessary ret attributions on non-error logic
 - remove breaks on switch-case after return

 drivers/iio/light/vcnl4000.c | 55 +++++++++++-------------------------
 1 file changed, 16 insertions(+), 39 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index c08927e34b4e..023176ff14c7 100644
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
@@ -660,20 +651,15 @@ static ssize_t vcnl4040_write_ps_it(struct vcnl4000_data *data, int val)
 
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
@@ -1480,13 +1466,13 @@ static int vcnl4040_write_event_config(struct iio_dev *indio_dev,
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
@@ -1495,13 +1481,11 @@ static int vcnl4040_write_event_config(struct iio_dev *indio_dev,
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
@@ -1511,17 +1495,10 @@ static int vcnl4040_write_event_config(struct iio_dev *indio_dev,
 		val = state ? (ret | mask) : (ret & ~mask);
 
 		data->ps_int = FIELD_GET(VCNL4040_PS_CONF2_PS_INT, val);
-		ret = i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF1,
-						val);
-		break;
+		return i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF1, val);
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

