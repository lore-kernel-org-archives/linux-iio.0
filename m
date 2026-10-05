Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB9A4AF147
	for <linux-iio@vger.kernel.org>; Mon,  5 Oct 2026 14:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791211508; cv=none; b=L74WBvt3/nEOS2aVh9qr+wP8Cm2IWp+TByqx2kM8mNeUHkN6mee++xnWZx59etLX0UwUkMdbTRVPzOp7QlzU5WfkCxry2dyQtHZf/eM64NC2IFEOIJGy9dbEFu4qwr/FKXiSB4/I4g4JdkPrW52kYdUR3lWNDc5ZBupvpMynBDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791211508; c=relaxed/simple;
	bh=6T4Tog3D9ZgXq4YvOeG+JFSPCx8A0Jg9bkAN4W0dXiM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qUkIFW9n/8tx4hACqt+Cpu3nkOOq5ZC4A4Z/xJJnlA7iElIq3E/+RxszF29n2//SQWSUIgpkB3GaEEp6KklJ11MOOTPL+9prgsmEff1+inJrBtU4NudI2nPVM+1r/OvOcenRu5KMtkM29qteZbG43IiTZYfbmPEJhX0bGKllWz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fhY1qyQO; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fhY1qyQO"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id B98E94E41197;
	Mon,  5 Oct 2026 14:44:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8BE8E601A5;
	Mon,  5 Oct 2026 14:44:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BC96A103307C6;
	Mon,  5 Oct 2026 16:44:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791211487; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=O/vKoMeflT9nPRyOcWw9LHjjIb32mZRk5p1cYeQFa4Y=;
	b=fhY1qyQOBJamKPEYUqjtmqO7d1ciMUbOCSNa+LQ4E2uJxkJjVUOQDCqgd7f3sB9NWG1lqB
	Gv3zhJV6mBQnTT3aEFSWk1j9nMQzb8Gm1EAK9AmTfCIyX/Rlzg+io0HDSXn6sUgMLabrU7
	lC/WUQ2qde91UdAe3cN0Kq89C+n6yMgwwDz5HrwSPEVCuK1dmoPX9thiA4k8MXB1VouzFN
	TkAx2mi6Ng4qZ2z0AnoaE/rEleUBzE3Sf+hbCD88YzXSfVQWyXaF+eXslQIMSABr1ILMHR
	18Gwlrhs7Y71mc92w1PUaRjDQYWcSGC0ySD4kybDo7Z0xFPu9sAjaY4+rJOADQ==
From: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Date: Mon, 05 Oct 2026 16:44:20 +0200
Subject: [PATCH 2/2] iio: temperature: tmp117: add support for HIGH and LOW
 alerts
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261005-add-tmp117-notif-v1-2-c6cef6fad64c@bootlin.com>
References: <20261005-add-tmp117-notif-v1-0-c6cef6fad64c@bootlin.com>
In-Reply-To: <20261005-add-tmp117-notif-v1-0-c6cef6fad64c@bootlin.com>
To: Puranjay Mohan <puranjay@kernel.org>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6647;
 i=thomas.bonnefille@bootlin.com; h=from:subject:message-id;
 bh=6T4Tog3D9ZgXq4YvOeG+JFSPCx8A0Jg9bkAN4W0dXiM=;
 b=owGbwMvMwCV2Z+MHT+XNR6wYT6slMWQd3n4h5L77jGWt5p/3sXN8PCJw8+OGzafXXWy2yq8uV
 /1U1Ohxr6OUhUGMi0FWTJHlgn9qicDiE8Yp6WETYeawMoEMYeDiFICJXDBkZDh/2e+bYtV7trx9
 YnZNfwT4MjivhH3ZNbFV7T3v7hs/Il4w/DO+Y7x0tUTQnpuHZvpri1V/nLl3/beH/DwqZ7Q9vTp
 Ul7AAAA==
X-Developer-Key: i=thomas.bonnefille@bootlin.com; a=openpgp;
 fpr=D04F657410A3C83364675691DCB1F04923B3C43A
X-Last-TLS-Session-Version: TLSv1.3

The TMP117/116/119 chips allow the user to set an alert if the
temperature reaches a HIGH or LOW limit.

