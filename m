Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E063CCA1F
	for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 18:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779041911; cv=none; b=PVn9D8FMYfsPU1fFZumtUS+g9CLuU1AY9DdfKsnOfuyCdx9tqKt4Y4lHIm+m86olfycNkr6QKkuBSzYt9AVyFdxxstUVFE5HQlN1T5fB3rKTwFZDtAUJfL6BbAYP00jIaU1mWm2tLUsZBkXNZkgLzlRaUMWuN5qExZk0M9Od7WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779041911; c=relaxed/simple;
	bh=C48Abd8eNikDaFfFId0eSCBHL6bq+0x5TvEL5GoFu8w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TbLXswkRiX2c1DI5KFRhDX0m+Goy/w/8iQAUe9vnqVFmfDwNLia4WsWZPw4iYBvV5JXlxVckC77dhr0c6c0FsTDGxvoY3gUvTwaaD68hA3BXRGJCv4pZETwEYraKOhpsveUCJrdeuxmUN8lPG2Zlu8fmwd0czf6Wcach0zT/C2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=DmLRxW7P; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="DmLRxW7P"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-479fc1fc048so1391629b6e.1
        for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 11:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1779041908; x=1779646708; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ECANKKg4MTkRxfSENzBkwIS1NPIhToNwg5GYCZ/bh6o=;
        b=DmLRxW7P4I8CHoJaVwQfjywacWblW53x01sZ4DW7+a95Q36le3z71vlgyxZCtCx3cD
         xw39MWjxdiIO/G8zWNQP65wRayjqF32FQHiQ8UCgA4cgcrK48gyL0JlPuEu8PLB6Yozo
         Y4J7zFtIDVPeIZ93B9CZdbCcX0wOzMgDra0Jnh5CD9w/119DUImRN9+WMoDBrmJax1Y0
         RTEY77EiYJaiibvshMmFm3YvBiCy1/wW0fEY6ff97B2lxPR37MwUrPYpA0Lt6LdLppla
         rytnIrej0ZfTH3juilpk8bE/yQ39MOhPC894FKAoy1ScNm7C3bDM7Bd/Y1RRPg3rt1yW
         rn+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779041908; x=1779646708;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ECANKKg4MTkRxfSENzBkwIS1NPIhToNwg5GYCZ/bh6o=;
        b=eTwjoe/ws0DHjyUcHy9Tf4j2VGBLuJ36zA7qQsrV3aEJuZ5RP33rz1srIzv6B3dTpF
         hpWqXuOFKuWMKT6Wn+jqPCqTIvAohGgfXe4doAryVNqqVYi0CXsPYQOaktxML3XNhuso
         9h6LuyTWMPvFPb3c6Ktepam7j0TJpqfwvYlUZ/oUlhCif25z0omdwwVeNjQAs5Xr0Wlc
         zwRGYmf/YHfu1cbtWYWhPdbOie8cU6+Fli/2CO3ERFc+pDd7fqFsRVq7h0MtXIDaLlig
         IqFQpNA7k+QZFEFDRO5One1uaSAFeSz/irAStCSeIrPrl3w6YFKjLrvidl+9EEADK5QZ
         Qwqw==
X-Gm-Message-State: AOJu0Yz6079Iq0+MRjdHZKYLoqeQGfjQytqvEULGth9DNLJJfdHiXkiC
	Xj1bAZ0i/bGegBjcpKpA/kEh7iZPTv+Vm1sANIF/K1H7md9RZnd99LclrwaVxXQS5FU=
X-Gm-Gg: Acq92OGCoiZ6gvZ/WjEYWmKuyeouS5MI5R9V4+KPESz1pQoX7iPTyHn82FRcoBZZA25
	smenA+M+m/YqCV/oLGYWuV6SeAsy/CLpUgUFyKVutYZ6KI3Ii/UiEgJb+hleaufePEXyyIWso3Y
	gbHaYYdXUCcQ4bXozD+WUyNlvnDGZzlhscqXClt/TRmpT/rNA/YkK9c+STXO5KjyGSC3O746bnX
	I1cXGF56XrLpfAutEqvPv9lqQBtodmCCVgI5X9NQT5tXq68Pv8/nLEwpKlCQl+m8iIkzZQzhxpP
	RAVI4ivlDPDGo8jjXz7B6Gk2KCBWDxiZxy85ir/r9qCrHUnGmKHrsEXyvcmhBg3I2HR3fN/5N+/
	vB2w0/WXRiCy+1/lIUgeeS/0Z5pmR5smgFtV5eaRlivN0elMM3A3LN319uxCkI4TcaR4zpzUTSu
	HRh++0v/IJ6K0nCPxkwwXNUcVkoS8=
