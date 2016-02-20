Return-Path: <alexander.sverdlin@gmail.com>
Subject: [PATCH v2 4/5] edb93xx: Add ADC platform device
To: Hartley Sweeten <hsweeten@visionengravers.com>,
 Ryan Mallon <rmallon@gmail.com>, linux-arm-kernel@lists.infradead.org,
 linux-iio@vger.kernel.org
References: <56C88EDD.3040007@gmail.com> <56C88FCB.30008@gmail.com>
 <56C88FFD.9050504@gmail.com> <56C89024.3060802@gmail.com>
Cc: Russell King <linux@arm.linux.org.uk>, Jonathan Cameron
 <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>,
 Jonathan Cameron <jic23@kernel.org>
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Message-ID: <56C8A9A5.5050908@gmail.com>
Date: Sat, 20 Feb 2016 19:00:05 +0100
MIME-Version: 1.0
In-Reply-To: <56C89024.3060802@gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

This enables the creation of ADC platform device on EDB93xx series of Cirrus
Logic evaluation boards. The driver for this device must be enabled separately,
either as built-in, or a module.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
---
 arch/arm/mach-ep93xx/edb93xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-ep93xx/edb93xx.c b/arch/arm/mach-ep93xx/edb93xx.c
index ad92d9f..8da0127 100644
--- a/arch/arm/mach-ep93xx/edb93xx.c
+++ b/arch/arm/mach-ep93xx/edb93xx.c
@@ -264,6 +264,7 @@ static void __init edb93xx_init_machine(void)
 	edb93xx_register_pwm();
 	edb93xx_register_fb();
 	edb93xx_register_ide();
+	ep93xx_register_adc();
 }
