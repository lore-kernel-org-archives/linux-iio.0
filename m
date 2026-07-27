Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168FC313E17
	for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 14:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785161457; cv=none; b=qfKjNMXsj6uiRioShEYWJOmbf35YHkMmJifOOC4drBsyfCLY00/322HyroFj2pVwjyv2KUVUV41sTTxbzI0Sf1E5hAcFOwMu4eZRvZnGhKp05/plQ0i1oenQyDptFTCwgw7wXvc0kV5dayaa4fENIjqTthG/oC/clSsYNDh8W0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785161457; c=relaxed/simple;
	bh=xH3vJNAk19MPrNE6QAQT/iPmZjRAUZBH2JibYJD/xYc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Au8dqBKzoTBq2zifKhkZumR+2VpBpMvcFw3+t0PCo9DRpGL+IcEFp35aymp8/oeNRO7C/PFcHXdX425C6CzKlLrzJrnRvcJOBpSBwLddMxs1GxkqTsVbZ225drnsYppW2laFT7GwSJBQ9izeQRJIzudHmrjdHEyzOZbC0lbJva4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=gYclcXRa; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="gYclcXRa"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-448b69cfc6dso2308932fac.3
        for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 07:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1785161445; x=1785766245; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kab9DAWIhAckGttNkH5bjDh+HT59M3wQV4Qz4OAw0HI=;
        b=gYclcXRawtGZGmBVedy5iRCfGMUjcjF+texaVhv/XBJxhOZmtiaph8u0Pq0pUfLk+S
         mv6pYgkwJ8E3ZEVGWgvHc/x1WnT2exRzXNC9MMshJP19cklggYW3AtEjSWYcP/NEoXp9
         RxTUzpfO7jD/ozbit9luXvxrHAKqbp9lZo3+sYUNQ08ig25P8rX0yQjGsaaVBxmrdYbI
         UxNZqS+wc3DWBM6WFvsHUbwHybU9NQPAqU/HX8bCnevadH3VOs3CieD9Z/9MniPN/PAk
         0kYd90GmNMTfvi0ps0shA6NMrcqzPSRUORVDTZfy+/OYVfhJmvxt6ryn7k2EAyIJd0Ds
         GyZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785161445; x=1785766245;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kab9DAWIhAckGttNkH5bjDh+HT59M3wQV4Qz4OAw0HI=;
        b=gGwrMveI4l3Pc0i5FTAW2LaZPnAQdfXx6vEurIVucgMBXDf3inBr3FsyC+ZBHsz2FF
         wPzGWUY4sXHn2whTOu0fgHH5I2zn1KQ5ld4/J3Yt0ssXaz64T2qv44OQA/qiTo2RHczd
         PfqMeybflFa5O905ugIGp+aqtTSGXG5Zn2tbaXKLWKjPWFnJtcivsAVrExoo2ZUBuck7
         wa9yvWMTxJ5+zEbK8SpLDzqQd3rbRwNiY43EaEIb95Yz/BxvgFvvic1UPHaiBB5ifMUa
         609kCiasK5gMyNzyG/SoeHKwO/6VHUPwTNSgT9r9hulgHFg0zAd3jkt57u7h8TCPBYCr
         Osbg==
X-Forwarded-Encrypted: i=1; AHgh+RqlizAKOgZQ5QdpIciC098bKUAX8bZpM29JeMSUCZGSLPVSWzXU/6STp4SCk7hf15GCBGPEfegl6Cs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGpxRRN9NeSKLudd8S5J7eUGSATCLEOvqUhRLd5OWSARsJyZ7I
	W3PYr0cYclYjF0xcRQx64gJx34U2XsjSnwlUE9mhQf0yemvMpRhrxLpomGJVjQFZSR0=
