Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10313203B4
	for <linux-iio@vger.kernel.org>; Fri, 20 Feb 2026 09:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771579157; cv=none; b=r2cxL8RJGw5sQO6ewoVYT2RxHAT4F+5kBN7hdICSwNjc210qW/H7ACvyoH0vLCAis5WxGLPKUyPecKYnyctA79BaqnCjBfoLXpgdFKUAiaMm11iLIU5buxYjo/UTEo2XFdDAtg+GYo3pxRqzQK11NbhE2nT3UiVk1anU+yWac/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771579157; c=relaxed/simple;
	bh=YivXcgaeSy4QpelRV9DOtIokhuwXBYKEbFlVEzS3lpM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dtsx4mcQ0KamTFgjZvWa1ZaSAE/sMy5a3NNRR00QVrpxanbAbLWvZNLhZvTGN3KP3NrtftLMnL4CM1aKU+KllMVZ1gYqMGvmjn5e++yRjMLTPVV8VWYCqEXN+pXwQwVPMCaGMt/gDJVezGFla4y7G6MOcrvWQXFD+knWnXjY4P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=BM6nE3bq; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="BM6nE3bq"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6581234d208so3192002a12.3
        for <linux-iio@vger.kernel.org>; Fri, 20 Feb 2026 01:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1771579154; x=1772183954; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VLnypLVR9kDKeATjKH+xrFf0kQ5EEkkXkqVAX1JHxt0=;
        b=BM6nE3bq7abmYjj4dSmVPfsbpiNDKCGYSUeEEz1/ZfdMsZ3pvu1YYezJHlXCuanE7o
         B8bUCYrSj4Lb2cRcbFvoKMC2EhnlggJAV1ha+XeuP5Fte0pZyI/IR2+5fRL5GzoQZLKo
         iGwRxzX12dyJKB+AUI1LgTL76Z/nRYzdbkOGNpTAnyQZEBx2HCIqwP3Z2TfvTNERRNCr
         Xp3w3GaZjtrK9Jd37tSA/t6TAlOasgVTv5D9gz876pwPUiRFWtOseJZB+QRg48kd9PsW
         JDUfyV5EfpPMF3qtoiu849btB9JyJm5qz+43t/ouqJbJKpSavlhV/tUfdU8/EqYn+i+b
         zb+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771579154; x=1772183954;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VLnypLVR9kDKeATjKH+xrFf0kQ5EEkkXkqVAX1JHxt0=;
        b=ZkOgeZc3UDPrgCsRz1+M8SxHlmghMRGWLcUpuBbP0Gbnph10Nq9F7UepVVR1WSsvpl
         hZMZy7vlc/S3vRR7A4TFyzb+frcKxp1WhXW9Co6ww+2riVGqCXBVVi5U6CquFTcW6FRV
         fSgvYF4yBl2Arjb6w9utWdQVc8xyhUldo//xTaHppfjieSn8SDUb+B0j/P5yrFyEF2Er
         RejuwRvUGiKV7qckCvVGfrUK8FU4KvW2kclmM6pdiVWsjuzZrG8K0HgLT6N4Q4fbNRFB
         H91pohRTkNUTqXswen1vGeQGYK9GT2lfRLfERtxO1mUZwSHzBoEEV+H+SAa6sQXfX+FV
         nzpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXeNX42XUJkB0vBMou+do/84dzZfRG8wH8VYimFv3USAFAaO0+5r65UY54tZgQ9UvJ3n73kaI7m/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwG3L4jmRcJVpzyvxghb1Uh09B+BvDns2qsfKZ1/7l26xaFRro
	qec9Sm9/VUAJfc51Scj7ykpqAT2JncvgVWKQqUijWfB4C+Anib34wYFLkJbC2phRegMBqcBOGhz
	O2N2z
X-Gm-Gg: AZuq6aKrTL/Ba2pkr2enAbsCPMj5vSEi88X9EDVaLIPqSdroOwUG+oksNnb6ZGO8sG+
	OgCptWP2uj/brLNKtEfh8nNBwH3P7QXIX7n+UYgbpXz9L6qQPuyNwxeRTlQNFl6HgnOYz/uJsL1
	ZlYTvcqlJPUsTO9fUdUGxHzObAIMpYCd+NZNTw8sInAhzsmxAWOyGZLUsAK3XxTYwWKzw3W4L4c
	IfsTNSYoUoWVXT/NERN6ccLsy3lMtBHlkJXxQsReXbJINkA3kc3uVpCj/yOUTc9jqsXC6q+IrQb
	LU3LawBn0JqqSLfF2BQb5mpYM4c2RhTBjBwu4zxqNXIwiJ+o2eKJ0roTNx0j1WOvWobR0D9Mr//
	EOV8fFzmJzF2ygw6XXHwomelrkIBc1xNwbRcTpUoKjWXtFsGGXownudt8VPOUEmT+RVgsHpXBL3
	6lyvWnnR1KXzf+MMD1p191WsFLWG/nU8Wjx5A+g7r2bUU4Y1hP2VjngP2JXdKJzGIKwuyY0drar
	ffmQA==
