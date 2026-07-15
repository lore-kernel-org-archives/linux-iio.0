Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CF023ED60
	for <linux-iio@vger.kernel.org>; Wed, 15 Jul 2026 00:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784074807; cv=none; b=kb/cqSYtiOJKbSr6WeX1l0xnvzsufm1YVACQmpR9GVfi7bIxgiUlcF80Dnu+UjXmBFa0pv0NIrNyJ5VsOkSOjlTLreU8KOUDR4rT+06cZuZexVAAgogHL12busUWNV60ebstPKh3mDoCElfqI/+3iSeuqyjcDrcuxOeuXE+sii4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784074807; c=relaxed/simple;
	bh=F7uehXGTkndv6ihXbLs2vu47tYBk+ugQD/7Z1ipiJs0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t4ekcNAhiG2YruUcvD36yF13Mj8xBuw1i+gfjdzsEXY/ua4ZsodGJ27RqR5tEy2Tzk8mcj4DSwj2TZB9t47zckS1xJ6W0Lqa/4sfyXyCBnzo7R1W9aADY5aJhG4SZ+8FH1tUwULHlVaVYBsqx/OQ8zW/GGO+gXLl0OLRHFcyunA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=TFjWDCTI; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="TFjWDCTI"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-43bfe209e45so1247214fac.0
        for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 17:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1784074804; x=1784679604; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LWRbxdASCdWKyZ3TvrDr8088Qpx03IBe8BQQlo35n/Y=;
        b=TFjWDCTIRRjswslP1wTxuKQoOSEtyje98T9tSrcRohj+1569THDI5p0OoueooHrYVO
         +s6ygE+FV3lOBjE6hwzaycgXvRIp8M5p6cigNqD8UyJnaoLuQB2V2SuL5+ZDJQLTOc6X
         RgGDJ4RQt6o6DD6xq/mIwVhbEyT2gkMqtu9PxRsOY6+O2SQc5hwCVVMjdh6LWdCRaOgr
         /qzFuw4OI8M5PWFSPyMcCkTKVZdbbAgptNsI3Ju7ocXkjBLp4l9UlbuednRP5qIqWC/O
         fVgDjU3Sa+y4Fdw3e/FH/AFcjpvnl7uavw8/2k5iGwc4j07CvlSrDLZm/pGRnEdGAv2G
         /vwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784074804; x=1784679604;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LWRbxdASCdWKyZ3TvrDr8088Qpx03IBe8BQQlo35n/Y=;
        b=VPBtx/01VcsLfg3rCEa0xN79IphuUQMDMQKUruEFGWRs4uFMZAZnT4bxEmrxOjhvdS
         4I0vLddM15g7EBFUk76GFUWlRcKr+Tjxi/nO3Vug6IgXTdyJAAW97EOVH0cuf4ihQu46
         UcSnhiQlFMgAOO//jXRJNu/7mXqSlW0v5WjhBPMQMNIIw0FZBSiAZFi4wwVxG5gx0IEO
         Wtspa6XCTG+bRBi5V68uIid3P9ynKznbVLeupDxo1GcjFlCLdIoXWgKrBppy13SoyuAg
         6+XpAiBh7r2ob3uEdRxA82IGhHGxKKEWZp5THGVjko5TJA1E9eE6y3ZWJS7goVsX0EUf
         ED8g==
X-Forwarded-Encrypted: i=1; AHgh+RqNfy2Di0ZzP8EFICP+sFO06eEsz/Q41qhbiG74kQFWJ6d9jZK8mBxw/8XTbuQctVfpqnbaAR8779o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYqRKl59hfF7odDvIfvVkowqTxeoHsX8VNfW2xzRjOp8BrYRxG
	JDNIGv2i48LkJwYy3A7IIDXHvJzIeiGTkA+8Xt+z5MQTgNE/SNTOrDnV1tUbPl7JSjvGhzOug/V
	OaO3S
X-Gm-Gg: AfdE7clkwAg3EuY9m0eZPPh/uVL1U5XHABHQnZm/E79G5gV+rq1BOLaEYXsDDWEUj7t
	WdPurs4M46kFd12P3/ETvw7vauMwK5xBtyNdMaLGVfBnaKHWSSBUpRcnnZtSXrH1I13nUgTyIvd
	6oQUYayJx8vM4hUD7t+pqkj0VTE04d9miSI7dHCj1PKnNiSiruEK05xGrS7DGYDTl2M1dKbFUwi
	Uvp3FsgfbqeDanVt6D9Wf99fIYREc5CiRdROTKnizMUZJMaju4WcW8t4wzMxkApAlE9dMaEATKC
	fBDM7owFA5hiefcrV4FqjKbFqsM6tsX3PgUQ70MTbdCID4y9gVJ0VVqd2WO3gzziMKg9t3OYW05
	R4PnE32oFYrOTi6S0fuleElUPHGiYTeBGonqkumJiq6LuZvi/b3TAPGGVadeK0G8p+d+kyArOwr
	qkDUK54uRzNRSd7EqU1Q==
X-Received: by 2002:a05:6871:5225:b0:448:558c:d8c7 with SMTP id 586e51a60fabf-451f1485119mr8363700fac.37.1784074803907;
        Tue, 14 Jul 2026 17:20:03 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:280e:69fd:7612:d5a9])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-455b767413dsm8047305fac.3.2026.07.14.17.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 17:20:03 -0700 (PDT)
