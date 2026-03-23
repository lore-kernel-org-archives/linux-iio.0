Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8352433D6C7
	for <linux-iio@vger.kernel.org>; Mon, 23 Mar 2026 06:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774248429; cv=none; b=Xgq69ucDbHpohvyu5h22s/yBD6rCUFMg5FHLPbhPY8IWX040gGZk5Ix9YNzzoPa4DDXZq9XKlQZ9HcIDQVXaGgeZpdJAdniWX5JBrWuj0qBFS9X46elh4ccZcdXb3luDzetyvqeg8pqmxhnUDY+UUsTV7SwJd8Rz4HSnxfRgT9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774248429; c=relaxed/simple;
	bh=YewGLFPnwB3WQuYPkCumCIQFUwE8/xFwqRgybAuAlUA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZfcGqiKPncwLwem8azc/WESMNQ2CLBq4CFwKFDl3urWs6P5cy6wNKWtTyTd2972g1HYJz0J9Nx3lPfoi09OkIzwK3oB1S/QJnIAW9l4dnDb4Q28MW6TdGlQKujqZeaCcDAgwSTxPUohgRjUKokmUTO64Dccn0R2hHglmYNcIeaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XXDQQoqn; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XXDQQoqn"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-483ad568d68so5639075e9.2
        for <linux-iio@vger.kernel.org>; Sun, 22 Mar 2026 23:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774248427; x=1774853227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OnSxPivJOX3Lcxy/K55f2w03GEwxvD8XwsrDC32/Y/g=;
        b=XXDQQoqnDSIr7YbuCdJ8w2bdjwEUv+i5H4yzeTLMpqv9m+pSuwxtrWV6gZIhHUSugc
         zHjgPM4CDNRip/cweZAo4fhOHO+LoHTOfGlp/QK0ciaNCPRXpExR4SsSGu0vQZ0fQpKd
         +Sxgy0nA9QF8r1H22w3aDzjMWGIjivNzPXLYNon1NMMLr3OPrg8nqTL5iWXpDKVdEauZ
         nREBNUvyQjxDkVgAwRqdYGWkWrEzC1sJPyMUti8nLRLoU9yMYnG3LGaheAxNfJVf3aIz
         nHqO+aMdXz+U1YvvHl7ckaP4meaa88mifKU68nOu+mObH7AzDzpWVt5VyDTiF5GdH0+3
         zEog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774248427; x=1774853227;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OnSxPivJOX3Lcxy/K55f2w03GEwxvD8XwsrDC32/Y/g=;
        b=Rh50cFwMoZe9YCOm3epM0lTpLxBNCt3XvLVmiBb0Xl7XwcIT6VKdxN2SaUPYhLnGCi
         4NbtKFqxUcZK+qtwJC99tLsyMPo8dld0T96A93BaMmkVMa8KrYIQPcWWlCoMNktCMYsx
         zKZ366Tk8nH1Bc8snPpXmGYfK0wgsbiInwyEA5US8MUv+85uhuUMNtxiCXHRG3kHsh+i
         AS9iXcqmbxWfIVOiLebGSNpa+nFUHJly6+xRRcTGj+r3ORVr+KKxfsWhELVf6x5bK4ga
         0fQ75tAEWYKDcIeuLm4iAPeOohruSnVZSdbcggOCOuvXmoARK31kKdN9SCMHRnoLQ2Cr
         YPFA==
X-Forwarded-Encrypted: i=1; AJvYcCWV5MybkgmpnP1S6Dr1S5tUoeIkcL5PTG5/IcMqTrClGlQSWRyZC03XzlAYf7H6xT4j7rgnZOF55RQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7g48MOe0w1/sONoLd7M9hcidEZw2/gIWoDu/r0XXxmKGX2ku5
	pIvkFspAo2JhgyZHYAA5E7IyxHWdhvn9vx3PW440RUBSNJWYedtlyCiZ
X-Gm-Gg: ATEYQzyCGuK4vu7oN5VvRhHlwPdqMmd84Uf0MQ8miw/zBu6SjTOicNLFw8lhNnlcWd8
	gzpL8w/kSuom1TlIruVTNzNQTBXwTqtQ+GKNI0SWrTdxRe9VfaknWEoLHSvntgZrq5z1XC/myrh
	HzYDCYRutV++3V/lJkJapvpcWHsZKKWGZ2Y820IbLDA97+Srb6fJPrOez49DSrfNg1JK1m0Gw+0
	WvWPSVMW7n/6hpUZpLze3c6fv9IOCIM/ayW2Qnm7RtCkUiKDxjhrSdhEyrBTGtAE8m8S6Xtvohf
	ZzNihP+3IQEOKX4bw142IUOljENaCUcvtxvhyseBCUvUcgC2vRe5efXzmyfZtzWTmDNWGAB/U8r
	roUbhF6ndXZC0K9ce7KgGXW4I1puidwKVywRO1bS0e4YT0bhcjyB807vfEuqYiQ6Ut/6PZ5lUG0
	wFU+sat3E+P6KSjcFpwMyju96RoAyYNXfJWZoSPEGYg0yDhxDhcpabtXATYnippubLOX795VWzM
	4Y9PEmiJPUULI7hhSQLTXDINIMhOiMP+/H94/W2PHHF2aPE/dAW
X-Received: by 2002:a05:600c:a43:b0:486:fdc0:4504 with SMTP id 5b1f17b1804b1-486fee0b930mr85793435e9.4.1774248426637;
        Sun, 22 Mar 2026 23:47:06 -0700 (PDT)
Received: from fedora ([149.3.87.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486ff1aeafdsm72714985e9.21.2026.03.22.23.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 23:47:06 -0700 (PDT)
From: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
To: antoniu.miclaus@analog.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Subject: [PATCH] iio: adc: max11410: make vref register name arrays static const
Date: Mon, 23 Mar 2026 10:46:41 +0400
Message-ID: <20260323064640.32497-2-giorgitchankvetadze1997@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The vrefp_regs and vrefn_regs arrays are constant lookup tables and
are not modified.

Make them static const so they are not reinitialized on each probe
call and are placed in read-only memory. Mark the pointer array as
const as well to prevent unintended modification.

Signed-off-by: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
---
 drivers/iio/adc/max11410.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/max11410.c b/drivers/iio/adc/max11410.c
index 511b2f14dfaf..69351f4f10bb 100644
--- a/drivers/iio/adc/max11410.c
+++ b/drivers/iio/adc/max11410.c
@@ -912,8 +912,8 @@ static int max11410_self_calibrate(struct max11410_state *st)
 
 static int max11410_probe(struct spi_device *spi)
 {
-	const char *vrefp_regs[] = { "vref0p", "vref1p", "vref2p" };
-	const char *vrefn_regs[] = { "vref0n", "vref1n", "vref2n" };
+	static const char * const vrefp_regs[] = { "vref0p", "vref1p", "vref2p" };
+	static const char * const vrefn_regs[] = { "vref0n", "vref1n", "vref2n" };
 	struct device *dev = &spi->dev;
 	struct max11410_state *st;
 	struct iio_dev *indio_dev;
-- 
2.52.0