X-Received: by 2002:a17:907:1c13:b0:b8f:a033:dea8 with SMTP id a640c23a62f3a-b8fc3cb0063mr1256153366b.52.1771579153680;
        Fri, 20 Feb 2026 01:19:13 -0800 (PST)
Received: from [172.16.220.101] (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8fc769111fsm667098666b.57.2026.02.20.01.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 01:19:13 -0800 (PST)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 20 Feb 2026 10:19:07 +0100
Subject: [PATCH v2 3/5] thermal/drivers/generic-adc: Allow probe without TZ
 registration
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-bat-temp-adc-v2-3-fe34ed4ea851@fairphone.com>
References: <20260220-bat-temp-adc-v2-0-fe34ed4ea851@fairphone.com>
In-Reply-To: <20260220-bat-temp-adc-v2-0-fe34ed4ea851@fairphone.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Laxman Dewangan <ldewangan@nvidia.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Hans de Goede <hansg@kernel.org>, 
 Jens Reidel <adrian@mainlining.org>, 
 Casey Connolly <casey.connolly@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771579150; l=2004;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=YivXcgaeSy4QpelRV9DOtIokhuwXBYKEbFlVEzS3lpM=;
 b=qWYp7BdWMKuAhoenfEM06j8Q/89bWGGCajKBj/3ld6dfa9CRhyH0+n0CikO8ZiIZiFZpeKwzw
 Irfto7/gBVzDLJtZTCfThE3vEpXL8m+GOfcstnRd4K7t2IcaEUXOXw7
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

If the devicetree node is not referenced in a zone under /thermal-zones,
devm_thermal_of_zone_register will fail with -ENODEV.

Since the driver is now also registering as an IIO device[0], allow the
probe to continue without the thermal zone.

We also can't use gadc_thermal_get_temp anymore because we haven't
necessarily initialized tz_dev.

[0] commit 3762f5851ac5 ("thermal/drivers/thermal-generic-adc: Add temperature sensor channel")

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/thermal/thermal-generic-adc.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/thermal/thermal-generic-adc.c b/drivers/thermal/thermal-generic-adc.c
index 7c844589b153..4852e584468b 100644
--- a/drivers/thermal/thermal-generic-adc.c
+++ b/drivers/thermal/thermal-generic-adc.c
@@ -86,14 +86,16 @@ static int gadc_thermal_read_raw(struct iio_dev *indio_dev,
 				 int *val, int *val2, long mask)
 {
 	struct gadc_thermal_info *gtinfo = iio_priv(indio_dev);
+	int iio_val;
 	int ret;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_PROCESSED:
-		ret = gadc_thermal_get_temp(gtinfo->tz_dev, val);
-		if (ret)
+		ret = iio_read_channel_processed(gtinfo->channel, &iio_val);
+		if (ret < 0)
 			return ret;
 
+		*val = gadc_thermal_adc_to_temp(gtinfo, iio_val);
 		return IIO_VAL_INT;
 
 	default:
@@ -197,14 +199,14 @@ static int gadc_thermal_probe(struct platform_device *pdev)
 						    &gadc_thermal_ops);
 	if (IS_ERR(gti->tz_dev)) {
 		ret = PTR_ERR(gti->tz_dev);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev,
-				"Thermal zone sensor register failed: %d\n",
-				ret);
-		return ret;
-	}
+		if (ret == -EPROBE_DEFER)
+			return ret;
 
-	devm_thermal_add_hwmon_sysfs(dev, gti->tz_dev);
+		dev_info(dev, "Thermal zone sensor register failed: %d\n",
+			 ret);
+	} else {
+		devm_thermal_add_hwmon_sysfs(dev, gti->tz_dev);
+	}
 
 	return gadc_iio_register(&pdev->dev, gti);
 }

-- 
2.53.0

