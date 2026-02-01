Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9EA2EFD9C
	for <linux-iio@vger.kernel.org>; Sun,  1 Feb 2026 22:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769986527; cv=none; b=YeSh+mRLB+i2u3u3bE/YpHonhxic6hg30HpMdvxkgx1k/C5rdrHWoEwjimwufB7kHHz+ljYeyGEjFDsjVhW+gE/iur4w0dZdYMIF4vOE7GUchUP8Os13VGEMRYal4k47dHQhmIEwr0gpQGoxBj6Rxi96j7JezgdROnqqohevbJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769986527; c=relaxed/simple;
	bh=wdAJSmDdkevTQvrbvEGoNggrcxZj8jV531QeQgd3CBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZCw0xAsLujTo0MNVKHv+CZ3v+7dQ3mJwUBuQ+KGKvr9yehuYHnEMusEJOUpFaAHYjEpQ0QD7XCD04Pja8uFCX1qqH5/N49HbuiHGr3657iNu3uXRG9IJRs5myVRw/FY4Wp1ysGsWBakvhT3PJlt1IP+ICa8wnQwVUP54pQBAzbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dionne-riel.com; spf=pass smtp.mailfrom=dionne-riel.com; dkim=pass (2048-bit key) header.d=dionne-riel-com.20230601.gappssmtp.com header.i=@dionne-riel-com.20230601.gappssmtp.com header.b=B+EH78wA; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dionne-riel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dionne-riel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dionne-riel-com.20230601.gappssmtp.com header.i=@dionne-riel-com.20230601.gappssmtp.com header.b="B+EH78wA"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8c07bc2ad13so291261985a.2
        for <linux-iio@vger.kernel.org>; Sun, 01 Feb 2026 14:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dionne-riel-com.20230601.gappssmtp.com; s=20230601; t=1769986525; x=1770591325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IfUc8fwnSb3Ej23lpsDntV4Xx+xIQN3dPI34pA88BYM=;
        b=B+EH78wATdERK6Lu3L64lxTCked5NBbaiY9dbj1qJiraUV5EIkIKvBhwoVjitZbbsL
         f4wGgl6QJ++1xO8Ns5+ETvW48OJ0HbuOqXelIgW+SEgU93gUL8czVB1wtiMbsiDAieM2
         OwGwhtZhm9kiiAdUT/GSX2E303taEXMPPlukHjuYgsAiSdRt99zKDFdf4nx2DnX4Md//
         ZK3tW+19cTbOwaBwejP2scHM0uPwWiAHPIwJw3F2j4l4ARyhtQz4jDzXdh/o2RUNa6is
         nKP79sl2e5kqy29dyexUY/bNasXw8y2wEAuFwJXRtY3liCK4kDwVQ7GhQBmX5vBJD6To
         It5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769986525; x=1770591325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IfUc8fwnSb3Ej23lpsDntV4Xx+xIQN3dPI34pA88BYM=;
        b=Vfgsex85mkC8Xj7hcAbOVjl9kRGOouLcm7qCZdC7kCxXgH8lH4BmosWiUs0t9rQNnJ
         FEC73nc4FOODDHUrnOOUinRMbnKA1R6zgABKBndY5hTNrnisteAA0KTlOFJHz60145mB
         K+Qughj3M1eWQyyCXEZUBpKOlPrqtgChCuHJo4p08k7ly3jq3wY1RufYfWVijMAocR0X
         q1dEekuNCapT+8ES5YBhsCDeXwdXhNVR/HcEbscGWKcpuKtgwWgPKjxCos5IEs/mRKKr
         c6SaHSmR1zGijUYSAr3TI03EssdFrt1fqlqpCSV5H+aAo5SbbtzvOcuo6WeR5cHB4dtl
         VG8g==
X-Forwarded-Encrypted: i=1; AJvYcCUNPGsLDAYR2noZ+JgjN6nYIbkjX9Msvppm8cOqd3D3aAqOBjOfuOait7jEWDqRokul26rZBJ1UCpA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxENB7ELIgRXI8JuRB1cGN/9BKbmW4f4nHPdFSOGkko8z6WuvbT
	wUATFwj+3DQ6OX1KAjXezcndY/81ZA726lpb8wXPlUO/z7+TsG+cbX+u0EV44XNDaRbJKCnBWpj
	VXfg=
