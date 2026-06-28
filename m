Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7DE36492A
	for <linux-iio@vger.kernel.org>; Sun, 28 Jun 2026 05:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782624998; cv=none; b=A1ptYhRkkDuRo920E6LDTSJa9j8V0NisfLFZj6dsk11d4Nc2DdqmQUr7eOoJZjOi6WizNJSBnDGuRNNBuD7ezdDV9yISjyruW+09nctQJ8PC4wg6AuXyrokDbtuG2Xlys0B6KpoTRYH+G5Nyne39OYRRxm41CztKEpLK5ut+ZcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782624998; c=relaxed/simple;
	bh=phGDKF/7ypWNAiTnvOwLVxua6NDi5KzvTxXMTomI5HA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DJX3SvDDZ/VzYDjgiHlZO9Rzww9KlIWH6OwohLpPzjvG3v8JDN3dV69o6PSwB78u72KXVXDMxQIsjLJ/5bmt2wmlULQ6wb6b83Z8/qvrXKcofxpXOCi6VG/UTQ/J+upSkUKnHQUzNUaBgMRv9uykN5zB1kB07BhXMHhBsjnpb1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r2cMMret; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r2cMMret"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-59d7db12342so999383e0c.0
        for <linux-iio@vger.kernel.org>; Sat, 27 Jun 2026 22:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782624994; x=1783229794; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z+yvCkodc+lVFLhFvxRIhqebis/f5gugGjsomvu2gcg=;
        b=r2cMMrettXu4ro01JOVLy6LnbpCt6pG1fKpTR9FgYxRiWgcOTjkbqyKqn0rYmAk2lc
         D9qgCpPg35xVW8dZUt5lPAmKPjAWGZdMo01+0JOYOd69QVu/hsZe9eZcNdYXTigKfeiY
         hW9d/U4/6UP7Z5n9BxoiTgDE/2rs/3WwiycujpoiFWU0NwrtSxN00DjuySLtWZXCkzl5
         EDaKgU/eKu1GF49PlSpE/YymVcPvSvzAOO10nhfznW+TQ4k4d0ApwKJYCT6Fc7izt4ck
         mQie3PPJ87a50ILcq6fgtYPGdsECAuBugZrxHTQ59Eru5St2JPFg74lSUWLVg41wMQel
         Tw8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782624994; x=1783229794;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Z+yvCkodc+lVFLhFvxRIhqebis/f5gugGjsomvu2gcg=;
        b=WfZR4kb66RfNEkSvehB1ysVKyXaoCroXXNwAikJvFIFwY32WQSZxJLiUNV4kFyZ79h
         /adgT9gbIc7y3meUx32kxjQj4fAyaZZRnVl+NZHYw03eLkZFqS8XVieqoAl2tBNSJplE
         RTDK5cOpWxLvofxwp27gvW+VYnpSoN05r1jBybsOZI/dlpW43vaA8Jyr9m8PbclSqHIu
         eHreaQ7C+fKSvOoVEFZcJAFa0v8emmsFHx75c2Cfqcbpdd6PbrK/tJknDDlTdUKbipng
         Ym37KCJ2ixzVuRS27c3R6s3wGjEfki/NZo9d+cQo1kjfQyq+9piLhF5Kvh3bfYgbce5v
         gvGw==
X-Forwarded-Encrypted: i=1; AHgh+RqYPBY76BVF/tATYiF5YyaXUFBRex/07IFMRpacs1a+SWXU5ZrDHHhb+m1Frv3Q4bFPiq2SG1LSxsc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN3DmkKcPtB+zYHyV8ShFS5shmQV4K/l5HTWD9B337iHgi6NMk
	8oFg/pQ+WczlGRizmohIeHhLjZEDDnQzU5X0C1wEpvzEvMAJLvVfGbWK
X-Gm-Gg: AfdE7cl4xhVnYZ2XS+YibderNZTvxRrtPxLBFayKt+vkRdDw1sn2Tipeabd+ObHbAzL
	nHpUIdMR8+IYDKkw6zwVt/CziroE6MpAEjIovcU1o4Od13mPPTfVpGDMpyElItqDYP43X+tTyQi
	PnvbGsuGhkNwJBw8cMQanKEUL753MHU/O/42s1rb+ThV2kMTDmLQculyvo0noB/+d1y1urxYs3n
	h+dleDQCJop1Sl4BnLgnvfOwzncsG4s6g5TT4uwWwYF97FhARHyE3NT9pH9cnvbGb1DMjQYeCIc
	szet8HjSdnuJueD7INktPOoCo+nmaoLOFwA+saP7iyYI4hb+AyViiOKKzaWIoKBZw8dhqYgDTiK
	su+XOKERiuajD0Otr042tTgyDgEmchMAiTst5YQrSSZyu0zSHE1EJPaaIUHMlakV23PI1jm44yW
	AgFjKF/akMLXbp5Pby
