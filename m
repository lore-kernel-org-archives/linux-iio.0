Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795417322;
	b=U59ViLllSg+/R9/n8R4sWcLgwbgDhbogZf8Gtg7UmzJzy5i2RJqMGKetwRPK5p0wWgtx
	 IFxtsbuuOSqyZmjZpdhMSExzQtnQ4/hbrtONzrYUoGpWjdv1NlwPqjmif9YuJ5aJ/zRZd
	 ThVz4zfQrmB1tQL4DS2ftfG7zceBy0N65TXJYqnftxmtnmBLYCEiCWCXAZ0K9ed+MMD5T
	 I0oKrKLuykac8m/knGHyUMQD5lESCB6yiut1h5QJ9O0gaEyKooRk7SL2dxG4uX1TJImVv
	 nuOLi/dqAA6A+fwe8ui0PXb18LMbEFJlPbQ8CLCefqWOpNDNe88uwLi5HcErNQ76cVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795417322;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=itP1hoxcgyxT3Gqtak+dePMpVPLjPeNpaNu3XlNcqvw=;
	b=G1K/qfprgUwMDIDb9ezoW4RO3QLQVpYvCPc+bf4UQrTqSaWHgq0gBsdpy8UdwbShDJC7
	 jwSms0foXl0X+uU6I4jdcy+YzFKy6Nc1DIHBQo11NQdBXfPaUq/Eflxnh2lB9AP247idz
	 zCbFnGwiGO80JCGoRrhfHm2nu1wtdLC7ghzsX9Yu6L5NvMj8tU2FS0SPFa3IRWmwJAJRF
	 hd5Hp4cie9Fzwu0D+Afv2eE2Foxdik2haj4NqaSoaUxHRLeAYgHUkVD0dSPMhw56xUh1m
	 9zahpkxbN3qKXLCHEZNBmQGwHj2x5di/Vm8rBw0/P/WtOO28WzFaDDZEm5FquUMTQlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bF2hp56X;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873A6606A321
	for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 07:02:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 873A6606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bF2hp56X
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4acb44dcd7bso2288423f8f.0
        for <linux-iio@vger.kernel.org>; Sun, 22 Nov 2026 23:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795417321; x=1796022121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=itP1hoxcgyxT3Gqtak+dePMpVPLjPeNpaNu3XlNcqvw=;
        b=bF2hp56Xq2rIag6eJRwAOTnk3Gj0c4889uXhlex2fV9Qe0c9H/votPte01U+uQI9mE
         DYSQ/o8TikWhaoBoravTlcSCJxMRilP6MLdJwlp+SCkQKyREAJZ2TzQiPo5P58Es4lME
         Ss0i0zr2BotC1iJtLZXCOjQtIollvxAplH1Augpk/ILTOCtGrD4eTAHOSNMd5uqjhk3X
         D4anTu0YF0f6gKMX3febTyXiuk6gtDOoDxMKyxHOQJrwt5KDrT3z9VuIdt4pyUzFGEw+
         LSv3pN9Q6s/+U5RjrbM0H32kNxZ0sy2ATAmx/Gv4KqTYprP2YoZdNinYqO3AjOou8S1p
         xQJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795417321; x=1796022121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=itP1hoxcgyxT3Gqtak+dePMpVPLjPeNpaNu3XlNcqvw=;
        b=JbiFCUixDdGM62P+ulYGHPcZXfuFvYDmMSeMEe4iYrJ9JBcBjKWnfnQcZ7DCQFCQ0X
         ahihhA63vJPgDNDSQyBO9Ift3qet5a8JswVtob/j/X9KUDRFuTZPrM4pOiudRPTX8TYD
         4aCY7h0NH28PgFnleyn+khcKDJvrr2f3Bac2l/8/zMC11fjAT8glihKB4D8DfODvvbgC
         5UHP8zTKUCNVpCxQyRM2EfPHRANZ6L+ZVVJBqe0lfkYHvd2UHY+0Nj45OJYFXyxoCn4Y
         6nu3g4nXjJvogelvImNDuSkVKywlIby+bFk1yABK/hrz8Ulq1NK58ohNTY7ydfFX811l
         jWcg==
X-Forwarded-Encrypted: i=1; AL+hErEeljTnlQjJUo3LFl0kXOQjQVXlLOGR43tz13MNrU6vgrvUVoxZdL6ljbut+I1t6FRUsxyQeE+7bVs=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Mx3U+LOvl5oTAvYlpx7BNM8uV3rvpcHsjvoognYv9CCTYQHEK
	2Gn0Hg8chrM5VqLka2iwsbMaPZvAT4nt0dANm9Bm6NTkX1YIwg+4pKiw
