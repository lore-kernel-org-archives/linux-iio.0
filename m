Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794131014;
	b=FDU+1nV6UELzW6li6YGobO7oc3dtogb2CBO+surNTeOKJYCapJS/UtCqWtA9SXoYupNi
	 PLFCg81akk+pODBwuRvLTsDYM+c4fVJ09A2ZjM5un16lci4pF5K0TdgwMRkbvVAJaEuq1
	 QdPicszSELYASAAh7gj8VKe7k2lU5PmVFAFgcVT9iuvLleZ2FQVZtDaWDzy5hzc413sUs
	 7xMIxZ+OBPuYmWQ5g6ZgF1LH+mX2c5CHiq/GND0Z+XUgIZaMtHGvnEC/DW6AWT/GvbZqv
	 HElo3bQvhqsD3TWiZMf/fPoAnWw472Be8+ZtmQ/fABM1nfpBSo2fo+8y3JE4bsdPudw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794131014;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=o3txUQbGmlLlC/W6WkzGi1vXNK5jT1AVFbEBwBiKJh8=;
	b=A07OYCRm1xDGIqBs8oGxiQxHCpqbTAyCkliJCrfhcA68FsTsGt/2M0pgVRTNUoUBsNOp
	 JGiNP4ke5IITfZ+FqYiHvTk8TWcuok5R+XuquYWhpVgUdMhL13EipJd2IgJgViWa19hNq
	 Hk25l5QqH2zwoP8EpokLssSg9ReULH/YUxaNqYor8jit5znMohIcj9KZymGoEC9noo6oG
	 vE14VHGeWLLmDB8js5K04uilOZpCrqe9IWScO/XKdmnRVwgL0daBiXbdJ05GpwHohhd/S
	 nChRacfSCCwp+h/dhLaXdNMmEZHjtI4h7AGRXIPEKIqbMkDD8DT+BX9zGDke73oB4+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p+2qtOWg;
	arc=none smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AEE606A320
	for <linux-iio@vger.kernel.org>; Sun,  8 Nov 2026 09:43:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75AEE606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p+2qtOWg
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b7245ab5e2so76225a12.1
        for <linux-iio@vger.kernel.org>; Sun, 08 Nov 2026 01:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794131012; x=1794735812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o3txUQbGmlLlC/W6WkzGi1vXNK5jT1AVFbEBwBiKJh8=;
        b=p+2qtOWgDXyYsw2NGoEMBkaCwK/CGliQMa7LeJ5uA/J/+XJmwnZYmdHso10YvTom7A
         SyIZoZsErvIfgtcMXnyIEJC2cNIHuo1AXxgrr4bdXEI9GWGymhq30Eul4j4OuK85s3dE
         OayAW//g+00+ZUNFGncYe0QzC1o/Y2szxt8c4UGWL+2yE6zCrXGTJmQBnb74PuZdm5BP
         i4lyl39wWivebywC3BHAICYCC+uMl9kowsclpzYoznKGHIAyf0ZSvS8qiw+1cL/2GFST
         OHKe8k3/qPPvtmjEqKCo3gjaSlxM3DfmCOEFw7JjT1MhUmGL3bxu3+hDKsEq7NqaOMKX
         c/ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794131012; x=1794735812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=o3txUQbGmlLlC/W6WkzGi1vXNK5jT1AVFbEBwBiKJh8=;
        b=vAa1pZ4LXq2HflEjOfmpXBAUztlQ2zuieSkUa2E/v1edpmz9ex/lB0xj6c73XpT4rI
         0tJ3Yy5FB2FAR4aanPxYobBHF1RJTv+pF6Iv7yh09SpX3yQKgzCt4uZnLjfOCknlGV8W
         NAQseCxyCLiBpPb6+WXRzhsFvaOrJkEJZoz0FIAkpnhrJJm/MY5xzwmOSBTgMG0xY/d5
         RoXKeY2KnoIbNSc1oet3Gt0/5m3Xj5XEf2egmFXgRTmyIzfZY5cIAUC69D6ZtjC2IRbH
         jnogdNvlOcJ0H0qz+FvhxBsQCazkgFQsHFwGdYI8OmnDHpXlPQUsLjf9EpKbR90uUvNt
         iplQ==
X-Gm-Message-State: APuU4Z+Vwjti4CKyg+V5Cnr5XXaObDhGTqdPUZTXpRS2PaC/WFW+6s6C
	pnhHHFwk7BwmcXBvn88SYi0+eMqL/JE/h/ZK2cvPxuxheyNnj9c6q3d2
X-Gm-Gg: AYBFou3dhMGyrUWEr3hLLzzHeeJfuqZ7qs6sBU2MsnbCaWYvtXxanEHJLr4dltd6mit
	EFjliyC8Z8xMJxYRSWIWvjKLIp9k9JXIEloj+lclAE4BezJZAbQc0b/t4kKfQFuloGbF7NpT/Bc
	Nl2eo3k/6dMjYljH1KnYdOlZ0Oq/n92kfmXIUr9IYnvC4mCwSZ0LI3vwfrDJD+MVL4/IQhtTJg8
	gVRDi3OyMNSRD+6+xbdcXwmpCMsI95wpVgaiQn8FOubTm2GnHeXS/olIaNCgcfyPHMbeMuh2h5U
	2f8sw8VHf/gJT+q1rr0vAGp5QTAbkqYl0k72UkVY+umRffpMvLX/P+cwWd/JuzI9FVM0t5HZfzc
	RSZKIFkV9WLyHsv4aFDDHGPxvm1GiRQEYJ5KyD/XErYURti5qERE9nVfotyE8bnCETaYhsSlOgv
	zjlt4M4+Aux7sKHADyKbhC18obcUIdeantxd9XnGkimj1OfrsOVOee5Ig5Ap08R0ynobIlOt0a1
	90XVxMDuBO9QnW0KuWYDylmZwiLWP628Lnh09+l6tMIyUEhLOH7cvTzjCAbKd/LmstChCYA5gxB
	HdNQqr3ONBrIpCa+dn642l60MBkh/zinzisa4CNCXOwklDxHfS8rh8MQBBBN7Ifpvyjq8GgkmXN
	a7nY6b2+4dAVrfkN612ia4kPCV8deek4=