X-Received: by 2002:a05:6122:1d0e:b0:59e:372f:6db9 with SMTP id 71dfb90a1353d-5bd69f5a5bbmr5548366e0c.12.1782624994517;
        Sat, 27 Jun 2026 22:36:34 -0700 (PDT)
Received: from [192.168.100.153] ([2800:bf0:61:1127:ab87:5602:531c:8dfb])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5bda2dd64c3sm229003e0c.1.2026.06.27.22.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 22:36:34 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Date: Sun, 28 Jun 2026 00:36:05 -0500
Subject: [PATCH v2 4/7] iio: adc: ti-ads1262: Add excitation current
 support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260628-ads126x-v2-4-4b1b231325ba@gmail.com>
References: <20260628-ads126x-v2-0-4b1b231325ba@gmail.com>
In-Reply-To: <20260628-ads126x-v2-0-4b1b231325ba@gmail.com>
To: Kurt Borja <kuurtb@gmail.com>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5127; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=phGDKF/7ypWNAiTnvOwLVxua6NDi5KzvTxXMTomI5HA=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDFkOm25sZW3t1VjStOD41IuRci0li1l49UJPXfPVViwx3
 MU5LVS7o5SFQYyLQVZMkaU9YdG3R1F5b/0OhN6HmcPKBDKEgYtTACZSP5OR4fdFE4to7+NzW4yT
 Ct5slTkYr/xnIndWUE7LbI6d62p5UhgZtvU5zI2ddEiKd+ZU01OCrzdU3MvenrG2csbxhV6uUzo
 ecAEA
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Support the two IDAC excitation current sources. Each channel can route
its IDAC1/IDAC2 outputs to a pin via the "excitation-channels" property
and select a magnitude via "excitation-current-nanoamp".

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/iio/adc/ti-ads1262.c | 78 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 76 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1262.c b/drivers/iio/adc/ti-ads1262.c
index ece97a0c2b1304ad..8921eaae537f6b0a 100644
--- a/drivers/iio/adc/ti-ads1262.c
+++ b/drivers/iio/adc/ti-ads1262.c
@@ -193,6 +193,22 @@ enum {
 	ADS1262_INPMUX_LAST
 };
 
