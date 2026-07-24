Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5455F43FD18
	for <linux-iio@vger.kernel.org>; Fri, 24 Jul 2026 20:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784924041; cv=none; b=NstQFGYThvEt99g1dV2OpXt5zap9KJvkrBMNV/LXk4oa7DRlXne+3lrSn+v4hym+9mqIha3Wq6CDqF2TIrmgt8KQs7j9HCsen0bbp6+cyMKTIBmnbxl1mXPYjTmUYqG7sWEA5JOUqoZ2lVl7oKDtoEV3TRt7wcKreEQqGamQmGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784924041; c=relaxed/simple;
	bh=BPt109iAWgDJXAvgjMvwx0rWb03VUfrCvuRuh/1KsDI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gPad1rjOD9BVPrqr0/b6J8mxW5xQBQFZXweWSgDwYYRiT05U9KOoX++6HB334tjU1td/bFTZhW0EHe8CcCkUmOUDvf1IVFhLNKmftlaMkkfTvtupVkMLJXELTO1CPec8GEZZ1oFL4n9l9rwQEO1QjL8arRFc5GvbtlgDumLEmSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=QhV2izri; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="QhV2izri"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6aae73c40c6so648635eaf.1
        for <linux-iio@vger.kernel.org>; Fri, 24 Jul 2026 13:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1784924018; x=1785528818; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x8jCGxO7GFnygrqE3Gh6IjanpH8BBhZPbSBH/qmP5TU=;
        b=QhV2izriklnO2RVYJwqFAlg5JXXslN/Y1pMC7cG6u6SR4bOqHBV90AFQMhBXUaef7+
         RdCWIetq44KaG5WP88zICdRQsnwOA8m2ll4+8OX5B4bwLvQnznB2vOtKsEWecugu49d5
         GZqsorpp9rAMS6DZh75Nyms2l4NY1I02AP+kOBdqYxM0LsZrwuc15DiNtHr+gTg8im5V
         DUv/Ywb24q/U2CLIGgWl6YSQDf26tCAQYwD7Ca8lJnYSbSJT4+Bs9k5EYEQRB82WDsiS
         obGnTEw69U4tumECxSixCRJUgYGCZ7cwbRBmhWI2RWLe51lR57wyRQrr33F57q8vOM1o
         I0hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784924018; x=1785528818;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x8jCGxO7GFnygrqE3Gh6IjanpH8BBhZPbSBH/qmP5TU=;
        b=kXSbgHUSAjV34wkKus0WgLpvDNI7wYKcEpaTwsccC8Qtdgiowvy8IDq25eJPVTU9DA
         lfBind1puf20bKQJz0QN/KeMBXKSBxjtg0kaf6jVMmaF+r6zjJMsViIdbp2xn2IxUGMF
         88ytCY3Uu8gf1Pt+1FS8c0A6nXh1+1asAckzAtEEyd+kwq85QFokqa+fFQicsB2vo3Ni
         4djVp5I+XH3/cEor4GQMfiQTaFV6DRiu5Dr/Qg1jdD8ZywVzJZCJWy7uuWrcBd18kZoo
         z0FEpKwEThDxUQxQzdpwGYptR+fijpLqYVRGvjFUlPmIDdkMC31V119knRNzQmxA8p2j
         Vgxw==
X-Forwarded-Encrypted: i=1; AHgh+Rpaa7oD9FttfaDk4VrrjREuJV2C4lP+b6rpEEyP2AlD3NJV0saFMyI4Dh8TRElY2o1k4U2onpBT/Iw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLtnNrQ5Js6BcRD5HbFnXG/uvOHxyLi5c5Oosl4hf8pZwv6ebE
	TsvP346FQ3+srKQ/H4A4U7BXOO6aG7qSa2QeLoUkIAs+t2xmJ7AtovxiOXDkBYv/iJE=
X-Gm-Gg: AR+sD11p06TcHFimJwGlFKW+C/ALMWHhBgxePGXo79N9A1ighMIaYrkEfyT7wjtApU4
	dAKymGdvAg7urc09X+BzE+OSJiJBJyxQhDeYeSrDwIX23B1lCtBIhGwFsOqLZP/XdcZV57A2tWc
	QjszWajAQTI9FDoRq3+XjjMyWw3Y10JJtm2pYFUlVtSu4wOeHsc/7UzyI/ECC0iYdRGBq72fv4r
	8I/BzWoNIBtJ541zoRvkYz2O/v2Tehi0lg8ND5c5bIZnV0wGUT1OqP9b7mcp+SUvvnYxae/iCDW
	ocqJUjlR4Oe/ATZcjP1quD5ZU616fPWFH6+ZpUUKDQ08RRpWKJ3XjHiYmJ1NfA90dzLhtFXEa4V
	liGjkYvg7jfwmcu8CcQsPykjFFAcKiW8Z3hdGSP75TAzn+YN4hVoSY/os1CDXnRLVzO7Al+pPHc
	LMRJNsWw==
