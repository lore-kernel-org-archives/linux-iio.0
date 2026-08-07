Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BCA38A70C
	for <linux-iio@vger.kernel.org>; Fri,  7 Aug 2026 13:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786110687; cv=none; b=kMBqbuiRpxO4jHq81fmrcQzEQhsB2BXQjV6LnodrQnXWgXs3AXzXndrZFQuDNaYdHYtS+ms/0YDw8ciPESX0umauwEmXv6UAJ1udT7HEVh8OtNXh0LyckprjeGU4pu3N8VJEiA+dDmKW5bUYt079jOr0lJXcxgF2mV9pFIO3r5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786110687; c=relaxed/simple;
	bh=V2gsJVOsLkWpOZHku+gGdJOheBnQKUwd/SvLka7TZrg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=uFJHksUpC9T7vUml3mNGIXUchVIB44qfrd09VoXgtwszt+BrEqaP/41S1Cndv5YK3neJL00t4Ihkr0AznulWcXs7Rda1Znbw/9Y4y+L54AYYKi6AHAWZk6BNW+UG26vE5dhkAhIbRMHwODMadIhUIX9cj3VersRJ1rbiIYjsoh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o56ofh1s; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o56ofh1s"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47362928f65so2835969f8f.2
        for <linux-iio@vger.kernel.org>; Fri, 07 Aug 2026 06:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786110676; x=1786715476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+0sXOgt8k3ndIy/kW/uba3BvDayq38VbUcMUx/rYOQs=;
        b=o56ofh1sJTUuTSGU1SrjhvurdZ8erhPSlcZFsfFqy9f6geuU6UeoAhneQmuRTDQnX1
         sWKR4/6RaHKD8iepeC5W70dVMK28yrLlpcumiph7PBoN2+4HdMW0KJBBoeiDzOTCeTcy
         Lpx+saGn4yoRZ39pTTleyqXY1oxkisY0bb8gl/zt49Cxqx5SeaOrvPM38aKFuC86Gccz
         /1pxo+7SHew8NGXC4+WvIDsAKxrsbAUkb9D+gD5nqQDxx+E2pt4AQu2tK02KkTB6fdEU
         RZQZdmzzQNY7Kak+2d3bp4LODd+nTBrS4MxWiaEtZtRXT6U5OZVk/NuYjDSN7suVedzy
         LdoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786110676; x=1786715476;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+0sXOgt8k3ndIy/kW/uba3BvDayq38VbUcMUx/rYOQs=;
        b=km68Xcd+9ZmKHoKrnzOnIexCntdeu9ik9xLgHgpFdJEf+T4SeFOkzAsniv6d5etm1v
         TyKRqdjGoNMVFxhK4S3+qSHe2fJgIDTRnm1LiGZV6OHPHJJodfG9l9HIZ5dVfN60UBUM
         0HYIo5Xfnr6binL1EjMmeyAstVmxSCHIWnQs1iBvnsetf13/cItZNa8EuK5nRSLjsnoF
         MCf9yjXnsZDOzw1KJIJAFZQVceRFBCjNbesotpFKLZ8s5JH7mgj6cFOF/zmUT2vG1eo1
         0MyvVEwVO7rqyyyiboaq0jrI0VgvV3MyfBtIzwEyPrU5AZphphvydx1dYtH2h89WQfDK
         h8CA==
X-Forwarded-Encrypted: i=1; AHgh+Rp1+4/QhQxMvPO/ZiLNU7mOpqwKxUvqfeWl87sZZHCQH3h2s3SI50GpmN0okfhFNXwIFlZ+ENcpmFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFjtU7p3xKm6upwbBs3kH/i5iP/XJpXJO8UwMm3xZRi2jb2+On
	ecg1APu+y70cwLNddbRS6TaFguWYRd0+VFuNweMnrFzoay3tZGAyPSCR
