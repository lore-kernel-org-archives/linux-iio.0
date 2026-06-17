Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342A43D331A
	for <linux-iio@vger.kernel.org>; Wed, 17 Jun 2026 08:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781683268; cv=none; b=UViCouHiLGSpXI2RBcGzuKgZy1ZW7Kt7sZJo7GJ8+3cxx8E+5Pt3D4YQPuWp66YisRsgoyDs7xnxt2b8RmYk22uFYY4lYL1+mleGjwJ14aFDCcjU3QS0XIlY/kPlLrjyQh8CK/OEQPvmWBUjFxKW+7z5r7Ye3+jy0arwot58l/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781683268; c=relaxed/simple;
	bh=4WjmiWfFTCp+1bBNDrcHv5gGqTRg8YPvmqnJ/PwH9+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SZCKlZo/QQPf5wqrZ6UaOFSfpFhkCAJbivjNcD14u5cLqEEKZCPkqeNoaRCaXpIp9f1UIiME6j7TmEpZvesw5Iaba4ZD/UoTCwDQf2p1D0hpVKh39gLq2JLTcuuRQnURiC1+C9xSsG9j2/NvLy7Su90jp0g3uvA6u1/66yOClBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HVF+bSHq; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HVF+bSHq"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c03a466c96aso458909566b.3
        for <linux-iio@vger.kernel.org>; Wed, 17 Jun 2026 01:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781683256; x=1782288056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bDbkv4yENGcso8lbBuowMRR6EhhW3sM2nEWvZfEX0tI=;
        b=HVF+bSHqNdQvwqLcn9tqAERPwc90kPjvY1ZlbO9x4CEynUEdYqSkotKSHBTysqh1xa
         f0Nz9C1tt9TuXyQ0YZ13rtHlKkt2q23ZE22a0rO1zvJTB0ecXWc6xyp5tIu6Ju9YRBW3
         4U+gjnfRkDhoYlipuhzNKy6NfC+UXWTaWKzhknJeV4Atb5dU8wHDWScavvsAzrZ05stY
         F/SwjhQ+AX4yLCqOeHfW+ml3x+Lq8gz5WrV1eHpVV7iWuK2yn+nSwW2HrRGoj3XNT4pF
         K0/ltZ+jBPHoG8OIpo3bYyIMmjVqezRifhdb5Q6pLRk74EOfwjw1NS4lmoogwi6+jkWS
         88Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781683256; x=1782288056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bDbkv4yENGcso8lbBuowMRR6EhhW3sM2nEWvZfEX0tI=;
        b=n7jM+12iAlllRUR12wP0wr/LIiC+8IP6/MLD/UVhBCCHrejKIF3tA5BE5tE6Vy53hS
         UMYWr8IUbG6FYhdjayX1Sk1LJE2ZFyJz4WLHTShdz96KPY8tVX63mAdnHo+gkeMtvBDe
         bflvLjn0wezfMt5b8rPFTaIUkgAQjzvTG8wkPhYgErTt3YVyGpauJK6pEwxyeejrCnzE
         dY+zVZxLIZgA8zqx/7fyI/VilWsO6iyOwEAXFYliPeX3I+RWIgAseM8LbRCd9CUbGaou
         LQQB+LSM70KGMZj/gaWSak4AvMqOQxxBNDxLYIJLtELE7bM1LJkRgr/5jFmgJ4I5YtgM
         A/Ag==
X-Forwarded-Encrypted: i=1; AFNElJ9tG3NURPk+tMe9jNnYEBRCnIAcRG9lw0s7frdf+6p4TAAUvi8cjUrldgQt1Ktw6ewE7RC1ZvL84Ls=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTgxSsOpwSjnEHdg03F3D5umqi/lTHHwkZwqkEH7LRo8XsNMeC
	KnXQuLP+O8J/zzxosxw++qSJG1NI1tfzF1GGgwbkaZyNYU37beiYVxKN
X-Gm-Gg: Acq92OEuvUr/x1a9IVo2n/FQa2nrWFq6xY11sxbzwIjXgXzhWLmbgrtXw9NYd4dvRRV
	dlIct5qZiLNM5dNDMWC/lkpcW/tzIIfzpj2z85vC98ZQWTyXW6dzqSQUte1O/+qxFT+0TKTJo8z
	pnCitqbOpmYq76ukuwQMMpJx8QxkPI7izCOeyPA7xgtTiiY17JUPgNx0U9ZEHnBMKmh1ftD/M6C
	WXv0I9kVQg/MegER3SuHvR8aTQvKAYiCnlyV+GjT0At/R6pLXPHAVZ460kHGVfxq0clJQ6/ir0l
	cQymqBHowBwYHcAOmJMlQmTbOTwpaXtEsT+g9QRRyHFosJQMwZjCtVnG3njA7CYmy/IV565UJ6d
	cCnMyn+3TAdnAj77BUUqNbSdIRPqQiK/IBueXxzI6d1Nv7vqfsCEBSZ+BI7KznmC6O84Z9+fV9a
	4v8i14UrxxRhYw
