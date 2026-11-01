Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793542538;
	b=jTrPmsOasCkeKczjWd3t9jN+rtXfJ38Y8mW4m/EUgvawPJPN0z1YZfPr+vCVOkpCa7Yq
	 xVfPNZ+i1OGWKgt3yeiqfuXDfKloPyaIYLi1Z0EE9YBUvKwLVM1k9SmMn6emPU242wd66
	 slvtbKWWhQWG64pejW3sl3LHDF3/363LgPxDRx/stW7JXVj1Kgvxe3CLCS2ztomiOfcHo
	 h+LZueopoe2OBqajgvgmcTVcBefh51a2QPFzsoYbPhX9MkDU1aYOradMY44gnLaGDmHAY
	 nc53HiW/zo+4owvOlH0/Wb5OhK+cOZN8+7+95qd6UPGyQkX0NsjVhYFuDvbJJ86BWyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793542538;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=yWnYzS6t5E7LXptWp7lsUkqJlDk1ug9cyhEyAxBvppI=;
	b=4ntHlMreEGgfPVhA9ACoUIBOcbjINp+q8D9zE9NJCp8O+wzLVt5GEqrQjZGfDRFj8iZ/
	 /cKQ2icrAn1cLUpLGl3wjLcS/+crxvPNm9MNe04QXUUX5VfunHmeVslFog+5DFz7d7kwL
	 hgkg8x7CsWVIvpING7bbZj/HG7XvHyicAF2I4HxUvZlUUdi2y38YnW3a8I7Qw4XoO7Zao
	 NAFQdPB2s69efnDeauuE/tpxmyr3fiF1WclRTqkvdT/iCY1Xd52xxkUOtrm1xhmMTe1Bh
	 QGHR/JQb1ZZpfkXJwO9idg3ov6WVRACHDj76KlMM9VeTO+W0fKTjEFUHjk90u+Q4Otw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U6YdSaLg;
	arc=none smtp.remote-ip=209.85.208.53
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE06606A330
	for <linux-iio@vger.kernel.org>; Sun,  1 Nov 2026 14:15:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCE06606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U6YdSaLg
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6b3dd83e779so3821268a12.1
        for <linux-iio@vger.kernel.org>; Sun, 01 Nov 2026 06:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793542536; x=1794147336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yWnYzS6t5E7LXptWp7lsUkqJlDk1ug9cyhEyAxBvppI=;
        b=U6YdSaLg0O6zzMiGFFkQ1p2MEY9grW9njWvhdGLrpjZ+Tgafcp+j45zpAq356pQOWf
         Mk2WOjcbbQ17tJjksPTbQbAslyemUh2L69OLSW/1p38MzuAW1cxSK6U7D9nczi07d9+Y
         bii77h0EgjsPgAM90SiYDnvpvBhxUTTBIPfAq/wSMfur9Im8cn6sUaehfbwECIOGGOY9
         Q2Gdempn9ypx2FUfWbdzE1ZplpmGojYJ4QilLS2r96gZFfbZHscUUtEF0FD/UvfofAP2
         XzVlO8Gu2SjRzfxkTHa50172EceLNbyYfIprd3v2TqGTA02eowVVN3e0DpPzhtecYRdl
         gB8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793542536; x=1794147336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yWnYzS6t5E7LXptWp7lsUkqJlDk1ug9cyhEyAxBvppI=;
        b=t/j1UafIJLPSPX4DGU/fCHX/Lr+5VK+l9ILSLFq/+rgUMJ0kPwnzn2TTZRO/1LKoiF
         qzg00ZjCw0z8JeballiQN/nr4Qs6GAqnnyh2bubUqKNxugaOx/IEfCjREJYmaw1dWp7c
         d4BN0jTB2Mxt0NGffkg3NzPQGfrqVoJ6L3d+h3KwEP2v1GIeOIZ1Waj02491MTVVNYpx
         uUWq81d2umguiicWMFMWj5oXutVMEDLj/OcsGWlNNZLjQ1y8ya4wxpQlXJQSV5Kc3VfZ
         PYM2FfuYL/blqAMwn1mFZReZUF1+dST6IwIE/TBdFyld3vYIzm536E33WLtYrEbzKGpk
         bJqA==