From: "David Lechner (TI)" <dlechner@baylibre.com>
Date: Tue, 14 Jul 2026 19:19:32 -0500
Subject: [PATCH 3/3] iio: adc: ti-ads112c14: add support for buffered read
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-iio-adc-ti-ads112c14-buffered-read-v1-3-fe6e1c971288@baylibre.com>
References: <20260714-iio-adc-ti-ads112c14-buffered-read-v1-0-fe6e1c971288@baylibre.com>
In-Reply-To: <20260714-iio-adc-ti-ads112c14-buffered-read-v1-0-fe6e1c971288@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Chris Hall <c-hall@ti.com>, Patrick Edwards <pedwards@ti.com>, 
 Kurt Borja <kuurtb@gmail.com>, Nguyen Minh Tien <zizuzacker@gmail.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "David Lechner (TI)" <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6896; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=F7uehXGTkndv6ihXbLs2vu47tYBk+ugQD/7Z1ipiJs0=;
 b=kA0DAAoBwswgAf8Bj8AByyZiAGpW0imiz67irHdK0psKZ4mSTPPqIKVR70UqBtdT9ux7Dra3v
 IkBMwQAAQoAHRYhBOwY2Z5iDoPWnNhomMLMIAH/AY/ABQJqVtIpAAoJEMLMIAH/AY/A2B8H/A5S
 zBbw9OmQ5Cj0zMPXbS8O1YY4w+iTh6wgE6aQGAxMskmlVGSWxTu54YhFYQa/mVfLW/KZs+rBfeP
 v0X7tl4piUo0d6pT/x8STRdU0aYH6saY2Sa7A+9Tv1e9rdZ8eqpbRcZfO/mQbqJz+DoKCzj7aA4
 v945IJi1IO2iF42fOYIIhQjNCSJjmbmcZ2h2Vz6Gj9XkLDyPL+D1mBL/kvqimhOjCJC4lN+Nle4
 fcgNTGvGEU7LOYDjAnTOWkZwAB91AXeRcSq2FdlkLw4ORjtXsLKeb4Z4GkrQ6SbE6WjtF4L1tQr
 knYoAQU3aij/zexKugevSUPIPCnAgem09zG9/1A=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add support for buffered reads using a triggered buffer.

The device has a continuous conversion mode, but that can only be used
with one channel at a time since there is nothing like a sequencer to
support that in hardware. Instead, we use single-shot reads like we do
for direct reads to be able to read multiple channels.

Support for continuous conversion mode could be added in the future if
needed via a 2nd buffer.

Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
---
 drivers/iio/adc/ti-ads112c14.c | 103 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 99 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ti-ads112c14.c b/drivers/iio/adc/ti-ads112c14.c
index 99ccacd6d56f..1404ca31324b 100644
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
@@ -605,6 +613,22 @@ static int ads112c14_single_conversion(struct ads112c14_data *data,
 	if (ret)
 		return ret;
 
+	/*
+	 * When doing buffered read, we don't check the CRC, but rather pass it
+	 * along with the raw data.
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
@@ -639,7 +663,7 @@ static int ads112c14_read_raw(struct iio_dev *indio_dev,
 		if (IIO_DEV_ACQUIRE_FAILED(claim))
 			return -EBUSY;
 
-		ret = ads112c14_single_conversion(data, chan, buf);
+		ret = ads112c14_single_conversion(data, chan, buf, false);
 		if (ret < 0)
 			return ret;
 
@@ -765,6 +789,10 @@ static int ads112c14_write_raw(struct iio_dev *indio_dev,
 	const int (*scale_avail)[2];
 	u8 *gain_val;
 
+	IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
+	if (IIO_DEV_ACQUIRE_FAILED(claim))
+		return -EBUSY;
+
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE: {
 		guard(mutex)(&data->lock);
@@ -863,6 +891,37 @@ static int ads112c14_read_label(struct iio_dev *indio_dev,
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
@@ -908,7 +967,7 @@ static int ads112c14_parse_channels(struct iio_dev *indio_dev,
 		return -ENOMEM;
 
 	channels = devm_kcalloc(dev, num_child_nodes +
-				ARRAY_SIZE(ads112c14_sys_mon_channels),
+				ARRAY_SIZE(ads112c14_sys_mon_channels) + 1,
 				sizeof(*channels), GFP_KERNEL);
 	if (!channels)
 		return -ENOMEM;
@@ -1069,14 +1128,44 @@ static int ads112c14_parse_channels(struct iio_dev *indio_dev,
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
+		struct iio_chan_spec *spec = &channels[i + j];
+
+		spec->scan_index = i + j;
+		spec->scan_type = (struct iio_scan_type){
+			.format = IIO_SCAN_FORMAT_SIGNED_INT,
+			.realbits = data->chip_info->resolution_bits,
+			.storagebits = 32,
+			.shift = 32 - data->chip_info->resolution_bits,
+			.endianness = IIO_BE,
+		};
+	}
+
 	indio_dev->channels = channels;
-	indio_dev->num_channels = i + ARRAY_SIZE(ads112c14_sys_mon_channels);
+	indio_dev->num_channels = i + ARRAY_SIZE(ads112c14_sys_mon_channels) + 1;
+
+	i = indio_dev->num_channels - 1;
+	channels[i] = IIO_CHAN_SOFT_TIMESTAMP(i);
 
 	return 0;
 }
@@ -1304,6 +1393,12 @@ static int ads112c14_probe(struct i2c_client *client)
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

