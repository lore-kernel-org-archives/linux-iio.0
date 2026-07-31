Received: from mail1.manjaro.org (mail1.manjaro.org [142.132.176.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E2D374A1D;
	Fri, 31 Jul 2026 20:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=142.132.176.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785528113; cv=none; b=AJF0qzc9cqCKBy3m13Id7TExj9lRWc2ffSbCPm2DdmTP+Im/FCti+X7CvHDKDVDxj9ITAaix7ke/+tLhlHTUZo1ww87yGxTEsvJeq69dKshtzd0kqhti3uUFMDqhRIQSjMf/3c5J+nwyqKiVmwvzouHReNujDRfScOsVUeAQ/9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785528113; c=relaxed/simple;
	bh=DRwJi3QuEoOsFXDXmBO3Lmvav4hr2ee/qwr+mA61dCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h0LPGmag81ECUbksqvLHaBT6yJxytgkMT/JWzGZyWdx/ek7TTSGECGBvzVXfKwgJg+wiHHjxogu//uhnPE7UKRgxjuyZ5tjeeQEvet9pmXvK8fqmdao/9XzUkx/3KIwQeizaJ25tyws7ktfP7i3tHS4oWXXsJ0QXdCj2Qfu9o0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=O2pZbayj; arc=none smtp.client-ip=142.132.176.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="O2pZbayj"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0E55242B99;
	Fri, 31 Jul 2026 21:53:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=dkim;
	t=1785527617; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=XK5Rq+P9xXei9sWBIqRl5WOHAYU2IMZ+1LN9Bvx59g4=;
	b=O2pZbayjZ27FkjgXQX1ueAaI2FiRbtY5Dvs33ebwny1WU9p+ypSydr35Arm9oq81uRwMVj
	v3aCGHTfjUU1CB+melGiUaEiIhWzx7bC8aOP6KJKr2CGZKBw/xtamscT80jD3x8uAm9AxL
	t9wG0KkZFuyYnhhxDU7LYVmN/D9ga4a9TNUkhI8aZwYdpmOIjH+BdiXRfEwecvksX2enRx
	KTEVjFp83482XH6P6IXXT9sCb+qiStVdHPn6wTC50l25NJtfwRr1XMlVXypmye3xnrCe34
	s7jgpceLD+QLTzGdpD1/XMSOksRUMTPqyjpjtj2ne80gjlPCtcn1mFHZstB83A==
From: Philip Mueller <philm@manjaro.org>
To: Thierry Reding <thierry.reding@gmail.com>,
	Alex Lanzano <lanzano.alex@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] iio: imu: bmi270: add BOSC0160 PNP ID for gaming handhelds
Date: Fri, 31 Jul 2026 21:53:24 +0200
Message-ID: <20260731195325.44453-4-philm@manjaro.org>
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

Adding BOSC0160 as PNP ID will enable more gaming
handhelds using a BMI260 sensor with this PNP ID
to properly use the bmi270 driver.

Cc: stable@vger.kernel.org # 6.18+
Signed-off-by: Philip Mueller <philm@manjaro.org>
---
 drivers/iio/imu/bmi270/bmi270_i2c.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/imu/bmi270/bmi270_i2c.c b/drivers/iio/imu/bmi270/bmi270_i2c.c
index d7faebcbd2fa..839e71b65f05 100644
--- a/drivers/iio/imu/bmi270/bmi270_i2c.c
+++ b/drivers/iio/imu/bmi270/bmi270_i2c.c
@@ -41,6 +41,7 @@ MODULE_DEVICE_TABLE(i2c, bmi270_i2c_id);
 static const struct acpi_device_id bmi270_acpi_match[] = {
 	/* GPD Win Mini, Aya Neo AIR Pro, OXP Mini Pro, etc. */
 	{ "BMI0160",  (kernel_ulong_t)&bmi260_chip_info },
+	{ "BOSC0160", (kernel_ulong_t)&bmi260_chip_info },
 	/* GPD Win Max 2 2023(sincice BIOS v0.40), etc. */
 	{ "BMI0260",  (kernel_ulong_t)&bmi260_chip_info },
 	/* OrangePi Neo 2026 (since BIOS BCPH01_V1.20), etc. */
-- 
2.55.0

