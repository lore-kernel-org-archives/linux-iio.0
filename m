Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5C92FD7D3
	for <linux-iio@vger.kernel.org>; Mon, 30 Mar 2026 18:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774894678; cv=none; b=I5T1Ej2f8hgxvXTVfAYsIKcPRjFlVW+Ibn0wbMU+NVJ8fXbK8VeGG5b0ihAqVgsiyZwBdR8h+EKTJhlNapQjTXve5eBbTjgjO0xmFLFpihJZOXCgBAyo0HOoA8C0M9R5z+eQVMwTUvuTmZ6drj+KB5MYGtijhEazOiiKN8BK83k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774894678; c=relaxed/simple;
	bh=Br5vGAXYgtBTtZqV3PmJuhT96uRJmxgj8Z+FdJj7Yxs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j6EPGYq4zsva6+RiDoH/cTucgOw9zWlhGeF7mVCAEcjJ9nR9WBDjficMaxYnsO3HbViu9CvPePSZ24sUF4PHSPULDEEPh3iQxSHoLFkaoTJqrdrLcpiPiuaZcGRn+8XX+d2fSJJSqon3qU4e57IYFrfPgIBl3b44JCARtnPoMME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UXyVgLdv; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UXyVgLdv"
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-82a62714fe6so1917526b3a.0
        for <linux-iio@vger.kernel.org>; Mon, 30 Mar 2026 11:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774894677; x=1775499477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AEev0NrgAro5b++Ke8wuTx9Yh3OdT4GarY6/WNk8AFQ=;
        b=UXyVgLdvJcpR39RSvtP96JNd83RUi6khDbasqa71wEFNAC2nfFuC0QFvkZ6AslVj5t
         PQAdng7mIk87UZNw2K77kIB+y4MwF5yibO4LBaXjTkHUmNx7cy+1Tiqk451lgRAshLqU
         pT5tDcA+eqoUdPo1wahPsXYPw+xv14tT4U2KDkJm8CE6ByeuiRNfUPNIl2wECYoN7RLX
         z8C9KN2eHp+VAReeart51e3T8iqeqhEnCyZYP/Fd4EM1kVGTzrILNvI+vjujBYsYsymG
         zgGSlHqVxgxIm5dZ9IJ5FkmVtSTy9Io442oGSvh3DdTR/6LxTGRxJXJghsX6DLHkoZ5k
         NNMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774894677; x=1775499477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AEev0NrgAro5b++Ke8wuTx9Yh3OdT4GarY6/WNk8AFQ=;
        b=gqUPlBHgx4kQVytJGwL0M23fFTgE8oPiY0o7nKFi4Tlbi5XNC9EuzcgMjXVvwUgmmO
         MsBaNDFUmqU5vlKlU0ZS/Dh2fzQoGfL6w3kQ1aIe6v81f7cbF/nnh7fTpvIu4pwmrNRa
         Je566dEUCNEqvWRo60mke7TfBNW4skR1ybZ5nTrQNNZfxPsRtXxWko94Kqw6vYRy0IkT
         AqgpwHmo+3YBesgLLhG4NoOb7dIo4JcwfoL8AtOcDCT5YB54I9ozP+W5YhkUGqZAmZRC
         urLaqE80cHJ+SgseucSGFxmnp+IulYiEIy5XDApdjFqSue2Q7aZZUwDmAy7woKFpQC8v
         1RGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgQxBHWktYtCsWPz8p9weXhEwag79Esj2E+gOd2uoo8AhUqIgqBfk68LLnhv3sIp65cBtlrdmJ7nU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKz3m1iAY9DNX0Mjjd2eB6DK65gftniTdtwXv2JHmYY9AUdbQ+
	8UeXEmQqNliJba080YPjqlaOoAKuBNIR1PdR770zrN1JZHBrlupcb6agagSq2XK56dw=
X-Gm-Gg: ATEYQzyIqctnNZn31T3LbfRC4Q361g36c7PKphuCwQhOXl0RHjDsRTmu9Db0+T7gkp0
	30zAue5ix12Vv+MuD/3M91/VbnhVZyRxoGWdjTJiQnN4DTMY0fWoQvVUiBrNWwRzZ0oWsHl9UMl
	kh2uMgnj5j+mRSYTx+Lotby7Mi5UTXeSWMLSacg8wftGwtUT4VRXDp1+Zpkcjl5+oy1boaoLxJ7
	7vKCVq0HTpDp7Fb4PbQz1p25pvYaVMBs6kahs22uwfZ5x3iX2KNI/RzRRkW45qTrcyGlkSMR+uG
	F9DOz65zKWpJVQnxbQmVVzEuGmQUv/E+VU96Zeo7TnZUY+B4tSTHpOXIdNoVMi0ruKC/b/n1Z+n
	9OzNwuQTldXHQKBllosLyJC7hOLw3pYRnqx5ppOL/meo3gPdJxzG1iIwUrILEMgz4+FEqDv4nFC
	1LlU7SUkfVgBHEx2ITBRoohR9RsX46IV7zM5IfelJ0
