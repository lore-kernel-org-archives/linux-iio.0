Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCA9388E7D
	for <linux-iio@vger.kernel.org>; Tue, 16 Jun 2026 11:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781610392; cv=none; b=ID0YluE17LXKMhnyM3E0dGJWLdqmQ53etEeraDt6qKsq8v3K2HVFD3oTGAtqXga9u0obZix/f+SR6yRi/V9796XOeKr8p5I5B+/WLvMrkcnI0GI4PIF1Vg2TtRFMYAk8XyubdmppeuwzclL/nKgFvqHLcJ1e4l0HpkjtfAEaHL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781610392; c=relaxed/simple;
	bh=B/5zCf5qxtCKHH0leXzgYelc7fOtETg9twMXugSJIls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aE7M2zvdOYnVAUN14vAuzKoHhjoQ5kAsJTH3EcfVUdmPN0GLthjMJiDGsBdKXLSYAqDu5MlkQbPsARyFnritGU8s62YmE2X74szyxPPg2lzZOaYt8Tq2ScpagyBu9cO2quuks/CmW9EcbhXbSvn2KvZyOyllRIEfIuz4XZYPl8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jGPK3j/A; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jGPK3j/A"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2c0c379e8ffso30069585ad.3
        for <linux-iio@vger.kernel.org>; Tue, 16 Jun 2026 04:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781610390; x=1782215190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2SZwmLoyOVnXN8nI4Eki4lO2D5PAd8xlSte9gW+ZCNM=;
        b=jGPK3j/Aj30BhTVuaxTrTTwZUJU39KooiyunH+RgGxNNqFxwWBrfKi4DbEPawPmEgW
         YDzDMj+4Bhgd7KP/fwXhn7pfq9p9BJoYV46h3hNBEaEqvepC6mCNBlBw0AsJ3o3Et4Ss
         E/+sI6ov07/Umbb8HEjKWFKxKHXrRukASJy+o/Y/X4jE5doYDHAswyx5fZ0s98rLGK2u
         +qYv+GuGEywDnR1rssX2cN1svp0AUbXV9s4J1KQG3e2u6h7VtNkWVG8IELfcTtXysWiX
         LmmdQA0hxygCwebjlC2DQEktcpliNfkA9AFtTMJ5ckuQURkjjQMrIvWVCx2/EbSIFnIz
         WLSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781610390; x=1782215190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2SZwmLoyOVnXN8nI4Eki4lO2D5PAd8xlSte9gW+ZCNM=;
        b=Yj0Wo+XSDq56Ygdm4cdKd9m9zT6KGiFMTBxYgLlua9qMKmMyIg5gJ+jGRj+AJocbih
         sB5rSMATTA3fqskbMfUAR8Okojg9uNTzMOSjfznI9tkIZ7macXB7Hm10RlQudhXrO9o6
         jMyzPiHY9SHd4YPxxf/a7it/R7eOCjt7d7OOg8A9yDuTQ26zFmR0J5axls2LBgp/WXqt
         1DmGE8mqHq/XjBr6fJIb5cqAzpV073B3WfrpNarqgFNwfOx6/oNLthIxzAV80V4ubGVp
         a1R7rnSPOsc4BdDifc2ALeY5WIsuZLFhSlC6zHmAu/FKVV2HODLLbxKYNCieo5L1FhcN
         dBbw==
X-Gm-Message-State: AOJu0YwoJ5fMr0C2WnZ/X50cHFbEWr0LIhH7l0QupC3iK6GI2oMacRuo
	e/zSUZpChhvfccm/zcHjzTBCNYqd/5VYfOJOZc0GGDiEWuzfg0Q1HTqKRMOBtCnV
X-Gm-Gg: Acq92OEbr5GKPPt7AZYL4SUb89r2LRRs0/7/1w4bJZB/+mVZ1QGqWAN1bOiCP35ivih
	2MUFjJJkzl7xIeBCVp5LTyqqSD9rBCtORrYt42z+CBdk4yEeGz5E7jIS31+P1+qgit8aa6REIdl
	6rE+Tw+1haYzLncqg4WXvO8rKkrQVvTyo2Ry0SdArGOaOrFuEahL8X134Mayeof51yV1nidnyIt
	HI2Sd0WHjfmkyc6hT1CK272zcFQnzMUm4/up51qKsU+kiokVy93Pcfp4MlFHFEtI8IyvBQTSc5x
	/bniK86LHZaW48mVSnm+qcrCO/D9mVAPLe4T2OB3VQMw9/+gvenNKeH8PhyHRWuxWRUy5j8ons2
	PaaRl6HGb2yziHCqAWURj4oA/U/K8OWS5J0FUX1jnkLsrDazNBoS6NAOzcVSqkTufoBeSTu+f0e
	xTwN7AZzq+8gjevjv+U6bYLW/aJCnFjGtXqwIJZ7G6NKSI
