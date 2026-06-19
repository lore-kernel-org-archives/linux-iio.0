Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19435386C1E
	for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 15:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781884548; cv=none; b=f5TbfqICfcKGuczQIidSH4X9mNVe25S5XtjS4dDKuqfWQO6O04msXivX5DKCJDwnt3CJksKhc9PHYVRdcHUXNHIwWK6gTK53fgAqclUjm4X19/Qv7YZhCHUKKiFfeTJ2VcfBS3f3YBC/HcBVbcGOxmTAE4hxwGpnf73JmQqQ6kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781884548; c=relaxed/simple;
	bh=hyIaGEtXgM+7P6xi8gCb0dFwedKi2IdfFj6KUImdblw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RFop0grupsxwPo9kcQKxNZXS+MQpYCBMOqvMn0nxRB9PjSbCJVRnuCmvg6kQSk4Z+rBNgQcfZkC0VXRpyiGCftSGaWpepgEmjQnBfS30Eu/7JEWtbhUMo29CfYe75C6QuKXrYtlnPNugAUja2WUdb4wXSiik0L8J0otNlrC7pEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=N5GfJP7v; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="N5GfJP7v"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-463b2f6fc9dso2312062f8f.2
        for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 08:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781884534; x=1782489334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DKi2/yGAwPwQAoVL3bJbtIeYC0ie7APGZSmUdZ2OEgE=;
        b=N5GfJP7vcheZUB60OSC+X72GBoppbaVjBaMYBjuX0z683W+BmlzclyqiNiHjKI6/ov
         TfbKBC+5U47NIiYlgZ36EeumH5FN09aO2Qx7/HYd11p6znKH/vAqt+sVY8mbE4SQB2JO
         /Wmb6LjsbdbDJgV07qn7DYpJWXCBe4NpC3gClVR0Dw4DavXsJwnESuFcExxsLE1OULS9
         gKFc8PV0W7t2O/QnpB1c0WXwUA9FqnRt+bDg37WwwmELlntmjFbVxTHMKGwIo1fXoqco
         yblew1kAU7/pc2yzxAeOa8NvoR2MCgkijuKfwWBhe0iSK2CjdMMo6mhucxq01R8/eByW
         ER7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781884534; x=1782489334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DKi2/yGAwPwQAoVL3bJbtIeYC0ie7APGZSmUdZ2OEgE=;
        b=ft6jjnthrtUqZKRk2IWOHfknoa1Fd34ANVpV3ISStQA0+0JJk6+V+Hv5Ke5tY1DLHO
         Pqm5deZp4sHBv0ZkDWIBBjvUFI3ZjJzqcur5MFwTLW7K76HOmenoPXAprwbr5EXnvbPL
         5nkrStscrI6DXS7Uud2GoaOwKswYjqF1pLV0Bn2tcwQQSZT64NdE8pSI5s9O/MrqtfTB
         mF5MfxWoZtMV64hIJ+fSqafOIj/0X7IsCuLk4n15bDRAoSHmS/c9aagmgSDc44zdYoGS
         u8shdFekVkuKhwDwMtvB8HUZ3s6R8ijzQxJzpaJj0G0PGuOiV+XZ56EsycnWzw/TCdsj
         iISQ==
X-Forwarded-Encrypted: i=1; AFNElJ9/PSFHIv09xTryJUWxBmZLkvVDB9XCn0RUOzrQhA1zkxX0grt4grZDCZ9F/yey5l8+9FcKirJUd6I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyucRk3OJKidEZ8k18I0JIMNR8JxBpGLWaWnItkGNtkE5no0Z8x
	2fD+PST/ftvlAfOUItBrtMnZMbVhrMPXt0vCRBmcwV33s/VEClvXjnVptsFCcRKuc14=
