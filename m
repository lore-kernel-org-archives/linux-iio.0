Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452B03AFD16
	for <linux-iio@vger.kernel.org>; Sat,  8 Aug 2026 03:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786161539; cv=none; b=SZJnuAj6psGzAsOnCed+ms5nUzn1yumMRj807zVeET3fjKEFyDjH0GBPz1osQrsCEKCDYj5+SnNLW11G/sjX7VZUzMXnFhtScYQMRMAopeRd3sXaBug/6H0cJ7ugzxgV1ghxjqy5laSUMIZe1Co0zOrm8Ot1Cm4qJKGhzc7CgmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786161539; c=relaxed/simple;
	bh=G+m4JpteOwH1Zo2tIqYoGuuzgz1W67Q67Aw+8oU4NjM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d0B6q6/puA171fToybGfofySUl/LC5JgrKcv81o/b444FwIDbBFb8/Diyv8eiYWSK2AgzAe+IhLKc2W0NqVOKObvcsc0Hwy57ZZaEK1QNMZaAoGBrSObBkSJTMKPZz+6WA8rEX6PVvR8ugBoaPK9hhrTtDOsA/TaWXpluyvPBtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=otcdFQnm; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="otcdFQnm"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-5bf959b820cso169807e0c.3
        for <linux-iio@vger.kernel.org>; Fri, 07 Aug 2026 20:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786161536; x=1786766336; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lrTqoTQOzou37Z6mnJvLS7m03O+NZx1RHl2W3+gwCEY=;
        b=otcdFQnmlStaWfXUZZfsMEHaFTGvSwg3usbpqXh46oGAmWMTK3sEXEVSZMD77BRjHA
         bQv2Qmk8eO9UbHEOUwRJe7M8rbOg/LE3bHdtz7QPCyDZhmrknVE9exRrZX/qKMB4PgNe
         5pucba3yGsiJvT/B4WNu6RDSiEfMqRWGJI9CZ6rZPKNLw+NdSfMYCgN6LmtIapwYxVcB
         v5rOEbTgU39YAK+BmWHkywKSSQFBrTaGyva946ZuXjQcrS4V9N9dtlWRDiwsas8/36nR
         LP8nWjdB/rj07MBSoruygY1G5JvfHdmyei47tgUDDxhgfUSI5bByo//pG6dQ+uBR6xjc
         ipQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786161536; x=1786766336;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lrTqoTQOzou37Z6mnJvLS7m03O+NZx1RHl2W3+gwCEY=;
        b=efNyPRk9y3LG8mXddstptGART3m3v0AbyZZEZ6Num6Pc+K46nm4CYxccrGpkG4X5oz
         oVbA7C9BXUKK3Qm23FGrI/MukMt03OAdIUrBDHQbR+tyYPkShslryBkhKpqRfYcS78V/
         9Oz8efICAj2rvhQ5gzvYRwZXzpFUKFbWs2vibvLZhA+u9YHe5p4PsAKCz6ERjYH9wdsJ
         A3qd82F6Ut1ubejKc5GnIf+fQ1OLGWzxu4dSls4MOzMjNHdSLosy0+7Ey78chuk7K9zb
         b4bLIxmXVEdc4WKpSQGDlgh+eNgjL9x4wjG/KePbvrsZsQ19NambLpeetnDr14S+bl6P
         WNCg==
X-Forwarded-Encrypted: i=1; AHgh+RphjxRQljhcFYBnIpIF0TQCwvOigf4wLsCj7dEKjUskJynE9AnUN4wQOaZXmo/j7vtC6IenGSZ+oT8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyshI4xhkPqtmysHLdMRqUfiJ0CVsDVVMlN9J4etyElcOlbVCmA
	6OCCLGsNyD/Fs77gPu4aKe/niMvidegqa7C/wI5l46KgkOXRYP23eSxV
