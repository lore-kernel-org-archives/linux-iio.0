Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7416B375AC3
	for <linux-iio@vger.kernel.org>; Tue,  3 Mar 2026 09:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772528660; cv=none; b=iqSPh/N3FdCYKCswtfh2qSH3iCqWHJhxCyT+mMO1wudE7lTfinc0wzBkRMyqkCOrlBVNsnrEb1oCNb4hSDH2wp+MGkN4ASrobyDZl9sKX6XmnUH69NuskvaRZBev3qTL2a2dlbVcW4ObZUXE+75U2YmNgcnxWveJCFs6Nc4c2yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772528660; c=relaxed/simple;
	bh=u/oB+juUyehiMTo86CuId9XkHNGUcsQAYMN/hj3QnKM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fSvATd227dApcfiomLwt7gn5hC/0N/xgDMu4sOGBoQ8CQFuZv2waVOVkG9nzoHZ7CGW6zY70vIqlT8pMwhMAbiQ4d0mVxONACGYgcQlD9rgbBgnDEw96FmIkfdX5xM9hcLBoPdqis68WVRWT/JjVHFpvOGCvL8zCEaFB+0K2+gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sirat.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sirat.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-82747396358so2676726b3a.0
        for <linux-iio@vger.kernel.org>; Tue, 03 Mar 2026 01:04:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772528659; x=1773133459;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jOSOKW0kCqITngNEZ1ehcTCopjWs3+gJ5WzH0JONI+w=;
        b=H3umrQS1jsk/qRtOPaA1Fc+JScYRHklzManCEmEPGOvBcPeXZllX3xBTEoeqTZnjrX
         KRqmJ2Syeaws09Sx0Tn5p3SWRJ9oIr+JsVA3adRhIyYesRBlzYwp/4TMul9x5uNsZEjw
         z++cS8EHz59U9vJ1ZLvRWaujBnG8e9J+ya7uiIAWNDnjpy33eFyp7riHX8jZdAu2r6rB
         zlwNxYNt3g43zg47pD3SPuUu9XI18lgCY4bOKMilc3adh4gbusZnTSPYZaYmGSS71f41
         3kFqVQs/dM/FnPswRifj6NE1xvlOGUBT47/qUu4SSh+lWPMjizr0/91rdNaE5jQKVZAh
         kmSQ==
X-Gm-Message-State: AOJu0YyrqYqPddku6BJY9OACH58sHAcwx690AvcX9ZPWNiBU4e2opEYC
	uNR/+jZMp8gpkM/rI5Vub1zHLhSc8fsgWGl+clDNo+hhkRPjlEU0lOiAHxuUbFm3wy4=
X-Gm-Gg: ATEYQzwbsYbsWlbRiDphzlZeP6we4S2P1Qp2QBphAxn58dsb/YdPnNxViWcXQ1YMlzu
	O+uq9MMrBfTxdjwVqTf8kmS8AxAVW3f8Qv+CdGGNsNbprDAQHLLtVlrGDnII6Re3D3XOusscB1/
	7XzNOq+s3NUF4fRNKRAe5rtI269yLZ9QcxK6nY3FAG5IaWwAEWyzk/K1EE88fqhdvuwXiEYAiNW
	LkZ+/AeZ0u2qSsr9nAG4BejX+4S5BwtKhTHpQ2yuJWEnjvwjQ5VIQFVvFTo/cj2m15iC1O5nKpn
	cQrTLsw1iECuSOa0UGYsTXlirQBWanrfvmobAfid6FIxN/3je068TGKcMZXonenFR9lzhP8Tk3n
	HykUoKuo7D41EW/fT5VRSevceeWkHNetnN8+ftB7IiNQ2U8Erxx9vGOJ1hZzYRGyEclGWTWCdl0
	0EEYU3GXPQmo2CqJM3
X-Received: by 2002:a17:90a:f950:b0:356:22ef:57ba with SMTP id 98e67ed59e1d1-35965c17f28mr12237786a91.7.1772528658429;
        Tue, 03 Mar 2026 01:04:18 -0800 (PST)
Received: from archlinux ([59.152.111.50])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3599c4c0792sm1638259a91.14.2026.03.03.01.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 01:04:18 -0800 (PST)
From: Siratul Islam <email@sirat.me>
To: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-kernel@vger.kernel.org,
	Siratul Islam <email@sirat.me>
Subject: [PATCH 0/3] iio: proximity: add driver for ST VL53L1X ToF sensor
Date: Tue,  3 Mar 2026 15:02:39 +0600
Message-ID: <20260303090253.42076-1-email@sirat.me>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds support for the STMicroelectronics VL53L1X
Time-of-Flight ranging sensor.

The VL53L1X is a ToF laser-ranging sensor with I2C interface,
capable of measuring distances up to 4 meters. The driver
supports both interrupt-driven and polled operation.

Tested on Raspberry Pi 5 with a VL53L1X breakout board.

Siratul Islam (3):
  dt-bindings: iio: proximity: add ST VL53L1X ToF sensor
  iio: proximity: add driver for ST VL53L1X ToF sensor
  MAINTAINERS: add entry for ST VL53L1X ToF sensor driver

 .../bindings/iio/proximity/st,vl53l1x.yaml    |  49 +
 MAINTAINERS                                   |   7 +
 drivers/iio/proximity/Kconfig                 |  14 +
 drivers/iio/proximity/Makefile                |   1 +
 drivers/iio/proximity/vl53l1x-i2c.c           | 901 ++++++++++++++++++
 5 files changed, 972 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/st,vl53l1x.yaml
 create mode 100644 drivers/iio/proximity/vl53l1x-i2c.c


base-commit: 39c633261414f12cb533a8b802ee57e2d2e3c482
--
2.53.0

