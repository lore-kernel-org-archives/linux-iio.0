Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1060A3BCD11
	for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 15:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781884530; cv=none; b=tr8LmK3IiUeL4YQM5CJMVKPIkIiwC1xVEw0lxKi0c+hSYvklUmkEsjaltpz5SXN1mfE3Ynkp8pcZTsA1+U4yZe81oVLA/b4sguVFmeXqBBwuznT5Hzg1r7wySWfgQ6c74Pr/gXPIlGYpLyiWJMCucBWvCjHyUWeZH2quVc8Pt/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781884530; c=relaxed/simple;
	bh=tjQx5mVS7NwTuASh950+KxnTHzEEB3I294/tVkNGHZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dh8xjyabgWCYsXK9yXEiC14iJAwAPk2WMt8AgTHdMoaQbhQgLeRY/uS9kbjKZCXET3Xn1bTT8i7RXt3W2KHz/RxbjrwtfvPKhZmHFe6hXwexpEY0ZvvxpGVFdIviR/pJzVUEG45qKoNJ/2EDBOjWOI4KfNe7T0IEcVwnuX1quXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=kF5CyIyo; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="kF5CyIyo"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49241896317so4551285e9.3
        for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 08:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781884522; x=1782489322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xDRJylIAJWw9ly2uEWk0nfBJM14YPiybO0SdmY5VJdk=;
        b=kF5CyIyoMbb+fu13bT70pwDqFUaI0QWu2Hc+Qwg38kQkWxDEitoYdx0R3+PCHbq6Rs
         3/ckoFdxGjGTBZy+teqWOWmPnE2+lpLW5kO5s72GrxpxQcutZ4w2Clg007D41l5owewB
         WUPOKiFhiVL6cYg/vGdn+V61ZPZGJHw7+NViK68tWTpRUNPyQEzdEVGC8cX/osiYtcQS
         zMmbb7aCyqEcivFpBWKqlQqFTcBwl38rcX65/kUvyLwScfu6tzM02eP+WJz9eL8VhNB2
         rMesLSzOUI9GBOm6xZ9jKc/C+Z0NrbC3QM/gqcpCj3JH5bQHzj3bW2eKxUrJcn6OTwK5
         AynQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781884522; x=1782489322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xDRJylIAJWw9ly2uEWk0nfBJM14YPiybO0SdmY5VJdk=;
        b=KVab7qlj82xxF9VuqKBujVP1x7Joq+K6i0ysWXimo3wkS+s2BKZ961yAErq8k0ETXl
         RGkv/3MLRTvzdb1xKknUZVOCPUS89mZoHUcDZIsBOaPJa2O6xg8t+F0g7f8SQx4K29f0
         D6bC6GU57UfFwvQF6TP4dE3gcK+wLWX9ZMDdBBOU5JmaJZtO9s2+pl1guzKjOSN1B03P
         eqzObp/SlF3fFbJLVt9E7Ks8vAXwYrOci89a3/HVMg8Nx57gai9N9/XxMuMrvC8iftDM
         sZ7FDBoP4ubhPeWGoXz6No07e3FPo5enkN42gGh80gY6BfwC1OA+JS4MNm0P6uPdhhzy
         w+8A==
X-Forwarded-Encrypted: i=1; AFNElJ+c4jo41MUzBZuMwCvlZ8UwIA6uR6WUal7cxUr+fxVsHgZl3rJpEz2ebRiTdpPjxeaTZ7WeVJOeXUo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlILRtDSVWsd6uhxH2QQYLPrAZ1uuqvKITSF/to6uqxXXh3FLn
	+1yunWI60f+eR/YqLEJ518C2Fs4tmx1kJyWf3NDhlJ01E4UouMRxcMFSIiYYcBZDh9+uwx6Wy6Y
	KK4iW
X-Gm-Gg: AfdE7ckzhRRZXx7e/K5k0IJgd3Ptd6wIAnfmangKnLIvqWGlsmKlrM5+AwBN+14SNDQ
	vTXzBwCxm7iOsAV87jjhMhNuPRo4X42AEYzjG2F1nugKzrL4u67ejeHhZ/53VqF8VjuM+KBFUm6
	+sde6ozNK395Z+hKwKw8NpDO7FKV/XgClvd7nrcl5UoX+HFLBeqrP3FvzoE9K++KSb2s4KZKUJk
	BgQNNXXeLzE70Xjw2pN/oWVSyazNZBC9OI/YsHwaoxyOBG8jCj944BFq84CncpROMAYUClF3HEm
	l5L+0qrW3FHcOivvM4af/rFh5CYUFXVYFaWUQ90D/uRI/Har8P1H8dzWNG4KQ+jE26Dl5Exl2qr
	+SCDp16B8iUHtn1Nwa8XvlGsoYCka5pSo6q0TMDJFtU/hnR7d+oA/1xoVhIxNfhKMZZPHUqK02c
	tMErTiOUqgTnu7C5l7PxPmw2JypexaPcKw7oZjYUO8QkWJZUVPYnaM0JAKp4clloKltR6OwLick
	BA=
