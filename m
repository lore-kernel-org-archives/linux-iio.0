Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520C93C3448
	for <linux-iio@vger.kernel.org>; Sat,  8 Aug 2026 03:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786161550; cv=none; b=cwbz4i6hGoVLbniyV0sbPJzYE4BbvtPnSui/8akLwpcnSa19yu7Q2VZB2F/IyvTQPgT4+n+W7JqCVleDmL72CsQLIUQqRaWdJa2h0rNMcwVdK6AIUr6YU7K+LI15tl6z+vC94+5SbjzD68V8KbJfxPqsm86nhAocFUnDuLGuxIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786161550; c=relaxed/simple;
	bh=ALPm4wN0XxL4MAFfiFBimkAb2s7JRwqMzky26VfX7JM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mIdvrKVUSIv2fUWfIApSafa3EE/sjS2j3sm8+9W0CdIduawMd02GEafiP/aNi8oLcXuUfZOLDilISnCUpjEz8qd/z48pLrt2MpWYc11aNndkGluqP/u0Dj/XODCDQZDa4SIQ1IO3Hm5lvkzArlhq1i+OkC5e1hceb4NjgbGP+XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VVhbSvW3; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVhbSvW3"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5c276bfce7eso192517e0c.2
        for <linux-iio@vger.kernel.org>; Fri, 07 Aug 2026 20:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786161547; x=1786766347; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+Z33c2/VIdQJHXYt//EgpTsqkZyaHvNkSYBF+LRNUwo=;
        b=VVhbSvW33O2Q7jd0o1t2l73Y/OFOskS8IYccyEO6ANNqlqmNv6RxnR93kXC8Rrv+n5
         k9XgSQqlo/NAh1Z/2Qt1pr5px1c+Wwa5fSBsad93nyXw5g3pkBlVxQ+IJDAf0X1IBnC8
         x+jOsk/JfO/sE2Awzo7vfPUT96QvWy1f9jjVZ1tqVV30Z19jshHRwPtK+29jSx2wQ1i9
         aC3wMW0IVLss6icIJ77cFANq/w4S4MTvE4t/JHlZk7I5AAHd5Df3ix16mD/Uqwo3DMMp
         cZLQRdSGwYLDmupGnoQPmWF/dQrKlaIEYBj9aZVhmGKDbttjWwx9lycV4UXmU2eI1BnU
         pgjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786161547; x=1786766347;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+Z33c2/VIdQJHXYt//EgpTsqkZyaHvNkSYBF+LRNUwo=;
        b=RosNA3OE36Z2iVL5lDR6jy3UJxt5tL7ziF6Werj5umFDS0KpDyAPUu350ZhPYmMk23
         z63pnYVHV1zGDd9u6uoaYCNqrvWfcxC+LW2Pb1aFrKYYrOLnedud7YvonPbOTAAoGvuv
         0XZQXA0T9zHKwqL1sUKLJ1+ChqTFvEQZ2oe+NsA17sDDkwTfoqL6nnO7dBRZZGGfwVIP
         NWRhsuimzEfrxYnrHhsbGdRQ1amSnJW5kupcNvSKrCuQyNqo1yfjngVOdY2TuUyaGvUN
         Y0eqEhdmFC7dUKj8PTpouf1QuQ3PlnznIkL7+nBRqBgu4ybGqQsFo99iXK/84INNEfMC
         Qkgg==
X-Forwarded-Encrypted: i=1; AHgh+Rq+B8z1JW0ojHdp2yJrYFF3zcZSObS69doV694tkT6dvXcBwrNA6M+wxt7lD7WjGb17J8sGZ3tLU6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTsJLqHbykRUalgy4o/EjqpbAHFHxHWR3zbzAnKrUZFsHlc5fg
	mwC85kL7fX05VwDEGVKAXB9vASBAGESCH2/HxJqlTDGWCXq5C3UXRAXS
