Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE64A50EC02
	for <linux-iio@vger.kernel.org>; Thu, 15 Oct 2026 10:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792061400; cv=none; b=Hfr/DTJ8o/TIPKSaMA1px5bClzvCRT0YvYIO/b1VyEP4kl4OABFMwS6FOg6SJkwKY9kmIIkX1qkPSdVgxsceK3NlhFW6kkoE+hJ7k0I2Tqc4jKWJHnYG/FMAJ/o3MPr03pfrVj8HwWpDEXLLCW/44YZVMCjcAsTAjZ4qPNX+E58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792061400; c=relaxed/simple;
	bh=BXh2KC/D7GXQthn8khp/oBYxkxEzogKXXCzUOL6Vc7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Db2FqRsX8f1lybWGWWsSXlTUy4K6YkjryXQdD2kAzYe2ex/3dyWAy9Z7QPcwJ4XRR6vx9xZGMb2DEvU2Ii6pbgtv2IT0nRjNX8So3i/1I96UEfcnE0dA2qIkxHJk/578mINqBdXuXczgAjiX2VnuPZG9WE8JeqkMt8v6it0UX/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JXrAqUqy; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JXrAqUqy"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c37b612635bso296728166b.3
        for <linux-iio@vger.kernel.org>; Thu, 15 Oct 2026 03:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792061395; x=1792666195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I9TQ/rDTWNb6jj0ZIezmBlxAzwTLhuF2EhGxHk6EpcU=;
        b=JXrAqUqy1dylQTC1FPsS0DwIvjLMCSQJWX9dLQcWGybNMxF235tV0wd0DSDBCWEe47
         cbrVKvfNfdjyu4deDSJ9JPTP7BSXnUj141du4UOhUtKcBV8oy3ZzbguOeE6ZLPVV9t83
         CqDSFaJy8Ple5zFEUN916qXYl6S40Wy5WUylYMtTOS1qnoFDYvUvoDnbyBGMDsJ5j196
         IuN/DfJn8FvQfrAkHs0frTwOAuu20EExr1Qav1/Mp6rEqfWocb5T6BRIDfbxkPgdEA0t
         dYBlmFuvrTc/P71Bp+1Sp5GExU4jN/VpFv4Iw0NPf6V+zuC//XT5W83Nx0ILIoAiZ7PR
         tSGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792061395; x=1792666195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=I9TQ/rDTWNb6jj0ZIezmBlxAzwTLhuF2EhGxHk6EpcU=;
        b=etNK9h4trutUzI3UwDSCXaMoJdm0XioYkdEyu5PFfU8gpdAv0dKvPLJ+Auxm91CR7b
         cFCQjR2BmL2NwaqqEDljioYG8v6DVRsx16s5UBjWMAQsAL1xpYcDOO1WSSokX2IKrZv0
         T/C3IQpRJcDZf9dSx7QfytPG8u++K8q3OmFkMorHZXmh9uIjCMjKIJEa/Q2surz1wc76
         xYLFTYOnONB8VJ3R1lnl0lxqzA1+uVU06L4y0ebV+lpFc3Lr6fmBoo/ncSvynlwB4AoY
         UCkEmRcSjvlxLetZ0iEGsEQwkkDJLLe4eb0XwbqPLj3NsvnvzlQHp9+YQifz/7ujLF1A
         9Kdg==
X-Forwarded-Encrypted: i=1; AKwUvBxgEG0l9qlOkfmFW6W6Uoefzkqokifr0G2Mejc5FETL16LS1fljd74J+OD1pdJ6hxA2nSNZyrQw1s0=@vger.kernel.org
X-Gm-Message-State: AFq9FYLb2XvatjI/7gTy3QDdzzg7pkL0HxyIwyqjn6zbwNjIXA15wKs/
	PJ06ef9IxaopGQNOSNLxF7oTKF0k2qobRJiZTMzA0GJQNyueXmT8cwLOVbDYkV/9
X-Gm-Gg: AYBFou16vh1LOUNSlH/lP0K59mI8Hsp2gxRvxbGEg9t3WPwFZJ0WZ9epadpWFqMNkjy
	KYN1jnE6r1BloCZCaRttQ5rzAITLG4Jt31dAwoJigjBFT2QUUBg0oc8Xs0lgcVeU+kpEyE23Ruq
	Yxnfy5hxgfWYkze8xTZV1or7YHqsfx68qx5+ag9V2VZC/slZOLOZlw1rlMGwRZ97amSlj84GHKV
	iEAzd8veV2OHOos8Mw1pUjnKg+Qg7Dgz5mY+KG7fadUree9T4l6dUuovvnrqHzdCUx+bMRepMZN
	ZWAj9OQKaEMUt7kkHwQxJheGAZGUOVR/2WKDY2u7gb/DmSt4gQpFeSser6tM7ZPc449E5kcJw3e
	G1jdvAQkTRAJf332LtE/4paRwYctWOZ9Ubj25t/ugFgsz6icLJ2HpsFoTKOKa5V3ElZJzbdVgFc
	ADMjoTOo7J6D9qHrAVgEfNGS3xOi7YUybDDJwH7bSRUsA+Iwefh8YTEZfxIVFCmFnIGV3VDP3eA
	PpotR3pmDg2MvgL66tOGFeu7fqOeFRQwrQuSnPWfQdyE/ssMiBgPcKbcmyVYLYcW6gmmybQV+u9
	cXDuffiMlD2wPKLOZgSc1r0T/bc=
X-Received: by 2002:a17:907:2d21:b0:c2b:7686:4d7 with SMTP id a640c23a62f3a-c31a9ff6976mr1704835366b.39.1792061394794;
        Thu, 15 Oct 2026 03:49:54 -0700 (PDT)
Received: from M-K2012N0113010.localdomain ([88.119.128.229])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c3ed9b3af45sm107890066b.33.2026.10.15.03.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 03:49:54 -0700 (PDT)
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
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rupesh Majhi <zoone.rupert@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paulius Zaleckas <paulius.zaleckas@gmail.com>
Subject: [PATCH v3 4/5] iio: pressure: dps310: add an OF match table
Date: Thu, 15 Oct 2026 13:49:44 +0300
Message-ID: <20261015104945.2687162-5-paulius.zaleckas@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261015104945.2687162-1-paulius.zaleckas@gmail.com>
References: <20261015104945.2687162-1-paulius.zaleckas@gmail.com>
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
Signed-off-by: Paulius Zaleckas <paulius.zaleckas@gmail.com>
---
 drivers/iio/pressure/dps310.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index aa80d106ac44..ad3860d11592 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -1042,6 +1042,12 @@ static const struct i2c_device_id dps310_id[] = {
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
@@ -1051,6 +1057,7 @@ MODULE_DEVICE_TABLE(acpi, dps310_acpi_match);
 static struct i2c_driver dps310_driver = {
 	.driver = {
 		.name = DPS310_DEV_NAME,
+		.of_match_table = dps310_of_match,
 		.acpi_match_table = dps310_acpi_match,
 	},
 	.probe = dps310_probe,
-- 
2.55.0

