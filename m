Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73963CF20A
	for <linux-iio@vger.kernel.org>; Thu, 27 Aug 2026 22:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787869419; cv=none; b=YAyjEgWuE4B4Dz3tdHUWTeHzzuzkUpCKPEuH28jVIlanruJQHZzBvjK7PRQfMOcXyK6cTa2drk6QaynbEXY9SH+4B+rlzuL5Fv9vnHVKa7TLevZCsAYmgJU8lMM7nmVkCFOBjIoRKXtshqVFd2gmGUQsrvJFeVKSqJAyB6w8DNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787869419; c=relaxed/simple;
	bh=NDSDpivYarXePwTSDpiVgkViP53hrWoSMytekojHNS0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NuhGI6Y46Z75JDb4bwbKGeZcEE0hnCyOB863syWGrpBgV5DzglAr2Ep91GJaeXaodDRr83wPuDszxtW5Dup2QHoBTSHwdRhshcy6ihtGxf7S9JPANRyrD5eeNsBBZG2Yp+23MrBysZxeGUza3hc+gyqhnL9c//XcnccoC0Lu6LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=Bj9n86/4; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="Bj9n86/4"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-45eddb6fdccso351290fac.2
        for <linux-iio@vger.kernel.org>; Thu, 27 Aug 2026 15:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1787869411; x=1788474211; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iNTRuf05CTvv6ajYQ262DYaZCyLOnZ0DLR4E2AczWeM=;
        b=Bj9n86/454/r0A5Rz30RgYmgEUzHeIJZ/uje9shf9gzih+oovpz6r40xX11R63es+k
         UszRfDxw0Zj9M1q2nDgPST4DEvUaU5Zenzd3qHA/0aZsC2C8d1R+eTe2OWdJe0RAJBKt
         n2UKoE3Owz7bcZeWTIJWKDZKfGCQzN9gcUtykeQSc3aYscSZwg957OB3qcbFSb1Ql2jq
         my5UowA7++8OL+0jWxrs1RADhUXJ2OXcgiJKDPWhzC12E9G1NaqvKIUH7piyl4bBzJtb
         DqaTQ7gB5wEnpWeei6TX63m7GjfpcSTQ+6XJWScjtnpYy9adSCxUqDJJ/XsiA+PkkySn
         oNMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787869411; x=1788474211;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iNTRuf05CTvv6ajYQ262DYaZCyLOnZ0DLR4E2AczWeM=;
        b=ZcMVXFkyPkQga7vh4pZ6341bHYY5Ti56PbAJPeneXuYCPe9rmubhDH0wKwq6fIsRfE
         7vM4MUh7d0culVXaog0oAHurDyBBfApzRC8hooxpWh78GZDM5g4IdEJGEHJGx8w2iWrD
         90PvZqFWIVEm5Ff8q0u2VehcdS/Lav9v3+g2+KJgvXeRqyc/c5NM24DYJ/LWoFh2i4r0
         qfgqajmpLGxgJPG6/6PSNcA9lLC22JmiZvB1v+ooTmiQ6cn5xWhuX8QEnm3zZ7mUSEGA
         At0AbBpHcvX0Aix5xwJB0HAKbOKsoP6BbPZV19wDm8b49NkoJ+nOzMe9Wr54VbWyU+gm
         bImQ==
X-Forwarded-Encrypted: i=1; AHgh+RqXD8SIWKzXU5VqV12JE86wgZvXrwWc2DZ3yXnQZh2d8KptTIPwZVOnlOlhf5SC7mckp/Ko+4iFt/Q=@vger.kernel.org
X-Gm-Message-State: AFuF++ljT/D8Dcf4JaCMf9U/sbigKzmbdya3PxoUGH/AWOhnzBu4V6bn
	9pY5vgwWYUJB71b08TPUlJx5jNulTcKHbsw/Gc1DQ5kQt2w0UFZ3k9X03lxQbfuyHJ8=
