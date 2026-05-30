Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564373469FC
	for <linux-iio@vger.kernel.org>; Sat, 30 May 2026 17:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780162525; cv=none; b=Sz+zIk+OQzynev39d52s2TvS1G9WLJ0q3YYWWOo5X3Mms6yCXrS55O+gUsoIGHkiCuhkekgSK23ZsLKrDdpaYlm4x+jNd67S43SESHeq/SW6JZ705BgkxBMmNOxCXN6B7eXPiSagtn9XQcqw4Q6AVb+b/aMTqzGS49UKd3HPbJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780162525; c=relaxed/simple;
	bh=xj2N+hvunO9H/qokpmL+Uj1ED+5NNhqPQcO+Sny1sow=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E9WfgRUxuFfKdRS3l1e3UZ8lyek2NqtJNrw5bgvr41wmcrpPFeVfLTEt5m1h1dHGN63XmbA59YvAxOo+vEmZHnXdDTAERyG6UR4XUtI/Ng6aTMNF31uwPZPtISfX/phvWrVaVIZVSohnroHK7KagcBgAcb7ddplQ5zxZt/IBSL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UvE5NwAh; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UvE5NwAh"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-39677114c7bso79321fa.0
        for <linux-iio@vger.kernel.org>; Sat, 30 May 2026 10:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780162523; x=1780767323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/CEDkzzLvL1DAe0lGDe9mPko0qZhdDrWYtsQ4KepKeg=;
        b=UvE5NwAhYqtARLEpa4T90l9mmsRbo25P1wl0zBNRq5IOqXDLtiZvo+1muzRMHOBDo4
         nlJjXkAr6Qflu546igOfb+lcr0gPdTwb5VREGdiK49QEpkgu5gsbGtIgDgzAdQdUl+Dz
         Q4GsK/SuEfmr+Duy0mwix93FetrEKt/dpFbNjAGhllUAEwJoXmT2PKmpvFvfCMg97HOp
         7I8omwOiO2abbJRAqjbNR823JVXx6yA8WJYwrRl5h6EnjSTfX9+l4DokbPyz1m+uZla5
         wv4cI9McTctjihsEE+qHZqt15JEZENzHBZ3aY9XFXYGiz2Op+t8zZcP5pPOj4b92cRjM
         C64A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780162523; x=1780767323;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/CEDkzzLvL1DAe0lGDe9mPko0qZhdDrWYtsQ4KepKeg=;
        b=AYFPFHzd5xjK9zUTQ3pThFww4Cry5JpKlnla/7iuBP71AuKhQ65D1YL/WW8Ma43ukS
         +BYnGmLTtAu4ZphPpH57PjYbtGap15CZp8AHG2NnU52VuZUMJDaWkIpnKzIgkJuu+0pH
         WdsDEMjGsiolzKIRBHjUVqF0gSs8Yzxu0I8rGuCV0Lu1xxSrjjcaxgWZ5Dl9UrLfe8MO
         R1h9Ba453Uct6CWeiCEnZ8RBYtRsOjpKla/G2DgKfyqvHHIlM4uyOgOe2VnZujx3ldyO
         IiRRuaAP2mTd2rLcatRh/xBWp35H2wZX5LCa2CKsYM9uiDASwvIXC2BmPshOdT80yvN6
         WeHA==
X-Forwarded-Encrypted: i=1; AFNElJ89h+D3uyUKqBmw5DeaaXADuglRfhehkNKltBG9FbvztPmuHwKWY+BZTJDrCY4f88+JVQbCV/zjDks=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0btLT60OXjX3qqOmF5nYes01TJf62zc8tTJugpmKd04FCWTBQ
	lcqbio5+EF5V7b0WzXhkXcw6Bji7S+G9CkJpu5glin/ixCP6YCI8QMpZ
X-Gm-Gg: Acq92OFUeGYX57jPuLi+C0akO82G8FugIqj9etTmLsAsmML2mxD2r15hD3f0alt19Cu
	Mr4PsbK9G0aYV9pEKcr7i28bT0HGOv2i/zSPZVcOiBZjxjqseBGElvDErD4jEl8GohTA7OIhG8e
	OBns4zr6aupBM631+5b/gbORvBK6iniZqVn14ke6jF8w56+C4b24f9FLDrteFLjKeq8Y4ZguE5r
	WY338yoQ1TBH8zz+97EX7t8GuONVJ7o2KqnQUGJIXNWgvo/HmDIzvPWw1djED9ewZuKPpe7cALj
	1ir+7L8IZoHW/yCVlNna9Ug7bEILgGupo42qeJSNMbPLmgBGuyzz2MPmIwELOCgDQy1UDxGJgz7
	VQZN+CoNcHIUWvB7TP7rq/USV0zbCydldjc+49jrs0qbGC+WADUm47PNyRcG4HqZ19x1D4xMOMC
	ju+2Pggp7hxWKeZF/N1sFHXDIAceGamH+Mu40E/EdEfQZIAg==
X-Received: by 2002:a05:6512:3f10:b0:5aa:59e8:3313 with SMTP id 2adb3069b0e04-5aa60a35218mr649131e87.8.1780162522382;
        Sat, 30 May 2026 10:35:22 -0700 (PDT)
Received: from localhost ([5.124.164.24])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa5b072066sm1128982e87.22.2026.05.30.10.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 10:35:21 -0700 (PDT)
From: Taha Narimani <tahanarimani3443@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org (open list:STAGING - INDUSTRIAL IO),
	linux-staging@lists.linux.dev (open list:STAGING SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Cc: Taha Narimani <tahanarimani3443@gmail.com>,
	linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
	linux-staging@lists.linux.dev (open list:STAGING SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] staging: iio: adc: ad7816: drop busy pin requirement for ad7816
Date: Sat, 30 May 2026 17:35:12 +0000
Message-ID: <20260530173514.56640-1-tahanarimani3443@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to the AD7816/7/8 datasheet, the AD7816 is an 8-pin device
and does not possess a BUSY pin. The BUSY pin is exclusive to the
16-pin AD7817.

The driver previously requested a 'busy' GPIO unconditionally for both
the AD7816 and AD7817. If a device tree correctly modeled the hardware
by omitting the busy-gpios property for the AD7816, devm_gpiod_get()
would return -ENOENT and cause the probe to fail.

Fix this by restricting the busy GPIO request strictly to the AD7817.

Signed-off-by: Taha Narimani <tahanarimani3443@gmail.com>
---
 drivers/staging/iio/adc/ad7816.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index 988eee3..0eac484 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -84,7 +84,7 @@ static int ad7816_spi_read(struct ad7816_chip_info *chip, u16 *data)
 		gpiod_set_value(chip->convert_pin, 1);
 	}
 
-if (chip->id == ID_AD7816 || chip->id == ID_AD7817) {
+	if (chip->id == ID_AD7817) {
 		while (gpiod_get_value(chip->busy_pin))
 			cpu_relax();
 	}
@@ -380,7 +380,7 @@ static int ad7816_probe(struct spi_device *spi_dev)
 			ret);
 		return ret;
 	}
-	if (chip->id == ID_AD7816 || chip->id == ID_AD7817) {
+	if (chip->id == ID_AD7817) {
 		chip->busy_pin = devm_gpiod_get(&spi_dev->dev, "busy",
 						GPIOD_IN);
 		if (IS_ERR(chip->busy_pin)) {
-- 
2.53.0