X-Gm-Gg: AR+sD11GieFc4b/tFh7BGq6ehi/Q3GiZguyGmxeoUsUIYWF2iAwKO0JonzZSMr5hlJU
	TpLLQL/fipwcZ4SGrH/8xmTItspRJXSfQFsW44GQr/qhh9VRCBfiO60WZcuFoki1CJGDsUIO47l
	lRJCwb/5ZVfpDWwTiddtC96+OPRu2xlIDOH9Sdq+1suQiEFSPKyh2Blx9TBHYph09I04tysi/ZK
	rI+TwvzsCkJiQdrCN8ZRcHZiJxiIDvHeVv6U2l6onwkW2UFfdj4VxTr07ub6k2Pv3kXfP0AuAiL
	gODKgC7FU0Y8d18IIxtfyA9Qgp2wcEN8T07bkg98oYYHxhbdb3BJoPU6keSCLcAKwUpHFk7tYNm
	nTb67giccM3geywkIyCGtdegozMu69X36xWXpSqcadHeuBwHLrplfqF+kDmKiKIPrnZgT971XKz
	R9yVxKeSwJxXFib5cDJuWMw18m1gFhWzsfNQlKBjM8NOF1HTNeaPvL/rToOfeZ0vP7ygfu/A==
X-Received: by 2002:a05:6122:4085:b0:5c2:c0b2:9880 with SMTP id 71dfb90a1353d-5c4112ef01dmr834216e0c.1.1786161536147;
        Fri, 07 Aug 2026 20:58:56 -0700 (PDT)
Received: from [192.168.100.6] ([2800:bf0:82:11a2:7ac4:1f2:947b:2b6])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c40b212fa6sm1432936e0c.16.2026.08.07.20.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 20:58:55 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Date: Fri, 07 Aug 2026 22:58:25 -0500
Subject: [PATCH v3 3/9] iio: adc: ti-ads1262: support per-channel sampling
 frequency
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-ads126x-v3-3-f89925d72792@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8180; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=G+m4JpteOwH1Zo2tIqYoGuuzgz1W67Q67Aw+8oU4NjM=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDFllK8tZj5UKLE8qipONtLw6Z0/C5HCFrepL/fzTvrRuu
 q+mpHG0o5SFQYyLQVZMkaU9YdG3R1F5b/0OhN6HmcPKBDKEgYtTACby9QMjQ/c5/2bxyd/2MKXc
 DWR3WrzboZPr1sXKuh9aPac+X9knys7wv0Qza9eq6af/uwbxFM3j2JcxyahmDk99ZvlU/Sl6Ru/
 +8wEA
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Add per-channel sampling frequency support. The "available" attribute is
assigned per-channel too, in order to eventually support per-filter
availability.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/iio/adc/ti-ads1262.c | 159 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 158 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-ads1262.c b/drivers/iio/adc/ti-ads1262.c
index d78e5e3ae13e..b3b7b1249102 100644
--- a/drivers/iio/adc/ti-ads1262.c
+++ b/drivers/iio/adc/ti-ads1262.c
@@ -26,6 +26,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/spi/spi.h>
 #include <linux/types.h>
+#include <linux/units.h>
 
 #include <asm/byteorder.h>
 
