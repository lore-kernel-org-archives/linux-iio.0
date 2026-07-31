Received: from mail1.manjaro.org (mail1.manjaro.org [142.132.176.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D78374A12;
	Fri, 31 Jul 2026 20:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=142.132.176.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785528114; cv=none; b=K5Rha6013tDH8Ki2s2L2IS7vHacGIjZPxDGc55onlQgfr7gJsbaVbUihviTAdyK7PSEYzrA6LDortLM+BWx5WP0H7yfaDSgGWcnhxC3NzxG3W+MK1NV+yLv+pkPo1p0+ByWIzVL1qiwf+rERjFAb8SzslFMDxNXWiD63wQGwLr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785528114; c=relaxed/simple;
	bh=sE9OrebhMOO30eBmUhikUVcTKKtLT2oYAa1lVIYzPzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QCAmtUk1xpJpdLAOdFt5aiqKO6oOOERNwxP/thSpPPsDV7UVixDExy17P+2NDy89pxDKGJ7e2UiVgrIwkFB67anBiRX3n0f98pZFWYLEmv1N9zxPP2UftzweQ2gam/q6YTiH20GAJAQVH1OdUa/pMGpouBhLOcKbdxf2taHftpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=D7CvMhYw; arc=none smtp.client-ip=142.132.176.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="D7CvMhYw"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5DBA342B98;
	Fri, 31 Jul 2026 21:53:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=dkim;
	t=1785527616; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=y77k9R3NVlJPpC2eIjtZM6oIrTRpTY+r4swdx86bhlU=;
	b=D7CvMhYw9aQYrvxtHluqNJZw3NkyRGxeBHYk1+psRkuWnmXfxj2Eq8ZZ/qh72Sv3s4U1Jk
	7gzfs0hhClnHGYaeFFLvmO6GPgKWL+idacCIAAHFxKpuqtEjcPsZv9NDOmNqFCllitTfH7
	jjlUAjoCSDJCYw2eRT7fY2dJ59G7GKKlYQLjMeiXTIl4OUdIzOChZldcEGbhMDK3KAm85V
	kcEjv7cIKQLjAgljIMf/K11K2FjbJhqY6IJYybZ/fLvw1Go7pgpN8Qsi8Ai/gM3ilt2l3U
	p/E+a7ftA8Edh18l0+gUy5DlH+XVMdzvu+yT/WUiIBaYQFp79C9fqSKeTggeLA==
From: Philip Mueller <philm@manjaro.org>
To: Thierry Reding <thierry.reding@gmail.com>,
	Alex Lanzano <lanzano.alex@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] iio: imu: bmi270: Match PNP ID found on OneXPlayer X1 Pro (AMD)
Date: Fri, 31 Jul 2026 21:53:23 +0200
Message-ID: <20260731195325.44453-3-philm@manjaro.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260731195325.44453-1-philm@manjaro.org>
References: <20260731195325.44453-1-philm@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The OneXPlayer X1 Pro (AMD) uses 10EC5280 rather than BMI0260 or BOSC0260 as PNP ID.
Adding the ID will enable the BMI260 accelerometer on the device using the bmi270 driver.

Closes: https://github.com/ublue-os/bazzite/issues/4805
Cc: stable@vger.kernel.org # 6.18+
Signed-off-by: Philip Mueller <philm@manjaro.org>
---
 drivers/iio/imu/bmi270/bmi270_i2c.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/imu/bmi270/bmi270_i2c.c b/drivers/iio/imu/bmi270/bmi270_i2c.c
index 036c6f0f7cd4..d7faebcbd2fa 100644
--- a/drivers/iio/imu/bmi270/bmi270_i2c.c
+++ b/drivers/iio/imu/bmi270/bmi270_i2c.c
@@ -45,6 +45,8 @@ static const struct acpi_device_id bmi270_acpi_match[] = {
 	{ "BMI0260",  (kernel_ulong_t)&bmi260_chip_info },
 	/* OrangePi Neo 2026 (since BIOS BCPH01_V1.20), etc. */
 	{ "BOSC0260", (kernel_ulong_t)&bmi260_chip_info },
+	/* OneXPlayer X1 Pro (AMD), etc. */
+	{ "10EC5280", (kernel_ulong_t)&bmi260_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, bmi270_acpi_match);
-- 
2.55.0

