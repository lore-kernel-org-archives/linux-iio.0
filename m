Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:35692 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751077AbdFCX1j (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 3 Jun 2017 19:27:39 -0400
Received: by mail-lf0-f66.google.com with SMTP id v20so4149117lfa.2
        for <linux-iio@vger.kernel.org>; Sat, 03 Jun 2017 16:27:38 -0700 (PDT)
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Ryan Mallon <rmallon@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH v5 4/5] edb93xx: Add ADC platform device
Date: Sun,  4 Jun 2017 01:26:51 +0200
Message-Id: <20170603232652.21401-5-alexander.sverdlin@gmail.com>
In-Reply-To: <20170603232652.21401-1-alexander.sverdlin@gmail.com>
References: <20170603232652.21401-1-alexander.sverdlin@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This enables the creation of ADC platform device on EDB93xx series of Cirrus
Logic evaluation boards. The driver for this device must be enabled separately,
either as built-in, or a module.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Acked-by: Ryan Mallon <rmallon@gmail.com>
---
 arch/arm/mach-ep93xx/edb93xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-ep93xx/edb93xx.c b/arch/arm/mach-ep93xx/edb93xx.c
index 0ac176386789..7a7f280b07d7 100644
--- a/arch/arm/mach-ep93xx/edb93xx.c
+++ b/arch/arm/mach-ep93xx/edb93xx.c
@@ -245,6 +245,7 @@ static void __init edb93xx_init_machine(void)
 	edb93xx_register_pwm();
 	edb93xx_register_fb();
 	edb93xx_register_ide();
+	ep93xx_register_adc();
 }
 
 
-- 
2.12.2

