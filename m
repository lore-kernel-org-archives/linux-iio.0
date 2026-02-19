Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CEF26ED3C
	for <linux-iio@vger.kernel.org>; Thu, 19 Feb 2026 02:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771468181; cv=none; b=jHh0EHUHLHzDdqFWNrUifyXsZdIqDaxVou1J2HEQ7aFo24hNE8uyABHM+SZDD7UwghciyfSrILwV8NT8ShfkXuAk5Kz6tIvHoEVaEXoECxT0+AcyqsNQoAAa8T3nX8GoDCAzlQSXgbZZu/QKdiKhLzsXHVVFP5lXiI4CsaXorFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771468181; c=relaxed/simple;
	bh=2ptV1Xx56QfDBrLdYoSATcUoNP/8s/g1i+FnXCc7fjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MmbA7bUKAbIKfEhO6pipLcjHnbprmecgI95m5/BZ+fGWYXM9JBV/bZJty5qzazUDBVTmideB1Li2Hlqyg2fCV+kKmHeGRny3OsxKZrCsQbmZ9+BoyP2euRlVit6Z5R7qyk/tNDy3MCbrNg+7w7fGkFfX1J+fXgeFV5IkaGQBelU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TGgnh/Bo; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TGgnh/Bo"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1273349c56bso584785c88.0
        for <linux-iio@vger.kernel.org>; Wed, 18 Feb 2026 18:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771468178; x=1772072978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3VoJX5vAwTEOYnmz7o7D9xEfXbcGfOzpGSFIbfxsNUg=;
        b=TGgnh/Boe6QQ+iF+sZfeqDa9Wi4yFH1/5ElXDenkc7mwKG37f88y9geMJZXtsAEK19
         b8HaQpzDuL9S4AEd7jmuWYeKLWElhJmXerEusM0ya1zkLhd+yxzWaewXK9+CRdelDtBe
         a4X/ivCm0IhyfuVxU78C0ZLgO1JT2WwPMOZcqKwbfCNz/B4sHVeSrHjZvfrSizHPnfZt
         Ub6Cu36wgSM0/sA6dsx43AdUN5OGh52nsFBLmXU00dVdc5xeKWFp0rJBHZLDt932ZoWM
         as9GuBhog2TyFF+7s84/HjheYU6VOx4eqs1RZRkQHT+LU976XMXKrmVlPSlOMakiUm8a
         QD4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771468178; x=1772072978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3VoJX5vAwTEOYnmz7o7D9xEfXbcGfOzpGSFIbfxsNUg=;
        b=E8Gl2oYjrb1BYwG9LyQN8ox2HX0FDbCtS4DPV4MeJnXkTZW915yVWhYGBIpWgOaHuc
         rtHA2RovNE0FWioQU2EI4c7dw5POlVL07fmvkJ+Kx29TBLbajHQXvtyLd2p17q4MPEnp
         A/SnR4I3tAWPR7DIbRdBiDbp0HixurKxfEH2cCwDTbQfnjECHI/EzVXP4UGBZDFVXVi+
         bwLSMofZC29QiUpyFonk9gwNaCeQbATqwYw0rMpJS5+T3ANp4riNCnJE10QaVQk5e71b
         I90azZYC0Vxk1wLnrDCvGgSno5EhhQEyAbT9c06oQCcNXZhhEWadvyFOa5672li8Zyq3
         s9sA==
X-Forwarded-Encrypted: i=1; AJvYcCVO8H2/w1RPYJ+KjbeUe8hU7I+SlK8y3eCdlRarA+K6EU4C71AIPuzAoiNJzfjqJ7IUb9WoTQ4WlAw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDR3txnKvTQGh/Wo5v67alqWl89LbjZRMJ1TvKjcnZYQiUuKAz
	z/CMXdj+5elNXuS+DAORtUxXYwC0iFpI5EhNM8HDe9+3hvQoVNP99SDd
