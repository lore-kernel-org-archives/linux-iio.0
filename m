Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6128936DA1A
	for <linux-iio@vger.kernel.org>; Fri, 20 Mar 2026 22:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774045472; cv=none; b=g5v55tXPemmh9iNmfI2vzRXIE5hhZpObSNJq27Uet7989+W4SJkIniMT5EvLO9MwmkLOl1kv1GyKpFL1AzEJ8QibqbUA2bEoIRyyzk7Q/dRQSc4WeynD3EjfTx71XAm9B/Qhjfa/kI++omQak8+9TEPoRFVed/yJ7ssgaiBVv3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774045472; c=relaxed/simple;
	bh=A5fdWSepkSgmkvMJpmG5ZlnAONFldDTK+KtfLvuP/z0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dLds/HexlthEKk6bJwF9TCuZhKORpE3s0YStln1IbIk26Cm8QqL5VGXJRvFqnVeHKasDF/c7N7oCSvkzq6KjTifZ3+LOYxGCW5/NUXUWVnt6J1a5KcrQAsu9PCI7QgTEAk39/d3I+bbmlDE7iGBqJXuJYy478pInHWYuE8cewCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EbHbFKK6; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EbHbFKK6"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48702d51cd0so5976365e9.2
        for <linux-iio@vger.kernel.org>; Fri, 20 Mar 2026 15:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774045470; x=1774650270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QLzLy2hDM9Kbvx/sb4ZAms8XilnjagJUDNjtCCjNGlk=;
        b=EbHbFKK6hs3F1bZSbocdY4HT2p2x4cGtxUqaXaaSfxzBiOO3iTRF4EWLz07lbz1I5d
         iXf26Rgru28cYN6dNMjYsNsZRHpn2Ed8zpIFzTmJpvgOeGCTB1WiaF3T6HrX7Hr7gLty
         wUIgOnrLNtjrQFaZQ+TKuLb0WneztJRP4QaCmFwlFtvl7Ojl2f7GAmvPp3qw2bpvkpnT
         UpXhgOaiYrmibmMTL00Rd+hVodrwFwYVsdU1EI8esyrY4hGS23AMFcRbWMSJXEcrCRDA
         QVNvSAEOCjtx5f9TQkH1T+23KqH9aekg70Pt/srx5jKYrVXz/R4DjQXxp/v+TPxJepy2
         utWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774045470; x=1774650270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QLzLy2hDM9Kbvx/sb4ZAms8XilnjagJUDNjtCCjNGlk=;
        b=fPKCSu0ky//jxVmAodheFCUpfo+h1p5AKp2PcGA8N97cvzacm9F2xu7L022RXt7p0N
         RQEWvE06dOmENy2B6dSuw6AC4aN+HaMu8xeiSnMmHOc8VpR47neWwI3vjUyuvn3eg3dt
         fj56s7QqEDIDH552zItinKjwKWp1QDgkUahOAWslwsGcXHVgXk7aSY8PSUNd5RUs1EoK
         5hS9CmKAqGC+3qJd+bBpgP0rOXmGO0qT+lhald8m6hDV5NMFTEdzMJ6asYS+P7IJVbQK
         nBaeLuvkNvP8CzeplPBjH9jL8eKV65OG6Fgo4pxSvZL9qwyryNXYQzokweMCPsh9+c1I
         Zb0g==
X-Forwarded-Encrypted: i=1; AJvYcCWiDFiIigGv9iJXNT49QjioNKmNhCabUJz0ccgLwMRGePMLswk1NXpb8gcV+yiLhl6Cxny3plstB6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeOGN0FUnsKiJwfiZmMOYxdyXvNvKHIrFT5kAiV5zCKxMmJjIN
	M5Hvz0zNJWpzoEXM2ZDNR/GvPOPhLtuIpWffGJafed2/JGH7oexrTDgB