X-Gm-Gg: AZuq6aJU1yqXu915tZEBF6qgSaW68G5dBMbjuLV6WNKv+L1dj6cBFP9rbtasB9OK3EZ
	jML31Dzw47e9K5jS5ou34TAQz1AdVzzyLB51DTDbAxR+ZHQSlf/iAgtras+seya6pMXZfmhlqp2
	odWpi4z+yh5eEwwVvQiY8iT5gRZMSkt9fUaKtcdnXwZFWFi9qrTfQb5nLJ2CRPDhUCBR6xmWSta
	4DsrET/phCDRfrs0hhTSDHHZOXDoM+iuwURAl0W9hNqWAmdM60YQ5jam0g6BBJDXkZgvd8qvtdK
	v1A1vsJEjrVy891Ii4YR8wCCL7aLPkjL9nrDcYMF6iTZf5Rn3zUfCizejHBVRbMxacvXaFLxBX0
	thZTvX5LTWjCso4OO/fxQ1I997VW9ujb/lJZs5MY/7al9O6jVHCxaRvAtabDIDrq4tCDFJOhEt+
	KHfmd7nyNlTPJU9Nn4SRsTtN769gfqSvSfINISLHKijjq9bg7b2Wx+oYV8F94+hVvcqA==
X-Received: by 2002:a05:620a:4802:b0:80e:3af7:7a0c with SMTP id af79cd13be357-8c9eb2faff7mr1322884585a.43.1769986525019;
        Sun, 01 Feb 2026 14:55:25 -0800 (PST)
Received: from frankgrimes.elk-nominal.ts.net (135-23-195-66.cpe.pppoe.ca. [135.23.195.66])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d375ce71sm102146966d6.45.2026.02.01.14.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 14:55:24 -0800 (PST)
From: Samuel Dionne-Riel <samuel@dionne-riel.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Samuel Dionne-Riel <samuel@dionne-riel.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] iio: imu: lsm6dsx: Add alternative ACPI mount matrix retrieval
Date: Sun,  1 Feb 2026 17:54:50 -0500
Message-ID: <20260201225450.1649001-4-samuel@dionne-riel.com>
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

This uses the SLA0 matrix, which is how the SMOCF05 configuration
exposes the mounting information for the accelerometer.

On a limited sample size of one (1) unit, the SLG0 matrix is the
identity matrix. It is unknown how the SLG0 mounting matrix would
logically affect the data, if it differed from the identity matrix.
After all, the IMU is mounted as one single unit, its mounting can't
differ on the gyroscope compared to the accelerometer.

The new `st_lsm6dsx_read_acpi_mount_matrix` function currently only
implements the *known* ACPI methods found in the wild, but the windows
driver seems to indicate more integration-specific methods could exist.

Signed-off-by: Samuel Dionne-Riel <samuel@dionne-riel.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index dc78227952a7c..2278cbf2b711f 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -2635,6 +2635,13 @@ static int st_lsm6dsx_init_regulators(struct device *dev)
 	return 0;
 }
 
+static bool st_lsm6dsx_read_acpi_mount_matrix(struct device *dev,
+				      struct iio_mount_matrix *orientation)
+{
+	return iio_read_acpi_mount_matrix(dev, orientation, "ROTM") ||
+		iio_read_acpi_mount_matrix(dev, orientation, "SLA0");
+}
+
 int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id,
 		     struct regmap *regmap)
 {
@@ -2708,7 +2715,7 @@ int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id,
 			return err;
 	}
 
-	if (!iio_read_acpi_mount_matrix(hw->dev, &hw->orientation, "ROTM")) {
+	if (!st_lsm6dsx_read_acpi_mount_matrix(hw->dev, &hw->orientation)) {
 		err = iio_read_mount_matrix(hw->dev, &hw->orientation);
 		if (err)
 			return err;
-- 
2.51.0

