Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726C24D90B7
	for <linux-iio@vger.kernel.org>; Fri, 16 Oct 2026 15:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792164953; cv=none; b=a699QQ8qtzq0W1h9td2lmfmZ+BGGaUPyxj6xfVWoS3pjK1j0KASMDDXXIqhWJ3VTA9P+jvBlEJrfnPxvKsKbakbQjjefblf8gjU9WKPbLdM4BkdwsMmJQSc1aRRWhr6IWimEG0pqZF/+QXaVWVD42JsQ0QCJDotLr+YGs2dPPwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792164953; c=relaxed/simple;
	bh=gAjWw6G9lcSq8Zo8mxFK1qqxGDdtLdmuHsxWpOlc32g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RkIam2/lR+yuYWEeaoNNFY1X+rm2pLrm/0exRTWoWjgIwc9krT85H2AsU71tCj/biTxHiC9X0hzJHA41aGpiQmfucEs0E+v/3xxRROIfjGiGMzaIyupoW7Z0e7AGUUZ5n/B4uCecxYH0LIadBoQ9SHfT3LlBTRN4pv9dBPm+ddM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P3uHZ00k; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P3uHZ00k"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c34bff61551so3789366b.2
        for <linux-iio@vger.kernel.org>; Fri, 16 Oct 2026 08:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792164943; x=1792769743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=56A80MSXyfRwi9kKSqYlXnDxAngt+h6Mj8IZY9vejNc=;
        b=P3uHZ00kIJz4Z5/zDJs46jIzzLseL00bjw7L/uWX552j6qLwegbw0QhS0TVYFflyQ7
         ZvYLvtkBv4eZvZcimQoaLDVkpxxSO2kK8pDbWygxo+SlnfhAcc3f5R8RsZPojfFrDUdm
         T5oL9xa83iPgZ5equUVjbs67774yHbq2UAPh9o6Ir4kMvLAnF6LKRzI6Aq1O6Ktt7x0T
         Phrh8h4b0s0SbZejmLkStQoRTh1Rppziiw3yhhxxUq+pZq48P/F6cBcJMdgk26Dav/Vx
         A/uWTwJ8lC0WB9cN3pe0YOcX8zyZZQMW95dUWajt86lm4RljQb7kSHFu+/EqsPz53KHI
         lxEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792164943; x=1792769743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=56A80MSXyfRwi9kKSqYlXnDxAngt+h6Mj8IZY9vejNc=;
        b=InytuO7cF7dNsbOQ5F0UGyThwe0pDMEcwVG0WvopjL4qKcrBWl1bVh+5bMm2luNe0o
         WQE1z7CpQmtuNEr6hB29SgaUoLtIPGFPm4H3GhIcK48m2UYjF1JpDWwdPLJWwPefO3al
         czEjbBM6jIovAEP7RDtVwZDbUnJmeYAxUcIe0wWVv5nbSsyivspqB8F6URvHw2j+xQCp
         9hxG01tyTTWHwKtptnO1dXKMe3VJuBwsg0bRfpX/C19HBDqNbwUK8n3NCqkrRozaor23
         xsEsyY1RjRD2n8hg3lcCAUYaAavDJMqZ8iXcVG90hEtLeJlBn3Ybq8MqDVdSfWI7nsb/
         rGBg==
X-Forwarded-Encrypted: i=1; AKwUvByzAVJwXxGp/U8IPWsgwsy5jDmFdZPd63IPDUJdvWBUAX6IL66nE6TVR+r1ejwH6qkgwiBbE+gTdew=@vger.kernel.org
X-Gm-Message-State: AFq9FYKjucWPOjblqeBz3jFUvdavUrk0+XsP0K3fIOKWme6JE003Me4e
	WimLEl5eVmvhqIAKNya11Za+YsSb/Na42eXr+SwfTOpPVkKPqjP2Lwbw
