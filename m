Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70F03BBFC8
	for <linux-iio@vger.kernel.org>; Sat,  8 Aug 2026 03:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786161544; cv=none; b=Yq4B1kMuS1zrh0L/5Qj6/kRBHfiz5MbRHLwVGmbm17C5QSHkIt1FSuN5OmYfenFbvfmVqU7qCdRYn/lXFplkCkSDRsdYRQ4njL/9AR/6TrTVlj7ah3Q6L2yiY/huughIcMtYoTsL66A7DlYhfQRjZwj7ybdwFknsTFGL4BK2DWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786161544; c=relaxed/simple;
	bh=bIpvMMa4U2CGo++dRegyRF9eL9wseA8Sf0kiZsyR1Ek=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bfV23vNq0xfcZKatwyc/Mq5fzqcq3C3mTg0yUQuq74oWJk2AtQSv+4IYVY/0AbhAHAlbqxLivIq7rE9mGhBkZeRsdCKx8in1K9V/yuYjQsxDfi1LKKTNuzIbKhdwQFhukJe74EhjnD6yf7S5MHcWI4/9sJowpMWWA2Jt7kUn7xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LMyBInlY; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LMyBInlY"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5bf83925ddaso59882e0c.1
        for <linux-iio@vger.kernel.org>; Fri, 07 Aug 2026 20:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786161541; x=1786766341; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JHoYBqcl+n61cEQGO8t2siDqeVUfdNDd2mseqU1bHQo=;
        b=LMyBInlYZzXgybyjvo8UPKRjmPKYUGn40DvA9nrdbXLgwvOX8vDIkBS9Cbo5p5/4Q3
         MEifOjiRqUrR+yXvBSxCMzOQFF//0zkA3bqg4sJ1yyq/9JWXlq31IWedwJ3kfGkPuvXl
         cMJLtOkGVhQvkQb/Rsvt2ZHaJUxtruYV+uOQv7PC9VsxSlv0AT4ZrKrtpdDZlNZx8sC3
         HzNM38c/d48kCGNGYlBaOiy8MdBpuc3tSUKnVoRb793z7kC3yuIdrfk5di+DxR/xJX4U
         bmVfRXa1M1dznyCaVuNBkwsubQ7PG2RdtiHWCHk/L8AFioT+4BTQLpznkgvDgXKvZluw
         IIvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786161541; x=1786766341;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JHoYBqcl+n61cEQGO8t2siDqeVUfdNDd2mseqU1bHQo=;
        b=o7DKLXMewCsFU88tqdUC89wNtnjqiW4WacGk1Xulj8dj2ziPBImnedhU02Y09J0pI3
         k2FVR0ErfDRRyAj2O8lh1w6qm8O/7ir6X0HyUwEpPFIltE0+xiZ47GK1h7/zeXbKDnFi
         6zzolq9H4aiRuM5Zr96UcI1ee+b6GpmDn1zO/aPXpCFJL63EUYH0Rzn/gPN15x1PRMd4
         pSz8U6Os6hvZ7CQDXEJfUL4AzB0LNWEOo5bjy2ZY55eiwH95qRvmymvNmYSaXSae3Lal
         MfFrTQn0StibOnFwktGQvLcKJwI1slpEbuilblle8k0iuDHd+5u8maWTS8sbOUSs0oXW
         UCuQ==
X-Forwarded-Encrypted: i=1; AHgh+RotMd+/yu9m3emYHk21QCxfVYhdP9rDXzaJs3UhH98aWDBMuHgiKkvpulGk4iPEFrFftHCGt9XVEsE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDcCZepLL7f1/6Cd2ag2RnauJZiklYXTmql86AygZzXEqShZVR
	Fx7M2YsW5kSNAWqTeE6rF6MFURH3Q2i4ok1sxZMGEsx3410YLTMBleV1
