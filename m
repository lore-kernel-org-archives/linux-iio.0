Return-Path: <alexander.sverdlin@gmail.com>
Subject: [PATCH v2 2/5] clk: ep93xx: Add ADC clock
To: Hartley Sweeten <hsweeten@visionengravers.com>,
 Ryan Mallon <rmallon@gmail.com>, linux-arm-kernel@lists.infradead.org,
 linux-iio@vger.kernel.org
References: <56C88EDD.3040007@gmail.com> <56C88FCB.30008@gmail.com>
Cc: Russell King <linux@arm.linux.org.uk>, Jonathan Cameron
 <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>,
 Jonathan Cameron <jic23@kernel.org>
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Message-ID: <56C8A996.8040107@gmail.com>
Date: Sat, 20 Feb 2016 18:59:50 +0100
MIME-Version: 1.0
In-Reply-To: <56C88FCB.30008@gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

ADC and keypad controller clocks share the same control register, so use the
existing infrastructure to add ADC clock support for Cirrus Logic EP93xx SoCs.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
---
 arch/arm/mach-ep93xx/clock.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/mach-ep93xx/clock.c b/arch/arm/mach-ep93xx/clock.c
index b9cd9d7..4253426 100644
--- a/arch/arm/mach-ep93xx/clock.c
+++ b/arch/arm/mach-ep93xx/clock.c
@@ -98,6 +98,13 @@ static struct clk clk_keypad = {
 	.enable_mask	= EP93XX_SYSCON_KEYTCHCLKDIV_KEN,
 	.set_rate	= set_keytchclk_rate,
 };
+static struct clk clk_adc = {
+	.parent		= &clk_xtali,
+	.sw_locked	= 1,
+	.enable_reg	= EP93XX_SYSCON_KEYTCHCLKDIV,
+	.enable_mask	= EP93XX_SYSCON_KEYTCHCLKDIV_TSEN,
+	.set_rate	= set_keytchclk_rate,
+};
 static struct clk clk_spi = {
 	.parent		= &clk_xtali,
 	.rate		= EP93XX_EXT_CLK_RATE,
@@ -214,6 +221,7 @@ static struct clk_lookup clocks[] = {
 	INIT_CK(NULL,			"pll2",		&clk_pll2),
 	INIT_CK("ohci-platform",	NULL,		&clk_usb_host),
 	INIT_CK("ep93xx-keypad",	NULL,		&clk_keypad),
+	INIT_CK("ep93xx-adc",		NULL,		&clk_adc),
 	INIT_CK("ep93xx-fb",		NULL,		&clk_video),
 	INIT_CK("ep93xx-spi.0",		NULL,		&clk_spi),
 	INIT_CK("ep93xx-i2s",		"mclk",		&clk_i2s_mclk),
