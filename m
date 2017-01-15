Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34148 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751068AbdAOWmh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 15 Jan 2017 17:42:37 -0500
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        khilman@baylibre.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org
Cc: carlo@caione.org, catalin.marinas@arm.com, will.deacon@arm.com,
        mturquette@baylibre.com, sboyd@codeaurora.org,
        narmstrong@baylibre.com, linux-arm-kernel@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 2/4] clk: gxbb: add the SAR ADC clocks and expose them
Date: Sun, 15 Jan 2017 23:42:19 +0100
Message-Id: <20170115224221.15510-3-martin.blumenstingl@googlemail.com>
In-Reply-To: <20170115224221.15510-1-martin.blumenstingl@googlemail.com>
References: <20170111174334.24343-1-martin.blumenstingl@googlemail.com>
 <20170115224221.15510-1-martin.blumenstingl@googlemail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The HHI_SAR_CLK_CNTL contains three SAR ADC specific clocks:
- a mux clock to choose between different ADC reference clocks (this is
  2-bit wide, but the datasheet only lists the parents for the first
  bit)
- a divider for the input/reference clock
- a gate which enables the ADC clock

Additionally this exposes the ADC core clock (CLKID_SAR_ADC) and
CLKID_SANA (which seems to enable the analog inputs, but unfortunately
there is no documentation for this - we just mimic what the vendor
driver does).

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/clk/meson/gxbb.c              | 48 +++++++++++++++++++++++++++++++++++
 drivers/clk/meson/gxbb.h              |  9 ++++---
 include/dt-bindings/clock/gxbb-clkc.h |  4 +++
 3 files changed, 58 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index 9d9af446bafc..1c1ec137a3cc 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -564,6 +564,46 @@ static struct clk_gate gxbb_clk81 = {
 	},
 };
 
