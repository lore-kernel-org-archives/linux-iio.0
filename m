Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2643FD960
	for <linux-iio@vger.kernel.org>; Fri, 31 Jul 2026 11:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785497838; cv=none; b=W3trRzbP9+F7+/fpE+IN+JFn8MK07AqZtaEce1e81eCwyTbsWHxzORKnvRM32gixA0FAs6CBrMkVmSosezoSQall4SfzZheQyec+X1rq+Whvmiy0XIbM6kvhDTtKKJ0m1qGsERldHS0qfwxhn0lw2Ltgftn4r4zxXzb5+xubi/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785497838; c=relaxed/simple;
	bh=Fsi9naHLvq24ntJl8U1aGARdwDxfue5n7pfYhUOdjEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BaE5qvLyYVFqY2QXeKqlQm6SSJhv1EFXEH4ZfDCtY6G9H7gYNPVamOT4uwZwaJn4nA8yAOvtEyzfJpreg6HDhtWF8pSdcND6ce4dLxxHEMeFsDauswuCWf5Ge3JBi0ql5b2cYMAPS1b018hVPga4Zc8kgEdspjCXitmPDeqzPNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A95vPldS; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A95vPldS"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c1677c91969so103016466b.1
        for <linux-iio@vger.kernel.org>; Fri, 31 Jul 2026 04:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785497832; x=1786102632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HoJ5QEzgIc1R//Ldk+eAj0/fHRhzYHI0+TPDQsoclNc=;
        b=A95vPldSdrEKSwrXHx+iMhHhdBfisS9tpnWPOflxrJLJZIPH0r1wtS2TDjDMg+Ult+
         v7rOWz9LKBtts4zSX0o1BOouk7Kx8qlwxWXE3Fx/m89bkEUQ6g+bXcRozJh54J4hMv0v
         HCS5PlrQ24CWu2VyyG74Jp8g1Y66adoBx8Kucuvw32CAxqufcywm6cvz90PSDn1t+ri8
         qfhgA6y7QfkwLXGuQpCpNsCqpKBdd1ECEuY6F/nYmcny9urYKRMJ6D/WMG5+bfoZPegD
         Qi9wfHv1sVRvB7LGjQP9kciplQisaj8FosdMrlueI6B+Dh7WkcUBfFj+dWSSCxN4h5iA
         ZYZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785497832; x=1786102632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HoJ5QEzgIc1R//Ldk+eAj0/fHRhzYHI0+TPDQsoclNc=;
        b=AB3t45Nii5qDDVBtde+gr/nn5KqE6cxVxc/OzgueUL1KfmO3TgjQrDXTWdwdiTmK/6
         IpxEvo/3StQhq7SysopCtUbeJboAuzA5+gZCgVq6YFqJgjUtIvZTsQGLbVmHC6FAq4X9
         8rVdjwsVY2vJcmi9l4CRm26fZSGvOCqGl4utfEWnr5Sz57h90UZzN6Y/w3pO97dIIbwM
         z7e6YSHvE5COpBUi4NhOkBCgmh2Ojt5dLMuU4e4kuYcdg2L4rtpssyudmiRxhPOfYeQC
         LWpF5fEknuTRe7cYbKftHAY78yXoecmmwmGAFtjZBYczaGFVXfHCMojupQS8C1Dpyn0H
         gxyg==
X-Forwarded-Encrypted: i=1; AHgh+RoqlxI5f3P+a/KLbm6uzLv8wuGE4KrEMNac5kHvQN/kcKuJ2wcsXLutcKcLukLR5Ri/Ph4hXS1q9OI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOYTj7CvqOwiaS23zrn6wrVcIaJzR6Dx+WaVb426IvHrmNQfM7
	M2NR+W41X0k21i6tczMePlwQXMgGbhjAezYv/CC/cSVwnwzaX/sbi/cw
X-Gm-Gg: AR+sD12S9wq3nLMEEVkSjG2tZeHnhE4gl3AkLurVuDwBI88WTKvcxqR5glv7/1qiOsz
	/OC17+j4oNJJw9/65MEF46TfZRN8JoGTfjdRZKr4JKzhV7SB4RdriJklYOho5uK7fMxSvsAimSz
	FyXNbMBZ0lq/RavvBvNb3PO3piPsCcoc3b7B9Bt9O4mt/jZRpC3R9wM2IqHsiVO2hHYs7rHfEE0
	aBDKY4vTf689vSMMTHKwalx1aufUpAXGkuuBBUSvQ7vficd0OerKyp0qhco8XuXBfQq08uGXYCD
	NT8xiucxqsYKhn8fF/G3GiPw9tfVz0fDx4IWidJKEBl+KWZSBlMrGBw4tcFeFyfB2/cXO/Zx8GD
	teOCfnU26CHc93VUreibztNtYwA4knTjtrHzLyrkp556jjBHytWa2wqTHtGgXk6rTG+CLi+ClTC
	u1DreZ912rzys4SEXthBkDP6iFXcrzOQRcXPSzmXLARS1YdAkaum8zxSKko8xbqa7kaNK0nrhvn
	V5CGi/bYw==
X-Received: by 2002:a17:907:c78e:b0:c12:7934:52fd with SMTP id a640c23a62f3a-c1fd250eeb8mr91901366b.32.1785497831684;
        Fri, 31 Jul 2026 04:37:11 -0700 (PDT)
Received: from xeon ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd45a0c8bsm3670646f8f.34.2026.07.31.04.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 04:37:10 -0700 (PDT)
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
	mfd@lists.linux.dev,
	linux-fbdev@vger.kernel.org
Subject: [PATCH v6 09/14] mfd: lm3533: Add support for VIN power supply
Date: Fri, 31 Jul 2026 14:36:27 +0300
Message-ID: <20260731113632.158440-10-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260731113632.158440-1-clamor95@gmail.com>
References: <20260731113632.158440-1-clamor95@gmail.com>
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
index c7c7e71719ae0..2a63df034171e 100644
--- a/drivers/mfd/lm3533-core.c
+++ b/drivers/mfd/lm3533-core.c
@@ -17,6 +17,7 @@
 #include <linux/mfd/core.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
@@ -111,14 +112,25 @@ static int lm3533_set_lvled_config(struct lm3533 *lm3533, u8 lvled, u8 led)
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
@@ -446,6 +460,11 @@ static int lm3533_i2c_probe(struct i2c_client *i2c)
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
index 5710e88da45d2..8f72dd41e8f02 100644
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