X-Gm-Gg: AR+sD10L5PXBjXKGnq+SrK4Bs+TO1RS6bpsvQm+AbT6lgbNcd9eBjmdbdcQFOfxbDBo
	qrfnahXwlJG1asFdqSRLAcBDeyxb9jDRq2zMBqZzIOfluzswpA5Xx7NBVgQGMbRScSxEc+8whxN
	LnMoyAEQa/WgRgXLdrBsVccJWLVEKVJqeD5vCG14XCWQ3a178hIqMbphHUH7zc1OAHOIAaHWszv
	HTeub1thsLby+9+5EIveFYvXnTXC3zU1HI+UzXOHkRPYM2jXFsPwR2iEzMm7yMygIGezoia3kbI
	QokdKjw0LEpuddEWwSBlrZ4hMupnCphX5aOtM3kQlg3q4GAUr2jaGbVFvRu2G+uoPNcYxLuo1Og
	SAWLDgppdX11/kvJGGNfvE/klF85AkZ790HA6ckNplFhKhEUh3fI4wtMy8VG8h3MfpdsKZXgsDM
	JiYQ8h1bk=
X-Received: by 2002:a05:6870:80cf:b0:448:c864:2ed6 with SMTP id 586e51a60fabf-457f2862b1dmr7646474fac.39.1785161444890;
        Mon, 27 Jul 2026 07:10:44 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:41b4:f2ef:8a0a:2104])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-45767486cf6sm15998645fac.15.2026.07.27.07.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 07:10:44 -0700 (PDT)
From: "David Lechner (TI)" <dlechner@baylibre.com>
Date: Mon, 27 Jul 2026 09:09:51 -0500
Subject: [PATCH v3 2/2] iio: adc: ti-ads112c14: add support for buffered
 read
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-iio-adc-ti-ads112c14-buffered-read-v3-2-cbbcaf030148@baylibre.com>
References: <20260727-iio-adc-ti-ads112c14-buffered-read-v3-0-cbbcaf030148@baylibre.com>
In-Reply-To: <20260727-iio-adc-ti-ads112c14-buffered-read-v3-0-cbbcaf030148@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Chris Hall <c-hall@ti.com>, Patrick Edwards <pedwards@ti.com>, 
 Kurt Borja <kuurtb@gmail.com>, Nguyen Minh Tien <zizuzacker@gmail.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "David Lechner (TI)" <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=7691; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=xH3vJNAk19MPrNE6QAQT/iPmZjRAUZBH2JibYJD/xYc=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqZ2baPaXLmIJaqS4JoPU/N34/SwTrwNbvzmv8F
 169sLknQy+JATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCamdm2gAKCRDCzCAB/wGP
 wH4lB/0YvtMocf/Y25z7W7f8tKZyMAy3OH83JxM4bmqvG709BO2dvvjCBHxe2u61tgmNyTT2L8w
 csN7yc4GQ7TTA59L2YVXXnU1L+N7gIGWrZLr329IzzRrEeCrCjAACnnlYABtNlVMep+Q7c2tk0e
 gGKNxotHDrh4CyZvpVo2IiiVpWHBlTI7xxLl/GmPBS6AyBy7LVh75apmLWdOWQaI7DVUjNTN9um
 3tkY78ZT/csJgAAn142M2WlAcpTJpI32oB5+yvpSmHNiWhiLRe+SXFsy46MkO+gnv0bnypUD9cI
 RuR2KSpX7i4rBhOE+xIcVpmT4vLox2kR8yJLdSnnBsX9zvJp
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add support for buffered reads using a triggered buffer.

The device has a continuous conversion mode, but that can only be used
with one channel at a time since there is nothing like a sequencer to
support that in hardware. Instead, we use single-shot reads like we do
for direct reads to be able to read multiple channels.

Since CRC is always enabled, buffered reads include the CRC byte along
with the raw data without verifying it. This allows userspace to perform
it's own CRC verification per-sample and drop bad samples rather than
failing the entire buffered read for one bad sample.

Support for continuous conversion mode could be added in the future if
needed.

Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
---

v3 changes:
* Fix >= should be > ADS112C14_MAX_MEASUREMENT_CHANNELS.

v2 changes:
* Rebased on iio/testing.
* Don't say how to implement continuous conversion mode in the commit
  message.
