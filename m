Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40B23254B0
	for <linux-iio@vger.kernel.org>; Sat,  4 Apr 2026 20:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775336340; cv=none; b=aZTIT7VLKS9AyAndyntmwoOsxjFTqiN/kcsaCz9uLFiaU4kEVBoaM8EdCh0d88Wp192M7WEomi+YpqsMYL1RV3+rNcAT55E2sb26QC5GAxXChgVE2KbBhKnfQgrImEkj27/ULL8I1aHooP035snSc08s9RU4o+83cJHj2HbDqG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775336340; c=relaxed/simple;
	bh=PQurDO6OXhnVPnvpUtqOGS5FT+WIsaPPR8yY5aKiW/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u+9sSQa69GDx9UUd/6NNQRvSow2MpM6YfII0A2LsnF652sy0ygwfOod5StbcIgdl47b2yNFiE1AABVaYv4IQVeg+aKoSiHK1Z7Nd+/LljRsyVv/KNuXVvAi/uOMmlhRP3E3iTzA6XHPSquM3EPZtC1uxRvptX5XuOeBrYZhFPZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fK6dxg0j; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fK6dxg0j"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488aa77a06eso2733115e9.0
        for <linux-iio@vger.kernel.org>; Sat, 04 Apr 2026 13:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775336337; x=1775941137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iPUiQBF9d8UvPDKEpZeV7b1Q9KHNeEe04jRYcpwMjow=;
        b=fK6dxg0jJqzSDawXAwx3Vjmd66lExzwrhUtZCmwQJJZtzdM+DnBF/qjrlTxiANh6fs
         q4gn15kyte/d4lPuCfDhKRl+65aPMyZdfuLvf+BJ29oXMKLNAGCsu+IlPINAFkQ7/g3h
         fbfE4v2N0pvaGXGLRzw1AHb1ffoNzX2Ky9YxeCLZy5umkGhqvI6Hq6Czbmr6+r3nQv+L
         Cy0pJHzoBTGwQ7TD7XVNN3SDR+pT0EaSapHXmhbRtA6KqLosSHx3KHQ4b0VEBiEeQbbK
         Lu8fygt53w7pAe/HvzganC6bpOPSoBJsXId5LxpU3eUBXhgyrNYcwG215E9PhED6Cu/R
         EbFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775336337; x=1775941137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iPUiQBF9d8UvPDKEpZeV7b1Q9KHNeEe04jRYcpwMjow=;
        b=n+qJ/MOhkAQ20rdTBuc3RCt3Ws1lrZAT/vD3l9BOPoZr6DZIA0v9e1cC1BjlkdQqbR
         rB3hXcdctluyQ6aUeXTakEbnmuws5jaFqHAbL8ZwfIRHF921xNXqW872mg44z9OIZ7nQ
         Ymz7F4T+qv7k7HeOhyKkOUZaxWONX8TvbvnUl73hljFzIciGQIePyZFgx054mOEXMk8J
         IyszxrRglzqdmS8nVZ4ugktUGKXdfMxDgF65tACm5q3SX9rcYsMXAzF3Vz+sq198E1by
         Ua/3qtET6IfS76n3QuypFb+FlY4YxKQZemKUBDJVRfAFmoXb7XDYuc8SctOakYLlJsCI
         /z+A==
X-Forwarded-Encrypted: i=1; AJvYcCXgOXHZTCPeMRqn8kRyOezxF0hzdANfsDeIPZK5TuTTXbsd0AyKTvq601Qoe6wDfzXrn3iHkd1jXwU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTzt2XFZU2dEyEE0IpnxwNnu5o9ISOd4YjQbIEpwKmZedVDrtr
	4D8Y+93mfpi7bwaRheLtDtPZiWLICVj78FEvGP72UUs1Tay3aoTa/Jpm
