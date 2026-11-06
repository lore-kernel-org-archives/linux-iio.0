Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793956819;
	b=PB7Fmr3eX/aZEHIxOCNvGKnia/u4WC60pze0H764hRn7U8tqTVYN4No82jGnCtZkMymY
	 0dMX+7xModGkHffueOuS1sVIhk/q3wiNVxThZ21cCa+PeJj2ifOjE2wQGrCBVDKq7kpE8
	 fWjxAkxSor9otCwRHTE19XocI4Ni0LFqV4BZxjerYknV2/Fw/FjHF8+OP+mprInAKxJ1s
	 spY5WHg8wlmY0wN0Vu2cqSRdrCHLDpwnvqivn+p/EIxjuD8vUfMViH7Zwqlso3dBOkEkS
	 8UB1Ha+/7CIVV0KzRtkxN6ncu9x1YMijnpetBabEdCQnO3x/QkivNGf7yKoIZEQFj9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793956819;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Lt2el+1PRelTWOtuHBgUwaDovv++emfSs0a0UkoSKek=;
	b=nEyqqqZYeSoDcfbpLJaYIiJ39PE9v+LSHl3EZLavoEKcktXThEoR9k53A09/pIQwmzWh
	 eUf5/1aV89WgDrmvPnypNM+wM6XPfWRcvecyguP2fGsukDByOQX2M3bLELOeN2hdAwV3C
	 ORs2ANWrPdxSrjH+IM7ScNQxO4J7X1D32clD4pR8TiJwIBSXJCbuePr79jBgFg8Waggmh
	 TVPU8uR0T7VBUrc5MZS4odctpMNdUbSBg5erROqEz+kedvl+Ncl5FcalWkyZRn1acuulD
	 BoyikUS1+LvJfjOj77iHd9AtAwZPtlGH+pDbF5dGVgHeixy9Pblg/8ID07yMWfOkzmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vedrZJHa;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7952D6082BFD
	for <linux-iio@vger.kernel.org>; Fri,  6 Nov 2026 09:20:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7952D6082BFD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vedrZJHa
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a5036bbac7so2185525e9.3
        for <linux-iio@vger.kernel.org>; Fri, 06 Nov 2026 01:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793956818; x=1794561618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Lt2el+1PRelTWOtuHBgUwaDovv++emfSs0a0UkoSKek=;
        b=vedrZJHa0qrWP8SprQrms0Pn8x+9evx/RNxvdQ/AcgtklhE4TnEUWJjGT6xF3uyWIx
         8GoM7RJrENS9XKcVdPyp+QdYSJoUJg3a2dWIIQQ6tqZPR5H+bpP9c1kHJ9xPPW0xVJxN
         PoISUbdypypvUHECR/kkkynPyG21uxhrU5QouPtHymNd3BzYAxAr1yoHHhLrAmfQH79X
         jldgRFzLBO/2WcF4bieWviVxw2gqnJr4faMCnu4DVf3lHCOPojpTP6zqeiHvazSrgVEt
         tnW27f0Tte+tE56wancPWi3TAVbR+Uio19nMX2EPVLNPr4tLkqUPapj4IcnJhwnerhVq
         ZRtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793956818; x=1794561618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Lt2el+1PRelTWOtuHBgUwaDovv++emfSs0a0UkoSKek=;
        b=Uf7ZwRd51d0yAbKr/JP2gSgWXsvRYyMuGT/x4FMv2jHXZzwVrPmgTAjcEKybRubwPo
         SbYHvndfOXLhy+lrtkfzkluSk0tidMMnY22KRoZ8c25O2KsCsEfPIDnsEd7CRWorQJtW
         A18hB0wv0Ih2AVEBzSLIFsfcR3lsXOuuSvt6rcDzWnxCPUERLoZD+gLyoQ5bW3W3Vcjj
         woIOZee6xg1bOIm99xDep1w1uosTEsXppzOClCXBZfgkb9Hnd6VN/vNzxzDMBhyik/l7
         wXAcpkxZsV6iKL12HyaPm6fAHBxFAepToCbWSX8yI3OiIvnJBZ0ZX8a6FODvkUIcaFQ3
         iP5A==
