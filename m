Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D32F49659
	for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 18:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779041921; cv=none; b=XzSAEDbnDZQ6NmSqvZLm3BF2Q/xcBw23KhRPujUePCr4hT7ZlDhVD/GjKeD9NjI4eLrcw0gU21o8kuv/hLG7SFN6N1JpBtxpO2WHhT2fct2y2mDm7mvxLckrEic3GGNko1ruA3xM2EYufWnD5hh063mDHQvF6o0uGN8TWveEfCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779041921; c=relaxed/simple;
	bh=zB7k3lhSdqbVTwNkTinjxGrJXZtNT6Oek8UbqFGJVDE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kdnomwW9QoucXksPY22TLpAMx8l3/PXQI0No57vKWh7YprKvFCAqCwlXqcz9rNvjUBTVTVfKPZKdYR520uj1rK2eVq+Soc+tmraeHP8+p1F+3F285/SStsDt2LM/AajS5/nGstyWzS6DL0PLgR9/aP2G2+mtozwGx3us4gJ4ezI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=Cy3CEejV; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="Cy3CEejV"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-40974bf7781so2378247fac.0
        for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 11:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1779041918; x=1779646718; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ez1Xhq1H9VVtiiULLv6l2O+VSNqbdV04NQCVQ2RP6/g=;
        b=Cy3CEejVKbeUuD8VfHR9PbNu+Potlquid/BSRBkiaPwZkl3AXxd1k4TZUAd3LvpDN5
         FUK3zV1u7A7PvI32h4NCgN8SIrKy7LwGy4zILI/y9Oh9edoShLo2hFH1aUyiFul7I/h9
         x3EhKXqTxA2U0CExCtb/pQh/Gp5mFUaD9sz3qEThLDjvyTSNZ1H5C7Go9wdWsW2jA2i0
         ZybC0elQXePpVqjXAU/v3BAEdBxLanKBtad0LOJ3rbhzUn/zLjQMt3q4tSv6UdAqMSMr
         SUs3xK0AGOyz7VUe+KpxmvS3d38OpvmcpUoJY48iOLj7tmCUbSdZj+fX0qls/MwB/ZWd
         WHRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779041918; x=1779646718;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ez1Xhq1H9VVtiiULLv6l2O+VSNqbdV04NQCVQ2RP6/g=;
        b=W7GACjr8kZZof0yK+vf2Hslq6arGV5JmVU+Cnf8wfv8EAjggq6WRg53cSzTGjJEV8n
         iK2lA82yEHfvoLSmM3dLQzo3NUazwRuUYR6VD2gl765mSzxYJRwVTAB7opUgtI+CtwPA
         niBFUhW2vH1VFKnr/3ARpYE+aAHJ98LqXgbLW05IIz/+pDl+JsowrZgRp84I88Zmd00w
         Kg3zgfh3TiQ1JZNedLoXDfgb1kS+Z/fROSBP5x7n5j7FejB53JukwelOW/DXwpkMQ98h
         NTvqdvaU7D782yahF5FMJJVipL61QJaIcZw0I0LTQKwJ0JGee4b2r2MoEVKEKgra1E1c
         5kDQ==
X-Gm-Message-State: AOJu0YzLi7IaJUL9TWrmz6dNDHGzEb9qjP8NpqQr1DoF/3M2gn4reucM
	X9uYYJk/3+Sgr48VzoNluhYNVexR2xvnviHMKCmmWcPU9nYSnlDNZTcksa31XCxR4Jw=
X-Gm-Gg: Acq92OHJQdBs3HUio6wsRqVCfQc/J3aOeQNLcmxzxlX9y3dbjEqeDV33kYBu8UZ+f1r
	JnyDeu9ItjsYm+Knzp7H+xqoyvsMjpb+kK0mu8tzmOjRfB4DImbEjLovE67yRpJudj7ZjsodH7U
	el9wGxNIoYglEy9ZG6Owm243rrKyPk1LosY+5hOy26SasAofS6wfbVfypUbQFKFGrbVPBQ1PRZt
	/jKmCTYnbpM42epDrPTDXih1gkFhqx5oRJ/Cjgqyt3hAh/h9h94dJPRBC8pXShiJldTM6SNUXQO
	5g1aDwCsbq6THoJh27QwbmM59hzBggsSTwsIRnFq6e5DSKzQpsFCrRHTUdpdGqg4lRsmh5eOM+8
	sCnb2ghrZs/PnZZTqNpg83Cy7r8QiZ6Z5PA8/tNdntizp3CcZGV3Dg7KK1Qckz8Cdg/bRyE513N
	5w6M+mIS0WaOAgQgu8fYA9xKiXI5mj3c01Vxe3rA==
X-Received: by 2002:a05:6870:1750:b0:404:1843:e5bf with SMTP id 586e51a60fabf-43a2dddeb0fmr7311064fac.18.1779041918076;
        Sun, 17 May 2026 11:18:38 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7a4b:ddf0:f61:f58d])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43a95766535sm2085539fac.15.2026.05.17.11.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 11:18:36 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Sun, 17 May 2026 13:17:24 -0500
Subject: [PATCH 7/8] iio: light: cros_ec_light_prox: simplify timestamp
 channel definition
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260517-iio-timestamp-cleanup-v1-7-61fb908c11c7@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1097; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=zB7k3lhSdqbVTwNkTinjxGrJXZtNT6Oek8UbqFGJVDE=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqCgZfqM0vragiRqGTD7eEpg/krmTzQCfTGXB1h
 0z3rSgndWeJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCagoGXwAKCRDCzCAB/wGP
 wN/7B/9mbxgZ1arMG7zmnev/BZ3+8rddj+Wn7ufPv6TcTQVYZzFDkOaHVzTOdhOhQywA7LeEEEV
 IYxyzLebUsY7Cvp2hJfywA+NbN6mvVmcxj3d7MNcdTYL9x4UdjBbqkIPV6CTxo2VyRM4/QG2Rk8
 nXeiJ7FNalUuj/gJKBAdAsEbnZbV2jUTYylcaR7OcLTK3VbQ/uPpePkxwsx10WIjNYsUvt/g0eG
 DwEXz3vbLZSJCMhlKhEIdi/N4wcK8Q4Rdaa1PF4w36R70uw/HT3E6MFRjz5JnYuCyliNZUqykHp
 FNKiie0h+NYOJQVharYkgWkfNDV7xWjPxN6K248678aKDb6Q
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use IIO_CHAN_SOFT_TIMESTAMP() to define the timestamp channel instead of
manually filling in the struct iio_chan_spec fields. This makes the code
less verbose and mistake-prone.

Also drop obvious comment while we're at it.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/light/cros_ec_light_prox.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/iio/light/cros_ec_light_prox.c b/drivers/iio/light/cros_ec_light_prox.c
index 815806ceb5c8..6c8746236030 100644
--- a/drivers/iio/light/cros_ec_light_prox.c
+++ b/drivers/iio/light/cros_ec_light_prox.c
@@ -223,14 +223,8 @@ static int cros_ec_light_prox_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	/* Timestamp */
 	channel++;
-	channel->type = IIO_TIMESTAMP;
-	channel->channel = -1;
-	channel->scan_index = 1;
-	channel->scan_type.sign = 's';
-	channel->scan_type.realbits = 64;
-	channel->scan_type.storagebits = 64;
+	*channel = (struct iio_chan_spec)IIO_CHAN_SOFT_TIMESTAMP(1);
 
 	indio_dev->channels = state->channels;
 

-- 
2.43.0

