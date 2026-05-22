Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9263BCD21
	for <linux-iio@vger.kernel.org>; Fri, 22 May 2026 12:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779453271; cv=none; b=AT+AbRWwbHKnGp4TSOfyE14F1IOIRLTYuASfEG5cKIl7meYPThJHkiJCfCT9vcMsFQX+4ZHqXjkEJxBZVTtC3OT9HM3KsjhrXHI9sRm7004LzNL8INEbfLJmeGiuemHuRU/XPM2e5BcBlPpm0DLgKcEK0+fc3rkt6xnPJwVIweo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779453271; c=relaxed/simple;
	bh=HNVQB1Sx2eQiNy7XgLEbGRhcVanUAKDqdo7tkqRq+NY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IKSRGeJxyLt67v08q3j2igZ45lhalVk3QqZF2DuaoqVjwiN9do2L0L0iqgnBFTUCS8wTtZtY60JwWvePeEyrd+e/U9EuEEbqkBET38/kRhE/Yp6mmFfLEwlQbMjyHPTH47suom3QvukuKb5In2atN/oXMABF+u1dEHtdllPBkx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HqoaDxWk; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HqoaDxWk"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49048e043e5so1744735e9.1
        for <linux-iio@vger.kernel.org>; Fri, 22 May 2026 05:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779453268; x=1780058068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vMlIJr0UEjBMHNhPJ63udc9c/uXuEqSnqN9pM/ii/fY=;
        b=HqoaDxWkj+EbAyRjFhvsMl0E5lEU6Sh1cB/ef/JXsIDOu8skIwLb2xXfivS3Isia1x
         P4dOPHBtUHbyxqdMKF452WrhD+BsGfb/o4mg3OfOFA+MTUiO8yv4rTWTK8bwkVxcJG9b
         xsMosTBYdSD1d3GyjFm81Fnlo41szg/bKg+ybppa9HK51nzkyHf7OX1FliiZ4V53ETwU
         WQIHQDv04Tv4wW1jWz5GeD9WFRL/E3VrX3OtpKVOXuZdwP21mRBam+ubvzu8p7/Fsmo3
         YoEjr3wUwy19f+3xkdNHh/f13Vu+9WY6U4WS1jjptnmwnLGqCkC2DcIK9s6q8JBoMPEm
         eXAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779453268; x=1780058068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vMlIJr0UEjBMHNhPJ63udc9c/uXuEqSnqN9pM/ii/fY=;
        b=Nua9iGUQoYkI1QQbSL9/myXuvjf/MhOIcCaGaMKROvy80iGRFxcFOpbOAXM4MLRNS2
         n3lmvMMSgDCKI/agXxFT6dY/sCXslzAM4P8jWjoWr7AOxXh9ikd9TGb1WuyfRyPCyrFX
         x2i9dRQOv/hAG6orgutXlcxEbuzpnfac85yJcU2N4pqj339ToO0Rub/o+eGmnyC/NVhB
         K/F4TDxDrRJX2oabICbWRH8h8LxS/ePxsJVC309BA+s6kUPzgeGtEb+fwusCgPCToaTM
         VhlaNE79adiTbq8mySHZdVNMtV2qZezVrlFU2lz9Nz0tWCHfC8LvY2EtbWjogsW8ptWO
         NXJQ==
X-Forwarded-Encrypted: i=1; AFNElJ9oyJiODGXUWTgPCQVYUuQdO7dw0I1JMwfe206kGbcdzx4qzq5arKPk9Ry1kMbJaDMnF5uaXbZXODY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjX04xf3IokJ+Q1eRNqVJSPLhFie0ap+hyiFHQxQku8vQanmtA
	F23IXRdBxH2TEDF1BUlc2+a5aAwm28dPmj0v8jZN7BmtMYXiGlVdX+Cw
X-Gm-Gg: Acq92OGSx4+BUgY02pTR+xa+DS4XU8MOQtzFdOzmD0/JSGlOeDegO+L/77LhUSEad+Z
	kKPhalvaKQmky0SFuqHHnReL2mRBfDfEBSE1Yl1JpRyWplYmeDMSeCj/XE6gHZoZ+KoYxfbIrN5
	Vlfm/cbUzNQ10Qlet6foazc7LBIJY65Uq1GdW8RZRW2Jjs1jU6eIvJwxk641H8y2Au4gy/87OHa
	z1CWTxvHFzQaqcM1kRslaCMZ05tljUXybHDyN3iNrIrEF1otw+fzAEFGywm0pnKm3eBsxcHhCXl
	NUozKY4arFPvM1XrHCuRdPV9iJevCTj1i7ZLtE5Mv5J+bclKeZZwrq9A2iYNxd/oc3MxoLZAhZe
	zybzPSdcfE7s9waQMaqPntUrggEn34pF03lANRjKgQFOfqPUBPJa3FZT5zhHc2i+uQ4Glmzr+IZ
	yD3fzviTdTKO2UPiUd81QVUWfCvmjb7kcOaPQRlOGVJ4dmRxMsRXkZwV1WmWjL7Kk=
X-Received: by 2002:a05:600c:4ecc:b0:48f:e249:4094 with SMTP id 5b1f17b1804b1-490426d4bf0mr45733275e9.18.1779453267839;
        Fri, 22 May 2026 05:34:27 -0700 (PDT)
Received: from aldo-conte-t14.tailf68ad9.ts.net ([217.61.173.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49042af0ac1sm14760175e9.31.2026.05.22.05.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 05:34:27 -0700 (PDT)
From: Aldo Conte <aldocontelk@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	shuah@kernel.org,
	joshua.crofts1@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH v3 6/8] iio: tcs3472: use local struct device * for remaining cases
Date: Fri, 22 May 2026 14:34:17 +0200
Message-ID: <20260522123420.45495-7-aldocontelk@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522123420.45495-1-aldocontelk@gmail.com>
References: <20260522123420.45495-1-aldocontelk@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the local 'struct device *dev' variable introduced for the devm
calls also for the dev_info() calls in tcs3472_probe(), to keep the
probe function consistent.

No functional change.

Signed-off-by: Aldo Conte <aldocontelk@gmail.com>
---
v3:
- New patch

 drivers/iio/light/tcs3472.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/tcs3472.c b/drivers/iio/light/tcs3472.c
index 4966abf83c18..f74e6633db45 100644
--- a/drivers/iio/light/tcs3472.c
+++ b/drivers/iio/light/tcs3472.c
@@ -480,9 +480,9 @@ static int tcs3472_probe(struct i2c_client *client)
 		return ret;
 
 	if (ret == 0x44)
-		dev_info(&client->dev, "TCS34721/34725 found\n");
+		dev_info(dev, "TCS34721/34725 found\n");
 	else if (ret == 0x4d)
-		dev_info(&client->dev, "TCS34723/34727 found\n");
+		dev_info(dev, "TCS34723/34727 found\n");
 	else
 		return -ENODEV;
 
-- 
2.54.0