X-Gm-Gg: AfdE7cl34/qMQ/aM8q8uF571JFV+BYZwKhOcHGy/OxvkOd/hlBjunzpB4ownGLwjG6q
	g8ov/n1atssD9mu3GpeMsPxDHA2xepD3xl4xrSP+KppsGGm+vgGFmMeAODfFU+XBwTIL8buLlGB
	WjhWSwBaOZzUc7+emtKjWcUcrMuT9YInfHlEAf8J9FZWB9e8DvyQU2d21EbxJofhprA8+MqME7a
	llNX2yXPY0Fq4cJXlrKrKDJEalQYn6DrGEDz97EgyCnDgIczo98JDsfxH3UpFNxEapUrbyv3AOu
	U5Gbi+mloOjd18YHo48EYBuWky+rvA6zSJZnH9AmXfBkrmRWDzzg7mkvmh5LxEl5GcNEzHQWp+t
	iCrLoceAdRfu5qxegh/D36qjkhOz1NPNm6maOTA39RzLqGXk4sNB4Dvx8L7f/O06v2Cb5fblRJP
	BJyRuu420A46dqPxKp50ybntqZ6X4G6xK8IiAAQJPXkzYmVkM+GRbc8IoctfGjYFaPSpyKWvWrk
	4I=
X-Received: by 2002:a5d:448a:0:b0:461:a15f:700a with SMTP id ffacd0b85a97d-465069501b1mr6350673f8f.9.1781884534160;
        Fri, 19 Jun 2026 08:55:34 -0700 (PDT)
Received: from localhost (p200300f65f47db04359fc0e70763236f.dip0.t-ipconnect.de. [2003:f6:5f47:db04:359f:c0e7:763:236f])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-466667882f7sm2430f8f.21.2026.06.19.08.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 08:55:32 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Petre Rodan <petre.rodan@subdimension.ro>,
	Dan Robertson <dan@dlrobertson.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Rui Miguel Silva <rmfrfs@gmail.com>,
	Dragos Bogdan <dragos.bogdan@analog.com>,
	Dixit Parmar <dixitparmar19@gmail.com>,
	chuguangqing <chuguangqing@inspur.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Andrew Davis <afd@ti.com>,
	linux-iio@vger.kernel.org,
	linux@analog.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 10/13] iio: Drop unused assignment of spi_device_id driver data
Date: Fri, 19 Jun 2026 17:54:38 +0200
Message-ID:  <e3252cfede27ded7aaf0413edfeb7600df5f331f.1781883685.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1781883685.git.u.kleine-koenig@baylibre.com>
References: <cover.1781883685.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=18095; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=hyIaGEtXgM+7P6xi8gCb0dFwedKi2IdfFj6KUImdblw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqNWZO0r4WUl5LuePOe8KpDgV80MfLF1DXpLOD1 h/NWTNlAd6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCajVmTgAKCRCPgPtYfRL+ TiWVB/9D//vwPSNzOHfo0rvHfQJG4qI9aabJ05qyi0Odtqsr4rlUMNrHLM7SOYmN8BQ2/rmnrnP JzHeaMoESm1SQQub7kRlpuSy5NRKEBBTghnJBCI8r7uFCvSQgXscefV7q4dFIgPExxynscOoWHW 7SUaxQn38/di/6M6kaZn3cQW0dUd0RQIpNt5Of3WYWc57akKJwzFYU3Z6aYYI+H+AyhBlwVS/Fp jO5Zpg1uUkmKqPvkXJc8B4w2GYhZFH8Y4jUSVATRehiAfZQhYb9ipz6eeUIJuEOzeLq3+cCZTDR r5xi1tJKMSadMcGTAt9Ox22xMPHc0i+4x6fOFwHIPeXaboVh
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The drivers explicitly set the .driver_data member of struct
spi_device_id to zero without relying on that value. Drop these unused
assignments.

While touching these arrays unify spacing and use named initializers for
.name.

