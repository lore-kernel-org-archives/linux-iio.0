Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2568737CD33
	for <linux-iio@vger.kernel.org>; Thu, 25 Jun 2026 21:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782424576; cv=none; b=m6N3zr/6MF6EJvMnzGXrj0VT5jz9iHIis27R6+28ZGVpBRvOM7FtY9oC78v/qo/IZaPxwi6ic7vkOSyGPTFpwleaGGJwQPGXdSgh9xvAIcMLKTm6XjUV6iSoEZVNzVB14qwoo8BXHcOjzAkcrHbdSOOp8zcDAcYl+h7316fhAAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782424576; c=relaxed/simple;
	bh=p93Fd/jVwedHVMTUHpgIUU6Iuysh/xIVKYrOnooLhAE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lpA3Ddi+r+Qiw2j36/GdUVglHwhYW33lyagJVLygZxxlUFegv3MToYF9foWMrrNJVDX8ub5O5Chbh05YtTLk9tz/fcgGel+v6YVcKl6um62XuBwqZzZuLMYyzuQaiym1Tlt7MFR+YV1oQ2vm7Nw3tmStzWRiBtA37+QSur36LbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=IyeMxDn5; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="IyeMxDn5"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7e93f93ed01so200450a34.3
        for <linux-iio@vger.kernel.org>; Thu, 25 Jun 2026 14:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1782424573; x=1783029373; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=78SgO8t6lnr4/0Yxgoon6/tW0T30/mCxf/eK152p+fs=;
        b=IyeMxDn5ohuKzjeUtrJnMQiubGwnrQ0vKr6+DTM9pf9q3BPwWsRA2Pb/cf0L5KzhZb
         apHg/E694TGJshvxSHk9zgzg/j8+dIoTuSZnldaj53R98dBOED3xYRmN+zZozEXMENNS
         akyxrqz3PDZ2R+CFZv9j22JeEF+9s9nTlZBokN6HEXBKzPjFi/YvSqyknQU4rR5AFiZL
         PbvgSOCOVpcz9hO2R9VqdVHmg5FQZRaOdpfCa5cBOHgISOXp8x8+A0eqirz+4eUNLX4h
         dOgO6L7UflJoyaFj4GZaJprL7AYLTBlsNV8AB8BIBPzgnz042mi2iTvNqAA7RGRsvNLt
         laKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782424573; x=1783029373;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=78SgO8t6lnr4/0Yxgoon6/tW0T30/mCxf/eK152p+fs=;
        b=HYOiUu831OGtCqJa1b5M+sDWlILq2EU8ise+JprJG9GHFN2g18Q9WW/7iAYjTorCPL
         O/RNCf/rzh4jGdJMkGNrfOM4iS5rSjQSsz1pVeZ+YdkFdDVYOy896w60fJtAlpE0W3Ty
         1coprzzp/BiJLoG0EbE0stP3nRO2N/9RLhMS0GZubR65fbv2EytFtiP3B5SjI8oNscWE
         mylMVScwxxL07I3D1nLlMuJci4EUUtQxMErzRqHLevualOuskH2HemQlv0r3UidvxxrY
         KG0tn19k1zBd+B0nPnSb8v3WOkqw/gpVK/a53TuWfCKHGj7dMMHJFstJhNvcL7dgNCnY
         aHeA==
X-Forwarded-Encrypted: i=1; AFNElJ8ffYFk28UYm0tXzmDUIFJMZVbF99sjN6OvVFadOhUlq2tUsug61ORDM9eOFfcaSJyhvdgw41ym9gE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnLYj9dRianu6iZyXIb+370H9mRNFm7+dhxNWxiPXNUPSEiMR+
	6kBnPnKNo/uPC027LaoOClEG0EgMX5HgQbvPVb2PiotKRX5QrBoBYkrZHAE0bIACYDk=
