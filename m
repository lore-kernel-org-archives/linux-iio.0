Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D323BCD26
	for <linux-iio@vger.kernel.org>; Mon, 17 Aug 2026 21:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787001103; cv=none; b=rY6UikUNPHS5iUWCx14sBwbjemjurQyWTo3YcbONpCen+NPM/Y1UtsW8Q+IgjmUYCeXa4M5vy7oQi9iSZUW718yqVIkPl78yFJfMTVr7a/Yo90cSdqeGah3M249EMhhoNPb+w9grGjbm7KMcD6q+NdXrCHjcv6RNijdUpJ63t6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787001103; c=relaxed/simple;
	bh=KKCQp/0RMN5WXaLM5bicyktOACB6mRToxqjIMmbfh6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XMP4i/RMYP658Qy5A8z/uU5a7Z8Dku8IHGWs9/O30cm9gKN8+GN4p0Zk+23oRf9eXNXJt++2hRCtqx9RXXQj2hOY5zHTQNwSC1guJ9i5TOQFvtaBdOgRGchu6RWQHKzJrs3dpvXN7za0GrjjqJpwJdBXppN+78svgQ68n+yh14U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GqlD3n6N; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GqlD3n6N"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-482938466a7so2419622f8f.1
        for <linux-iio@vger.kernel.org>; Mon, 17 Aug 2026 14:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787001100; x=1787605900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Igoic2RMUzhWCgHEuYeIt4q8iEPlVBgMNrF843o6/Ho=;
        b=GqlD3n6NktURbIh0eWjeV0EHpFetk0V04QDFVKCT3dGawChO3C4L/Fe5c+O+LKAGba
         wgEDckFFjvdF26tRMmjoedqwkzZGzx9WfSOzGCaKRoB7moXTU1dUD49HSHsqkfyH2AOs
         iqAYFby9bsbWGQbFy9W0UKqBGkgESZBgt/uNC50DnjxfbOcvrSnzUuGrrXLsle5ed2J7
         6W0HiBHJ/vC85hAbHzmIklKj1czv+yjmtm9+UN5Tz29A6KaTfB4Z+7DcfcAWC3OW7gcL
         uzEOgVm20eezVyfS2BCyUwyz/04J+LfcV09qxes9UAI1hWAVt/wyf6hNFcmX6tO8vPBi
         ysjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787001100; x=1787605900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Igoic2RMUzhWCgHEuYeIt4q8iEPlVBgMNrF843o6/Ho=;
        b=HQ3R8QUHx17nOJTdEEEWQuNx6D1CoTZyWVaxU2DcN+mmROulU4HBobupgfXxSrU8y+
         2Hi9OhGsH1XbnCmjvicZD9Dbi7HII3nOm4QNMhux09r6iW1s1u9ggjxyx3ilK170+6Ws
         b4/lByVi6SNA8C3jrS37JSotJOvFNKRZUQbZmrGspsSkscQSOexMzFKQ49GGf2NrLIiW
         hFQYcYb4GZywo9WR+iJFETW4hejXY9GQtSsThCnwwUICZL/j5UW4BQQNoPWP+df8Z0cK
         plNUiu+07hxyKxblNDy6KA/VQPvEYM0nXbQf14aqKKVuGrELrUi+QAoa8CXI/3OtmpcI
         xDwA==
X-Forwarded-Encrypted: i=1; AHgh+RonLXCzgf4YXqKd//9Y6CuDKuBjtTNk/TNEoQ5BcVjBNTjdIJOL8dvNT6vXfiKyq8Iq780WJCZz35Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwguuTVzZBNlPEC8fafm42tEQNAZjuz5wD2+qhxM8ZZJu2CB3aD
	20ZR9eJ71qkbBuAsZbNPYFmDezGdxWuxgKXHPn3ywrHyjN3zwn+OwtJq