X-Received: by 2002:a05:6402:1e92:b0:6b5:76bb:4522 with SMTP id 4fb4d7f45d1cf-6b7223732e0mr708896a12.2.1794131011650;
        Sun, 08 Nov 2026 01:43:31 -0800 (PST)
Received: from xeon ([188.163.112.62])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b721ea56f2sm436321a12.8.2026.11.08.01.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 01:43:29 -0800 (PST)
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
Subject: [PATCH v3 4/4] iio: light: ltr501: Add support for the LTR-659PS-01 proximity sensor
Date: Sun,  8 Nov 2026 11:42:53 +0200
Message-ID: <20261108094253.83899-5-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261108094253.83899-1-clamor95@gmail.com>
References: <20261108094253.83899-1-clamor95@gmail.com>
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
 drivers/iio/light/ltr501.c | 76 ++++++++++++++++++++++++++++++--------
 1 file changed, 61 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index ca6c8cffb4001..b97b8da98e86c 100644
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
@@ -654,6 +655,29 @@ static const struct iio_chan_spec ltr301_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(2),
 };
 
+static const struct iio_chan_spec ltr659_channels[] = {
+	{
+		.type = IIO_PROXIMITY,
+		.address = LTR501_PS_DATA,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),
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
@@ -1239,13 +1263,24 @@ static const struct ltr501_chip_info ltr559_chip_info_tbl = {
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
+	if (!data->chip_info->no_als_support) {
+		ret = regmap_write(data->regmap, LTR501_ALS_CONTR, als_val);
+		if (ret < 0)
+			return ret;
+	}
 
 	return regmap_write(data->regmap, LTR501_PS_CONTR, ps_val);
 }
@@ -1260,16 +1295,21 @@ static irqreturn_t ltr501_trigger_handler(int irq, void *p)
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
+		const struct iio_chan_spec *chan = iio_find_channel_from_si(indio_dev, i);
+
+		if (chan->type == IIO_INTENSITY)
+			mask |= LTR501_STATUS_ALS_RDY;
+
+		if (chan->type == IIO_PROXIMITY)
+			mask |= LTR501_STATUS_PS_RDY;
+	}
 
 	ret = ltr501_drdy(data, mask);
 	if (ret < 0)
@@ -1337,11 +1377,13 @@ static int ltr501_init(struct ltr501_data *data)
 {
 	int ret, status;
 
-	ret = regmap_read(data->regmap, LTR501_ALS_CONTR, &status);
-	if (ret < 0)
-		return ret;
+	if (!data->chip_info->no_als_support) {
+		ret = regmap_read(data->regmap, LTR501_ALS_CONTR, &status);
+		if (ret < 0)
+			return ret;
 
-	data->als_contr = status | data->chip_info->als_mode_active;
+		data->als_contr = status | data->chip_info->als_mode_active;
+	}
 
 	ret = regmap_read(data->regmap, LTR501_PS_CONTR, &status);
 	if (ret < 0)
@@ -1350,9 +1392,11 @@ static int ltr501_init(struct ltr501_data *data)
 	data->ps_contr = status | LTR501_CONTR_ACTIVE;
 
 	if (ltr501_has_irq_support(data->chip_info)) {
-		ret = ltr501_read_intr_prst(data, IIO_INTENSITY, &data->als_period);
-		if (ret < 0)
-			return ret;
+		if (!data->chip_info->no_als_support) {
+			ret = ltr501_read_intr_prst(data, IIO_INTENSITY, &data->als_period);
+			if (ret < 0)
+				return ret;
+		}
 
 		ret = ltr501_read_intr_prst(data, IIO_PROXIMITY, &data->ps_period);
 		if (ret < 0)
@@ -1579,6 +1623,7 @@ static const struct i2c_device_id ltr501_id[] = {
 	{ .name = "ltr329", .driver_data = (kernel_ulong_t)&ltr329_chip_info_tbl },
 	{ .name = "ltr501", .driver_data = (kernel_ulong_t)&ltr501_chip_info_tbl },
 	{ .name = "ltr559", .driver_data = (kernel_ulong_t)&ltr559_chip_info_tbl },
+	{ .name = "ltr659", .driver_data = (kernel_ulong_t)&ltr659_chip_info_tbl },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ltr501_id);
@@ -1589,6 +1634,7 @@ static const struct of_device_id ltr501_of_match[] = {
 	{ .compatible = "liteon,ltr329", .data = &ltr329_chip_info_tbl },
 	{ .compatible = "liteon,ltr501", .data = &ltr501_chip_info_tbl },
 	{ .compatible = "liteon,ltr559", .data = &ltr559_chip_info_tbl },
+	{ .compatible = "liteon,ltr659", .data = &ltr659_chip_info_tbl },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ltr501_of_match);
-- 
2.53.0

