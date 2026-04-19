Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093031BD9CE
	for <linux-iio@vger.kernel.org>; Sun, 19 Apr 2026 01:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776560743; cv=none; b=l7SeaD7XgcidcBabviGTgJYbHhCS4jRavBbZh3C1s+95nhfdaQcVn7fNPJi8FAkyrVAQz+1ogkmStFEhjR+Sr+99LB//JLtq0oB0pwrWuN1r4S2sXq/+BnJ5XlFCjEZ8i2XAYXD7Kzg6WFjK36YIyItBZJuX9RHiO/LPeOhu7iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776560743; c=relaxed/simple;
	bh=+jTXEfHh/gOIUYWfxPrWRz07T1+dNIeDgB+atJW8LHc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QtNgJAVX/t7wWFYdKZai0wLVU49ueVVdTeFbq+gEn0q33NtCYdxTdHfmNJAaBqY7esECjQNOsvEg7EXhiLDWD+BL3KQRRhsIHQ+Mw92ZXtmbcQPf6xP6ssMr6dGn/959Y2DxP6TeOOuInc0afMPDM2IVj9x4Y5z2y+aqNVM15gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MaeGyoiT; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MaeGyoiT"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-47018d34159so1240992b6e.2
        for <linux-iio@vger.kernel.org>; Sat, 18 Apr 2026 18:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776560741; x=1777165541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w/kO/B/YPv16fwXs3FVc8gLKrhCkxXiOBqE54B/j6U8=;
        b=MaeGyoiTseZshOQF/XhQSHb7I2FtYCzp25rSf+KZGcXSSEDh4dES5LYKY89CEkf6JG
         Hc0PkdkSxSrLrxOs7aJPMBIXztwWIWw7cAVSlENp1c42DkIiI6qDNoWqqs/0zcbmnP3e
         GbvLraAi/DnjSCVPhSbRGdXQI018s6r3uuSJN9bKOhFWwxALhCDHW8wjYw/7sRD/Q25b
         36aSuJPjHTErHE6icn9++YL8Bs2vtq65lJRPOp5LzAFPsksJkMSI/nSyakxNbkC8r+5g
         SU1aqcPjHnV48b8H9syu/YEQv7AsNl0hqMFjAmXPbpeQkudZ7N1YAme6i0cbnWY2Bf+4
         BW5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776560741; x=1777165541;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w/kO/B/YPv16fwXs3FVc8gLKrhCkxXiOBqE54B/j6U8=;
        b=HxODec13s/JokzCgTTQ9JUO3fub0ymdsfsWjmoLPKFI1YblbhoVkApq9j3D7lbkyPk
         5kz83ejjPpYQNyZmIOounXGO4VscLsjPY9slWqsmwyspQz/hoREIBKe6HeZ89cZIKlYG
         h/wq1KeSzUN3WmMiiOQpDagdT3dhyXy2YgrU6arVS6Pt8D97pHE4ap1H1JvDRTEC7vON
         4NjMWlo0B+YnsH7+nQ++v3f8MEfKQVcupue1p+9ZwUy/EZ+XgbxXPibeiTkHMqv8b6xT
         8EthXqWsEKGFnID0R9ezLoQQSqRw9tB2+y4ey539gU1kXaTESZYefBkoX9GwUKTCRtb7
         uIgQ==
X-Forwarded-Encrypted: i=1; AFNElJ8xp2CudxxNH8rNvAeyyxUFT0alu1dVteBI+8qq7ccXBCS/jiNCapW0A2Tyd7ymSgm9vJZKAsVAWKI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP2utFaADmstaxTGa4bMLDqDhK+Z7mkEGRMNHK6Vf5sjKL0f+e
	+yRlnPZNXaRvEkGgV6nTc0rR0zDJl0Y7/MlhlAmclScqR3ZN8ZIRQ4Js
X-Gm-Gg: AeBDietpbQxITddv+SRMAUNiW8pQSc+ZGgz61GRY/UU2vfVhRrISG+cI6TMK+gpxDSv
	jcsb4waPLrXwRGOQ0UCzvE4LriCXd4ZhYDFfMwq1IDlneRYvhHftNSkhUDcOc1OQAXtsAJ+d125
	MSbB7nE75M19nOX8dC4SqqT0eoiZRcr9NTIW4ZfsCjiGxtFZ/GtfrCVEtnf9cD365knxtoMzNtU
	gYZf7f8xE+RG5rHaJcL/VmdkFDO/l7bvdBb3P1Z9DYC9YbLv8lkjN+PmG8tzy/mX/CNmv4T0fzQ
	sGQ+e7OiIyJcEpgLzS2BhcCZADHNI78tBbniixh41gu8zoVguONRpHSaiP5+8ljONz0a5uZ3yy3
	3FlFFYVanIAUb60zXFKmr6vw8P+hGR3GLzKSlzRP7Rc68MWRgOJnZeMJGuz5OEt7tKp/lX2HFn/
	FBB8fA9vQLWaYnzuOGwvuY1ctEDhEEOMldh5QNYg+A9XrhGSNWGw8RaHTjGnvuFv0cdDhO
X-Received: by 2002:a05:6808:4e89:b0:467:2be8:6673 with SMTP id 5614622812f47-4799c67cb72mr3427152b6e.0.1776560741037;
        Sat, 18 Apr 2026 18:05:41 -0700 (PDT)
Received: from linuxescape.lan (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-479a02097b6sm3983367b6e.14.2026.04.18.18.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 18:05:40 -0700 (PDT)
From: Maxwell Doose <m32285159@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	gregkh@linuxfoundation.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: iio: adc: ad7816: replace sprintf with sysfs_emit
Date: Sat, 18 Apr 2026 20:05:37 -0500
Message-ID: <20260419010537.116002-1-m32285159@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch replaces sprintf calls in ad7816.c with sysfs_emit to help
modernize the driver, ensure bounds checking, and to increase stability.

Signed-off-by: Maxwell Doose <m32285159@gmail.com>
---
 drivers/staging/iio/adc/ad7816.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index 172acf135f3b..0e32a2295990 100644
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
2.53.0

