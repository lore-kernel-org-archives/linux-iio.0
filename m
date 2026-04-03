Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE781332EBD
	for <linux-iio@vger.kernel.org>; Fri,  3 Apr 2026 08:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775203607; cv=none; b=GpcrlZpcK2x7xODShwXuOHx1jsaoRgr/pPBbqBUFo7HjbgFT9RO2wsba7rpfDDDJ4XGJeJH2Y9WI+pqvDOIQn6CmvqCpSxrKuR97TyzJBSO7rj7E4mmfEU37aoo4eC9fbInkqAE/JglU6AdVPDfURt/NtmWa7YpbQBsrx1UHcGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775203607; c=relaxed/simple;
	bh=cfn1ijAobwTrXyt5+z+cKX2dHKqOw+biyb82n/YresU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GJARsJ1h8Q3mhUAls8arptw8ujDL3zUhquWOoOLC45xUpMJ+3POyLqKa5zTcjWNdv3EMWiMoptBgaV96LsWoLqTGVXQ+nEPJDBOAHnMGWY/lzNHR4i/4v/KjRjU675j7LJ8ioRgp9gLP5cpzFpFaojrPo0bIBmI3mMePdTUuVjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n9VQvp8o; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n9VQvp8o"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-82c70e4654eso780530b3a.2
        for <linux-iio@vger.kernel.org>; Fri, 03 Apr 2026 01:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775203605; x=1775808405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hEif9Z5kuu/R+mzMUqLNULAX8wRxNRnpj5puPaiJPIw=;
        b=n9VQvp8oUC9HCkg9eGfBrrXwPwRR7qesoF8s3jW7d/9PzPJlLx7E59ou7/7HwjXq5z
         I6OZBocYOmoAyEOJlO4Cvbkj95e/BOwNhg9GNIDnBiFx9v9JoFkANp+LInQctdhG4wcc
         aRT0UMJ6vYKJp4/ptDnxoW1Sger2vlPQqzkxq7FjwQ7tkHjx9b5pABD9GBDS0FGSZ49o
         PgmeTlsp9dwuR0T7QLIJkH2Rbmkw7NnRhg5EPAwJ9JVFFIRM4eH2tiOqR0maNLre+UzC
         oMygCy5TAZBsqjKf2rc43SRYb5kefgcafwLfAHi4UujtkKHCh5pNy8FH7ouXtr4gJZPy
         s+JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775203605; x=1775808405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hEif9Z5kuu/R+mzMUqLNULAX8wRxNRnpj5puPaiJPIw=;
        b=St9w4CMbGKXPVcWh3odT+As27HFtKbMZxq+zDyzqi0KHZo1itzeDUcJpUW75Moexzf
         Igbj7YGt/3q/FxFStAPjtiFr0RkP2ppiJboDyXTZ097ZujKUaGIyhhgEfMnPWj6714dW
         gsAXq1To5KmQ+Yo0C+Mn4//7QTAOa7OI+quPB9v2PGr+Hahh3nJ9oiFG6CKIoehMTd6Y
         w7c1qW9kB3RI+dDASL5/60w8ACyeRIJVNT28gxggLqPEyS2KzG6t3HfotI9O04N3Jly0
         N/0o/nDTs9ZXDZvWXwP9HRXeeL5M926hMV+2bQtcH17CZ3CTLt3QZAMjVTCPNENvzGQE
         FobA==
X-Forwarded-Encrypted: i=1; AJvYcCXhzueXSI25mgXDvaj3cgRWKDnlIxl2B1rEXTtavH9CqAt7GntJOgPvGX9109WlSRruBBBn9aJlxAU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX1Z6abDiwaxi763fek150DCSj1Db8II1+tye6U3Va8HrHrz2M
	LLsvbZCiB9XwFQazus7enKmSMd1rbUbFy7ZiJZiVnxy2qytrr9LSFvgz
