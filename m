Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9533D5C3A
	for <linux-iio@vger.kernel.org>; Fri, 12 Jun 2026 22:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781304431; cv=none; b=KpBsGxHUrJyqDGw25k144/EmVVY13GZKPnxrfoIed/3nKH8zh1D2Sf2IJWFHw8VLLORCiSWFZ+diH/Ytz/xAI5+/Xnwc628OABYqDuam51RhXmqTntrWKXvTIXVh3oky6Lb/b3C5HJfenelmxi9SCO+vE+ZUPGe4DM5GUJi7av0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781304431; c=relaxed/simple;
	bh=EsJT2lMotT/uWF+cKzuNO4c+y11rGpYGsfhS1ED7rJ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TSyxi0H5wa+xutfRe0MyyqQ6ay8dccPONdbOMiDxSmjS+AEU3Dy2N0/b/1WPW2c1SGO7uB0mtMlB5J/+UDZrns6MJd2Y1JfXHKOHa8j7E3P4hc9L9aTLdJMtyxW8DbKDy8mqrszkONE7GHwCQOOconiApexZ1gF+LPYdiIm6H9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oclrRre0; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oclrRre0"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-59d6e44e5c8so1026117e0c.2
        for <linux-iio@vger.kernel.org>; Fri, 12 Jun 2026 15:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781304428; x=1781909228; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Js/ra5LqzPxNouNNjbCHmWUBqDkuSo6GLF0IH/adVcE=;
        b=oclrRre0kQE7emjth8u8hVeIfsS6xqiPI/WFPlRhkVqagAEP1s813V6mCgM/vyY+aU
         JvagNG06+QuAo7JMZ7l4ARt/lGplyNhS4I9j1sB4jXW7dqwneTPgUOjq1KTUSZoHGxFc
         lgFjEEnfopkDQP56mC/WROmXhHWLnZ4kkmXX0NfQMswtL53XeQKwvOkiaUdv84JCt5IF
         xQZl0vFlOsDbyk2yFGcudsTe8+PAl+7io694nV6SEFvd/4wAovxeoyabWVWkTV3LVJpi
         rUlDUKADS6FoJuiQmzPF10aUQEtwcokZNcSjnsgxOwdW9A8rjn/KwsUdy5RaKzQXNFma
         qT3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781304428; x=1781909228;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Js/ra5LqzPxNouNNjbCHmWUBqDkuSo6GLF0IH/adVcE=;
        b=bev+TUciL++1G1aYZRCP2VOoSLYZc66kqHYPBhR7kqb4AGSVo28SFqR1cz3EUSgCc0
         RM9mXol7QKgVnvKXOgz+VJv9ITGnSsS9stVPIEcufYIe/UVGle/5ZMKK9RzK7stcs2Iu
         xiiU4ihyfywemlYB2fMN24d6s1BUaQgVctjnebnlmoLSD6ICe0+K47yXdsXq5yEnPaxW
         a9kiUeYaM6GnobJMjvu7c1k1RQdS0Eu9a3S/ohctP6gaUDBcILksMR3laiW6teAr9fcE
         d+t615wxQaUv5hSwpdBcCFLneIeQM4sqLVFWwyrO8Mb7VuAFmmHlA3j9K7r0X0Oe39Kv
         6bCQ==
X-Forwarded-Encrypted: i=1; AFNElJ+IU634ZoCHtdvhRRjAjmBTV6eC8aO7zkfE+ekoG+hJbLT+0moxoPnWvLbDl6VG6zCcYfidsXEKodU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjrdiELnFSSn2zBN7YwJr7Wt4/qiQSfWOAhc43vkvW31zz2Tk7
	CfQ4dmPQoErHWA69ggKDWKtFkeTfNJfhcKhReXriUHjjUUbEJkASREuJ
