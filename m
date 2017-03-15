Return-Path: <SRS0=seG1=2Y=rock-chips.com=cl@kernel.org>
From: <cl@rock-chips.com>
To: heiko@sntech.de
Cc: robh+dt@kernel.org,
	mark.rutland@arm.com,
	zhengxing@rock-chips.com,
	andy.yan@rock-chips.com,
	jay.xu@rock-chips.com,
	matthias.bgg@gmail.com,
	paweljarosz3691@gmail.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	wsa@the-dreams.de,
	linux-i2c@vger.kernel.org,
	jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	wxt@rock-chips.com,
	david.wu@rock-chips.com,
	linux-iio@vger.kernel.org,
	shawn.lin@rock-chips.com,
	akpm@linux-foundation.org,
	dianders@chromium.org,
	yamada.masahiro@socionext.com,
	catalin.marinas@arm.com,
	will.deacon@arm.com,
	afaerber@suse.de,
	shawnguo@kernel.org,
	khilman@baylibre.com,
	arnd@arndb.de,
	fabio.estevam@nxp.com,
	zhangqing@rock-chips.com,
	kever.yang@rock-chips.com,
	tony.xie@rock-chips.com,
	huangtao@rock-chips.com,
	yhx@rock-chips.com,
	rocky.hao@rock-chips.com,
	Chen Liang <cl@rock-chips.com>
Subject: [PATCH v1 1/7] include: dt-bindings: Add pin function index definition for rockchip pinctrl
Date: Wed, 15 Mar 2017 18:03:51 +0800
Message-Id: <1489572237-6649-2-git-send-email-cl@rock-chips.com>
In-Reply-To: <1489572237-6649-1-git-send-email-cl@rock-chips.com>
References: <1489572237-6649-1-git-send-email-cl@rock-chips.com>
List-ID: <linux-iio@vger.kernel.org>

From: Chen Liang <cl@rock-chips.com>

The rk3328 soc need more pin function index for pinctrl.

Signed-off-by: Chen Liang <cl@rock-chips.com>
---
 include/dt-bindings/pinctrl/rockchip.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/dt-bindings/pinctrl/rockchip.h b/include/dt-bindings/pinctrl/rockchip.h
index aaec8ba..bc2b6af 100644
--- a/include/dt-bindings/pinctrl/rockchip.h
+++ b/include/dt-bindings/pinctrl/rockchip.h
@@ -63,5 +63,8 @@
 #define RK_FUNC_2	2
 #define RK_FUNC_3	3
 #define RK_FUNC_4	4
+#define RK_FUNC_5	5
+#define RK_FUNC_6	6
+#define RK_FUNC_7	7
 
 #endif
-- 
1.9.1