X-Received: by 2002:a05:6820:4c86:b0:6a3:7816:cbe2 with SMTP id 006d021491bc7-6aaf4658c68mr1808677eaf.35.1784924018163;
        Fri, 24 Jul 2026 13:13:38 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:b635:d463:c98:cc75])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-457675260b4sm8309042fac.17.2026.07.24.13.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 13:13:37 -0700 (PDT)
From: "David Lechner (TI)" <dlechner@baylibre.com>
Date: Fri, 24 Jul 2026 15:13:11 -0500
Subject: [PATCH 2/2] iio: adc: ti-ads112c14: add continuous mode support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-iio-adc-ti-ads112c14-continuous-mode-v1-2-9eb0b7a4f020@baylibre.com>
References: <20260724-iio-adc-ti-ads112c14-continuous-mode-v1-0-9eb0b7a4f020@baylibre.com>
In-Reply-To: <20260724-iio-adc-ti-ads112c14-continuous-mode-v1-0-9eb0b7a4f020@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Chris Hall <c-hall@ti.com>, Patrick Edwards <pedwards@ti.com>, 
 Kurt Borja <kuurtb@gmail.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "David Lechner (TI)" <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=9335; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=BPt109iAWgDJXAvgjMvwx0rWb03VUfrCvuRuh/1KsDI=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqY8doJil6Sdh+THaPJd6VWxh3gK+mJCHEghJoo
 touFy0p0VaJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCamPHaAAKCRDCzCAB/wGP
 wLTqCAChF72KTMz8OrRdfjQ2ek/HQz7QQTw5/p/HWkOT2Xit/SA2sp/bBzRBF8g0T/kRYIUWXbZ
 i3198lSrvUgofGTWo5UYoNVbPIGgin6tv3iri6qyi6kdMt2WG1iJyR0yG+kn07/4s/zhC6oHdHl
 fiTlBA4MMsXWaVwbYYSrk1apaumr7g6uB7Iyqztj/aqWhiAFNxWMuXCdMyPxl2mVJBRIi38s9RS
 pYOhytO8BnhiV4PAkSSYMJk7qylh449XWQpGImoqBFCI8+elAlOyWwOTehbzc1RQxyDkxaQgLsO
 xyxki9IrtT3kP2OmEr9+mIHJdV5H3mZk1j8GuUhdM7BfD59q
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add support for continuous mode in the TI ADS112C14 ADC driver. In this
mode the ADC itself is starting each conversion, so we add a trigger
based on the DRDY interrupt to read each sample. This mode is also
limited in that only one channel can be enabled at a time since the
chip does not have a sequencer or simultaneous sampling capability.
Continuous mode will only be used when this new trigger is the current
trigger.

Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
---
 drivers/iio/adc/ti-ads112c14.c | 200 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 178 insertions(+), 22 deletions(-)

diff --git a/drivers/iio/adc/ti-ads112c14.c b/drivers/iio/adc/ti-ads112c14.c
index 57e301c15314..f3a2eba55362 100644
--- a/drivers/iio/adc/ti-ads112c14.c
+++ b/drivers/iio/adc/ti-ads112c14.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/bitmap.h>
 #include <linux/cleanup.h>
 #include <linux/completion.h>
 #include <linux/crc8.h>
@@ -18,6 +19,7 @@
 #include <linux/i2c.h>
 #include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
+#include <linux/iio/trigger.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
 #include <linux/interrupt.h>