X-Gm-Gg: AR+sD12aD3xaA/4nldZ4TxXqdQOwcMgCOm4HwTxtosLH5DLce2Ap7dFXtb3cvyvf2Wz
	/wvphSE9QikAcu2o1DRhR/ityA92mmzUH8a8dUQ/mh5guJoKpCs4lUeXwOAoHn4cOD047uUrsLX
	0K3fTtSEZi59ujFlJ1SZGs9kyRUtzMVno3YtK9ISjw61vtzjkBn5QryqPZvL1Y6Gtkm+RsVrDFH
	sQvjGTsu4jPaMUh6nn3zHTPrmj70UcGmYQ35gRN/hI1OyZLiTocqifR2Z402VbZi8OjD3mWvmHZ
	5aweTHFw5r7NK+wz1Bhqq7gdHJmIisBO0gut134hTLpHI0g2yIcaA7HNQRBpGuhAZ585jqneLc5
	0tA/tmohtZc4dhlf9BcXyZF+Jqr48DieQxpmKto988NjBXHxdQ7lu2HjooPcR2P7Zp/iZ/pFUS6
	/SuzryDrH4QnqstmdXYpFNslaoKnocVrFMTTuv/gIGA3V+ojar0qbT81fro7PyKbwLrc9Xs7iqV
	RID
X-Received: by 2002:a05:6870:340c:b0:417:4693:ca0 with SMTP id 586e51a60fabf-46837336748mr3287799fac.14.1787869411000;
        Thu, 27 Aug 2026 15:23:31 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:d288:6f77:e285:6925])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-46736445d6csm3176880fac.2.2026.08.27.15.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 15:23:30 -0700 (PDT)
From: "David Lechner (TI)" <dlechner@baylibre.com>
Date: Thu, 27 Aug 2026 17:22:53 -0500
Subject: [PATCH v4 1/3] iio: adc: ti-ads112c14: add DRDY interrupt support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-iio-adc-ti-ads112c14-continuous-mode-v4-1-1e51a6e20a69@baylibre.com>
References: <20260827-iio-adc-ti-ads112c14-continuous-mode-v4-0-1e51a6e20a69@baylibre.com>
In-Reply-To: <20260827-iio-adc-ti-ads112c14-continuous-mode-v4-0-1e51a6e20a69@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Chris Hall <c-hall@ti.com>, Patrick Edwards <pedwards@ti.com>, 
 Kurt Borja <kuurtb@gmail.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "David Lechner (TI)" <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6047; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=NDSDpivYarXePwTSDpiVgkViP53hrWoSMytekojHNS0=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqkLjL4zBRwoqqPUTVf7uUQ/AGhhA7trbe/0MLE
 jXD4Q5bhk2JATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCapC4ywAKCRDCzCAB/wGP
 wI9VB/wOUhPd+nshKlotSaCWLOXFgUr+QeZ7Sf1Pt/vGSoCOcObHFrujg3gPRKNUbl5yncXYgpj
 BybatK1G3EV/fcQgWRVOJ5iTT2czeznwN4rubcXiBJRb4MDehx2eI0sPEB+8aT8ncwEAEiikiVw
 z9vvY0LnW8DwPMbyo33WZI2zkiGG2gGN9CXqGgwgvSWJWK0f6O0ryipEYOfh8ix8JL7HgZsJvtr
 nXLgDb6+R2O6LFQLveVOmE40F+33FnNRgW8bjtlPTib1/xS/oIU5obhJijpglRZ5vJi+vO+IBgz
 5Vxqry0Gedl5kuBneT8zkvh4Aro1p8H2CcvNLkAeNKd134Us
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add handling for the DRDY interrupt to wait for data ready events rather
than polling (only when it is wired up).

Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
---

Small note: the hard-coded 100 ms timeout will be replaced in a future
series with a dynamic value, so I didn't bother with a macro or comments
to explain why the value was chosen.

