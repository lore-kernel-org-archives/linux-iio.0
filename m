Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F16E3BED38
	for <linux-iio@vger.kernel.org>; Mon, 31 Aug 2026 22:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788215630; cv=none; b=BOQuFIkqERyQt6xd9Mim9pQ7GAI1J+USHENTHOB3ACY5+4U/J6LhnI/bjZOAWiaBZKZzN0GSOy3lmReIRcSIoXXt1zNJ2mxs54G/rtrgboKrc2UITsABd5ggIxdMT7amWMN1+jqtKCP0XoTegn0HUgI5YiHvjFSI1glIuzWy7JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788215630; c=relaxed/simple;
	bh=0jleKfSV4x8zSuizbp6O6ni4ujngh47YqjL22y19AbA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EwlrVEfhzRh5LTZQSGNMS/t9ii0bs1zUzavew2axhrE4h+twdhEa3CZMef/SAPin4A+XDWl3qgpW2ol6K1AgOVBijYDyn/bUqA6FioBDAFDzC9fwiMjPgl4MQmMmz6jc7JWJepQDFaXa4ARJGoGGI22dvyDC35yhKpnDnB/7fCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=bcak9rcC; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="bcak9rcC"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7eb1dc6bd53so3319035a34.2
        for <linux-iio@vger.kernel.org>; Mon, 31 Aug 2026 15:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1788215627; x=1788820427; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cEY7r8lduCT2nc4feVvWUral7NtsjaDfgRTqImYybck=;
        b=bcak9rcCdTn+FzUmIuL+onyCyoZfIKuzd4mIAhotwnzg0OMeMCYDDT37++oauu1bMW
         YgAmm+I8ZDY9weoMJ49My0xTBln8QsTj+PqlgYp7Cap+PShZ4/gOnja16Bk2rHOmSHu5
         iXM6K+TMnpP7wvy8zn5kV4pX8S9isMdoQtqmZDtRDAbBSek4QhBD2lIACFB4nBh/IAHA
         z1yEMc9ZxjugS7JF9R22Tk55o4+6dWcaquuvMVnrD8aWUB62W5HgOQTzpH2f21dwaNnV
         k9scCyGabIzhulGzoO0zPSfb2BlXia/yjy2oPlFaf65FO2VdrTZmCJO8JqkIxYqacBVC
         X28A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788215627; x=1788820427;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cEY7r8lduCT2nc4feVvWUral7NtsjaDfgRTqImYybck=;
        b=qfhmpYk2gdP+pD2ySudOn93N2LSx0HUGJ6kaq6JSS2pK2oZ1FqX9rOYSH4pxxTOtD/
         zj3PocVoRSP7EyDLR6RGrW+VdKQSbPWm973BXlEwKlp8hw1byWi9f9RZRbfzeAJqkokA
         dRt6nY8ojFpwk2U1hfBznXP7oJOI5gmDw5BWi/zqkQO7coU/ZM7Wi1w7IT3UB+E/DMjS
         /yqygnPsXXnBlyOkp0RZ/c4caacQ4InaIg+eqmk4zBJ1sFY9L82CyAvSer7idnsO6J/+
         c136TLmTyh1oa3qjZmPXX+Fyu3MDxH7J6A9XRaU2JOzXy2azRujm6RRbGe3PCvAFKPhh
         1gAg==
X-Forwarded-Encrypted: i=1; AHgh+RodaMLjGfjGxrDoKLc0N+X3XTM+OiceJgdrn9jdQ0Qjb/lIOob7crynrJHrYVFLN23tJn3X1J4tGno=@vger.kernel.org
X-Gm-Message-State: AFuF++lvR12eUX6srUumcDsul6sLLbl2a9mpU+JnMEO/AdmOXCuQGxPt
	hEE/snClj+miQBQtZ8jLsLATpSziKXSZEGcseHxAI2SBc93WIzAbk4B1ZyPNAbArd/Q=
X-Gm-Gg: AR+sD13Ohi1MWIme1HNINS2rlRSHKeUlJ2xcdPRSoo7ssPo1zZfVwa0g44lbqUr5srq
	7IQO4gepUTLCczDPxrG7Om+bVFeArKFxJormj/4k+GzDJkrCy7h8YUP7PacL70Cw/xbW7qNvaSa
	URH1ixK2KzbK5r5X12+hBn4ch7GkkmfLofdCyB6ZPlsbuBrgn6XXvRWnp6stbsUh5EYd1gCjnDL
	SRt31wxLv3/Z8oaYSNe4otgPHejX4nOwisRSlmc017M7nKEs/4wS6sgf5TlJ1ovee7Ai75NaTDf
	n+F7MFBLF7A2PGSxYMAk7KA5/875KNB3mXMzCQxj955BHVHuMM0/o+f4DXyDYyG5kyW6No83BfH
	sgUL9cCLPEcWE+2yWnbj7z+z0w+u6CeG/SWM+2QLn8LmLkg/CaeaHjEMnPhV1hkKiJ5jNKD9aaf
	uG1bibw7vkl4d0y6NkkRKS0Ke92p+FOaxNSXYM1jUjXSGtiO55QYx+m/obHE+E5BnV