X-Gm-Gg: AZuq6aJBvnqMtKa/9ha1Rdhf7MIXEBvAfP2i9xwmM7pHWUPemeFFR07Co8vqU2o7W1x
	NKlN5qQy4vnzTNkxeS4gh0NTjdhw3DqStZwqXjhFk97fAeJqf4XRcKCYzQvFNGPVXwrCYFmpjWj
	B9o/nXkKvV/l7roduQgmdya1BdS3tpdJ37t2+AMi3GGVTl+zkUy5f+JHyrNwh0qx+znCtvO4lc0
	YyUOYSIijaijuQavZSVTxPw8LFqpcJ8ZbNeGgvDnvAqhkffNtLuI9G2HgnuU7aJqgvVN5gVMDyH
	4G+yv8qHbUctaDCclHLF1g7PwmrsMvRBq6q6r636DbqgT59c2/wi4gR29LkHMv7oQZCTcKNQbBC
	wF7NkIWKNEhvtC4pktqAWN3go0BsRsz/fJ2sbv9A6KYkkCa+6CSnVa5L3M7NiuOIvSnNGpu0ao8
	WL9/gdEoQCZUitxJTTNwVU9UnBdS72wkiRWZnBw6CIJkq7j+THcWQYQnclH76QnwqVdtP0GDkVK
	FO2GI+JI5GvDpU=
X-Received: by 2002:a05:7022:160a:b0:11a:2f10:fa46 with SMTP id a92af1059eb24-12741ae3323mr7734818c88.0.1771468177903;
        Wed, 18 Feb 2026 18:29:37 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:265b:f5ad:9e03:677e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bacb577bcasm19609433eec.12.2026.02.18.18.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 18:29:37 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org
Subject: [PATCH v2 2/4] iio: adc: ti-ads7950: do not clobber gpio state in ti_ads7950_get()
Date: Wed, 18 Feb 2026 18:29:26 -0800
Message-ID: <20260219022929.3558081-3-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.53.0.335.g19a08e0c02-goog
In-Reply-To: <20260219022929.3558081-1-dmitry.torokhov@gmail.com>
References: <20260219022929.3558081-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GPIO state was inadvertently overwritten by the result of sip_sync,
reuniting in ti_ads7950_get() only returning 0 as gpio state (or error).

Fix this by introducing a separate variable to hold the state.

Reported-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/iio/adc/ti-ads7950.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ti-ads7950.c b/drivers/iio/adc/ti-ads7950.c
index b8cc39fc39fb..2a7d4a1d9fa9 100644
--- a/drivers/iio/adc/ti-ads7950.c
+++ b/drivers/iio/adc/ti-ads7950.c
@@ -427,13 +427,14 @@ static int ti_ads7950_set(struct gpio_chip *chip, unsigned int offset,
 static int ti_ads7950_get(struct gpio_chip *chip, unsigned int offset)
 {
 	struct ti_ads7950_state *st = gpiochip_get_data(chip);
-	int ret;
+	int ret = 0;
+	bool state;
 
 	mutex_lock(&st->slock);
 
 	/* If set as output, return the output */
 	if (st->gpio_cmd_settings_bitmask & BIT(offset)) {
-		ret = (st->cmd_settings_bitmask & BIT(offset)) ? 1 : 0;
+		state = st->cmd_settings_bitmask & BIT(offset);
 		goto out;
 	}
 
@@ -444,7 +445,7 @@ static int ti_ads7950_get(struct gpio_chip *chip, unsigned int offset)
 	if (ret)
 		goto out;
 
-	ret = ((st->single_rx >> 12) & BIT(offset)) ? 1 : 0;
+	state = (st->single_rx >> 12) & BIT(offset);
 
 	/* Revert back to original settings */
 	st->cmd_settings_bitmask &= ~TI_ADS7950_CR_GPIO_DATA;
@@ -456,7 +457,7 @@ static int ti_ads7950_get(struct gpio_chip *chip, unsigned int offset)
 out:
 	mutex_unlock(&st->slock);
 
-	return ret;
+	return ret ?: state;
 }
 
 static int ti_ads7950_get_direction(struct gpio_chip *chip,
-- 
2.53.0.335.g19a08e0c02-goog