And passing indio_dev instead of data to irq is intentional as it will
be used in the next patch.
---
 drivers/iio/adc/ti-ads112c14.c | 100 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 90 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/adc/ti-ads112c14.c b/drivers/iio/adc/ti-ads112c14.c
index 60eab4852ba2..63b819339788 100644
--- a/drivers/iio/adc/ti-ads112c14.c
+++ b/drivers/iio/adc/ti-ads112c14.c
@@ -10,6 +10,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/cleanup.h>
+#include <linux/completion.h>
 #include <linux/crc8.h>
 #include <linux/delay.h>
 #include <linux/dev_printk.h>
@@ -19,6 +20,7 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
+#include <linux/interrupt.h>
 #include <linux/math64.h>
 #include <linux/minmax.h>
 #include <linux/module.h>
@@ -117,9 +119,15 @@
 #define   ADS112C14_GPIO_CFG_GPIO2_CFG			GENMASK(5, 4)
 #define   ADS112C14_GPIO_CFG_GPIO1_CFG			GENMASK(3, 2)
 #define   ADS112C14_GPIO_CFG_GPIO0_CFG			GENMASK(1, 0)
+#define     ADS112C14_GPIO_CFG_GPIO_CFG_DISABLED	  0
+#define     ADS112C14_GPIO_CFG_GPIO_CFG_INPUT		  1
+#define     ADS112C14_GPIO_CFG_GPIO_CFG_OUTPUT_PUSH_PULL  2
+#define     ADS112C14_GPIO_CFG_GPIO_CFG_OUTPUT_OPEN_DRAIN 3
 
 #define ADS112C14_REG_GPIO_DATA_OUTPUT			0x0C
 #define   ADS112C14_GPIO_DATA_OUTPUT_GPIO3_SRC		BIT(7)
+#define     ADS112C14_GPIO_DATA_OUTPUT_GPIO3_SRC_DAT_OUT  0
+#define     ADS112C14_GPIO_DATA_OUTPUT_GPIO3_SRC_DRDY	  1
 #define   ADS112C14_GPIO_DATA_OUTPUT_GPIO2_SRC		BIT(6)
 #define   ADS112C14_GPIO_DATA_OUTPUT_GPIO3_DAT_OUT	BIT(3)
 #define   ADS112C14_GPIO_DATA_OUTPUT_GPIO2_DAT_OUT	BIT(2)
@@ -251,6 +259,8 @@ struct ads112c14_data {
 	struct regmap *regmap;
 	/* Synchronizes access to register value fields. */
 	struct mutex lock;
+	int drdy_irq;
+	struct completion drdy_completion;
 	bool i2c_crc_enabled;
 	u32 avdd_uV;
 	u32 ext_ref_uV;
@@ -265,6 +275,16 @@ struct ads112c14_data {
 						 ARRAY_SIZE(ads112c14_sys_mon_channels));
 };
 
+static irqreturn_t ads112c14_drdy_irq_handler(int irq, void *private)
+{
+	struct iio_dev *indio_dev = private;
+	struct ads112c14_data *data = iio_priv(indio_dev);
+
+	complete(&data->drdy_completion);
+
+	return IRQ_HANDLED;
+}
+
 static bool ads112c14_writeable_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
@@ -581,12 +601,45 @@ static int ads112c14_prepare_sys_mon_channel(struct ads112c14_data *data,
 	return 0;
 }
 
