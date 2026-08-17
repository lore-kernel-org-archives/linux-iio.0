Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91102471CE2
	for <linux-iio@vger.kernel.org>; Mon, 17 Aug 2026 21:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787001107; cv=none; b=Tb67qW44T4Xyh6JWuDVHJFsIXXSmPAfvt1qYthfyiCnGkegv7NRHsXlnY4QWjHOSXvo+xyCqyB4a/cj6ovo5Xmr2SmE0II7HfWVg1H4rKQgrYa8PDDporYToGbG7t/7BYqJsG2xsGKbmlRA5ZrJWQjfRx85q0sN+bw7qHUgejow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787001107; c=relaxed/simple;
	bh=OlM8K7Hln5lV9GkceSzF8HYbv5V1jBHK/YfIivjoDiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UPMtFHU2ai9/FLb8TMlS74FX9YlBmYuSqnA6fOxt5DUY/HL64YvB2WPwOosKzzv6WykjRGC7OQk/vS49p32Y6a7cFQ7QuB0JrsDxFFzLq/Dad0rxjKLqDQcBJq+f4+tU9UJoDJ/SnucugV08Kruet4UmWI4lDv5+HEWhz0SwUz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rvLFtsFs; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rvLFtsFs"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-47f92e3c14bso551400f8f.0
        for <linux-iio@vger.kernel.org>; Mon, 17 Aug 2026 14:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787001102; x=1787605902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2T7LsusGMuIJahe1GygV2/c0EF4vZ4QZqRAMwjrmywg=;
        b=rvLFtsFsVtbqFBPjYjmAwlwUzaNqHCWuajptiHXDMwXPi+AYNLVG3p6W8auNJMWwOK
         ddpN/+UdSY/SCRMKtUXwlWjbcouzk23RapAX/WutOONdKnFZNfuzY/zSFznfuSjf3VVo
         OBCBIOBCiXOT1bNZg2oovieghaAv12Nl3IwU/DoMC3KzERyPV3TEaZQ49XhhoMbSIROZ
         P9XgK/Le56ZDgcEis/pk1msmjrsx9Gz33JOAByFZJotLpEvNkh0zQlG5QwLjtZ/QfcXc
         MItH484yPxC2bLOCGxtMNXevYjSKjDc+FWBHWZClJvbb0e/LQPEiLpei/ImVCQFeLK13
         MD2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787001102; x=1787605902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2T7LsusGMuIJahe1GygV2/c0EF4vZ4QZqRAMwjrmywg=;
        b=HlG+nnddjMl+RKMDc3wv254py/yJ67u/299BZ48kQj4c6hqewfY27pAB93ZlRO1KcI
         LIuMIFyEmUuQqcV2NZHkkaB3lSTbdsgIzRzATOkErSVrkCijG+FhZdQHrtpPn8pgpwUY
         QlhauzVgPIqJtlDwTfbnYK89a1GSWoODbhzjjJn1byrOM0K5dYHzgFfAe+/KMWPU9f3b
         xgcMizMVjl45FxMBh9jJG9LtqW8CYk/cNXl2GrHUn6PFSYkY6lSlsEqsktY7+sMQ1TZZ
         07AruWOLSg4wtrW6DjW0BPT0L4YlXotyuPGSPZ3SAqjfZ4+lKS00YpZ9NtQrgRslGC25
         TEaQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro3u+lQrRD1UnoINgzDxtUfdJ7VWZ9EUqhqECVmwxUQuyhDb3a0UQZhQIEhaXZnSX2WBgq45EgsTsE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3RDOtqwfIEptijqsOBxHvH2o5v2ZplwZzBCpj4mS49pVZ210Y
	4Nv8OoNEyO76UDVDq087Ybjd+Wdfqo4ue6alZErNPSo8tX+LbkQDYbOD
X-Gm-Gg: AR+sD11lXtgfxc0ZhbhsgOVLzoF+kq/JH5YxtOqrmsjJipJ5iFfwj7Np7pwO8hA1Zbx
	TdnsE33gNeOK62cGZxXTOTe2BjT1cn4XIB84oRxy9YcGocl5N9VK9bxXhP3CIzO6CaCJ0Iul7oc
	Yi1B3e/O9dW+VSowBI+bYz+XpqvRTl1cQZxWrIxofTLhcgeCGKV3DO5EYbR/KGUokhX8NwkK3dW
	bb3m73hMBKB/lDAJ9nIlDEQK+uKtOHl5zUCTQYabb6y8HXmo/pNY1h+dH/WN86Sz+1C/wupnRzi
	cPWpBE8mF69pHL1hBKBTltqkFyGvr2iU72yqPZC3t3nhaR6cj3mKHlvb+GPUhb14/45PCBOFgq9
	TlNYEJ0otqs3ITsFNUMqk83dFS5G9frL1nDytckII/EPJ39sRgcXtpRK5VnwCPtP8BfAILYrurv
	nscDUUgcB8vj1I0640326gIJ2oNlhO/6vcW5vCfamlniJNdI0COPnwSssPxtcZQf34GhZgdGlU+
	sJCUP6582nl0eQY5Izq5Zo=