X-Gm-Gg: AfdE7cnxxMUPrIgGpx0TSgA369mRx1lf33X6FU1CmrU+7+7xbuiycesxlY/E67MHmpL
	letHsxJTUz764rBM4OQw9bJ32tIxE/rOgEEDRltIZHA/ZV3tzHWo6knB5W2GXWfDpd2rQO7qzu0
	DaXJgz9N2zM/y7SxhyRv8eOj9ji4y7wqUgxwZIrgsCsE7MUpiO8EeThgz7m1dnEeYxzNRLY8Y6U
	WCaDXH6QeGvgW0ZsG4qT13wf4WqD39U96SGvqaokzg+hjb/TulbluWPWYqPon4OvfNU1X/c9q9S
	tv6cX4Gnwf4P/LrrMMEbpS96grO1YM1wTLIwwMNC1QWlXXSS6RCYxGDRAfCF5VNzRBIjCYZZwUx
	f9AbR9veKwAx1JU74bZ8KHWoeq6WnLhHCQsgCD+Gq7szDM0CLSdZ7j2dc4muki6f0igz30ksZi3
	jDATAcvjPPpbkm7Ruxgg==
X-Received: by 2002:a05:6830:6993:b0:7e6:e0ab:416a with SMTP id 46e09a7af769-7e99c258b1dmr4051944a34.18.1782424573142;
        Thu, 25 Jun 2026 14:56:13 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:f1f0:2d9f:2f31:3426])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e9aa5e575csm206058a34.11.2026.06.25.14.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 14:56:12 -0700 (PDT)
From: "David Lechner (TI)" <dlechner@baylibre.com>
Date: Thu, 25 Jun 2026 16:55:09 -0500
Subject: [PATCH v2 7/8] iio: adc: ti-ads112c14: implement gain on internal
 short SYS_MON channel
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-iio-adc-ti-ads122c14-v2-7-ceb9b0b561cb@baylibre.com>
References: <20260625-iio-adc-ti-ads122c14-v2-0-ceb9b0b561cb@baylibre.com>
In-Reply-To: <20260625-iio-adc-ti-ads122c14-v2-0-ceb9b0b561cb@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Chris Hall <c-hall@ti.com>, Patrick Edwards <pedwards@ti.com>, 
 Kurt Borja <kuurtb@gmail.com>, Nguyen Minh Tien <zizuzacker@gmail.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=7706; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=p93Fd/jVwedHVMTUHpgIUU6Iuysh/xIVKYrOnooLhAE=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqPaPqLmndT3E5Tp9KqcmzVaAN8xU5LlueYGKTm
 ihtCChuUZmJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaj2j6gAKCRDCzCAB/wGP
 wHKbB/990c5jmU/ixInebTqmOgR5uQUiTfkG2mbVJz+lwkqa8WcVQiYONAFs3br/KITiHpXTH6X
 un+7o6787Wiqxzcg7K0iDNXWnlusFbq74LtUBl76Tk3VGkVGyrjo1PRpg84wvjNpfjgYOY8Fnbl
 YsLgRPeX+BYF7XDgqbzrpusTwlEyX0DKpO6NVnYHt8xfaNBzEdoVAlz7wviRVBYQrO8V9xmBxRg
 pAwDAs7JdW1CgupaTsM0nxaiNJk62M0byNC76AfaP42mIsGHMWsewAWd6tuaoNcVBf9v3x9UGbl
 KAm74u78osVfnfXGeibyHnO0/VOr/UqzpkwNrH0qDH/cw6w7
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Implement support for the programmable gain amplifier on the internal
short SYS_MON channel. This channel is used for calibration, so it is
useful to be able to set the PGA to the same gain as the external
channels. The gain setting is implemented via the `_scale` attribute.

In the future, we may want to support different reference voltages for
this channel, so the scale_available table is populated during probe
rather than being a static table.

Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
---
v2 changes:
* Make some changes to reduce diff in next patch.
* Add some local variables to reduce line wrap.
---
 drivers/iio/adc/ti-ads112c14.c | 144 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 141 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ti-ads112c14.c b/drivers/iio/adc/ti-ads112c14.c
index c61d47244732..0e775dbc8d50 100644
--- a/drivers/iio/adc/ti-ads112c14.c
+++ b/drivers/iio/adc/ti-ads112c14.c
@@ -124,6 +124,26 @@
 #define ADS112C14_INT_REF0_mV				1250
 #define ADS112C14_INT_REF1_mV				2500
 
