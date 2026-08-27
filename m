Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA84499F07
	for <linux-iio@vger.kernel.org>; Thu, 27 Aug 2026 17:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787851334; cv=none; b=OGRTTuaWu4NrGWm+B+Q+laiF2iu0rHyVyN/C4L0VsVagqH4FZ2re9yQ5eTR1/5hPlYaVeX9o9VdVfkogUYv4tHjg0UFddY6wV65l4+V5pvXkzQcgQi9yqMkZdcoKpqWM/wNkQV4YuXllGhIedvGvN0XoxcFWBjOyOCLApEPNdgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787851334; c=relaxed/simple;
	bh=J2EcOeMd2OmrNccebRyTDB0Wq+MHEvb9vc6I0fgxqgY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j9pVlau9K/uhaeJR70fVf637ytKhll2Nx0Hh7qIlMGYaQHzAC+4W5jObcpbpMTbJawkYk7U/668p4jBiRLTB51XHtrsFFC4w5PaRs5oS6Pu+pEUffqjLRVn8bXMSAWH3ykdfHMXOR6vs+OYJF7Bv0FrE5lntZ0Ge2k97JxtItKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OYq0Knpx; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OYq0Knpx"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38dfe910e9dso248854a91.3
        for <linux-iio@vger.kernel.org>; Thu, 27 Aug 2026 10:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787851332; x=1788456132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OInfa0FfwgSOfH71N8TEeQkXznl+VqaYA4i5iO+q5S8=;
        b=OYq0KnpxTD4MdyfKvx4fW1vce6pyVHP+ALIslgja6PVahRp3aFXdqL0T/NVWzlNTaj
         kaBkQ1nAM4/TT02Aq/R8MNHfyjqQcgSxhdPkb/UiVaqT/6vAqdyhKTrxdDPGxjXNEsZA
         9I1QB9Gk+IjuM082wsFfuBsggSxXEKND5LZ0vemCzM6W2EEdmIXh40I3WyGAgE014dAE
         yrrFqTBMQtkr0/UrplCAVAvHWmaBB7u9R3Qb+nRcocJNcwf3JI5TeVUdljI+zXmVnfRs
         kSN3dxkyGPm3EqlinmAssXEKG2liPNYEpiy9Eja0y9iDM8yjhp0G4cPvXDWTCwdqCHMy
         Wo2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787851332; x=1788456132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OInfa0FfwgSOfH71N8TEeQkXznl+VqaYA4i5iO+q5S8=;
        b=m3HaC3pPDAKjFIRZiYcfh8X2++LHciLIsNe75uqhSAFzjodhF8AQuSL7J2xwI+XH+r
         0gNqTnJ60dXJaZvwZbgGHydHAZUAEJkysPKx7XCbTJTjbSpblf8rz3/c6xe4ICK69QgQ
         38UCpuNTc5pSfi7AftZ13okvL1FxHcUbwOuUjkLoDlczxRJNc282DpOeRNpMgAzd0eP5
         6kgEpPw8aCRiPx8lZzxP65s5O8dJfCo5dwfm266hW6WAxZBCL0atDyIKjnE826kxfvsH
         lYOCOpr4NBv87w3jxIkFW+keVxqD7MFk8pWbyzlRUBg/SbMYqAYQVB9QNUQ6GC4rAd8C
         kLlA==
X-Forwarded-Encrypted: i=1; AHgh+RpeUqD/UcU2p512d2tfEXy2sU/HQzsz1qBwfgC/85YhPtMrn+qMP3TnLWjf5u6XDTZ0bP+qyJaomdE=@vger.kernel.org
X-Gm-Message-State: AFuF++l2h0tDjcoNDRKn5hWR+F0MSukN5QVaSjFoZeognuIWuw+u1F0h
	fr1LwV22MZhoUNML36dmITZqEqPibb1s63kwA5uZIUdNffYRh0v9k6XK
X-Gm-Gg: AR+sD11oQW6QBlOA7P3I2Z+llidiR8uoHRsD58SuDG0ydO//ybManLIlTfIR0dfLHa3
	5F75tIclXp9Irpiqmt3ZychqSipzXkcV8ytWnEx1dH1Fkj3AqAJb7VkiJN0iQ8sfgyAhQ+9rGEJ
	2b8m6jueb+EVQJtBwzu2Tz2Ncrhzg9hASLgAuqldYSo0oMC9PL46a+2kWLi4wvqwCUvH+5YUZri
	8UJhugwD9qpDbBI4xWNaRs0V32prxanAdal92j1WbIVeACjup8OBZW1cDA3y4eWX5QXtn/8fWzA
	roWVeIHCGcxvQVF+JUPlB2u/490H/8jpQB0MeZ+m0PCPWRCDmKXFz76Ch+Y8N549+krFc7R/7Mu
	mp/3/0xSv5NQ7fiZEYBvtZxe8nA9YQJL2xlk3ws1zJtMQO3ZH6eAhBwF74IsLFxvoxxF4hrxHIW
	ItYrV4iv8H33L82CBH/VwwiM96ggq67ocVU8vC2fgPJLkBMZTx0X0TJpeEDj1rHMh7bcMtS5Jsc
	SRPgP9SwO5WCZn8xiSarF64SCEHi6qCYnXf
X-Received: by 2002:a17:90b:1d04:b0:38e:4cb:51f with SMTP id 98e67ed59e1d1-396d0f75f2fmr1416549a91.11.1787851331929;
        Thu, 27 Aug 2026 10:22:11 -0700 (PDT)