X-Gm-Gg: AR+sD13OanYiZJQMXt9JXTY5xQVgG4Mnw5A4R6tqEEWrQUoFeNRsviP806sbIHFjpJN
	3JoGflROTB39y0PEX82VM5REjqEpNmY46EpUohdXH5ewZktKPWqZA/G2hHjJerX3WELHzvF3Sfp
	l6mWYuA0u2O00VHDF517/NjDFB4JuLAyQOg4v1IC8Q/4FtFTXO2/fcIUVm0hLj+CXAt9TTvRLma
	gOcvUwklB0QqKDZDU/gtWWjAaIIT5j86jPthRJcMNTom4cMJ76NrieWnZDVasdsMkdtTBrWUzn+
	1QGY+WCWbrzO8dw5dq8t0r7e6tGJ9qWBXQ0Yj/3laR72svkTevCrqRiD1eEJaikK91GGu2CHnNb
	kwLtSEbjDvpDtFkPWdmAo93DFBA9DykyZY2W6/pB8xybG+ZS7PAx1qyZvbme4kD4H59uyItxFGQ
	4phaWn1OMGrFIEGQIVbvC76akY9Dl2fnXdRas/WnXXkz/jIEBsqSKRWZZ1V7Mal7Nc5TUh
X-Received: by 2002:a5d:6ad0:0:b0:47f:7129:6e2d with SMTP id ffacd0b85a97d-47fec51fcbemr29987756f8f.17.1786110675754;
        Fri, 07 Aug 2026 06:51:15 -0700 (PDT)
Received: from veee-pc ([78.171.143.94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480020be8f3sm5924714f8f.0.2026.08.07.06.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 06:51:15 -0700 (PDT)
From: veeenjoyer24 <danilsirin24@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	veeenjoyer24 <danilsirin24@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: accel: mma8452: add ACPI match table
Date: Fri,  7 Aug 2026 16:51:05 +0300
Message-ID: <20260807135105.2175-1-danilsirin24@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mma8452 driver supports obtaining chip-specific data through
i2c_get_match_data(), but only provides OF and I2C match tables.

On ACPI-based x86 systems, compatible devices such as the MMA8653 are
enumerated via ACPI. Without an ACPI match table, the driver never
binds to those devices.

Add an ACPI match table mapping the supported devices to the existing
chip information structures.

Tested on a Bay Trail tablet exposing an ACPI device with HID
"MMA8653". With this change the driver successfully probes, reads
the expected chip ID (0x5a), and registers an IIO device.

Signed-off-by: veeenjoyer24 <danilsirin24@gmail.com>
---
 drivers/iio/accel/mma8452.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index cefc7cf4b..8cb78e4cf 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -1822,6 +1822,17 @@ static const struct dev_pm_ops mma8452_pm_ops = {
 			   mma8452_runtime_resume, NULL)
 };

+static const struct acpi_device_id mma8452_acpi_id[] = {
+	{ "FXLS8471", (kernel_ulong_t)&mma_chip_info_table[fxls8471] },
+	{ "MMA8451", (kernel_ulong_t)&mma_chip_info_table[mma8451] },
+	{ "MMA8452", (kernel_ulong_t)&mma_chip_info_table[mma8452] },
+	{ "MMA8453", (kernel_ulong_t)&mma_chip_info_table[mma8453] },
+	{ "MMA8652", (kernel_ulong_t)&mma_chip_info_table[mma8652] },
+	{ "MMA8653", (kernel_ulong_t)&mma_chip_info_table[mma8653] },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, mma8452_acpi_id);
+
 static const struct i2c_device_id mma8452_id[] = {
 	{ "fxls8471", (kernel_ulong_t)&mma_chip_info_table[fxls8471] },
 	{ "mma8451", (kernel_ulong_t)&mma_chip_info_table[mma8451] },
@@ -1837,6 +1848,7 @@ static struct i2c_driver mma8452_driver = {
 	.driver = {
 		.name	= "mma8452",
 		.of_match_table = mma8452_dt_ids,
+		.acpi_match_table = mma8452_acpi_id,
 		.pm	= &mma8452_pm_ops,
 	},
 	.probe = mma8452_probe,
--
2.55.0

