Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756082DA750
	for <linux-iio@vger.kernel.org>; Sun,  1 Feb 2026 22:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769986525; cv=none; b=ZQ16PnchmryD6CyIFfH1Grk1uoV0Soj0U3Vsl2n3aiME6gD58RutIbjpyL7gTsOUVO5wwf5gKt2+vqWnLA9pxNTkXb5qeJgvpzLDqhEC9qyJ9LHyEZtZypN/hJ+Z5m0pFEZgoTuJnI31truYWRmBnK4PhrSyn9knv3sjRFrDRYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769986525; c=relaxed/simple;
	bh=2uBGwyPKg09Xl1QrADRzV51xy4gZyTiCD6K2R5tfW6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X+80adhccMDr7PlN0PVtExPjo8bCE6+mY28QAeej0i3IVnf4bBwXVzpy4kpZ4507ba1c9HqEkXgnWCZpJ6zyvclgDmXXZzIo8ie0csMxaU93AvvlmSiTUY3P3hsxpj3RfXvdQA0est9DoXN8+2xXGNSe9Q8SA52BcadRrsM7lwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dionne-riel.com; spf=pass smtp.mailfrom=dionne-riel.com; dkim=pass (2048-bit key) header.d=dionne-riel-com.20230601.gappssmtp.com header.i=@dionne-riel-com.20230601.gappssmtp.com header.b=RNy8yCNZ; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dionne-riel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dionne-riel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dionne-riel-com.20230601.gappssmtp.com header.i=@dionne-riel-com.20230601.gappssmtp.com header.b="RNy8yCNZ"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-88fca7bce90so50316106d6.3
        for <linux-iio@vger.kernel.org>; Sun, 01 Feb 2026 14:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dionne-riel-com.20230601.gappssmtp.com; s=20230601; t=1769986523; x=1770591323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lLL9EDoklYU6EWGrSqPTm/RhT8uawPhepLIaInnkA7Y=;
        b=RNy8yCNZNqAADPOyTL/3RYgMBQQDouF8AI7WFsQUJy4EA/Z9LtfVnljbs3/I921fcU
         PvHPwc/l63m3iKqgqFSyXYNFgyvPilZlJ5/scz3Ff3m4nYU04eBHaPXsAGvgPNXMvYq+
         9znNTWPU4aUQS1WV4yDUNB8Un55RxtL3IDVayrRYcWaVfa3C1hwn9UCve2tVnijM6KzV
         H3RT2Yh86vQYkKlhF7ZVhvhcDIAbtIt9ER4SM47dnskmPRjFQiNSRlSddfHDhu50d3vr
         KO0aKjq63QeLapauOGafAxEHLGYiU8A1+hz/0sMqdmMHK4p/8+nhnYPDd/TeUqAf/Aoy
         hIrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769986523; x=1770591323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lLL9EDoklYU6EWGrSqPTm/RhT8uawPhepLIaInnkA7Y=;
        b=GtYbv9qOhimF4TaI8gqCmvcinIrHN/l61HVWpVfh1qBP4hO4Aqh5i0UUQJK2y3V6Jn
         2A1P44I8s7DnSYT1Xr6pLZHD71tcOoOQlz+ap1v+u4iK3swhrqLCtdXIgtFxTSpiYe5i
         D01q1tYiA1bHyhjjWS4xVeYMkUPyhgthmbFZXsPbzyjuxak7G4WVcO2rRLh3RU/UdNfh
         PXcIDmGP8Qc8E2Q4FvSCfmvrX8T3NvO0bUF+lJar3qWs7HdfJg/0aRJBs+PDeTW/yHSX
         B63qSz3jd/R9zCFpmYPHwNx71rARl86z3yCU1tnEfrm+qngCERHYqYiLzgGKdsXyAcoe
         5kWA==
