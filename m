Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC45733688A
	for <linux-iio@vger.kernel.org>; Fri,  7 Aug 2026 17:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786122908; cv=none; b=scQ+qrrbwk13A0J6A/Gtpo+Ubl3UHZbSVWFFx2dR2jxuhmhrYn1NJ78wwpdsngniSjKwAImY1ka2klg0JhJClxdaGbmYP4IynMagKMTAvZtB7d5GJaPx6yG6iR2Oxsv9fQkP0eQBmFP+QqjX/QAhsbxqq5r99hmLoerzO1XEyHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786122908; c=relaxed/simple;
	bh=u+ltRlQclHoHsgMvRxk6MgKJdNdPDNVBalUsGO10YAQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YIEiz4LLroq2kpu4lUpvQHNdkCklO9FsNLlYwAMsfmXSBc7CYclI0zRjLubfVsUStzRBSMFB3q8TlKvwKgTxPJStz2WLGMckHA/FHkSJ864lXgGc/7K6yFfhTZh4815wc4j55WrPcfHlkiYvKtHJ2ZaKylIKu2wgyHeH9Xzii8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nCtp0Lou; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nCtp0Lou"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49554ebb87dso33245885e9.3
        for <linux-iio@vger.kernel.org>; Fri, 07 Aug 2026 10:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786122905; x=1786727705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8wCGk7YUKAP39MO6sdV3VrjFUc/b97t30OgB7e+3zsM=;
        b=nCtp0LouenRz2Q2NiMrKcfQnGZyZUBc2cNMLpE5QDF+bcqlT54eLLqLevVZTB7LaR7
         Q6Z5vNQObBbIx2IOu8qK3z1L+hCxK3N/tys+PIsXmkkVoxXHyrAeClTFjFWy18ehFUYx
         rWLEj660a72p0RMOe66zHyVr/p7+5YiQavB65sC9cv7m4Fh7+lRdmX8Dc/VQL0eVqyT6
         MojMTo3gz0rJFB4bz29bAsmGXQaD3KFB2xo0zGFEPWstp/Zs7AsRF+7meqpZdASVgR2D
         KcQ7TNhqyIZiYKpX/oi5BUP5uWONepmEcCPdV8dY5PWoGLQv5MMKcEDawtlrlscvm3oB
         djKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786122905; x=1786727705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=8wCGk7YUKAP39MO6sdV3VrjFUc/b97t30OgB7e+3zsM=;
        b=N4qRMNKbZCaS3NtZ3IXeAdzoDw5y5dM9BVUePGHmW5E7l+s1qkHF0pMMlf/pUxF2HX
         KTTP+r0NQ7FJLadTanNwUL9u9WfR2lrWv8upM4/HGJ571Nz7mnp7h7DBQRVoVTzwjhxs
         iuoHGqrOPgUu96sSzxQpwC3vbcxComEbLd1nlxJ0hZ4gGtyT8uXr95VkBaGFxYK7bEQc
         2kzob+yCSSVdB2fOKoTKI8P61Rc0F2WpvavuBmCPsAzSguO3XswJMkN6SmibYLDLS0Ha
         qRT9MpDbrFs0QXwZLQQ0155bB6gFS9s34g8wyq1oSmslW9CmlAglcMhjWNk9+tLgQe9k
         OWGg==
X-Forwarded-Encrypted: i=1; AHgh+Rrz21LOVpgv2pZVzdC7vzEmTIV/W34a1MvW7KE7I1I1fPQIIP8XTRTorZVtNTEFfcT3eYolmuOD9cc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0vwE7wRS3DYFhI0OfswXyBLuPTv+q6a0n6rrh55N/B4KAVYFX
	7gp3EFUp8hzhJ+WnOe3VdBzuYQBLdXIqFF6zI+T4upoLEUZ4Ltjkb0Mv
X-Gm-Gg: AR+sD10JQjI5+vtGYYwob+YNdG9W99LGg4o9EK8EgoDDreY5uAdiOMDZ5NIEi3iN7/g
	ALekmGhk+iqcdquclYjbI15QNw4BKvlnPPzXTwNR98OnqcEcsYFvpOxSpWFtKu1nOHZzEQXsiVg
	tQitDem6U7ZfuOBpz52XLMriOx3X9nqeH3QYV27FqF+SbkufIaZcGOfWRzXuv2GdAkw7e84keM6
	FyQ61sMmxQ68X0U+tluRZsCclYRIEJOO+1wiVl59jCtjs1q0/cABWzaUoUtYprP95j7bKPrLmmb
	8YZ4d4/HhtrQsGwPy3yWmrU312fgjMaURZkld4JnJ0L6j24g3SKBtb8+5SRYqO0CVk2/sY2epom
	QqQ1r2upZtFY1icN6fO32BjE9j1ooU5vYeLngHAGG9mXg6iUc3IKuqhc2sbqW80ejBSB93xcNmB
	5PA2WG6cGLu224NhjArLaQJDXqW3L7T4pfbJDjQe1dowUra3OGXEC/wJ7H7HLBNByN2GcHnKFoV
	CZdNGCY
X-Received: by 2002:a05:600c:1912:b0:495:4d88:e630 with SMTP id 5b1f17b1804b1-499619928f5mr13550175e9.10.1786122904669;
        Fri, 07 Aug 2026 10:15:04 -0700 (PDT)
Received: from veee-pc ([78.171.143.94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995427a244sm160291005e9.10.2026.08.07.10.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 10:15:04 -0700 (PDT)
From: Danil Sirin <danilsirin24@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Danil Sirin <danilsirin24@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] iio: accel: mma8452: add ACPI match table
Date: Fri,  7 Aug 2026 20:13:25 +0300
Message-ID: <20260807171326.1137-1-danilsirin24@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CALoEA-zR7Z75k3uNRD_Swqf7G0+mYmFkPfXTJ5O-mBr6_iu8qA@mail.gmail.com>
References: <CALoEA-zR7Z75k3uNRD_Swqf7G0+mYmFkPfXTJ5O-mBr6_iu8qA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mma8452 driver supports obtaining chip-specific data through
i2c_get_match_data(), but only provides Device Tree and I2C match
tables.

On ACPI-based x86 systems, compatible devices such as the MMA8653 are
enumerated via ACPI, preventing the driver from binding.

Add an ACPI match table mapping the supported devices to the existing
chip information structures.

Tested on a Bay Trail tablet exposing an MMA8653 device via ACPI. With
this change the driver successfully probes, reads the expected chip ID
(0x5a), and registers an IIO device.

Signed-off-by: Danil Sirin <danilsirin24@gmail.com>
---
v2:
- Update Signed-off-by tag with real name

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