X-Gm-Gg: ATEYQzxzBhfqdvr6HKKElJA7ZS5la9aJ8gBizcG8liZvxR0L40IbkCXpHYbC/YKAQkO
	N9ARQkq6Zt2Ex50hBnh78pzBo2eL+bOop72zf/G7H4FapMnVZViTM6FS6hIA6/RqCU/BrgmhoDD
	cW9PLi6iBjku3Rzi9+bULFMY13kJpfcgeoxaA5leWJcSyW57on+P0kv2hcWbSXxDBTTzpLWUr8r
	3JMz5IBPjH8/y+uujpHm/awq2NIRPEGvbxmf5dyK2z04nonAYDK/zwm3pzmsOhzBvacM6+7BYHz
	VvdIpfT8Rgyryaeh/r1QDzzvAgPOso9GT/haYcRnsY6JRsKf1WI+rSeTOQLjW09XopDzP7lA6R+
	4CLWuULaoBYAQSGd2ifa5afy/Jo6b6iLdQ2eGasK8xY3BLOKIC6DftiddDjHKeFaHd/8PlxtiDD
	VqRkrSPo+7gkhoGEddtWlhJfjKxVPAPIxb9ZQu6UyXhVhafpeckyMVWDqTMtgb9kpmN/FGQJzks
	Q==
X-Received: by 2002:a05:6a00:408d:b0:829:8c23:f70e with SMTP id d2e1a72fcca58-82d0dbabbf2mr2193957b3a.45.1775203605279;
        Fri, 03 Apr 2026 01:06:45 -0700 (PDT)
Received: from debian.ari ([152.58.181.253])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9c6ad8asm5481093b3a.40.2026.04.03.01.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 01:06:44 -0700 (PDT)
From: Archit Anant <architanant5@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Archit Anant <architanant5@gmail.com>
Subject: [PATCH v7 4/5] iio: adc: ad799x: cache regulator voltages during probe
Date: Fri,  3 Apr 2026 13:36:13 +0530
Message-Id: <20260403080614.14213-5-architanant5@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260403080614.14213-1-architanant5@gmail.com>
References: <20260403080614.14213-1-architanant5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the reference voltage for this ADC is not expected to
change at runtime, determine the active reference voltage (either VREF
or VCC) during probe() and cache it in a single variable in the state
structure.

This improves the performance of ad799x_read_raw() and removes the
dependency on the regulator pointers during fast-path reads.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Suggested-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Archit Anant <architanant5@gmail.com>
---
 drivers/iio/adc/ad799x.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
index d8389b6e19b5..e37bb64edd2b 100644
--- a/drivers/iio/adc/ad799x.c
+++ b/drivers/iio/adc/ad799x.c
@@ -30,6 +30,7 @@
 #include <linux/slab.h>
 #include <linux/sysfs.h>
 #include <linux/types.h>
+#include <linux/units.h>
 
 #include <linux/iio/buffer.h>
 #include <linux/iio/events.h>
@@ -135,6 +136,9 @@ struct ad799x_state {
 	u16				config;
 
 	unsigned int			transfer_size;
+
+	int				vref_uV;
+
 	IIO_DECLARE_BUFFER_WITH_TS(__be16, rx_buf, AD799X_MAX_CHANNELS);
 };
 
@@ -303,14 +307,7 @@ static int ad799x_read_raw(struct iio_dev *indio_dev,
 			GENMASK(chan->scan_type.realbits - 1, 0);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
-		if (st->vref)
-			ret = regulator_get_voltage(st->vref);
-		else
-			ret = regulator_get_voltage(st->reg);
-
-		if (ret < 0)
-			return ret;
-		*val = ret / 1000;
+		*val = st->vref_uV / (MICRO / MILLI);
 		*val2 = chan->scan_type.realbits;
 		return IIO_VAL_FRACTIONAL_LOG2;
 	}
@@ -829,9 +826,20 @@ static int ad799x_probe(struct i2c_client *client)
 			ret = regulator_enable(st->vref);
 			if (ret)
 				goto error_disable_reg;
+			ret = regulator_get_voltage(st->vref);
+			if (ret < 0)
+				goto error_disable_vref;
+			st->vref_uV = ret;
 		}
 	}
 
+	if (!st->vref) {
+		ret = regulator_get_voltage(st->reg);
+		if (ret < 0)
+			goto error_disable_reg;
+		st->vref_uV = ret;
+	}
+
 	st->client = client;
 
 	indio_dev->name = id->name;
-- 
2.39.5

