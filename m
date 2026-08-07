Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578063F8232
	for <linux-iio@vger.kernel.org>; Fri,  7 Aug 2026 21:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786137633; cv=none; b=GK/ZL/6JuKJ2MD6d6jymsy3S4RN5N7suYWGHO8xe+1fbH3hQLFBgUbg0+qcZyJEM96YkY12aZj2JoOVvcMHaQVoJINcLX+l6P4sXdq+CxI22eueLcNTDBGPSis5ZarlKCGkK5UsYO8QM12Qz1H+Iv5Fb799uh2jovZH8yU11UlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786137633; c=relaxed/simple;
	bh=MYu4KxURi0kEu9JyX7YNixCr2LSeVCPXKFGnl80k+OI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ncfVo9+Bzye0ewO7ixjRsYuDsS6U5kwRHeVO/0NQaV9LNe0T99nS4hImnJgzVIqq0dmKAMy58LRtZwE7V1sxqavzuiXESlzTmh1wJR2H8EW8fpZmhDG+JOYzwQPb/QqmycQ/i1rppXXRY3A5pM2jWHJM9jK/23+PkMHXgReUHIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=Q4DU8ioj; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="Q4DU8ioj"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-495b27007d0so4525b6e.1
        for <linux-iio@vger.kernel.org>; Fri, 07 Aug 2026 14:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1786137631; x=1786742431; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nZUPZxX06G+USAOFyqtgdGfXpR2hkqtdlH21kk8KCjY=;
        b=Q4DU8iojzN6WeLM2eYTiJK6V3bKIFQy2e7Hh9GXe4HjqUJytlq9xpYj/gYXohPif4y
         AMeZDVR0ggtbeBvlU2iQLJu7mSZlfO6oz1DOChhAcCpkpkpDD943YhQ/kqVVo5nZc/D0
         uRYhaG3y76f+VSTOO/gFsMwKccke30eLEf8abRQES7klq4HKAVU8sUv8xzfB5p09mjop
         cIV/KqFxL9J+L4pQ5DrWVLcoGBS/s+FcxDYaDm4o/r+M3hCMmbfzSTx7xBC9dcqwO9dS
         eCFc18BsSyfuYtTtxWl2yHONwq7RCYz2weSdvWa/N28ESWeEgLJ35H036ULLJHD0RwAq
         E8lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786137631; x=1786742431;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nZUPZxX06G+USAOFyqtgdGfXpR2hkqtdlH21kk8KCjY=;
        b=XnCaI283iix3yHToqKT8Wt3wqIqmLJ091fyeSJENCUKatpPXSsjSK9VWKsLRJDGGkS
         nSElDh1vB1xvyEh+/pcmQYj6VMKlMwkRcB36oLAeIzYuRgsjlRS85mo/Kypfpmfj1y4V
         mUjgYpgfZDo4JsRAFFcXmLmLHzFX26vox+IcP4xze1o41CegtSf1i7Y5NpQl9fnBrdp6
         0Ci6qVhF/vrMuYmbj1EVJtXkEB3RSZixDnxjGuPbVJ1vlgijraQWI6mP9JKsVLIcUFQn
         sLtXnnXw4I7xXj6qDVDodvOumPs7YWMjvhR3RqF1P13vPyhC70RxBmG90hxFP74yaujt
         7nDw==
X-Forwarded-Encrypted: i=1; AHgh+Rpf4XfudWoTY3MTglFbXC5iLTrsLqoi7XAWgU78R/EshZ/7NcM0uVjsh64+O8fZ3uZvEbL1VR4mdPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAh5AE1/ifsBANQN5VDkpr9dosqU0lXtfzmEU2h1pmKUesCzyr
	blh1R1eA7rHjXTHViw+svSmAck0j4elb2eCJWagGKJqdvmRxNBChKSP4jTVYehBpzfI=