X-Forwarded-Encrypted: i=1; AJvYcCUHj81RXkf4bMDIrX/h8NdlJzwu1Hf1ZbrGLGEspggSTTWHcl7u+ugsWQJCcJAYujJ/tdX8E9XJBiU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2KVmYIX/OpjlaTMxWfxD80U4N5Y3AlBcaxb5dSmpavelri+Js
	wmu+whT2pIR8KjSPczgMSenKMa/zHLDkFw9qy5E0Peouo+kPV8e2DTu7iEAR7gfnug==
X-Gm-Gg: AZuq6aLlUgqVd4YavQJuI1isL0pvg6y1xFp/ETaBxNon6RoVBuwNz60f3NKa6SlEY4I
	X8v/mMRsYfIDWJ6LO/X8ke9EvwWDEBIkSardaSoNLp7o+h9FtIWJi+Ag93P8sdKAtaLDG4GqbU7
	0k/aEWoFOWEeynJ9IprEPmk2PvNsuS6A9V71iQGN2qbPfhfSJbeOLDvNulrcE2Ap9lOGolVzRLM
	+1Me/nB0j/ZLCH9sjZ6FRqRKJbTD7JQDu8k802nBkiUPiR5SUD5Egr+IYDUWgEf0lZpn675mknL
	sV4L0daU5uVo6hy5KAfZKcWKOrlCjp6dzwUGTugwnPmzAXRaFoR3uqm+Y8p/yKtvjOQZ07xy7xN
	Y76fW80LmpaVI8UWha9L1OhmKoHnW8LFdOkFS/rTPLBzjdvMhR10eRuT30ePL14QHZzOsRsNkEF
	+/MAk4rpsovSYS5u8KGVT171/XJozN6mr/xkYNeJPvRMKR1czHIXtc/uoiYGTmcW2W+3Gu556BT
	POZ
X-Received: by 2002:ad4:4b6d:0:b0:895:829:48a1 with SMTP id 6a1803df08f44-8950829582fmr27286566d6.43.1769986523463;
        Sun, 01 Feb 2026 14:55:23 -0800 (PST)
Received: from frankgrimes.elk-nominal.ts.net (135-23-195-66.cpe.pppoe.ca. [135.23.195.66])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d375ce71sm102146966d6.45.2026.02.01.14.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 14:55:23 -0800 (PST)
From: Samuel Dionne-Riel <samuel@dionne-riel.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Samuel Dionne-Riel <samuel@dionne-riel.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] iio: imu: lsm6dsx: Support SMOCF05 ACPI ID for LSM6DS3TR-C
Date: Sun,  1 Feb 2026 17:54:49 -0500
Message-ID: <20260201225450.1649001-3-samuel@dionne-riel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260201225450.1649001-2-samuel@dionne-riel.com>
References: <20260201225450.1649001-2-samuel@dionne-riel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Same device (LSM6DS3TR-C), different integration with the firmware.

The integration differs in that the firmware provides the SLA0 and SLG0
mounting matrices. They are assumed to be Accelerometer and Gyroscope.

Observations were made against the Windows driver, version
`12/06/2023,1.0.4.3`. This driver supports both identifiers, but expose
the device in different ways.

Signed-off-by: Samuel Dionne-Riel <samuel@dionne-riel.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
index 7c933218036b8..10002f05b45f5 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
@@ -143,7 +143,8 @@ static const struct of_device_id st_lsm6dsx_i2c_of_match[] = {
 MODULE_DEVICE_TABLE(of, st_lsm6dsx_i2c_of_match);
 
 static const struct acpi_device_id st_lsm6dsx_i2c_acpi_match[] = {
-	{ "SMO8B30", ST_LSM6DS3TRC_ID, },
+	{ "SMO8B30", ST_LSM6DS3TRC_ID },
+	{ "SMOCF05", ST_LSM6DS3TRC_ID },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, st_lsm6dsx_i2c_acpi_match);
-- 
2.51.0