X-Received: by 2002:a17:907:94d6:b0:bec:b4e3:e930 with SMTP id a640c23a62f3a-c05a511f1ccmr158862466b.12.1781683255042;
        Wed, 17 Jun 2026 01:00:55 -0700 (PDT)
Received: from xeon ([188.163.112.61])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfdb058fa59sm755339766b.0.2026.06.17.01.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 01:00:54 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Helge Deller <deller@gmx.de>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Johan Hovold <johan@kernel.org>,
	dri-devel@lists.freedesktop.org,
	linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-fbdev@vger.kernel.org
Subject: [PATCH v5 09/14] mfd: lm3533: Add support for VIN power supply
Date: Wed, 17 Jun 2026 11:00:26 +0300
Message-ID: <20260617080031.99156-10-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260617080031.99156-1-clamor95@gmail.com>
References: <20260617080031.99156-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for 2.7V-5.5V VIN power supply.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/mfd/lm3533-core.c  | 23 +++++++++++++++++++++--
 include/linux/mfd/lm3533.h |  2 ++
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/lm3533-core.c b/drivers/mfd/lm3533-core.c
index a5aa7da9668b..4b5d94e9ed27 100644
--- a/drivers/mfd/lm3533-core.c
+++ b/drivers/mfd/lm3533-core.c
@@ -17,6 +17,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
@@ -113,14 +114,25 @@ static int lm3533_set_lvled_config(struct lm3533 *lm3533, u8 lvled, u8 led)
 	return ret;
 }
 
-static void lm3533_enable(struct lm3533 *lm3533)
+static int lm3533_enable(struct lm3533 *lm3533)
 {
+	int ret;
+
+	ret = regulator_enable(lm3533->vin_supply);
+	if (ret) {
+		dev_err(lm3533->dev, "failed to enable vin power supply\n");
+		return ret;
+	}
+
 	gpiod_set_value(lm3533->hwen, 1);
+
+	return 0;
 }
 
 static void lm3533_disable(struct lm3533 *lm3533)
 {
 	gpiod_set_value(lm3533->hwen, 0);
+	regulator_disable(lm3533->vin_supply);
 }
 
 enum lm3533_attribute_type {
@@ -333,7 +345,9 @@ static int lm3533_device_init(struct lm3533 *lm3533)
 		}
 	}
 
-	lm3533_enable(lm3533);
+	ret = lm3533_enable(lm3533);
+	if (ret)
+		return ret;
 
 	ret = regmap_update_bits(lm3533->regmap, LM3533_REG_BOOST_PWM,
 				 LM3533_BOOST_FREQ_MASK,
@@ -447,6 +461,11 @@ static int lm3533_i2c_probe(struct i2c_client *i2c)
 		return dev_err_probe(lm3533->dev, PTR_ERR(lm3533->hwen),
 				     "failed to get HWEN GPIO\n");
 
+	lm3533->vin_supply = devm_regulator_get(lm3533->dev, "vin");
+	if (IS_ERR(lm3533->vin_supply))
+		return dev_err_probe(lm3533->dev, PTR_ERR(lm3533->vin_supply),
+				     "failed to get vin-supply\n");
+
 	device_property_read_u32(lm3533->dev, "ti,boost-ovp-microvolt",
 				 &lm3533->boost_ovp);
 
diff --git a/include/linux/mfd/lm3533.h b/include/linux/mfd/lm3533.h
index 5710e88da45d..8f72dd41e8f0 100644
--- a/include/linux/mfd/lm3533.h
+++ b/include/linux/mfd/lm3533.h
@@ -22,6 +22,7 @@
 struct device;
 struct gpio_desc;
 struct regmap;
+struct regulator;
 
 struct lm3533 {
 	struct device *dev;
@@ -29,6 +30,7 @@ struct lm3533 {
 	struct regmap *regmap;
 
 	struct gpio_desc *hwen;
+	struct regulator *vin_supply;
 
 	u32 boost_ovp;
 	u32 boost_freq;
-- 
2.53.0

