Received: from mail1.manjaro.org (mail1.manjaro.org [142.132.176.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDFD14E2F2;
	Fri, 31 Jul 2026 20:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=142.132.176.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785528221; cv=none; b=UCj4EMs1rBIc5L53xt1kJc5TWT4IphjTIg4dsOCtiHIPbjPHwlBYl+yUunMFWZLtjCN6841tlnJE1YmDyieqh+aH7xc/CEOPxr+byfi/msmQP18HO1i+lNVtwJTBpLPMz2pvJN66dUV5fy7gf0dSBt/OGCQ5gutOCwsHnMQvDPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785528221; c=relaxed/simple;
	bh=YzWZ7lsHD93ObC97V7LYFmdd9Wc11a+KmzMIPSDe6a8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tHyeVEcdx0s0oKNzgqoFHDF33urb3nsya5jmp54ULutVzkMDjM3TerLpV91hFJ2bK/qWQRCCZODh5wIvqHRhgQWr2LXFktwEffzXaWuYiBvyeSDQnWGNFKXYKvBhEb+JgSt7z6/qkks5QEJ2305aEzaM9Yw/81yct/DiXqvhiGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=S/lYezaH; arc=none smtp.client-ip=142.132.176.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="S/lYezaH"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 72FB342B95;
	Fri, 31 Jul 2026 21:53:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=dkim;
	t=1785527615; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=RvZzW8zcPEa5hPGgqOn+m+TYbEMCpj/5Ze42JWdhRDU=;
	b=S/lYezaHBVd+03ErzEOZjMVpvjJoLu4tTjYMdZd/fWOGAjAVfnl0dn0bY/vbAqX6fXsOS8
	votjghzN+4T77jpqAVYRDqQxgHJhbb6ltJX9ig2QbUfgsZcgerc0jyFJika5n/zn/uEl7u
	BDUnBcXAozQ6LrnmLfT9v/Dj54q2mZG4KoqgBCkbavf7OJDF1Zc8Bx8yUCm+karY6eM5NP
	lBGcfwIC+D3Od1BCHSRby5i8D2kjfRGe3EiughADnJmFuOcYVnGeKD/fzVLq7wrrZFeKQX
	WQoyU8Tlh9Tba6lyjZ6wmpbASMtsCTtCYpq2QFZow/AeTmb1DG98SqwRXW3i6g==
From: Philip Mueller <philm@manjaro.org>
To: Thierry Reding <thierry.reding@gmail.com>,
	Alex Lanzano <lanzano.alex@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] iio: imu: bmi270: Match PNP ID found on OrangePi Neo 2026
Date: Fri, 31 Jul 2026 21:53:22 +0200
Message-ID: <20260731195325.44453-2-philm@manjaro.org>
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

OrangePi Neo devices use BMI260 sensors in their hardware.
In older firmware they used "BMI0260" as their ID. In newer firmware
however they switched to "BOSC0260" as their ID for the sensors.
This change is also seen DSDT tables within newer device firmware.

Adding the PNP ID to bmi270 driver will load the driver properly on the device.

Cc: stable@vger.kernel.org # 6.18+
Signed-off-by: Philip Mueller <philm@manjaro.org>
---
 drivers/iio/imu/bmi270/bmi270_i2c.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/imu/bmi270/bmi270_i2c.c b/drivers/iio/imu/bmi270/bmi270_i2c.c
index 7c035e82e6e9..036c6f0f7cd4 100644
--- a/drivers/iio/imu/bmi270/bmi270_i2c.c
+++ b/drivers/iio/imu/bmi270/bmi270_i2c.c
@@ -43,6 +43,8 @@ static const struct acpi_device_id bmi270_acpi_match[] = {
 	{ "BMI0160",  (kernel_ulong_t)&bmi260_chip_info },
 	/* GPD Win Max 2 2023(sincice BIOS v0.40), etc. */
 	{ "BMI0260",  (kernel_ulong_t)&bmi260_chip_info },
+	/* OrangePi Neo 2026 (since BIOS BCPH01_V1.20), etc. */
+	{ "BOSC0260", (kernel_ulong_t)&bmi260_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, bmi270_acpi_match);
-- 
2.55.0

