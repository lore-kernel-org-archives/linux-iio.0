Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D512047ECED
	for <linux-iio@vger.kernel.org>; Fri, 31 Jul 2026 23:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785541730; cv=none; b=TebEtdrtf+O1vToDYle1JjXJOz7gEAWypU2Q4bCuWXf4BmGCQnaXX8fThZkPeuOvqYIHpNxnQ9zSZeoNCrKxG1/RFl5N6DCKhs22Dv2qzE1m62lvN/uHZSINGFT60i0FRj3GVxnB3EIK/GkKeGiJKJYwzS6UshsNZd9QjDbm3ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785541730; c=relaxed/simple;
	bh=MMUPyjsWYoyg55yjxt/Forn9EzHSzzw9gunEPLWs0kI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kePVJlRu+qf9y613s1evwIFTIOlFXkTV5+092VhHs6Qq/ktdrd087yIvxzC/7xza4lQAbOhn4N+sZEVJfTLDDd/kcFzN/XsHqkH3JEblxJzC+6iXsAjFvuO00azdIQwCZMLYuWa/FssQGwjrPqOMuH4rs/HA0tBEyJWKjXKVXQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=X2Gna6CI; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="X2Gna6CI"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7e9ecd7216cso825338a34.3
        for <linux-iio@vger.kernel.org>; Fri, 31 Jul 2026 16:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1785541728; x=1786146528; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vtTXmGRQi3vncZnUKbfOnZzKc+altiKF9bbiSkLj2m8=;
        b=X2Gna6CIkzfqS8EaSuxMoKcgZrVk6aetkAet7tpQ2trOsYRTMSGGysf6c/ckHlieTw
         xHv7avP0jhsfcSD0VVF+6GJIyHsClLKSDVW3AY3G769fC1PzWIp1vgGiBI2A2/w38Wfh
         hz2JhNEyazBj4x6w291oFGP/uzGvlV6CJE4qUyQ9fVGqs5wWSXNUEXL/6pA7ehOUIfv0
         C0qKR0J5LH7l3QJR6FKTfox2228r4e1geWu1sPSTyBMLrreVzn6/Ip5S8gep6MKGliQk
         MuTtCNIDLygWiMRzGGl1Z9wI64Ju8UCCnR15baySnHJJMewbIQTrthFkmPxhtd+q+nGc
         eQsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785541728; x=1786146528;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vtTXmGRQi3vncZnUKbfOnZzKc+altiKF9bbiSkLj2m8=;
        b=rg0J/9Y6C+WUh7U51y/gHxbriP+m8S6Xq5Xc9faXPfslAfMqWP+JOSOIvDo/IGfoZu
         qI16I10PdBGd78amXeFowO97OCm3N+ck9NJg9OdUNp8PpJ/3aiswT2onhi6aWnLpvo18
         FC2pnn4G1zeSGYb+r2dPn3lsPNYOWu1Q0RApk82KAxKe4/4PksveVkbWX0YAPEDmOmlV
         m7G96VIxtCKp+ogOoti2bAQ0rRt/lmDZpYqyXzPrTXBedxwQgWoB9cOl1XXyOuHGaFyn
         6yAsK0RnprRAk0D2rTJAW3h2sVK77rN6Rv3Cmk4RFpWADx46IyBhdj6yqH1rXi47A/L0
         Cyig==
X-Forwarded-Encrypted: i=1; AHgh+RqBOtXSpNjtgTi7RCftttsZIRkgevPQhXfFAwj0pXuCJSjoDYr39xCJWf3AOVpwz0vm4Di4XKosKzU=@vger.kernel.org
X-Gm-Message-State: AOJu0YygzEgox8A4ktOhMhbfWk+OIJixHD4c6Ji4fu6ZbxONha9LBEtc
	rSR9CybmCcpAfMxveVe566W3rr7+K7ho0PKMTKcYY0ni5KNX9B8F+CYA/tZfL1AcQO0=
X-Gm-Gg: AR+sD12F41wH5M2xd/uzggXbW+L6Jv/o6MnALC1i3ON0yo6cIIWZ7cOgUnAn61ukMoH
	GM7yg4VZt0TfDYHpId/98UvK8HnPyo5jyj1KfpPwgEScg3ELBvPWkIhErvwzgYLmLqG0Rz67YEC
	cwS6k7FL/8Nllzof6aE9Qvh865ofN+jevLuizmXzUeLO7nS5xv8ycLlLmgfvswmY67jcwFUc7vM
	CiC/xB9uphRrqOfEK2IEwNbQQhNMsBZmVo7hRA5CEADBJVaMicblWVGIc2xTF22N+2+00Ni8vak
	ypdtBWGz1KkBEZpTxfCcRuE7aVZ8SKGqMg359YW1TTkVR5Ul7ez+1G3g7z8CGxQAI2QPQdo0OMv
	3EgmlO16zlJBZ5oASHExMc0EQEm2aLUISQWe75R4WXQIliuJugzCIp4yQkya2+r+gNcZKjovK+3
	2OfzrJLPiMzBvXTZopUIOkBrsYARsDcdibIdfbIfJn6ZH+YHMvJFcmLmJQoGeZ0rcMpA==
