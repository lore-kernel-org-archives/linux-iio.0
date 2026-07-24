Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4839442D75B
	for <linux-iio@vger.kernel.org>; Fri, 24 Jul 2026 15:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784908535; cv=none; b=d4rTmZqK9GjEhmXud6H7pOtl9RNsk+l414TozIbivXY0d2tGkBALfAJfeaXnEjnlw3VsllKpJTeav7Is1ONQJzCIWJ6tbPSBuaVuBTMdjj9c7FdywiUujlecimAHFQnaC4gnqbPZ4HC0l5Sqpfe65JA/zl00PZf4uiDdl+EBaFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784908535; c=relaxed/simple;
	bh=ZaWOvelJv5bYIAvvNRBNpGwUfXwkW2TNg4nkmRV6Zts=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fej4Quv6DjHUOgXs/DvxGoWQWwh4vZl91fddssshu2RZmCbLYyFaPPVtfsvHaCYoS+9OnDWuq1sM1Tk4olrE9UG4wpC4BwbX/n952xn54BVt1M5BFHX/hoGbjm1e7f64W87E0UdEOr3X+S4BhflrggyrL+prn/c+K5g2BfPQfww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=SQUjovIg; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="SQUjovIg"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7e9f69ee6f4so444220a34.2
        for <linux-iio@vger.kernel.org>; Fri, 24 Jul 2026 08:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1784908532; x=1785513332; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qSEN+009lnU4b5a7hshNtk0fuwqcDxCxvgsAK1D6mJo=;
        b=SQUjovIggJwdxmUtYu/Hz0I8pX/MqwY+vYPHqIJGBRAruLd/4z8/VWAU9zEsnR9Zh7
         jxCZ52L1tjDCYgZxjChlwLfh2g8ML5GnJb97pq/Oc2oH8SYSFRDj6qou3uJnNVGM3ao7
         YkcyHWOmN1wGzvU80BCWMRz5Cb1DOYmPbFOnO40TGPJzm41naeQq8KoggnanSLjF0QLs
         Ij7FjetrAuTLayWAfwSYliyg5ISalzqHkdRb72TRVI8BTmzRr4XW/+sc3LREzx0XSktW
         Q69NQLVZHlalXxidn/X9mARA94YmRxSb34GJeVX284+EfkoJZUmaMkSGs+JJyXmKMHHI
         gBUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784908532; x=1785513332;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qSEN+009lnU4b5a7hshNtk0fuwqcDxCxvgsAK1D6mJo=;
        b=HnMhNDgNYKoI9INEW2YMZ81Bl7rYM1gk0XdR8d+Q79GLEShLgqkQm+U4l9AJbIMPuc
         34Nvbaee8jQ3qb0Hc3dwRGP9v24LtyjMmiu+Oaty+/3wL2oPnzTwBFo6rLBaqsdB5PF/
         e9McudxLguxyuTDyIHcug6PVn4OzwvCDn97OAgRtaLQSUed8xrSyrhveI7cQnerAG3oX
         lOX+Z66KzlmJA3bWvAzwKvFli/04FcT/MhxbF77mXxVzWUL/94Bhs5ZPgyaWXtmgQTN4
         DFxyHTUB6neZ4hQ7vsuuodOLScRcRw3nggzArpCe99PE3A7QqmcnG1WMhlHyWvJ4aaVP
         /eFA==
X-Forwarded-Encrypted: i=1; AHgh+RpDsriS4oqeOGXXvRLNa52ko0HBfUwJjK7iavOvS2XADmMQ5KnnooHfUv41/8WERmhJsrj0QtqK8Gg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxtIQC7WrMd2jCkVZFmZcOhls8cD1+T/rpAjRYE6UWeEvX9qC7
	GMwL13lEM4y1YIXttSv2BLFj/za7vr5D75I7D7bxWHV9jE/VgDuXvMNuLKTiNpsPa5s=
X-Gm-Gg: AR+sD13soyMtKJCDe7W3kApxUC/aUDpYS0uwS1Zu2nn1k6XUI1F2tLOkNgKpMuGiEkw
	A7d7IV9ODaiSkY9C0X+BBFOE8OrDYGcT/QigIHR4Mzsu3EbFsueUpeozZN3TvQwyAV1sFkH/xWO
	TuAiIgEQLsUaP1m2YbT7FPbLnGjrAcSMJhivBLmd8QUd+mfmdEDvxFhk2VH/xNBHln0Qc8r7gQH
	dDiypCXSqeNaQCuIuc44f5dBC6BVNVwb8vnd3kpswq2ctx7f31t4hjSzBcDO3qL4wbHsgC8aARs
	e5z8gL2C9/lKQi/tghZTfePh6hxxd2tHp24AOhjhVAi4pOusT8pJulaoOmwiHWJQUdKu6i8cqqB
	2e6FoULJE0aDP2Ok1CYY2+yVtUlDoZHOz4AeZGlQpZRn4q13Kmuk+Z5kbdU3coGGkBlRkx6b719
	cKi4yi5A==
X-Received: by 2002:a05:6830:83b8:b0:7ec:6749:f38f with SMTP id 46e09a7af769-7ee43e1a6f0mr5421714a34.22.1784908532150;
        Fri, 24 Jul 2026 08:55:32 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:b635:d463:c98:cc75])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ee2a03eba8sm6160911a34.17.2026.07.24.08.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 08:55:31 -0700 (PDT)
From: "David Lechner (TI)" <dlechner@baylibre.com>
Date: Fri, 24 Jul 2026 10:55:07 -0500
Subject: [PATCH v2 2/2] iio: adc: ti-ads112c14: add support for buffered
 read
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-iio-adc-ti-ads112c14-buffered-read-v2-2-98b06f3d47d9@baylibre.com>
References: <20260724-iio-adc-ti-ads112c14-buffered-read-v2-0-98b06f3d47d9@baylibre.com>
In-Reply-To: <20260724-iio-adc-ti-ads112c14-buffered-read-v2-0-98b06f3d47d9@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Chris Hall <c-hall@ti.com>, Patrick Edwards <pedwards@ti.com>, 
 Kurt Borja <kuurtb@gmail.com>, Nguyen Minh Tien <zizuzacker@gmail.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "David Lechner (TI)" <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=7619; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=ZaWOvelJv5bYIAvvNRBNpGwUfXwkW2TNg4nkmRV6Zts=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqY4rrIcPOilJ37loqyM6K7h9FH+UzfYFA5d3lK
 KGq2roh33iJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCamOK6wAKCRDCzCAB/wGP
 wB7TB/9sK9+m7wlX7cZe6LJTvssePDqKx4AUmBjtVgCnWBuORlY4F+b9VVX445a6WgAIajcUb3l
 fjqThSUmxllJvYne5zjEE2xvoz2p/cHGh3TZiMUsPoPH1i6uc0+quHe9kC8AdJWLPVt2ARkbt/j
 7dvDq1tiaVXv6TcI7oKOhUjuEwDzLNPV9uhugi5B/wvW3fSThXLCHISnbLdugyQg07hfHIaRyr9
 KVw8ttCjOi5SKDz+C9blEEqZ60srhaQPnaI/RU8Cg2S8GptE0mKuCt5w5mM3Tn1IxI/7Yzzb5nM
 2RZKp3EwCnM3Qei8BdainDKMCXpBL4VuWjtppywCfeIqI2Y7
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
index 80d712049d15..8ad8caee0ff7 100644
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
+	if (data->num_measurements >= ADS112C14_MAX_MEASUREMENT_CHANNELS)
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
@@ -1304,6 +1398,12 @@ static int ads112c14_probe(struct i2c_client *client)
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

