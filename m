Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F464BCABD
	for <linux-iio@vger.kernel.org>; Wed,  6 May 2026 18:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778091322; cv=none; b=ZZuC/4xsSvXIv1qTcoMrUEmyfCdnmeyIoaZGkkfYx/N52u7WT7krWUdwed+gArLNU4tWlVotAkq4RrzQgIy4MYUGb/rfL09SO1oCpYB2ZXDYwRNaEx43wycEIdRULNwsWTJcbP9InaO3sIJjH/MVRJvdgC5jI+ENDVzlPfgazCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778091322; c=relaxed/simple;
	bh=KYHbEs1hFhbzdxRs3kjAitKOLVWL54iGr3ovFRvC3yk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nAYcZajH8I1DdnSxiKjOMgzA854OIF26xzpBjbchMnJ8oosNIZZCyxZyPjHmLsp4guYIspa70pQqDFX0g4KxAuzqcT4FpUG5qux9st2lsi08zJXvo2G/wT2TepiHJr8nvjkdqw4slMXyL/Y+y+5b/r+pXLSD8K9HoqkAr5DY0sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=daIx9g0o; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="daIx9g0o"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5a0ff30b240so10011476e87.0
        for <linux-iio@vger.kernel.org>; Wed, 06 May 2026 11:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778091319; x=1778696119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=urPJFirmQxK1PfI+Y4FpSbIT/Bsr9NE+HAChfqtMiKg=;
        b=daIx9g0on/PQSEE9MhzP8Nv9cyaaJuK8fgMwlUMPj8I1A+Vc6fOGB/hhbZq21D2wBy
         mXOrUzKqTu7gBpVCO3cNkxcZ5rLAYVpzP949GQqdNZMdZSz9ND6Tp+ATNa+RSZ5XvUCe
         Tqvd4vOtYYiw1rLq6lsQXJbRulJqxCfZwtJ1k3rflxRoEaq43gjbZlcM9pYOLOBFgPGt
         ivxwHkK/sorDqrbvl+pM4zd9JC6RlG/gel00HCDtTfvSG8IVlBjQRsYveSFHMmS6eVOT
         I/7bq5BsY8IKKE9J8uJVURXoHkZquzco7NPwKqptL7jIoRsAlHhQWHSR9rjD0feM3nr9
         TZ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778091319; x=1778696119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=urPJFirmQxK1PfI+Y4FpSbIT/Bsr9NE+HAChfqtMiKg=;
        b=YNJs/DySem/PMeQarPnc7u+Jp/NSXxpWe/S+qTQzreSfdIP5pD8O5SB8CAqED7VkLW
         Wu8vT1QnKIgPEj7N5U4XtZuFAANEAAgHZIVrTsj4GB57dH3W9A/ifjF6+Jb38Uohp3Vm
         gzajba5Mbr4mzPjunX6EfqN3yhtlegAJ/VdSFZfVZzId5rsVqAvl/MSNcOH7u5euKVxb
         vC93wgsJZjk5mbZ2Y8IxUqvJS/jCXreJKbtUbslNkgYM1wqIAR5Fx+5+ego90ApibRsF
         CpAdjzXgY5I9VGdqVsrcq8tBE+QTkXbkUoR6sBhjjqFSBxFEe/wKy16FEVYJ4jH251Tg
         Q7CA==
X-Gm-Message-State: AOJu0YyWwVkq2Ot+YUQ9vUovh4xS7fhf0ClmwVz2xXWemU2aHE0Twbsr
	+Nry8tMjNOuxoocUUOYKccGHCD5NC5ARBMZnIeOE44zZR3XwUHYPhzuewbULzfz4
X-Gm-Gg: AeBDiev2L+WotvymglBN/NIjRdVaDH8gXSB7iwZakxLQlsruRZZw3ka1h4Dnrmt/Vhb
	CxMLQJZBGX3ejqG9IKQtsq2y18K5QUTPdh+9YhwTkf4aj8tgBNMRpudggzlh8XzGjqlonphWRb7
	Q9LdUtN3PDwDwEKd1wBpIomQhRTeLl6OHkeQ6bTrHqC08YpqMKWG7P3CZoeP1PmdMcg2tMF17+i
	uInJbzUxWnrkmg2soX00VpNrrrEK600H1OkQKvQA2HzJVdl4ehGcAoNHBjfZkMswFetMbTOy5HO
	/L3dy2WmzKNRoGBYGdpe6Ih7zspBrRq9seF2uhVb6qjm6B3IzIymjS+L4YJ3E7UJuwoaBO/PJvh
	st8LrmCBrY/QudU9AU9vzm+ApGuseSt6B0vUDOjCrj2+f3GQg0behcEuauQurQOrwngpxS7qZOo
	QZ+3CpudYJaT9YXbG6vGlG+xbW02frzzbd+weaSoRL8x7KWCg1vltDAKEs4s9QSmS1+/ppkMjnA
	xs=
X-Received: by 2002:ac2:4e45:0:b0:5a8:6b96:9d10 with SMTP id 2adb3069b0e04-5a887cef69fmr972792e87.40.1778091318831;
        Wed, 06 May 2026 11:15:18 -0700 (PDT)
Received: from Shofiq (87-92-218-151.rev.dnainternet.fi. [87.92.218.151])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a85c341848sm5037123e87.65.2026.05.06.11.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 11:15:18 -0700 (PDT)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Md Shofiqul Islam <shofiqtest@gmail.com>,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	mike.looijmans@topic.nl
Subject: [PATCH 3/3] iio: adc: ti-ads1298: Don't enable internal test signal during init
Date: Wed,  6 May 2026 21:15:06 +0300
Message-ID: <20260506181508.6813-4-shofiqtest@gmail.com>
X-Mailer: git-send-email 2.54.0.windows.1
In-Reply-To: <20260506181508.6813-1-shofiqtest@gmail.com>
References: <20260506181508.6813-1-shofiqtest@gmail.com>
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

While the test signal does not affect channel measurements unless the
channel MUX is explicitly set to route it (MUX = 101), enabling the
test signal generator unnecessarily increases power consumption and is
inappropriate for a medical ADC driver in normal operation.

Keep only the RESERVED bit which the datasheet requires to always be
written as 1.

Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
---
 drivers/iio/adc/ti-ads1298.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1298.c b/drivers/iio/adc/ti-ads1298.c
index 186bda3087..360dfd2fc8 100644
--- a/drivers/iio/adc/ti-ads1298.c
+++ b/drivers/iio/adc/ti-ads1298.c
@@ -615,12 +615,9 @@ static int ads1298_init(struct iio_dev *indio_dev)
 	if (!indio_dev->name)
 		return -ENOMEM;
 
-	/* Enable internal test signal, double amplitude, double frequency */
+	/* CONFIG2: reserved bit must always be written as 1 per datasheet */
 	ret = regmap_write(priv->regmap, ADS1298_REG_CONFIG2,
-			   ADS1298_MASK_CONFIG2_RESERVED |
-			   ADS1298_MASK_CONFIG2_INT_TEST |
-			   ADS1298_MASK_CONFIG2_TEST_AMP |
-			   ADS1298_MASK_CONFIG2_TEST_FREQ_FAST);
+			   ADS1298_MASK_CONFIG2_RESERVED);
 	if (ret)
 		return ret;
 
-- 
2.54.0.windows.1