+static int ads112c14_wait_for_conversion_irq(struct ads112c14_data *data)
+{
+	unsigned long remaining;
+	int ret;
+
+	reinit_completion(&data->drdy_completion);
+
+	ret = regmap_write(data->regmap, ADS112C14_REG_CONVERSION_CTRL,
+			   ADS112C14_CONVERSION_CTRL_START);
+	if (ret)
+		return ret;
+
+	remaining = wait_for_completion_timeout(&data->drdy_completion,
+						msecs_to_jiffies(100));
+
+	return remaining ? 0 : -ETIMEDOUT;
+}
+
+static int ads112c14_wait_for_conversion_poll(struct ads112c14_data *data)
+{
+	u32 reg_val;
+	int ret;
+
+	ret = regmap_write(data->regmap, ADS112C14_REG_CONVERSION_CTRL,
+			   ADS112C14_CONVERSION_CTRL_START);
+	if (ret)
+		return ret;
+
+	return regmap_read_poll_timeout(data->regmap,
+					ADS112C14_REG_STATUS_MSB, reg_val,
+					FIELD_GET(ADS112C14_STATUS_MSB_DRDY, reg_val),
+					1 * USEC_PER_MSEC, 100 * USEC_PER_MSEC);
+}
+
 static int ads112c14_single_conversion(struct ads112c14_data *data,
 				       const struct iio_chan_spec *chan,
 				       u8 *buf, bool for_scan)
 {
 	struct i2c_client *client = to_i2c_client(regmap_get_device(data->regmap));
-	u32 reg_val;
 	int ret;
 
 	guard(mutex)(&data->lock);
@@ -601,15 +654,10 @@ static int ads112c14_single_conversion(struct ads112c14_data *data,
 			return ret;
 	}
 
-	ret = regmap_write(data->regmap, ADS112C14_REG_CONVERSION_CTRL,
-			   ADS112C14_CONVERSION_CTRL_START);
-	if (ret)
-		return ret;
-
-	ret = regmap_read_poll_timeout(data->regmap,
-				       ADS112C14_REG_STATUS_MSB, reg_val,
-				       FIELD_GET(ADS112C14_STATUS_MSB_DRDY, reg_val),
-				       1 * USEC_PER_MSEC, 100 * USEC_PER_MSEC);
+	if (data->drdy_irq)
+		ret = ads112c14_wait_for_conversion_irq(data);
+	else
+		ret = ads112c14_wait_for_conversion_poll(data);
 	if (ret)
 		return ret;
 
@@ -1391,6 +1439,38 @@ static int ads112c14_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
+	if (device_property_present(dev, "interrupt-names")) {
+		data->drdy_irq = fwnode_irq_get_byname(dev_fwnode(dev), "drdy");
+		if (data->drdy_irq < 0)
+			return dev_err_probe(dev, data->drdy_irq,
+					     "failed to get drdy interrupt\n");
+
+		/*
+		 * REVISIT: would probably need to implement a pin controller in
+		 * order to support open drain option here.
+		 */
+		ret = regmap_update_bits(data->regmap, ADS112C14_REG_GPIO_CFG,
+					 ADS112C14_GPIO_CFG_GPIO3_CFG,
+					 FIELD_PREP(ADS112C14_GPIO_CFG_GPIO3_CFG,
+						    ADS112C14_GPIO_CFG_GPIO_CFG_OUTPUT_PUSH_PULL));
+		if (ret)
+			return ret;
+
+		ret = regmap_update_bits(data->regmap, ADS112C14_REG_GPIO_DATA_OUTPUT,
+					 ADS112C14_GPIO_DATA_OUTPUT_GPIO3_SRC,
+					 FIELD_PREP(ADS112C14_GPIO_DATA_OUTPUT_GPIO3_SRC,
+						    ADS112C14_GPIO_DATA_OUTPUT_GPIO3_SRC_DRDY));
+		if (ret)
+			return ret;
+
+		init_completion(&data->drdy_completion);
+
+		ret = devm_request_irq(dev, data->drdy_irq, ads112c14_drdy_irq_handler,
+				       0, dev_name(dev), indio_dev);
+		if (ret)
+			return ret;
+	}
+
 	ads112c14_populate_tables(data);
 
 	indio_dev->name = info->name;

-- 
2.43.0

