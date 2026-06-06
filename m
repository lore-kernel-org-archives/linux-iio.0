Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443BD30DD1F
	for <linux-iio@vger.kernel.org>; Sat,  6 Jun 2026 04:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780721914; cv=none; b=JegXCcPlLQ64+vo5HM/GIY0mGK9O84Hkcn1kIeUICCxgObOVGEb1zc9rMQejuVShHaaBENIPqkpFcCxd4Ddz9Q7gU7ZRVqEmxmYiSTCDU2VdPWxGMSkQIWLC5Gof8fZweOMMPZXvsnQcb5lYhUCmx6IEBH1K+mp1ppNX286y840=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780721914; c=relaxed/simple;
	bh=1nFZau3RQUxnCZgOYDCBt3epgx5xe5YIlqUb8E8u0UM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lBjCYIeh1HrK+L2YTacfsMmrH/BNo8o1duXCGp2RboItNh+d79oOuXbtT92mKwFYvqckxVsX4IpLIjdT8hrALYekdplVwWPW7/MPYT1mTAkchptrGoPswji40fjxAXXZOcWOCh5X1HJbqhuZqvNb+NDWxypdgY4JnBUucD+vWiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MeuMLo6d; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MeuMLo6d"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-bf1cdcfd6deso294138866b.3
        for <linux-iio@vger.kernel.org>; Fri, 05 Jun 2026 21:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780721912; x=1781326712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RlI5mUz8s798lOZfnX8f9JGZtNvnkftPBfqwbzzNVuw=;
        b=MeuMLo6ddRVm4igBW3Yn2OS7xsV+kQTx3p48MhwdrnG77458i4pHAqhN6OK2U1I5c0
         iQPBtpxS/+vZX8/eMqS0fv0LAGGXQVdHzaObof2MDhEnYB4C4gY1zJP2NrqXq4QCuvJ9
         3lyivExzhuIbC58zbI/2pV91uiunbu+avjuZ1oJoa7hrJL5tMSCs8LuMAmmPKu8KPe9a
         ekgkxNrfhoAn6pm/CZ513lgWxyA/RbFh2aBcLMVUxBXYx5O2YSJnYKWkKlL1D3ZnwVqS
         Izd8MJGGAyuGsvOg5RRk3yEiPaXi8TWJBMINw3HQHGzuisu+mwEDGqY/UJQLFtY0L5+Y
         cDTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780721912; x=1781326712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RlI5mUz8s798lOZfnX8f9JGZtNvnkftPBfqwbzzNVuw=;
        b=KkZnWLbJV+n+SXnD24r+w6OsSdZW9FjVebF7xDU+1Td6P5G+xlVr7c9geYRhU9KgB/
         HI67c7nHRy6C/2pLASNgo0//v7KvoJRr8Mr3rKd7/MHM6MNDxw1dYl/aE+jR3LrbHzlB
         tQ7g3QgM1e68MbAZ4ipzVjI3EODwqntb4vER/I4sBNIKD7G1DbVAi0K3A53bUTf3RNWH
         jy46Yd2czBkgF6EcEuEv8RcEt7QQ8puePhp4RMzDHe3DQRKKDTSPzu3OX9nlRUw43eVd
         Jv0gz5Iw7AApsJBYQc8vgX9XtqHj7p8L85H7nO9sgv0FYlT0fWy9hQrmiqoYbIr8pX5n
         w2Gg==
X-Forwarded-Encrypted: i=1; AFNElJ9HFut2ijB28JSjamlL1VI2pcDN78jJ+mksAcmfxX/HQAmXIIi8mmkn+N6jEhUycFHpUkfIqA/U+JQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb8hzVzP5VeZ4/sc+GiaE29QGsKSIquyUW8tPhKAPElOXUKJgi
	EiZmtcpVUYMtBC81P1MQXeE7CJhrb6o3OazabxEhFYdcWraaST/lS5sM
X-Gm-Gg: Acq92OEp0T5oce4Sq2u1tvQejMaQDonGTIof2uRzfNGePemmPU9t0FSQ5SoaK2Q4X3N
	nGDLguqyLQ7H9tQpPOD3T2pZIo9rGQLyqjJ/DcLLxSwYWcFPuw4L8BpE6I0qbYjuKxwo0wPNsie
	+CHj/IYbx88lROIgEJ1hIdULqMGSVhlU3OiGXlRF8Q3kXORhmQSP+b1f96+8p5cEH+zwtrZEjtk
	0WsFPfZ6/Z7JLHgmnMvh2U02HnsDSX9EJ0SevNXz+KwPy3uODdW7TuV0OaBjKCkg65lcKOup6CE
	3mcgyNkPDG00E/ABhA9lVEICKn7t4DRLdUf4YMn1fPpWXUitQH61SeHmjCAX0/PYN+ddCxnYu9L
	TFB2G33HzlfUEtawRQlJjC7l7koopx7O/0OyEC5Tkr4zM8MCgVYNMQF1yrbkuw1zVADKeixgzLC
	miqqKSYuEvLELtSrk22aPK85Y=
X-Received: by 2002:a17:907:c247:b0:bed:6e53:bb16 with SMTP id a640c23a62f3a-bf3743e5c7dmr350247866b.43.1780721911635;
        Fri, 05 Jun 2026 21:58:31 -0700 (PDT)
Received: from xeon ([188.163.112.61])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf054e086fesm570597166b.32.2026.06.05.21.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 21:58:30 -0700 (PDT)
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
Subject: [PATCH v4 09/14] mfd: lm3533: Add support for VIN power supply
Date: Sat,  6 Jun 2026 07:57:33 +0300
Message-ID: <20260606045738.21050-10-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260606045738.21050-1-clamor95@gmail.com>
References: <20260606045738.21050-1-clamor95@gmail.com>
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
index 5af1d5476d3e..500cec3cceba 100644
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
@@ -332,7 +344,9 @@ static int lm3533_device_init(struct lm3533 *lm3533)
 		}
 	}
 
-	lm3533_enable(lm3533);
+	ret = lm3533_enable(lm3533);
+	if (ret)
+		return ret;
 
 	ret = regmap_update_bits(lm3533->regmap, LM3533_REG_BOOST_PWM,
 				 LM3533_BOOST_FREQ_MASK,
@@ -456,6 +470,11 @@ static int lm3533_i2c_probe(struct i2c_client *i2c)
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
index d3f7b07dbefc..3f9f4c9ef9f3 100644
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

