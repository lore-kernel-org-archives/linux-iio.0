Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F23A374E63
	for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2026 14:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776694542; cv=none; b=o2WWyEBS61zBCHSS0VBaPFpK2ih+EzP02bebJ53BAkHAdIuLQcyb0yzj7LfqbTEGhShecRSLCSQajq8jYIacqy5NOEKjhaZxe1ksAtQeHVuYcSl4hqwlYmKJbqSIal0im9rRDfaUZsFkUxzFtBr4Ooi4wdZQYuyNdjjHBOcpvmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776694542; c=relaxed/simple;
	bh=YcTmhQFrWRE7ijgI1iUngC5TDtL9GsWMubfCtaFL4Bc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aERVvRA+fyVV2PECTd9AHCKuBuyfWEIWuY6sIO4OyU1zeCslQKaLaq0Er373dAkIupJRIuSp2xbPGQ2xMFLyZciRTtOazHGCYsPuH3L53wCft77jfip+Z725sVpCrgwwTJSE/yILGqzqrooL4giXtt88MvB8XZbHYYjFkaXj6CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=gNxeNm5Q; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="gNxeNm5Q"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2b6b0500e06so5305882eec.1
        for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2026 07:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1776694540; x=1777299340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KqIvrMPswH/B4TSkUA1EU84bsQBlSOpWLbjz+cfUhSM=;
        b=gNxeNm5QFwA430aTg18aGbSIHu29ZKM4BPZyqrre7O7uSXHc2/axvAyu8ksWV19gRX
         z+VeoEaZntgengfg1Q9Vlo6iren1Ni3nN5MNTM+cVd6T+bA6u9PmHWeCvKYOepSLNItE
         JoMZGWngzTWLOG4HJ/PUU0mJIsVRCmfcustDifNW6W1QNTIPZRq2hX2t95w4gEPl82Qr
         U858JrkIhSSc2HcgC70eLZlwlcLGT8NmojB8f6GHs8BrJUnR98ChFKIyOktIkDVS26Gq
         aWWs98q+tdu7jlA21AEfky/oW++oZPHbVRevITeLPEe+UYbszjDrZMMbFouGAsKhw74H
         3rdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776694540; x=1777299340;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KqIvrMPswH/B4TSkUA1EU84bsQBlSOpWLbjz+cfUhSM=;
        b=Dwhcitl8o2TpV1hQFCu4fjUSHArSXB/wSRlHDiVxADNWF8mF7XsmGBGjEdD7h7nA2I
         dhebFkshe4cGjFZBke/lzgSfSbvb6VSAf5psj3cYe8gSs9LVHltPzzRmNvJPuBh1YhJ5
         YhAFBAO09iyYXv5Gnp7uKotjREKOHfleWTqcEI0NvOddqIGBpP3Y7qrtqYIdP6M/PGL6
         NpNyClfVc8TW4ZdbZMoWp2hXVGrzZM6KHEx09qiB2FW83P0CknUAzPFnhyTuHVo++2qX
         fUtckpCa+K9wtN9ygFampPG5jvqyuUqjJEw8XEYi7A4f7PdBH9UunhW+3Vco00LiYD66
         YKZw==
X-Forwarded-Encrypted: i=1; AFNElJ86e3aV7mDOMvqJzoEx5LhoZv/NNSkl28X9Z8in59wZUdsVknFlKdw837j5dpc4L2JcYhvt4EMZxVg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP7lnxH6Vpv3iVsXcbU/zQD6s2VMhhN3jwS93hYKAkFV/520jk
	QYxmMh2u0GfTiopjzDHIuI3AC//7eT95IKdWkDPI60kr2veuPnY+5iKcKiVbzMT3WZI=
X-Gm-Gg: AeBDietBfqasOxD4UMPxSKbYXE8rxC1bBTDqZa7wzboxWV4bH9jR+lkiqBGejOrchV8
	K9/l72YZ7JUvbguS/2vQGWt6Pv0A4+YAq4mL0WyDJmMJis3xlpPsrQwsne/DubLzn6GObFzL/gB
	wmN67M8mIc8pRghIav26AUBx8SDNVexujqS6UttSGAv7i9Q9uj2ouDtbI6l6aSAIK7ZZXtgsFRP
	HFQeReV5rAwdXGOjRjUg2S5uH7uV6XUFYL5Sc/6o6BsVGq/BcSqYHwl/Er+xZw/ROx/kfaxi1eG
	OE5RZQy8xNJE2ARp91TvRXs411j62u+LYJi7BIBxo8/8A7nCzkQaYHlsC1ZYgznjkNfvJMQvvDk
	OmjyRFkyxHsl0pYT/8j6ZxDbyLAAxf77VFOfJXAc9aZx+m4zyWrLelhIwD8uyWItRbUzESqhjyV
	m4hfRFoHeOjyNi1jvytdP524r5EgEPfmHk5g==
X-Received: by 2002:a05:693c:310b:b0:2dd:649d:751d with SMTP id 5a478bee46e88-2e46538dc17mr6215600eec.8.1776694540180;
        Mon, 20 Apr 2026 07:15:40 -0700 (PDT)
