Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEE03DD518
	for <linux-iio@vger.kernel.org>; Mon, 30 Mar 2026 17:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774892478; cv=none; b=EYT77M+o6GyrXvGRPCsPixTDvKTMkzp0zsi6OxUR3P3ad5iAhhR+R3q8AepTEWCyDZBtatXlJR+wGmZXyhwNBm6QIZ0VLPzypJ36i4c/xFPib/ZT5WJ8xWrnxyim6/wKYcQBNCZIG/JX/x7/WEsVq5r7XsUkC8no/hv5RKws9o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774892478; c=relaxed/simple;
	bh=9qTZJN4MZ8hzBIdowCVJK06Yf+gkp3opcTlMx+EtYus=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L6kyy2Rlg7EUsVCPUDolVIx1XDEdSzJnLMKp1ODc2mZiZsjkN88+y2AnX6DGDjjxfdI74YJOvGF8w6PAMEGzt5G/XrDMVgm86evcaM6hXtNGQM9lF0PWrtGVoTHKPA1N8gYvzx0qW5YTQJFrrdk0EsrEBFGRo8rQKyrb4T1R3Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VpfCfB/j; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VpfCfB/j"
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-82748257f5fso3126370b3a.1
        for <linux-iio@vger.kernel.org>; Mon, 30 Mar 2026 10:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774892476; x=1775497276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r0JUsGvLhS5kbPI7JpUTp+ry0YaI45Aayw2r9a2X+zM=;
        b=VpfCfB/jQg3s+QIfU8Lo4zGifaLn8Ny5iZqwDegmnozosblbtIlaoU+ZZ4+/PQiUG9
         hvF94HrufbESPZnP3V0sqz8XpjBf5Q50B9QdO3adFbTyGglbLIJnaj+jA6aqqGhmfeYb
         KJ1KNGw4mvT6E2zuOp2BIeox4bRNeHoGxse2WbKQb36/OAlo78PvJk/9RXFhStRqJlGh
         79E81imk9tvHqJk0fbdt54YJaAb5etRO04jmvY7jSzOKUtbJwJE8C4B2ksQSI5xaEv+d
         dflL8aMZn88cXONSxiSzo2+iMIAqqPc+/YddP1BmSld/vqsnVmbRLlBQwXuRcUOLEglK
         DBaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774892476; x=1775497276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r0JUsGvLhS5kbPI7JpUTp+ry0YaI45Aayw2r9a2X+zM=;
        b=lS2WeHMHVDrTDXWLQX+nwJdyD9qnq4bPuL7xKz0ty7IziacbHnAuvaMT30nN2T+7Uj
         WQnKrvwb36OidadkamHs2qOoA5jXXjCE5pbr0QUtMg2g79omFSO/L8vPTtmzqYvUaPlZ
         fKhMSklPXIgRjJ5fjtz5LmmY6clSVcq8+NhpA+r/z3PjzU4wC9mdMyViTFTHXj5xoxUE
         cckNF2iAq7TnhW6aDROMS0oQO3dVR/RCC7DIFrlvRzn1hv/IFlNUMMkfmp6mLPzQsqWw
         V78CuPruzjq4M54aDN0c6oy/cuasizPZdWNv8YUqVWtRPemQwyNheSheTBTHrai0/aUJ
         Nayg==
X-Forwarded-Encrypted: i=1; AJvYcCV8LmQSdpJDI5HtvWOM0lSxysSs4Xt2P0tEOT+ziTOFuIj5zU3iSumNMLkkCgSAOu+DCDnJrz8CcgY=@vger.kernel.org
X-Gm-Message-State: AOJu0YysVK28dBu/UoFc3tQqBbzNyrYtDeGZC2v18upwPgJNhmDy3H4V
	Yx+5E0Xeundh2IyBJvuxglMt74WXai+ARPiVKHV0AfF2ObmEI1lAKuJ5
X-Gm-Gg: ATEYQzy0lHRONfxBA+UzgARn4+1lxBMSigqt69TWflyw6iE+0/L25c7SzFSA3zlFj3B
	bi4OFkWIGD04Di+GaavVFM5kfnkQce8M3r9ZNYA5so1o2oNpw5CKco2FKDqaCUC4g1AEkoa0R+1
	QYB4zvBNlOYTANDvCeq7BopEjthp17R64loYEMMIqzUOt5g0Tboez5IzLvnoBvzE4drvDV5M5b3
	Qt8c008MtzHVWcoh/cOTGXtkgtL+8hYU/xR5l3PxI4jkFQGwsdc0fRRb5KpqRhyfqdwylZNekx8
	aG9Hb5k0vinwJTMEF9j59gD6tm39uR4wbLNb4w5B6pCT9uoX3g/De5Od+Bd4SfX5bkX7xqV2aKq
	3xqq26UQ+uE56f+hjxoJrYRk4DbqA0n8sgr6ex20dlqLYJUxdBYVIupvoD05Wt2Dt264sLtFaK7
	LebIVJXT4fNi4oAtzlLhafufwr6DZxP4eRZDp/H6tWhmvrfaAHOR0=
X-Received: by 2002:aa7:8486:0:b0:82c:9c90:6ea0 with SMTP id d2e1a72fcca58-82cd61d48e3mr265854b3a.3.1774892476427;
        Mon, 30 Mar 2026 10:41:16 -0700 (PDT)
Received: from Mahmudul.. ([2400:c600:545e:6508:42eb:3d78:89be:591b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca860b125sm7844052b3a.50.2026.03.30.10.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 10:41:16 -0700 (PDT)
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
Subject: [PATCH v2 3/4] staging: iio: adc: ad7816: replace sprintf() with sysfs_emit()
Date: Mon, 30 Mar 2026 23:40:23 +0600
Message-Id: <20260330174024.20712-4-mdmahmudulhasan1511@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260330174024.20712-1-mdmahmudulhasan1511@gmail.com>
References: <20260330174024.20712-1-mdmahmudulhasan1511@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