Received: from debian.ari ([47.30.51.191])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141a8eedd13sm17797165c88.1.2026.08.27.10.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 10:22:11 -0700 (PDT)
From: Archit Anant <architanant5@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	andy@kernel.org,
	nuno.sa@analog.com,
	u.kleine-koenig@baylibre.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Archit Anant <architanant5@gmail.com>
Subject: [PATCH v4 8/8] iio: adc: ti-ads1015: inline ads1015_set_conv_mode()
Date: Thu, 27 Aug 2026 22:51:00 +0530
Message-Id: <20260827172100.39176-9-architanant5@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260827172100.39176-1-architanant5@gmail.com>
References: <20260827172100.39176-1-architanant5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ads1015_set_conv_mode() helper function is a single-line wrapper
around regmap_update_bits().

With the transition to the FIELD_PREP() macro, the raw register updates
are now self-documenting and easy to read. Remove the wrapper function
and inline the regmap calls directly at the call sites.

This also allows for the removal of the final custom shift macro,
ADS1015_CFG_MOD_SHIFT.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Archit Anant <architanant5@gmail.com>
---
 drivers/iio/adc/ti-ads1015.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index d675f82c0bd5..2072b9dd43e8 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -40,8 +40,6 @@
 #define ADS1015_LO_THRESH_REG	0x02
 #define ADS1015_HI_THRESH_REG	0x03
 
-#define ADS1015_CFG_MOD_SHIFT	8
-
 #define ADS1015_CFG_COMP_QUE_MASK	GENMASK(1, 0)
 #define ADS1015_CFG_COMP_LAT_MASK	BIT(2)
 #define ADS1015_CFG_COMP_POL_MASK	BIT(3)
@@ -739,6 +737,7 @@ static int ads1015_disable_event_config(struct ads1015_data *data,
 	const struct iio_chan_spec *chan, int comp_mode)
 {
 	unsigned int val = FIELD_PREP(ADS1015_CFG_COMP_QUE_MASK, ADS1015_CFG_COMP_DISABLE);
+	struct regmap *map = data->regmap;
 	int ret;
 
 	if (!ads1015_event_channel_enabled(data))
@@ -751,7 +750,7 @@ static int ads1015_disable_event_config(struct ads1015_data *data,
 			comp_mode == ADS1015_CFG_COMP_MODE_WINDOW)
 		return 0;
 
-	ret = regmap_update_bits(data->regmap, ADS1015_CFG_REG, ADS1015_CFG_COMP_QUE_MASK, val);
+	ret = regmap_update_bits(map, ADS1015_CFG_REG, ADS1015_CFG_COMP_QUE_MASK, val);
 	if (ret)
 		return ret;
 
@@ -913,19 +912,14 @@ static void ads1015_get_channels_config(struct i2c_client *client)
 	}
 }
 
-static int ads1015_set_conv_mode(struct ads1015_data *data, int mode)
-{
-	return regmap_update_bits(data->regmap, ADS1015_CFG_REG,
-				  ADS1015_CFG_MOD_MASK,
-				  mode << ADS1015_CFG_MOD_SHIFT);
-}
-
 static void ads1015_power_down(void *p)
 {
+	unsigned int val = FIELD_PREP(ADS1015_CFG_MOD_MASK, ADS1015_SINGLESHOT);
 	struct ads1015_data *data = p;
+	struct regmap *map = data->regmap;
 	int ret;
 
-	ret = ads1015_set_conv_mode(data, ADS1015_SINGLESHOT);
+	ret = regmap_update_bits(map, ADS1015_CFG_REG, ADS1015_CFG_MOD_MASK, val);
 	if (ret)
 		dev_warn(regmap_get_device(data->regmap),
 			 "Failed to power down (%pe)\n", ERR_PTR(ret));
@@ -933,6 +927,7 @@ static void ads1015_power_down(void *p)
 
 static int ads1015_probe(struct i2c_client *client)
 {
+	unsigned int cfg_mode = FIELD_PREP(ADS1015_CFG_MOD_MASK, ADS1015_CONTINUOUS);
 	const struct ads1015_chip_data *chip;
 	struct device *dev = &client->dev;
 	struct iio_dev *indio_dev;
@@ -1028,7 +1023,7 @@ static int ads1015_probe(struct i2c_client *client)
 			return ret;
 	}
 
-	ret = ads1015_set_conv_mode(data, ADS1015_CONTINUOUS);
+	ret = regmap_update_bits(data->regmap, ADS1015_CFG_REG, ADS1015_CFG_MOD_MASK, cfg_mode);
 	if (ret)
 		return ret;
 
@@ -1049,19 +1044,23 @@ static int ads1015_probe(struct i2c_client *client)
 
 static int ads1015_runtime_suspend(struct device *dev)
 {
+	unsigned int val = FIELD_PREP(ADS1015_CFG_MOD_MASK, ADS1015_SINGLESHOT);
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
 	struct ads1015_data *data = iio_priv(indio_dev);
+	struct regmap *map = data->regmap;
 
-	return ads1015_set_conv_mode(data, ADS1015_SINGLESHOT);
+	return regmap_update_bits(map, ADS1015_CFG_REG, ADS1015_CFG_MOD_MASK, val);
 }
 
 static int ads1015_runtime_resume(struct device *dev)
 {
+	unsigned int val = FIELD_PREP(ADS1015_CFG_MOD_MASK, ADS1015_CONTINUOUS);
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
 	struct ads1015_data *data = iio_priv(indio_dev);
+	struct regmap *map = data->regmap;
 	int ret;
 
-	ret = ads1015_set_conv_mode(data, ADS1015_CONTINUOUS);
+	ret = regmap_update_bits(map, ADS1015_CFG_REG, ADS1015_CFG_MOD_MASK, val);
 	if (!ret)
 		data->conv_invalid = true;
 
-- 
2.39.5