@@ -148,6 +149,7 @@ enum {
 	ADS1262_DR_14400_SPS,
 	ADS1262_DR_19200_SPS,
 	ADS1262_DR_38400_SPS,
+	ADS1262_DR_COUNT,
 };
 
 enum {
@@ -173,6 +175,11 @@ struct ads1262_chip_info {
 	const char *name;
 };
 
+struct ads1262_channel {
+	u8 data_rate;
+	int samp_freqs[ADS1262_DR_COUNT][2];
+};
+
 struct ads1262 {
 	struct spi_device *spi;
 	struct regmap *regmap;
@@ -183,12 +190,47 @@ struct ads1262 {
 	/* Protects channel state */
 	struct mutex chan_lock;
 	unsigned int num_channels;
+	struct ads1262_channel *channels;
 	struct completion drdy;
 
 	/* Protects transfer buffers and concurrent SPI transfers */
 	struct mutex xfer_lock;
 };
 
+static const u32 ads1262_data_rate_div[] = {
+	[ADS1262_DR_2_5_SPS]	= 8 * 64 * 5760,
+	[ADS1262_DR_5_SPS]	= 8 * 64 * 2880,
+	[ADS1262_DR_10_SPS]	= 8 * 64 * 1440,
+	[ADS1262_DR_16_6_SPS]	= 8 * 64 * 864,
+	[ADS1262_DR_20_SPS]	= 8 * 64 * 720,
+	[ADS1262_DR_50_SPS]	= 8 * 64 * 288,
+	[ADS1262_DR_60_SPS]	= 8 * 64 * 240,
+	[ADS1262_DR_100_SPS]	= 8 * 64 * 144,
+	[ADS1262_DR_400_SPS]	= 8 * 64 * 36,
+	[ADS1262_DR_1200_SPS]	= 8 * 64 * 12,
+	[ADS1262_DR_2400_SPS]	= 8 * 64 * 6,
+	[ADS1262_DR_4800_SPS]	= 8 * 64 * 3,
+	[ADS1262_DR_7200_SPS]	= 8 * 64 * 2,
+	[ADS1262_DR_14400_SPS]	= 8 * 64 * 1,
+	[ADS1262_DR_19200_SPS]	= 8 * 48 * 1,
+	[ADS1262_DR_38400_SPS]	= 8 * 24 * 1,
+};
+
+static int ads1262_find_two(const int (*array)[2], size_t num_elements, int val,
+			    int val2)
+{
+	int i;
+
+	for (i = 0; i < num_elements; i++) {
+		if (val == array[i][0] && val2 == array[i][1])
+			break;
+	}
+	if (i == num_elements)
+		return -EINVAL;
+
+	return i;
+}
+
 static int ads1262_dev_cmd(struct ads1262 *st, u8 opcode)
 {
 	guard(mutex)(&st->xfer_lock);
@@ -316,11 +358,19 @@ static int ads1262_wait_for_conversion(struct ads1262 *st)
 static int ads1262_channel_enable(struct ads1262 *st,
 				  const struct iio_chan_spec *spec)
 {
+	struct ads1262_channel *chan = &st->channels[spec->scan_index];
+	int ret;
 	u8 val;
 
 	guard(mutex)(&st->xfer_lock);
 	guard(mutex)(&st->chan_lock);
 
+	val = FIELD_PREP(ADS1262_MODE2_DR_MASK, chan->data_rate);
+	ret = regmap_update_bits(st->regmap, ADS1262_MODE2_REG,
+				 ADS1262_MODE2_DR_MASK, val);
+	if (ret)
+		return ret;
+
 	val = FIELD_PREP(ADS1262_INPMUX_MUXN_MASK, spec->channel2) |
 	      FIELD_PREP(ADS1262_INPMUX_MUXP_MASK, spec->channel);
 	return regmap_update_bits(st->regmap, ADS1262_INPMUX_REG,
@@ -372,6 +422,8 @@ static int ads1262_read_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan, int *val,
 			    int *val2, long mask)
 {
+	struct ads1262 *st = iio_priv(indio_dev);
+	struct ads1262_channel *chan_data = &st->channels[chan->scan_index];
 	__be32 raw;
 	int ret;
 
@@ -384,6 +436,65 @@ static int ads1262_read_raw(struct iio_dev *indio_dev,
 
 		return IIO_VAL_INT;
 
+	case IIO_CHAN_INFO_SAMP_FREQ: {
+		guard(mutex)(&st->chan_lock);
+
+		*val = chan_data->samp_freqs[chan_data->data_rate][0];
+		*val2 = chan_data->samp_freqs[chan_data->data_rate][1];
+
+		return IIO_VAL_INT_PLUS_MICRO;
+	}
+
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int ads1262_read_avail(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan, const int **vals,
+			      int *type, int *length, long mask)
+{
+	struct ads1262 *st = iio_priv(indio_dev);
+	struct ads1262_channel *chan_data = &st->channels[chan->scan_index];
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		*vals = (const int *)chan_data->samp_freqs;
+		*length = ARRAY_SIZE(chan_data->samp_freqs) * 2;
+		return IIO_AVAIL_LIST;
+
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int ads1262_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan, int val,
+			     int val2, long mask)
+{
+	struct ads1262 *st = iio_priv(indio_dev);
+	struct ads1262_channel *chan_data = &st->channels[chan->scan_index];
+	int ret;
+
+	IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
+	if (IIO_DEV_ACQUIRE_FAILED(claim))
+		return -EBUSY;
+
+	guard(mutex)(&st->chan_lock);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		ret = ads1262_find_two(chan_data->samp_freqs,
+				       ARRAY_SIZE(chan_data->samp_freqs),
+				       val, val2);
+		if (ret < 0)
+			return -EINVAL;
+
+		chan_data->data_rate = ret;
+
+		return 0;
+
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -404,6 +515,8 @@ static int ads1262_debugfs_reg_access(struct iio_dev *indio_dev, unsigned int re
 
 static const struct iio_info ads1262_iio_info = {
 	.read_raw = ads1262_read_raw,
+	.read_avail = ads1262_read_avail,
+	.write_raw = ads1262_write_raw,
 	.debugfs_reg_access = ads1262_debugfs_reg_access,
 };
 
@@ -575,6 +688,36 @@ static const struct regmap_bus ads1262_regmap_bus = {
 	.max_raw_write = ADS1262_MAX_REGMAP_WRITE,
 };
 
+static void ads1262_populate_samp_freqs(struct ads1262 *st,
+					struct ads1262_channel *chan)
+{
+	int freq_Hz, freq_rem;
+	u64 freq_uHz;
+
+	for (unsigned int i = 0; i < ARRAY_SIZE(chan->samp_freqs); i++) {
+		freq_uHz = div_u64(mul_u32_u32(st->clk_rate, MICRO),
+				   ads1262_data_rate_div[i]);
+		freq_Hz = div_u64_rem(freq_uHz, MICRO, &freq_rem);
+
+		chan->samp_freqs[i][0] = freq_Hz;
+		chan->samp_freqs[i][1] = freq_rem;
+	}
+}
+
+static int ads1262_populate_tables(struct iio_dev *indio_dev)
+{
+	struct ads1262 *st = iio_priv(indio_dev);
+	struct ads1262_channel *chan;
+
+	for (unsigned int i = 0; i < st->num_channels; i++) {
+		chan = &st->channels[i];
+
+		ads1262_populate_samp_freqs(st, chan);
+	}
+
+	return 0;
+}
+
 static int ads1262_gpio_setup(struct ads1262 *st)
 {
 	struct device *dev = &st->spi->dev;
@@ -661,6 +804,11 @@ static int ads1262_parse_channels(struct iio_dev *indio_dev)
 	if (st->num_channels > ADS1262_MAX_CHANNEL_COUNT)
 		return dev_err_probe(dev, -EINVAL, "too many channels\n");
 
+	st->channels = devm_kcalloc(dev, st->num_channels, sizeof(*st->channels),
+				    GFP_KERNEL);
+	if (!st->channels)
+		return -ENOMEM;
+
 	/* Account for the timestamp channel */
 	num_specs = st->num_channels + 1;
 	specs = devm_kcalloc(dev, num_specs, sizeof(*specs), GFP_KERNEL);
@@ -681,6 +829,8 @@ static int ads1262_parse_channels(struct iio_dev *indio_dev)
 			return dev_err_probe(dev, -EINVAL, "%s: duplicated channel reg\n",
 					     fwnode_get_name(node));
 
+		st->channels[reg].data_rate = ADS1262_DR_20_SPS;
+
 		specs[reg].scan_index = reg;
 		specs[reg].scan_type = (struct iio_scan_type) {
 			.format = IIO_SCAN_FORMAT_SIGNED_INT,
@@ -701,7 +851,10 @@ static int ads1262_parse_channels(struct iio_dev *indio_dev)
 		if (specs[reg].channel != ADS1262_INPMUX_TEMP)
 			specs[reg].indexed = true;
 
-		specs[reg].info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
+		specs[reg].info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+						BIT(IIO_CHAN_INFO_SAMP_FREQ);
+		specs[reg].info_mask_separate_available =
+				BIT(IIO_CHAN_INFO_SAMP_FREQ);
 	}
 
 	specs[num_specs - 1] = IIO_CHAN_SOFT_TIMESTAMP(num_specs - 1);
@@ -786,6 +939,10 @@ static int ads1262_spi_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
+	ret = ads1262_populate_tables(indio_dev);
+	if (ret)
+		return ret;
+
 	st->regmap = devm_regmap_init(dev, &ads1262_regmap_bus, st,
 				      &ads1262_regmap_config);
 	if (IS_ERR(st->regmap))

-- 
2.55.0

