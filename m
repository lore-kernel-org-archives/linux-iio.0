Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D122C028F
	for <linux-iio@vger.kernel.org>; Thu, 16 Apr 2026 03:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776309855; cv=none; b=pzLegLfcUnbEywPj1kgFbU7ng9xYKyi+/1Na0pwbilR0AhPD/GJXypfq1pRH6a8IucOqtdjcg+OtVPqAQYOKxeytIwGz22nPUjaA+jkcfsBf4MYcAIg82Cxg89L+WyampC06jjRR+dhd4hPQVE3Ar03Hf4QaJ5TV3NGi8SkKUto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776309855; c=relaxed/simple;
	bh=IR4Yw5KCCekOz48EDEZ7vVH6bslUcge9pvcgR8a6pao=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HcF/sr49wy9rS7W705len1lStzYjpD5F6o6XqHf5uHAB2qVbBohOpxe6zrG08MoUtbQy7gRP6yKqGjSDMKLqMvE8wEHmA3bKjZIfieHoi1IgtwISyHh/AZGYJLwY/SZefzte4A0W5IL3lQsba1hAKx7imqmvEneR6cNbyiIDvsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=dOZeobps; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="dOZeobps"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2ba895adfeaso8050015eec.0
        for <linux-iio@vger.kernel.org>; Wed, 15 Apr 2026 20:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1776309851; x=1776914651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QAETdeYpwR/J91KQX8o8KXu4BSWvO+oZiamqLazazak=;
        b=dOZeobpsUl/Ly1FMjQboxll7lgjJn1FP6Onpea0xVIIk3pollUHsmzxLEbhKH9Z+4j
         x0KoK7AeRXU+EM6TVl1+i6BPBPRyWneSHFWbYTbOM1CkXG5ifufvuJ1qIqXVNEOyOOZf
         HAkXBUJ7BtmMjf6dcJ9wrpCkTpIRV699ye1yjzHd5DUZjKZr2oCrMV2vFW2kFjkWc3GB
         f+RW0eRf7pkYCQn2/sy34z8pIH3vykpsYweYoGDvHAyS8gjvFHaNjxImqsHfy8WldknI
         V5Qh3dwyFf5E6kE6437/9zc1o4j4QcmL8hVBVN2c9UTCH7RPfavvKyYVTYdMRHEgU4il
         clMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776309851; x=1776914651;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QAETdeYpwR/J91KQX8o8KXu4BSWvO+oZiamqLazazak=;
        b=TfcJ5RZnckadFrrx3hrLYRl1A9C4kz/jqekuyt0MPq25GKS+OY/d3GwVZ6KRRcVLuH
         fb2wDR96kLfQ53MKm11MPrMPfeXtoyw94fMf0AD44MfcN90B95uYSiiK690FqL1hqH1H
         T1IoGnSR9+JdHdb7lYMsja2NLqP2ieRSJXnD1DDFwoY4oWr+uNLl+CZg2+2nUADccLnk
         uZtL7uoJszoQhGR8hlE5NUGsZAg1w5O/LmylnckY+GsP9Y9w+d/5a0PoAl0HJ/zbM7zG
         RUzEf/kbVYyzCVUbtMSd32tSW1l4oFo2HOYLmL6TlQ/8eX+I7+FdgeoPLpC55/zQU8Qf
         Hz9Q==
X-Forwarded-Encrypted: i=1; AFNElJ8zMGDs8YEbnNbPEq1Zgwe17+/XLUwcGeHooeBwm83RavXthriWeb3C3el53zZxKMN9PP4m5zwaFWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZyOo7IEm76NaDb0x07SS8T6/312fOuFImxWhQir9lnIKxxY3G
	osSu0JrhzyUaL5cj/yNAEmLc/kKHXw1zoQIOdcqP6Wqg4S3tvB7FjiCp+wALHWGa5T8=
X-Gm-Gg: AeBDiev8PfHkGO26wC1wFA/PP/wAVF9VrLhS3tp8WIv5yNhRVOUsMqLVIxXXNwQqn12
	s+Mxzz/u/P6KmlBhMsIFyKHBW89yWO607j/lDQwxmqxpaXVhRx0Vz6FFpMrILEqXwHSn6/jKvse
	KZSmJA3yRbuEEmDvYWloGDc/Yw8TsntJTJKs43qDAiWSCn+F4uLLsEOr7Za0WX1nRadcJduZqIy
	NAkZlEalelY+4vs9+7bB+y1x2Or/6aOHvMckfuEAIfxZXL52ScQNzVZkJKTM6Rq2X5KMfsY5WF3
	4IM9q/CLWjEV0r/WsjB524rdfeenBiXbPSuNJiI11D+k7QmAc5ARkozOivrHnoDw9YpHeN25mWE
	h4lHabiw8r4/jp0niEpgfaTAgRhFBjTHDDHGrc59BobtzBBl28/GiWWi20uSUIHS1SaPomD0RYE
	MnDiPFA+SRsr7MOPQpLqHEzsVpZgEOOPiIPAdcQNi9l3y3
X-Received: by 2002:a05:7300:238d:b0:2cc:600d:2ffc with SMTP id 5a478bee46e88-2d5898a4e37mr14043952eec.25.1776309850941;
        Wed, 15 Apr 2026 20:24:10 -0700 (PDT)
Received: from localhost.localdomain ([191.183.70.226])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2de8c606db2sm5404349eec.11.2026.04.15.20.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 20:24:10 -0700 (PDT)
From: Giovanna Luisa Hirata dos Anjos <giovannaluisahirata@usp.br>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: Giovanna Luisa Hirata dos Anjos <giovannaluisahirata@usp.br>,
	Naili Lucia Marques <naahmarque345@usp.br>,
	linux-iio@vger.kernel.org
