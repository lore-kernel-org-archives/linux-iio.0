Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com [74.125.231.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F4442CB05
	for <linux-iio@vger.kernel.org>; Thu, 10 Sep 2026 21:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789074887; cv=none; b=HcRZfZR+veIEl0JSrFV0cttqOQHEm16JSfejUeWQV228A4n1xVCGvJwJeFcwmj6keerq2t37IJpUis+emJ3bpeOWIS69yy+/FZS+vIX6kaQo6zLxAbfjxizvbXqpiaznxSy84S0LPA2KddeBONBvtej3ZcI/UuzGNLsbA0/MGhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789074887; c=relaxed/simple;
	bh=ipRQM+y4GEfK0iLNUB8nAfxP8/yNtQ0sDmoWBJ2tDGI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IA3AZ16hemjrFZx4BkuhYsJfT3yilz8FSxrOpk77dvaSdriUoxsKNcWSyrrK5gUXo6QMPaEu2M8655RpY17JeRifP/JvbXT3+fS9h37wEyQfgYdOO+dkbMfW+UFo7QwTz0NByA3UBBf5vTDqsmWfaERckyIASFCtppf4OnglT3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=gjEDSmf9; arc=none smtp.client-ip=74.125.231.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="gjEDSmf9"
Received: by mail-oi2-f13.google.com with SMTP id 5614622812f47-4c206dc9827so183034b6e.0
        for <linux-iio@vger.kernel.org>; Thu, 10 Sep 2026 14:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1789074875; x=1789679675; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wBiJn8Ecvvni6QBRfEghFXWnlQeSyCYHU8s9BH4FLQU=;
        b=gjEDSmf9Cze5DGk7lvDcIWqke3hNey1+qCmc+7vwkBvubBWN6EF3YMAt+7XWx2HQWe
         Ma112U47v4X0Xo3rKvkoUgsQGFzZO/M+8/0UE0z6ngRLmOEvi2OZPOgSVzdrVh6TaYGx
         EqFuNQhlv6G4ZMOICxni/0RAa6ZJX3+9jZJ9/nKOL6nZ8tiuYh8iF/rGTUrvmwLg8k1y
         MefvQ80+6ZZ0owI4MKE8V5YtKOlf9Sa8C+Xkcvk/BvnJ/qPJGUP5jPUJwdPMMe495RTW
         CJpTbhtTw1Cr4JMLptSIgFVLlpMxucuGuu+tOvqOlCUh4ZVz7g3gmVBhBvzMboIN/kvC
         ZIZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789074875; x=1789679675;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wBiJn8Ecvvni6QBRfEghFXWnlQeSyCYHU8s9BH4FLQU=;
        b=ipxNBR2dwwb0Gj/rzHw7D1KxvbO49SYCEcTy/hMIsRvm0EiSlB2o5SIK8RuJ7dRSrT
         NOx+jaeeiW+/dbDcnvvWB/oy1SgqttqmpO0JdRZBrrnUHFmxHmchiEP0e2E7J6ZGLC51
         0wJI60YwWyFLJQIjnWk73/ZrP1hexZNwd1HFDHYBdIxlE67AtSNKAcgIdLGZwk4VSNQY
         M5h+nIMaSDb0TuEYN5125nRXUim4T3uif/cssP+Zi++/nmhtZS8i1mshTDbll2pQ/25S
         lxp28A9kgdzd7uj/zhKcaGig5gd71hgqT2TMhdNuwJ9Y+Mc1GAdI8iU/wOdTe4Pc8MJu
         tmJg==
X-Forwarded-Encrypted: i=1; AKwUvBwzmItC6H4o5nBEAgOlL+bpSXU2pOLdAWMD/I8SLPHigyMQ+P2/L73HtF5EX8MNgf6xvFSUWCsyvWU=@vger.kernel.org
X-Gm-Message-State: AFuF++kBZqQJHtMP1nWWg0njA3eAGHePX3N5tQisibUEKn0VQKaUxttB
	K9Y4M683sqwptzQCnWDJg2IfqxuTa1igcXs67OXylLxwjO4FFUIG4pQFXifVK6k2Fv4=
X-Gm-Gg: AYBFou3v7oy1gQ60swLfX4ImD+owA9m7ei7VpvDvPOpsPb3HbgDia6g1ZtLwKYIRRJF
	EBORAuShjFEMSBlzJci8eBa09S9UM7/7MrKftCfBzfaHR4rdJEyQhPMMl4PvjVIu3ke+UY4KAh5
	vYbvlR4GQbJlJbnwIAd+MOTDivkvZNrZSE6JRs5X7k4zb0iyV2Bp1WZOyiT3mCzHxd3g87Z0GHz
	eMAGYEbWLJbDliXJ0KoKtVdIcrdmgxaSQBGWmk3KjxKZkgQH3VDwqe8cU0L2hpKIXqb+KsPgfcy
	zEjJq0oSGcASBfSe8oCgtceUuVQgcCn+sdT3LXQ/tQxYXK+8uGP0rmhGw5/9IEWnpBcBv1ArQK1
	Cw/pFp/8TZUW+rsKfP20n/HC8spAFXT8vx/7shQvl2pmsc5ngnNEw0PrJc+OY6vTCzOgzj2P1Jd
	dwazbZWrVYLbDzSg04vCN78jRJCYFdN/C1nDGQHpibUGt/wPgy7bYF1/zL7bU1lkGIp0ZKZk6o/
	HB7
X-Received: by 2002:a05:6808:2f0d:b0:4c1:30a9:6dac with SMTP id 5614622812f47-4c31c6263f4mr1346436b6e.19.1789074874957;
        Thu, 10 Sep 2026 14:14:34 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:fbf1:d0da:69e0:11a0])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4c330daa42esm347315b6e.4.2026.09.10.14.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 14:14:33 -0700 (PDT)
