Received: from mail-dl1-f65.google.com (mail-dl1-f65.google.com [74.125.82.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E1A390CB9
	for <linux-iio@vger.kernel.org>; Sat,  9 May 2026 09:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778317422; cv=none; b=D7vLHfLpxMXa9wmq00z8e5w/eYDHID6UlkuDKcImDq9/hWw4NFuKkIKqitHXc5+kflT3B16qIl5jHx1XGJ+zYtVMSP4IDcto9ZsQbSjao1/blpDLWAVIYKQWL0qDWaaUHq/xHeNTERoC9ZXGILb+0ciJQ6Wx6nlgooAPpozKKe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778317422; c=relaxed/simple;
	bh=byOtteQFJj7wH2m03b47SoF27/lgF6IuUDHq8SOBtxQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=u/gnkjBcrSr+NF9kXVTxQvw16lpa11p6GGqZTSq4SiGTu9j7Jqi09c7xTXHS2IcDSA453b2xMABHKTkByNJIeK5DuQLOXWcDlYaS5/S1ykHk6vvseYZqQCdtzADzlHWKdOooBAFmsXjdJjNzp6zKGileNi190gyQmsG+yqwpl0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nnQnep4T; arc=none smtp.client-ip=74.125.82.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nnQnep4T"
Received: by mail-dl1-f65.google.com with SMTP id a92af1059eb24-12dca45ca21so4026448c88.1
        for <linux-iio@vger.kernel.org>; Sat, 09 May 2026 02:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778317420; x=1778922220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ng77Sr+Aq2eTeCc4veSUx5zjPL7nDApX4AemJNimqX8=;
        b=nnQnep4TrtHGzH33K6VC6bt0QwBPhNF31syK4cezXEGgmrg7WofEkOz0iQKSMlltmR
         2Zn4tlgodUFFlJv3+Bn4L7x6H3+kVxfo3maZKXdj3cgcXp2ZHfu46/atuvVy8m8DLRwN
         tNwcsoRnsx8abcTNhlJf2oO5VB4TQ06RDzMK0z0jYWrnI+Y5ZPZbRoP6JKQ0QXOJYguY
         CrA7VQgrxsgxS9rikDQfXDr7xEghMc1GkWHvMnNnU2U0KkcOK2wmQYVkxsmnQ/4WlznG
         A1hOU54wLmBjdumVq3R2Qphgk7wyryMWGArcHNSA5vRJFxO2hYxwkLshCZkKBldCwNtv
         u9NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778317420; x=1778922220;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ng77Sr+Aq2eTeCc4veSUx5zjPL7nDApX4AemJNimqX8=;
        b=DaDFRU7khl7TF2o8JOEw5pUzUdsLpylmoB+xnvz5josbBWWqGo62ILAU5pNRbsujEb
         WVxpz1k5uxbT7G1Q7Hr7Juupf7647AckFdKVhwed9GzZnt74ddQt4Ks2niLZ42n6j1yN
         qrmQ92QBga+7DfymfY0l0NuU6a4ScOXdeWT5KzeCGEPi9XZn255bN8P+t7cUrufp8LO5
         mOOlc7+LEu/fnJnUI5ov/KcL30wJ1fLGe+CnvzM3Ddx5ZD/yrXFWCjwhMXD+nZtzNaNL
         GXFQrOCUihVmV+yW9/oFk6EegtHv/TtgofkT2Lf2/JUX/g92CVMrksZatHeW+1SkUXdw
         6nkA==
X-Gm-Message-State: AOJu0YzupR/XMnGyjZA1EJ8h9yc3Zdzv8KLtOHv3zD6h4+BV3qgR8iJh
	OlUev89TiAE7Og5vJP7nqCDeMIv4Ddi+6Dz+DLQk+7HhuSo31LFfQqR/OlnExU98
X-Gm-Gg: Acq92OFS5bfhCzrRwwBajQKV8RY3ifU+mauUXW4dUah23Zw63aJZ5VY2X0pSekH75CG
	OS2kHj+mfOUPOd4Bxu4jHSWhOU9D8vaEAWqiXQGh7cMpkE0s73A5w/l3ZwZVPn3I3mA6v4AksDc
	6FwTuio7TkVHfJ0lxIR6rIWWPgu5ZJj4g+XJjxe3+TphIlj/2gJglnAqj+Fl5X560uYH1mrftud
	nXReIbQyPmUxOkOAuBHMpf+qy3ddDToH2iAPAxCSvmSCEnhTmXhjxyZbGW/MbJbOpkRg1yiPE6h
	mKerbDkXSv41/MeNEJhwLSQBUPvFEI8h1Cs9iA/R+zoxg/6pI7yqmkPkLpooPJHgaNE54oeFeJJ
	R/3vPjgSpNsQ1kZKxO3lQaDmdjD9UEAgCPxPTaNTFc/451RulypMRi5aInNw2kcqcTJ0hSZ8MrM
	wwMZxlccq0XhjS/aZbU5rDRaaRf5w8lZEN/yc3upJXkowvoRAeXtPjlxY=
X-Received: by 2002:a05:7022:672a:b0:128:bae0:e043 with SMTP id a92af1059eb24-1318eb4a66bmr7629992c88.31.1778317420273;
        Sat, 09 May 2026 02:03:40 -0700 (PDT)
Received: from localhost.localdomain ([76.32.119.210])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13278758e0csm6116676c88.12.2026.05.09.02.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 02:03:39 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH v2] staging: iio: addac: adt7316: check SPI write errors in probe
Date: Sat,  9 May 2026 09:03:20 +0000
Message-Id: <20260509090320.85481-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The probe function issues three SPI writes to switch the device
from the default I2C protocol to SPI protocol, but ignores their
return values.

Switch the repeated SPI writes to a loop and return an error
if any of them fail, as failing to switch the protocol should
abort the probe.

Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
Changes in v2:
- Return error instead of just warning
- Clarify that repeated SPI writes are converted to a loop
---
 drivers/staging/iio/addac/adt7316-spi.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/addac/adt7316-spi.c b/drivers/staging/iio/addac/adt7316-spi.c
index f91325d11394..056a4505bf30 100644
--- a/drivers/staging/iio/addac/adt7316-spi.c
+++ b/drivers/staging/iio/addac/adt7316-spi.c
@@ -98,6 +98,7 @@ static int adt7316_spi_probe(struct spi_device *spi_dev)
 		.multi_read = adt7316_spi_multi_read,
 		.multi_write = adt7316_spi_multi_write,
 	};
+	int i, ret;
 
 	/* don't exceed max specified SPI CLK frequency */
 	if (spi_dev->max_speed_hz > ADT7316_SPI_MAX_FREQ_HZ) {
@@ -107,9 +108,11 @@ static int adt7316_spi_probe(struct spi_device *spi_dev)
 	}
 
 	/* switch from default I2C protocol to SPI protocol */
-	adt7316_spi_write(spi_dev, 0, 0);
-	adt7316_spi_write(spi_dev, 0, 0);
-	adt7316_spi_write(spi_dev, 0, 0);
+	for (i = 0; i < 3; i++) {
+		ret = adt7316_spi_write(spi_dev, 0, 0);
+		if (ret)
+			return ret;
+	}
 
 	return adt7316_probe(&spi_dev->dev, &bus, spi_dev->modalias);
 }
-- 
2.34.1