X-Gm-Message-State: APuU4Z8mWjlr4oVLUqD9gy5AOydxYV2IGn338ylpw1179y9j/itB+F3d
	jCq8eBhGrcgIpAYoral8fE/IGjOeYe1nlOmt9Z8ZL0Qt1cfkFzDC6kva
X-Gm-Gg: AYBFou2GVbVQdWJxAj++LwfxJ506Q3AJvUFAtUH1SeSA9ghPfcDYDhE0blkrLT8LmCj
	leUan6qvwLxFiH8mStwILSHE32qVHBhI9BH+OihXR+oKz+i8MrjoB8TO5Ouo47G5Vm2y4WpHi3S
	69QyHV93axs8tLvrlD6LxAmobYGNptwThWtE8maUN8yR6WsVZecXHER7lht2srMxI+aHbWW1ooy
	PSY/0YdXepUBgaeLLo6KxdJdy1OfOLy/DFQiKkbCameFAM0DaF48rCtRJ76jhpfaw5SVJUpbCrl
	j1ySNLRna/j1FCWbNzkGhhHo+LrkLssR6hUMulYa+ZZ4mnIq7hSxle3VLlfkKOM8o5zKvkDIHcD
	m+GCjrD/KMMsZycj4nqB+fXAZdyKn2BmA0yxPcy6y4TRzemRPki1D3olfYVIRs+iYMlKv1Ikqct
	PffW2iyk+5ilUDwLFSxyiffAt/jXUNFCxHon+FzOgrWVf45zNgRXNdVDkURn2KTzbJYU0HMqKYf
	RcZoPiGC8NAqYbnXrlvujXXNKU9We3qF7aTVKNbY1QbgwF57NpMMWlv/ixypinhN8KbSqujmKO3
	X6ugjVdBbJWbcGZPriTTA/qIRl7fu6imsbIlMFlZfTeb4YKYT6R0em08XGiktpzO5sNBOMO5RdF
	uDrl9ml5ooQ==
X-Received: by 2002:a05:600c:3ba0:b0:4a7:a5db:a93e with SMTP id 5b1f17b1804b1-4b6db1c5f48mr32230065e9.4.1793956817871;
        Fri, 06 Nov 2026 01:20:17 -0800 (PST)
Received: from xeon ([188.163.112.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b57203a98fsm108358935e9.4.2026.11.06.01.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 01:20:17 -0800 (PST)
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
Subject: [PATCH v2 4/4] iio: light: ltr501: Add support for the LTR-659PS-01 proximity sensor
Date: Fri,  6 Nov 2026 11:19:43 +0200
Message-ID: <20261106091943.35783-5-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106091943.35783-1-clamor95@gmail.com>
References: <20261106091943.35783-1-clamor95@gmail.com>
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
ambient light sensing.

Add a no_als_support flag, similar to how no_irq_support is used, to
isolate ALS register access for the LTR-659PS-01, since ALS registers are
marked as reserved and interactions with them are discouraged.

The ltr501_trigger_handler relied on the scan index to identify channels.
This approach is fragile regarding channel status flags and can break if
the index is not strictly set. Switch to checking the channel type
instead.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/iio/light/ltr501.c | 73 +++++++++++++++++++++++++++++++-------
 1 file changed, 61 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index d5ce6468a229b..e7762115df913 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -151,6 +151,7 @@ struct ltr501_chip_info {
 	u8 als_gain_mask;
 	u8 als_gain_shift;
 	bool no_irq_support;
+	bool no_als_support;
 	struct iio_chan_spec const *channels;
 	const int no_channels;
 };
@@ -192,6 +193,11 @@ static bool ltr501_has_irq_support(const struct ltr501_chip_info *info)
 	return !info->no_irq_support;
 }
 
+static bool ltr501_has_als_support(const struct ltr501_chip_info *info)
+{
+	return !info->no_als_support;
+}
+
 static int ltr501_match_samp_freq(const struct ltr501_samp_table *tab,
 					   int len, int val, int val2)
 {
@@ -656,6 +662,29 @@ static const struct iio_chan_spec ltr301_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(2),
 };
 
+static const struct iio_chan_spec ltr659_channels[] = {
+	{
+		.type = IIO_PROXIMITY,
+		.address = LTR501_PS_DATA,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE) |
+				      BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE) |
+						BIT(IIO_CHAN_INFO_SAMP_FREQ),
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
@@ -1230,13 +1259,24 @@ static const struct ltr501_chip_info ltr559_chip_info_tbl = {
 	.no_channels = ARRAY_SIZE(ltr501_channels),
 };
 
+static const struct ltr501_chip_info ltr659_chip_info_tbl = {
+	.partid = 0x09,
+	.ps_gain = ltr559_ps_gain_tbl,
+	.ps_gain_tbl_size = ARRAY_SIZE(ltr559_ps_gain_tbl),
+	.no_als_support = true,
+	.channels = ltr659_channels,
+	.no_channels = ARRAY_SIZE(ltr659_channels),
+};
+
 static int ltr501_write_contr(struct ltr501_data *data, u8 als_val, u8 ps_val)
 {
 	int ret;
 
-	ret = regmap_write(data->regmap, LTR501_ALS_CONTR, als_val);
-	if (ret < 0)
-		return ret;
+	if (ltr501_has_als_support(data->chip_info)) {
+		ret = regmap_write(data->regmap, LTR501_ALS_CONTR, als_val);
+		if (ret < 0)
+			return ret;
+	}
 
 	return regmap_write(data->regmap, LTR501_PS_CONTR, ps_val);
 }
@@ -1251,16 +1291,21 @@ static irqreturn_t ltr501_trigger_handler(int irq, void *p)
 		aligned_s64 ts;
 	} scan = { };
 	__le16 als_buf[2];
