Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C573F264619
	for <linux-iio@vger.kernel.org>; Fri, 24 Apr 2026 15:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777043217; cv=none; b=p7DIP4JiVISH00+H6X8KBzBpv6+TXDbC/NgwHcPxexXzYr+YwIX4SR2kf4YpZVG1TPoX+10I8+tND2Cz1EQaRi/MQKSQ9tt61Y3K+LklJNKyXcoOFtOslQGIcaQ9zzo6Y9MpYmJ14sVK2UzK7AABIc7ovOKsaxU3KJnq43wAiBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777043217; c=relaxed/simple;
	bh=g7uNErpww7LkDRGtVNGmRdf6PPweeBnnmZM5F/WNRJE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SRgKD7e8Kbm3GOuRC+hBZjw9++w1I+1EYSBHr1vHFqXXzt+7EowEBs8l4v5r+GDCfUXESySejiQG3e/zp/TLkfSyS7rKqKrBxJZ+J05VXtYt7Tno2KGVj2gLFTrdWVHqJZXpEFHsoe2+XmFy8ZeMHSLKQBZorE4GEcjVnMTxR/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RBkKz2e+; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RBkKz2e+"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-12c8f9846c8so7582671c88.0
        for <linux-iio@vger.kernel.org>; Fri, 24 Apr 2026 08:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777043215; x=1777648015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=247B1qaVFj/YXlYhPiXykaqQnuOzRC0LqGxEuJfJas4=;
        b=RBkKz2e+iNByRm5TuXEtEgEH0Pl4DPMMs2bmsuhuy0PrrR0+RoIynSZz8I9VZzNlLM
         +//0dsht8AYQagdmk+QIRpnno2aMhjO9hZ5XQ8q2gT7nJhkavVNjQmtnTXvO//aV2RHi
         Ps3J/2J3aT5nonv1HX3dCb2Vcxwebh4EQQJHO26t3AZnHfyiqBSf9bSlF+X3wD2iE6/S
         Q53mYJj0ZR3Ucq31iQeVsR+PqKh9KJQbLPp1+TI8vWA+rebQ5wqIm0sbRCeUMsiKhPjC
         xhURD/2n2Nw4IUMHEDSeBBBShh8y4DYZbB1d1/VefGpvp3RptiuiEe8XPn4QdMrWHJnL
         qAFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777043215; x=1777648015;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=247B1qaVFj/YXlYhPiXykaqQnuOzRC0LqGxEuJfJas4=;
        b=pscTn3rGcmPEnWo9lhsADro5L61bbXohcLq44jNAXxZXfMrxCcc/NQlJxFDWifdhVA
         MCsInwcHcI9JzNp4wg1Nfll0xZ8jr81owAyAjFOwl/Z00vB2q2pGgcrkFJyT2w4VkZIZ
         bcLTeVo1OFTpAZufHuqbsqePbku+PbKnE7q+EfZ3owsXK0QWxd07Ou1FozwK4VgzrKRR
         iAzO2Eq6qcyKo4/4KuK52qyoCxD+loHwKULGC2YV7/qXwCTZ1DSXFw+L8FyguPduODR4
         V69f7OFS+r/SouUr4m4sXNQtD4Wrvz1gtNjpznyx1YKOrBL4kraOBlsZXAGVJV1+MCnf
         z2gA==
X-Forwarded-Encrypted: i=1; AFNElJ9Ftac/Rq6Rb1+pw0FaPCTmdYyBD4Y5C5feyishO9QqoT79Y5lhLFOe/jf+kV6B58Se3+FQOzu4URc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9xVdOul1SiwIDZnjONWPnjt0FEh79jl+9XAnWdxPr2WznCYCa
	G7NFDRLXMA0NigA6F43SWz9y0efwjlQj1Mx1FvAdHwWeEgXlQugjkWWirc0J5N8Cv+M=
X-Gm-Gg: AeBDiesN+NAFFmcEWbzY6G3kNTohdYQqiXmkHH+8q9OZnjAwe+9jQ/jhzm1HRjpVyxi
	vSPdfX55/8lzxCUmekdbd1l/eF8v/vSnL5cIkMA85XZBeK6E8H6zdCatqvuSvGSALcPERdu0eKI
	wb3DnfGz5NnzzUarPdZCaJm6nAzs0jZAL6pXkqAbqnNFaOySBNZoPdAgJSKLC74SeivTXCeiJ+N
	rKPeXUl6tfBOvE453yOJVGOkcTTYtcPiYR7ex+uiq1K+l0t4fh86FkyUEtnGKpHm68dijLlVu6E
	VjfP6u2OamAioqOUq6fDEWgkkzRzyVDhS1RE1rRit/p+FKfgt88wFV/WszOc2koIFELY77m213a
	xaoTt3dWqIhbvW7qtkq+4r5+xKK4XFELJl3im2sWLNexl7fbPMoGTZerxMSV0cmFwKAFnObRqXJ
	YXZ9xk9zBMlJ+FqUJSUTQCVkl0EbWXeki1Qil6seBD0LsSrXPkRarq5/fh5pG6JpaZ
X-Received: by 2002:a05:7022:220f:b0:12a:713b:8953 with SMTP id a92af1059eb24-12c73f72283mr17166787c88.12.1777043214763;
        Fri, 24 Apr 2026 08:06:54 -0700 (PDT)
Received: from DESKTOP-R76JGJA.localdomain (vps-e1cc9378.vps.ovh.us. [2604:2dc0:202:300::1365])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12dc6f08eaesm3558952c88.12.2026.04.24.08.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 08:06:54 -0700 (PDT)
From: kunjinkao-os <kunjinkao.jp@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kunjinkao-os <kunjinkao.jp@gmail.com>
Subject: [PATCH] staging: iio: adc: ad7816: Replace sprintf() with sysfs_emit()
Date: Fri, 24 Apr 2026 23:06:17 +0800
Message-ID: <20260424150617.28194-1-kunjinkao.jp@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sysfs_emit() is the preferred function for sysfs show callbacks as it
is aware of the PAGE_SIZE buffer and prevents potential buffer overflows.
No functional change intended.

Signed-off-by: kunjinkao-os <kunjinkao.jp@gmail.com>
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
2.43.0

