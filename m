Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:32998 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753628AbdEQROJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 17 May 2017 13:14:09 -0400
Received: by mail-wm0-f66.google.com with SMTP id y10so5099462wmh.0
        for <linux-iio@vger.kernel.org>; Wed, 17 May 2017 10:14:08 -0700 (PDT)
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Ryan Mallon <rmallon@gmail.com>
Cc: Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH v4 1/5] clk: ep93xx: Implement clk_get_parent()
Date: Wed, 17 May 2017 19:13:48 +0200
Message-Id: <20170517171352.20369-2-alexander.sverdlin@gmail.com>
In-Reply-To: <20170517171352.20369-1-alexander.sverdlin@gmail.com>
References: <20170517171352.20369-1-alexander.sverdlin@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Trivial implementation of clk_get_parent(), but necessary for some drivers,
such as ADC.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
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

