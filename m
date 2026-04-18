Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AE138F259
	for <linux-iio@vger.kernel.org>; Sat, 18 Apr 2026 14:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776523675; cv=none; b=iPNuaeo6PVkKsxWkrmYIIZvw1FVSVrsme2BaAjGbaFbNOYCnG+KFGojeuO0G/f5IIudtRJ/r8G7O3akElPMogynQIFPz6aZ0LRvOZrx4C+FtEOGbPkHKiHE3VtbynQ7T9shJlC9U2fDjFvRE49soMsM1vhl+EfFMUQgPBSIZvHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776523675; c=relaxed/simple;
	bh=XKtOaV+bu3GvFb00eX45ajrX/DX5a1syVpVsKIHtT+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cEActRzX1lMbSPtA14druBfo3L8SPpg7y0XdXECkJBNO6LtiJG2RYMnXzvpMfn8BUZorgtQ2df7uuRHHiMnVagrYrUG+npAqoO9GcWWppnIWGQvF8qAmhhUlJdIlDvyF9qZkiyq7zg3hYnQCLLvMuD9NXHJ1JY4nEDq6Hm7kl1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QwHZS1HB; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QwHZS1HB"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-38e7d983f50so18175351fa.1
        for <linux-iio@vger.kernel.org>; Sat, 18 Apr 2026 07:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776523671; x=1777128471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CjixepHmZluQFzutL7IUoBNMtxTYec1nzIsEup2SLc4=;
        b=QwHZS1HB7y2cHsS0zZaLVw5mgiblgjtZL9OQg4LWZS7YHSOrwTACoGfkc+nBgrTwjJ
         l0CiPXZhHIQVP+DT5NlNUIOlDX2JhKdQh2rzLfcrPOC2WXuLpYhdaYqFWPRsYAoHI1VF
         im+iyRR0RFPhr4fH+bjE15Vf84b1sCnHos0710rtGpIygt5d+0T7l6bEYO+g2LpLlUAq
         YLc2nGAquDJmz4uHAEXiw8g0tqGoADWRJunJe5B5TkyvrKfzybR8Kj/IHGbQDN+d/Bo5
         1UgTxWWOmwM0eCz2R3OdS6DCpsseOndxbgeTKsNW32kCv7NM0Xq65ITzu0mvcwhBHV5u
         2tCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776523671; x=1777128471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CjixepHmZluQFzutL7IUoBNMtxTYec1nzIsEup2SLc4=;
        b=HMwki3nSP5luhOwQj/oN+2lt3j2YaTfD2Cf3FwvAkeVz2nREyxSnFwnyoG9g0xhkKd
         CmwGBzrjyv1bV/mmtjsn5GkZ/uNqMocOwDp3fJrR129RnjgKy3C7pQLKf8308mb8fR56
         EHrkIkumwJXtC+av6n8Q7j0lZnna5D4/TSLsGy1oTOHinrcZbE4zdIQd3VwGS98itfh/
         Gfgyq+aC9TljZd5YFBYK8hjxkHNcH4N7Tv869nKhgPOixZlzynPtct9Ajj8laGbNopb+
         bP8vOglJgTe7MLwO1KERsl53p0Y0FBP6rS+Up2shlQejDrTnqtwkySpAC9a8g/sciLyj
         rckg==
X-Gm-Message-State: AOJu0YwxSuJHfH1RFQkMXCjMrNNQmiAWZpFXD6WzkEUN/caIQuwmNteb
	UgmT0ojATbsUTArE2jPxlBN1bZgJ4/lDwqXBrD0TkjfKwiHOEd1mDSvV
X-Gm-Gg: AeBDiesGV0MU6anAbLKgSclPyI3gdDZFtYmOYV/1uxt1oxCU5KBHhRWoQQ1guVunHvP
	sHxCJB2nupzqBfayepHs8D/nx7MPlzYWGo7Ts/tx69vgGp/8IVCkjzlSUlq+3cUOczSRxjT5dtA
	psVPUSsaYLK8PpiBLfEUr2/JdnwoS/9n2AFM0nJavuMnOIVprx/IoCikBdMkEQxljWEmXy2qanr
	BvbzSmbSEc+NuriBafiqVwDCzCGXFJSJC44rJmcfySTrQuZ1pd09Vr4Q451xHr0bVYsSZSwkgKh
	+X677Wbx7xVZ5hqvcgA94FgAdGdIfA5b9z2p/sXlcYPvEiCBLOZkKgoAUExy2xi40pMKx2UZPFp
	NCOszoFO1pFhYMaelzZvW1fEbscAofvJHBfkK5ObTa3g4rRDwRREdmVUHqDLxw6Z4XKGCC+4tKu
	ftyl6soUXOoQHPL1kXUdbV5l4=