X-Gm-Gg: AYBFou3D2mPyziUQ3LcyMbSzD2smBRwodAyyoL0rPlHYYCGyRXKBSZkU+dkbHsfWNeX
	8tB009UdxzNVnWcgw3L6mKFqPmpE6TNNpqWVEMLmhcHTteO4P1sW3La2TfpA7nyBtUeZBx+CsDz
	aa2OmTrPIgCM3ayGqFlYCl9Gc12CSnwd2hKbBhc/0TR8ZLKkJTzlDGosXePbo3L/Q1NCfolhv7K
	6OSA8qdsXyyuevm9JO9uf6pbdWIlxIhtufDEC5atOBMkknMKb18yPS8TDYz676kk+qKVq0lu6hQ
	TJtuF9yB+L5JlW4usTSjOOpajeD/wLhi8fbyomLFXk7YZUQK0H6rrIRA7LE5HwBs8zCzFhqTPFF
	Mx1juVrJ/jh0zNHHEsvtXegvq/LmOe0jsMAT8ZW34Tg63k4S1AFdYYVk6fu0jgi9m8xRwS0BQKL
	X1/w5/lhlRJ2G3Zj1Smy3HafO/yCUJShuR5uh0p7hvSVfj9gwDRKewwSkCZ8H63IU3CzT1UkNf3
	uFzLOLURdVCGFqWv+UvDvUnkr6dI34hSuR33UEJDASL+bndVLH82na9yHwYEi90v6OAwkMTMSse
	/ye+vwwW+vmft3ws0OqruNyLr5M=
X-Received: by 2002:a17:906:9c96:b0:c2d:c739:30e0 with SMTP id a640c23a62f3a-c419f707becmr11778566b.38.1792164943313;
        Fri, 16 Oct 2026 08:35:43 -0700 (PDT)
Received: from M-K2012N0113010.localdomain ([88.119.128.229])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b38a1b113dsm999067a12.10.2026.10.16.08.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 08:35:42 -0700 (PDT)
From: Paulius Zaleckas <paulius.zaleckas@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: Eddie James <eajames@linux.ibm.com>,
	Joel Stanley <joel@jms.id.au>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rupesh Majhi <zoone.rupert@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paulius Zaleckas <paulius.zaleckas@gmail.com>
Subject: [PATCH v4 4/5] iio: pressure: dps310: add an OF match table
Date: Fri, 16 Oct 2026 18:35:32 +0300
Message-ID: <20261016153533.3701000-5-paulius.zaleckas@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261016153533.3701000-1-paulius.zaleckas@gmail.com>
References: <20261016153533.3701000-1-paulius.zaleckas@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Devicetree nodes match the driver only through the I2C ID table fallback.
Add an OF match table, so the chip data comes from the compatible and the
module autoloads from the of: modalias the I2C core reports for
devicetree devices.

Assisted-by: LLM
Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Paulius Zaleckas <paulius.zaleckas@gmail.com>
---
 drivers/iio/pressure/dps310.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index f2a8698e1e30..d0a2f6c6ec48 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -1043,6 +1043,12 @@ static const struct i2c_device_id dps310_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, dps310_id);
 
+static const struct of_device_id dps310_of_match[] = {
+	{ .compatible = "infineon,dps310", .data = &dps310_chip_info },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, dps310_of_match);
+
 static const struct acpi_device_id dps310_acpi_match[] = {
 	{ .id = "IFX3100", .driver_data = (kernel_ulong_t)&dps310_chip_info },
 	{ }
@@ -1052,6 +1058,7 @@ MODULE_DEVICE_TABLE(acpi, dps310_acpi_match);
 static struct i2c_driver dps310_driver = {
 	.driver = {
 		.name = DPS310_DEV_NAME,
+		.of_match_table = dps310_of_match,
 		.acpi_match_table = dps310_acpi_match,
 	},
 	.probe = dps310_probe,
-- 
2.55.0

