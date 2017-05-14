Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35248 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751689AbdENJcW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 14 May 2017 05:32:22 -0400
Received: by mail-wm0-f65.google.com with SMTP id v4so21536115wmb.2
        for <linux-iio@vger.kernel.org>; Sun, 14 May 2017 02:32:21 -0700 (PDT)
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Ryan Mallon <rmallon@gmail.com>
Cc: Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH v3 4/5] edb93xx: Add ADC platform device
Date: Sun, 14 May 2017 11:29:53 +0200
Message-Id: <20170514092954.12790-5-alexander.sverdlin@gmail.com>
In-Reply-To: <20170514092954.12790-1-alexander.sverdlin@gmail.com>
References: <20170514092954.12790-1-alexander.sverdlin@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This enables the creation of ADC platform device on EDB93xx series of Cirrus
Logic evaluation boards. The driver for this device must be enabled separately,
either as built-in, or a module.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
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