X-Received: by 2002:a17:903:40ce:b0:2b2:57f3:8d07 with SMTP id d9443c01a7336-2c664148d86mr162923495ad.7.1781610390142;
        Tue, 16 Jun 2026 04:46:30 -0700 (PDT)
Received: from yash-Bravo-15-B5DD.local ([14.99.167.142])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c42fbb50bfsm131128635ad.33.2026.06.16.04.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 04:46:29 -0700 (PDT)
From: Yash Suthar <yashsuthar983@gmail.com>
To: linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	andriy.shevchenko@intel.com,
	salah.triki@gmail.com,
	sakari.ailus@linux.intel.com,
	Achim.Gratz@Stromeko.DE,
	Yash Suthar <yashsuthar983@gmail.com>
Subject: [PATCH v2] iio: pressure: bmp280: return on runtime PM resume failure
Date: Tue, 16 Jun 2026 17:16:21 +0530
Message-ID: <20260616114621.16480-1-yashsuthar983@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616093126.66312-1-yashsuthar983@gmail.com>
References: <20260616093126.66312-1-yashsuthar983@gmail.com>
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
 drivers/iio/pressure/bmp280-core.c | 32 +++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index d983ce9c0b99..e2e22b1c7288 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -750,7 +750,10 @@ static int bmp280_read_raw(struct iio_dev *indio_dev,
 	struct bmp280_data *data = iio_priv(indio_dev);
 	int ret;
 
-	pm_runtime_get_sync(data->dev);
+	ret = pm_runtime_resume_and_get(data->dev);
+	if (ret < 0)
+		return ret;
+
 	ret = bmp280_read_raw_impl(indio_dev, chan, val, val2, mask);
 	pm_runtime_put_autosuspend(data->dev);
 
@@ -924,7 +927,10 @@ static int bmp280_write_raw(struct iio_dev *indio_dev,
 	struct bmp280_data *data = iio_priv(indio_dev);
 	int ret;
 
-	pm_runtime_get_sync(data->dev);
+	ret = pm_runtime_resume_and_get(data->dev);
+	if (ret < 0)
+		return ret;
+
 	ret = bmp280_write_raw_impl(indio_dev, chan, val, val2, mask);
 	pm_runtime_put_autosuspend(data->dev);
 
@@ -2254,7 +2260,10 @@ static int bmp580_nvmem_read(void *priv, unsigned int offset, void *val,
 	struct bmp280_data *data = priv;
 	int ret;
 
-	pm_runtime_get_sync(data->dev);
+	ret = pm_runtime_resume_and_get(data->dev);
+	if (ret < 0)
+		return ret;
+
 	ret = bmp580_nvmem_read_impl(priv, offset, val, bytes);
 	pm_runtime_put_autosuspend(data->dev);
 
@@ -2328,7 +2337,10 @@ static int bmp580_nvmem_write(void *priv, unsigned int offset, void *val,
 	struct bmp280_data *data = priv;
 	int ret;
 
-	pm_runtime_get_sync(data->dev);
+	ret = pm_runtime_resume_and_get(data->dev);
+	if (ret < 0)
+		return ret;
+
 	ret = bmp580_nvmem_write_impl(priv, offset, val, bytes);
 	pm_runtime_put_autosuspend(data->dev);
 
@@ -3108,11 +3120,17 @@ EXPORT_SYMBOL_NS(bmp085_chip_info, "IIO_BMP280");
 static int bmp280_buffer_preenable(struct iio_dev *indio_dev)
 {
 	struct bmp280_data *data = iio_priv(indio_dev);
+	int ret;
 
-	pm_runtime_get_sync(data->dev);
-	data->chip_info->set_mode(data, BMP280_NORMAL);
+	ret = pm_runtime_resume_and_get(data->dev);
+	if (ret < 0)
+		return ret;
 
-	return 0;
+	ret = data->chip_info->set_mode(data, BMP280_NORMAL);
+	if (ret)
+		pm_runtime_put_autosuspend(data->dev);
+
+	return ret;
 }
 
 static int bmp280_buffer_postdisable(struct iio_dev *indio_dev)
-- 
2.43.0

