Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDB7303C8A
	for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 07:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784361048; cv=none; b=H7Cu5n8PcU0MdXc2xgNBbm0p+8oxmLJ3PZrh9fbzYo1I/z+fIwN/tqp6KK4c67ja0MSMby3g8spFOP3Zpe7JUsb2/XJLEri9C9gKx63H2SdWQxOOuYj1DLBWirQ1dKvB5ADbSlLdBcCUB6fDVMOiPzdaGBRo9chH8j101ay/yeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784361048; c=relaxed/simple;
	bh=axGdFwDRPmHC80+igOjmSxNrGka73suNE+Z56JHacSg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DWP7gs+9B1R2su6ykMeX0qBLxt4dtGxl2KmR3hFKP7pFwuZQoIudNnlArTwrQbEAuiSZQ0ImGVEUyC3PKXODB63PKpwQXRBq5rd9GyvqwPG7JCg+r8VUasP5ihRJ9lm+ij3bLRWeKFKuvWM69Ck1KUGhvgXQcKxlCKK2AqQ8anE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fKPf32Is; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fKPf32Is"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c9e0b89e228so3289353a12.1
        for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 00:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784361046; x=1784965846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZYQz/KYXwf3OLcsAA66MTPAZaZSTmxzDqnf6BrqdGD8=;
        b=fKPf32IsYhkP0RiFuRI/+PfoRbFfKnJDzi5t8GNgqeI0UP0PnIYd7qvxHb9iv6YKhe
         E/BwTjpmjlDg29oY+CJ1JciwGTLB93kaNkQC8d19ZmK8hI7J+nfQ1DqPrD4LsTdS1zoe
         2cSYUKvXxIdzPvzQmpywj98Ao6wgypm+NPLiJosdJV16T5CTMT2Ynzd/j5NLeAgoBgri
         6E6YqaAt69JHBf2HWv/o9xhGUuDhP5fKf42uqF/LEXeJl5KcbmBVNLYfLlaz8TIfzQP/
         P7mKrf4pr3bhMMjmleFa3coSrzWyzSpg90eBapLOlU5/IEwA+L7rZ4RJ9Ceeu9tdVkbh
         Fw9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784361046; x=1784965846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZYQz/KYXwf3OLcsAA66MTPAZaZSTmxzDqnf6BrqdGD8=;
        b=J2AmKg1GWcQjiaYt2+Qv66yH5TlRL4rcECrYQGKjpUgi4HClpxID162T0++ZtzcS0l
         tNlUE2EhJ1lq7NesO9yfaFpGkK6W8m+EdTJSfVBBIRdMZxEEbBiIUJQbxYrzvPPki9y2
         EEPuvg6nb/xE6l3hbod9btJj8eH77M1IvaInPtLqc5ojLtxzJ3zt+kod2nMiGSfd+iO4
         H20s4vMmFmgZRUiCDoM2UTDrYtxfDrtLUywLUYolMryFX1LfqqPlWQeLfuJ2ra9vgwwf
         gSmk+MVyakzxtpJ1mXg1HnlCdlT/fSFosiY58t1nNFmKCqweR3oCHoYIt+Z3r6iI95uX
         lIbQ==
X-Forwarded-Encrypted: i=1; AHgh+RqG6PEXy6CIFiMDsv49stKTotDlWOVEQyWrsOu1QwxKSALaCJ85Xmq0PHTpYwRYtBl0nLWKPL79jdw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYaleXhxZY132TCkx2Gz8YZHGDo0DtxSo8fBXcMWoJuV++P4ZU
	5jxwPx+VaVWZfhtketnwaN21Q89jqRdSolCXueSAlM2P9I9fQzoa/Zf5
X-Gm-Gg: AfdE7ckDcvTMfuSMcV2vIYRZ8mC5pja6b0f1yvOSn+0MRIwXHbRxEx/NsWRIqYd3HVG
	RwcJR3MvIsMLr2t0aztoreFJ9ODyK/fWf0+esekMy8hxM5kwAcoEHVJGMRmoIW/BDIh6MuIFeq/
	1rcV60tEE3qZE/gGqXnEZMWAA3vp2WfgeXcFXeCvSu+lpoGzM3ojuNuwOrGcAH3NAtm1VMSkarm
	Iv43+3QPX+HuR2s6udKAMk2TkcAfTezrIDZB6FUL9MGHLu1Jn1U3tPFXNp1FtAkqu36ykWbpKPt
	6rh3S/YJcqPzFOJbf8XxD9Bjp96lQ1Ka/AsslVckdempHFbDVyjg+dv2HcWFAAx++ufV/fszkIX
	TUxdERHCUBK6L9wX3fm0mQx2xv15ad01ViB77QT2bw9JXW0T2AsSHafYO3sQN2SAapPq2KfcdVF
	0u8BNyu9WBsYBR/FqW1psRHPK7PS4LrgfBH+yT2Yrzf5wCZj62pNav
X-Received: by 2002:a05:6a21:6b17:b0:3c3:7f8f:88cc with SMTP id adf61e73a8af0-3c3ad963e78mr5739675637.46.1784361046046;
        Sat, 18 Jul 2026 00:50:46 -0700 (PDT)
