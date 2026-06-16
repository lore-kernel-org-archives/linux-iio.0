Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF8E3B27D2
	for <linux-iio@vger.kernel.org>; Tue, 16 Jun 2026 09:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781602295; cv=none; b=DlJgZ0JR+PhMgcl/W1UwEYkhVoBo3uXL6lPDhimlPACtw7B/Znez1phHkul1RD8y8kd2HJW0dvhpzTth0oq5choRSgqUuqq7mjFQTW3Ci8DAYaYYuRbRuDHINFS1g5OaLdl5IAT/4rQCSOmxHlEUV+dUwq4T+pCq+G6LnLVXYZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781602295; c=relaxed/simple;
	bh=kbOvHmTSqYH6ZhDlkSyFUWaZQoEKHlkdbvzRjRUcDZE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z/bXmmMXrgVXhIFfiWQHEMZNdVby1OJ+6AbpwCu66NffjqexCRWQ2Md1OchBQkRjT+2iCM2oqzD3btHaMouQcrtOyCnirMKVGSf9m3ObHpJjxqoD51dZg6Yn9J6Rjb2kskUjSxGei8eEToeCBFuCMU0aKlJ/MJLBw4IG7j775As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PDXOVOfI; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PDXOVOfI"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-36b9ec98144so3455269a91.1
        for <linux-iio@vger.kernel.org>; Tue, 16 Jun 2026 02:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781602294; x=1782207094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Lv1kXIsdJamoce5XmOVqGJYZGtkdYhIqTWwqHQ6Y0qA=;
        b=PDXOVOfIrEwVjlYIcG7QpNGliJI4hYCrqxnG5jU2b/IQbbCHpQask2IiEVVh4pJzL6
         ZceTNOQGC+lAq5V5bhzqhmf/5tDu1VXMmH63NBv1O2+0Qyz7vC4U/Ji8MC5QXCMKYqj3
         tZ+tutT44soUjXhK51YkwNAaDvXWJqMx+9BfL3ekB7cmAlP6XtkHfU99KtVIahGD1rmk
         IHFUS4NLzUEj3J0A6G9DR/hc12LbVk+1vCBzuFEJmFDeNfwY6DYCYVi/ifJZVcKwPgBm
         uIzGYRE8qEQr4t/0kLVideGsI3R61Nk77FBtIb8mxCezDmDrsMVAFy6L3YzDhNIq3TbN
         6Z0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781602294; x=1782207094;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lv1kXIsdJamoce5XmOVqGJYZGtkdYhIqTWwqHQ6Y0qA=;
        b=CXLh0W0uZJ5HlCwPrrvYPwxK5NkNbV24h+jqgG1gL1FGdo8eOjnUJ295++OpjcGZyh
         oVkigAhYqEsc3RI7SD+JwUjquF867AfYdl1VTZdFCHCTuvdmAcAYMVgQB8Mw5hqx9/rp
         wPPDDOQRsa0L4WU6gaZFgjLk9X+7KxkSbsm3ZMQTQ0M1S5Ordbam/b0DkdW9YOHrMSZe
         L+qa9PaSVKI/EmwJdDuAEIrg6qjeJeEObEG7vg4TBUDo8hJZ4TFxgmZWVDJ0scLJ3abY
         V2/o9Dwr5jIEZV+h2KxlnUhik/9iI1Yc/d91gEsjROMrrmPK1cPPbEjFzavGS/+4Skgl
         cZRw==
X-Gm-Message-State: AOJu0Yyx5dqXOcA74z3ijsn66WsZ0JhHcZLAQeKiuhFhtjbby0rs5PXv
	Tg0EuHOdKzl6toccZw9TD0RcxYdU9HPgrcQeeCIO7mMGRzCpv/M+FnR3ejDnI1k2
X-Gm-Gg: Acq92OFLXamuxlQdtbiNWECWrj+CvUkTG3HR+4MJ1sozI/flkcQXAnwujl/J2OQvDN8
	0lJgRCfwyAKQXWq7ibZsxwUobuOeYtjQs4dJI4RTMYNqE1EFe5s4zc4RuT2B6MKoUaSu+PHogke
	WZNwYgArJ5DAyibfbcvsTjR6vF6KNzXbnHUa+pNn63ZfOOA/nuAAZzdAW/Hjrg+RwS3SflarXol
	037lXiWGyF7ZU8Cgjjj9EhqT8ZD02LYDqVftmEONx2GoARaUneGUbn9uxePXKLhSXGjcZgppxoT
	0eLDRn/MGa3R+d/GmjckyTEKcryS52npS14ZSmN/SlieRIMGpuDyzA3ZFJq13oQOLO4NqlB4uTD
	aJLNRA0ShYd2uaGygH7bXc7Ak2Z07rD+IZOgoajPz2I9p/zESMlf8DyNBcLCZgDT70+EpV+RfKw
	Suu1yAeZcTYNbXRuiFV93fbpRCrYBv06zhKTosa1K1xo+FZEQoXPbElT0=
