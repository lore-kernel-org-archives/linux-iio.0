Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B336466B7C
	for <linux-iio@vger.kernel.org>; Thu,  7 May 2026 19:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778181098; cv=none; b=kuZLBQyD6kWob0SGEJRexjZhi4ef0IiirRA2jBW3AIpFVNKu/tGWAdCp6ljP0UqBpJjJ/D4P7/RQhA8W6J9mefHk3HuNUJSWg/c7ywYpwAVecnJXnU2piOI3gVdkonzPCN83R++yU/NuQGfqiANgFC5OlVH5B1L8lCuNQrhljD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778181098; c=relaxed/simple;
	bh=Vm7MxuGve6glr3G+kFIdqTFBlilbOLRC5V7j4nzahac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CbDP0kL0TOFmrxUJlyQFa3KXkfj+3lThueOvsULvFXcR6v81pnYBR6kFRQu6wJQ6EpiBIUT/c33Ht+VfEoCRKPS7sqJ9vS5Zw+SmLN08RPs4lhjAt8j4OSMOvX2S2GA/PeRUNyf9kvW1Mdo6oyU5Le2u2gOUUbpXSzuysHFQoOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fEL8K4o8; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fEL8K4o8"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-393800586aeso24096851fa.1
        for <linux-iio@vger.kernel.org>; Thu, 07 May 2026 12:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778181095; x=1778785895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iev/RaR7ebPD8/QuDYCOu2PRxG+LdvAV0DZxv0cI94U=;
        b=fEL8K4o8G/P5sHNu+tkBmlFhPZqRqEsG5OqVBzrz6oV4XMfoh8H0qFVi98ESoniPx2
         I91nptS4ludgi6p/LwNQTvd1bkAtH0VUO7m1/rqPmq70OwN8pFr2x77hhS1h56rsBmgZ
         6Dkjjcti+IwHKOaaKDsE1/ZziNvN7gZu/ZVaCHt3TlNHWiHXZA9wRJt89/V+j6ph5rBB
         tmi02edUO584AAx4XqG/eVCoA9IufKWoq9a0AZVWy4JsVlQAlcinL8+2/Ld5z8DtmKEH
         xctBls3SGNdw7aiHaaMGD+C3sSKICkeqBBEiTT4AaOQdqmjq2fmgMvPFx3WXJ3/dCg1w
         rWzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778181095; x=1778785895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Iev/RaR7ebPD8/QuDYCOu2PRxG+LdvAV0DZxv0cI94U=;
        b=h79/Cv/Or5ZTiS6W0FIIDdksUOR3fGhLDWPOhDQQD/CRVVKXG0HnHKhgkMC6wcGgTA
         QtH+wszFguBs/7DIArKSO2s2dzvw0pV8QpLiCNOFDTC79gHguh54oXEHec41lL2PFXcp
         xmp8++YIBjq+IGEXWRtYds9esfX3xCzjvF+Vs3qjBLL3s5KiLOZnEpRM3wDjRmlhflFJ
         PkIUFTBqpyfR+WD640Qxgh9MG1QOi1qSi3nWIqH3rqI8y0Tbf//jjtMBP5zunnVjNzWW
         8oPLcT1cKB4ZALKmuVO7dhT7OV7Qu0MuB1K57tksLXkqGnuQ497xPSFPj2iKNN2wZdCm
         md+Q==
X-Gm-Message-State: AOJu0YwFc/oIchjrHvryFaoAm1yzGPgvXqznBIsPUoWn6/VudHa/ABDQ
	HnPay577ppHtIXfnJB8ZUSZqMtiEI5lE2kqsd0InjWQgptvwb/d9jO3w
X-Gm-Gg: AeBDies4rGO2rXhg1J2s46k3nE5OJrHFIS91QfuU26E2Zk5vvlUpojkLbdoFC7ESQcc
	CB7Duw35sdAirTZXZ3Lmcvv43yy3EvYUzah3xYvqN0GssUu4M8twmbctVac675eOgsj9FglzYJg
	lXW+8RQ/YD57hzcVTGeNU7oOYm3+nPKev09LkcsNbO9mN6G/oqA5KRbHC5kPhQWIvfbuvt95fn2
	MZw0cNI/eMxaCZAJKeJiyk24zMT1udjBzyRVYpp6sWsCW5B+hjOHGyg2OLBy94cx/SWMkxI0GS/
	5WbXMNcXSltka1lOJOpykz3Lt0kSKAoATAE+FuO6f64CKwWigj/uOM0eM2uTaPeEp/UVVGintBC
	s0HmYaob0vah9OIHTAvGcrggsprqVk2dlEL5M3cNqBvifgnlNffl+unDNETGt2cJsVFSPT+BQOB
	vkDQdNBGOU1euyiSgAvKVL+i9fyOSGJqmPkNW/yPaD0KdLXhy9L8POm6uUZSnja23b
X-Received: by 2002:a2e:a804:0:b0:393:b138:34ac with SMTP id 38308e7fff4ca-393db0526d6mr12247041fa.10.1778181094473;
        Thu, 07 May 2026 12:11:34 -0700 (PDT)
Received: from Shofiq (87-92-218-151.rev.dnainternet.fi. [87.92.218.151])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-393ef1b2b91sm1612271fa.1.2026.05.07.12.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 12:11:34 -0700 (PDT)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: jic23@kernel.org,
	mike.looijmans@topic.nl
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	Md Shofiqul Islam <shofiqtest@gmail.com>
Subject: [PATCH v3 3/3] iio: adc: ti-ads1298: Remove unnecessary CONFIG2 write during init
Date: Thu,  7 May 2026 22:11:28 +0300
Message-ID: <20260507191129.25924-3-shofiqtest@gmail.com>
X-Mailer: git-send-email 2.54.0.windows.1
In-Reply-To: <20260507191129.25924-1-shofiqtest@gmail.com>
References: <20260507191129.25924-1-shofiqtest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver was enabling the internal test signal (INT_TEST), double
amplitude (TEST_AMP), and fast frequency (TEST_FREQ_FAST) bits in
CONFIG2 during initialization. These bits activate an internal square
wave generator intended for device testing and calibration, not normal
ECG operation.

CONFIG2 defaults to having only the RESERVED bit set after reset, which
is the correct value for normal operation. Remove the write entirely
since it would just be writing the reset default value.

Suggested-by: Mike Looijmans <mike.looijmans@topic.nl>
Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
---
 drivers/iio/adc/ti-ads1298.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1298.c b/drivers/iio/adc/ti-ads1298.c
index 186bda3087..8957e873e1 100644
--- a/drivers/iio/adc/ti-ads1298.c
+++ b/drivers/iio/adc/ti-ads1298.c
@@ -615,15 +615,6 @@ static int ads1298_init(struct iio_dev *indio_dev)
 	if (!indio_dev->name)
 		return -ENOMEM;

-	/* Enable internal test signal, double amplitude, double frequency */
-	ret = regmap_write(priv->regmap, ADS1298_REG_CONFIG2,
-			   ADS1298_MASK_CONFIG2_RESERVED |
-			   ADS1298_MASK_CONFIG2_INT_TEST |
-			   ADS1298_MASK_CONFIG2_TEST_AMP |
-			   ADS1298_MASK_CONFIG2_TEST_FREQ_FAST);
-	if (ret)
-		return ret;
-
 	val = ADS1298_MASK_CONFIG3_RESERVED; /* Must write 1 always */
 	if (!priv->reg_vref) {
 		/* Enable internal reference */
--
2.54.0.windows.1