X-Gm-Gg: Acq92OF9gW87RJQMgL02YiS6g0UZutP+hVhj+w+/V6/pyb0QZxQ2abFfJ2iEmMXofR9
	pnZBzXmesoDPoAqpMCjFgTuh9Jg8MxNg0LH/AFRy3dhFbcs4jCGuvP9fqtKc03SeZjhHNcTQFdQ
	ez6Ij4kstpOvFRg4FxPx1UwAhaFyfyzHulDTPTH9I5VEpOMJakv6bdm+9egtSE8jGbSTRFk3mwy
	y5IiM8femF3b0AEM0lxMHhE1gZfcMvxf4VIBibZ2ionNiWmcr/q3eSr1rMY34GDHSasDqw9CgPU
	9ip0eSNwGTlwUBM0C039Psnt7Jb0DkSB9J6oa1yuerY/qBzdumHGHh5oByEXXzZWzNR6UOlRwTK
	GPmcR0kQ2h4KAYuV0aoiGC5Z9AUeNiULse8oQlrrCWtzB2LxD3ixbaf7OnBQ0UyIzDZM1kt1Dy9
	O9I4X30z7scF15oto4b6twmR/CUC8QEm7w
X-Received: by 2002:a05:6122:1da2:b0:56b:9b7b:83e7 with SMTP id 71dfb90a1353d-5bb6c02821bmr3390332e0c.7.1781304428144;
        Fri, 12 Jun 2026 15:47:08 -0700 (PDT)
Received: from [192.168.100.6] ([2800:bf0:82:11a2:7ac4:1f2:947b:2b6])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5bb691fd8adsm4244553e0c.13.2026.06.12.15.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 15:47:07 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Date: Fri, 12 Jun 2026 17:46:22 -0500
Subject: [PATCH 4/5] iio: adc: ti-ads1262: Add calibration support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-ads126x-v1-4-894c788d03ed@gmail.com>
References: <20260612-ads126x-v1-0-894c788d03ed@gmail.com>
In-Reply-To: <20260612-ads126x-v1-0-894c788d03ed@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, Kurt Borja <kuurtb@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4008; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=EsJT2lMotT/uWF+cKzuNO4c+y11rGpYGsfhS1ED7rJ4=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDFk6PUkHXwQHBh/UZlLZzLP2Zen616qlUzR1la7On31XM
 qzHjVWro5SFQYyLQVZMkaU9YdG3R1F5b/0OhN6HmcPKBDKEgYtTACYybQEjw2lGLef42wft9aRl
 l79Mvf9rx5Rss9I953/Vzyl39OrYzMjwh3NV+RahVSuPWnw1+/Ii9VPJmfp8Pl+B3zeDDBefSlR
 v5AcA
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Add channel calibration support.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/iio/adc/ti-ads1262.c | 70 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 69 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-ads1262.c b/drivers/iio/adc/ti-ads1262.c
index 6d5f22836ad8..b33505e7fdc7 100644
--- a/drivers/iio/adc/ti-ads1262.c
+++ b/drivers/iio/adc/ti-ads1262.c
@@ -217,6 +217,10 @@
 #define ADS1262_RMUX_AVDD_AVSS			4
 #define ADS1262_RMUX_COUNT			5
 
+/* The calibration word is signed 24 bits value */
+#define ADS1262_CALIB_WORD_MAX		((int)(GENMASK(22, 0)))
+#define ADS1262_CALIB_WORD_MIN		(-ADS1262_CALIB_WORD_MAX - 1)
+
 struct ads1262_channel {
 	/* MODE0 */
 	u8 conv_delay:4;
@@ -453,6 +457,32 @@ static int ads1262_dev_start_one(struct ads1262 *st, u8 runmode)
 	return 0;
 }
 