X-Gm-Gg: AR+sD12fjkKI7MvGRiQ3C7sHlXBEPTSpFV55fJCctVOvfO54Z9n3P81rF5OmBi2KXh2
	5XWNgQo42/a4MBkTslj8JwPFpPwZjFcW+NJt/NIbeXHKkiwZl00vx1S4M4iG+gvQ/GY9ZvtWbsL
	vYvDfb1XGA+gsSAtJ75DmYPLnApauLzGVxeDX6Iz6bq0gaPLKMK7IWAEuTna+zblkYUjnWjjZxc
	idVlr0zqwMKu5YppnYa9iFEJrjZAh8ivVp0ATvzLzIHWTyY4KBNV8pbLalKQd4Q6Q71Xn8I1GpE
	J5/LkWXo/1InEb+ALNiFswSVT6jAhKTqDky7vF7cIsGnIeB8e0lVe/WDilRfmwdrTJaDtSImKke
	55XGtBkqsjzbXkU3N6Nob1W9sacuEklI0Ezps1hP0ujeX2wxCginW2Z136jtFSTldo/vMP3jAEN
	PZSTmMf8bvIBaNalZtveGh0q/nMe4mpBK1qS0hduY5JG565kkfRjrkE7xZSls=
X-Received: by 2002:a05:6102:5108:b0:608:9a34:c8ea with SMTP id ada2fe7eead31-760e9e49872mr6923015137.10.1786161541530;
        Fri, 07 Aug 2026 20:59:01 -0700 (PDT)
Received: from [192.168.100.6] ([2800:bf0:82:11a2:7ac4:1f2:947b:2b6])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c40b212fa6sm1432936e0c.16.2026.08.07.20.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 20:59:01 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Date: Fri, 07 Aug 2026 22:58:28 -0500
Subject: [PATCH v3 6/9] iio: adc: ti-ads1262: support excitation currents
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-ads126x-v3-6-f89925d72792@gmail.com>
References: <20260807-ads126x-v3-0-f89925d72792@gmail.com>
In-Reply-To: <20260807-ads126x-v3-0-f89925d72792@gmail.com>
To: Kurt Borja <kuurtb@gmail.com>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, 
 David Lechner <dlechner@baylibre.com>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6635; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=bIpvMMa4U2CGo++dRegyRF9eL9wseA8Sf0kiZsyR1Ek=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDFllKytuvDb5+MLnwV+ul3VndxxITghzcPhh8LsgvdJFk
 ndra6xXRykLgxgXg6yYIkt7wqJvj6Ly3vodCL0PM4eVCWQIAxenAExkVRvD/+g9v6W2sUW4fbX7
 uoNr1ar/mvY61/TdgxYFtl362JUdcpKRYbvf1P1Lan3c+zsu66tESZQJWTsWbeaM+Z3V48BhWdD
 OCwA=
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Support the two IDAC excitation current sources. Each channel can route
its IDAC1/IDAC2 outputs to a pin via the "excitation-channels" property
and select a magnitude via "excitation-current-nanoamp".

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/iio/adc/ti-ads1262.c | 101 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 98 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1262.c b/drivers/iio/adc/ti-ads1262.c
index e2659941e1af..d5464b4f2bfb 100644
--- a/drivers/iio/adc/ti-ads1262.c
+++ b/drivers/iio/adc/ti-ads1262.c
@@ -98,6 +98,8 @@
 #define     ADS1262_IDACMUX_NO_CONN		0xB
 
 #define ADS1262_IDACMAG_REG			0x0E
+#define   ADS1262_IDACMAG_MAG2_MASK		GENMASK(7, 4)
+#define   ADS1262_IDACMAG_MAG1_MASK		GENMASK(3, 0)
 
 #define ADS1262_REFMUX_REG			0x0F
 #define   ADS1262_REFMUX_RMUXP_MASK		GENMASK(5, 3)
