Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C685277007
	for <linux-iio@vger.kernel.org>; Sat,  7 Mar 2026 10:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772880542; cv=none; b=QZeYhfZ/4QUtFxwD38alGFFuVPWUecZ2Fl/qe4Yj9BbE6zaMp2KS/Sq8Z/6UBa/JpKvBalZSrlgZE+9fiLyRqS8XtTbduK+jde9t4ZkE6Mni8t7iKW9XDp141Iaqlo3EnnMGZSYhiGmmAYEklwg5BIuZGQ9HVbS6K9794SiKQNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772880542; c=relaxed/simple;
	bh=GEKF4DSIPqf8iTNvzGmcZ8ACdxqenBxpGn1KwgO6weg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eiSx3MTB0HMNf3v5nWJuzeANBbGffKJ3gw4/56oQ1ZpC2eGVPPA19mc8voFLcyxlnhV6FfeF1TNzs4rBxaGDqpTm4jUwZrOhLAQej3LvDi/ZMiI2+N2RrsWd2DWAEJiL621AOVyQtdJukSDX2hqKb3qA6yzmnv17Z1fJp/Ovc6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=avHU4BG5; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="avHU4BG5"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ae4d919f9bso39930325ad.0
        for <linux-iio@vger.kernel.org>; Sat, 07 Mar 2026 02:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772880540; x=1773485340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HNpYRSGd+j/T6pgpjNPyqo3Qzs4qm+K9ub7Shj6jVf0=;
        b=avHU4BG5BiXIu2S0U/xSJr4jt20Yeoz9l++rpyK1MMYP8DdOIQllbLZJqiqXenrZYK
         2RNqisykzxfJLBdpxfT4Ds4Xz5KkEYZbG2YVolI8/ZWl633VslMIUMeepocfWRPPM8cm
         OdHUiayeavixHz3Cuvbth93+a1Ms7D2DOhmMRFHCrsZf1p2izp0SH8Z4uVexnBxeUasa
         QfcGRlElIvfTRoWenUocqDVOfAg/cL9GD5yvQRcBupOH0nTL0TDNgT4VNpxQ94f/HobS
         HlS/ZZrRCyOe8eWOQMwEp4XYWOEiwU15QVvnBP8p6yXM5VymCAIW6g1bVe3JYYAx9EVP
         wzxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772880540; x=1773485340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HNpYRSGd+j/T6pgpjNPyqo3Qzs4qm+K9ub7Shj6jVf0=;
        b=iem6WmcAT0CKf1BekeDnkzBwfVuDeZ+0wPHHsk975lGPqHqCIAaB1MtzC1mOuej4Dh
         fwHRHyy/vTpwS3M4swZh45107FORWrzp9TWv9g00SnyXhiBDOqE1ZnVJsXaj4nP2S1dq
         wNSkePFs+PhN7YokiJZNbrh9PFbjdsziuShNJPulG0H7jO6I1ttYY09VN7R36dw0uQYi
         PMTBEyOGx0hYkj8U/spFwFzuv7KgNFPlOtrskgpG1nJua1pBdsJOHZdgEvfVvlJmedSw
         0kGMr3bQjLXMsadJw6ZWJ4gbWxTbrCeHg4scHZ689y+Aqc8Sifc+1c5H/yy6l5U5xI/g
         bfTg==
X-Forwarded-Encrypted: i=1; AJvYcCXR8c2Tfjr+F+hRp7LeNCZ2ai6zdz3w7X/qlJ59t//gqCSQ34Bci/9OSHNaRBx05E/JkpyZjTWsPdo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOxtcFtj9usySLUKOret8rWsvgVlIelkiToHaJBg7VAiCPj7PS
	fEy8WdM/a1fXIw+HDx+E5Je78u7/TploBAHgygy1d+m7Fe9F/8vIC9hy
X-Gm-Gg: ATEYQzxK5bB3QjPo4MA+NY0jGJAvA+dzGd5CCWIGZfGtdunnih6vUGGGNZZU/nQT65v
	KkIbGj3zI2NnIZaRN5Vbw3Lph1GgT6m+MO0QF8ZZ1XnLuQTZAScX9aLBH85MTL23eVfx3k5P+3D
	+SpmICt6kOq/rpQRXgLhSf9qiuYGkmP2Cll+/lxzOvw1rorMrKnIUEGr+XsYLwIXMguaShksjWZ
	a5Afcgr6HVkneqOD3SCfdrHsoufREfIGfzBg/u5Oo4KMVTivUth11EuWe9p+jKz0pWbijxL/7R2
	X9afZJO4KnMTU5Jm7vF2dr3OWFzJ9BS1jr728K3YR8TmmPw3iDALEZpHFpz+s/UMuPgrwODJr7A
	OWuEnjGw4tlAKi64IWOXye5IOmK0HnGV2fYcQI0zj193jyoc/2y61KSXN/KdDA2YM3K/JdrQjRz
	dyE6gzpLX4KWwRWd6mXtBbnW0O
X-Received: by 2002:a17:902:d4c5:b0:2ae:71e6:e79c with SMTP id d9443c01a7336-2ae823abc4cmr58229195ad.25.1772880540408;
        Sat, 07 Mar 2026 02:49:00 -0800 (PST)
Received: from fedora ([2401:4900:1c6a:49e5:cff6:c6fd:2f81:fb7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83e78d48sm49541235ad.22.2026.03.07.02.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 02:49:00 -0800 (PST)
From: Shi Hao <i.shihao.999@gmail.com>
To: andriy.shevchenko@intel.com
Cc: andy@kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	marcelo.schmitt@analog.com,
	mazziesaccount@gmail.com,
	nuno.sa@analog.com,
	i.shihao.999@gmail.com
Subject: [PATCH v2 5/6] iio: chemical: fix spelling mistake in comment
Date: Sat,  7 Mar 2026 16:17:04 +0530
Message-ID: <20260307104705.49129-6-i.shihao.999@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260307104705.49129-1-i.shihao.999@gmail.com>
References: <20260307104705.49129-1-i.shihao.999@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fix incorrect spelling in comment

- insuffient -> insufficient

Signed-off-by: Shi Hao <i.shihao.999@gmail.com>
---
 drivers/iio/chemical/bme680_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index 70f81c4a96ba..204663330bb3 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -807,7 +807,7 @@ static int bme680_read_gas(struct bme680_data *data, int *comp_gas_res)
	adc_gas_res = FIELD_GET(BME680_ADC_GAS_RES, gas_regs_val);

	/*
-	 * occurs if either the gas heating duration was insuffient
+	 * occurs if either the gas heating duration was insufficient
	 * to reach the target heater temperature or the target
	 * heater temperature was too high for the heater sink to
	 * reach.
--
2.53.0