X-Gm-Gg: ATEYQzwZ0Xdka3N2wF6hrcq8LY4WcjPMilPMDwf0aNKHy+IKMj1AYCGp3V11c/7FB97
	xowpDeJxDdSj6tiQMeGCdTyOYSi5tFzQvuDbjeBoliggfiAjqtMvMZlmTz3E/WPkKk283E2l1rl
	qe1vr255ocnOSGb/J1DsIHG+YMvUucyp55MLgywCriWU/n3vK0NnHkk/gnUW+BLO+yxoz3Fh8gx
	3Ycecf+7DL86da4a0EPuHFS3JEPKzINarQkj5RjJ6oe6FTVddQLuVZmCH/y+i8MyQuaiKVDxLFF
	FxhD2ZKr0Ym4bbiolun/HC7417eULlYN0T3Diy6LoG/KE1zGfUCfQDVxi3tPWu8lEGDqbzZ2lfh
	niIsmbI+W7wtLHStiVrxInoH4Hn5Oa86iVVuC4cnmENW9gaoqjXFczjAuyALhYWs92SWa1rExs/
	4w4m2e4yu/3dKyo1oV5vW9A+HxdN8ri64APLU+9hrZMdVFFTLWvbudK4d99A==
X-Received: by 2002:a05:600c:17d8:b0:483:703e:4ad9 with SMTP id 5b1f17b1804b1-486ff0291d7mr40807615e9.19.1774045469730;
        Fri, 20 Mar 2026 15:24:29 -0700 (PDT)
Received: from localhost.localdomain ([2001:8a0:6c9b:a000:bc11:6b0a:79ed:3d9f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644ae016sm9290237f8f.4.2026.03.20.15.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 15:24:29 -0700 (PDT)
From: Gabriel Rondon <grondon@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	gregkh@linuxfoundation.org
Cc: andriy.shevchenko@intel.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] staging: iio: ad7816: use sysfs_emit() in show functions
Date: Fri, 20 Mar 2026 22:24:22 +0000
Message-Id: <20260320222424.53294-2-grondon@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260320222424.53294-1-grondon@gmail.com>
References: <20260319225719.73587-1-grondon@gmail.com>
 <20260320222424.53294-1-grondon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace sprintf() with sysfs_emit() in all sysfs attribute show
functions. sysfs_emit() is the preferred API for sysfs callbacks as
it is aware of the PAGE_SIZE buffer limit. No functional change.

Signed-off-by: Gabriel Rondon <grondon@gmail.com>
---
 drivers/staging/iio/adc/ad7816.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index 172acf135..0e32a2295 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -124,8 +124,8 @@ static ssize_t ad7816_show_mode(struct device *dev,
 	struct ad7816_chip_info *chip = iio_priv(indio_dev);
 
 	if (chip->mode)
-		return sprintf(buf, "power-save\n");
-	return sprintf(buf, "full\n");
+		return sysfs_emit(buf, "power-save\n");
+	return sysfs_emit(buf, "full\n");
 }
 
 static ssize_t ad7816_store_mode(struct device *dev,
@@ -156,7 +156,7 @@ static ssize_t ad7816_show_available_modes(struct device *dev,
 					   struct device_attribute *attr,
 					   char *buf)
 {
-	return sprintf(buf, "full\npower-save\n");
+	return sysfs_emit(buf, "full\npower-save\n");
 }
 
 static IIO_DEVICE_ATTR(available_modes, 0444, ad7816_show_available_modes,
@@ -169,7 +169,7 @@ static ssize_t ad7816_show_channel(struct device *dev,
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ad7816_chip_info *chip = iio_priv(indio_dev);
 
-	return sprintf(buf, "%d\n", chip->channel_id);
+	return sysfs_emit(buf, "%d\n", chip->channel_id);
 }
 
 static ssize_t ad7816_store_channel(struct device *dev,
@@ -231,9 +231,9 @@ static ssize_t ad7816_show_value(struct device *dev,
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
@@ -281,9 +281,9 @@ static ssize_t ad7816_show_oti(struct device *dev,
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
2.33.0