From: "David Lechner (TI)" <dlechner@baylibre.com>
Date: Thu, 10 Sep 2026 16:13:02 -0500
Subject: [PATCH v3 03/10] iio: adc: ti-ads112c14: add continuous mode
 support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-iio-adc-ti-ads112c14-filter-support-v3-3-e5a9b27ddb1a@baylibre.com>
References: <20260910-iio-adc-ti-ads112c14-filter-support-v3-0-e5a9b27ddb1a@baylibre.com>
In-Reply-To: <20260910-iio-adc-ti-ads112c14-filter-support-v3-0-e5a9b27ddb1a@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Chris Hall <c-hall@ti.com>, Patrick Edwards <pedwards@ti.com>, 
 Kurt Borja <kuurtb@gmail.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "David Lechner (TI)" <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=8170; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=ipRQM+y4GEfK0iLNUB8nAfxP8/yNtQ0sDmoWBJ2tDGI=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqox1/1aiAbgy+Uf3d3gNsS+yyEcwcEWW/qJX2R
 xM7emYTUeOJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaqMdfwAKCRDCzCAB/wGP
 wLq7B/4rq3+r6tbXQG6SmX1KkB29Ri8ZzWD5Cpp2y562utbYrcQ9XrHqI+CmzAOayk5FsDk/k/q
 2+J9d1YIOd9EaMsLGj+krSBsPHxMT3L6DHQYpa63E2GC1lZt7YJPzEF4TQ/2UX0QRh7dahUswhz
 uKieByxUshAzid6VPaIXhIZucriRGFsfwxj+9qZY9em4cUAVSR14GPGtAUWfxAiNqSrH45TUyBo
 tn4HjVgoc8mOCjjXnORaDlOhQtDgJW+hmaEA/nOk2HLAw1f1Dewto8p0miq+N4tNF1IBI5nskSa
 MsN0KA4e2itP651j/wPfhFhxONBjYyPRkGJRINzKumYkPBKx
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
 drivers/iio/adc/ti-ads112c14.c | 153 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 151 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ti-ads112c14.c b/drivers/iio/adc/ti-ads112c14.c
