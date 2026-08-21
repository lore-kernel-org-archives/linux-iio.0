Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515C741F376
	for <linux-iio@vger.kernel.org>; Fri, 21 Aug 2026 10:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787307928; cv=none; b=PFPvORWT5e9bWLUWmEelsvU8KeBYyahYIIfrJQTIg9q5qK7Tp1f4mttqeuPDfcnbB27/ABH2dWftVHhOqel7qYPf362z459hRhFQtHmgWgwk4lrRbMQJMWIkQ+qhMRqKftyyiXmd9kI3Ek0piizlNNBWq1cTFeZNJqawF6rtLfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787307928; c=relaxed/simple;
	bh=HCZVOF8T9m7E1Gm3Iq+tZImcQ0gw7AQRtwevkDBWDd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lNp2MaVYmzMy+l8vKDkjFHFetzSCCv6W3uMXQFGGP1KDm54CJLVafYaHcPmpkPZnEdg+Hx27ZB5n5gmSHx9OFtp1kiMA2GA/NdQ+N489MVCKJcP177wJJdrDvusiP5B5RSKTv3Q5G0erJoSeSsmRppsxNxt6U0Sb6FzSKBQ8frE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UtHLc+OU; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UtHLc+OU"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-49978908b35so5485665e9.0
        for <linux-iio@vger.kernel.org>; Fri, 21 Aug 2026 03:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787307914; x=1787912714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0dWiifvCNQ6/1XjQKOnLCIy+9xjui2vS7wMw6DuKzck=;
        b=UtHLc+OUTF+fZmq9XpVSv2JuxfjYbpBPEgeWJhlyrnxWStFtw0RR+ZCpA+GwngTb5j
         lT/ulqbApiN2yudQX2EsW/5g9yOW6QK1VhorQJi4j3aYd44AiFQfdYv46GIE4YK7aFgT
         iuWEv6j300X2pEaW7K58Mou/xuNd+iakhuya3tEHGSrbRonvKwnytpQxfMyk5hnB2Zyp
         RQIunIkVYcUHB98LO5f3nJq6GRPeFeL7wJf9mn5cOmJFNboiGO/mkMN+e+30isV3dvzS
         ryrL55bHwmG9eGswDMvXFVSMwR77pUtVSeycpKuPyQAPYv8FPvKdcEhYQpEPJJgW77xc
         etTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787307914; x=1787912714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0dWiifvCNQ6/1XjQKOnLCIy+9xjui2vS7wMw6DuKzck=;
        b=lzgEDtk46J9/UDzqpTPR4Y63RnlvPNNXtvNmqrnZ4T6+auPYVOj+kFC/h6M1JO2lE4
         kzHZcRF59AIbMoCpSbJSDgU9C90OT2I2de6p3FAUKhkjlwHIe2WyhHmbmLxuibHQQhbA
         zgbXK13GNcsZBMtqY36nxyfkJW+nwzn0QeBnajtOVAOtifWK7tihI+lri6YsvpNHwE6K
         JA1b6TQrwCoBItbR7ge9arpbjJXJjE9pMG4UO4PSxhLJwTXtIOYpanhyU7RJfGM2emYL
         iIcPGf8/l1NM531xLOhIPvzG1JZYhHyHUw3bGHipXkvXdWRisQcmW2Zfblpub4Sx6JH/
         mXZw==
X-Forwarded-Encrypted: i=1; AHgh+Rr+AjY/HGweGR6viNY0p1Qo5BzNXYjPxnKQleb1gh+UCtTLjwvfxU3/KGjl0Gl/OxZnVRRGskzZxdM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjkWqAYV9J65o0ssZagDBfSO1bN4cWumU+lhN6y3kh8cKwTqDp
	bTbP/EM0T8sNmtFDJEWhYatHOEO4Q0d0j1r8/IIdVZz3kcT20vzqhE2aPLwTSA==
X-Gm-Gg: AR+sD11p0EhORh2vlAdyRYGVpmjMH3Zin1bkRfKgIdB5Kxlvduln54qJchoeS5RCins
	zetkgiMUgwW7YCjbV5one53G+FT/7q5ywK4u11gAA4VWKQtZEpOmIk6BZyRhdbHJVnXdvdkSwPo
	efcjtW1pRck4I8bDnS0UaNe00ZCH0DybFzNUd46acW0bzjCc6OZ/DdGB/FeEc97XS++eaXnSlj2
	9DYyKXFHS0pTwF7Tef7cJd8DEC0CYrdsxsr+2ga2vK596q8QKd9aGdrTmB/5Qa9ox9t9stvt5fD
	UVUVIXRvUDSzx8r3c5ILUWVzepsgpMpgo3pZfSgn20R+K1TZltYLzv3CFSNQWw31uhrHozrQpUt
	//MnJqTwJfxpyLqIauMv6xlzrzpcc7havkECcdcsV4ucNtcw01pTniW79z2nd1v2gVe3+CSJAow
	YYQGtTkD6FN1IR41W8AcpTJ2YHBXqSabIK0ZCOw03H487EE7LFesxp738gKuha2uVbeLkpDnSS1
	fmPA7saomGqrg==