* Explain CRC usage in buffered reads in the commit message.
* Added comment on updating the template for system monitor channels
  with dynamic values.
* Refactored total channel count to always use i++.
---
 drivers/iio/adc/ti-ads112c14.c | 108 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 104 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ti-ads112c14.c b/drivers/iio/adc/ti-ads112c14.c
index 5610d16f4467..60eab4852ba2 100644
--- a/drivers/iio/adc/ti-ads112c14.c
+++ b/drivers/iio/adc/ti-ads112c14.c
@@ -15,7 +15,10 @@
 #include <linux/dev_printk.h>
 #include <linux/device/devres.h>
 #include <linux/i2c.h>
+#include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
 #include <linux/math64.h>
 #include <linux/minmax.h>
 #include <linux/module.h>
@@ -29,6 +32,9 @@
 #include <linux/unaligned.h>
 #include <linux/units.h>
 
+/* Arbitrary limit since channels are dynamic. */
+#define ADS112C14_MAX_MEASUREMENT_CHANNELS 16
+
 /* Datasheet t_d(RST) - time to wait after reset before next I2C use. */
 #define ADS112C14_DELAY_RESET_US 500
 
@@ -255,6 +261,8 @@ struct ads112c14_data {
 	u32 num_measurements;
 	u8 sys_mon_chan_short_gain_val;
 	int sys_mon_chan_short_scale_available[ARRAY_SIZE(ads112c14_pga_gains_x10)][2];
+	IIO_DECLARE_BUFFER_WITH_TS(__be32, scan, ADS112C14_MAX_MEASUREMENT_CHANNELS +
+						 ARRAY_SIZE(ads112c14_sys_mon_channels));
 };
 
 static bool ads112c14_writeable_reg(struct device *dev, unsigned int reg)