This patch doesn't modify the compiled arrays, only their representation
in source form benefits. The former was confirmed with x86 and arm64
builds.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/iio/accel/adxl367_spi.c            | 2 +-
 drivers/iio/accel/bma220_spi.c             | 2 +-
 drivers/iio/accel/bma400_spi.c             | 2 +-
 drivers/iio/accel/kxsd9-spi.c              | 2 +-
 drivers/iio/accel/mma7455_spi.c            | 4 ++--
 drivers/iio/adc/ad7266.c                   | 4 ++--
 drivers/iio/adc/ad7280a.c                  | 2 +-
 drivers/iio/adc/ad7292.c                   | 2 +-
 drivers/iio/adc/ad7298.c                   | 2 +-
 drivers/iio/adc/ade9000.c                  | 2 +-
 drivers/iio/adc/hi8435.c                   | 2 +-
 drivers/iio/adc/ti-adc084s021.c            | 2 +-
 drivers/iio/adc/ti-adc108s102.c            | 2 +-
 drivers/iio/amplifiers/ada4250.c           | 2 +-
 drivers/iio/chemical/bme680_spi.c          | 2 +-
 drivers/iio/dac/ad5758.c                   | 2 +-
 drivers/iio/dac/ad5770r.c                  | 2 +-
 drivers/iio/dac/ad7293.c                   | 2 +-
 drivers/iio/dac/ad7303.c                   | 2 +-
 drivers/iio/filter/admv8818.c              | 2 +-
 drivers/iio/frequency/admv1013.c           | 2 +-
 drivers/iio/frequency/admv1014.c           | 2 +-
 drivers/iio/frequency/adrf6780.c           | 2 +-
 drivers/iio/gyro/bmg160_spi.c              | 7 +++----
 drivers/iio/gyro/fxas21002c_spi.c          | 2 +-
 drivers/iio/health/afe4403.c               | 2 +-
 drivers/iio/imu/adis16460.c                | 2 +-
 drivers/iio/imu/bmi160/bmi160_spi.c        | 4 ++--
 drivers/iio/imu/fxos8700_spi.c             | 2 +-
 drivers/iio/magnetometer/bmc150_magn_spi.c | 6 +++---
 drivers/iio/pressure/mpl115_spi.c          | 2 +-
 drivers/iio/pressure/zpa2326_spi.c         | 2 +-
 drivers/iio/proximity/as3935.c             | 2 +-
 drivers/iio/temperature/max31856.c         | 2 +-
 drivers/iio/temperature/max31865.c         | 2 +-
 35 files changed, 42 insertions(+), 43 deletions(-)

diff --git a/drivers/iio/accel/adxl367_spi.c b/drivers/iio/accel/adxl367_spi.c
index 3fed56bb9054..e3ac44e68326 100644
--- a/drivers/iio/accel/adxl367_spi.c
+++ b/drivers/iio/accel/adxl367_spi.c
@@ -138,7 +138,7 @@ static int adxl367_spi_probe(struct spi_device *spi)
 }
 
 static const struct spi_device_id adxl367_spi_id[] = {
-	{ "adxl367", 0 },
+	{ .name = "adxl367" },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, adxl367_spi_id);
diff --git a/drivers/iio/accel/bma220_spi.c b/drivers/iio/accel/bma220_spi.c
index 383ee8a135ee..84a43842841c 100644
--- a/drivers/iio/accel/bma220_spi.c
+++ b/drivers/iio/accel/bma220_spi.c
@@ -26,7 +26,7 @@ static int bma220_spi_probe(struct spi_device *spi)
 }
 
 static const struct spi_device_id bma220_spi_id[] = {
-	{ "bma220", 0 },
+	{ .name = "bma220" },
 	{ }
 };
 
