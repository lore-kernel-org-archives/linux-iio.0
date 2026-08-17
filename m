Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79E047140D
	for <linux-iio@vger.kernel.org>; Mon, 17 Aug 2026 21:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787001099; cv=none; b=YnjtAV/kr75eJ5WgkPC3qByo95rsHS2IDpfQoAvkNuqIRMnxsZP20hWeR6DMZHzzVuHqLMZlTr+OYR1iRZhxvzKCBUfvjpULUhvFUeRGy0PgW4g9xhF9f0nqrHggempezRthmCz99DumxRRBq4c6z+htR1pdTjiHyRwZnWKTVX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787001099; c=relaxed/simple;
	bh=WbTAqwH1hEHc7w/nmSJFTeDBlIBMy1IZRPJDl8XZxxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fl/7s1EXCeDG+1DMpc0RQapNuhXmjphoPqG/GKvMF3Mp0I0bIpuUe32lvfklEn9Xvq76ys3CpgC4pUAA0zBiwnQaB9ZO+s3NfAWCXa7NffowmgzCRX3/UKrmWC7xZMwarFxTsfcHvfCHayg3Chq4Gh1EQ4uNVBs0JNo8humzKds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oYthXJao; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oYthXJao"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4980fe6b3beso2390435e9.0
        for <linux-iio@vger.kernel.org>; Mon, 17 Aug 2026 14:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787001096; x=1787605896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pPltEi6/m6MK7qnK+08esVhAO7E1S2IgaHOgnArHxZI=;
        b=oYthXJaoI10XoywU25SywsfQ6Xsi+8CdjqtGLSgA30UhrfH2SUrBcK5cTysNMj0UMb
         mt6FxRoR6zQ9AMTCiB+CFRj4n55XiihSM/NmzaRbaGk3VEzqQjQkJVqrMyXi1drUizqY
         RYjVGsAuBCAW6F1FKBWRgyJX4cxARru1+/X02jGCtnCih4VFNIbdWYR+kb90FWt/GvVa
         gbU95j3X+8JBP+ngBSnnG80YcFIMYtSyx70XitjXCl64q4ONW5DeeVJNOVFl5mgRzMma
         QHt2TgBQkbKo7cjLrXvzBDcg/3SIlUEtCDpJnwD6giJJnhBU9DH7mjHqB6dxUTGdaDHL
         l3/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787001096; x=1787605896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pPltEi6/m6MK7qnK+08esVhAO7E1S2IgaHOgnArHxZI=;
        b=i0jp36XL+uSo9kcv06Mbf6rLvYoqLWU4VQQL6wmhdMBMd7XSzFsbx5bpdsRelSuM/z
         L7YAu56C3S61JaCzW2gJ8wrtE0tNdsSbxcQOcm2XvMd362HzJpQKGbnjUQNnLfnkkmtW
         dHac20dsVFUR1uBLON9NPRIlncC9ygiAjKgIikpo5yVB+dnmHPVL3LxFBU4Mx/UVLZYF
         lf71IjCN7MlmUNUskWIXjK5wF9L2C4gIzWVRPuSXDsguyuQl2i3El5JmWBDKs0tegru3
         fKfMc75fAzzT2k+oLGnTmjUoxhA6DVRuVYPVbv3GIlXxizq8wiaAC/fLhTpu1LwfSHAM
         fLvQ==
X-Forwarded-Encrypted: i=1; AHgh+Rps3ptdKPyLRJTLkYk8E6nftyWpuwl+NQKy7bI8vFOgIj87G3rS8Dl/w+z3X7H5Ef3xDFtUhl4YVCM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLnrzlB0/cQeGDz8yxTuXsV1v1e1n391K+lkLqRzZV/bWhwsHv
	0PcLkloMBGPvUf9LXcOuEp1mTEQ6ud3KyB7/L5EYw0+jWZQx4ap19/p+