X-Gm-Message-State: APuU4Z9u2nDFHfWv5ySj5ufXqUZ9TfvFpYo8fMYg7tKrAjWw2YLtHRKT
	o79RzendA/gIArbp6Y2oky30XT7WQy3WBBR/xLFeQB+0aomCn3WOTYNU
X-Gm-Gg: AYBFou2SK1hur6TNCxCt3rFNYPw4exbBCJad9N/cWQlZJBdf2aaPoZTqgdaFfaCviCy
	Am1m7SWJ6TTRtMSSqTNNZqO4GPjW9prOi0zeLZPjf796fReCgZxBricIjsIoIQhfW3JyhD6Fai2
	0fA7WDn0OQP0HSj4L4IVws2RwsNsxIfO77dqusg93UGbkqLnEtK/7baqCmBIYXWlBCHSbPulPG3
	eVpe1kNj/GETfum8z2wopz8TURLQHQ/zfdgIW4nW0TbnjKCDeTAZgEFRVt7xLciH/BKDv+8JY1Z
	tDMujKG3Tbt9byURTSamQaNmJmmE5gSzJgWIHBzTytNczGZxStci4fFhb+Ge5IKdXCoLYq765FP
	QTmdQKTHSCrwqUnCLGwWiktCY4oo+b0E1yZ+ihDFFtnJ0EOWj48seJVI652VTeewinH87UNqMQ7
	7ZCluVcFU9buY6z3LBSMMXfOIjr6wJKwrnfeF5E0lYL2dANmt2M1w2jEVponjfo1MZC1ohWRKBV
	pHrkZKn4uN9f0PV52PlqHfAE4EZ0i3d7JtWPNhr5yllNL34FUuZyDfO3YVSjbLZOB3oyNDZZVM1
	zYr64rtftmFbeihXEoktlM+wMMfdbKEZNdokPdk0FXSEK3gnbIY=
X-Received: by 2002:a17:907:3da5:b0:c3f:84aa:af0d with SMTP id a640c23a62f3a-c4ca7a4f260mr724581366b.18.1793542536042;
        Sun, 01 Nov 2026 06:15:36 -0800 (PST)
Received: from xeon ([188.163.112.62])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4cabc18ec5sm281769266b.12.2026.11.01.06.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 06:15:33 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Esben Haabendal <esben@geanix.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Pan Chuang <panchuang@vivo.com>,
	Hemanth Selam <hemanth.selam@gmail.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Nikita Travkin <nikita@trvn.ru>
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] iio: light: ltr501: Add support for the LTR-659PS-01 proximity sensor
Date: Sun,  1 Nov 2026 16:15:07 +0200
Message-ID: <20261101141507.119186-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261101141507.119186-1-clamor95@gmail.com>
References: <20261101141507.119186-1-clamor95@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the Lite-On LTR-659PS-01 proximity sensor. This device is
nearly identical to the LTR-559ALS-01, but omits all elements related to
ambient light sensing (Even the regmap is identical, but ALS registers are
marked as reserved and interactions with them are discouraged).

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/iio/light/ltr501.c | 58 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index 302be2fc314c5..5cc1141322ad5 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -96,6 +96,7 @@ enum {
 	ltr329,
 	ltr501,
 	ltr559,
+	ltr659,
 };
 
 struct ltr501_gain {
@@ -649,6 +650,26 @@ static const struct iio_chan_spec ltr301_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(2),
 };
 