X-Received: by 2002:a05:6820:20e:b0:696:7697:647a with SMTP id 006d021491bc7-69c942ef628mr8599698eaf.16.1779041908361;
        Sun, 17 May 2026 11:18:28 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7a4b:ddf0:f61:f58d])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43a95766535sm2085539fac.15.2026.05.17.11.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 11:18:28 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Sun, 17 May 2026 13:17:20 -0500
Subject: [PATCH 3/8] iio: adc: at91_adc: simplify timestamp channel
 definition
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260517-iio-timestamp-cleanup-v1-3-61fb908c11c7@baylibre.com>
References: <20260517-iio-timestamp-cleanup-v1-0-61fb908c11c7@baylibre.com>
In-Reply-To: <20260517-iio-timestamp-cleanup-v1-0-61fb908c11c7@baylibre.com>
To: Jyoti Bhayana <jbhayana@google.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com, chrome-platform@lists.linux.dev, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1410; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=C48Abd8eNikDaFfFId0eSCBHL6bq+0x5TvEL5GoFu8w=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqCgZDEZ17zmDQ4U89aCy+DcS8oW4YodZ7dhEf8
 0qbBK+H7XGJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCagoGQwAKCRDCzCAB/wGP
 wJFGB/9B3fVze53U8lx+G9ghHy0Zh5HQ9zTEiq/MOyWnB+E6PZoNL92fCoc4WMGniCoaEyd6UCT
 S8/2ofgAd0JD6A+5gZ4A3Z6ioBLYgUhJB1cHu1KUM29AIBLuDxp4xU/9MsG4PhsURfN/lRehJMA
 TIBIIL84aV7F9kAT9F1FpaGDR/nQSJxXDhoEa8ITP6iA442nNGUPY34z1zkTKtuuSPA77R7r8+V
 RIzxuL++W+LZLHPnaWA91BW32quPK4BG2mAgCxFA5La2kmd/mk/1EYpzGp93fuc89AhgdccUHvZ
 2XE8TzX6pT/qCvLiY0eYEtpxXW7n17P6PId2jHScku1P7KKe
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use IIO_CHAN_SOFT_TIMESTAMP() to define the timestamp channel instead of
manually filling in the struct iio_chan_spec fields. This makes the code
less verbose and mistake-prone.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/at91_adc.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index 6e1930f7c65d..260e3e0c09fc 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -481,7 +481,7 @@ static irqreturn_t at91_adc_9x5_interrupt(int irq, void *private)
 static int at91_adc_channel_init(struct iio_dev *idev)
 {
 	struct at91_adc_state *st = iio_priv(idev);
-	struct iio_chan_spec *chan_array, *timestamp;
+	struct iio_chan_spec *chan_array;
 	int bit, idx = 0;
 	unsigned long rsvd_mask = 0;
 
@@ -519,14 +519,8 @@ static int at91_adc_channel_init(struct iio_dev *idev)
 		chan->info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
 		idx++;
 	}
-	timestamp = chan_array + idx;
-
-	timestamp->type = IIO_TIMESTAMP;
-	timestamp->channel = -1;
-	timestamp->scan_index = idx;
-	timestamp->scan_type.sign = 's';
-	timestamp->scan_type.realbits = 64;
-	timestamp->scan_type.storagebits = 64;
+
+	chan_array[idx] = (struct iio_chan_spec)IIO_CHAN_SOFT_TIMESTAMP(idx);
 
 	idev->channels = chan_array;
 	return idev->num_channels;

-- 
2.43.0

