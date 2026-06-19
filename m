Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1EB3C1081
	for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 15:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781884533; cv=none; b=qJPh62Gd/R8qt7kFV1U+hJ8r/1tleaH3dTYR5VQCcx/IOYCfokniJLSE8kyDaTYoKMpwUfGkpi/QOFEHCzt/U+sXPZ/SbeQ8Osun7AsG1aM2qwZ5vJkx7kVeDBpZgaseQThkT+DyEcQn9EbI45ql58vFY47t7RYfCQRjtnXMXO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781884533; c=relaxed/simple;
	bh=mwcODpq3teqzhwQYIn9G/W6bSTTnQxJQn5II92L3umM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qyXVDeNfqXs+bFu3n6hUOz5KH8n8itMJTi7E+9esyt5LpamoLujTpwrSEB3LrRE60ky8/UG4gjX9r4wQNTiDTMcVU350N3QvDOfVlWyouBcSiMnXDJ6CExfHb19FRqWjYHcpnqWsaOS538iCTHAyFlm0FyTUEUZ+reLooZXvB5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=eceDyh6W; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="eceDyh6W"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-462bb734793so1613589f8f.1
        for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 08:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781884524; x=1782489324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dzjy8QZ6gHtH+Mr2OZYB79kN3oEDC91fKj0LGCYohJ4=;
        b=eceDyh6WXnfW57W90KAcz0WXHNNvxUjxwCFqiSmqkkAejfVXEYIGDYTRcsmBCcVC8p
         MoxKNga/GO5qGNHUbGwqwkgYEkZiccD1ajgyvkBcdULSrTIKpfC335HAn3mkFKrl1zIc
         EeW+xbc+1XzUh8qTaFcRyk8Dk+diQ7ytYZz3H7bVxZ4jkc9UB8GWjsA380BMCUF89kNq
         wQTAreRSMG1/Eq0WEbJxVkNse3XvSZ3qO+uhaW6YTOPW05rtL2k6q+AypRJ5GkuQV/VU
         1TYTeEcRhnxp8rI4STcgWd70ZQ8ip6m1RSGLGKySYZfmvCfar8XiS++6XdX65DZmcXxi
         76rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781884524; x=1782489324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dzjy8QZ6gHtH+Mr2OZYB79kN3oEDC91fKj0LGCYohJ4=;
        b=c9s8tAAjCOwvafdGabH7tAM9QNE9pUV/VgMY5b8Cdg6KO7DAGLFdDQYzzUgHzgURn+
         LjYYKu1lfjuWznjqgKS5jxZlD032kBkAiBTLlCPMaBKs81ChNYPAz8yZFReiNif0+oew
         Vzu2axmHtidJSIFjgAz3lPJw2qZAcOfZq3iM3aWNMikAW4k/dLhpWxe+e68z+1kOVJvH
         YfESkEWTR+py1rOQMoNbZ+OMqGfVuS7eyScetDtmjelELTOz2HBVIGfkutFW3ggGU1AI
         nKbU/WQ3UXWpWGeJWuv0rzlvpy65aENbi3udWx/Vy+iamBPdOnGs48iwaZ37MQ+3E6sE
         09BA==
X-Forwarded-Encrypted: i=1; AFNElJ+vl1rBCQAe3uuN3cbqEcSnIikOjcN4qybHtmLVUOceZOvMuCap04VekMVRoMLFQnlS1yX6b40e7rk=@vger.kernel.org
X-Gm-Message-State: AOJu0YySqFmkROs6SCVanqJZiCryk/ElIVg+chG3z6ofYDGAYl8RIcCO
	ipis1GNx4mhcOYm85eGsHU8l0Qo/MqXNWyiuLPSZw5daDwKSbECMZ+da4Pz8/Jab8Sk=
