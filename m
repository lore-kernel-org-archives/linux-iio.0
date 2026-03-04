Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0397F37DE94
	for <linux-iio@vger.kernel.org>; Wed,  4 Mar 2026 04:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772597945; cv=none; b=YS4GlC7aBsLEKeUHSryaK6/DsgjvE3rtIvMz16HT8ZW2biCUJuzURKmp/xuX+JE2Q6Tn2uWb7199PLk9WefTpocyBJfGWYnIdElxHEU0Q2lI/Lhtpz2xYlskfMX+rNfRaZLEGavnsTDYY3vGFfY6ksAAExzhEO5r8ZvNpY5kzn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772597945; c=relaxed/simple;
	bh=tVuA+tPAo4/bBKbHQc+OgPhHzgNXg3xW2vrAE9dGuds=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GBixhmsw/6vDS81R6177BG6Qx8DzgDTPQo48blB0RXoE3s5vkzX+wFwK59AYswAIOAvQ9x1K1JKxc6seX9NNJiQtGtoM49fXcR14YcOtgLmVjAQAU9wDJEJC39J/4A/1J5iUJUuVVLSzNtjrL/4cb2780HyMa2srnDsrBEh7Uc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FaZwWQbi; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FaZwWQbi"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-79853c0f5b9so55723217b3.0
        for <linux-iio@vger.kernel.org>; Tue, 03 Mar 2026 20:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772597943; x=1773202743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e3J4SJFkd0Yz/4xyMUebZW0UW2z89TjGNLD0gGCcfR0=;
        b=FaZwWQbiXYNSzfL9GwVbIOVE5i5m/vYBIFDNNioFVqImerGd4aBH0WSXQOVg4zfF1V
         INTzN20Z/geuyK5Hr6sEHNaLTmECZoOI2rkTM0MaKyKHUPbdjfrTVmiNow/kUqRzGMMg
         KsWk/FgNeWmAXKkg/QLiQihIojzG+FqR/a5w5pQC2pqsIzuww/kkM/Peh4VgvnBxGOOJ
         1cwriay8HO91y6yRkHYSDCW1C8rblXUrhgG1engzNQknz0cYWAE7xiWeZJby55Xmrqli
         vXCJwMM8LtLCM/nHZ5CQNdo6dAyqEYOdLxVp5JPDkzcTQRTC8m2NA5vNGUyOQ08Tk+Kq
         560g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772597943; x=1773202743;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e3J4SJFkd0Yz/4xyMUebZW0UW2z89TjGNLD0gGCcfR0=;
        b=UZQB0JDs60jBjDj/iYxmXZcsf3o/lswRIRD/zK+r9Oj0J1e9mWmb3WAmewhlWvwNWL
         l80A6oIna0HXZg+b/wrdpSL3qlDpTM83AH31eYv0JnI+weuNwXdgUmLwKiBZTsAUucBU
         2+ahaa2mZDiC2I4MUYKzB4l3tDa/mRBs6f+nrakbABxcSRmKrTwtrHJKbMfgWJrqBWKQ
         UBbP22FykQg5SLOSmge5TRhh75/WU/D8cQgvCizVsWws7b60g1C3uY01ISF7qVpqJjCW
         Rrwe1MPxKpNYqrxQNMCTNJbq6Yid6qxXRfIlajaBMj0iRSH/WfmU2a8X+K1qwVIc9y6E
         fAVQ==
X-Gm-Message-State: AOJu0Yye/TI4AEPFzJmd1OcyajeY8PgOo5eiPx1swXa9ewbVpf4iuhUb
	iSbCW3n/7GY8iceoKQQrtYzlV/c73fCmh20l89PH0yHQqwgm4dboUNZk3leikWtsPC4=
X-Gm-Gg: ATEYQzxSkDgiAno/7DH2sFwfkI78C9z4siz74PQl772P+5khh94gzok9v1mt4cvd0w6
	LXTYUQ5KITT7Nna7NcPdQ8NPDZ5qP5BsRuW/X6Ram0pwv1tE742ffw77zjLRGv7zMIGF5EaM4PE
	Bms3eLjcinZUr+S/9Ypcu3mPRSH1nTzW1KZpJN1y2kR1SL1pqOPG8jvXeuG+VGW1vte0KBrTgFZ
	9MTKESLQw+jZOieZOxZXgsVAqUI3HS44yVg4MNOQHBIj7njEFiblj8+J5UGuqyR7WFNrR7VXOvX
	QUiDbtTMrW54E1bICtYg8kZOpuxRI+U+WJiLJXqQmJHWSEMIF2ii4doUDWw9sCDbS8FSBQed3NW
	hCBkeNdpJBMIrXoO908jP1G3GJINlbSFTIq1A23WHlpVCf4N/Knf0lZHoy2qvD0yv1OOhVNwYmm
	tNPMAW4R7cBcExtKr563fUVFHB2LOta3isk3N8LnzsqIyxDYMpsVZbBpglmTgH2L/n
X-Received: by 2002:a05:690c:c513:b0:796:3236:7e2d with SMTP id 00721157ae682-798c6be0a5emr6473207b3.15.1772597942730;
        Tue, 03 Mar 2026 20:19:02 -0800 (PST)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79876a8db33sm71465357b3.4.2026.03.03.20.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 20:19:02 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: linux-iio@vger.kernel.org
Cc: Eugen Hristev <eugen.hristev@linaro.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Microchip (AT91) SoC support),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] iio: adc: at91-sama5d2_adc: no devm for nvmem_cell_get
Date: Tue,  3 Mar 2026 20:18:43 -0800
Message-ID: <20260304041843.7709-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is absolutely no reason to pospone cleanup of this post driver
removal. Just do it immediately.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/iio/adc/at91-sama5d2_adc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index 69bb49434f90..255970b2e747 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -2259,7 +2259,7 @@ static int at91_adc_temp_sensor_init(struct at91_adc_state *st,
 		return 0;
 
 	/* Get the calibration data from NVMEM. */
-	temp_calib = devm_nvmem_cell_get(dev, "temperature_calib");
+	temp_calib = nvmem_cell_get(dev, "temperature_calib");
 	if (IS_ERR(temp_calib)) {
 		ret = PTR_ERR(temp_calib);
 		if (ret != -ENOENT)
@@ -2268,6 +2268,7 @@ static int at91_adc_temp_sensor_init(struct at91_adc_state *st,
 	}
 
 	buf = nvmem_cell_read(temp_calib, &len);
+	nvmem_cell_put(temp_calib);
 	if (IS_ERR(buf)) {
 		dev_err(dev, "Failed to read calibration data!\n");
 		return PTR_ERR(buf);
-- 
2.53.0