X-Received: by 2002:a05:651c:144a:b0:38b:f0f0:e3f7 with SMTP id 38308e7fff4ca-38ec77f4afbmr20680301fa.7.1776523670642;
        Sat, 18 Apr 2026 07:47:50 -0700 (PDT)
Received: from xeon ([188.163.112.56])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38ecb4f51easm10901001fa.6.2026.04.18.07.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 07:47:49 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/5] misc: apds990x: Drop Vled supply
Date: Sat, 18 Apr 2026 17:47:14 +0300
Message-ID: <20260418144716.132936-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260418144716.132936-1-clamor95@gmail.com>
References: <20260418144716.132936-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to the APDS9900/9901 documentation, this chip has only one
supply, VDD; hence, drop the Vled supply. Additionally, supply has been
set to lowercase for consistency.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/misc/apds990x.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/drivers/misc/apds990x.c b/drivers/misc/apds990x.c
index 742ab331a221..264335b581c1 100644
--- a/drivers/misc/apds990x.c
+++ b/drivers/misc/apds990x.c
@@ -113,7 +113,7 @@ struct apds990x_chip {
 	struct apds990x_platform_data	*pdata;
 	struct i2c_client		*client;
 	struct mutex			mutex; /* avoid parallel access */
-	struct regulator_bulk_data	regs[2];
+	struct regulator		*vdd_supply;
 	wait_queue_head_t		wait;
 
 	int	prox_en;
@@ -179,10 +179,6 @@ static const u8 again[]	= {1, 8, 16, 120}; /* ALS gain steps */
 static const u16 arates_hz[] = {10, 5, 2, 1};
 static const u8 apersis[] = {1, 2, 4, 5};
 
-/* Regulators */
-static const char reg_vcc[] = "Vdd";
-static const char reg_vled[] = "Vled";
-
 static int apds990x_read_byte(struct apds990x_chip *chip, u8 reg, u8 *data)
 {
 	struct i2c_client *client = chip->client;
@@ -597,8 +593,9 @@ static int apds990x_detect(struct apds990x_chip *chip)
 #ifdef CONFIG_PM
 static int apds990x_chip_on(struct apds990x_chip *chip)
 {
-	int err	 = regulator_bulk_enable(ARRAY_SIZE(chip->regs),
-					chip->regs);
+	int err;
+
+	err = regulator_enable(chip->vdd_supply);
 	if (err < 0)
 		return err;
 
@@ -615,7 +612,7 @@ static int apds990x_chip_on(struct apds990x_chip *chip)
 static int apds990x_chip_off(struct apds990x_chip *chip)
 {
 	apds990x_write_byte(chip, APDS990X_ENABLE, APDS990X_EN_DISABLE_ALL);
-	regulator_bulk_disable(ARRAY_SIZE(chip->regs), chip->regs);
+	regulator_disable(chip->vdd_supply);
 	return 0;
 }
 
@@ -1108,14 +1105,12 @@ static int apds990x_probe(struct i2c_client *client)
 	chip->prox_persistence = APDS_DEFAULT_PROX_PERS;
 	chip->prox_continuous_mode = false;
 
-	chip->regs[0].supply = reg_vcc;
-	chip->regs[1].supply = reg_vled;
-
-	err = devm_regulator_bulk_get(dev, ARRAY_SIZE(chip->regs), chip->regs);
-	if (err)
-		return dev_err_probe(dev, err, "failed to get supplies\n");
+	chip->vdd_supply = devm_regulator_get(dev, "vdd");
+	if (IS_ERR(chip->vdd_supply))
+		return dev_err_probe(dev, PTR_ERR(chip->vdd_supply),
+				     "failed to get vdd-supply\n");
 
-	err = regulator_bulk_enable(ARRAY_SIZE(chip->regs), chip->regs);
+	err = regulator_enable(chip->vdd_supply);
 	if (err < 0)
 		return dev_err_probe(dev, err, "cannot enable regulators\n");
 
@@ -1164,7 +1159,7 @@ static int apds990x_probe(struct i2c_client *client)
 error_pm:
 	pm_runtime_disable(dev);
 error_regulator:
-	regulator_bulk_disable(ARRAY_SIZE(chip->regs), chip->regs);
+	regulator_disable(chip->vdd_supply);
 
 	return err;
 }
-- 
2.51.0