X-Gm-Gg: AR+sD10lJbbf7HOGALa0TSRv+ljRoNc1qYJQuDmPJBp8gdPoHyfb4bHucszaMRCHalu
	m0BjuUQLQINRNkGjYm6EXv92TvgpM0PeKwaIS/ouYDotudBnIcQf8aSqrpewm50u8CxdqhiUlvD
	3/3mp6k5CMJF+QkRY5j06d+wKh01HI4JuVTWBjnUG/xG4GxxLOnu6or9Vmn/eW/BSIyb6IqVrM5
	mjEm4JYD9MTMBbbLSEuNBwNPMr5LPRVZkOEzcMGj5g5vOMK7j5SdNK/m+jyM+qEYph0CXp1FYIo
	tC+LG9Jj7PGiQjb3aBs5PvRrZJOYPVdvRgHW0N6RtXQnuBJFvNS5T5FgYuIHEjTzb7WuwTtwjIJ
	qxaiy9atZQBe8kbew8YFDyo8hfrUwRYIMYk+QBIDxejPhoJJss3DBsGzGVwUZ8bQql7o8sLSv6M
	+bxKOrDjx9+lOqmWIglo+eoGWRXNlJUQaRMcLxJT8byB1AzlXXrh9PNOfqoNS6+88w26EdWs2hE
	U3Mp2omYsi/
X-Received: by 2002:a05:600c:19d1:b0:495:4e89:3f30 with SMTP id 5b1f17b1804b1-499879ae4f4mr412180665e9.15.1787001099817;
        Mon, 17 Aug 2026 14:11:39 -0700 (PDT)
Received: from fedora ([105.74.73.207])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49996176b95sm134587625e9.10.2026.08.17.14.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 14:11:39 -0700 (PDT)
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
Subject: [PATCH v4 5/6] iio: dac: ad5504: strictly separate ACPI and DT probe paths
Date: Mon, 17 Aug 2026 17:11:14 -0400
Message-ID: <20260817211118.21833-6-0rayn.dev@gmail.com>
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

Refactor the ad5504_probe() function to explicitly separate the ACPI
and Device Tree execution paths. Previously, the driver relied on a
fragile -ENODEV return value check from the regulator framework to
bypass the voltage check on ACPI platforms.

Following modern IIO subsystem design patterns (such as those found in
adc/ti-ads7950.c), fork the logic using ACPI_COMPANION(). On ACPI
systems, where dedicated voltage regulators are typically omitted from
the firmware description, bypass the regulator subsystem entirely and
initialize the reference voltage to the hardware default 60V scale via
a new macro AD5504_VA_MV_ACPI_DEFAULT.

For Device Tree platforms, treat the VCC regulator as mandatory and
wrap the allocation in dev_err_probe() to cleanly handle potential
deferrals and error propagation.

Signed-off-by: Taha Ed-Dafili <0rayn.dev@gmail.com>
---
 drivers/iio/dac/ad5504.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/dac/ad5504.c b/drivers/iio/dac/ad5504.c
index 87946cdf69e7..546420f9afc0 100644
--- a/drivers/iio/dac/ad5504.c
+++ b/drivers/iio/dac/ad5504.c
@@ -19,6 +19,7 @@
 #include <linux/spi/spi.h>
 #include <linux/sysfs.h>
 #include <linux/types.h>
+#include <linux/units.h>
 
 #include <linux/iio/events.h>
 #include <linux/iio/iio.h>
@@ -26,6 +27,10 @@
 
 #include <asm/byteorder.h>
 
+/*
+ * In case of ACPI, we use the 60 V as default voltage reference.
+ */
+#define AD5504_VA_MV_ACPI_DEFAULT	(60 * MILLI)
 #define AD5504_RES_MASK			GENMASK(11, 0)
 #define AD5504_CMD_READ			BIT(15)
 #define AD5504_CMD_WRITE		0
@@ -300,11 +305,16 @@ static int ad5504_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	ret = devm_regulator_get_enable_read_voltage(dev, "vcc");
-	if (ret < 0)
-		return ret;
+	if (ACPI_COMPANION(dev)) {
+		st->vref_mv = AD5504_VA_MV_ACPI_DEFAULT;
+	} else {
+		ret = devm_regulator_get_enable_read_voltage(dev, "vcc");
+		if (ret < 0)
+			return dev_err_probe(dev, ret,
+					     "Failed to get vcc regulator\n");
 
-	st->vref_mv = ret / 1000;
+		st->vref_mv = ret / MILLI;
+	}
 
 	st->spi = spi;
 	indio_dev->name = spi_get_device_id(st->spi)->name;
-- 
2.55.0