Received: from debian.ari ([152.56.157.145])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a20bf96sm14354220eec.28.2026.07.18.00.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 00:50:45 -0700 (PDT)
From: Archit Anant <architanant5@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	andy@kernel.org,
	nuno.sa@analog.com,
	u.kleine-koenig@baylibre.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Archit Anant <architanant5@gmail.com>
Subject: [PATCH 3/3] iio: adc: ti-ads1015: convert to fully managed resources
Date: Sat, 18 Jul 2026 13:20:16 +0530
Message-Id: <20260718075016.27750-4-architanant5@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260718075016.27750-1-architanant5@gmail.com>
References: <20260718075016.27750-1-architanant5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor the driver to use devm_ allocations and power
management, allowing for the complete removal of the
ads1015_remove()

Key changes:
- Use devm_add_action_or_reset() to ensure the ADC is safely powered
down upon driver removal.
- Move to devm_pm_runtime_set_active_enabled() to manage the runtime
PM lifecycle.
- Update the PM operations to use DEFINE_RUNTIME_DEV_PM_OPS and
pm_ptr() for modern compiler saftey.
- Convert iio_device_register() and mutex_init() to their devm_
variants.
- Remove the thus obsolete ads1015_remove() function.

Signed-off-by: Archit Anant <architanant5@gmail.com>
---
 drivers/iio/adc/ti-ads1015.c | 58 ++++++++++++++++--------------------
 1 file changed, 26 insertions(+), 32 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index 0232a4ca2d77..57e5fa593b31 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -930,6 +930,14 @@ static int ads1015_set_conv_mode(struct ads1015_data *data, int mode)
 				  mode << ADS1015_CFG_MOD_SHIFT);
 }
 
+static void ads1015_power_off(void *data)
+{
+	struct ads1015_data *st = data;
+
+	/* power down single shot mode */
+	ads1015_set_conv_mode(st, ADS1015_SINGLESHOT);
+}
+
 static int ads1015_probe(struct i2c_client *client)
 {
 	const struct ads1015_chip_data *chip;
@@ -950,7 +958,9 @@ static int ads1015_probe(struct i2c_client *client)
 	data = iio_priv(indio_dev);
 	i2c_set_clientdata(client, indio_dev);
 
-	mutex_init(&data->lock);
+	ret = devm_mutex_init(dev, &data->lock);
+	if (ret)
+		return ret;
 
 	indio_dev->name = ADS1015_DRV_NAME;
 	indio_dev->modes = INDIO_DIRECT_MODE;
@@ -1033,38 +1043,23 @@ static int ads1015_probe(struct i2c_client *client)
 
 	data->conv_invalid = true;
 
-	ret = pm_runtime_set_active(dev);
+	ret = devm_add_action_or_reset(dev, ads1015_power_off, data);
 	if (ret)
 		return ret;
-	pm_runtime_set_autosuspend_delay(dev, ADS1015_SLEEP_DELAY_MS);
-	pm_runtime_use_autosuspend(dev);
-	pm_runtime_enable(dev);
 
-	ret = iio_device_register(indio_dev);
-	if (ret < 0) {
-		dev_err(dev, "Failed to register IIO device\n");
+	ret = devm_pm_runtime_set_active_enabled(dev);
+	if (ret)
 		return ret;
-	}
 
-	return 0;
-}
-
-static void ads1015_remove(struct i2c_client *client)
-{
-	struct iio_dev *indio_dev = i2c_get_clientdata(client);
-	struct ads1015_data *data = iio_priv(indio_dev);
-	int ret;
-
-	iio_device_unregister(indio_dev);
-
-	pm_runtime_disable(&client->dev);
-	pm_runtime_set_suspended(&client->dev);
+	pm_runtime_set_autosuspend_delay(dev, ADS1015_SLEEP_DELAY_MS);
+	pm_runtime_use_autosuspend(dev);
 
-	/* power down single shot mode */
-	ret = ads1015_set_conv_mode(data, ADS1015_SINGLESHOT);
+	ret = devm_iio_device_register(dev, indio_dev);
 	if (ret)
-		dev_warn(&client->dev, "Failed to power down (%pe)\n",
-			 ERR_PTR(ret));
+		return dev_err_probe(dev, ret,
+				     "Failed to register IIO device\n");
+
+	return 0;
 }
 
 #ifdef CONFIG_PM
@@ -1090,10 +1085,10 @@ static int ads1015_runtime_resume(struct device *dev)
 }
 #endif
 
-static const struct dev_pm_ops ads1015_pm_ops = {
-	SET_RUNTIME_PM_OPS(ads1015_runtime_suspend,
-			   ads1015_runtime_resume, NULL)
-};
+static DEFINE_RUNTIME_DEV_PM_OPS(ads1015_pm_ops,
+				  ads1015_runtime_suspend,
+				  ads1015_runtime_resume,
+				  NULL);
 
 static const struct ads1015_chip_data ads1015_data = {
 	.channels	= ads1015_channels,
@@ -1148,10 +1143,9 @@ static struct i2c_driver ads1015_driver = {
 	.driver = {
 		.name = ADS1015_DRV_NAME,
 		.of_match_table = ads1015_of_match,
-		.pm = &ads1015_pm_ops,
+		.pm = pm_ptr(&ads1015_pm_ops),
 	},
 	.probe		= ads1015_probe,
-	.remove		= ads1015_remove,
 	.id_table	= ads1015_id,
 };
 
-- 
2.39.5