@@ -575,7 +583,7 @@ static int ads112c14_prepare_sys_mon_channel(struct ads112c14_data *data,
 
 static int ads112c14_single_conversion(struct ads112c14_data *data,
 				       const struct iio_chan_spec *chan,
-				       u8 *buf)
+				       u8 *buf, bool for_scan)
 {
 	struct i2c_client *client = to_i2c_client(regmap_get_device(data->regmap));
 	u32 reg_val;
@@ -605,6 +613,24 @@ static int ads112c14_single_conversion(struct ads112c14_data *data,
 	if (ret)
 		return ret;
 
+	/*
+	 * When doing buffered read, we don't check the CRC, but rather pass it
+	 * along with the raw data. This way, we don't silently drop samples
+	 * with CRC errors, but rather leave it to userspace to decide what to
+	 * do.
+	 */
+	if (for_scan) {
+		u8 len = BITS_TO_BYTES(data->chip_info->resolution_bits) +
+			 (data->i2c_crc_enabled ? 1 : 0);
+
+		ret = i2c_smbus_read_i2c_block_data(client, ADS112C14_CMD_RDATA,
+						    len, buf);
+		if (ret < 0)
+			return ret;
+
+		return 0;
+	}
+
 	return ads112c14_i2c_read_bytes(client, ADS112C14_CMD_RDATA, buf,
 					BITS_TO_BYTES(data->chip_info->resolution_bits),
 					data->i2c_crc_enabled);
@@ -639,7 +665,7 @@ static int ads112c14_read_raw(struct iio_dev *indio_dev,
 		if (IIO_DEV_ACQUIRE_FAILED(claim))
 			return -EBUSY;
 
-		ret = ads112c14_single_conversion(data, chan, buf);
+		ret = ads112c14_single_conversion(data, chan, buf, false);
 		if (ret)
 			return ret;
 
@@ -765,6 +791,10 @@ static int ads112c14_write_raw(struct iio_dev *indio_dev,
 	const int (*scale_avail)[2];
 	u8 *gain_val;
 
+	IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
+	if (IIO_DEV_ACQUIRE_FAILED(claim))
+		return -EBUSY;
+
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE: {
 		guard(mutex)(&data->lock);
@@ -863,6 +893,37 @@ static int ads112c14_read_label(struct iio_dev *indio_dev,
 	return sysfs_emit(label, "%s\n", label_source);
 }
 
+static irqreturn_t ads112c14_trigger_handler(int irq, void *private)
+{
+	struct iio_poll_func *pf = private;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct ads112c14_data *data = iio_priv(indio_dev);
+	u32 offset = 0;
+	u32 i;
+	int ret;
+
+	iio_for_each_active_channel(indio_dev, i) {
+		const struct iio_chan_spec *chan = &indio_dev->channels[i];
+
+		ret = ads112c14_single_conversion(data, chan,
+						  (u8 *)&data->scan[offset++],
+						  true);
+		if (ret) {
+			dev_err_once(indio_dev->dev.parent,
+				     "failed to read channel %d: %pe; additional errors will be suppressed\n",
+				     chan->channel, ERR_PTR(ret));
+			goto out;
+		}
+	}
+
+	iio_push_to_buffers_with_ts(indio_dev, data->scan,
+				    sizeof(data->scan), pf->timestamp);
+out:
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
 static const struct iio_info ads112c14_info = {
 	.read_raw = ads112c14_read_raw,
 	.read_avail = ads112c14_read_avail,
@@ -908,7 +969,7 @@ static int ads112c14_parse_channels(struct iio_dev *indio_dev,
 		return -ENOMEM;
 
 	channels = devm_kcalloc(dev, num_child_nodes +
-				ARRAY_SIZE(ads112c14_sys_mon_channels),
+				ARRAY_SIZE(ads112c14_sys_mon_channels) + 1,
 				sizeof(*channels), GFP_KERNEL);
 	if (!channels)
 		return -ENOMEM;
@@ -1069,14 +1130,47 @@ static int ads112c14_parse_channels(struct iio_dev *indio_dev,
 		if (spec->type == IIO_RESISTANCE)
 			spec->differential = 0;
 
+		spec->scan_type = (struct iio_scan_type){
+			.format = measurement->bipolar ?
+				  IIO_SCAN_FORMAT_SIGNED_INT :
+				  IIO_SCAN_FORMAT_UNSIGNED_INT,
+			.realbits = data->chip_info->resolution_bits,
+			.storagebits = 32,
+			.shift = 32 - data->chip_info->resolution_bits,
+			.endianness = IIO_BE,
+		};
+
 		i++;
 	}
 
 	data->num_measurements = i;
+	if (data->num_measurements > ADS112C14_MAX_MEASUREMENT_CHANNELS)
+		return dev_err_probe(dev, -EINVAL,
+				     "too many measurement channels defined\n");
+
 	memcpy(channels + i, ads112c14_sys_mon_channels, sizeof(ads112c14_sys_mon_channels));
 
+	for (u32 j = 0; j < ARRAY_SIZE(ads112c14_sys_mon_channels); j++) {
+		struct iio_chan_spec *spec = &channels[i];
+
+		/* Update the template that was already copied with dynamic values. */
+		spec->scan_index = i;
+		spec->scan_type = (struct iio_scan_type){
+			.format = IIO_SCAN_FORMAT_SIGNED_INT,
+			.realbits = data->chip_info->resolution_bits,
+			.storagebits = 32,
+			.shift = 32 - data->chip_info->resolution_bits,
+			.endianness = IIO_BE,
+		};
+
+		i++;
+	}
+
+	channels[i] = IIO_CHAN_SOFT_TIMESTAMP(i);
+	i++;
+
 	indio_dev->channels = channels;
-	indio_dev->num_channels = i + ARRAY_SIZE(ads112c14_sys_mon_channels);
+	indio_dev->num_channels = i;
 
 	return 0;
 }
@@ -1303,6 +1397,12 @@ static int ads112c14_probe(struct i2c_client *client)
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &ads112c14_info;
 
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
+					      iio_pollfunc_store_time,
+					      ads112c14_trigger_handler, NULL);
+	if (ret)
+		return ret;
+
 	return devm_iio_device_register(dev, indio_dev);
 }
 

-- 
2.43.0