X-Received: by 2002:a05:6830:2b0b:b0:7f4:daae:401d with SMTP id 46e09a7af769-7f6878a21f0mr5338278a34.8.1788215626889;
        Mon, 31 Aug 2026 15:33:46 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:778b:da9:a8a1:bc78])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f4fa7efe09sm9190551a34.11.2026.08.31.15.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 15:33:46 -0700 (PDT)
From: "David Lechner (TI)" <dlechner@baylibre.com>
Date: Mon, 31 Aug 2026 17:33:06 -0500
Subject: [PATCH v5 2/3] iio: adc: ti-ads112c14: create data read helper
 functions
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-iio-adc-ti-ads112c14-continuous-mode-v5-2-76f80a04b94f@baylibre.com>
References: <20260831-iio-adc-ti-ads112c14-continuous-mode-v5-0-76f80a04b94f@baylibre.com>
In-Reply-To: <20260831-iio-adc-ti-ads112c14-continuous-mode-v5-0-76f80a04b94f@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Chris Hall <c-hall@ti.com>, Patrick Edwards <pedwards@ti.com>, 
 Kurt Borja <kuurtb@gmail.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "David Lechner (TI)" <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2657; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=0jleKfSV4x8zSuizbp6O6ni4ujngh47YqjL22y19AbA=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqlgEx+aahE+cYocqs2efmRZVEAwCyLE4ueayOX
 YCZ4zl5g4uJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCapYBMQAKCRDCzCAB/wGP
 wAAKB/9xHTeXLzRpeOEtix20REwMw6zmGeJg51rZOWxL7X05ayKgnlN1M5Mh0juAwfUQS0UScTq
 +kNh7PBZiBAIFfX+mnxguDvtPNZdw0lEQNLTLm/FWnaw4qPQplpQwJUEJXY4u76ObGhIlAupSQ6
 IGBrnbcVmmPgSYNKymnSEDJRQP55cHd2g4CBaQoekfQ8zTrjyKwfKxZdIgYljZAUsKMdUqKda5Y
 9HtcQ7u2tDjFXjVOIgm1adYjVf/JqZD+aMQ0mLfYJWSd7dI1wLYRIo62VTDl21ZhdsGoTEUYMua
 M/p+gTs2+NhTPoEGzoeVyLos1aO5JhIJDheH5p7wg0X2VOhY
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Refactor a few bits of code into helper functions. These will be reused
when continuous mode support is added in a later patch.

Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
---
 drivers/iio/adc/ti-ads112c14.c | 51 +++++++++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/adc/ti-ads112c14.c b/drivers/iio/adc/ti-ads112c14.c
index 63b819339788..23f15be303fb 100644
--- a/drivers/iio/adc/ti-ads112c14.c
+++ b/drivers/iio/adc/ti-ads112c14.c
@@ -601,6 +601,32 @@ static int ads112c14_prepare_sys_mon_channel(struct ads112c14_data *data,
 	return 0;
 }
 
+static int ads112c14_prepare_channel(struct ads112c14_data *data,
+				     const struct iio_chan_spec *chan)
+{
+	if (chan->channel < ADS112C14_SYS_MON_CHANNEL_BASE)
+		return ads112c14_prepare_measurement_channel(data, chan);
+
+	return ads112c14_prepare_sys_mon_channel(data, chan);
+}
+
+static int ads112c14_scan_read(struct ads112c14_data *data, u8 *buf)
+{
+	struct i2c_client *client = to_i2c_client(regmap_get_device(data->regmap));
+	int ret;
+	u8 len;
+
+	len = BITS_TO_BYTES(data->chip_info->resolution_bits);
+	if (data->i2c_crc_enabled)
+		len += 1;
+
+	ret = i2c_smbus_read_i2c_block_data(client, ADS112C14_CMD_RDATA, len, buf);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
 static int ads112c14_wait_for_conversion_irq(struct ads112c14_data *data)
 {
 	unsigned long remaining;
@@ -644,15 +670,9 @@ static int ads112c14_single_conversion(struct ads112c14_data *data,
 
 	guard(mutex)(&data->lock);
 
-	if (chan->channel < ADS112C14_SYS_MON_CHANNEL_BASE) {
-		ret = ads112c14_prepare_measurement_channel(data, chan);
-		if (ret)
-			return ret;
-	} else {
-		ret = ads112c14_prepare_sys_mon_channel(data, chan);
-		if (ret)
-			return ret;
-	}
+	ret = ads112c14_prepare_channel(data, chan);
+	if (ret)
+		return ret;
 
 	if (data->drdy_irq)
 		ret = ads112c14_wait_for_conversion_irq(data);
@@ -667,17 +687,8 @@ static int ads112c14_single_conversion(struct ads112c14_data *data,
 	 * with CRC errors, but rather leave it to userspace to decide what to
 	 * do.
 	 */
-	if (for_scan) {
-		u8 len = BITS_TO_BYTES(data->chip_info->resolution_bits) +
-			 (data->i2c_crc_enabled ? 1 : 0);
-
-		ret = i2c_smbus_read_i2c_block_data(client, ADS112C14_CMD_RDATA,
-						    len, buf);
-		if (ret < 0)
-			return ret;
-
-		return 0;
-	}
+	if (for_scan)
+		return ads112c14_scan_read(data, buf);
 
 	return ads112c14_i2c_read_bytes(client, ADS112C14_CMD_RDATA, buf,
 					BITS_TO_BYTES(data->chip_info->resolution_bits),

-- 
2.43.0