diff --git a/drivers/iio/accel/bma400_spi.c b/drivers/iio/accel/bma400_spi.c
index d386f643515b..14815086fa42 100644
--- a/drivers/iio/accel/bma400_spi.c
+++ b/drivers/iio/accel/bma400_spi.c
@@ -88,7 +88,7 @@ static int bma400_spi_probe(struct spi_device *spi)
 }
 
 static const struct spi_device_id bma400_spi_ids[] = {
-	{ "bma400", 0 },
+	{ .name = "bma400" },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, bma400_spi_ids);
diff --git a/drivers/iio/accel/kxsd9-spi.c b/drivers/iio/accel/kxsd9-spi.c
index cbb6c6412665..45257fbdbf8e 100644
--- a/drivers/iio/accel/kxsd9-spi.c
+++ b/drivers/iio/accel/kxsd9-spi.c
@@ -37,7 +37,7 @@ static void kxsd9_spi_remove(struct spi_device *spi)
 }
 
 static const struct spi_device_id kxsd9_spi_id[] = {
-	{"kxsd9", 0},
+	{ .name = "kxsd9" },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, kxsd9_spi_id);
diff --git a/drivers/iio/accel/mma7455_spi.c b/drivers/iio/accel/mma7455_spi.c
index aca02e83f789..872c47acf882 100644
--- a/drivers/iio/accel/mma7455_spi.c
+++ b/drivers/iio/accel/mma7455_spi.c
@@ -28,8 +28,8 @@ static void mma7455_spi_remove(struct spi_device *spi)
 }
 
 static const struct spi_device_id mma7455_spi_ids[] = {
-	{ "mma7455", 0 },
-	{ "mma7456", 0 },
+	{ .name = "mma7455" },
+	{ .name = "mma7456" },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, mma7455_spi_ids);
diff --git a/drivers/iio/adc/ad7266.c b/drivers/iio/adc/ad7266.c
index 0ef36c249ab8..594a070c3745 100644
--- a/drivers/iio/adc/ad7266.c
+++ b/drivers/iio/adc/ad7266.c
@@ -453,8 +453,8 @@ static int ad7266_probe(struct spi_device *spi)
 }
 
 static const struct spi_device_id ad7266_id[] = {
-	{ "ad7265", 0 },
-	{ "ad7266", 0 },
+	{ .name = "ad7265" },
+	{ .name = "ad7266" },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad7266_id);
diff --git a/drivers/iio/adc/ad7280a.c b/drivers/iio/adc/ad7280a.c
index 01c2f55a680c..442e5f54d472 100644
--- a/drivers/iio/adc/ad7280a.c
+++ b/drivers/iio/adc/ad7280a.c
@@ -1083,7 +1083,7 @@ static int ad7280_probe(struct spi_device *spi)
 }
 
 static const struct spi_device_id ad7280_id[] = {
-	{ "ad7280a", 0 },
+	{ .name = "ad7280a" },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad7280_id);
diff --git a/drivers/iio/adc/ad7292.c b/drivers/iio/adc/ad7292.c
index e5ad83d2240a..0334f2b94aa4 100644
--- a/drivers/iio/adc/ad7292.c
+++ b/drivers/iio/adc/ad7292.c
@@ -300,7 +300,7 @@ static int ad7292_probe(struct spi_device *spi)
 }
 
 static const struct spi_device_id ad7292_id_table[] = {
-	{ "ad7292", 0 },
+	{ .name = "ad7292" },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad7292_id_table);
diff --git a/drivers/iio/adc/ad7298.c b/drivers/iio/adc/ad7298.c
index 7c0538ea15c8..27d406461144 100644
--- a/drivers/iio/adc/ad7298.c
+++ b/drivers/iio/adc/ad7298.c
@@ -354,7 +354,7 @@ static const struct acpi_device_id ad7298_acpi_ids[] = {
 MODULE_DEVICE_TABLE(acpi, ad7298_acpi_ids);
 
 static const struct spi_device_id ad7298_id[] = {
-	{ "ad7298", 0 },
+	{ .name = "ad7298" },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad7298_id);
diff --git a/drivers/iio/adc/ade9000.c b/drivers/iio/adc/ade9000.c
index c0a9babfa519..b80cdd8ad982 100644
--- a/drivers/iio/adc/ade9000.c
+++ b/drivers/iio/adc/ade9000.c
@@ -1768,7 +1768,7 @@ static int ade9000_probe(struct spi_device *spi)
 };
 
 static const struct spi_device_id ade9000_id[] = {
-	{ "ade9000", 0 },
+	{ .name = "ade9000" },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, ade9000_id);
diff --git a/drivers/iio/adc/hi8435.c b/drivers/iio/adc/hi8435.c
index 86c10ea7ded4..5b14ecec8006 100644
--- a/drivers/iio/adc/hi8435.c
+++ b/drivers/iio/adc/hi8435.c
@@ -527,7 +527,7 @@ static const struct of_device_id hi8435_dt_ids[] = {
 MODULE_DEVICE_TABLE(of, hi8435_dt_ids);
 
 static const struct spi_device_id hi8435_id[] = {
-	{ "hi8435", 0 },
+	{ .name = "hi8435" },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, hi8435_id);
diff --git a/drivers/iio/adc/ti-adc084s021.c b/drivers/iio/adc/ti-adc084s021.c
index a100f770fa1c..a4f82a629998 100644
--- a/drivers/iio/adc/ti-adc084s021.c
+++ b/drivers/iio/adc/ti-adc084s021.c
@@ -244,7 +244,7 @@ static const struct of_device_id adc084s021_of_match[] = {
 MODULE_DEVICE_TABLE(of, adc084s021_of_match);
 
 static const struct spi_device_id adc084s021_id[] = {
-	{ ADC084S021_DRIVER_NAME, 0 },
+	{ .name = ADC084S021_DRIVER_NAME },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, adc084s021_id);
diff --git a/drivers/iio/adc/ti-adc108s102.c b/drivers/iio/adc/ti-adc108s102.c
index 7d615e2bbf39..81e25458ca6a 100644
--- a/drivers/iio/adc/ti-adc108s102.c
+++ b/drivers/iio/adc/ti-adc108s102.c
@@ -277,7 +277,7 @@ static const struct acpi_device_id adc108s102_acpi_ids[] = {
 MODULE_DEVICE_TABLE(acpi, adc108s102_acpi_ids);
 
 static const struct spi_device_id adc108s102_id[] = {
-	{ "adc108s102", 0 },
+	{ .name = "adc108s102" },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, adc108s102_id);
diff --git a/drivers/iio/amplifiers/ada4250.c b/drivers/iio/amplifiers/ada4250.c
index 71e361af2074..9702de3a5074 100644
--- a/drivers/iio/amplifiers/ada4250.c
+++ b/drivers/iio/amplifiers/ada4250.c
@@ -358,7 +358,7 @@ static int ada4250_probe(struct spi_device *spi)
 }
 
 static const struct spi_device_id ada4250_id[] = {
-	{ "ada4250", 0 },
+	{ .name = "ada4250" },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, ada4250_id);
diff --git a/drivers/iio/chemical/bme680_spi.c b/drivers/iio/chemical/bme680_spi.c
index aa97645ba539..5fbabcb1d4b3 100644
--- a/drivers/iio/chemical/bme680_spi.c
+++ b/drivers/iio/chemical/bme680_spi.c
@@ -131,7 +131,7 @@ static int bme680_spi_probe(struct spi_device *spi)
 }
 
 static const struct spi_device_id bme680_spi_id[] = {
-	{"bme680", 0},
+	{ .name = "bme680" },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, bme680_spi_id);
diff --git a/drivers/iio/dac/ad5758.c b/drivers/iio/dac/ad5758.c
index 8e6fb46cce4d..632b60a8ed26 100644
--- a/drivers/iio/dac/ad5758.c
+++ b/drivers/iio/dac/ad5758.c
@@ -879,7 +879,7 @@ static int ad5758_probe(struct spi_device *spi)
 }
 
 static const struct spi_device_id ad5758_id[] = {
-	{ "ad5758", 0 },
+	{ .name = "ad5758" },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad5758_id);
diff --git a/drivers/iio/dac/ad5770r.c b/drivers/iio/dac/ad5770r.c
index 6027e8d88b27..bdc48e57013f 100644
--- a/drivers/iio/dac/ad5770r.c
+++ b/drivers/iio/dac/ad5770r.c
@@ -642,7 +642,7 @@ static const struct of_device_id ad5770r_of_id[] = {
 MODULE_DEVICE_TABLE(of, ad5770r_of_id);
 
 static const struct spi_device_id ad5770r_id[] = {
-	{ "ad5770r", 0 },
+	{ .name = "ad5770r" },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad5770r_id);
diff --git a/drivers/iio/dac/ad7293.c b/drivers/iio/dac/ad7293.c
index df6f126abf05..caa5f45859b6 100644
--- a/drivers/iio/dac/ad7293.c
+++ b/drivers/iio/dac/ad7293.c
@@ -870,7 +870,7 @@ static int ad7293_probe(struct spi_device *spi)
 }
 
 static const struct spi_device_id ad7293_id[] = {
-	{ "ad7293", 0 },
+	{ .name = "ad7293" },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad7293_id);
diff --git a/drivers/iio/dac/ad7303.c b/drivers/iio/dac/ad7303.c
index 1c2960fa9743..e9c1cafad478 100644
--- a/drivers/iio/dac/ad7303.c
+++ b/drivers/iio/dac/ad7303.c
@@ -271,7 +271,7 @@ static const struct of_device_id ad7303_spi_of_match[] = {
 MODULE_DEVICE_TABLE(of, ad7303_spi_of_match);
 
 static const struct spi_device_id ad7303_spi_ids[] = {
-	{ "ad7303", 0 },
+	{ .name = "ad7303" },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad7303_spi_ids);
diff --git a/drivers/iio/filter/admv8818.c b/drivers/iio/filter/admv8818.c
index a4984b867248..c188243269d4 100644
--- a/drivers/iio/filter/admv8818.c
+++ b/drivers/iio/filter/admv8818.c
@@ -790,7 +790,7 @@ static int admv8818_probe(struct spi_device *spi)
 }
 
 static const struct spi_device_id admv8818_id[] = {
-	{ "admv8818", 0 },
+	{ .name = "admv8818" },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, admv8818_id);
diff --git a/drivers/iio/frequency/admv1013.c b/drivers/iio/frequency/admv1013.c
index b852378b3f68..ba843324a678 100644
--- a/drivers/iio/frequency/admv1013.c
+++ b/drivers/iio/frequency/admv1013.c
@@ -620,7 +620,7 @@ static int admv1013_probe(struct spi_device *spi)
 }
 
 static const struct spi_device_id admv1013_id[] = {
-	{ "admv1013", 0 },
+	{ .name = "admv1013" },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, admv1013_id);
diff --git a/drivers/iio/frequency/admv1014.c b/drivers/iio/frequency/admv1014.c
index 25e8cd8135ad..f4ddc5b3f481 100644
--- a/drivers/iio/frequency/admv1014.c
+++ b/drivers/iio/frequency/admv1014.c
@@ -782,7 +782,7 @@ static int admv1014_probe(struct spi_device *spi)
 }
 
 static const struct spi_device_id admv1014_id[] = {
-	{ "admv1014", 0 },
+	{ .name = "admv1014" },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, admv1014_id);
diff --git a/drivers/iio/frequency/adrf6780.c b/drivers/iio/frequency/adrf6780.c
index 9911b5273b22..baf6f9f1faa3 100644
--- a/drivers/iio/frequency/adrf6780.c
+++ b/drivers/iio/frequency/adrf6780.c
@@ -487,7 +487,7 @@ static int adrf6780_probe(struct spi_device *spi)
 }
 
 static const struct spi_device_id adrf6780_id[] = {
-	{ "adrf6780", 0 },
+	{ .name = "adrf6780" },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, adrf6780_id);
diff --git a/drivers/iio/gyro/bmg160_spi.c b/drivers/iio/gyro/bmg160_spi.c
index 6aecc5eb8347..14ae1d03be3d 100644
--- a/drivers/iio/gyro/bmg160_spi.c
+++ b/drivers/iio/gyro/bmg160_spi.c
@@ -33,12 +33,11 @@ static void bmg160_spi_remove(struct spi_device *spi)
 }
 
 static const struct spi_device_id bmg160_spi_id[] = {
-	{"bmg160", 0},
-	{"bmi055_gyro", 0},
-	{"bmi088_gyro", 0},
+	{ .name = "bmg160" },
+	{ .name = "bmi055_gyro" },
+	{ .name = "bmi088_gyro" },
 	{ }
 };