X-Gm-Gg: AeBDieuPQv5h01tM+r1e/FS99Mg1rECqiyyW8dl+59BtGbk5jEGb5qTYTD201WRG548
	ntOu7JBj6mabBZhvGz1RNpD4yog3UzGZDEY+Zc43nmCGwCgZPly2en9jh8j2pOlEUV1pZF64ADM
	UTXCpsBzRkVq7qx0CfsH6dVZVGf6LfQIf0NzLTZiGgY0S5gMD7mKDSZlZC4rFTf9msSocsOYN52
	wMVTLcgcoLprhL+dHxJzvwxDd5MO/z3qokvg67oSbVtOx3CsUplvBVHHTxMHK8N9NXknCO3fsvg
	peXUe1buwXVpQgB71E0nDGBNGd9ur1+NR9jJTWDStASJdlETgUgSGEW80KeGz+GN0bf25xoqNAz
	DJ6jH99ft8JhZTJF6Hz0LNwtmO6kVrGEaJIz32aVolgw/X6izL98bqeK4+1WnLd4MjY+m5SYQSp
	Oae/Ek2nUKNIdVNw5EnMS1UXxHFtDsxKzMyiR2IfI9sKSNuGaIXBVC
X-Received: by 2002:a05:600c:64c7:b0:488:a8f0:35bd with SMTP id 5b1f17b1804b1-488a8f037c4mr30177285e9.8.1775336337032;
        Sat, 04 Apr 2026 13:58:57 -0700 (PDT)
Received: from aldo-conte-t14.tailf68ad9.ts.net ([94.164.143.38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488a36f22b1sm84749535e9.10.2026.04.04.13.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 13:58:56 -0700 (PDT)
From: Aldo Conte <aldocontelk@gmail.com>
To: jic23@kernel.org
Cc: ktsai@capellamicro.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	daniel.baluta@intel.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	me@brighamcampbell.com,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH v2 1/2] iio: light: cm3323: fix reg_conf not being initialized correctly
Date: Sat,  4 Apr 2026 22:58:51 +0200
Message-ID: <20260404205853.18559-2-aldocontelk@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260404205853.18559-1-aldocontelk@gmail.com>
References: <20260404205853.18559-1-aldocontelk@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The code stores the return value of i2c_smbus_write_word_data()
in data->reg_conf; however, this value represents the result
of the write operation and not the value actually written to
the configuration register. This meant that the contents of
data->reg_conf did not truly reflect the contents
of the hardware register.

Instead, save the value of the register before the write
and use this value in the I2C write.

The bug was found by code inspection: i2c_smbus_write_word_data()
returns 0 on success, not the value written to the register.

Tested using i2c-stub on a Raspberry Pi 3B running a custom 6.19.10
kernel. Before loading the driver, the configuration register 0x00
CM3323_CMD_CONF was populated with 0x0030 using
`i2cset -y 11 0x10 0x00 0x0030 w`, encoding an integration time of 320ms
in bits[6:4].

Due to incorrect initialization of data->reg_conf in
cm3323_init(), the print of integration_time returns 0.040000
instead of the expected 0.320000. This happens because the read of the
integration_time depends on cm3323_get_it_bits() that is based on the
value of data->reg_conf, which is erroneously set to 0.

With this fix applied, data->reg_conf correctly saves 0x0030 after init
and the successive integration_time reports 0.320000 as expected.

Fixes: 8b0544263761 ("iio: light: Add support for Capella CM3323 color sensor")
Cc: stable@vger.kernel.org
Signed-off-by: Aldo Conte <aldocontelk@gmail.com>
---
Changes in v2:
- fix typos in commit message

 drivers/iio/light/cm3323.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/cm3323.c b/drivers/iio/light/cm3323.c
index 79ad6e2209ca..0fe61b8a7029 100644
--- a/drivers/iio/light/cm3323.c
+++ b/drivers/iio/light/cm3323.c
@@ -89,15 +89,14 @@ static int cm3323_init(struct iio_dev *indio_dev)
 
 	/* enable sensor and set auto force mode */
 	ret &= ~(CM3323_CONF_SD_BIT | CM3323_CONF_AF_BIT);
+	data->reg_conf = ret;
 
-	ret = i2c_smbus_write_word_data(data->client, CM3323_CMD_CONF, ret);
+	ret = i2c_smbus_write_word_data(data->client, CM3323_CMD_CONF, data->reg_conf);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error writing reg_conf\n");
 		return ret;
 	}
 
-	data->reg_conf = ret;
-
 	return 0;
 }
 
-- 
2.53.0