X-Received: by 2002:a05:6830:4992:b0:7eb:c8ed:71d5 with SMTP id 46e09a7af769-7f196ef1d76mr4081354a34.14.1785541727688;
        Fri, 31 Jul 2026 16:48:47 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:fa40:746f:401a:3b75])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f18ed3c814sm1736940a34.6.2026.07.31.16.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 16:48:47 -0700 (PDT)
From: "David Lechner (TI)" <dlechner@baylibre.com>
Date: Fri, 31 Jul 2026 18:48:12 -0500
Subject: [PATCH v2 3/3] iio: adc: ti-ads112c14: add continuous mode support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-iio-adc-ti-ads112c14-continuous-mode-v2-3-eb13da38e8fc@baylibre.com>
References: <20260731-iio-adc-ti-ads112c14-continuous-mode-v2-0-eb13da38e8fc@baylibre.com>
In-Reply-To: <20260731-iio-adc-ti-ads112c14-continuous-mode-v2-0-eb13da38e8fc@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Chris Hall <c-hall@ti.com>, Patrick Edwards <pedwards@ti.com>, 
 Kurt Borja <kuurtb@gmail.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "David Lechner (TI)" <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=7102; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=MMUPyjsWYoyg55yjxt/Forn9EzHSzzw9gunEPLWs0kI=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqbTRUAax+b2bNiNL1hz8q/KmWToB5oFG5NXwA2
 kbNIBW713CJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCam00VAAKCRDCzCAB/wGP
 wPFPB/0bGBR5/GKdU3SOj+E4bzPsFirpcfHk82yB4R94+TnhrgfAIF3qsyaNA/TiYia0lCdK2o+
 MBVnG76u0vTgnOoAsn/+zb7wojFTwu7mDc0Uv8mTMj5/DRDF7jEXr/DEG15T7Rh5ckBWZe5swNx
 km4JEVYueS45BfeXGG+bLwtJSFBS22hx2KTjS+pG2y8B1KS21cn8i70naQloVKUjN2bGkdtekdx
 LmAzZqvpneReXjAY3Aw6EJZ+uCZ6fMda4HqMr1umKVc5jr9KrtDtwdwr/aH1AdqZF+m6OUVb8l9
 /wqf9YgZOj3ELXAwH8YZIn9YM0yjwcQ5RbzELDcpFe58gP2a
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
 drivers/iio/adc/ti-ads112c14.c | 146 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 144 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ti-ads112c14.c b/drivers/iio/adc/ti-ads112c14.c
index c6d83298c312..5147d10785fb 100644
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
+	if (indio_dev->trig && iio_trigger_using_own(indio_dev))
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
@@ -962,10 +986,31 @@ static irqreturn_t ads112c14_trigger_handler(int irq, void *private)
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
 
@@ -997,6 +1042,89 @@ static const struct iio_info ads112c14_info = {
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
+	return iio_validate_scan_mask_onehot(indio_dev, mask);
+}
+
+static int ads112c14_buffer_postenable(struct iio_dev *indio_dev)
+{
+	unsigned int scan_mask_len = iio_get_masklength(indio_dev);
+	struct ads112c14_data *data = iio_priv(indio_dev);
+	const struct iio_chan_spec *chan;
+	unsigned int i;
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
+	int ret;
+
+	if (!ads112c14_using_drdy_trigger(indio_dev))
+		return 0;
+
+	guard(mutex)(&data->lock);
+
+	ret = regmap_write(data->regmap, ADS112C14_REG_CONVERSION_CTRL,
+			   ADS112C14_CONVERSION_CTRL_STOP);
+	if (ret)
+		return ret;
+
+	return regmap_assign_bits(data->regmap, ADS112C14_REG_DEVICE_CFG,
+				  ADS112C14_DEVICE_CFG_CONV_MODE,
+				  ADS112C14_DEVICE_CFG_CONV_MODE_SINGLE_SHOT);
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
@@ -1486,6 +1614,19 @@ static int ads112c14_probe(struct i2c_client *client)
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
 	}
 
 	ads112c14_populate_tables(data);
@@ -1496,7 +1637,8 @@ static int ads112c14_probe(struct i2c_client *client)
 
 	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
 					      iio_pollfunc_store_time,
-					      ads112c14_trigger_handler, NULL);
+					      ads112c14_trigger_handler,
+					      &ads112c14_buffer_setup_ops);
 	if (ret)
 		return ret;
 

-- 
2.43.0