Add support for setting the high and low alert limits.
An IIO event is generated when the temperature crosses either limit
thanks to an interrupt on the Alert pin.

Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
---
 drivers/iio/temperature/tmp117.c | 145 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 145 insertions(+)

diff --git a/drivers/iio/temperature/tmp117.c b/drivers/iio/temperature/tmp117.c
index 74cb8d62bef3c..d2924e9a7f97b 100644
--- a/drivers/iio/temperature/tmp117.c
+++ b/drivers/iio/temperature/tmp117.c
@@ -22,9 +22,12 @@
 #include <linux/regulator/consumer.h>
 
 #include <linux/iio/iio.h>
+#include <linux/iio/events.h>
 
 #define TMP117_REG_TEMP			0x0
 #define TMP117_REG_CFGR			0x1
+#define TMP117_CFGR_HIGH_ALERT		BIT(15)
+#define TMP117_CFGR_LOW_ALERT		BIT(14)
 #define TMP117_REG_HIGH_LIM		0x2
 #define TMP117_REG_LOW_LIM		0x3
 #define TMP117_REG_EEPROM_UL		0x4
@@ -37,6 +40,13 @@
 #define TMP117_RESOLUTION_10UC		78125
 #define MICRODEGREE_PER_10MILLIDEGREE	10000
 
+/*
+ * The temperature limit registers store a signed 16-bit value with an LSB of
+ * TMP117_RESOLUTION_10UC / MICRODEGREE_PER_10MILLIDEGREE = 125/16 m°C.
+ */
+#define TMP117_LIMIT_LSB_NUM		125
+#define TMP117_LIMIT_LSB_DEN		16
+
 #define TMP116_DEVICE_ID		0x1116
 #define TMP117_DEVICE_ID		0x0117
 #define TMP119_DEVICE_ID		0x2117
@@ -52,6 +62,112 @@ struct tmp11x_info {
 	int num_channels;
 };
 
+static irqreturn_t tmp117_interrupt_handler(int irq, void *private)
+{
+	struct iio_dev *indio_dev = private;
+	struct tmp117_data *data = iio_priv(indio_dev);
+	int ret;
+
+	ret = i2c_smbus_read_word_swapped(data->client, TMP117_REG_CFGR);
+	if (ret < 0 || !(ret & (TMP117_CFGR_HIGH_ALERT | TMP117_CFGR_LOW_ALERT)))
+		return IRQ_NONE;
+
+	if (ret & TMP117_CFGR_HIGH_ALERT)
+		iio_push_event(indio_dev,
+			       IIO_UNMOD_EVENT_CODE(IIO_TEMP, 0,
+						    IIO_EV_TYPE_THRESH,
+						    IIO_EV_DIR_RISING),
+			       iio_get_time_ns(indio_dev));
+
+	if (ret & TMP117_CFGR_LOW_ALERT)
+		iio_push_event(indio_dev,
+			       IIO_UNMOD_EVENT_CODE(IIO_TEMP, 0,
+						    IIO_EV_TYPE_THRESH,
+						    IIO_EV_DIR_FALLING),
+			       iio_get_time_ns(indio_dev));
+
+	return IRQ_HANDLED;
+}
+
+static int tmp117_read_thresh(struct iio_dev *indio_dev,
+			      const struct iio_chan_spec *chan,
+			      enum iio_event_type type,
+			      enum iio_event_direction dir,
+			      enum iio_event_info info,
+			      int *val, int *val2)
+{
+	struct tmp117_data *data = iio_priv(indio_dev);
+	s32 ret;
+	u8 reg;
+
+	switch (dir) {
+	case IIO_EV_DIR_RISING:
+		reg = TMP117_REG_HIGH_LIM;
+		break;
+	case IIO_EV_DIR_FALLING:
+		reg = TMP117_REG_LOW_LIM;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (info != IIO_EV_INFO_VALUE || type != IIO_EV_TYPE_THRESH)
+		return -EINVAL;
+	ret = i2c_smbus_read_word_swapped(data->client, reg);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * Report the threshold in millidegrees Celsius as an exact fraction:
+	 * value = raw * TMP117_LIMIT_LSB_NUM / TMP117_LIMIT_LSB_DEN.
+	 */
+	*val = sign_extend32(ret, 15) * TMP117_LIMIT_LSB_NUM;
+	*val2 = TMP117_LIMIT_LSB_DEN;
+
+	return IIO_VAL_FRACTIONAL;
+}
+
+static int tmp117_write_thresh(struct iio_dev *indio_dev,
+			       const struct iio_chan_spec *chan,
+			       enum iio_event_type type,
+			       enum iio_event_direction dir,
+			       enum iio_event_info info,
+			       int val, int val2)
+{
+	struct tmp117_data *data = iio_priv(indio_dev);
+	s64 tmp;
+	u8 reg;
+
+	switch (dir) {
+	case IIO_EV_DIR_RISING:
+		reg = TMP117_REG_HIGH_LIM;
+		break;
+	case IIO_EV_DIR_FALLING:
+		reg = TMP117_REG_LOW_LIM;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (info != IIO_EV_INFO_VALUE || type != IIO_EV_TYPE_THRESH)
+		return -EINVAL;
+
+	/*
+	 * The threshold is passed in millidegrees Celsius as
+	 * value = val + val2 / 1000000 (val2 holds the fractional part, with
+	 * the sign taken from val). Convert it back with the same LSB ratio:
+	 * raw = value / (TMP117_LIMIT_LSB_NUM / TMP117_LIMIT_LSB_DEN).
+	 */
+	tmp = (val < 0) ? (s64)val * 1000000 - val2
+			: (s64)val * 1000000 + val2;
+	tmp = DIV_ROUND_CLOSEST(tmp * TMP117_LIMIT_LSB_DEN,
+				(s64)TMP117_LIMIT_LSB_NUM * 1000000);
+	tmp = clamp_t(s64, tmp, S16_MIN, S16_MAX);
+
+	return i2c_smbus_write_word_swapped(data->client,
+					    reg, tmp);
+}
+
 static int tmp117_read_raw(struct iio_dev *indio_dev,
 			   struct iio_chan_spec const *channel, int *val,
 			   int *val2, long mask)
@@ -112,12 +228,27 @@ static int tmp117_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec
 	}
 }
 