X-Gm-Gg: AR+sD13CHZZIJbmPJuumx3BN0q5ubRRtTc1ys6Ij2zJ4C/kQ8ogI3OUZUHPXUYp4nu3
	y795XaGtZOv93QRxYbm3xdWC9tl/EsN8F7JW7iL1at04SKdG+OTiZGatMXHo0hLp/RsTs//k/xT
	axUQgCn7iqh5Ngq6ABQc3/T9QE9ZqWwtvZH4j/3O3ViF5Sd1vWQmKyBIiC+8y/OAMs9JBg3wZy2
	RHOcNHzCCzSOwGLF/vAZFem9kWfTxFUdA+dtNkqdNq4GdRP7Aylh7c7Y788+6Y/bp1HpsvRbi4A
	TXieZzGyffj2BZmkTupnIuQioz5d+/+7Lsejs8KlJnTfj3+VynWtn0ixdrDNyQx8MuSj+a0xr9/
	sStvHl9nH12jbS7CdSFirnokZ8wRd+/YG26FV1RJCioBmr/AiCPD9oUnKdmD+TDo7vLxRCuMEgb
	vlWlp2ohSFSaAzWntWnReL6pr9UQezsBgInp3vg/yahTUkjeHYWFJmQtbNPMJo/ibERx6gsEpKy
	rGK0xJrgeyqBmmkwHT/M2E=
X-Received: by 2002:a05:600c:1394:b0:499:8d9b:832c with SMTP id 5b1f17b1804b1-499a2060a14mr5656095e9.4.1787001095635;
        Mon, 17 Aug 2026 14:11:35 -0700 (PDT)
Received: from fedora ([105.74.73.207])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49996176b95sm134587625e9.10.2026.08.17.14.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 14:11:35 -0700 (PDT)
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
Subject: [PATCH v4 3/6] iio: dac: ad5504: remove legacy platform data support
Date: Mon, 17 Aug 2026 17:11:12 -0400
Message-ID: <20260817211118.21833-4-0rayn.dev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260817211118.21833-1-0rayn.dev@gmail.com>
References: <20260817211118.21833-1-0rayn.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The AD5504 driver contains fallback logic to use legacy pdata for
configuration. Since modern systems configure hardware exclusively
using device tree or ACPI, and there are no in tree users for it.
It can be safely removed.

Drop the ad5504_platform_data structure, remove the fallback logic
from the probe function, and delete the dedicated
include/linux/iio/dac/ad5504.h header file.

Signed-off-by: Taha Ed-Dafili <0rayn.dev@gmail.com>
---
 drivers/iio/dac/ad5504.c       | 14 +++-----------
 include/linux/iio/dac/ad5504.h | 15 ---------------
 2 files changed, 3 insertions(+), 26 deletions(-)
 delete mode 100644 include/linux/iio/dac/ad5504.h

diff --git a/drivers/iio/dac/ad5504.c b/drivers/iio/dac/ad5504.c
index 689147cdaa14..55ce7e49e0e0 100644
--- a/drivers/iio/dac/ad5504.c
+++ b/drivers/iio/dac/ad5504.c
@@ -18,7 +18,6 @@
 #include <linux/sysfs.h>
 #include <linux/types.h>
 
-#include <linux/iio/dac/ad5504.h>
 #include <linux/iio/events.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -275,7 +274,6 @@ static const struct iio_chan_spec ad5504_channels[] = {
 static int ad5504_probe(struct spi_device *spi)
 {
 	struct device *dev = &spi->dev;
-	const struct ad5504_platform_data *pdata = dev_get_platdata(dev);
 	struct iio_dev *indio_dev;
 	struct ad5504_state *st;
 	int ret;
@@ -287,16 +285,10 @@ static int ad5504_probe(struct spi_device *spi)
 	st = iio_priv(indio_dev);
 
 	ret = devm_regulator_get_enable_read_voltage(dev, "vcc");
-	if (ret < 0 && ret != -ENODEV)
+	if (ret < 0)
 		return ret;
-	if (ret == -ENODEV) {
-		if (pdata->vref_mv)
-			st->vref_mv = pdata->vref_mv;
-		else
-			dev_warn(dev, "reference voltage unspecified\n");
-	} else {
-		st->vref_mv = ret / 1000;
-	}
+
+	st->vref_mv = ret / 1000;
 
 	st->spi = spi;
 	indio_dev->name = spi_get_device_id(st->spi)->name;
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

