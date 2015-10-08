Return-Path: <Haibo.Chen@freescale.com>
From: Haibo Chen <haibo.chen@freescale.com>
To: <robh+dt@kernel.org>, <pawel.moll@arm.com>, <mark.rutland@arm.com>,
	<ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>,
	<shawnguo@kernel.org>, <kernel@pengutronix.de>, <mturquette@baylibre.com>,
	<sboyd@codeaurora.org>, <jic23@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-clk@vger.kernel.org>,
	<linux-iio@vger.kernel.org>
Subject: [PATCH 3/5] clk: imx7d: add ADC root clock
Date: Thu, 8 Oct 2015 18:59:06 +0800
Message-ID: <1444301948-21721-3-git-send-email-haibo.chen@freescale.com>
In-Reply-To: <1444301948-21721-1-git-send-email-haibo.chen@freescale.com>
References: <1444301948-21721-1-git-send-email-haibo.chen@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Add ADC root clock support in imx7d clock tree.

Signed-off-by: Haibo Chen <haibo.chen@freescale.com>
---
 drivers/clk/imx/clk-imx7d.c             | 1 +
 include/dt-bindings/clock/imx7d-clock.h | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx7d.c b/drivers/clk/imx/clk-imx7d.c
index f86b680..448ef32 100644
--- a/drivers/clk/imx/clk-imx7d.c
+++ b/drivers/clk/imx/clk-imx7d.c
@@ -829,6 +829,7 @@ static void __init imx7d_clocks_init(struct device_node *ccm_node)
 	clks[IMX7D_CSI_MCLK_ROOT_CLK] = imx_clk_gate2("csi_mclk_root_clk", "csi_mclk_post_div", base + 0x4490, 0);
 	clks[IMX7D_AUDIO_MCLK_ROOT_CLK] = imx_clk_gate2("audio_mclk_root_clk", "audio_mclk_post_div", base + 0x4790, 0);
 	clks[IMX7D_WRCLK_ROOT_CLK] = imx_clk_gate2("wrclk_root_clk", "wrclk_post_div", base + 0x47a0, 0);
+	clks[IMX7D_ADC_ROOT_CLK] = imx_clk_gate2("adc_root_clk", "ipg_root_clk", base + 0x4200, 0);
 
 	clks[IMX7D_GPT_3M_CLK] = imx_clk_fixed_factor("gpt_3m", "osc", 1, 8);
 
diff --git a/include/dt-bindings/clock/imx7d-clock.h b/include/dt-bindings/clock/imx7d-clock.h
index 728df28..a4a7a9c 100644
--- a/include/dt-bindings/clock/imx7d-clock.h
+++ b/include/dt-bindings/clock/imx7d-clock.h
@@ -446,5 +446,6 @@
 #define IMX7D_MU_ROOT_CLK		433
 #define IMX7D_SEMA4_HS_ROOT_CLK		434
 #define IMX7D_PLL_DRAM_TEST_DIV		435
-#define IMX7D_CLK_END			436
+#define IMX7D_ADC_ROOT_CLK		436
+#define IMX7D_CLK_END			437
 #endif /* __DT_BINDINGS_CLOCK_IMX7D_H */
-- 
1.9.1
