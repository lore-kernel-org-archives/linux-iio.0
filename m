Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0BB3B3BF5
	for <linux-iio@vger.kernel.org>; Thu,  7 May 2026 10:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778151105; cv=none; b=oqzo+TN9LraCVpEsnQI88iijWAGGrTh6nXom2NxOsC4xRuBMz6vnWHqTQIICgxo8o7oi6N9eRd0I57mC0Z6pXCsMqg6WHTKsywl/h3n8Vj6tT46Zgt1Ak52PSNRyQ/qLNHJNYK5CjO7gQ8w28/rs+Uu3Jxmj78QoTfJOb/oHjVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778151105; c=relaxed/simple;
	bh=8be50cgUO97dUmyXY8QEaFaIeWcvbyn4FZHCMFnyX9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RNKwQh3ynm6qZqzsgpmAXBAY/ndTbqDg4kagb1eJ+g+U5/zyIbKCx+2sLOV87NeY4+T5oFoD8F9FDgJGjXWyr2hnp2X9R8cqzm6LltmtM8Jak9eCmiFAw8jsuDm+DmB7sEfCkPI+Uz3F0gP4KP3xFsACAbSDBjeO8QAWcuHWsUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OLbQ/Kg2; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OLbQ/Kg2"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5a88de2b52eso953295e87.2
        for <linux-iio@vger.kernel.org>; Thu, 07 May 2026 03:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778151094; x=1778755894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iev/RaR7ebPD8/QuDYCOu2PRxG+LdvAV0DZxv0cI94U=;
        b=OLbQ/Kg2Ab1Nw7b0o9rhRmuhauZ2HaSuOpQfUpIj4uySDNFnH6CgGvD7Mc/sW4UXSV
         zV+0wktTQFDPHQN1GQkVRrrTvM5hC3a7VmaOe1DJBDAw5Gb7CFTut8FUJIK0ExxD6n2p
         zFzZ71TP3gMFPyHsjm6daHIVozdr5kTpJOlc87+4L+EiNmh6ozkF4XkmKtSbT5azqjrI
         SH+qQbQwCrQStYtmUCTuy2XjHd0c70+eBd2pl8a59pAMV3Ex/5CbPrnGGQoscp56HIDQ
         rm+UusqD98fRu1+xv7hkbw9THovkrquCas5W8T1Ilbu7KwNpvPtPhuwFaOJKFhiXgiLe
         BlGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778151094; x=1778755894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Iev/RaR7ebPD8/QuDYCOu2PRxG+LdvAV0DZxv0cI94U=;
        b=Ewbv9mJ6VF/mJ3pnUwX7cWws6jgiAD5JDN0BJJgeDANin6YteDAMmg/nI00hrQ6/jp
         kzUSjd2nyJk1GoV7qbGoV6QwS7minxuMa8XWyHADjBQy5mAnQs6/GQDw1lhm+kdzJqdn
         YlRntMSinQ59j83Yjnt6VuNW5N2T5bvrSLOxc8qOSQ6dh3YRSecYBSFK7AZydS57d1Gz
         EYMYD+nkEp3yDjkgKrnTDMTMuQiMjrujIjs2NwACMRf8cABx86NyPJizbM563dWg4JdT
         rT0I87r6iTw9SnEqlH/ESp02rN07BMZWE6EJyEOPzm6WlHPO75TppJsH2zhSW9R04DNL
         xmOA==
X-Gm-Message-State: AOJu0YxRM35GVa8Vcif/K2UMCHg5BZn7QigWhm0LquHpsfhl7ztqbxm6
	SxZfJ8Hgi+HW02BINw1kj4qNjIrTc42AxvJjxJVsES3hlfFg/b9T12w+YEjAFbJf
X-Gm-Gg: AeBDieucK/ku1ES6W5zprSLhqf0Mck84D5bPsu5bHeDAvRH/QMQFxpNrerACOBo2ibk
	3CjmVvHu++rfWiSg4pYxIl9SeaGjZyrOZFB/JolAYlRGpUk4FqA2JoHlT/5nm0zkb9vQ1CwGi7p
	5GWi9KYAqsEzxdMZeBfbD7z5/mwud2F0L748GH0QgSNefZyaLWGyitcQEka6ntnoKFKRBBVblwa
	GdsUfcN7hR2Du1NQwU9xvDMd56q9WVFast1EO4d7FjbWttG4Y1FJG23JhWNZ0e13oXsFFQdsC6e
	NKLYaU8oKlHzI6EtVL6AFpw9ICxlT55n7uUm9dzSGncN43/wNJLf/ZVHLmf+XCJRuagfB1yBwL5
	4oWju3iaFnMyJtDa40RBk5ErqDAC6Q1MCcqfEtMFYVqckPN+6LetPP25bcsinelysotRR2AhZdo
	8w+EFfPwW2u+QsNAywvG7E2Khc9pyA1vXRDDVkP4VjSDkYqsT1iX2I8d53dx9FxxrT6yIVjIovU
	y8=
X-Received: by 2002:a05:6512:682:b0:5a8:7d6c:8b82 with SMTP id 2adb3069b0e04-5a887add82fmr2719997e87.7.1778151093418;
        Thu, 07 May 2026 03:51:33 -0700 (PDT)
Received: from Shofiq (87-92-218-151.rev.dnainternet.fi. [87.92.218.151])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a85c341848sm5530224e87.65.2026.05.07.03.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 03:51:33 -0700 (PDT)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Md Shofiqul Islam <shofiqtest@gmail.com>,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	mike.looijmans@topic.nl
Subject: [PATCH v2 3/3] iio: adc: ti-ads1298: Remove unnecessary CONFIG2 write during init
Date: Thu,  7 May 2026 13:51:28 +0300
Message-ID: <20260507105129.25639-4-shofiqtest@gmail.com>
X-Mailer: git-send-email 2.54.0.windows.1
In-Reply-To: <20260507105129.25639-1-shofiqtest@gmail.com>
References: <20260507105129.25639-1-shofiqtest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver was enabling the internal test signal (INT_TEST), double
amplitude (TEST_AMP), and fast frequency (TEST_FREQ_FAST) bits in
CONFIG2 during initialization. These bits activate an internal square
wave generator intended for device testing and calibration, not normal
ECG operation.

CONFIG2 defaults to having only the RESERVED bit set after reset, which
is the correct value for normal operation. Remove the write entirely
since it would just be writing the reset default value.

Suggested-by: Mike Looijmans <mike.looijmans@topic.nl>
Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
---
 drivers/iio/adc/ti-ads1298.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1298.c b/drivers/iio/adc/ti-ads1298.c
index 186bda3087..8957e873e1 100644
--- a/drivers/iio/adc/ti-ads1298.c
+++ b/drivers/iio/adc/ti-ads1298.c
@@ -615,15 +615,6 @@ static int ads1298_init(struct iio_dev *indio_dev)
 	if (!indio_dev->name)
 		return -ENOMEM;
 
-	/* Enable internal test signal, double amplitude, double frequency */
-	ret = regmap_write(priv->regmap, ADS1298_REG_CONFIG2,
-			   ADS1298_MASK_CONFIG2_RESERVED |
-			   ADS1298_MASK_CONFIG2_INT_TEST |
-			   ADS1298_MASK_CONFIG2_TEST_AMP |
-			   ADS1298_MASK_CONFIG2_TEST_FREQ_FAST);
-	if (ret)
-		return ret;
-
 	val = ADS1298_MASK_CONFIG3_RESERVED; /* Must write 1 always */
 	if (!priv->reg_vref) {
 		/* Enable internal reference */
-- 
2.54.0.windows.1