X-Received: by 2002:a17:90b:5645:b0:36a:d6dd:9fee with SMTP id 98e67ed59e1d1-37c523bcd31mr3196860a91.12.1781602293941;
        Tue, 16 Jun 2026 02:31:33 -0700 (PDT)
Received: from yash-Bravo-15-B5DD.local ([14.99.167.142])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37c521ae78csm2280110a91.4.2026.06.16.02.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 02:31:33 -0700 (PDT)
From: Yash Suthar <yashsuthar983@gmail.com>
To: linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	salah.triki@gmail.com,
	sakari.ailus@linux.intel.com,
	Achim.Gratz@Stromeko.DE,
	yashsuthar983@gmail.com
Subject: [PATCH] iio: pressure: bmp280: return on runtime PM resume failure
Date: Tue, 16 Jun 2026 15:01:26 +0530
Message-ID: <20260616093126.66312-1-yashsuthar983@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace pm_runtime_get_sync() with pm_runtime_resume_and_get() and
propagate error.

Signed-off-by: Yash Suthar <yashsuthar983@gmail.com>
---
 drivers/iio/pressure/bmp280-core.c | 32 ++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index d983ce9c0b99..7f4b0976ff22 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -749,8 +749,10 @@ static int bmp280_read_raw(struct iio_dev *indio_dev,
 {
 	struct bmp280_data *data = iio_priv(indio_dev);
 	int ret;
+	ret = pm_runtime_resume_and_get(data->dev);
+	if (ret < 0)
+		return ret;
 
-	pm_runtime_get_sync(data->dev);
 	ret = bmp280_read_raw_impl(indio_dev, chan, val, val2, mask);
 	pm_runtime_put_autosuspend(data->dev);
 
@@ -923,8 +925,10 @@ static int bmp280_write_raw(struct iio_dev *indio_dev,
 {
 	struct bmp280_data *data = iio_priv(indio_dev);
 	int ret;
+	ret = pm_runtime_resume_and_get(data->dev);
+	if (ret < 0)
+		return ret;
 
-	pm_runtime_get_sync(data->dev);
 	ret = bmp280_write_raw_impl(indio_dev, chan, val, val2, mask);
 	pm_runtime_put_autosuspend(data->dev);
 
@@ -2253,8 +2257,10 @@ static int bmp580_nvmem_read(void *priv, unsigned int offset, void *val,
 {
 	struct bmp280_data *data = priv;
 	int ret;
+	ret = pm_runtime_resume_and_get(data->dev);
+	if (ret < 0)
+		return ret;
 
-	pm_runtime_get_sync(data->dev);
 	ret = bmp580_nvmem_read_impl(priv, offset, val, bytes);
 	pm_runtime_put_autosuspend(data->dev);
 
@@ -2327,8 +2333,10 @@ static int bmp580_nvmem_write(void *priv, unsigned int offset, void *val,
 {
 	struct bmp280_data *data = priv;
 	int ret;
+	ret = pm_runtime_resume_and_get(data->dev);
+	if (ret < 0)
+		return ret;
 
-	pm_runtime_get_sync(data->dev);
 	ret = bmp580_nvmem_write_impl(priv, offset, val, bytes);
 	pm_runtime_put_autosuspend(data->dev);
 
@@ -3108,9 +3116,17 @@ EXPORT_SYMBOL_NS(bmp085_chip_info, "IIO_BMP280");
 static int bmp280_buffer_preenable(struct iio_dev *indio_dev)
 {
 	struct bmp280_data *data = iio_priv(indio_dev);
+	int ret;
 
-	pm_runtime_get_sync(data->dev);
-	data->chip_info->set_mode(data, BMP280_NORMAL);
+	ret = pm_runtime_resume_and_get(data->dev);
+	if (ret < 0)
+		return ret;
+
+	ret = data->chip_info->set_mode(data, BMP280_NORMAL);
+	if (ret) {
+		pm_runtime_put_autosuspend(data->dev);
+		return ret;
+	}
 
 	return 0;
 }
@@ -3133,8 +3149,8 @@ static void bmp280_pm_disable(void *data)
 {
 	struct device *dev = data;
 
-	pm_runtime_get_sync(dev);
-	pm_runtime_put_noidle(dev);
+	if (pm_runtime_resume_and_get(dev) >= 0)
+		pm_runtime_put_noidle(dev);
 	pm_runtime_disable(dev);
 }
 
-- 
2.43.0

