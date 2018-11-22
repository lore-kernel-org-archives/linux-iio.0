Return-Path: <SRS0=t3Fg=OB=osadl.org=hofrat@kernel.org>
From: Nicholas Mc Guire <hofrat@osadl.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Yixun Lan <yixun.lan@amlogic.com>,
        Xingyu Chen <xingyu.chen@amlogic.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] iio: adc: meson-saradc: check for devm_kasprintf failure
Date: Thu, 22 Nov 2018 08:46:43 +0100
Message-Id: <1542872803-29060-1-git-send-email-hofrat@osadl.org>
List-ID: <linux-iio@vger.kernel.org>

devm_kasprintf() may return NULL on failure of internal allocation thus 
the assignments to  init.name  are not safe if not checked. On error
meson_sar_adc_clk_init() returns negative values so -ENOMEM in the
(unlikely) failure case of devm_kasprintf() should be fine here.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: 3adbf3427330 ("iio: adc: add a driver for the SAR ADC found in Amlogic Meson SoCs")
---

Problem located with an experimental coccinelle script

Patch was compile tested with: multi_v7_defconfig (implies ARCH_MESON=y &
MESON_SARADC=y)

Patch is against 4.20-rc3 (localversion-next is next-20181122)

 drivers/iio/adc/meson_saradc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index 028ccd2..672a5de 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -589,6 +589,9 @@ static int meson_sar_adc_clk_init(struct iio_dev *indio_dev,
 
 	init.name = devm_kasprintf(&indio_dev->dev, GFP_KERNEL, "%pOF#adc_div",
 				   indio_dev->dev.of_node);
+	if (!init.name)
+		return -ENOMEM;
+
 	init.flags = 0;
 	init.ops = &clk_divider_ops;
 	clk_parents[0] = __clk_get_name(priv->clkin);
@@ -608,6 +611,9 @@ static int meson_sar_adc_clk_init(struct iio_dev *indio_dev,
 
 	init.name = devm_kasprintf(&indio_dev->dev, GFP_KERNEL, "%pOF#adc_en",
 				   indio_dev->dev.of_node);
+	if (!init.name)
+		return -ENOMEM;
+
 	init.flags = CLK_SET_RATE_PARENT;
 	init.ops = &clk_gate_ops;
 	clk_parents[0] = __clk_get_name(priv->adc_div_clk);
-- 
2.1.4