index b2940b5d3c99..09807ea4fb18 100644
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
@@ -257,10 +259,12 @@ struct ads112c14_measurement {
 struct ads112c14_data {
 	const struct ads112c14_chip_info *chip_info;
 	struct regmap *regmap;
+	struct iio_trigger *drdy_trig;
 	/* Synchronizes access to register value fields. */
 	struct mutex lock;
 	int drdy_irq;
 	struct completion drdy_completion;
+	bool continuous_mode;
 	bool i2c_crc_enabled;
 	u32 avdd_uV;
 	u32 ext_ref_uV;
@@ -280,11 +284,18 @@ static irqreturn_t ads112c14_drdy_irq_handler(int irq, void *private)
 	struct iio_dev *indio_dev = private;
 	struct ads112c14_data *data = iio_priv(indio_dev);
 
-	complete(&data->drdy_completion);
+	if (READ_ONCE(data->continuous_mode))
+		iio_trigger_poll(data->drdy_trig);
+	else
+		complete(&data->drdy_completion);
 
 	return IRQ_HANDLED;
 }
 
+static const struct iio_trigger_ops ads112c14_trigger_ops = {
+	.validate_device = iio_trigger_validate_own_device,
+};
+
 static bool ads112c14_writeable_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
@@ -695,6 +706,13 @@ static int ads112c14_single_conversion(struct ads112c14_data *data,
 					data->i2c_crc_enabled);
 }
 
+static bool ads112c14_using_drdy_trigger(struct iio_dev *indio_dev)
+{
+	struct ads112c14_data *data = iio_priv(indio_dev);
+
+	return data->drdy_trig && indio_dev->trig == data->drdy_trig;
+}
+
 static int ads112c14_read_raw(struct iio_dev *indio_dev,
 			      struct iio_chan_spec const *chan,
 			      int *val, int *val2, long mask)
@@ -898,6 +916,19 @@ static int ads112c14_write_raw_get_fmt(struct iio_dev *indio_dev,
 	}
 }
 
