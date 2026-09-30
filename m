Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFAE51CF64
	for <linux-iio@vger.kernel.org>; Wed, 30 Sep 2026 17:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790788379; cv=none; b=exS7rogzdnjQ1+sdSO10wFCnoTIJo9JtSk1Od9J8uY9Rr/CdVbCII97Dm1I6vi8xUcdYsRfr6HPgzoW2AibQugXQvgNjmnXfGmdJnWv2V/d+SsNQqQqoAwbVuLU7+P+uMXf5loNkFrICVzwkx08FaGqIzY2Ml8S7K0uXEJkroeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790788379; c=relaxed/simple;
	bh=0WyjQ+EZUsUcqfNeOlxL3H7OfrO2zGvmDdfhd9wFSfM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DoGQ8pih/XUFAzp49+PlN0bS9gj//RfgtkyTXgTXccjGU7wvhuRdtX0OHaR89sUxhhv7X192HpaxREfD9qSd55rB5wWKaInGbVpKkRFZA8eYTmx/u4x/I5u2kHZVcPmyqOo3c7iqwzSP0QYP/eaKz51h8bvE5T5UwgIwg6C2LGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aWQlyvkX; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aWQlyvkX"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc4cdc0d663so2414130a12.3
        for <linux-iio@vger.kernel.org>; Wed, 30 Sep 2026 10:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790788377; x=1791393177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P3gkqcJf9G0KUXQZxMjMRnR74+ZlcVG13gmjvfAtmwI=;
        b=aWQlyvkXio/0UABDqT7yD9aV1mrXxyE8iTppvZq/GTHY6eA7ArTjXKGQ4QPgTSaqhP
         zB8bCUk21I0eheukr7SMnWydt1xUvcNHJkibLzU1723iiFEyZaGC7x11GJTOQBKv9k8B
         /JB4t9D8qdjqJ0/7u23RuP0JkyFaATroa0/9/GIT5I/RMM/4mvGkRB7EErXauF6ELG7j
         hbRmruHOx6Eg11ureO5wVoJwP2AZF99NqqAcX5gM2a61V1rxsiiBXCG90bQlKJFMi2O1
         vOm1reyhSTWQb8EpnLa/Hn5nDVlWKqlILssp4ahDT9fOegkX0J1pm4VWlN8NvphcAuVZ
         PV9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790788377; x=1791393177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=P3gkqcJf9G0KUXQZxMjMRnR74+ZlcVG13gmjvfAtmwI=;
        b=SHcJ7ZIXQukJaAVzRec/Go3MCMK/yT40SFOoZnYkwCRXyrtBB34c5GpRUkE//hOmXA
         LZtg7mPZw8lI8rEw9hWrc9ThlEsqkRyncykBmJxZENbgLekjHOJyoiyyZOwT96TuhdxE
         5i7tvI5J9nD4Ad2vxsgX6BQvGFThivpGgpAIX+xegbKef5F2HdyD3BSZEAAGMOALfaex
         h7pxpVumIM7D/w6ywza3b4caqY8gEWC6QcY3E98t0ZX8rxUmjdFHGoDSGa9YE1wvFSjb
         ZU7wUUmM7SwroeYtT50KxBnbpgRl48W84KJY0Ccz9xm+IKptZdyv3YTG1qut7Duzh2nP
         CZlw==
X-Forwarded-Encrypted: i=1; AKwUvBwMI49GoGbcfQXgQdYMJGtiTUmqCGu1k6vw3nOM5GHmHULgZZtkCJQk0XLMAi/t68zrsh1E83wxDeQ=@vger.kernel.org
X-Gm-Message-State: AFuF++kVCTxwCdwLsKRXpLUsvl2NysC4I2Mc+3GrLRwtsIeJh8B9VtcV
	Zb2Phfdk3Crl365WFQvjm1FER6kbwGnOJ4gz4Hh8W66KLQ1Nit3vfzBI
X-Gm-Gg: AYBFou1yR3Q79rvJ7o+PVF57fWIrfzLPF3EkGioC/fV4i6IUJMoTXrxB6I2SqEYWQ/1
	o5shdLPtCwo2wQ/WF/4iXUDzhH6CZ8LrkllPkoGfSvvTDhV4zU+BsBIONHXL6u2jFEUcQXgMUNH
	nHDIx6QRyHuDgCAtfGM3Qp4+S6dmKaPpIF4sdInfcEHKhUT2yXhcsK1MGS89DLMiCPFt0t+yisj
	f46wF4amA8Y2KAl/bjCN8fFD1jVi1XYOrraTGcDvvWbRFdQAjgsFqCXJvAB3Ov10F+v17UYqzAF
	XpmwBh3VmncMQz9EIrz5dgZuzdHKlAHJefIxpZJ6Hx/D2+t186lQp+3VxO+2J2a+ZFxeEmeM9pH
	PAxnObsn2fPFTdqeUXZ3Pu9Y1ufNzzYN55ar+uVdYaz9q0r1AvOn+1CvgU7cEr2F1KigLESrLvu
	KrpyKKLjhDwyUcAGesOr22xiZ8Owh+57H6KxSgjkGtsWkH1EKo8GK3DBycoBi11RT7aebNZ6plx
	Vpa5jgu3sxLi/Zyux67GwHtLGBxamkg7L/lQVPik7S3YyReYw==