X-Received: by 2002:a7b:c384:0:b0:490:b642:ce31 with SMTP id 5b1f17b1804b1-4923ef53bcemr57137875e9.2.1781884522167;
        Fri, 19 Jun 2026 08:55:22 -0700 (PDT)
Received: from localhost (p200300f65f47db04359fc0e70763236f.dip0.t-ipconnect.de. [2003:f6:5f47:db04:359f:c0e7:763:236f])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4923ff8a712sm74618025e9.13.2026.06.19.08.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 08:55:21 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 05/13] iio: dac: max5522: Simplify device abstraction
Date: Fri, 19 Jun 2026 17:54:33 +0200
Message-ID:  <54b79462e753b99c132a835f6b618b3cef76fa9c.1781883685.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1781883685.git.u.kleine-koenig@baylibre.com>
References: <cover.1781883685.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2705; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=tjQx5mVS7NwTuASh950+KxnTHzEEB3I294/tVkNGHZw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqNWZBaWItpPfmylmOY174IjWt8IDI/dN1J57Qx tIbokWb7ICJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCajVmQQAKCRCPgPtYfRL+ TngsB/oDqYjBl+ytmTMwPkmrsBrq1Ha9VM0FXnonBjNTDIXia6dUh82pv6M1Qfo1PWrSwinxkw8 4rrZzhwLswq50tkCRnp/nvJnEjUFsSMCGuywYRYKw3Wj1DGivLZSDv53JBsQd5tUqF6eoDspZQA AZaKbAtdkpSgtPVO5Q2spR3/HcNJ7PjJd1Lto9SREPmQmOYWLH3vcYBW+t9yBmoxmKJxzTF5AzT lFXIKPgdFkJ80197Ge2N29FXELHBD4Eird4A6ZRrlZ1zWZ9WtwZ6QCHpWxxgt2CXwn8gyVp6HlZ lJTYDZ9f9X98uasuRmmD/5rSYpmrc+tnNrTyliQgK2rSJzXn
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The driver only supports a single chip variant since it's birth in 2022.
Both the spi id_table and the of id_table are essentially unused (only
assigned to a write-only member in private data).

Hardcode the device name and then drop various unused stuff from the
driver. While touching the spi id_table assign .name using a named
initializer.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/iio/dac/max5522.c | 31 +++----------------------------
 1 file changed, 3 insertions(+), 28 deletions(-)

diff --git a/drivers/iio/dac/max5522.c b/drivers/iio/dac/max5522.c
index b52a9cc1da79..cfbe3a6e0449 100644
--- a/drivers/iio/dac/max5522.c
+++ b/drivers/iio/dac/max5522.c
@@ -25,15 +25,8 @@
 
 #define MAX5522_REG_DATA(x)	((x) + MAX5522_CTRL_LOAD_IN_A)
 
-struct max5522_chip_info {
-	const char *name;
-	const struct iio_chan_spec *channels;
-	unsigned int num_channels;
-};
-
 struct max5522_state {
 	struct regmap *regmap;
-	const struct max5522_chip_info *chip_info;
 	unsigned short dac_cache[2];
 	int vref_mV;
 };
@@ -58,18 +51,6 @@ static const struct iio_chan_spec max5522_channels[] = {
 	MAX5522_CHANNEL(1),
 };
 
-enum max5522_type {
-	ID_MAX5522,
-};
-
-static const struct max5522_chip_info max5522_chip_info_tbl[] = {
-	[ID_MAX5522] = {
-		.name = "max5522",
-		.channels = max5522_channels,
-		.num_channels = 2,
-	},
-};
-
 static inline int max5522_info_to_reg(struct iio_chan_spec const *chan)
 {
 	return MAX5522_REG_DATA(chan->channel);
@@ -140,9 +121,6 @@ static int max5522_spi_probe(struct spi_device *spi)
 	}
 
 	state = iio_priv(indio_dev);
-	state->chip_info = spi_get_device_match_data(spi);
-	if (!state->chip_info)
-		return -EINVAL;
 
 	ret = devm_regulator_get_enable_read_voltage(&spi->dev, "vrefin");
 	if (ret < 0)
@@ -159,22 +137,19 @@ static int max5522_spi_probe(struct spi_device *spi)
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = max5522_channels;
 	indio_dev->num_channels = ARRAY_SIZE(max5522_channels);
-	indio_dev->name = max5522_chip_info_tbl[ID_MAX5522].name;
+	indio_dev->name = "max5522";
 
 	return devm_iio_device_register(&spi->dev, indio_dev);
 }
 
 static const struct spi_device_id max5522_ids[] = {
-	{ "max5522", (kernel_ulong_t)&max5522_chip_info_tbl[ID_MAX5522] },
+	{ .name = "max5522" },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, max5522_ids);
 
 static const struct of_device_id max5522_of_match[] = {
-	{
-		.compatible = "maxim,max5522",
-		.data = &max5522_chip_info_tbl[ID_MAX5522],
-	},
+	{ .compatible = "maxim,max5522" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, max5522_of_match);
-- 
2.47.3