+enum {
+	ADS1262_IDACMUX_AIN0,
+	ADS1262_IDACMUX_AIN1,
+	ADS1262_IDACMUX_AIN2,
+	ADS1262_IDACMUX_AIN3,
+	ADS1262_IDACMUX_AIN4,
+	ADS1262_IDACMUX_AIN5,
+	ADS1262_IDACMUX_AIN6,
+	ADS1262_IDACMUX_AIN7,
+	ADS1262_IDACMUX_AIN8,
+	ADS1262_IDACMUX_AIN9,
+	ADS1262_IDACMUX_AINCOM,
+	ADS1262_IDACMUX_NO_CONN,
+	ADS1262_IDACMUX_LAST
+};
+
 enum {
 	ADS1262_REFMUX_INTERNAL,
 	ADS1262_REFMUX_AIN0_AIN1,
@@ -213,6 +229,8 @@ struct ads1262_channel {
 	u8 gain;
 	u8 data_rate;
 	u8 reference[3];
+	u8 idac_mux[2];
+	u8 idac_mag[2];
 	u8 pga_bypass:1;
 	u8 ref_reversal:1;
 	u8 input_chop:1;
@@ -450,7 +468,7 @@ static int ads1262_dev_read_by_cmd(struct ads1262 *st, u8 cmd, __be32 *val)
 static int ads1262_channel_enable(struct ads1262 *st,
 				  struct ads1262_channel *chan)
 {
-	u8 mode0, mode1, mode2, inpmux, refmux;
+	u8 mode0, mode1, mode2, inpmux, idacmux, idacmag, refmux;
 	int ret;
 
 	/* Avoid using guard() here to mitigate AB/BA deadlock warning */
@@ -464,6 +482,10 @@ static int ads1262_channel_enable(struct ads1262 *st,
 		FIELD_PREP(ADS1262_MODE2_BYPASS_MASK, chan->pga_bypass);
 	inpmux = FIELD_PREP(ADS1262_INPMUX_MUXN_MASK, chan->input[1]) |
 		 FIELD_PREP(ADS1262_INPMUX_MUXP_MASK, chan->input[0]);
+	idacmux = FIELD_PREP(ADS1262_IDACMUX_MUX1_MASK, chan->idac_mux[0]) |
+		  FIELD_PREP(ADS1262_IDACMUX_MUX2_MASK, chan->idac_mux[1]);
+	idacmag = FIELD_PREP(ADS1262_IDACMAG_MAG1_MASK, chan->idac_mag[0]) |
+		  FIELD_PREP(ADS1262_IDACMAG_MAG2_MASK, chan->idac_mag[1]);
 	refmux = FIELD_PREP(ADS1262_REFMUX_RMUXN_MASK, chan->reference[1]) |
 		 FIELD_PREP(ADS1262_REFMUX_RMUXP_MASK, chan->reference[0]);
 	mutex_unlock(&st->chan_lock);
@@ -493,6 +515,18 @@ static int ads1262_channel_enable(struct ads1262 *st,
 	if (ret)
 		return ret;
 
+	ret = regmap_update_bits(st->regmap, ADS1262_IDACMUX_REG,
+				 ADS1262_IDACMUX_MUX1_MASK |
+				 ADS1262_IDACMUX_MUX2_MASK, idacmux);
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(st->regmap, ADS1262_IDACMAG_REG,
+				 ADS1262_IDACMAG_MAG1_MASK |
+				 ADS1262_IDACMAG_MAG2_MASK, idacmag);
+	if (ret)
+		return ret;
+
 	return regmap_update_bits(st->regmap, ADS1262_REFMUX_REG,
 				  ADS1262_REFMUX_RMUXN_MASK |
 				  ADS1262_REFMUX_RMUXP_MASK, refmux);
@@ -1040,13 +1074,19 @@ static int ads1262_parse_channel_node(struct ads1262 *st,
 				      struct fwnode_handle *node)
 {
 	struct device *dev = &st->spi->dev;
+	static const u32 idac_nA[] = {
+		0, 50000, 100000, 250000, 500000, 750000,
+		1000000, 1500000, 2000000, 2500000, 3000000
+	};
 	const char *ref_sources[3] = {};
-	u32 pins[2];
+	u32 pins[2], mags[2];
 	int ret;
 
 	/* Write non-zero default configuration values */
 	chan->filter = ADS1262_FILTER_FIR;
 	chan->data_rate = ADS1262_DR_20_SPS;
+	chan->idac_mux[0] = ADS1262_IDACMUX_NO_CONN;
+	chan->idac_mux[1] = ADS1262_IDACMUX_NO_CONN;
 
 	ret = fwnode_property_read_u32_array(node, "diff-channels", pins, ARRAY_SIZE(pins));
 	if (ret)
@@ -1086,6 +1126,40 @@ static int ads1262_parse_channel_node(struct ads1262 *st,
 		}
 	}
 
+	if (fwnode_property_present(node, "excitation-channels")) {
+		ret = fwnode_property_read_u32_array(node, "excitation-channels",
+						     pins, ARRAY_SIZE(pins));
+		if (ret)
+			return dev_err_probe(dev, ret, "%s: Failed to read excitation-channels\n",
+					     fwnode_get_name(node));
+		if (pins[0] >= ADS1262_IDACMUX_LAST || pins[1] >= ADS1262_IDACMUX_LAST)
+			return dev_err_probe(dev, -EINVAL, "%s: excitation-channels not in range\n",
+					     fwnode_get_name(node));
+		chan->idac_mux[0] = pins[0];
+		chan->idac_mux[1] = pins[1];
+
+		ret = fwnode_property_read_u32_array(node, "excitation-current-nanoamp",
+						     mags, ARRAY_SIZE(mags));
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "%s: Failed to read excitation-current-nanoamp\n",
+					     fwnode_get_name(node));
+
+		ret = ads1262_find_one(idac_nA, mags[0]);
+		if (ret < 0)
+			return dev_err_probe(dev, ret,
+					     "%s: Invalid excitation-current-nanoamp\n",
+					     fwnode_get_name(node));
+		chan->idac_mag[0] = ret;
+
+		ret = ads1262_find_one(idac_nA, mags[1]);
+		if (ret < 0)
+			return dev_err_probe(dev, ret,
+					     "%s: Invalid excitation-current-nanoamp\n",
+					     fwnode_get_name(node));
+		chan->idac_mag[1] = ret;
+	}
+
 	if (fwnode_property_present(node, "ti,pga-bypass"))
 		chan->pga_bypass = 1;
 

-- 
2.54.0