+	unsigned int i;
 	u8 mask = 0;
 	int j = 0;
 	int ret, psdata;
 
 	/* figure out which data needs to be ready */
-	if (test_bit(0, indio_dev->active_scan_mask) ||
-	    test_bit(1, indio_dev->active_scan_mask))
-		mask |= LTR501_STATUS_ALS_RDY;
-	if (test_bit(2, indio_dev->active_scan_mask))
-		mask |= LTR501_STATUS_PS_RDY;
+	for_each_set_bit(i, indio_dev->active_scan_mask, indio_dev->num_channels) {
+		const struct iio_chan_spec *chan = &indio_dev->channels[i];
+
+		if (chan->type == IIO_INTENSITY)
+			mask |= LTR501_STATUS_ALS_RDY;
+
+		if (chan->type == IIO_PROXIMITY)
+			mask |= LTR501_STATUS_PS_RDY;
+	}
 
 	ret = ltr501_drdy(data, mask);
 	if (ret < 0)
@@ -1328,11 +1373,13 @@ static int ltr501_init(struct ltr501_data *data)
 {
 	int ret, status;
 
-	ret = regmap_read(data->regmap, LTR501_ALS_CONTR, &status);
-	if (ret < 0)
-		return ret;
+	if (ltr501_has_als_support(data->chip_info)) {
+		ret = regmap_read(data->regmap, LTR501_ALS_CONTR, &status);
+		if (ret < 0)
+			return ret;
 
-	data->als_contr = status | data->chip_info->als_mode_active;
+		data->als_contr = status | data->chip_info->als_mode_active;
+	}
 
 	ret = regmap_read(data->regmap, LTR501_PS_CONTR, &status);
 	if (ret < 0)
@@ -1569,6 +1616,7 @@ static const struct i2c_device_id ltr501_id[] = {
 	{ .name = "ltr329", .driver_data = (kernel_ulong_t)&ltr329_chip_info_tbl },
 	{ .name = "ltr501", .driver_data = (kernel_ulong_t)&ltr501_chip_info_tbl },
 	{ .name = "ltr559", .driver_data = (kernel_ulong_t)&ltr559_chip_info_tbl },
+	{ .name = "ltr659", .driver_data = (kernel_ulong_t)&ltr659_chip_info_tbl },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ltr501_id);
@@ -1579,6 +1627,7 @@ static const struct of_device_id ltr501_of_match[] = {
 	{ .compatible = "liteon,ltr329", .data = &ltr329_chip_info_tbl },
 	{ .compatible = "liteon,ltr501", .data = &ltr501_chip_info_tbl },
 	{ .compatible = "liteon,ltr559", .data = &ltr559_chip_info_tbl },
+	{ .compatible = "liteon,ltr659", .data = &ltr659_chip_info_tbl },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ltr501_of_match);
-- 
2.53.0

