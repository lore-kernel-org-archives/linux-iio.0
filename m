Return-Path: <alexandre.belloni@free-electrons.com>
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	Josh Wu <josh.wu@atmel.com>,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	Ludovic Desroches <ludovic.desroches@atmel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH 2/3] ARM: at91: at91sam9g45: change at91_adc name
Date: Wed,  5 Mar 2014 17:57:54 +0100
Message-Id: <1394038675-15809-3-git-send-email-alexandre.belloni@free-electrons.com>
In-Reply-To: <1394038675-15809-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1394038675-15809-1-git-send-email-alexandre.belloni@free-electrons.com>
List-ID: <linux-iio@vger.kernel.org>

We can't use "at91_adc" to refer to the at91_adc driver anymore as the name is
used to match an id_table.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/mach-at91/at91sam9g45_devices.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-at91/at91sam9g45_devices.c b/arch/arm/mach-at91/at91sam9g45_devices.c
index cb36fa872d30..88554024eb2d 100644
--- a/arch/arm/mach-at91/at91sam9g45_devices.c
+++ b/arch/arm/mach-at91/at91sam9g45_devices.c
@@ -1203,7 +1203,7 @@ static struct resource adc_resources[] = {
 };
 
 static struct platform_device at91_adc_device = {
-	.name		= "at91_adc",
+	.name		= "at91sam9g45-adc",
 	.id		= -1,
 	.dev		= {
 				.platform_data	= &adc_data,
-- 
1.8.3.2