+static struct clk_mux gxbb_sar_adc_clk_sel = {
+	.reg = (void *)HHI_SAR_CLK_CNTL,
+	.mask = 0x3,
+	.shift = 9,
+	.lock = &clk_lock,
+	.hw.init = &(struct clk_init_data){
+		.name = "sar_adc_clk_sel",
+		.ops = &clk_mux_ops,
+		/* NOTE: The datasheet doesn't list the parents for bit 10 */
+		.parent_names = (const char *[]){ "xtal", "clk81", },
+		.num_parents = 2,
+	},
+};
+
+static struct clk_divider gxbb_sar_adc_clk_div = {
+	.reg = (void *)HHI_SAR_CLK_CNTL,
+	.shift = 0,
+	.width = 8,
+	.lock = &clk_lock,
+	.hw.init = &(struct clk_init_data){
+		.name = "sar_adc_clk_div",
+		.ops = &clk_divider_ops,
+		.parent_names = (const char *[]){ "sar_adc_clk_sel" },
+		.num_parents = 1,
+	},
+};
+
+static struct clk_gate gxbb_sar_adc_clk = {
+	.reg = (void *)HHI_SAR_CLK_CNTL,
+	.bit_idx = 8,
+	.lock = &clk_lock,
+	.hw.init = &(struct clk_init_data){
+		.name = "sar_adc_clk",
+		.ops = &clk_gate_ops,
+		.parent_names = (const char *[]){ "sar_adc_clk_div" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
 /* Everything Else (EE) domain gates */
 static MESON_GATE(gxbb_ddr, HHI_GCLK_MPEG0, 0);
 static MESON_GATE(gxbb_dos, HHI_GCLK_MPEG0, 1);
@@ -754,6 +794,9 @@ static struct clk_hw_onecell_data gxbb_hw_onecell_data = {
 		[CLKID_SD_EMMC_A]	    = &gxbb_emmc_a.hw,
 		[CLKID_SD_EMMC_B]	    = &gxbb_emmc_b.hw,
 		[CLKID_SD_EMMC_C]	    = &gxbb_emmc_c.hw,
+		[CLKID_SAR_ADC_CLK]	    = &gxbb_sar_adc_clk.hw,
+		[CLKID_SAR_ADC_SEL]	    = &gxbb_sar_adc_clk_sel.hw,
+		[CLKID_SAR_ADC_DIV]	    = &gxbb_sar_adc_clk_div.hw,
 	},
 	.num = NR_CLKS,
 };
@@ -856,6 +899,7 @@ static struct clk_gate *gxbb_clk_gates[] = {
 	&gxbb_emmc_a,
 	&gxbb_emmc_b,
 	&gxbb_emmc_c,
+	&gxbb_sar_adc_clk,
 };
 
 static int gxbb_clkc_probe(struct platform_device *pdev)
@@ -888,6 +932,10 @@ static int gxbb_clkc_probe(struct platform_device *pdev)
 	gxbb_mpeg_clk_sel.reg = clk_base + (u64)gxbb_mpeg_clk_sel.reg;
 	gxbb_mpeg_clk_div.reg = clk_base + (u64)gxbb_mpeg_clk_div.reg;
 
+	/* Populate the base address for the SAR ADC clks */
+	gxbb_sar_adc_clk_sel.reg = clk_base + (u64)gxbb_sar_adc_clk_sel.reg;
+	gxbb_sar_adc_clk_div.reg = clk_base + (u64)gxbb_sar_adc_clk_div.reg;
+
 	/* Populate base address for gates */
 	for (i = 0; i < ARRAY_SIZE(gxbb_clk_gates); i++)
 		gxbb_clk_gates[i]->reg = clk_base +
diff --git a/drivers/clk/meson/gxbb.h b/drivers/clk/meson/gxbb.h
index 0252939ba58f..d90052d74abd 100644
--- a/drivers/clk/meson/gxbb.h
+++ b/drivers/clk/meson/gxbb.h
@@ -191,7 +191,7 @@
 #define CLKID_PERIPHS		  20
 #define CLKID_SPICC		  21
 /* CLKID_I2C */
-#define CLKID_SAR_ADC		  23
+/* #define CLKID_SAR_ADC */
 #define CLKID_SMART_CARD	  24
 #define CLKID_RNG0		  25
 #define CLKID_UART0		  26
@@ -237,7 +237,7 @@
 #define CLKID_MMC_PCLK		  66
 #define CLKID_DVIN		  67
 #define CLKID_UART2		  68
-#define CLKID_SANA		  69
+/* #define CLKID_SANA */
 #define CLKID_VPU_INTR		  70
 #define CLKID_SEC_AHB_AHB3_BRIDGE 71
 #define CLKID_CLK81_A53		  72
@@ -265,8 +265,11 @@
 /* CLKID_SD_EMMC_A */
 /* CLKID_SD_EMMC_B */
 /* CLKID_SD_EMMC_C */
+/* CLKID_SAR_ADC_CLK */
+/* CLKID_SAR_ADC_SEL */
+#define CLKID_SAR_ADC_DIV	  99
 
-#define NR_CLKS			  97
+#define NR_CLKS			  100
 
 /* include the CLKIDs that have been made part of the stable DT binding */
 #include <dt-bindings/clock/gxbb-clkc.h>
diff --git a/include/dt-bindings/clock/gxbb-clkc.h b/include/dt-bindings/clock/gxbb-clkc.h
index baade6f429d0..c2e93676010d 100644
--- a/include/dt-bindings/clock/gxbb-clkc.h
+++ b/include/dt-bindings/clock/gxbb-clkc.h
@@ -14,15 +14,19 @@
 #define CLKID_MPLL2		15
 #define CLKID_SPI		34
 #define CLKID_I2C		22
+#define CLKID_SAR_ADC		23
 #define CLKID_ETH		36
 #define CLKID_USB0		50
 #define CLKID_USB1		51
 #define CLKID_USB		55
 #define CLKID_USB1_DDR_BRIDGE	64
 #define CLKID_USB0_DDR_BRIDGE	65
+#define CLKID_SANA		69
 #define CLKID_AO_I2C		93
 #define CLKID_SD_EMMC_A		94
 #define CLKID_SD_EMMC_B		95
 #define CLKID_SD_EMMC_C		96
+#define CLKID_SAR_ADC_CLK	97
+#define CLKID_SAR_ADC_SEL	98
 
 #endif /* __GXBB_CLKC_H */
-- 
2.11.0