Received: from fedora ([2804:14c:4c:af50:c408:26e5:33b0:662b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53ccce0f5sm14462449eec.17.2026.04.20.07.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 07:15:39 -0700 (PDT)
From: Luiz Mugnaini <luizmugnaini@usp.br>
X-Google-Original-From: Luiz Mugnaini
To: cmo@melexis.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: Luiz Mugnaini <luizmugnaini@usp.br>,
	linux-iio@vger.kernel.org
Subject: [PATCH v2] iio: temperature: mlx90614: use guard(mutex) for EEPROM access locking
Date: Mon, 20 Apr 2026 11:14:29 -0300
Message-ID: <20260420141512.196932-1-luizmugnaini@usp.br>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Mugnaini <luizmugnaini@usp.br>

Replace mutex_lock()/mutex_unlock() pairs with guard() and
scoped_guard() from cleanup.h for cleaner and safer mutex handling. The
lock protects EEPROM access across five call sites in
mlx90614_read_raw(), mlx90614_write_raw(), and mlx90614_sleep().

In all cases, the code between mutex_unlock() and the end of scope is
either a return statement, or a call to mlx90614_power_put() followed by
trivial computation. In the later cases we prefer the use of
scoped_guard() to avoid holding the lock longer than needed.

Signed-off-by: Luiz Mugnaini <luizmugnaini@usp.br>
---
Changes in v2:
- Prefer using scoped_guard() instead of guard() for cases where we
  don't immediately return. This avoids adding more code to the critical
  section and preserves the same semantics as the previous mutex_lock()
  and mutex_unlock() pairs.
- Removed the intermediate variable ret from mlx_90614_sleep() as
  suggested.

 drivers/iio/temperature/mlx90614.c | 37 ++++++++++++++----------------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/temperature/mlx90614.c b/drivers/iio/temperature/mlx90614.c
index 1ad21b73e..6c58375de 100644
--- a/drivers/iio/temperature/mlx90614.c
+++ b/drivers/iio/temperature/mlx90614.c
@@ -23,6 +23,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/gpio/consumer.h>
@@ -139,6 +140,7 @@ static s32 mlx90614_write_word(const struct i2c_client *client, u8 command,
 	return ret;
 }
 
+
 /*
  * Find the IIR value inside iir_values array and return its position
  * which is equivalent to the bit value in sensor register
@@ -296,10 +298,10 @@ static int mlx90614_read_raw(struct iio_dev *indio_dev,
 		if (ret < 0)
 			return ret;
 
-		mutex_lock(&data->lock);
-		ret = i2c_smbus_read_word_data(data->client,
-					       chip_info->op_eeprom_emissivity);
-		mutex_unlock(&data->lock);
+		scoped_guard(mutex, &data->lock)
+			ret = i2c_smbus_read_word_data(data->client,
+					chip_info->op_eeprom_emissivity);
+
 		mlx90614_power_put(data);
 
 		if (ret < 0)
@@ -319,10 +321,10 @@ static int mlx90614_read_raw(struct iio_dev *indio_dev,
 		if (ret < 0)
 			return ret;
 
-		mutex_lock(&data->lock);
-		ret = i2c_smbus_read_word_data(data->client,
-					       chip_info->op_eeprom_config1);
-		mutex_unlock(&data->lock);
+		scoped_guard(mutex, &data->lock)
+			ret = i2c_smbus_read_word_data(data->client,
+					chip_info->op_eeprom_config1);
+
 		mlx90614_power_put(data);
 
 		if (ret < 0)
@@ -358,10 +360,10 @@ static int mlx90614_write_raw(struct iio_dev *indio_dev,
 		if (ret < 0)
 			return ret;
 
-		mutex_lock(&data->lock);
-		ret = mlx90614_write_word(data->client,
+		scoped_guard(mutex, &data->lock)
+			ret = mlx90614_write_word(data->client,
 					  chip_info->op_eeprom_emissivity, val);
-		mutex_unlock(&data->lock);
+
 		mlx90614_power_put(data);
 
 		return ret;
@@ -373,10 +375,9 @@ static int mlx90614_write_raw(struct iio_dev *indio_dev,
 		if (ret < 0)
 			return ret;
 
-		mutex_lock(&data->lock);
-		ret = mlx90614_iir_search(data->client,
+		scoped_guard(mutex, &data->lock)
+			ret = mlx90614_iir_search(data->client,
 					  val * 100 + val2 / 10000);
-		mutex_unlock(&data->lock);
 		mlx90614_power_put(data);
 
 		return ret;
@@ -467,7 +468,6 @@ static const struct iio_info mlx90614_info = {
 static int mlx90614_sleep(struct mlx90614_data *data)
 {
 	const struct mlx_chip_info *chip_info = data->chip_info;
-	s32 ret;
 
 	if (!data->wakeup_gpio) {
 		dev_dbg(&data->client->dev, "Sleep disabled");
@@ -476,14 +476,11 @@ static int mlx90614_sleep(struct mlx90614_data *data)
 
 	dev_dbg(&data->client->dev, "Requesting sleep");
 
-	mutex_lock(&data->lock);
-	ret = i2c_smbus_xfer(data->client->adapter, data->client->addr,
+	guard(mutex)(&data->lock);
+	return i2c_smbus_xfer(data->client->adapter, data->client->addr,
 			     data->client->flags | I2C_CLIENT_PEC,
 			     I2C_SMBUS_WRITE, chip_info->op_sleep,
 			     I2C_SMBUS_BYTE, NULL);
-	mutex_unlock(&data->lock);
-
-	return ret;
 }
 
 static int mlx90614_wakeup(struct mlx90614_data *data)
-- 
2.53.0