+/* Available gains as tenths (x10) */
+static const u32 ads112c14_pga_gains_x10[] = {
+	5, /* 0.5 */
+	10, /* 1 */
+	20, /* 2 */
+	40, /* 4 */
+	50, /* 5 */
+	80, /* 8 */
+	100, /* 10 */
+	160, /* 16 */
+	200, /* 20 */
+	320, /* 32 */
+	500, /* 50 */
+	640, /* 64 */
+	1000, /* 100 */
+	1280, /* 128 */
+	2000, /* 200 */
+	2560, /* 256 */
+};
+
 static bool ads112c14_writeable_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
@@ -182,6 +202,8 @@ struct ads112c14_chip_info {
 struct ads112c14_data {
 	const struct ads112c14_chip_info *chip_info;
 	struct regmap *regmap;
+	u8 sys_mon_chan_short_gain_val;
+	int sys_mon_chan_short_scale_available[ARRAY_SIZE(ads112c14_pga_gains_x10)][2];
 };
 
 /* Fixed channels for system monitor measurements. */
@@ -234,21 +256,28 @@ static const struct iio_chan_spec ads112c14_sys_mon_channels[] = {
 		.address = 1,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW)
 				    | BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE),
 	},
 };
 
 static int ads112c14_prepare_sys_mon_channel(struct ads112c14_data *data,
 					     const struct iio_chan_spec *chan)
 {
+	u32 gain_val;
 	int ret;
 
-	/* TODO: GAIN is useful for shorted PGA inputs. */
-	/* All SYS_MON channels use GAIN of 1 to keep it simple. */
+	/*
+	 * All SYS_MON channels use GAIN of 1 to keep it simple. Other than
+	 * the internal short channel, where it is useful in practice.
+	 */
+	gain_val = chan->channel == ADS112C14_SYS_MON_CHANNEL_SHORT ?
+		   data->sys_mon_chan_short_gain_val : 1;
+
 	ret = regmap_update_bits(data->regmap, ADS112C14_REG_GAIN_CFG,
 				 ADS112C14_GAIN_CFG_SYS_MON |
 				 ADS112C14_GAIN_CFG_GAIN,
 				 FIELD_PREP(ADS112C14_GAIN_CFG_SYS_MON, chan->address) |
-				 FIELD_PREP(ADS112C14_GAIN_CFG_GAIN, 1));
+				 FIELD_PREP(ADS112C14_GAIN_CFG_GAIN, gain_val));
 	if (ret)
 		return ret;
 
