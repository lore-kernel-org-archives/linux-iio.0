Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2137D39A04C
	for <linux-iio@vger.kernel.org>; Sat,  9 May 2026 14:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778336563; cv=none; b=Z8UwicMIFYrHCJORvKzMcWhLsnFQSHLkfJNJEHsuOszy82m+3SkSIjQ7KSAqo16dqmNTE0pbjm5KrgzsKV1JleCBxtb42UeKMq0c5TnsZe7U/P6aXLyS/voC+4TY0hLPAPOSqE9Irlg833DQ4Bk3nx3WRJrF8LgW/4M76A4TDAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778336563; c=relaxed/simple;
	bh=5041B97lUMY1NweE62U8zsBcR/adbKbv4T2M7YYYW6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UN2MH3bSxZ8A3z5rENrtqYlVCkgGLf1PKjovKpWJ58RefoGZf8Qqbfw+I25FyZPiPYXiovn9zWKB4F8SgpG9EKJLRwUwOU74aQnXNrv9TpEoH7RS5QqXN4d3J28LLxjgMhI3NmQfw0eciJiGlwkLxh8kCo3xhPUUs1m8J0hiv6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T6vVYxRI; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6vVYxRI"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-44c4cc7c1cfso2307367f8f.0
        for <linux-iio@vger.kernel.org>; Sat, 09 May 2026 07:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778336560; x=1778941360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R4zpzlxVkYdL6pM1JU7oOah1Khvqrfh/u/pFhf5YJ9o=;
        b=T6vVYxRIPZONQzb82XboHZmB0XDa36OnTXbvUwmK1D9eKBKXMdEOrGV41vm9WDVhoz
         uhk8JG0cvaoamXgv86KzvoI++oklP79HHD110rNUCmMwy2BmfjyHP112rEyZIp2y9EA1
         9VVcm/jX3JiAr8ljkBPMRTKi59X9xEaNQnp5Sl7h6DSIbf0jQT46P6nzdlVDTFxggPFe
         qvp88lZOkL7zziin3eZ+Pr55muh2AdDzMp4v6CNbZ0GkzOfZGSWzw34L5EXxjfrLGxiY
         ah3vTPNXT5Mvy+X0zvm21MkWz5FsOnnZG20m3D4kROn6Pp/XVzTV+Ejn5GE0SDtQNHlg
         TwTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778336560; x=1778941360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R4zpzlxVkYdL6pM1JU7oOah1Khvqrfh/u/pFhf5YJ9o=;
        b=q56wKlS3Mqb5eDMk3w7qltPFVv1Rdn5it7TyD7hjTM0wXu5LOj1S7mXP+AQsrkPlei
         CYyqck2YrrpZTVJsuBTg4fOmy9IccAiI90UWAcUgGC2seIBibgEsoEEXgsvRZVph6PjQ
         Ar0i6xvdB5lQZRldviB3+LMBsnsAx7BiseaLlt7/9xcCzdhoevIWkjkWgzYRXZ2b57F9
         rbxxWlPUSokbUEHiwSi8s+2piyqpXfKtolJBdFTZ60oW5PKkUY5u0Hp6CEuTNKynMwIJ
         FWiCsVi6oKhzYLAz3j6YVIxhKtL/dVeeJSyRkKbe/uOCWLRf5DFjILQnqhCCpF0Jc8FB
         SNnw==
X-Forwarded-Encrypted: i=1; AFNElJ8kRBJVIsMK2GXl5RD4uAWvTlHdVZhgkYYtn/0h1akWA0uYLHUGZW1VRQC9loQzsyirqdU87iyrQYo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw83vuTD1P0W7zuo5nJjSWU4tKY7LF/UY2Xwc9vsKfwX7sN446v
	5OtUA+PRYlJCYh9O1JU4a6l2mICOTCoOEpte0QbjZzZoungHSLBVKN/D
