Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90EA43E9E0
	for <linux-iio@vger.kernel.org>; Wed, 15 Jul 2026 10:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784110269; cv=none; b=RcpI29RuHy+FJ4LWxPaR6icGUrVsVslbzPT/qSXCVhYiUXj3I9jD71Ndgy307G3bWX5n18Zd26VUI/e6TPMCftx2hgxsb462jFip5aoWdfWvGcdAjl70lKXnEfOE9+JQNZyRKch+HPhwLlhCM6iAVa1c35AnS4wOqD0hrYR4qhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784110269; c=relaxed/simple;
	bh=td8hsDBlRWSg1I0yceKl73dTjjAo8acQBy8lu2qEcxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jJYRuA+I/DHxHM/or6+86xSHYspGPjKo9TXNmMPzMsvzmRqt88Nz6G/FqzlX146bwcn9AfmZN6Lz0eqnaObTobeFh5GqQS8jinWihS/fO9DqYZWon0X78x1b18U9FQORRKH3tPserhnuxL6yTHJy5CMUFdH+IphG5lCnBfwtOQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rwo6605b; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rwo6605b"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-383b4a3755fso1828653a91.3
        for <linux-iio@vger.kernel.org>; Wed, 15 Jul 2026 03:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784110267; x=1784715067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1AtJCx4n0Ha80Zli2eWFQ1VWt2rCUOGYpij+i9kLvvo=;
        b=Rwo6605beSeXTU8rKWn5qfWfmtbPOHJ6EsRfaz+AZQxILPh6CBv/+AF+2kAayx7OzL
         /2EHDWBnoOhOgxJ1uuZhisQjVgspeXKy0r79kq5TA/+KYG2Q9YqcggV4GCqMZlaH4MOJ
         duB0Ajdp265s7oJOjiF85yz8Xj75uUkHegLrNZghs+Dn7Qq9lRAc5UKRXKggNAO36c20
         gc9u4OZcm2CH6wD0Erxn9DzwZl8oX+0snRGXXt+OYPFt4/LO4FtqV77IxXYNYpmzrkp6
         MfaGXyxcNV038XJlW28jWEe8nsNjOsKCcw/mLuEiAvkgAc/ODWoHHWlZZKwrQ6Kfb29z
         o3dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784110267; x=1784715067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1AtJCx4n0Ha80Zli2eWFQ1VWt2rCUOGYpij+i9kLvvo=;
        b=AG+6Yys7qcSr37tCEjFNr0jZtz8xTNVeGbmqgy6tf41oFVNO0VO+H+vCZHkTJo5f40
         NFsciDHBWCBjkMMZE36O3gCb1O63mAF8bUVqgqrARo18C5mIMpHJAzQ0WJRArmr/r8nz
         7vdgK2SODFab4l2PvVPFgrUNDalEu2+mM+BzzInoAJHgX39WsJjZJYiBzbo7zC0Fpe3i
         W6P2Pky1BFv5aCKiUO+FZ6lLsZ8StbsstnynayffZpx/SwcuJFuB5cqWifsgmqYKTSsA
         v9PTIocLccfC6vv8lDnsSJx1VTxk1HaCRqIsYehPTV/YznX1UJdFsPL+F7DfEhBEn6gr
         K4fg==
X-Forwarded-Encrypted: i=1; AHgh+RpS78NVEoGJOq61Sw/x/CX9+tFJl31WBAZm4yaSBZMaxDrOkoGd9gtvOrRrPj2Fl0bxW/7aovCip2o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/j8pODDDI+wjoOoQpQJW3eWkjjIcW4CFTPi+qalKJZNvIO1Wn
	bU5Pb+++CCfpoKk6KdoYgdfWhJlHp09I9hgRkFsdpqqjycAUKf8HMEOI
X-Gm-Gg: AfdE7ckM6cLNPxTtEF4ixedWOFkZ0UtmKpH+ObOz42zGnfILUX/DNM5o7NjlagvNNRf
	Ah7u4QazvHwybI4b24bNcePbaqaISU9Dbj14xkaaf9a75adSZ6y2/5dpB76n3+8GTKVxP5mMxxZ
	qWF4lia0SmXhC+pW9VYRnvbqqNb2rveXH2Kcfvz/c4gJadQn9itNnqihZjDuU/KvPNLuLBV2uP3
	q8t2X3yv5cNtjlGyygF5WKqDxA+PfAZE66/eRl1EcNXMB8EQWQsVL7+WCkoJGiDF+69Wi8tzRID
	v3AzdlyNWQRp197PRJwzABb0o+xEZOY9238SdMn2ujUe2SCnJYMrDusz+CIuAed0DkgJ/rZYY7W
	kqz/mIav4oQdeQ5NSCgHPO5qbGYPkhW/JFXGZCEl87BaNbDfdieWTzaNVz+LrZ9UtBm8IODoXHM
	xE5qJVDgX8qzgI0ODMdpSLg/8v6wl0hDZvPr22vrEK
X-Received: by 2002:a17:90b:498f:b0:368:af5c:5925 with SMTP id 98e67ed59e1d1-38dc77384c6mr15626367a91.23.1784110267074;
        Wed, 15 Jul 2026 03:11:07 -0700 (PDT)
Received: from primary ([223.181.23.34])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3119c2a7bb5sm62079757eec.25.2026.07.15.03.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 03:11:06 -0700 (PDT)
From: Vidhu Sarwal <vidhu.linux@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Per-Daniel Olsson <perdaniel.olsson@axis.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	Vidhu Sarwal <vidhu.linux@gmail.com>
Subject: [PATCH 3/3] iio: light: opt4060: Fix incorrect register name in threshold read error message
Date: Wed, 15 Jul 2026 06:45:44 +0530
Message-ID: <20260715011544.281148-4-vidhu.linux@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260715011544.281148-1-vidhu.linux@gmail.com>
References: <20260715011544.281148-1-vidhu.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

opt4060_get_thresholds() correctly reads OPT4060_THRESHOLD_HIGH, but
logs "Failed to read THRESHOLD_LOW." if the read fails. This is a
copy-and-paste mistake, as the preceding low-threshold read already uses
the correct error message.

Update the error message to reference OPT4060_THRESHOLD_HIGH.

Fixes: 0c6db4506ad0 ("iio: light: Add support for TI OPT4060 color sensor")
Signed-off-by: Vidhu Sarwal <vidhu.linux@gmail.com>
---
 drivers/iio/light/opt4060.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/opt4060.c b/drivers/iio/light/opt4060.c
index e3aabfb14d5d..f79dd342937d 100644
--- a/drivers/iio/light/opt4060.c
+++ b/drivers/iio/light/opt4060.c
@@ -810,7 +810,7 @@ static int opt4060_get_thresholds(struct opt4060_chip *chip, u32 *th_lo, u32 *th
 
 	ret = regmap_read(chip->regmap, OPT4060_THRESHOLD_HIGH, &regval);
 	if (ret) {
-		dev_err(chip->dev, "Failed to read THRESHOLD_LOW.\n");
+		dev_err(chip->dev, "Failed to read THRESHOLD_HIGH.\n");
 		return ret;
 	}
 	*th_hi = opt4060_calc_val_from_th_reg(regval);
-- 
2.53.0