X-Gm-Gg: AR+sD11Vw/loGQ7epIvnNfF+pyBpazIsvX8LZrVbvvsmVXI9mCZqZlxEGvJ78DCNw0d
	ERIgPjrLlg7EgVPQ67TB5lV68Voq4zRRNry2VhXJzpiQgMETxVF6MJuxxvUMyou3VMbJtg/8+4N
	0HfSfuH5MjjkfS2xoDMIq0BpaOct7rtFzxYdgcvzbYvZeWFl+ZbFp1qHUcCxfzqUvvR915g6BTX
	p8n57i1iN6EtdNcL4SrXrV9dEpWJGZNuD9F5VBWf3U8GT/1VRWZkspTfU+vLleSOHAgIX7wM6wy
	3rrRsJZie2tLuAsm9gm8J2DkuqSNROixy7GUQ0KhYNC9o53y0ebujxSpc1q4CqrqUNotvjHtI40
	6UYcEtXMp97Jik6TRlxW3D3kiYjMmzZ6dkBtXakkGixiL0dxm9DlSe+4hIIau+dz5+u5HjS+Fe5
	0qYpZZS+u+RYv7tcVszCxxh8aTvzT7Kxy1QYrFhxgeL0Ftf57epmVzJtBTu6mG
X-Received: by 2002:a05:6122:e142:b0:5bf:bb2c:1328 with SMTP id 71dfb90a1353d-5c3d9068a9emr4114304e0c.3.1786161547188;
        Fri, 07 Aug 2026 20:59:07 -0700 (PDT)
Received: from [192.168.100.6] ([2800:bf0:82:11a2:7ac4:1f2:947b:2b6])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c40b212fa6sm1432936e0c.16.2026.08.07.20.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 20:59:06 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Date: Fri, 07 Aug 2026 22:58:31 -0500
Subject: [PATCH v3 9/9] iio: adc: ti-ads1262: support common mode supplies
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-ads126x-v3-9-f89925d72792@gmail.com>
References: <20260807-ads126x-v3-0-f89925d72792@gmail.com>
In-Reply-To: <20260807-ads126x-v3-0-f89925d72792@gmail.com>
To: Kurt Borja <kuurtb@gmail.com>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, 
 David Lechner <dlechner@baylibre.com>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1626; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=ALPm4wN0XxL4MAFfiFBimkAb2s7JRwqMzky26VfX7JM=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDFllKyv+Bi7cp7Z2Ws4kW07VnctsRJW3+IbVM4j9nBazW
 Ei6USeqo5SFQYyLQVZMkaU9YdG3R1F5b/0OhN6HmcPKBDKEgYtTACbivJuRYeWM5Y9b32dbyz5U
 835veax3o2ybb8nmVZWsf16svJQk9JeRYbXY1eC4ZllZh1OuHVLKgq8MKmM/688WLC+r3/Yjsia
 RHQA=
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Enable common mode regulators. The usual configuration is to have our
own 'vbias' regulator connected internally as common mode voltage on the
AINCOM pin.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/iio/adc/ti-ads1262.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/iio/adc/ti-ads1262.c b/drivers/iio/adc/ti-ads1262.c
index 533574169b04..238d803abc50 100644
--- a/drivers/iio/adc/ti-ads1262.c
+++ b/drivers/iio/adc/ti-ads1262.c
@@ -962,6 +962,27 @@ static irqreturn_t ads1262_irq_handler(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static int ads1262_common_mode_setup(struct ads1262 *st)
+{
+	struct device *dev = &st->spi->dev;
+	char name[sizeof("aincom")];
+	int ret;
+
+	for (unsigned int i = 0; i <= ADS1262_INPMUX_AINCOM; i++) {
+		if (i < ADS1262_INPMUX_AINCOM)
+			scnprintf(name, sizeof(name), "ain%u", i);
+		else
+			scnprintf(name, sizeof(name), "aincom");
+
+		ret = devm_regulator_get_enable_optional(dev, name);
+		if (ret < 0 && ret != -ENODEV)
+			return dev_err_probe(dev, ret,
+					     "failed to get common mode supply: %s\n", name);
+	}
+
+	return 0;
+}
+
 static int ads1262_regulator_enable(struct regulator_dev *rdev)
 {
 	struct ads1262 *st = rdev_get_drvdata(rdev);
@@ -1797,6 +1818,10 @@ static int ads1262_spi_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
+	ret = ads1262_common_mode_setup(st);
+	if (ret)
+		return ret;
+
 	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
 					      iio_pollfunc_store_time,
 					      ads1262_trigger_handler,

-- 
2.55.0