X-Gm-Gg: AfdE7clgqmAlMUhq947Ekvgm1qcNdSK0Zi30hx+Yt8AEIXslt3BsxeU9SivcnV8tzsG
	0YAOgLFYjELEFUBkaVDFUfZFrCKXTScchWFFAqHv56xf4NlLlcP34XefUl5NO5R1qyZxPVNlPoB
	uSDTaScW8b4c3cdpl+tO7fl01N7FQyF0d08VmqqTwsbOYJDgKn6EokuwX1lg4N61RU75Kb6wMJS
	373q9pxTMxfRGMUFqIgoaUKZHZdX2BlTwW6lFviwZMUfBkaJVal7OdyOI7FjWLQLiZOLLrYl3gY
	WUZG9Rh7W9OJE836wzKq74KxIld/fpWbEhNyfhhf206d2sgcT6Jgve572mhAIkAL0lgXVrfsw8b
	qPQeiFe4iZ7YDBOZcz8mtt0FYBoFhWMi0r7LmzsikDHNkCBvuYEinrdv2UhWTZgjVckGkFTiONS
	vI9Tapev6lxikYAwrO1/3LeiBQ6biynawzaOclHEXjLv1iZONhSb+rGZuGCiD+yX4jdmMppFtPY
	/o/IqbWU+Eigw==
X-Received: by 2002:a05:6000:2881:b0:461:a5d3:915a with SMTP id ffacd0b85a97d-466607442a9mr155464f8f.6.1781884524146;
        Fri, 19 Jun 2026 08:55:24 -0700 (PDT)
Received: from localhost (p200300f65f47db04359fc0e70763236f.dip0.t-ipconnect.de. [2003:f6:5f47:db04:359f:c0e7:763:236f])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-46666788282sm2463f8f.17.2026.06.19.08.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 08:55:23 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux@analog.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 06/13] iio: frequency: ad9523: Simplify driver a bit
Date: Fri, 19 Jun 2026 17:54:34 +0200
Message-ID:  <620a617c03cc084a260c3441b8c9c6eed33efe0e.1781883685.git.u.kleine-koenig@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1058; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=mwcODpq3teqzhwQYIn9G/W6bSTTnQxJQn5II92L3umM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqNWZES0TSI6uR40ohmnYm+/+r6PYSX2LIz7Nqj zmU2BshBxuJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCajVmRAAKCRCPgPtYfRL+ Ts9/B/sFAXrWx5/vokfb8KyQBw6Yf5usjwh41HzMCMqpVbYpCgxg/E9pBoO4yGpsc4kM+R2EDcL YjF68VQwrpi4wuMvOBh7TeGz8FhF4T0ZsgGpFyBQqivge4qxtjScszLIweIsO8FWlKqmasB1d9G PmhZFD/JsHmEPnbveX3e3Sad5nG+aivx3tfG3m3baBocI7uaotvJqxO43HQEzPo2NnvqkBD1Ixa gvVEyAZ4jTHBa4gmPG9934rqKQeC9h3n6uwNOb8CjNdk+0KlIUl8gZzAVSUhzepz92dvW7K0aAm +pfXits1NOdaZ9nULtR0YrlG/7b4qskEhG4avNQEAbiGxNy+
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

spi driver data is only set but never used, so the assignment can be
dropped. Also the spi id_table's .driver_data is unused and can be
dropped.

While touching the spi id_table modify it to use a named initializer.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/iio/frequency/ad9523.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/frequency/ad9523.c b/drivers/iio/frequency/ad9523.c
index ea4d2763564a..1e393f40a8c8 100644
--- a/drivers/iio/frequency/ad9523.c
+++ b/drivers/iio/frequency/ad9523.c
@@ -990,7 +990,6 @@ static int ad9523_probe(struct spi_device *spi)
 	if (IS_ERR(st->sync_gpio))
 		return PTR_ERR(st->sync_gpio);
 
-	spi_set_drvdata(spi, indio_dev);
 	st->spi = spi;
 	st->pdata = pdata;
 
@@ -1009,7 +1008,7 @@ static int ad9523_probe(struct spi_device *spi)
 }
 
 static const struct spi_device_id ad9523_id[] = {
-	{"ad9523-1", 9523},
+	{ .name = "ad9523-1" },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad9523_id);
-- 
2.47.3