@@ -205,12 +207,15 @@ struct ads1262_chip_info {
 
 struct ads1262_channel {
 	u8 data_rate;
+	u8 idac_mux[2];
+	u8 idac_mag[2];
 	u8 gain;
 	u8 ref_p;
 	u8 ref_n;
 	bool ref_reversal;
 	bool is_resistance;
 	bool input_chop;
+	bool idac_chop;
 	int offset;
 	int scales[6][2];
 	size_t num_scales;
@@ -277,6 +282,25 @@ static const char * const ads1262_ref_sources_neg[] = {
 	NULL
 };
 
+static const u32 ads1262_idac_mags_nA[] = {
+	0, 50000, 100000, 250000, 500000, 750000, 1000000, 1500000, 2000000,
+	2500000, 3000000
+};
+
+static int ads1262_find_one(const int *array, size_t num_elements, int val)
+{
+	int i;
+
+	for (i = 0; i < num_elements; i++) {
+		if (val == array[i])
+			break;
+	}
+	if (i == num_elements)
+		return -EINVAL;
+
+	return i;
+}
+
 static int ads1262_find_two(const int (*array)[2], size_t num_elements, int val,
 			    int val2)
 {
@@ -433,9 +457,11 @@ static int ads1262_channel_enable(struct ads1262 *st,
 	guard(mutex)(&st->chan_lock);
 
 	val = FIELD_PREP(ADS1262_MODE0_INPUT_CHOP_MASK, chan->input_chop) |
+	      FIELD_PREP(ADS1262_MODE0_IDAC_CHOP_MASK, chan->idac_chop) |
 	      FIELD_PREP(ADS1262_MODE0_REFREV_MASK, chan->ref_reversal);
 	ret = regmap_update_bits(st->regmap, ADS1262_MODE0_REG,
 				 ADS1262_MODE0_INPUT_CHOP_MASK |
+				 ADS1262_MODE0_IDAC_CHOP_MASK |
 				 ADS1262_MODE0_REFREV_MASK, val);
 	if (ret)
 		return ret;
@@ -456,6 +482,22 @@ static int ads1262_channel_enable(struct ads1262 *st,
 	if (ret)
 		return ret;
 
+	val = FIELD_PREP(ADS1262_IDACMUX_MUX1_MASK, chan->idac_mux[0]) |
+	      FIELD_PREP(ADS1262_IDACMUX_MUX2_MASK, chan->idac_mux[1]);
+	ret = regmap_update_bits(st->regmap, ADS1262_IDACMUX_REG,
+				 ADS1262_IDACMUX_MUX1_MASK |
+				 ADS1262_IDACMUX_MUX2_MASK, val);
+	if (ret)
+		return ret;
+
+	val = FIELD_PREP(ADS1262_IDACMAG_MAG1_MASK, chan->idac_mag[0]) |
+	      FIELD_PREP(ADS1262_IDACMAG_MAG2_MASK, chan->idac_mag[1]);
+	ret = regmap_update_bits(st->regmap, ADS1262_IDACMAG_REG,
+				 ADS1262_IDACMAG_MAG1_MASK |
+				 ADS1262_IDACMAG_MAG2_MASK, val);
+	if (ret)
+		return ret;
+
 	val = FIELD_PREP(ADS1262_REFMUX_RMUXN_MASK, chan->ref_n) |
 	      FIELD_PREP(ADS1262_REFMUX_RMUXP_MASK, chan->ref_p);
 	return regmap_update_bits(st->regmap, ADS1262_REFMUX_REG,
@@ -490,7 +532,7 @@ static int ads1262_channel_read(struct iio_dev *indio_dev,
 	 * CONTINUOUS mode and briefly starting and stopping conversions to
 	 * achieve the same effect (Section 9.4.1.2).
 	 */
-	if (chan->input_chop)
+	if (chan->input_chop || chan->idac_chop)
 		runmode = ADS1262_RUNMODE_CONTINUOUS;
 	else
 		runmode = ADS1262_RUNMODE_PULSE;
@@ -1070,8 +1112,8 @@ static int ads1262_parse_channel_node(struct ads1262 *st,
 	struct device *dev = &st->spi->dev;
 	const char *sources[2];
 	char name[sizeof("ti,refpN-refnM-resistor-ohms")];
-	u32 pins[2];
-	int ret;
+	u32 pins[2], mags[2];
+	int count, ret;
 
 	if (fwnode_property_present(node, "single-channel")) {
 		ret = fwnode_property_read_u32(node, "single-channel", &pins[0]);
@@ -1150,7 +1192,58 @@ static int ads1262_parse_channel_node(struct ads1262 *st,
 		}
 	}
 
+	if (fwnode_property_present(node, "excitation-channels")) {
+		count = fwnode_property_count_u32(node, "excitation-channels");
+		if (count < 0)
+			return dev_err_probe(dev, count,
+					     "%s: failed to count excitation-channels\n",
+					     fwnode_get_name(node));
+
+		pins[0] = ADS1262_IDACMUX_NO_CONN;
+		pins[1] = ADS1262_IDACMUX_NO_CONN;
+		ret = fwnode_property_read_u32_array(node, "excitation-channels",
+						     pins, min(count, ARRAY_SIZE(pins)));
+		if (ret)
+			return dev_err_probe(dev, ret, "%s: failed to read excitation-channels\n",
+					     fwnode_get_name(node));
+		if (pins[0] > ADS1262_IDACMUX_NO_CONN || pins[1] > ADS1262_IDACMUX_NO_CONN)
+			return dev_err_probe(dev, -EINVAL, "%s: excitation-channels not in range\n",
+					     fwnode_get_name(node));
+		chan->idac_mux[0] = pins[0];
+		chan->idac_mux[1] = pins[1];
+
+		mags[0] = 0;
+		mags[1] = 0;
+		ret = fwnode_property_read_u32_array(node, "excitation-current-nanoamp",
+						     mags, min(count, ARRAY_SIZE(mags)));
+		if (ret == -EOVERFLOW)
+			return dev_err_probe(dev, ret,
+					     "%s: excitation-current-nanoamp size mismatch\n",
+					     fwnode_get_name(node));
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "%s: failed to read excitation-current-nanoamp\n",
+					     fwnode_get_name(node));
+
+		ret = ads1262_find_one(ads1262_idac_mags_nA,
+				       ARRAY_SIZE(ads1262_idac_mags_nA), mags[0]);
+		if (ret < 0)
+			return dev_err_probe(dev, ret,
+					     "%s: invalid excitation-current-nanoamp\n",
+					     fwnode_get_name(node));
+		chan->idac_mag[0] = ret;
+
+		ret = ads1262_find_one(ads1262_idac_mags_nA,
+				       ARRAY_SIZE(ads1262_idac_mags_nA), mags[1]);
+		if (ret < 0)
+			return dev_err_probe(dev, ret,
+					     "%s: invalid excitation-current-nanoamp\n",
+					     fwnode_get_name(node));
+		chan->idac_mag[1] = ret;
+	}
+
 	chan->input_chop = fwnode_property_read_bool(node, "input-chopping");
+	chan->idac_chop = fwnode_property_read_bool(node, "ti,idac-rotation");
 	chan->ref_reversal = fwnode_property_read_bool(node, "ti,reference-reversal");
 
 	return 0;
@@ -1198,6 +1291,8 @@ static int ads1262_parse_channels(struct iio_dev *indio_dev)
 					     fwnode_get_name(node));
 
 		st->channels[reg].data_rate = ADS1262_DR_20_SPS;
+		st->channels[reg].idac_mux[0] = ADS1262_IDACMUX_NO_CONN;
+		st->channels[reg].idac_mux[1] = ADS1262_IDACMUX_NO_CONN;
 
 		specs[reg].scan_index = reg;
 		specs[reg].scan_type = (struct iio_scan_type) {

-- 
2.55.0