+static const struct iio_event_spec tmp11x_obj_event[] = {
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE),
+	},
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE),
+	},
+};
+
 static const struct iio_chan_spec tmp117_channels[] = {
 	{
 		.type = IIO_TEMP,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 				      BIT(IIO_CHAN_INFO_CALIBBIAS) |
 				      BIT(IIO_CHAN_INFO_SCALE),
+		.event_spec = tmp11x_obj_event,
+		.num_event_specs = ARRAY_SIZE(tmp11x_obj_event),
 	},
 };
 
@@ -126,6 +257,8 @@ static const struct iio_chan_spec tmp116_channels[] = {
 		.type = IIO_TEMP,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 				      BIT(IIO_CHAN_INFO_SCALE),
+		.event_spec = tmp11x_obj_event,
+		.num_event_specs = ARRAY_SIZE(tmp11x_obj_event),
 	},
 };
 
@@ -150,6 +283,8 @@ static const struct tmp11x_info tmp119_channels_info = {
 static const struct iio_info tmp117_info = {
 	.read_raw = tmp117_read_raw,
 	.write_raw = tmp117_write_raw,
+	.read_event_value = tmp117_read_thresh,
+	.write_event_value = tmp117_write_thresh,
 };
 
 static int tmp117_probe(struct i2c_client *client)
@@ -208,6 +343,16 @@ static int tmp117_probe(struct i2c_client *client)
 	indio_dev->num_channels = match_data->num_channels;
 	indio_dev->name = match_data->name;
 
+	if (client->irq) {
+		ret = devm_request_threaded_irq(&client->dev, client->irq,
+						NULL, tmp117_interrupt_handler,
+						IRQF_ONESHOT, match_data->name,
+						indio_dev);
+		if (ret) {
+			dev_err_probe(&client->dev, ret, "irq request error\n");
+			return ret;
+		}
+	}
 
 	return devm_iio_device_register(&client->dev, indio_dev);
 }

-- 
2.55.0

