Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D709E28727D
	for <linux-iio@vger.kernel.org>; Thu, 28 May 2026 13:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779976318; cv=none; b=b3+vXo/zwQd2mArJnNtzBtAZ4CBiPk4TnUL00Br/Zd8nGx7KhQCQ0afaXPqwx6M191utgQn9oYnzuHDoanQXZRbl2e+5cE65tQH4gKOCgHrUIeJb4t0ScmKPurD/A2LEQNevkT+NWbPJB2CZMT6NAJjms37sogmD+joavGfegas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779976318; c=relaxed/simple;
	bh=GVDB20doAR1K3eUlSf2alRlQ5pVPpRgTdHeEwbkCl1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DSv5kW4CLNuyvMlBrIRx+T6rh0oEHGwROL5R0kl9jJx+jjto9v55/JvsG/3YTh780jmn6Mv7pM1r3nWBPnfVySsTfSl53mNvcL3TcK8IsY8L/6woLLGNdl4CA0+OUp2ZuPHqPoQII5YamELpTInUdM8Qt9YqUNvDASNgzRm/WJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WM0NCWkf; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WM0NCWkf"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-bd21ffaca79so2343260366b.0
        for <linux-iio@vger.kernel.org>; Thu, 28 May 2026 06:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779976313; x=1780581113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8RF2xk6t5S9a3BXZ1svw/IWrQWbafQA9obLcpKPhSUU=;
        b=WM0NCWkfxxhAP1fs+Vo6mRLqj6NIobz/HNMMMFa+sRnSMxYkv/45NnT4Smn4bmOIVK
         KO+Qpf4eTYFykEuHrLoKOpIqvv11vwJBmKUnX77F9J9UC2x8b+ulhQLf3xdCsy6GMHke
         T1qZTr8x40LTNP3rixwb5g9MQzcMwrrBc1XRv/8DCe57fPbgTH0r+lz48UnUKGNDjknB
         /lNNdYQ3Z1/XyKGFvL8Ms2xg88uTaKaN9pyFuk01JIELKWVVmWgPQkwcHXPRbuxqNPeM
         Ls3k5okZp2MAEviLQbi+G1VIeL9umYlji8BxGasjL94HP5QCOl1qMVIPNzliRQkOZqAE
         wB8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779976313; x=1780581113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8RF2xk6t5S9a3BXZ1svw/IWrQWbafQA9obLcpKPhSUU=;
        b=SGFraocVL+DjFSWMnYnH/FW4qRZLhg8nXtkYrv8nb75wzdDXTAFZ/jRdTITPLicfjF
         i7gunooCt9IxbCdllrmXLpNLUdL2y9+Eaq6vBPGhDm4DawSVJsiDzFJ/x5IZhgQmcIU/
         X84/jTAl75BsvO7WnsCbcVwYQMJR7Dbe+Gn98twAQ9FMjrLeA97h60qRuMBtmkkJ1enW
         wBKtaoKDo2fwgDWDe5YiTuf6Gdv11J3OWSQx1Mztzt92fVJc1nNCLr77yRDJmZpa0Cqb
         078EIJPdNCpH6j1HB+90lvhlSi5LGma8odszJUwey/XY2JoT2h7ejuaOIr+UhjRMn9OE
         n3eA==
X-Forwarded-Encrypted: i=1; AFNElJ9LoCLPOtMFdGHq1da4Bjnu+1eAc7pCzdswvOrGZy+PspBW6T2ORbR9cOnrWHlUtY43o6hr2mE9gic=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx6QWhgclosYQL44oOK5N+nomBMmqvzc4OD4dXjAJeSSLc97S8
	W4W3LVyCHWl2wcutznDzImwl0uwh6p6X2M/fcAfxxlg/qEu4LaOdAwUG7iBsKQ==
X-Gm-Gg: Acq92OHIve9P4IfH3HCeg6jMTrZ1mcMJ6rwt00+fsiXgUfMqdtEajeGe2HcMKnt2Ijt
	DPxuyEAV+RQSFhys3ZQh/MNsUAlzMS/OdTxOhj8jyosm9fVC/lenvNpmR8yI7vLkf9u5fQHIakB
	SmXE0V/SOfNSFVdNQ0g7RjDBDQUqD9KbVGcT/6sqgLKxPfS8zeE2U1ejLA4BujNdMJhuT6w9p4T
	kxxtLXlioL1y1Hzudj4IVVnrIz2TMKuPWLw4v9ipr7St001XLypOzDS76Mm6laioFK7Bpn/2yjM
	xIITlcDxjiun0gaUeLGRUsJL6Ud1RJ6mAIaPB/Qg6/4AF+Xq4/UV8st3MeOgnyqJv7QXsdyawYJ
	u4ZHS0l3DenacnOVuS8iRokrMg8+/1DXRfMowH4+1RgblHUgB2IPVgU2FbPSelzuJwGMlSONC4q
	gqwEbE63QYnb6lkbbd7LlbU57pbbzJTMPaVg==
X-Received: by 2002:a17:907:1b06:b0:bd5:b27:c02e with SMTP id a640c23a62f3a-be86d71c01amr114017466b.6.1779976313029;
        Thu, 28 May 2026 06:51:53 -0700 (PDT)
Received: from xeon ([188.163.112.61])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bddc65da3bbsm723636566b.52.2026.05.28.06.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 06:51:52 -0700 (PDT)
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
Subject: [PATCH v2 3/6] mfd: lm3533: Add support for VIN power supply
Date: Thu, 28 May 2026 16:51:20 +0300
Message-ID: <20260528135123.103745-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260528135123.103745-1-clamor95@gmail.com>
References: <20260528135123.103745-1-clamor95@gmail.com>
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
index 8495e9119871..519f8c16a3f3 100644
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
@@ -164,14 +165,25 @@ static int lm3533_set_lvled_config(struct lm3533 *lm3533, u8 lvled, u8 led)
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
@@ -324,7 +336,9 @@ static int lm3533_device_init(struct lm3533 *lm3533)
 	u32 count = 0, reg;
 	int ret;
 
-	lm3533_enable(lm3533);
+	ret = lm3533_enable(lm3533);
+	if (ret)
+		return ret;
 
 	device_for_each_child_node_scoped(lm3533->dev, child) {
 		if (!fwnode_device_is_available(child))
@@ -493,6 +507,11 @@ static int lm3533_i2c_probe(struct i2c_client *i2c)
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
index 3aa962d4c747..d751773fc92d 100644
--- a/include/linux/mfd/lm3533.h
+++ b/include/linux/mfd/lm3533.h
@@ -21,6 +21,7 @@
 struct device;
 struct gpio_desc;
 struct regmap;
+struct regulator;
 
 struct lm3533 {
 	struct device *dev;
@@ -28,6 +29,7 @@ struct lm3533 {
 	struct regmap *regmap;
 
 	struct gpio_desc *hwen;
+	struct regulator *vin_supply;
 
 	u32 boost_ovp;
 	u32 boost_freq;
-- 
2.51.0