-
 MODULE_DEVICE_TABLE(spi, bmg160_spi_id);
 
 static const struct of_device_id bmg160_of_match[] = {
diff --git a/drivers/iio/gyro/fxas21002c_spi.c b/drivers/iio/gyro/fxas21002c_spi.c
index d62efe50b697..000528d319a8 100644
--- a/drivers/iio/gyro/fxas21002c_spi.c
+++ b/drivers/iio/gyro/fxas21002c_spi.c
@@ -40,7 +40,7 @@ static void fxas21002c_spi_remove(struct spi_device *spi)
 }
 
 static const struct spi_device_id fxas21002c_spi_id[] = {
-	{ "fxas21002c", 0 },
+	{ .name = "fxas21002c" },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, fxas21002c_spi_id);
diff --git a/drivers/iio/health/afe4403.c b/drivers/iio/health/afe4403.c
index d358f4d5e5da..27e32707f089 100644
--- a/drivers/iio/health/afe4403.c
+++ b/drivers/iio/health/afe4403.c
@@ -568,7 +568,7 @@ static int afe4403_probe(struct spi_device *spi)
 }
 
 static const struct spi_device_id afe4403_ids[] = {
-	{ "afe4403", 0 },
+	{ .name = "afe4403" },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, afe4403_ids);
diff --git a/drivers/iio/imu/adis16460.c b/drivers/iio/imu/adis16460.c
index ba1887d36577..cadf21c05bbf 100644
--- a/drivers/iio/imu/adis16460.c
+++ b/drivers/iio/imu/adis16460.c
@@ -394,7 +394,7 @@ static int adis16460_probe(struct spi_device *spi)
 }
 
 static const struct spi_device_id adis16460_ids[] = {
-	{ "adis16460", 0 },
+	{ .name = "adis16460" },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, adis16460_ids);
diff --git a/drivers/iio/imu/bmi160/bmi160_spi.c b/drivers/iio/imu/bmi160/bmi160_spi.c
index 3581bd788483..42ad6fcdd1c2 100644
--- a/drivers/iio/imu/bmi160/bmi160_spi.c
+++ b/drivers/iio/imu/bmi160/bmi160_spi.c
@@ -35,8 +35,8 @@ static int bmi160_spi_probe(struct spi_device *spi)
 }
 
 static const struct spi_device_id bmi160_spi_id[] = {
-	{"bmi120", 0},
-	{"bmi160", 0},
+	{ .name = "bmi120" },
+	{ .name = "bmi160" },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, bmi160_spi_id);
diff --git a/drivers/iio/imu/fxos8700_spi.c b/drivers/iio/imu/fxos8700_spi.c
index 6b0dc7a776b9..c85af547da49 100644
--- a/drivers/iio/imu/fxos8700_spi.c
+++ b/drivers/iio/imu/fxos8700_spi.c
@@ -24,7 +24,7 @@ static int fxos8700_spi_probe(struct spi_device *spi)
 }
 
 static const struct spi_device_id fxos8700_spi_id[] = {
-	{"fxos8700", 0},
+	{ .name = "fxos8700" },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, fxos8700_spi_id);
diff --git a/drivers/iio/magnetometer/bmc150_magn_spi.c b/drivers/iio/magnetometer/bmc150_magn_spi.c
index 896b1d280731..37acaf9650ee 100644
--- a/drivers/iio/magnetometer/bmc150_magn_spi.c
+++ b/drivers/iio/magnetometer/bmc150_magn_spi.c
@@ -34,9 +34,9 @@ static void bmc150_magn_spi_remove(struct spi_device *spi)
 }
 
 static const struct spi_device_id bmc150_magn_spi_id[] = {
-	{"bmc150_magn", 0},
-	{"bmc156_magn", 0},
-	{"bmm150_magn", 0},
+	{ .name = "bmc150_magn" },
+	{ .name = "bmc156_magn" },
+	{ .name = "bmm150_magn" },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, bmc150_magn_spi_id);
diff --git a/drivers/iio/pressure/mpl115_spi.c b/drivers/iio/pressure/mpl115_spi.c
index 4e1d24beff94..3cff616e8d2f 100644
--- a/drivers/iio/pressure/mpl115_spi.c
+++ b/drivers/iio/pressure/mpl115_spi.c
@@ -84,7 +84,7 @@ static int mpl115_spi_probe(struct spi_device *spi)
 }
 
 static const struct spi_device_id mpl115_spi_ids[] = {
-	{ "mpl115", 0 },
+	{ .name = "mpl115" },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, mpl115_spi_ids);
diff --git a/drivers/iio/pressure/zpa2326_spi.c b/drivers/iio/pressure/zpa2326_spi.c
index af756e2b0f31..5dd0fa87c67d 100644
--- a/drivers/iio/pressure/zpa2326_spi.c
+++ b/drivers/iio/pressure/zpa2326_spi.c
@@ -61,7 +61,7 @@ static void zpa2326_remove_spi(struct spi_device *spi)
 }
 
 static const struct spi_device_id zpa2326_spi_ids[] = {
-	{ "zpa2326", 0 },
+	{ .name = "zpa2326" },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, zpa2326_spi_ids);
diff --git a/drivers/iio/proximity/as3935.c b/drivers/iio/proximity/as3935.c
index f1018b14aecf..40392db09bf9 100644
--- a/drivers/iio/proximity/as3935.c
+++ b/drivers/iio/proximity/as3935.c
@@ -449,7 +449,7 @@ static const struct of_device_id as3935_of_match[] = {
 MODULE_DEVICE_TABLE(of, as3935_of_match);
 
 static const struct spi_device_id as3935_id[] = {
-	{"as3935", 0},
+	{ .name = "as3935" },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, as3935_id);
diff --git a/drivers/iio/temperature/max31856.c b/drivers/iio/temperature/max31856.c
index 7ddec5cbe558..af8f2f2fe5a6 100644
--- a/drivers/iio/temperature/max31856.c
+++ b/drivers/iio/temperature/max31856.c
@@ -462,7 +462,7 @@ static int max31856_probe(struct spi_device *spi)
 }
 
 static const struct spi_device_id max31856_id[] = {
-	{ "max31856", 0 },
+	{ .name = "max31856" },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, max31856_id);
diff --git a/drivers/iio/temperature/max31865.c b/drivers/iio/temperature/max31865.c
index 5a6fbe3c80e5..aeb3375906a6 100644
--- a/drivers/iio/temperature/max31865.c
+++ b/drivers/iio/temperature/max31865.c
@@ -325,7 +325,7 @@ static int max31865_probe(struct spi_device *spi)
 }
 
 static const struct spi_device_id max31865_id[] = {
-	{ "max31865", 0 },
+	{ .name = "max31865" },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, max31865_id);
-- 
2.47.3