+static const struct iio_chan_spec ltr659_channels[] = {
+	{
+		.type = IIO_PROXIMITY,
+		.address = LTR501_PS_DATA,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE),
+		.scan_index = 0,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 11,
+			.storagebits = 16,
+			.endianness = IIO_CPU,
+		},
+		.event_spec = ltr501_pxs_event_spec,
+		.num_event_specs = ARRAY_SIZE(ltr501_pxs_event_spec),
+		.ext_info = ltr501_ext_info,
+	},
+	IIO_CHAN_SOFT_TIMESTAMP(1),
+};
+
 static int ltr501_read_info_raw(struct ltr501_data *data,
 				struct iio_chan_spec const *chan,
 				int *val)
@@ -1178,6 +1199,12 @@ static struct attribute *ltr301_attributes[] = {
 	NULL
 };
 
+static struct attribute *ltr659_attributes[] = {
+	&iio_dev_attr_in_proximity_scale_available.dev_attr.attr,
+	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
+	NULL
+};
+
 static const struct attribute_group ltr501_attribute_group = {
 	.attrs = ltr501_attributes,
 };
@@ -1186,6 +1213,10 @@ static const struct attribute_group ltr301_attribute_group = {
 	.attrs = ltr301_attributes,
 };
 
+static const struct attribute_group ltr659_attribute_group = {
+	.attrs = ltr659_attributes,
+};
+
 static const struct iio_info ltr501_info_no_irq = {
 	.read_raw = ltr501_read_raw,
 	.write_raw = ltr501_write_raw,
@@ -1218,6 +1249,22 @@ static const struct iio_info ltr301_info = {
 	.write_event_config	= &ltr501_write_event_config,
 };
 
+static const struct iio_info ltr659_info_no_irq = {
+	.read_raw = ltr501_read_raw,
+	.write_raw = ltr501_write_raw,
+	.attrs = &ltr659_attribute_group,
+};
+
+static const struct iio_info ltr659_info = {
+	.read_raw = ltr501_read_raw,
+	.write_raw = ltr501_write_raw,
+	.attrs = &ltr659_attribute_group,
+	.read_event_value	= &ltr501_read_event,
+	.write_event_value	= &ltr501_write_event,
+	.read_event_config	= &ltr501_read_event_config,
+	.write_event_config	= &ltr501_write_event_config,
+};
+
 static const struct ltr501_chip_info ltr501_chip_info_tbl[] = {
 	[ltr301] = {
 		.partid = 0x08,
@@ -1283,6 +1330,15 @@ static const struct ltr501_chip_info ltr501_chip_info_tbl[] = {
 		.channels = ltr501_channels,
 		.no_channels = ARRAY_SIZE(ltr501_channels),
 	},
+	[ltr659] = {
+		.partid = 0x09,
+		.ps_gain = ltr559_ps_gain_tbl,
+		.ps_gain_tbl_size = ARRAY_SIZE(ltr559_ps_gain_tbl),
+		.info = &ltr659_info,
+		.info_no_irq = &ltr659_info_no_irq,
+		.channels = ltr659_channels,
+		.no_channels = ARRAY_SIZE(ltr659_channels),
+	},
 };
 
 static int ltr501_write_contr(struct ltr501_data *data, u8 als_val, u8 ps_val)
@@ -1635,6 +1691,7 @@ static const struct i2c_device_id ltr501_id[] = {
 	{ .name = "ltr329", .driver_data = ltr329 },
 	{ .name = "ltr501", .driver_data = ltr501 },
 	{ .name = "ltr559", .driver_data = ltr559 },
+	{ .name = "ltr659", .driver_data = ltr659 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ltr501_id);
@@ -1645,6 +1702,7 @@ static const struct of_device_id ltr501_of_match[] = {
 	{ .compatible = "liteon,ltr329", },
 	{ .compatible = "liteon,ltr501", },
 	{ .compatible = "liteon,ltr559", },
+	{ .compatible = "liteon,ltr659", },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ltr501_of_match);
-- 
2.53.0

