Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C59391517
	for <linux-iio@vger.kernel.org>; Sat, 22 Aug 2026 08:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787389152; cv=none; b=Uj/sfBAnG+M3iuyNrchtNJfe4PtrU+kKGv/IFK6AxGrzeAiWgihJ6Nn8Qy6lMKH+l5MJSS8Ry3EQY41RlxQ+XsR5c6jhkhv58KR6w+bz8OKDMS+3Xc19r2NJcObBQIxbuTyQHauZsnzUGQxAtM2EdBrHA3xw6A03M/vj0PNNqyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787389152; c=relaxed/simple;
	bh=qh4p6NiaYYKZWRo5SdC+29bJh1njzkmd5IdAQaiKg10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J/eshct3fbLsUB8BJIXJtka6PWUTNqkA/kBRuM0PMhQWXHiWMjAg/1iMnW44LwmZ9QtApqSZ747kDNjDfaU3aX/R0rZvP+r09OwFaFgbUFOma6njTxcC1woZUwC4F/jNVv2U1G0RqwgBP9NXYN1OSbS/UvNiaHjErBHrDhFBiPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TcVXS5Ig; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TcVXS5Ig"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-499b2981a7bso2949005e9.3
        for <linux-iio@vger.kernel.org>; Sat, 22 Aug 2026 01:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787389147; x=1787993947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XsQREIODkCao/QDK0V814PCMzSICvR9cgatjnm3y9Ns=;
        b=TcVXS5Ig7krocPfP/9ao4ZyODVURPMyq6mDn0ZuHJdZ1Eoat34MD0jlK341uOkA9j4
         HDi9fuGMlZPXG4xNXrBOD9bXLfJ8LsAVM3OpOZ7JFIKWSkNPlbHKr4cjzdN+QmhNXVWD
         F5znCQZXZ798dW19vshgt9Hyf0gBSfGYB7VWGvjSza+7wdCKlOsRY4izrsK4fAifEEp1
         yjR5MIP6LdRNKcRAMcOwL8DRLn2uSliN4T7OCw3cSoJWtJZdjdAJlfajclsFdlFqqxuj
         CCawAFI2JFFSwmjoYis/FUT7vT1oBDvM3hBZC0AnE8Tws1vUp0C9VF9eeOp9BF7zdz9k
         ZObw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787389147; x=1787993947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XsQREIODkCao/QDK0V814PCMzSICvR9cgatjnm3y9Ns=;
        b=ECflvcKOFXkQxA+CHx13vPDMLD2JdRqqOm31oT+1CvoyOfYgrICiyCLJfmkMeRWmNV
         JVtC5LOsYnXet0YOBF+PMh6s9RWsLAuqYBd/bBlgcAbpGRXQ8hZ5DjigHmrb6y7G+MsT
         TIG1LaPgjYE1Nt0PWJJCpNZLcYGrOYq7JIhZSSl6N8lwGwZDhd71yluHWm3035nR7RHf
         HmG0Ea0SLAxogHf+9BI5a1SEN/DCz1dpEsmKFrt4OHwcNKCBBXTB0Vh5huJKwYRaDBxA
         g7LzUvDy+xHVK23xd9y/1MLdL1ZIz8HBmRBqZkx0OA3lYLxIf95Giv3U1Y3ACgUvCCIk
         gGFA==
X-Forwarded-Encrypted: i=1; AHgh+RpU7xv+U/VRvHR8eSd5tPFGRCVH+aaO3FWNfleixmRb0yTjFTxwviWZt+EWpF5C3+Pmw1UnSoGggFA=@vger.kernel.org
X-Gm-Message-State: AFuF++mwBeINmizBVk/Wti/o5EFPpRUR5Dvf3jMSCQr22o2j+PXZlVc3
	l0/Nzkn/33DhHyjCGK/+Kdm/BwHjk1hZMM84pgXUG3vzgn9W/lv3jiQ4
X-Gm-Gg: AR+sD13CPv5OGr8PHxadRkiNfQDpqzS53Zy/PFV505yB/DhpGrPufU2fhouolvjipkX
	yFSz7s0l0X+AtuZhhdigWxSQjayMz4Z0PsfDiXEjolRF8L3qxsriPM7O3+iLckgzFWb+Q97YPpY
	YjCYXaLE/NuwwSw+abw2mWorABD/a7z6Shm0W4W0KhQMDlLCG/w9siChBI/JkQGrJZ3xJdE/S8q
	wFDgwvViNrwfIhcNPqbSPi8DgjaJrvI7b295rTziN6voIoxjvshSK8+EXs6COJh9SlqyVvnCcma
	lrEDLXoxtUFeRNq5KzuYJsblvAVmRF3swMOBgkJjavY6erq1A8/OtjM4AE5vBlOb0WYfDfAki5V
	MyvWdgKew6oiB0hnqqqsI64bsPyIrsPBbKL+OROjrW5I3qkOZIkqoABjC3URshqR7tAo15N45Qj
	U8zuAo5tsuebjCay+Vvt2UPIhw5RdQAeY3XP1V/OShI/DjxQnjTdVUeQkkxBHTzBgST+zcsOT4b
	Xh0Z3Df4iQ=