X-Gm-Gg: Acq92OFTfVMe5u7wx9Rq8ZPUqnhg0a5vm07Y0fLYD2j7g70Wv1AixVgB9uiPzJqzEx/
	l+l5TtTn+eQDDREzZQC8SlRzdx+7wjOLxG7fKT/eBU/GZ5v2+WPsd7gL4tlYzBrlmwJcXj/YtC7
	w/ip9REAwFuiQYUyKnDs69fwn+9XBeCpOK7AyQm2VHmTa4Ff/JOn3pKk3AlAFrEzF1VqGX3DeKM
	e+am3iqXFR/YPck6X9aGU30aoNcyrUAgWAFTe4gv0mrdkmyUj3T9k/s/43PVheWCOV+1We0Pe9+
	kHWErBfLIMaSFixztxSGaNFFEdr4r49N+JaLvLdxUKmgPu44YbZlRJADEt/z2Y60ZUoheWm/Fow
	9WHCX4S7P439lMslXuziMrblAuGQbpi1kj20pibGEJNOVQSCeRJmyXtm34zOujf1L3i1EfAu1RL
	voC91nrCKkfdRNAKsbu5/2t8AT3fVbcviDVPdBfKf1MZ36lZyWeix7dkmz6A==
X-Received: by 2002:a05:6000:2386:b0:43d:1cec:4767 with SMTP id ffacd0b85a97d-4515d9a02c4mr28221085f8f.36.1778336560387;
        Sat, 09 May 2026 07:22:40 -0700 (PDT)
Received: from DB-07.1337.ma ([197.230.240.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45492271510sm15127763f8f.37.2026.05.09.07.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 07:22:40 -0700 (PDT)
From: Taha Ed-Dafili <0rayn.dev@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	skhan@linuxfoundation.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Taha Ed-Dafili <0rayn.dev@gmail.com>
Subject: [PATCH v3 4/5] iio: dac: ad5504: introduce local dev pointer
Date: Sat,  9 May 2026 15:20:42 +0100
Message-ID: <20260509142047.30302-5-0rayn.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260509142047.30302-1-0rayn.dev@gmail.com>
References: <20260509142047.30302-1-0rayn.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace &spi->dev with a local dev pointer to shorten lines, fix
alignment, and improve overall readability in the probe function.

Signed-off-by: Taha Ed-Dafili <0rayn.dev@gmail.com>
---
 drivers/iio/dac/ad5504.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/dac/ad5504.c b/drivers/iio/dac/ad5504.c
index 57e6eeed26ef..9e95da6e49d6 100644
--- a/drivers/iio/dac/ad5504.c
+++ b/drivers/iio/dac/ad5504.c
@@ -273,25 +273,26 @@ static const struct iio_chan_spec ad5504_channels[] = {
 
 static int ad5504_probe(struct spi_device *spi)
 {
-	const struct ad5504_platform_data *pdata = dev_get_platdata(&spi->dev);
+	struct device *dev = &spi->dev;
+	const struct ad5504_platform_data *pdata = dev_get_platdata(dev);
 	struct iio_dev *indio_dev;
 	struct ad5504_state *st;
 	int ret;
 
-	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
 	if (!indio_dev)
 		return -ENOMEM;
 
 	st = iio_priv(indio_dev);
 
-	ret = devm_regulator_get_enable_read_voltage(&spi->dev, "vcc");
+	ret = devm_regulator_get_enable_read_voltage(dev, "vcc");
 	if (ret < 0 && ret != -ENODEV)
 		return ret;
 	if (ret == -ENODEV) {
 		if (pdata->vref_mv)
 			st->vref_mv = pdata->vref_mv;
 		else
-			dev_warn(&spi->dev, "reference voltage unspecified\n");
+			dev_warn(dev, "reference voltage unspecified\n");
 	} else {
 		st->vref_mv = ret / 1000;
 	}
@@ -307,17 +308,17 @@ static int ad5504_probe(struct spi_device *spi)
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	if (spi->irq) {
-		ret = devm_request_threaded_irq(&spi->dev, spi->irq,
-					   NULL,
-					   &ad5504_event_handler,
-					   IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
-					   spi_get_device_id(st->spi)->name,
-					   indio_dev);
+		ret = devm_request_threaded_irq(dev, spi->irq,
+						NULL,
+						&ad5504_event_handler,
+						IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+						spi_get_device_id(st->spi)->name,
+						indio_dev);
 		if (ret)
 			return ret;
 	}
 
-	return devm_iio_device_register(&spi->dev, indio_dev);
+	return devm_iio_device_register(dev, indio_dev);
 }
 
 static const struct spi_device_id ad5504_id[] = {
-- 
2.47.3