@@ -257,6 +259,7 @@ struct ads112c14_measurement {
 struct ads112c14_data {
 	const struct ads112c14_chip_info *chip_info;
 	struct regmap *regmap;
+	struct iio_trigger *drdy_trig;
 	/* Synchronizes access to register value fields. */
 	struct mutex lock;
 	int drdy_irq;
@@ -280,11 +283,32 @@ static irqreturn_t ads112c14_drdy_irq_handler(int irq, void *private)
 	struct iio_dev *indio_dev = private;
 	struct ads112c14_data *data = iio_priv(indio_dev);
 
-	complete(&data->drdy_completion);
+	if (iio_trigger_using_own(indio_dev))
+		iio_trigger_poll(data->drdy_trig);
+	else
+		complete(&data->drdy_completion);
 
 	return IRQ_HANDLED;
 }
 
+static int ads112c14_trigger_set_state(struct iio_trigger *trig, bool state)
+{
+	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
+	struct ads112c14_data *data = iio_priv(indio_dev);
+
+	if (state)
+		enable_irq(data->drdy_irq);
+	else
+		disable_irq(data->drdy_irq);
+
+	return 0;
+}
+
+static const struct iio_trigger_ops ads112c14_trigger_ops = {
+	.set_trigger_state = ads112c14_trigger_set_state,
+	.validate_device = iio_trigger_validate_own_device,
+};
+
 static bool ads112c14_writeable_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
@@ -601,6 +625,32 @@ static int ads112c14_prepare_sys_mon_channel(struct ads112c14_data *data,
 	return 0;
 }
 
+static int ads112c14_prepare_channel(struct ads112c14_data *data,
+				     const struct iio_chan_spec *chan)
+{
+	if (chan->channel < ADS112C14_SYS_MON_CHANNEL_BASE)
+		return ads112c14_prepare_measurement_channel(data, chan);
+
+	return ads112c14_prepare_sys_mon_channel(data, chan);
+}
+
+static int ads112c14_scan_read(struct ads112c14_data *data, u8 *buf)
+{
+	struct i2c_client *client = to_i2c_client(regmap_get_device(data->regmap));
+	int ret;
+	u8 len;
+
+	len = BITS_TO_BYTES(data->chip_info->resolution_bits);
+	if (data->i2c_crc_enabled)
+		len += 1;
+
+	ret = i2c_smbus_read_i2c_block_data(client, ADS112C14_CMD_RDATA, len, buf);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
 static int ads112c14_single_conversion(struct ads112c14_data *data,
 				       const struct iio_chan_spec *chan,
 				       u8 *buf, bool for_scan)
@@ -611,15 +661,9 @@ static int ads112c14_single_conversion(struct ads112c14_data *data,
 
 	guard(mutex)(&data->lock);
 
-	if (chan->channel < ADS112C14_SYS_MON_CHANNEL_BASE) {
-		ret = ads112c14_prepare_measurement_channel(data, chan);
-		if (ret)
-			return ret;
-	} else {
-		ret = ads112c14_prepare_sys_mon_channel(data, chan);
-		if (ret)
-			return ret;
-	}
+	ret = ads112c14_prepare_channel(data, chan);
+	if (ret)
+		return ret;
 
 	if (data->drdy_irq) {
 		reinit_completion(&data->drdy_completion);
@@ -655,17 +699,8 @@ static int ads112c14_single_conversion(struct ads112c14_data *data,
 	 * with CRC errors, but rather leave it to userspace to decide what to
 	 * do.
 	 */
-	if (for_scan) {
-		u8 len = BITS_TO_BYTES(data->chip_info->resolution_bits) +
-			 (data->i2c_crc_enabled ? 1 : 0);
-
-		ret = i2c_smbus_read_i2c_block_data(client, ADS112C14_CMD_RDATA,
-						    len, buf);
-		if (ret < 0)
-			return ret;
-
-		return 0;
-	}
+	if (for_scan)
+		return ads112c14_scan_read(data, buf);
 
 	return ads112c14_i2c_read_bytes(client, ADS112C14_CMD_RDATA, buf,
 					BITS_TO_BYTES(data->chip_info->resolution_bits),
@@ -934,10 +969,31 @@ static irqreturn_t ads112c14_trigger_handler(int irq, void *private)
 	struct iio_poll_func *pf = private;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct ads112c14_data *data = iio_priv(indio_dev);
+	unsigned int scan_mask_len = iio_get_masklength(indio_dev);
 	u32 offset = 0;
 	u32 i;
 	int ret;
 
+	if (iio_trigger_using_own(indio_dev)) {
+		i = find_first_bit(indio_dev->active_scan_mask, scan_mask_len);
+		if (i >= scan_mask_len)
+			goto out;
+
+		ret = ads112c14_scan_read(data, (u8 *)&data->scan[0]);
+		if (ret) {
+			const struct iio_chan_spec *chan = &indio_dev->channels[i];
+
+			dev_err_once(indio_dev->dev.parent,
+				     "failed to read channel %d: %pe; additional errors will be suppressed\n",
+				     chan->channel, ERR_PTR(ret));
+			goto out;
+		}
+
+		iio_push_to_buffers_with_ts(indio_dev, data->scan,
+					    sizeof(data->scan), pf->timestamp);
+		goto out;
+	}
+
 	iio_for_each_active_channel(indio_dev, i) {
 		const struct iio_chan_spec *chan = &indio_dev->channels[i];
 
@@ -969,6 +1025,90 @@ static const struct iio_info ads112c14_info = {
 	.read_label = ads112c14_read_label,
 };
 
+static bool ads112c14_using_drdy_trigger(struct iio_dev *indio_dev)
+{
+	struct ads112c14_data *data = iio_priv(indio_dev);
+
+	return data->drdy_trig && indio_dev->trig == data->drdy_trig;
+}
+
+static bool ads112c14_validate_scan_mask(struct iio_dev *indio_dev,
+					 const unsigned long *mask)
+{
+	if (!ads112c14_using_drdy_trigger(indio_dev))
+		return true;
+
+	return bitmap_weight(mask, iio_get_masklength(indio_dev)) == 1;
+}
+
+static int ads112c14_buffer_postenable(struct iio_dev *indio_dev)
+{
+	struct ads112c14_data *data = iio_priv(indio_dev);
+	unsigned int scan_mask_len = iio_get_masklength(indio_dev);
+	unsigned int i;
+	const struct iio_chan_spec *chan;
+	int ret;
+
+	if (!ads112c14_using_drdy_trigger(indio_dev))
+		return 0;
+
+	i = find_first_bit(indio_dev->active_scan_mask, scan_mask_len);
+	if (i >= scan_mask_len)
+		return -EINVAL;
+
+	chan = &indio_dev->channels[i];
+
+	guard(mutex)(&data->lock);
+
+	ret = ads112c14_prepare_channel(data, chan);
+	if (ret)
+		return ret;
+
+	ret = regmap_assign_bits(data->regmap, ADS112C14_REG_DEVICE_CFG,
+				 ADS112C14_DEVICE_CFG_CONV_MODE,
+				 ADS112C14_DEVICE_CFG_CONV_MODE_CONTINUOUS);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(data->regmap, ADS112C14_REG_CONVERSION_CTRL,
+			   ADS112C14_CONVERSION_CTRL_START);
+	if (ret) {
+		regmap_assign_bits(data->regmap, ADS112C14_REG_DEVICE_CFG,
+				   ADS112C14_DEVICE_CFG_CONV_MODE,
+				   ADS112C14_DEVICE_CFG_CONV_MODE_SINGLE_SHOT);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int ads112c14_buffer_predisable(struct iio_dev *indio_dev)
+{
+	struct ads112c14_data *data = iio_priv(indio_dev);
+	int ret, ret2;
+
+	if (!ads112c14_using_drdy_trigger(indio_dev))
+		return 0;
+
+	guard(mutex)(&data->lock);
+
+	ret = regmap_write(data->regmap, ADS112C14_REG_CONVERSION_CTRL,
+			   ADS112C14_CONVERSION_CTRL_STOP);
+	ret2 = regmap_assign_bits(data->regmap, ADS112C14_REG_DEVICE_CFG,
+				  ADS112C14_DEVICE_CFG_CONV_MODE,
+				  ADS112C14_DEVICE_CFG_CONV_MODE_SINGLE_SHOT);
+	if (ret2)
+		return ret2;
+
+	return ret;
+}
+
+static const struct iio_buffer_setup_ops ads112c14_buffer_setup_ops = {
+	.postenable = ads112c14_buffer_postenable,
+	.predisable = ads112c14_buffer_predisable,
+	.validate_scan_mask = ads112c14_validate_scan_mask,
+};
+
 static int ads112c14_populate_idac_mag(u32 current_nA, u8 *idac_mag)
 {
 	u32 current_uA = current_nA / (NANO / MICRO);
@@ -1458,6 +1598,21 @@ static int ads112c14_probe(struct i2c_client *client)
 				       IRQF_NO_AUTOEN, dev_name(dev), indio_dev);
 		if (ret)
 			return ret;
+
+		data->drdy_trig = devm_iio_trigger_alloc(dev, "%s-dev%d-drdy",
+							 info->name,
+							 iio_device_id(indio_dev));
+		if (!data->drdy_trig)
+			return -ENOMEM;
+
+		data->drdy_trig->ops = &ads112c14_trigger_ops;
+		iio_trigger_set_drvdata(data->drdy_trig, indio_dev);
+
+		ret = devm_iio_trigger_register(dev, data->drdy_trig);
+		if (ret)
+			return ret;
+
+		indio_dev->trig = iio_trigger_get(data->drdy_trig);
 	}
 
 	ads112c14_populate_tables(data);
@@ -1468,7 +1623,8 @@ static int ads112c14_probe(struct i2c_client *client)
 
 	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
 					      iio_pollfunc_store_time,
-					      ads112c14_trigger_handler, NULL);
+					      ads112c14_trigger_handler,
+					      &ads112c14_buffer_setup_ops);
 	if (ret)
 		return ret;
 

-- 
2.43.0