X-Received: by 2002:a05:600c:b86:b0:499:8156:cd3f with SMTP id 5b1f17b1804b1-499b8301913mr118647255e9.8.1787389147451;
        Sat, 22 Aug 2026 01:59:07 -0700 (PDT)
Received: from fedora ([105.74.72.30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499c359b9fcsm13596635e9.9.2026.08.22.01.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 01:59:06 -0700 (PDT)
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
Subject: [PATCH v6 3/6] iio: dac: ad5504: separate ACPI and DT paths
Date: Sat, 22 Aug 2026 04:56:50 -0400
Message-ID: <20260822085850.17527-4-0rayn.dev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260822085850.17527-1-0rayn.dev@gmail.com>
References: <20260822085850.17527-1-0rayn.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver relied on a fragile -ENODEV check from the regulator
framework to bypass voltage configuration on ACPI platforms, sharing
the same fallback path as legacy pdata.

Fork probe on is_acpi_device_node() to explicitly handle each path.
On ACPI, skip the regulator and use a fixed 60V default via
AD5504_VREF_ACPI_DEFAULT_mV. The pdata fallback remains for non-ACPI
systems in this commit; it is removed in the next.

Signed-off-by: Taha Ed-Dafili <0rayn.dev@gmail.com>
---
 drivers/iio/dac/ad5504.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/dac/ad5504.c b/drivers/iio/dac/ad5504.c
index 5c9c66b04154..6f70c57c7a82 100644
--- a/drivers/iio/dac/ad5504.c
+++ b/drivers/iio/dac/ad5504.c
@@ -5,6 +5,7 @@
  * Copyright 2011 Analog Devices Inc.
  */
 
+#include <linux/acpi.h>
 #include <linux/array_size.h>
 #include <linux/bits.h>
 #include <linux/dev_printk.h>
@@ -12,10 +13,12 @@
 #include <linux/interrupt.h>
 #include <linux/kstrtox.h>
 #include <linux/module.h>
+#include <linux/property.h>
 #include <linux/regulator/consumer.h>
 #include <linux/spi/spi.h>
 #include <linux/sysfs.h>
 #include <linux/types.h>
+#include <linux/units.h>
 
 #include <linux/iio/dac/ad5504.h>
 #include <linux/iio/events.h>
@@ -24,6 +27,10 @@
 
 #include <asm/byteorder.h>
 
+/*
+ * In case of ACPI, we use the 60 V as default voltage reference.
+ */
+#define AD5504_VREF_ACPI_DEFAULT_mV	(60 * MILLI)
 #define AD5504_RES_MASK			GENMASK(11, 0)
 #define AD5504_CMD_READ			BIT(15)
 #define AD5504_CMD_WRITE		0
@@ -285,16 +292,20 @@ static int ad5504_probe(struct spi_device *spi)
 
 	st = iio_priv(indio_dev);
 
-	ret = devm_regulator_get_enable_read_voltage(dev, "vcc");
-	if (ret < 0 && ret != -ENODEV)
-		return ret;
-	if (ret == -ENODEV) {
-		if (pdata->vref_mv)
-			st->vref_mv = pdata->vref_mv;
-		else
-			dev_warn(dev, "reference voltage unspecified\n");
+	if (is_acpi_device_node(dev_fwnode(dev))) {
+		st->vref_mv = AD5504_VREF_ACPI_DEFAULT_mV;
 	} else {
-		st->vref_mv = ret / 1000;
+		ret = devm_regulator_get_enable_read_voltage(dev, "vcc");
+		if (ret < 0 && ret != -ENODEV)
+			return ret;
+		if (ret == -ENODEV) {
+			if (pdata->vref_mv)
+				st->vref_mv = pdata->vref_mv;
+			else
+				dev_warn(dev, "reference voltage unspecified\n");
+		} else {
+			st->vref_mv = ret / 1000;
+		}
 	}
 
 	st->spi = spi;
-- 
2.55.0

