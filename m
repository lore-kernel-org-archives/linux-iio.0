Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE5C283FEF
	for <linux-iio@vger.kernel.org>; Tue, 24 Mar 2026 19:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774381136; cv=none; b=Oiq8z5Iddr/sekH8hepBfNujKsN5rpIKMh+pm7m6NIq2l/owuy1wuwHrFO3ko9BG1p9JqDym8KMVwJRQ9wMIrkFIbSKbiPCa/fZCf9WJxY8/EUWB5K+QktQiu3EhvRscX4tgMmebDeNcHGdO74fEObJoGmJt8FTM5vb8otJd8rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774381136; c=relaxed/simple;
	bh=cscqrZnzpkMAgjJVuIb9Y9gEYIIdtCV+T1lp5zPSGnE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UUxnmjgPdYJWZbIDaDhMd35QFJAaRONWyToBL1icNct4s07Ch9CpiBUIm//ZdmVPdS7bgdHFHzhbyl1J/DAVsw3rZwDH3GjLG5cjSWH9/2hf1wO/fz6WHu5uPyPUTAcX8KV7CFwR/9gUus+x5oc+74OcLGLe8dEGn2uaOkFX/xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O8RttVaS; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O8RttVaS"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-486b9675d36so47398625e9.0
        for <linux-iio@vger.kernel.org>; Tue, 24 Mar 2026 12:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774381133; x=1774985933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nLg9qfVDz+TYTt33jHtLD4fAgojMn/cehyZVkxLC8is=;
        b=O8RttVaSjxOjIcAe741QxE/aP6X/SbSmwZW5+aq5fLMe2mRoBJTGNq5HboHkDSIGX8
         Bki2cnx+X4Rhiukp4+WnGgtAG1XpeBQX6BAnBmgC9GzTxTCTJi0YYJSat7K/F3n+vvVA
         EwftNIoLzOuQzc2oaHDb5h4/YYziuqz4LReBjJh6Bx6didtYZmrTcoAd9ww5JbLJSekg
         Ft+aCIMDNplM3HrUXOSGCvm8IcAwdC8XACE4stlWGo0KhpMNxWjLNkizvBS56wmNM9TB
         KdNelDW341kDPRtXPhlntaouZK5Mv67PZAOyX2vxArWvWVfsmQ6exuuYMBXMWqTRUvMr
         +1rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774381133; x=1774985933;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nLg9qfVDz+TYTt33jHtLD4fAgojMn/cehyZVkxLC8is=;
        b=QIt88VwULIvULAJ5W7Bm2KCnhkwmTlJP7541RpQfET2sU55gkjH4BdL/JqoXWPyIVG
         vOIG0EQlTLQErCUxn2S+uURZgbROmkS1wr44wQoS7R4bqH4ZQZqKjN0f/nHCB9IZqOkt
         RCaT3XTICJI3RDGAivnCDifu7Ssp8o3oTTe/fALXN5DE+Kjth5KgnMAQiHXOoAS0+Ix+
         WblDVhYPuRq7XXW9zwkNRo5k2FonO1ejbb/HvtQCdKEMJ04P1kxLdOGBF5rCVG+QwugN
         EqTbCiBJi007DNJW/W7jiperJJc/KMC6gdHhvRbJcReKI2ILhuPW9ZtxSyQSfKSVMtss
         nFjg==
X-Gm-Message-State: AOJu0Yzi41jQDZhhBfizabhSVW6mQa0bfHHnTItJa1A9LVpWfUbwv3eQ
	zv+rV+qEZ0VSduxfPgpLXQgjy3I8bC6g88HHok5Cu5Lg0LReZCdQWPqkvoGkBR4r4Ig=
X-Gm-Gg: ATEYQzy+nJ1jOVlJMvpsmNrT+bFAz6r52O7d/xGVYETZ/rbXASHrAAKEj2ogdeHfwOp
	wfj/KiUFrHfMjRxQk7futPxmYyUvwSzM+/EQwHzC1j89OMQ/X0UHUsfCm9qKX6Om59PAxjCbFZ4
	INh5MyGSMUinJQW2nrqOWUpLUE6aXgb2iLmNtLg4Zlbpt7vsdV7uC3ZuDJSaB6YeM/tGlu+gGzX
	VejgkX+ebRtb7y+SfPptStAQh/IiSaVcWNLAVDvUVjdXFkBTSm3Wx2BPctfXtyMZah4+OJTKGAu
	1dMHTRDEOTgy6Rm3CVN26lgOho/AdNO71TcZFQ1q8Dz8yQ0MUM5zhRM1uzzgGmjPgq9U0vKJvNn
	yesK+zTbsFQUXdOi824FMzbvqvpPiXRKoyllQNeNtGxPcgrf7IkuBA78hu+tnpWZS3+mauJ/zCT
	N1CUljzJEgVUl/qt7etg==
X-Received: by 2002:a05:600c:1d0e:b0:485:3ec6:e634 with SMTP id 5b1f17b1804b1-48715febda2mr14974115e9.15.1774381132881;
        Tue, 24 Mar 2026 12:38:52 -0700 (PDT)
Received: from archlinux ([2a00:10:8f5a:ad01:2e5d:326:c17f:af98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4871174f2desm92176815e9.9.2026.03.24.12.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 12:38:52 -0700 (PDT)
From: Milan Misic <twoexem@gmail.com>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: lorenzo@kernel.org,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	Milan Misic <twoexem@gmail.com>
Subject: [PATCH] iio: imu: st_lsm6dsx: Add ACPI ID for SHIFT13mi gyroscope
Date: Tue, 24 Mar 2026 20:36:26 +0100
Message-ID: <20260324193626.77231-1-twoexem@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SHIFT13mi or SHIFTbook tablet device by the German manufacturer
SHIFT contains an STM LSM6DSO IMU declared in the DSDT with the
hardware ID SMOCF00. Add this ID to the ACPI match table so that the
driver binds correctly to this device.

WHO_AM_I register returns 0x6c, confirming LSM6DSO.

Signed-off-by: Milan Misic <twoexem@gmail.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
index 7c9332180..b2a7c2eaf 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
@@ -144,6 +144,7 @@ MODULE_DEVICE_TABLE(of, st_lsm6dsx_i2c_of_match);
 
 static const struct acpi_device_id st_lsm6dsx_i2c_acpi_match[] = {
 	{ "SMO8B30", ST_LSM6DS3TRC_ID, },
+	{ "SMOCF00", ST_LSM6DSO_ID, },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, st_lsm6dsx_i2c_acpi_match);
-- 
2.53.0

