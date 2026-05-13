Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F96C382F2C
	for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 04:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778647820; cv=none; b=uRH/pBIO1fMwVbEsiojE2nsqcB3odbcAxq/ddMz+rUR19PmzlZ//Noq00LVC26DNBOc1of9QEhChjSAH6mNLSaqJhrT7sr8cwi23JPoRFKBLgp5zGoF8f3XqMRIHPM+KnShRGZIvUjHo/otI9rUjH7fVpjF9OHfIVavBVza99Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778647820; c=relaxed/simple;
	bh=tE0vkv4AeNf9uXj69TTohvhoxtlDeJ+vneLAz78H2GM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eqZgUgJyA+HHMvcC+4r5oPBNTYYTJyvESZuFJWnBQrXnGxOzrYpzQfgYrk7jovZuBMF+oFY7omHIHkC/4lKNmRuVGD26jhhUPAf2eWrhBuRxa7TbPBbEh23JYE8lFiz++g0WajWtc+4pFmxp7tDPzQIBWoEo/LfPVeBvuhvPyNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aKS/CRqA; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aKS/CRqA"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-836ebdeb969so2956449b3a.3
        for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 21:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778647818; x=1779252618; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7zlpa7Ke4ytx6XPVc5PZ6mNxC3kCRBVIMOI9TKDTTjQ=;
        b=aKS/CRqAo10wmFosk25zcB2iHvTml4vYTy0c3zNV/6yCSPYHNTMUXNrKZpUMQAKnNu
         crH6KTz8TEAPAplRaw0kVFKiXBGgveqsF1DCbmr8u1kb+jhjPdtu2PjaNVc7SKcH5lJr
         Nek4Wys/n1AAzjajXM0qHZYoY/iDsSS3m2KMHiMlMT1AQerPG3WlIdzY/3Y06rEuS6vW
         dB7Fd2mvprA6SGVemRcGggOu1zBEQFfLvJzSZdipxYp3s4UZpJOej39fwkNgp1yG3LuG
         baCCcIQ2ybbhdvLWaF4KgLExvFnhDYUV8UkCOs7ZhJ4FGNRqVxZJRqiMHArIFTtxWQQ/
         SvHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778647818; x=1779252618;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7zlpa7Ke4ytx6XPVc5PZ6mNxC3kCRBVIMOI9TKDTTjQ=;
        b=ShKBmf9sxeSq8ZN07r36icCnOGJAICU7ppPdsekQ3yT6wh8gosY1ZqzLqngfDePMqx
         SB8IKrvpdZefPt5+PlHFL9b8HNdaUdvYbBjp+ta2Yhhsr3PYC9H5B+k2vnBP/DvRULI/
         y6f3+tCLs0NWxWJgFKL9sykk3mWtd6U+CmGsXaEdKJ6qjOGuEsubF4loC5qlYoeni9+7
         Kb/wUspN4EwRIsRUlaIvn/UM+kkkwnJo9ARp/Z0TB5ruuVwRSMdCocYqcgS0iDahXod3
         ce0DF5+PfCm52Qs34LyRwFoIfJtiwNAB9Q0nYs6OyuhDaQrcPsLx1Bm7TYJKSZLtAP2a
         lb1g==
X-Gm-Message-State: AOJu0YzG7VUdXo4vVAFhYmYmGRVazdRbv7eysCkxM+HKOPdzVqFq/hrH
	0wDNBLyKhMfYeyre0ifoXjE0mv4pCHO2sEmJ26ii9t7SI++mbF4i5rgI
X-Gm-Gg: Acq92OHHmXLsg9h5G6Lkkpay6fZ37LqyU6S1TWlwP7XjAKJlOVwIXvtcSkzxoiIgJ6U
	ezdpxUglmXVUOP8ycSt8BRRJofN0GJgNmQJsqLmDKBxh5EvEKNV8MSIMJ2SjoSvV/4wkH0WDRwb
	JwTXRiQ0tESgDjWKOazpYoJU5HUqrJUEj7tMh62vt1RAl5MhrvtS82xCgHjYO/Af+QQ6JXOUCDQ
	WwS6NVmH1hOn2rdKfgbE7ItvBoVkl+49KWuzYukJhBTv8pap3oxOBXjcHV8jPq3KeVxmxmwMG0n
	TTJRiPOArhaUXNBUf9msJ9fN1ON1bwH6X7S+rNAlM631C4pPWypFlxAI1+ayCj2FSJ93MpPgagB
	uTrk+sa74p0ZgyW3eztxChQHifefu5i2dH1TGI19ngnS2x9zX1S37OxO/x4u3XJ6nrHLHME6lqr
	ABrVMM1knPrKddHHLFIXBz6AgYrJsJVod40S3+
X-Received: by 2002:a05:6a00:800a:b0:834:e15a:19f7 with SMTP id d2e1a72fcca58-83f05d5ff3bmr1328113b3a.44.1778647817871;
        Tue, 12 May 2026 21:50:17 -0700 (PDT)
Received: from [127.0.1.1] ([203.99.159.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83965c30ddasm32311914b3a.21.2026.05.12.21.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 21:50:17 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 13 May 2026 17:49:41 +1300
Subject: [PATCH v2 1/4] iio: light: veml6030: remove unnecessary read of IT
 index
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-veml6031x00-v2-1-4703ca661a1d@gmail.com>
References: <20260513-veml6031x00-v2-0-4703ca661a1d@gmail.com>
In-Reply-To: <20260513-veml6031x00-v2-0-4703ca661a1d@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Matti Vaittinen <mazziesaccount@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778647803; l=1095;
 i=javier.carrasco.cruz@gmail.com; s=20260111; h=from:subject:message-id;
 bh=tE0vkv4AeNf9uXj69TTohvhoxtlDeJ+vneLAz78H2GM=;
 b=ISt3NzjRzb7KhHFzYzU7B2y1enxR6T8lMuDXUlrcwUAm960i6bB641ld75uErc1Haoe7q5PCx
 UGoUQFOdwnoCTbsG/rQYhHSBEbsZ7VkkHKCRH2y45BPImcvpL4WwIx6
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=Lge8w8xidNSf/INy7JAIbAW+Hezkp3nsBh2OjKL7lLU=

This is dead code as the IT index is not used by gts to set the new scale.
In its current form, the value is read but not used afterward. Remove
the dead code.

Fixes: 22eaca4283b2 ("iio: light: veml6030: fix scale to conform to ABI")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/light/veml6030.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml6030.c
index 6bcacae3863c..745cf3ad7092 100644
--- a/drivers/iio/light/veml6030.c
+++ b/drivers/iio/light/veml6030.c
@@ -521,13 +521,9 @@ static int veml6030_write_persistence(struct iio_dev *indio_dev,
 
 static int veml6030_set_scale(struct iio_dev *indio_dev, int val, int val2)
 {
-	int ret, gain_sel, it_idx, it_sel;
+	int ret, gain_sel, it_sel;
 	struct veml6030_data *data = iio_priv(indio_dev);
 
-	ret = regmap_field_read(data->rf.it, &it_idx);
-	if (ret)
-		return ret;
-
 	ret = iio_gts_find_gain_time_sel_for_scale(&data->gts, val, val2,
 						   &gain_sel, &it_sel);
 	if (ret)

-- 
2.43.0

