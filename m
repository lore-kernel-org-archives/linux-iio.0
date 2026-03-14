Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C731139D
	for <linux-iio@vger.kernel.org>; Sat, 14 Mar 2026 22:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773527594; cv=none; b=qysh2moSL86fDeI8U/2WcKtlYd3Ep3U2gQmcIXr4qxdlL2hESOwCXH4A1RYaqZVeb0XfPT3e7MdLvZSKxia3N0zq5ojBwkmWEDiFb9feMLdJEGFbXSNmjkPXxmY3Wi/VThYvyjtC0wTiruKzZW5adlkpd7gw9xc0BMqdpiohvIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773527594; c=relaxed/simple;
	bh=F5YZfmacPGnfiNEAS0erRG+QQGtKjmB3EGupdTdGS8U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=nNAmduw0bR7w4qJqpd0cJhAJ1s6kfW679lXBtFuj7bui2CGXVOH6ctWXuoK/X9+K+ApVaZjgAVw7euzMwAifyMPJMn1OLEmop6NjFA3GF7Hegftt2jtanBDq8Cz3cM5UaXSd1+YZRu0vl4ZFiIkQPa1T5migcH7EPApOH1LeKbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=2ETQItmx; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2ETQItmx"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7d74aa6bcdbso2301406a34.2
        for <linux-iio@vger.kernel.org>; Sat, 14 Mar 2026 15:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773527591; x=1774132391; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h2tAKbjHUFoSXKgHV6cgHXldBRcBG6iPADoEUcfnIy0=;
        b=2ETQItmxuItZzGn4X9tzdQGrDLW2nugKtCU+UUwprQ6sYSDmG6YmNnQvrDU4KS+HNf
         mDvrmPZQ96Nw5OObub7x/SjrmS2HtR+dG999oqFCeoVlAa6GQo3ZcidWRuq0szF29WRb
         7lUCtYKPPdJRcJlJVrkCiOpTised83oGtYHM685SvXfGRBwBQqHMCUsGLpaJefjOsWQm
         0kJ2gJpovkzcbiGy5uVCVng4Noo/oc/zsXhnxWDq24pOJl76x8cmxAW2JRYEcOPCnHFz
         iogZcKZcmfWVuESg62V2ZxbN0+xHhGX71jz6niQLQHNowjj19zuvepbDH2grtnMK57Wo
         dvJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773527591; x=1774132391;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h2tAKbjHUFoSXKgHV6cgHXldBRcBG6iPADoEUcfnIy0=;
        b=PtcU0VH54JGbEKfKB62xWD83ZShuO0h4zQDRvmxBYVpyPrLmjxnU2uAOaLNRljV0l7
         XgQzTSe2IxY/AJehfvRgd5mJETHOuusGaT2IldAZpm8xS+lQYTHA6CA8aZO1dF7YMJy/
         ofgZPLA4kjuFCZdE6VKgIN3zx8hrtzTw8xPavaLCYmNsegevu+sqHYFghUQ5/myGOAB/
         qbhyhS/gBf2aAg6voMn1K98zvgsd86eqBetzoAKvWobUmClat0p7jr5JVq261sQ6JQDV
         1grbgE4oT5lEk5vQojC5W7egG0+nqYjTlKidjM1hPWBdxXHa25vINC/L+Dzz5ChN3rMA
         A8Mg==
X-Gm-Message-State: AOJu0YzREl/EH5XTEi2khVe9MqO/KKBXFK7K/+XPFFISjP5bPnnBZfPt
	USShVogC1eR0TJxEsGoBOlQa08gjTJx1zPSSTju6XYBZKeUqM4LnisLCTNyIQiVvcf4=