X-Received: by 2002:a05:600c:5494:b0:495:4749:16a7 with SMTP id 5b1f17b1804b1-499879a52aamr446795855e9.14.1787001101858;
        Mon, 17 Aug 2026 14:11:41 -0700 (PDT)
Received: from fedora ([105.74.73.207])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49996176b95sm134587625e9.10.2026.08.17.14.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 14:11:41 -0700 (PDT)
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
Subject: [PATCH v4 6/6] iio: dac: ad5504: support scale via output-range-microvolt property
Date: Mon, 17 Aug 2026 17:11:15 -0400
Message-ID: <20260817211118.21833-7-0rayn.dev@gmail.com>
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

The AD5504/AD5501 output range (0-30V or 0-60V) is determined by the
hardware R_SEL pin and is required to compute IIO_CHAN_INFO_SCALE
correctly. Previously the driver derived this solely from the vcc
regulator's configured voltage, which conflated the supply voltage
with the DAC's actual output range and offered no way to express the
range explicitly in firmware.

Add support for the standard 'output-range-microvolt' device property,
validating that it specifies one of the two supported ranges (0-30V
or 0-60V) and using it to set st->vref_mv directly. When this property
is present, the vcc regulator is only enabled (not read) via
devm_regulator_get_enable(), since the regulator's actual voltage is
no longer the source of truth for the output range.

For backward compatibility with older device trees that predate this
property, fall back to reading the vcc regulator's configured voltage
via devm_regulator_get_enable_read_voltage() when
'output-range-microvolt' is absent.

Use device_property_present() to explicitly distinguish "property
absent" from "property present but malformed", rather than relying on
the -EINVAL return from device_property_read_u32_array() as an
absence sentinel. That return code is ambiguous: it is also returned
when the property exists but the parsed array size does not match the
expected length, which would have silently and incorrectly routed a
malformed property through the legacy regulator-voltage fallback
instead of surfacing a clear validation error.

Signed-off-by: Taha Ed-Dafili <0rayn.dev@gmail.com>
---
 drivers/iio/dac/ad5504.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/dac/ad5504.c b/drivers/iio/dac/ad5504.c
index 546420f9afc0..25c0744545f0 100644
--- a/drivers/iio/dac/ad5504.c
+++ b/drivers/iio/dac/ad5504.c
@@ -15,6 +15,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/property.h>
 #include <linux/regulator/consumer.h>
 #include <linux/spi/spi.h>
 #include <linux/sysfs.h>
@@ -293,6 +294,7 @@ static int ad5504_probe(struct spi_device *spi)
 	struct device *dev = &spi->dev;
 	struct iio_dev *indio_dev;
 	struct ad5504_state *st;
+	u32 range[2];
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
@@ -308,12 +310,30 @@ static int ad5504_probe(struct spi_device *spi)
 	if (ACPI_COMPANION(dev)) {
 		st->vref_mv = AD5504_VA_MV_ACPI_DEFAULT;
 	} else {
-		ret = devm_regulator_get_enable_read_voltage(dev, "vcc");
-		if (ret < 0)
-			return dev_err_probe(dev, ret,
-					     "Failed to get vcc regulator\n");
-
-		st->vref_mv = ret / MILLI;
+		if (device_property_present(dev, "output-range-microvolt")) {
+			ret = device_property_read_u32_array(dev, "output-range-microvolt",
+							     range, ARRAY_SIZE(range));
+			if (ret)
+				return dev_err_probe(dev, ret,
+							"Error parsing output-range-microvolt\n");
+
+			if (range[0] != 0 || (range[1] != 30 * MICRO && range[1] != 60 * MICRO))
+				return dev_err_probe(dev, -EINVAL,
+					"Invalid output-range-microvolt\n");
+
+			st->vref_mv = range[1] / MILLI;
+
+			ret = devm_regulator_get_enable(dev, "vcc");
+			if (ret < 0)
+				return dev_err_probe(dev, ret, "Failed to enable vcc regulator\n");
+		} else {
+			/* Backward compat: old DTs without output-range-microvolt */
+			ret = devm_regulator_get_enable_read_voltage(dev, "vcc");
+			if (ret < 0)
+				return dev_err_probe(dev, ret, "Failed to get vcc regulator\n");
+
+			st->vref_mv = ret / MILLI;
+		}
 	}
 
 	st->spi = spi;
-- 
2.55.0