Subject: [PATCH] iio: common: ms_sensors: use guard(mutex) helper
Date: Thu, 16 Apr 2026 00:23:45 -0300
Message-ID: <20260416032351.224072-1-giovannaluisahirata@usp.br>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The guard(mutex) macro helps to simplify the code by automatically
releasing the mutex when the dev_data->lock variable goes out of scope.
This reduces the risk of forgetting to call mutex_unlock in error paths.

Refactor all functions in this driver to use this modern cleanup helper.

Signed-off-by: Giovanna Luisa Hirata dos Anjos <giovannaluisahirata@usp.br>
Co-developed-by: Naili Lucia Marques <naahmarque345@usp.br>
Signed-off-by: Naili Lucia Marques <naahmarque345@usp.br>
---
 .../iio/common/ms_sensors/ms_sensors_i2c.c    | 22 +++++++------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/common/ms_sensors/ms_sensors_i2c.c b/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
index 1960a2ce82a8..4dc9ec349dc6 100644
--- a/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
+++ b/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
@@ -9,6 +9,7 @@
 #include <linux/iio/iio.h>
 #include <linux/device.h>
 #include <linux/delay.h>
+#include <linux/cleanup.h>
 
 #include "ms_sensors_i2c.h"
 
@@ -318,9 +319,8 @@ ssize_t ms_sensors_show_battery_low(struct ms_ht_dev *dev_data,
 	int ret;
 	u8 config_reg;
 
-	mutex_lock(&dev_data->lock);
+	guard(mutex)(&dev_data->lock);
 	ret = ms_sensors_read_config_reg(dev_data->client, &config_reg);
-	mutex_unlock(&dev_data->lock);
 	if (ret)
 		return ret;
 
@@ -345,9 +345,8 @@ ssize_t ms_sensors_show_heater(struct ms_ht_dev *dev_data,
 	u8 config_reg;
 	int ret;
 
-	mutex_lock(&dev_data->lock);
+	guard(mutex)(&dev_data->lock);
 	ret = ms_sensors_read_config_reg(dev_data->client, &config_reg);
-	mutex_unlock(&dev_data->lock);
 	if (ret)
 		return ret;
 
@@ -380,10 +379,9 @@ ssize_t ms_sensors_write_heater(struct ms_ht_dev *dev_data,
 	if (val > 1)
 		return -EINVAL;
 
-	mutex_lock(&dev_data->lock);
+	guard(mutex)(&dev_data->lock);
 	ret = ms_sensors_read_config_reg(dev_data->client, &config_reg);
 	if (ret) {
-		mutex_unlock(&dev_data->lock);
 		return ret;
 	}
 
@@ -393,7 +391,6 @@ ssize_t ms_sensors_write_heater(struct ms_ht_dev *dev_data,
 	ret = i2c_smbus_write_byte_data(dev_data->client,
 					MS_SENSORS_CONFIG_REG_WRITE,
 					config_reg);
-	mutex_unlock(&dev_data->lock);
 	if (ret) {
 		dev_err(&dev_data->client->dev, "Unable to write config register\n");
 		return ret;
@@ -421,13 +418,12 @@ int ms_sensors_ht_read_temperature(struct ms_ht_dev *dev_data,
 	u32 adc;
 	u16 delay;
 
-	mutex_lock(&dev_data->lock);
+	guard(mutex)(&dev_data->lock);
 	delay = ms_sensors_ht_t_conversion_time[dev_data->res_index];
 	ret = ms_sensors_convert_and_read(dev_data->client,
 					  MS_SENSORS_HT_T_CONVERSION_START,
 					  MS_SENSORS_NO_READ_CMD,
 					  delay, &adc);
-	mutex_unlock(&dev_data->lock);
 	if (ret)
 		return ret;
 
@@ -462,13 +458,12 @@ int ms_sensors_ht_read_humidity(struct ms_ht_dev *dev_data,
 	u32 adc;
 	u16 delay;
 
-	mutex_lock(&dev_data->lock);
+	guard(mutex)(&dev_data->lock);
 	delay = ms_sensors_ht_h_conversion_time[dev_data->res_index];
 	ret = ms_sensors_convert_and_read(dev_data->client,
 					  MS_SENSORS_HT_H_CONVERSION_START,
 					  MS_SENSORS_NO_READ_CMD,
 					  delay, &adc);
-	mutex_unlock(&dev_data->lock);
 	if (ret)
 		return ret;
 
@@ -625,7 +620,7 @@ int ms_sensors_read_temp_and_pressure(struct ms_tp_dev *dev_data,
 	s64 off, sens, t2, off2, sens2;
 	u16 *prom = dev_data->prom, delay;
 
-	mutex_lock(&dev_data->lock);
+	guard(mutex)(&dev_data->lock);
 	delay = ms_sensors_tp_conversion_time[dev_data->res_index];
 
 	ret = ms_sensors_convert_and_read(
@@ -635,7 +630,6 @@ int ms_sensors_read_temp_and_pressure(struct ms_tp_dev *dev_data,
 					MS_SENSORS_TP_ADC_READ,
 					delay, &t_adc);
 	if (ret) {
-		mutex_unlock(&dev_data->lock);
 		return ret;
 	}
 
@@ -645,7 +639,7 @@ int ms_sensors_read_temp_and_pressure(struct ms_tp_dev *dev_data,
 						dev_data->res_index * 2,
 					MS_SENSORS_TP_ADC_READ,
 					delay, &p_adc);
-	mutex_unlock(&dev_data->lock);
+
 	if (ret)
 		return ret;
 
-- 
2.47.3

