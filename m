Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA8943C076
	for <linux-iio@vger.kernel.org>; Fri,  4 Sep 2026 22:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788559882; cv=none; b=lYvml8kGb57r/MO3HKFgsE6JgODvFEyzn7YfBoKo4rRX7MrP3iBaNnwuqH4L4v3bvdYueTzzd2yHgv21wO7NToaGa7jA9rkaGf/SvYwuTi+qFfDhCU78Ks+C6pWtFY1/S4bPZvI8Un9QdSKWIuM27qFLJECfot569NIqSWxDwnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788559882; c=relaxed/simple;
	bh=l9Q45b3Na0r37AULknN0n4Ws7BStWk9ckJ7bJVedIH4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X5ZVKb+E1Eus7ECnJZoFpEg+SRaTe6s3zke/Q214/79LG4K4ur88WCCS3noePhxBI2CE5oHK4CQQMXtWqEf9dTpE+dZXeu+kFBmWbA/MIBGznLsSdNCEbzNamwqvJ0CJ2KKshE/ON7FcpIvDoALCmJpoK16tDheObnSNy2lZnwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=Syj9XQ6B; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="Syj9XQ6B"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-4b21f71613fso968648b6e.2
        for <linux-iio@vger.kernel.org>; Fri, 04 Sep 2026 15:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1788559878; x=1789164678; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CkINITabsJkMFaMz+O6WBQXk3MjQkP9P7TfGAk4KvJ8=;
        b=Syj9XQ6BWdfoRjyTE7cLtF8Wi1O4tzV3XsrcbeeY2BnlDff7B8BV1J91N+4FKJe0Q6
         pEqxgITOvNWnrgWEP7L8kOH+vCk4pflcH7o88+7xsjC4+a/RSaXcBEU/XngSR2Z4AJvV
         K9Ui+8inkcsqqD5bc7VftMC5Zw9NC99g59pKuIbisgTGo+oOy30g9tyOCXysoXa6/JNW
         ceRV/Ft1yn6nCNr85AFtjyogLaLIlY5dz1sb1QgbpcbUI7pgiFk6JLtsZYUT+RGTpZcR
         2vGLPdxTAkoHddq/GrzTkOrWRqZLZOdULcsnu7FJF//6ZG8Jy3hfl6wkmsb2RAw1zINw
         u6QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788559878; x=1789164678;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CkINITabsJkMFaMz+O6WBQXk3MjQkP9P7TfGAk4KvJ8=;
        b=ERHVC6/zMIlas1j8oDevTkWd/J1E0HM04njAp6kh20nJSDybdDyy4GnC/GBLxY7zva
         tiXJlbqHIgzorpSrJyffCXdKEX2dSRdrN8XGBzq4GyD6PNef2YkNJ69yqslLswjmANMo
         SgKk3w1Uc2/3a0r4DhUx41ZOVoCtDLy5Y9OUJ5oaWhzcSFBWnT+LB72HoO/8TuaTxVI1
         CdRjw8uG93GBYM4+gCgqUjR7MGuZ7d3bxR0pQ9tnT3BTRZru/u5bba7EaqRgnxeRShwn
         uZJMRWrOizaqBggnVGRQAHhcLfY6U1w9sRLh2Kvx/cfLuYJhb5u3wVWGMLoGkKKltKi5
         05wQ==
X-Forwarded-Encrypted: i=1; AKwUvBxmGGeJiQxoZzihJ4rxeLQWYAppqX11NlwNn5L3cpOf+pYC5Y1DHltVEPj/oRSyykGZpctt9NxMtbw=@vger.kernel.org
X-Gm-Message-State: AFuF++nBAWGX+ANzRwcj1gXnzzDtzWWQO/t+MLOG215b00WC3sMKnc+8
	9myzL1SPIVSTvu9wNbg+CU4dekQzYZJgi37xSczt/YpHO40UVf8XE/PQ/HdEwYF1YS4=
X-Gm-Gg: AYBFou3BnfW2vaHpQoAup4F+b5Qf8jBwpUOIfffROGVO37oFA4heXMM+StU741SIHfx
	fX4upI8njTOthG+Z+GnVAPGsxCjwCCrC+S27gv+HvCdudS7zlxyNRo1ZsEge7JNhuXPE3TqvPln
	DPSuDPzqpF1KDWPEaIbT6nIJb98dYZUcX0lrcDNtB6CQ2rzQZ7SVdU8fO5qxnOTr7FCnLtfNUvj
	3MF+oVP/4cffli/slpkNpGHOIgVrrx0p2/KB2SoxVAEcovEd3yMXv2Qa+Ex/ZuMacnQywmBvAqf
	nn5hFSKPrVw+5xLJiAccFT/CpN8BSD9M9BGZwA9sWkEbFuYXcpFOxT3PSoMaaF6o55oEmWRCj7g
	PyKud16b+4z/fwOtEfXl+mvdDmxAfJBmQIP1XTypKOftvtZhGWJeaG279OKtJVuIJcY2T/rWV5G
	TKmtf8z47IkZMF2Ziqmhq5ZwhWRqqb6I2Je0XDEeaHLH6w9ZUyYAYJLsNiNF/gupRbNQ==
X-Received: by 2002:a05:6808:5187:b0:4a3:ff0a:e407 with SMTP id 5614622812f47-4b962843ed4mr8194737b6e.15.1788559876969;
        Fri, 04 Sep 2026 15:11:16 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:4324:3ccf:e2bf:d545])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b970d1ff95sm3187113b6e.6.2026.09.04.15.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 15:11:15 -0700 (PDT)
From: "David Lechner (TI)" <dlechner@baylibre.com>
Date: Fri, 04 Sep 2026 17:09:48 -0500
Subject: [PATCH v2 03/10] iio: adc: ti-ads112c14: add continuous mode
 support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-iio-adc-ti-ads112c14-filter-support-v2-3-f86592360658@baylibre.com>
References: <20260904-iio-adc-ti-ads112c14-filter-support-v2-0-f86592360658@baylibre.com>
In-Reply-To: <20260904-iio-adc-ti-ads112c14-filter-support-v2-0-f86592360658@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Chris Hall <c-hall@ti.com>, Patrick Edwards <pedwards@ti.com>, 
 Kurt Borja <kuurtb@gmail.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "David Lechner (TI)" <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=8104; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=l9Q45b3Na0r37AULknN0n4Ws7BStWk9ckJ7bJVedIH4=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqm0HFhPBkrZGiL8eDZSYH9sOM3kV6Jtt6VYxUt
 SpsuISDTzaJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaptBxQAKCRDCzCAB/wGP
 wAAEB/90rNcsdeuJothe1lQBEeHTKsF6AiNZ8tIZUEkvPH8U0HVCUF0ITlJWqji+/DSngK14sdI
 NscwVCgbWWznZBY4ewVghWtVEAvR53bj8JRz39uRQ6yD8ZBDrEnkL+EGmin7U3qnyjehIG5C9Sj
 KxYoyqhZsF/RdzJvrcvx6RfWLIZZXEoc8y7b+fBluRL4lNQSPcryqwDfEWg3UZHR9xC/JGoVVBM
 Iu5J+Ms6HwpyFJkxWz+/VcNzeOvojnScnTsRmrROt+E4OAQlr8x4Ww1niFjQQu6+bX8zKTnkXTL
 UdVxazEEPAxEK0C24TICzwtAylA44ZF0Yp8G+WwkEjy5/vA1
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
index 23f15be303fb..06b962fbde5e 100644
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
@@ -1480,6 +1615,19 @@ static int ads112c14_probe(struct i2c_client *client)
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