X-Gm-Gg: AR+sD13sqKwVi7NqQOd4FWVB88ltTx8kJuQbGCPAMG1mZYx0iJZMbT4LbORkGGjTkaU
	cHb2Pp3pIaTM/D4GSV1Q2XQm/DSB/yPeNypNORTUOm2gAB6ME+kVHeom9wka5jHdB/zmFwymubU
	+mcIfKFpMDOwzyk93F/tU6v/LgTDyFPg8DefgTXR/n+3TILrMPSZA7BlPMjrgyrNMpI7pfsV9oT
	bANqxJC1jW6eNX0sR6Ti801qUMEsmwrMe5Xd7JLCT8E6iGQau1Zx7d0INhZdJlWZ222cfjbHi/Q
	gKUH7oMQj+pdZZEoCUbQy1kCvMNwAZobPNoWrLxFFbbiW8cKbyugBg11NXNKpPWUrsTCTNNbl1s
	nR4j//sCMzuwl+/XA615LUI7Euv+42JecJR0sRcKOysc7vBsy9ST3D9YJTWPsffgiJtH2Orva4s
	AKZMzp5to7WfCw1kIEJo1fSg4+k7qOZwzQkrfNrS7tbYxtn5FHxIIY9RiX7yD51Xr2AO7dzWaLz
	kk=
X-Received: by 2002:a05:6808:f08:b0:495:f223:bcdb with SMTP id 5614622812f47-4b118e2d52amr7950867b6e.0.1786137631257;
        Fri, 07 Aug 2026 14:20:31 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:b714:88c:313d:dee2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b1af0bafa1sm508068b6e.7.2026.08.07.14.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 14:20:29 -0700 (PDT)
From: "David Lechner (TI)" <dlechner@baylibre.com>
Date: Fri, 07 Aug 2026 16:19:48 -0500
Subject: [PATCH v3 3/3] iio: adc: ti-ads112c14: add continuous mode support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-iio-adc-ti-ads112c14-continuous-mode-v3-3-76e0d30e6c6b@baylibre.com>
References: <20260807-iio-adc-ti-ads112c14-continuous-mode-v3-0-76e0d30e6c6b@baylibre.com>
In-Reply-To: <20260807-iio-adc-ti-ads112c14-continuous-mode-v3-0-76e0d30e6c6b@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Chris Hall <c-hall@ti.com>, Patrick Edwards <pedwards@ti.com>, 
 Kurt Borja <kuurtb@gmail.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "David Lechner (TI)" <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6724; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=MYu4KxURi0kEu9JyX7YNixCr2LSeVCPXKFGnl80k+OI=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqdkwQNvEfO6Oo3mp2GMItXZQmjm9eKH9ym8cGG
 FUeXVdtXwuJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCanZMEAAKCRDCzCAB/wGP
 wGzNB/4gfcAepkiU/2MwiEjBoMSB4ZFwHqfSVkpmEm5t+6zjXIAfQJtn+MnVOm5+CO7nl5/84h5
 ufdPC6j1qZyWewykRGlSmKATx0EO9xoSqRCT5sy4p50GegvTKgnmz0kTgZ6XNDGDTufv/yxiOBq
 Q4eEY/QYQqctAh41uRIhzLAx5O83QMDQZN/8Gt7EtSJh5zBGZSOCw3HBM4xvyiYSWzSUXlE+j0z
 njzczKbaiChHkCRtmIL+lFYaSZp6dVnd5sUGfvayHYElX51DPh0pOPCl72awZ+bNNSYhxaPK3fd
 YIukclr4Baj9+DAoQO5k+fwWCWW57asTDtW4Z8c63uQkbai+
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
 drivers/iio/adc/ti-ads112c14.c | 132 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 130 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ti-ads112c14.c b/drivers/iio/adc/ti-ads112c14.c
index 8481012c9e3d..160ee306d4a6 100644
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
@@ -280,11 +283,18 @@ static irqreturn_t ads112c14_drdy_irq_handler(int irq, void *private)
 	struct iio_dev *indio_dev = private;
 	struct ads112c14_data *data = iio_priv(indio_dev);
 
-	complete(&data->drdy_completion);
+	if (indio_dev->trig && iio_trigger_using_own(indio_dev))
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
@@ -957,10 +967,31 @@ static irqreturn_t ads112c14_trigger_handler(int irq, void *private)
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
 
@@ -992,6 +1023,89 @@ static const struct iio_info ads112c14_info = {
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
@@ -1480,6 +1594,19 @@ static int ads112c14_probe(struct i2c_client *client)
 				       0, dev_name(dev), indio_dev);
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
@@ -1490,7 +1617,8 @@ static int ads112c14_probe(struct i2c_client *client)
 
 	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
 					      iio_pollfunc_store_time,
-					      ads112c14_trigger_handler, NULL);
+					      ads112c14_trigger_handler,
+					      &ads112c14_buffer_setup_ops);
 	if (ret)
 		return ret;
 

-- 
2.43.0