X-Received: by 2002:a05:600c:3b08:b0:499:b402:6c0 with SMTP id 5b1f17b1804b1-499b830d671mr64331415e9.3.1787307913677;
        Fri, 21 Aug 2026 03:25:13 -0700 (PDT)
Received: from fedora ([105.74.130.192])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499b9ba5139sm11663155e9.2.2026.08.21.03.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 03:25:13 -0700 (PDT)
From: Taha Ed-Dafili <0rayn.dev@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de
Cc: Michael.Hennerich@analog.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	skhan@linuxfoundation.org,
	linux@analog.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Taha Ed-Dafili <0rayn.dev@gmail.com>
Subject: [PATCH v5 4/6] iio: dac: ad5504: remove legacy platform data support
Date: Fri, 21 Aug 2026 06:24:46 -0400
Message-ID: <20260821102452.37407-5-0rayn.dev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821102452.37407-1-0rayn.dev@gmail.com>
References: <20260821102452.37407-1-0rayn.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The AD5504 driver has no in-tree users of its legacy platform data
support. Now that ACPI has its own explicit path, non-ACPI systems can
safely treat the vcc regulator as mandatory.

Drop the ad5504_platform_data structure, remove the fallback logic
from probe, and delete include/linux/iio/dac/ad5504.h.

Signed-off-by: Taha Ed-Dafili <0rayn.dev@gmail.com>
---
 drivers/iio/dac/ad5504.c       | 17 +++++------------
 include/linux/iio/dac/ad5504.h | 15 ---------------
 2 files changed, 5 insertions(+), 27 deletions(-)
 delete mode 100644 include/linux/iio/dac/ad5504.h

diff --git a/drivers/iio/dac/ad5504.c b/drivers/iio/dac/ad5504.c
index 6f70c57c7a82..799726eafdf2 100644
--- a/drivers/iio/dac/ad5504.c
+++ b/drivers/iio/dac/ad5504.c
@@ -20,7 +20,6 @@
 #include <linux/types.h>
 #include <linux/units.h>
 
-#include <linux/iio/dac/ad5504.h>
 #include <linux/iio/events.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -281,7 +280,6 @@ static const struct iio_chan_spec ad5504_channels[] = {
 static int ad5504_probe(struct spi_device *spi)
 {
 	struct device *dev = &spi->dev;
-	const struct ad5504_platform_data *pdata = dev_get_platdata(dev);
 	struct iio_dev *indio_dev;
 	struct ad5504_state *st;
 	int ret;
@@ -296,16 +294,11 @@ static int ad5504_probe(struct spi_device *spi)
 		st->vref_mv = AD5504_VREF_ACPI_DEFAULT_mV;
 	} else {
 		ret = devm_regulator_get_enable_read_voltage(dev, "vcc");
-		if (ret < 0 && ret != -ENODEV)
-			return ret;
-		if (ret == -ENODEV) {
-			if (pdata->vref_mv)
-				st->vref_mv = pdata->vref_mv;
-			else
-				dev_warn(dev, "reference voltage unspecified\n");
-		} else {
-			st->vref_mv = ret / 1000;
-		}
+		if (ret < 0)
+			return dev_err_probe(dev, ret,
+					     "Failed to get vcc regulator\n");
+
+		st->vref_mv = ret / 1000;
 	}
 
 	st->spi = spi;
diff --git a/include/linux/iio/dac/ad5504.h b/include/linux/iio/dac/ad5504.h
deleted file mode 100644
index 9f23c90486ee..000000000000
--- a/include/linux/iio/dac/ad5504.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * AD5504 SPI DAC driver
- *
- * Copyright 2011 Analog Devices Inc.
- */
-
-#ifndef SPI_AD5504_H_
-#define SPI_AD5504_H_
-
-struct ad5504_platform_data {
-	u16				vref_mv;
-};
-
-#endif /* SPI_AD5504_H_ */
-- 
2.55.0