X-Gm-Gg: AZFdTZf8rrSIdDTqhxHDqZsytWytClT5cBUTg965WzeDOWhpgZPm2JMmB2e9S31hMyF
	eiR1y7U6Muy5LbVYvGCrQeGX8yuGKiT9AirYNXHnsf6gxpSj3bBHrum3DsVljnmACa+kh/B1uHj
	KN63w2y0Vqlkd1gagQ48IlibLe3ob184EmYdqbWcySfdeY4wA7+8CyKYcFjJ6QtujTQFn85mNHl
	WuHfGB6z6ZDh72shtueBMatcW+hfSXPpI3OXaR8YQHzJFzqdHMBsypMwNDUaSfpPCQ6Ow6k/b71
	M6Txu4+OkRYS3Ly5GARiit7XUidkLCZkAQ3tYuQkrxZ3DsS09jSiQ4uHNBYOIJ0BudG+OQ4BVPg
	T7yl5Tx7YT45IGwi/+RLEdKW/3CIq31zHudHQTol6QIwYr/deQKlikg9uJEI6KXNpUDuuP5KQK4
	g8EujE87wbga8p0frPS8RRaSX8/BTe3NP7LxhkSOh575rO2QLaHl6a/vOP49xbswGwz9GRJz9zA
	ARtrCbnUZSKxWPcG0bcmjMxmj4JUObY6nXQqJgEOI7e8DnkS9pZi9rvKTJh8llsr92nLE4cOPp9
	s+Ws25cJDEoAktIOlHwNu+635HkUs1jonO25wqwSPcLRuAFAenYyt8F45A==
X-Received: by 2002:a05:6000:2312:b0:48e:b62:d133 with SMTP id ffacd0b85a97d-4abab6de675mr21620895f8f.5.1795417320763;
        Sun, 22 Nov 2026 23:02:00 -0800 (PST)
Received: from fedora ([154.182.66.143])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab658e2d60sm20779007f8f.3.2026.11.22.23.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 23:02:00 -0800 (PST)
From: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	giorgitchankvetadze1997@gmail.com,
	amin.gattout@gmail.com,
	antoniu.miclaus@analog.com,
	gregkh@linuxfoundation.org,
	mripard@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Subject: [PATCH v5 6/8] iio: adc: at91_adc: pass struct device to at91_ts_register()
Date: Mon, 23 Nov 2026 09:00:59 +0200
Message-ID: <20261123070101.53868-7-abdelnasserhussein11@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261123070101.53868-1-abdelnasserhussein11@gmail.com>
References: <20261123070101.53868-1-abdelnasserhussein11@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The at91_ts_register() helper only uses its platform_device argument to
obtain the parent struct device.  Pass that device directly and simplify
the function signature and its call site.

Signed-off-by: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
---
 drivers/iio/adc/at91_adc.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index 3d9ae99a2ce6..05e8b3deb043 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -925,8 +925,7 @@ static int at91_ts_hw_init(struct iio_dev *idev, u32 adc_clk_khz)
 	return 0;
 }
 
-static int at91_ts_register(struct iio_dev *idev,
-		struct platform_device *pdev)
+static int at91_ts_register(struct iio_dev *idev, struct device *dev)
 {
 	struct at91_adc_state *st = iio_priv(idev);
 	struct input_dev *input;
@@ -940,7 +939,7 @@ static int at91_ts_register(struct iio_dev *idev,
 
 	input->name = DRIVER_NAME;
 	input->id.bustype = BUS_HOST;
-	input->dev.parent = &pdev->dev;
+	input->dev.parent = dev;
 	input->open = atmel_ts_open;
 	input->close = atmel_ts_close;
 
@@ -955,7 +954,7 @@ static int at91_ts_register(struct iio_dev *idev,
 		input_set_abs_params(input, ABS_PRESSURE, 0, 0xffffff, 0, 0);
 	} else {
 		if (st->touchscreen_type != ATMEL_ADC_TOUCHSCREEN_4WIRE) {
-			dev_err(&pdev->dev,
+			dev_err(dev,
 				"This touchscreen controller only support 4 wires\n");
 			ret = -EINVAL;
 			goto err;
@@ -1154,7 +1153,7 @@ static int at91_adc_probe(struct platform_device *pdev)
 			return ret;
 		}
 	} else {
-		ret = at91_ts_register(idev, pdev);
+		ret = at91_ts_register(idev, dev);
 		if (ret)
 			return ret;
 
-- 
2.56.0

