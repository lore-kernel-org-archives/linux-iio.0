Return-Path: <SRS0=skia=5I=gmail.com=alexander.sverdlin@kernel.org>
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Hartley Sweeten <hsweeten@visionengravers.com>,
	Ryan Mallon <rmallon@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH v5 1/5] clk: ep93xx: Implement clk_get_parent()
Date: Sun,  4 Jun 2017 01:26:48 +0200
Message-Id: <20170603232652.21401-2-alexander.sverdlin@gmail.com>
In-Reply-To: <20170603232652.21401-1-alexander.sverdlin@gmail.com>
References: <20170603232652.21401-1-alexander.sverdlin@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Trivial implementation of clk_get_parent(), but necessary for some drivers,
such as ADC.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Acked-by: Ryan Mallon <rmallon@gmail.com>
---
 arch/arm/mach-ep93xx/clock.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/mach-ep93xx/clock.c b/arch/arm/mach-ep93xx/clock.c
index 39ef3b613912..b9cd9d7da14d 100644
--- a/arch/arm/mach-ep93xx/clock.c
+++ b/arch/arm/mach-ep93xx/clock.c
@@ -475,6 +475,12 @@ int clk_set_rate(struct clk *clk, unsigned long rate)
 }
 EXPORT_SYMBOL(clk_set_rate);
 
+struct clk *clk_get_parent(struct clk *clk)
+{
+	return clk->parent;
+}
+EXPORT_SYMBOL(clk_get_parent);
+
 
 static char fclk_divisors[] = { 1, 2, 4, 8, 16, 1, 1, 1 };
 static char hclk_divisors[] = { 1, 2, 4, 5, 6, 8, 16, 32 };
-- 
2.12.2