@@ -323,6 +352,7 @@ static int ads112c14_read_raw(struct iio_dev *indio_dev,
 {
 	struct ads112c14_data *data = iio_priv(indio_dev);
 	u32 vref_uV, fsr_bits;
+	int *scale_avail;
 
 	/* Selecting V_REF source is not implemented yet. */
 	vref_uV = ADS112C14_INT_REF1_mV * (MICRO / MILLI);
@@ -371,6 +401,17 @@ static int ads112c14_read_raw(struct iio_dev *indio_dev,
 			return IIO_VAL_FRACTIONAL_LOG2;
 		}
 
+		if (chan->channel == ADS112C14_SYS_MON_CHANNEL_SHORT) {
+			u8 idx = data->sys_mon_chan_short_gain_val;
+
+			scale_avail = data->sys_mon_chan_short_scale_available[idx];
+
+			*val = scale_avail[0];
+			*val2 = scale_avail[1];
+
+			return IIO_VAL_INT_PLUS_NANO;
+		}
+
 		*val = vref_uV / (MICRO / MILLI);
 		/*
 		 * Last 3 SYS_MON channels (ext ref, AVDD, DVDD) need to be
@@ -394,6 +435,69 @@ static int ads112c14_read_raw(struct iio_dev *indio_dev,
 	}
 }
 
+static int ads112c14_read_avail(struct iio_dev *indio_dev,
+				const struct iio_chan_spec *chan, const int **vals,
+				int *type, int *length, long mask)
+{
+	struct ads112c14_data *data = iio_priv(indio_dev);
+
+	if (chan->channel == ADS112C14_SYS_MON_CHANNEL_SHORT) {
+		*vals = (const int *)data->sys_mon_chan_short_scale_available;
+		*length = 2 * ARRAY_SIZE(data->sys_mon_chan_short_scale_available);
+		*type = IIO_VAL_INT_PLUS_NANO;
+		return IIO_AVAIL_LIST;
+	}
+
+	return -EINVAL;
+}
+
+static int ads112c14_write_raw(struct iio_dev *indio_dev,
+			       struct iio_chan_spec const *chan, int val,
+			       int val2, long mask)
+{
+	struct ads112c14_data *data = iio_priv(indio_dev);
+	const int (*scale_avail)[2];
+	u8 *gain_val;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE: {
+		if (chan->channel == ADS112C14_SYS_MON_CHANNEL_SHORT) {
+			scale_avail = data->sys_mon_chan_short_scale_available;
+			gain_val = &data->sys_mon_chan_short_gain_val;
+		} else {
+			return -EINVAL;
+		}
+
+		IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
+		if (IIO_DEV_ACQUIRE_FAILED(claim))
+			return -EBUSY;
+
+		for (u32 i = 0; i < ARRAY_SIZE(ads112c14_pga_gains_x10); i++) {
+			if (val == scale_avail[i][0] && val2 == scale_avail[i][1]) {
+				*gain_val = i;
+				return 0;
+			}
+		}
+
+		return -EINVAL;
+	}
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ads112c14_write_raw_get_fmt(struct iio_dev *indio_dev,
+				       struct iio_chan_spec const *chan,
+				       long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		return IIO_VAL_INT_PLUS_NANO;
+	default:
+		return IIO_VAL_INT_PLUS_MICRO;
+	}
+}
+
 static int ads112c14_read_label(struct iio_dev *indio_dev,
 				struct iio_chan_spec const *chan, char *label)
 {
@@ -425,9 +529,38 @@ static int ads112c14_read_label(struct iio_dev *indio_dev,
 
 static const struct iio_info ads112c14_info = {
 	.read_raw = ads112c14_read_raw,
+	.read_avail = ads112c14_read_avail,
+	.write_raw = ads112c14_write_raw,
+	.write_raw_get_fmt = ads112c14_write_raw_get_fmt,
 	.read_label = ads112c14_read_label,
 };
 
+static void ads112c14_populate_scale_available(int scale_avail[][2],
+					       u32 full_scale, u32 fsr_bits)
+{
+	for (u32 i = 0; i < ARRAY_SIZE(ads112c14_pga_gains_x10); i++) {
+		int *entry = scale_avail[i];
+		u64 gain_x10, nano_scale;
+
+		gain_x10 = ads112c14_pga_gains_x10[i];
+		nano_scale = div64_u64((u64)NANO * 10U * full_scale,
+				       gain_x10 * BIT(fsr_bits));
+		entry[0] = div_u64_rem(nano_scale, NANO, &entry[1]);
+	}
+}
+
+static void ads112c14_populate_tables(struct ads112c14_data *data)
+{
+	u32 full_scale, fsr_bits;
+
+	/* For now, assuming all sys_mon channels are using 2.5V reference. */
+	full_scale = ADS112C14_INT_REF1_mV;
+	fsr_bits = data->chip_info->resolution_bits - 1;
+
+	ads112c14_populate_scale_available(data->sys_mon_chan_short_scale_available,
+					   full_scale, fsr_bits);
+}
+
 static int ads112c14_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
@@ -483,6 +616,9 @@ static int ads112c14_probe(struct i2c_client *client)
 	if (FIELD_GET(ADS112C14_STATUS_MSB_RESETN, reg_val))
 		return dev_err_probe(dev, -EIO, "reset failed\n");
 
+	/* Default gain after reset is 1. */
+	data->sys_mon_chan_short_gain_val = 1;
+
 	/*
 	 * Clear reset bit to prepare for next probe. And clear AVDD fault since
 	 * that happens on every reset.
@@ -499,6 +635,8 @@ static int ads112c14_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
+	ads112c14_populate_tables(data);
+
 	indio_dev->name = info->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = ads112c14_sys_mon_channels;

-- 
2.43.0