X-Received: by 2002:a05:6a21:492:b0:3de:6046:1e39 with SMTP id adf61e73a8af0-3de9e88de66mr2147141637.59.1790788377417;
        Wed, 30 Sep 2026 10:12:57 -0700 (PDT)
Received: from debian.ari ([152.58.182.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-887bc2bd404sm636872b3a.46.2026.09.30.10.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 10:12:57 -0700 (PDT)
From: Archit Anant <architanant5@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	andy@kernel.org,
	nuno.sa@analog.com,
	u.kleine-koenig@baylibre.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Archit Anant <architanant5@gmail.com>
Subject: [PATCH v5 09/10] iio: adc: ti-ads1015: inline ads1015_set_conv_mode()
Date: Wed, 30 Sep 2026 22:42:03 +0530
Message-Id: <20260930171204.12863-10-architanant5@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260930171204.12863-1-architanant5@gmail.com>
References: <20260930171204.12863-1-architanant5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ads1015_set_conv_mode() helper function is a single-line wrapper
around regmap_update_bits().

Since the function is simple and only called during initialization and
power management state transitions, the wrapper is unnecessary. Remove
it and inline the regmap_update_bits() logic directly at the call sites
to improve code readability and traceabilty.

Where applicable, introduce a local 'map' pointer to keep the
inlined function calls concise.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Archit Anant <architanant5@gmail.com>
---
 drivers/iio/adc/ti-ads1015.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index 9312822218df..2e8f89d16586 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -744,6 +744,7 @@ static int ads1015_enable_event_config(struct ads1015_data *data,
 static int ads1015_disable_event_config(struct ads1015_data *data,
 	const struct iio_chan_spec *chan, int comp_mode)
 {
+	struct regmap *map = data->regmap;
 	int ret;
 
 	if (!ads1015_event_channel_enabled(data))
@@ -756,7 +757,7 @@ static int ads1015_disable_event_config(struct ads1015_data *data,
 			comp_mode == ADS1015_CFG_COMP_MODE_WINDOW)
 		return 0;
 
-	ret = regmap_update_bits(data->regmap, ADS1015_CFG_REG,
+	ret = regmap_update_bits(map, ADS1015_CFG_REG,
 				ADS1015_CFG_COMP_QUE_MASK,
 				ADS1015_CFG_COMP_DISABLE <<
 					ADS1015_CFG_COMP_QUE_SHIFT);
@@ -921,19 +922,16 @@ static void ads1015_get_channels_config(struct i2c_client *client)
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
 	struct ads1015_data *data = p;
+	struct regmap *map = data->regmap;
 	int ret;
 
-	ret = ads1015_set_conv_mode(data, ADS1015_SINGLESHOT);
+	ret = regmap_update_bits(map, ADS1015_CFG_REG,
+				 ADS1015_CFG_MOD_MASK,
+				 ADS1015_SINGLESHOT << ADS1015_CFG_MOD_SHIFT);
+
 	if (ret)
 		dev_warn(regmap_get_device(data->regmap),
 			 "Failed to power down (%pe)\n", ERR_PTR(ret));
@@ -1036,7 +1034,9 @@ static int ads1015_probe(struct i2c_client *client)
 			return ret;
 	}
 
-	ret = ads1015_set_conv_mode(data, ADS1015_CONTINUOUS);
+	ret = regmap_update_bits(data->regmap, ADS1015_CFG_REG,
+				 ADS1015_CFG_MOD_MASK,
+				 ADS1015_CONTINUOUS << ADS1015_CFG_MOD_SHIFT);
 	if (ret)
 		return ret;
 
@@ -1059,17 +1059,23 @@ static int ads1015_runtime_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
 	struct ads1015_data *data = iio_priv(indio_dev);
+	struct regmap *map = data->regmap;
 
-	return ads1015_set_conv_mode(data, ADS1015_SINGLESHOT);
+	return regmap_update_bits(map, ADS1015_CFG_REG,
+				  ADS1015_CFG_MOD_MASK,
+				  ADS1015_SINGLESHOT << ADS1015_CFG_MOD_SHIFT);
 }
 
 static int ads1015_runtime_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
 	struct ads1015_data *data = iio_priv(indio_dev);
+	struct regmap *map = data->regmap;
 	int ret;
 
-	ret = ads1015_set_conv_mode(data, ADS1015_CONTINUOUS);
+	ret = regmap_update_bits(map, ADS1015_CFG_REG,
+				 ADS1015_CFG_MOD_MASK,
+				 ADS1015_CONTINUOUS << ADS1015_CFG_MOD_SHIFT);
 	if (!ret)
 		data->conv_invalid = true;
 
-- 
2.39.5

