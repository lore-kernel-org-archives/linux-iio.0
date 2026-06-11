Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF033F20EE
	for <linux-iio@vger.kernel.org>; Thu, 11 Jun 2026 13:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781185410; cv=none; b=ND4C4zhYL6MuPwW8/LadwihumRyVxHBYHhUoTnH54SOlWz/mU3IjPPD89P6y4hgHb32UvTo5NGZWqxmJUlqVH1MQPrqQgPmHOYBLRK6edabL7cBmrdK9FyAvqaV/Eh4U0VlI24H5Nf8Xlqp/Hd9goZaVO3W2ReAG0q01fYWcQ5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781185410; c=relaxed/simple;
	bh=fDgyM3FSzS61Ot2F2O9fobUBS5j4V+kpMqYKoNt/H0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QZnr7Qlw7hi56PKok6H43mo4IeVCaB1ah9Bm297NwA4hEA+Kxnctbx+at35EIjo+MHYLhYsF52PIIqVb+s/D0BRpBw4G8NerYqCP0AHqUdUc60ei2oyOQ89SGAvUFC9kl5nQyFB5XoWvV82p9nORnAcPKKQ8T3ZrUyn5kO2Dwvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sirat.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sirat.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c85c531d4a9so3259108a12.2
        for <linux-iio@vger.kernel.org>; Thu, 11 Jun 2026 06:43:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781185409; x=1781790209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f5ZUw6iO5Jcj43nv+dGjgrwCx8lsa008QjUaYwZ4YIU=;
        b=mDhxeXh815SqvxC8iMEy7AmHWKNBiVGEwMxnk37T3xwHZ2cY2aEPpn//3Aj7pFqdLc
         9yt6VSN7bgMenerR/iL9INFlZWo06UBWHwwYdPZtMXcVTLpr5vcAW1uCLhP3QvRKMUSn
         Sx8braWRHa+fL7yQ3GX+tGSyy7HpdyLOOULdab1XsRCgCTiEY0vqpIXzz8A7EPE9/eHz
         L6ozf+GqG/id5ATvIWTwhnp6m/l8PoqO4Sa2p4gtHCuyMwu8SicJrOKBfE0HXrUuQ6uf
         3wrWEJC0FodurSGeD63NCp0m/lchhrQMabKRj9swYs5alhL4VGNpwIcLDL0gTf9HYz/L
         FEbw==
X-Forwarded-Encrypted: i=1; AFNElJ/A+vUH2UAw9J2lUrj8kBVMpzqk9ZC+6AOaR3HEUNMivdhwBfVr8YpbrRO03Aq4cS7flMln8snptJs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4VPkAhVhhQWhm3epI2HCOhwZpbVTeyCvUulIzSJVEhSyXWi75
	0ZTaVh8WRd62anHfaFLZpABoHnRAImrje3XBKv3tujFhjtih8gKtCRrf
X-Gm-Gg: Acq92OGFXmobzMSceLq+QpIe7tKk/YHAljLv6K6CY/WUgtmfILobWmCSY9gCY15ZDfi
	I0lZNLE/+W5JyVzQ2CI/t62hmDoNiciMu9FKk81i8W+jPzutjfwQRBE5S6MMn1lHUcaoJTzG5Qm
	2bOIHIh2g6XXcz73jdviOGFF9vP5FNDIMSXMJmgSty8pX4c0Xh/VbndLBxweNpVy48aa43BPJtR
	oD8NrvBzmvBC5veDaBkmT+9OyZx+pSvzD3lUJ1LTm5MeY80SxAhrqFCu673CQevLNLcH/mk7l26
	p+FJRtxpB3OHNx20887s/GhcUN4jmgfiycy6o6PYy7Pg2UMs52d5ytXy0VAQK5E9XFmi9JljLqW
	4cG3CjWQK1Yci8z7o9tkffgx5Ertnl7oggna0KxBhslSepBcIMF0uvxfE790Adq/E/LUcw0DIFN
	0d/8dSPdUBWqErx9zHWulH4HfLITpQE5FEm3MBXUEmD0EWux65HXv2UyZntvkZ/Pc9ejTmlmbwb
	0wihjFFeuriX0F44rkHp6ZvX/sYG+7DDbe5NH7+nOGcHCX1BoPPSoVHdLgPZ/BJNB8q/odJ8al3
	HEA3X9iMJbfrX3Zsws5f
X-Received: by 2002:a05:6a20:db0c:b0:3b4:e4f6:4f15 with SMTP id adf61e73a8af0-3b5e318f3f6mr3400308637.5.1781185408520;
        Thu, 11 Jun 2026 06:43:28 -0700 (PDT)
Received: from fedora ([59.152.111.50])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c86585b20e0sm1757973a12.11.2026.06.11.06.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 06:43:28 -0700 (PDT)
From: Siratul Islam <email@sirat.me>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Siratul Islam <email@sirat.me>,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v3 1/2] iio: proximity: sort the register values for vl53l1x-i2c
Date: Thu, 11 Jun 2026 19:42:29 +0600
Message-ID: <20260611134245.30042-2-email@sirat.me>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611134245.30042-1-email@sirat.me>
References: <20260611134245.30042-1-email@sirat.me>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- Sort register defines list

Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Siratul Islam <email@sirat.me>
---
 drivers/iio/proximity/vl53l1x-i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/vl53l1x-i2c.c b/drivers/iio/proximity/vl53l1x-i2c.c
index 4d9cb3983dba..8302e0049e7c 100644
--- a/drivers/iio/proximity/vl53l1x-i2c.c
+++ b/drivers/iio/proximity/vl53l1x-i2c.c
@@ -43,6 +43,7 @@
 #define VL53L1X_REG_SOFT_RESET						0x0000
 #define VL53L1X_REG_VHV_CONFIG__TIMEOUT_MACROP_LOOP_BOUND		0x0008
 #define VL53L1X_REG_VHV_CONFIG__INIT					0x000B
+#define VL53L1X_REG_DEFAULT_CONFIG					0x002D
 #define VL53L1X_REG_GPIO_HV_MUX__CTRL					0x0030
 #define VL53L1X_REG_GPIO__TIO_HV_STATUS					0x0031
 #define VL53L1X_REG_SYSTEM__INTERRUPT_CONFIG_GPIO			0x0046
@@ -64,7 +65,6 @@
 #define VL53L1X_REG_RESULT__OSC_CALIBRATE_VAL				0x00DE
 #define VL53L1X_REG_FIRMWARE__SYSTEM_STATUS				0x00E5
 #define VL53L1X_REG_IDENTIFICATION__MODEL_ID				0x010F
-#define VL53L1X_REG_DEFAULT_CONFIG					0x002D
 
 #define VL53L1X_MODEL_ID_VAL		0xEACC
 
-- 
2.54.0

