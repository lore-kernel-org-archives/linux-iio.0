Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B586F3A168F
	for <linux-iio@vger.kernel.org>; Sat,  9 May 2026 10:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778321482; cv=none; b=lprJ1nH7OJQtZOmR95OR4UhVzS0Sgg6a9gfbkCnrSol67O4BJMHV6CC3eamLNkZoq2+1PtQluluI/xDRbaxYInqR/Vl4PzSaoFcZiVCWea9k0lYQ/DQ8okv5gNF0aWtWOogPN9iuZvprFz4i2AzGvVrNud2oRnrYsjLS5InWKdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778321482; c=relaxed/simple;
	bh=VVbBRaPqNz0NXDuh6RaAIZv6l4EoKGyZf9pCIvkbudw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RUoIXF8sZ6O7WqEQom9HViEx5tSMHRFfr+nlK1YXRYfVbbCdg0peRonlCpHjtQRWb0vqWmqY9pphjoC7FiaIKpVDn3AyGs2U/MIzfK5DnJ9HdIZg9Aj12UoOGfa+pTpyFUqDtB9W1lrYsdOxOMYq2/pihv6zW1LHFjjScAznqbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZapTjrsD; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZapTjrsD"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2bc763e2ba8so2095435ad.3
        for <linux-iio@vger.kernel.org>; Sat, 09 May 2026 03:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778321480; x=1778926280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gOWOLL+hb+19Lzkxv0p25XQnGbbiGbdMhzO7Q7xEcw8=;
        b=ZapTjrsDMGpXsHK31XNdtv5alGguGU5KzHo7JS/hwrG251F4O1ZjZooTfFDUAy4ZDq
         lLDnD/cshUVa5IO3o17lmwnwbl1A1tu/QxrCcSeFXt8oLLVEEoLNhvjBZ0uvDnHN4BXo
         dlTv+i26Y3EUfn7RM5tFc+5GySQ/kW+/qMUiXJiOFOwqXGXPnljeGLjtHC1QK4cSDNs4
         MZLe0JEUznHzBtY3A50cHT4JyneD/S9+vo6D4MA0KZorumyi5qLV2/GW9DIwD24QZGyL
         JCYBraubpxjE68hxjg7araxEtI9lDq21gQ8EniUOvPsIaWPA6KX3fn5Y1aKgg1DTkO88
         AwZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778321480; x=1778926280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gOWOLL+hb+19Lzkxv0p25XQnGbbiGbdMhzO7Q7xEcw8=;
        b=jh8VcLDsAwUpL0ejC9tJZzrwx1VXVbSqLxnMgq+oNYR9Jk9wz1nVj9X8synUXNByvw
         bJlekOAVPtzxePlGNtchNkY1ADQm0ZRjSIgVlFtwW3Ar2Ycp7PKK0PM51n63wrAIQWaK
         b2MI046ff7lj4ebZVyUjmj99EWeR66bQVbZpKWjcbUuR5Fp2zQIvjlcMdyMJ7eQeCzH5
         Mzuv9bxhpTqkfykhI2DZpha85QLVK9YZL2lsqIIhI3tCO3Afkx+oh0+V7WpdRY9gGvY8
         8tLm0+/kdPJPRMQy41Lf1KEKJfyBe8qDTU+sHFjtmqG+b9JkO8ZX2IDSKU8Ft6XxKKXl
         Spzg==
X-Forwarded-Encrypted: i=1; AFNElJ+hlu7W5plE+Y2DR7L57+qwx01gVBT+70TeDEdZV/DhujZQTURwUneQTpzrfvExBJ3CrKN1TWhXsEw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoRJvldfvlc1KqG/ty7f6SFktMJV8SQoUOyBS/OJt4eEmesfAv
	zh+yHQdo4AJbGb+S3mMy56JQ9OK5Y2JGR31X8wUYYURvpolJwMCKLXsE
X-Gm-Gg: Acq92OFIYTthsl5QN2m1r03s5dzcdJgKNyY0qpA8CoQVBCqoUBb8nDdKap0TRaV6ovo
	eIBzRU/yCfwzyteuQyHMgBOcIg3NxIwoT6MC5Xpxkl1BRDzz/pqKd5r/h2ZGVEIxQvux/fGKx5S
	qQG7b5QMdwVxkJWqOdoYFiSBH8SAEeaI0yIVinT7LMytGJnXdrb3+vsO9wFbkYXIASDUUs+uVar
	CmbylheVv4xwx2EWFyDIbV7E0pk/eTPiA8go6mhImSD3XdqyNmZonI7AOpIUzGZXV2w+nzc+6lP
	V+fwU9Wf8ft8jdQfiFFmiY8ITZalfOGFrAtiQMBaIyTVyp/FgxzKsk/tjk//E6xGTugMKhvBrUd
	LW0iBXM4FVNa5XFn/UuRSeXd0E7v1+cCBaYuYUjy133QaVpFymHc5AVESlT5mrPK5LpSkueiCIK
	32Ad3A/maTJCCmfwaC5z1jGEX9WNZNCqSEZCmvQHrdUU4EedLy
X-Received: by 2002:a17:902:d2c7:b0:2ba:99a2:c44e with SMTP id d9443c01a7336-2ba99a2dcb2mr148253195ad.21.1778321479939;
        Sat, 09 May 2026 03:11:19 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e83084sm47335365ad.61.2026.05.09.03.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 03:11:19 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jikos@kernel.org,
	jic23@kernel.org,
	srinivas.pandruvada@linux.intel.com
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	sanjayembeddedse@gmail.com,
	sakari.ailus@linux.intel.com,
	linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 8/9] iio: humidity: hid-sensor-humidity: use local struct device
Date: Sat,  9 May 2026 15:40:39 +0530
Message-Id: <20260509101040.791404-9-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260509101040.791404-1-sanjayembedded@gmail.com>
References: <20260509101040.791404-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Introduce a local struct device pointer derived from &pdev->dev.
This avoids repeated &pdev->dev usage and improves readability.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/humidity/hid-sensor-humidity.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/humidity/hid-sensor-humidity.c b/drivers/iio/humidity/hid-sensor-humidity.c
index 18d4e376376d..d310ec43a118 100644
--- a/drivers/iio/humidity/hid-sensor-humidity.c
+++ b/drivers/iio/humidity/hid-sensor-humidity.c
@@ -196,10 +196,11 @@ static int hid_humidity_probe(struct platform_device *pdev)
 	struct iio_dev *indio_dev;
 	struct hid_humidity_state *humid_st;
 	struct iio_chan_spec *humid_chans;
-	struct hid_sensor_hub_device *hsdev = dev_get_platdata(&pdev->dev);
+	struct device *dev = &pdev->dev;
+	struct hid_sensor_hub_device *hsdev = dev_get_platdata(dev);
 	int ret;
 
-	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*humid_st));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*humid_st));
 	if (!indio_dev)
 		return -ENOMEM;
 
@@ -215,7 +216,7 @@ static int hid_humidity_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	humid_chans = devm_kmemdup(&pdev->dev, humidity_channels,
+	humid_chans = devm_kmemdup(dev, humidity_channels,
 				   sizeof(humidity_channels), GFP_KERNEL);
 	if (!humid_chans)
 		return -ENOMEM;
-- 
2.34.1