+static int ads112c14_update_scan_mode(struct iio_dev *indio_dev,
+				      const unsigned long *scan_mask)
+{
+	/* Only continuous mode is limited to a single channel. */
+	if (!ads112c14_using_drdy_trigger(indio_dev))
+		return 0;
+
+	if (!iio_validate_scan_mask_onehot(indio_dev, scan_mask))
+		return -EINVAL;
+
+	return 0;
+}
+
 static int ads112c14_debugfs_reg_access(struct iio_dev *indio_dev,
 					unsigned int reg,
 					unsigned int writeval,
@@ -952,6 +983,19 @@ static int ads112c14_read_label(struct iio_dev *indio_dev,
 	return sysfs_emit(label, "%s\n", label_source);
 }
 
+static const struct iio_chan_spec *
+ads112c14_first_active_channel(struct iio_dev *indio_dev)
+{
+	unsigned int scan_mask_len = iio_get_masklength(indio_dev);
+	unsigned int i;
+
+	i = find_first_bit(indio_dev->active_scan_mask, scan_mask_len);
+	if (i == scan_mask_len)
+		return NULL;
+
+	return &indio_dev->channels[i];
+}
+
 static irqreturn_t ads112c14_trigger_handler(int irq, void *private)
 {
 	struct iio_poll_func *pf = private;
@@ -961,6 +1005,26 @@ static irqreturn_t ads112c14_trigger_handler(int irq, void *private)
 	u32 i;
 	int ret;
 
+	if (ads112c14_using_drdy_trigger(indio_dev)) {
+		const struct iio_chan_spec *chan;
+
+		chan = ads112c14_first_active_channel(indio_dev);
+		if (!chan)
+			goto out;
+
+		ret = ads112c14_scan_read(data, (u8 *)&data->scan[0]);
+		if (ret) {
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
 
@@ -988,10 +1052,81 @@ static const struct iio_info ads112c14_info = {
 	.read_avail = ads112c14_read_avail,
 	.write_raw = ads112c14_write_raw,
 	.write_raw_get_fmt = ads112c14_write_raw_get_fmt,
+	.update_scan_mode = ads112c14_update_scan_mode,
 	.debugfs_reg_access = ads112c14_debugfs_reg_access,
 	.read_label = ads112c14_read_label,
 };
 
+static int ads112c14_buffer_postenable(struct iio_dev *indio_dev)
+{
+	struct ads112c14_data *data = iio_priv(indio_dev);
+	const struct iio_chan_spec *chan;
+	int ret;
+
+	if (!ads112c14_using_drdy_trigger(indio_dev))
+		return 0;
+
+	chan = ads112c14_first_active_channel(indio_dev);
+	if (!chan)
+		return -EINVAL;
+
+	guard(mutex)(&data->lock);
+
+	ret = ads112c14_prepare_channel(data, chan);
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(data->regmap, ADS112C14_REG_DEVICE_CFG,
+				 ADS112C14_DEVICE_CFG_CONV_MODE,
+				 FIELD_PREP(ADS112C14_DEVICE_CFG_CONV_MODE,
+					    ADS112C14_DEVICE_CFG_CONV_MODE_CONTINUOUS));
+	if (ret)
+		return ret;
+
+	WRITE_ONCE(data->continuous_mode, true);
+
+	ret = regmap_write(data->regmap, ADS112C14_REG_CONVERSION_CTRL,
+			   ADS112C14_CONVERSION_CTRL_START);
+	if (ret) {
+		WRITE_ONCE(data->continuous_mode, false);
+		regmap_update_bits(data->regmap, ADS112C14_REG_DEVICE_CFG,
+				   ADS112C14_DEVICE_CFG_CONV_MODE,
+				   FIELD_PREP(ADS112C14_DEVICE_CFG_CONV_MODE,
+					      ADS112C14_DEVICE_CFG_CONV_MODE_SINGLE_SHOT));
+		return ret;
+	}
+
+	return 0;
+}
+
+static int ads112c14_buffer_predisable(struct iio_dev *indio_dev)
+{
+	struct ads112c14_data *data = iio_priv(indio_dev);
+	int ret;
+
+	if (!ads112c14_using_drdy_trigger(indio_dev))
+		return 0;
+
+	guard(mutex)(&data->lock);
+
+	WRITE_ONCE(data->continuous_mode, false);
+
+	ret = regmap_write(data->regmap, ADS112C14_REG_CONVERSION_CTRL,
+			   ADS112C14_CONVERSION_CTRL_STOP);
+	if (ret)
+		return ret;
+
+	return regmap_update_bits(data->regmap, ADS112C14_REG_DEVICE_CFG,
+				  ADS112C14_DEVICE_CFG_CONV_MODE,
+				  FIELD_PREP(ADS112C14_DEVICE_CFG_CONV_MODE,
+					     ADS112C14_DEVICE_CFG_CONV_MODE_SINGLE_SHOT));
+}
+
+static const struct iio_buffer_setup_ops ads112c14_buffer_setup_ops = {
+	.postenable = ads112c14_buffer_postenable,
+	.predisable = ads112c14_buffer_predisable,
+};
+
 static int ads112c14_populate_idac_mag(u32 current_nA, u8 *idac_mag)
 {
 	u32 current_uA = current_nA / (NANO / MICRO);
@@ -1476,6 +1611,19 @@ static int ads112c14_probe(struct i2c_client *client)
 
 		init_completion(&data->drdy_completion);
 
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
 		ret = devm_request_irq(dev, data->drdy_irq, ads112c14_drdy_irq_handler,
 				       0, dev_name(dev), indio_dev);
 		if (ret)
@@ -1490,7 +1638,8 @@ static int ads112c14_probe(struct i2c_client *client)
 
 	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
 					      iio_pollfunc_store_time,
-					      ads112c14_trigger_handler, NULL);
+					      ads112c14_trigger_handler,
+					      &ads112c14_buffer_setup_ops);
 	if (ret)
 		return ret;
 

-- 
2.43.0