X-Received: by 2002:a05:6a00:2187:b0:829:f777:dad4 with SMTP id d2e1a72fcca58-82cd665a37emr432819b3a.29.1774894676677;
        Mon, 30 Mar 2026 11:17:56 -0700 (PDT)
Received: from Mahmudul.. ([2400:c600:545e:6508:42eb:3d78:89be:591b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca85d4d90sm10099966b3a.36.2026.03.30.11.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 11:17:56 -0700 (PDT)
From: "Md. Mahmudul Hasan Mabud" <mdmahmudulhasan1511@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Md. Mahmudul Hasan Mabud" <mdmahmudulhasan1511@gmail.com>
Subject: [PATCH v3 3/4] staging: iio: adc: ad7816: replace sprintf() with sysfs_emit()
Date: Tue, 31 Mar 2026 00:17:09 +0600
Message-Id: <20260330181710.23258-4-mdmahmudulhasan1511@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260330181710.23258-1-mdmahmudulhasan1511@gmail.com>
References: <20260330181710.23258-1-mdmahmudulhasan1511@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace sprintf() with sysfs_emit() in all show attributes.
sysfs_emit() is the preferred way to return values in sysfs
callbacks as it is safer and handles page boundary checks
automatically.

Signed-off-by: Md. Mahmudul Hasan Mabud <mdmahmudulhasan1511@gmail.com>
---
 drivers/staging/iio/adc/ad7816.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index f9a0a5a69..f2486cb29 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -128,9 +128,7 @@ static ssize_t ad7816_show_mode(struct device *dev,
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ad7816_chip_info *chip = iio_priv(indio_dev);
 
-	if (chip->mode)
-		return sprintf(buf, "power-save\n");
-	return sprintf(buf, "full\n");
+	return sysfs_emit(buf, "%s\n", ad7816_modes[chip->mode]);
 }
 
 static ssize_t ad7816_store_mode(struct device *dev,
@@ -161,7 +159,7 @@ static ssize_t ad7816_show_available_modes(struct device *dev,
 					   struct device_attribute *attr,
 					   char *buf)
 {
-	return sprintf(buf, "full\npower-save\n");
+	return sysfs_emit(buf, "full\npower-save\n");
 }
 
 static IIO_DEVICE_ATTR(available_modes, 0444, ad7816_show_available_modes,
@@ -174,7 +172,7 @@ static ssize_t ad7816_show_channel(struct device *dev,
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ad7816_chip_info *chip = iio_priv(indio_dev);
 
-	return sprintf(buf, "%d\n", chip->channel_id);
+	return sysfs_emit(buf, "%d\n", chip->channel_id);
 }
 
 static ssize_t ad7816_store_channel(struct device *dev,
@@ -236,9 +234,9 @@ static ssize_t ad7816_show_value(struct device *dev,
 		data &= AD7816_TEMP_FLOAT_MASK;
 		if (value < 0)
 			data = BIT(AD7816_TEMP_FLOAT_OFFSET) - data;
-		return sprintf(buf, "%d.%.2d\n", value, data * 25);
+		return sysfs_emit(buf, "%d.%.2d\n", value, data * 25);
 	}
-	return sprintf(buf, "%u\n", data);
+	return sysfs_emit(buf, "%u\n", data);
 }
 
 static IIO_DEVICE_ATTR(value, 0444, ad7816_show_value, NULL, 0);
@@ -286,9 +284,9 @@ static ssize_t ad7816_show_oti(struct device *dev,
 		value = AD7816_BOUND_VALUE_MIN +
 			(chip->oti_data[chip->channel_id] -
 			AD7816_BOUND_VALUE_BASE);
-		return sprintf(buf, "%d\n", value);
+		return sysfs_emit(buf, "%d\n", value);
 	}
-	return sprintf(buf, "%u\n", chip->oti_data[chip->channel_id]);
+	return sysfs_emit(buf, "%u\n", chip->oti_data[chip->channel_id]);
 }
 
 static inline ssize_t ad7816_set_oti(struct device *dev,
-- 
2.34.1