X-Gm-Gg: ATEYQzybE0cpx/0EhCAGvHl5Tte9wvdu603jiDreOZZcRr8F7xq2Ho9SvHZKXJ6xTh/
	bGTxKmHAP1Z8HPGbi/5cgNucb8ml8ksz+tnvSV2p6KjSANb7NasTIo/EgKKGozi5VllQUTzA94i
	kQjzG6HvSEzoCc6BdLweQ+XJjtwKRmlaGMlM+J2Ju81iydVeKSXzmbHo2o4Hm3WA0plvnLI4zU7
	MK3tUxoI7yEA15OrqteYHR+YpsVy6N1zJ1qJ+EiuU5s8YtkJqE2mLVt07ER0A7vHzK5zquQaq7q
	7nqiRKKR2OvbpD4S6AOf8HuJ7J9qGAWWucUJ+Bw+vUctzFhKSTJitWgbrk6fOWaTbT1qoyX9G44
	RB5bRL85hHke/g463sOFVVQVvXypIcyijycVqHzY41ZST29ml6tGhju8QPD9b2GbYKqVNFuXmCG
	unKECIyFiIsS2JcV4ZQOEiRWIxV6jy
X-Received: by 2002:a05:6830:64c8:b0:7d7:556e:d677 with SMTP id 46e09a7af769-7d7825595e5mr5383286a34.29.1773527591504;
        Sat, 14 Mar 2026 15:33:11 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:f27f:adf2:8637:6bb9])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d76ac898d6sm9161899a34.9.2026.03.14.15.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 15:33:11 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Sat, 14 Mar 2026 17:33:01 -0500
Subject: [PATCH] iio: health: max30100: drop unnecessary cast
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260314-iio-health-max301000-drop-int-cast-v1-1-ed4982d559f5@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXNQQrCMBCF4auUWTswaYqiVxEXMZ2YEU1KJkqh9
 O6mFt7m2/xvAeUirHDpFij8FZWcGsyhAx9dejDK2Aw99UeyZkCRjJHdq0Z8u9mSISIcS55QUkX
 vtGKwQ9vZMoUTtNBUOMj8P7neduvn/mRftzKs6w8scQiVhgAAAA==
X-Change-ID: 20260314-iio-health-max301000-drop-int-cast-f34f3493e0f7
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1079; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=F5YZfmacPGnfiNEAS0erRG+QQGtKjmB3EGupdTdGS8U=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBpteIftIV8A41NMi4M31u6QsOVQbEQcQX62eolp
 iprnhIVgi6JATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCabXiHwAKCRDCzCAB/wGP
 wOZyB/0a3tRcAyrXVje/1hVi5YOhKAUZPfX7o9PvZmV8Qt4Fu3dIz/4yIJPP0QYX44Sh6xivQRg
 q/ERP4lQscQv2etgbwxW/UB5sGMeTiSmfp2F+oDGpWyieC+c37CcfQ/eXmko7FKXnArHgcsV+c4
 Nvwo2RIbqVEHm/ljk45HW9O1DaJrtB2MXxOdeHTEJUVNJ+qYZ4mA6UMZA6TD+mgvm22go/d2kis
 uZfflV1dCDJg21Gk5IMIwrt9yY1nIWaqIDxINhDbmsshjh/c2PxBkgxd8EYYXmy4nCrDwhpAOzj
 zqWyH4/9XVDSZ8Ni4IAzV1vvKq/34ccvEg9+2JAhwN3AXT9w
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Drop an unnecessary cast in max30100_led_init().

val is defined as unsigned int val[2]; so the cast is not needed, nor
is the address-of operator &.

Also fix alignment with ( while we are touching this.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/health/max30100.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/health/max30100.c b/drivers/iio/health/max30100.c
index 7dfdb5eb305e..00dca1c9425c 100644
--- a/drivers/iio/health/max30100.c
+++ b/drivers/iio/health/max30100.c
@@ -274,7 +274,7 @@ static int max30100_led_init(struct max30100_data *data)
 	int reg, ret;
 
 	ret = device_property_read_u32_array(dev, "maxim,led-current-microamp",
-					(unsigned int *) &val, 2);
+					     val, 2);
 	if (ret) {
 		/* Default to 24 mA RED LED, 50 mA IR LED */
 		reg = (MAX30100_REG_LED_CONFIG_24MA <<

---
base-commit: ff0843ceb1fb11a6b73e0e77b932ef7967aecd4b
change-id: 20260314-iio-health-max301000-drop-int-cast-f34f3493e0f7

Best regards,
--  
David Lechner <dlechner@baylibre.com>