+static int ads1262_read_calib(struct ads1262 *st, unsigned int reg, u32 *val)
+{
+	__le32 lval;
+	int ret;
+
+	/*
+	 * The calibration word is a signed 24 bit LSB-first value.
+	 */
+	ret = regmap_bulk_read(st->regmap, reg, &lval, 3);
+	if (ret)
+		return ret;
+	*val = sign_extend32(le32_to_cpu(lval), 23);
+
+	return 0;
+}
+
+static int ads1262_write_calib(struct ads1262 *st, unsigned int reg, u32 val)
+{
+	__le32 lval = cpu_to_le32(val);
+
+	/*
+	 * The calibration word is a signed 24 bit LSB-first value.
+	 */
+	return regmap_bulk_write(st->regmap, reg, &lval, 3);
+}
+
 static void ads1262_wait_for_conversion(struct ads1262 *st)
 {
 	reinit_completion(&st->drdy);
@@ -673,6 +703,18 @@ static int ads1262_read_raw(struct iio_dev *indio_dev,
 		*val2 = ads1262_conv_delay_avail[mode][1];
 		return IIO_VAL_INT_PLUS_NANO;
 
+	case IIO_CHAN_INFO_CALIBSCALE:
+		ret = ads1262_read_calib(st, ADS1262_FSCAL0_REG, val);
+		if (ret)
+			return ret;
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_CALIBBIAS:
+		ret = ads1262_read_calib(st, ADS1262_OFCAL0_REG, val);
+		if (ret)
+			return ret;
+		return IIO_VAL_INT;
+
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -682,6 +724,9 @@ static int ads1262_read_avail(struct iio_dev *indio_dev,
 			      struct iio_chan_spec const *chan, const int **vals,
 			      int *type, int *length, long mask)
 {
+	static int calib_range[3] = { ADS1262_CALIB_WORD_MIN, 1,
+				      ADS1262_CALIB_WORD_MAX };
+
 	switch (mask) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		*type = IIO_VAL_INT_PLUS_MICRO;
@@ -701,6 +746,13 @@ static int ads1262_read_avail(struct iio_dev *indio_dev,
 		*length = ARRAY_SIZE(ads1262_conv_delay_avail) * 2;
 		return IIO_AVAIL_LIST;
 
+	case IIO_CHAN_INFO_CALIBSCALE:
+	case IIO_CHAN_INFO_CALIBBIAS:
+		*type = IIO_VAL_INT;
+		*vals = calib_range;
+		*length = ARRAY_SIZE(calib_range);
+		return IIO_AVAIL_RANGE;
+
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -761,6 +813,18 @@ static int ads1262_write_raw(struct iio_dev *indio_dev,
 
 		break;
 
+	case IIO_CHAN_INFO_CALIBSCALE:
+		if (val > ADS1262_CALIB_WORD_MAX || val < ADS1262_CALIB_WORD_MIN)
+			return -EINVAL;
+
+		return ads1262_write_calib(st, ADS1262_FSCAL0_REG, val);
+
+	case IIO_CHAN_INFO_CALIBBIAS:
+		if (val > ADS1262_CALIB_WORD_MAX || val < ADS1262_CALIB_WORD_MIN)
+			return -EINVAL;
+
+		return ads1262_write_calib(st, ADS1262_OFCAL0_REG, val);
+
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -867,9 +931,13 @@ static const struct iio_chan_spec ads1262_iio_voltage_template = {
 			      BIT(IIO_CHAN_INFO_HARDWAREGAIN) |
 			      BIT(IIO_CHAN_INFO_SAMP_FREQ) |
 			      BIT(IIO_CHAN_INFO_CONVDELAY),
+	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_CALIBSCALE) |
+				   BIT(IIO_CHAN_INFO_CALIBBIAS),
 	.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_HARDWAREGAIN) |
 					     BIT(IIO_CHAN_INFO_SAMP_FREQ) |
-					     BIT(IIO_CHAN_INFO_CONVDELAY),
+					     BIT(IIO_CHAN_INFO_CONVDELAY) |
+					     BIT(IIO_CHAN_INFO_CALIBSCALE) |
+					     BIT(IIO_CHAN_INFO_CALIBBIAS),
 	.ext_info = ads1262_ext_info,
 };
 

-- 
2.54.0

