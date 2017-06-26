Return-Path: <SRS0=/lu3=57=mediatek.com=zhiyong.tao@kernel.org>
From: Zhiyong Tao <zhiyong.tao@mediatek.com>
To: <robh+dt@kernel.org>, <jic23@kernel.org>, <knaack.h@gmx.de>,
	<lars@metafoo.de>, <pmeerw@pmeerw.net>
CC: <srv_heupstream@mediatek.com>, <liguo.zhang@mediatek.com>,
	<yingjoe.chen@mediatek.com>, <sean.wang@mediatek.com>,
	<matthias.bgg@gmail.com>, <s.hauer@pengutronix.de>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-iio@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, Zhiyong Tao <zhiyong.tao@mediatek.com>
Subject: [PATCH v2 2/3] iio: adc: mt7622: add support for suspend/resume.
Date: Mon, 26 Jun 2017 14:11:41 +0800
Message-ID: <1498457502-3669-3-git-send-email-zhiyong.tao@mediatek.com>
In-Reply-To: <1498457502-3669-1-git-send-email-zhiyong.tao@mediatek.com>
References: <1498457502-3669-1-git-send-email-zhiyong.tao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

This patch supports auxadc suspend/resume flow.
Disable auxadc clk and power in suspend function.
Enable axuadc clk and power in resume function.

Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
---
 drivers/iio/adc/mt6577_auxadc.c |   38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/iio/adc/mt6577_auxadc.c b/drivers/iio/adc/mt6577_auxadc.c
index 2d104c8..c174b73 100644
--- a/drivers/iio/adc/mt6577_auxadc.c
+++ b/drivers/iio/adc/mt6577_auxadc.c
@@ -184,6 +184,39 @@ static int mt6577_auxadc_read_raw(struct iio_dev *indio_dev,
 	.read_raw = &mt6577_auxadc_read_raw,
 };
 
+#ifdef CONFIG_PM_SLEEP
+static int __maybe_unused mt6577_auxadc_resume(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct mt6577_auxadc_device *adc_dev = iio_priv(indio_dev);
+	int ret;
+
+	ret = clk_prepare_enable(adc_dev->adc_clk);
+	if (ret) {
+		pr_err("failed to enable auxadc clock\n");
+		return ret;
+	}
+
+	mt6577_auxadc_mod_reg(adc_dev->reg_base + MT6577_AUXADC_MISC,
+			      MT6577_AUXADC_PDN_EN, 0);
+	mdelay(MT6577_AUXADC_POWER_READY_MS);
+
+	return 0;
+}
+
+static int __maybe_unused mt6577_auxadc_suspend(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct mt6577_auxadc_device *adc_dev = iio_priv(indio_dev);
+
+	mt6577_auxadc_mod_reg(adc_dev->reg_base + MT6577_AUXADC_MISC,
+			      0, MT6577_AUXADC_PDN_EN);
+	clk_disable_unprepare(adc_dev->adc_clk);
+
+	return 0;
+}
+#endif
+
 static int mt6577_auxadc_probe(struct platform_device *pdev)
 {
 	struct mt6577_auxadc_device *adc_dev;
@@ -269,6 +302,10 @@ static int mt6577_auxadc_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static SIMPLE_DEV_PM_OPS(mt6577_auxadc_pm_ops,
+			 mt6577_auxadc_suspend,
+			 mt6577_auxadc_resume);
+
 static const struct of_device_id mt6577_auxadc_of_match[] = {
 	{ .compatible = "mediatek,mt2701-auxadc", },
 	{ .compatible = "mediatek,mt8173-auxadc", },
@@ -280,6 +317,7 @@ static int mt6577_auxadc_remove(struct platform_device *pdev)
 	.driver = {
 		.name   = "mt6577-auxadc",
 		.of_match_table = mt6577_auxadc_of_match,
+		.pm = &mt6577_auxadc_pm_ops,
 	},
 	.probe	= mt6577_auxadc_probe,
 	.remove	= mt6577_auxadc_remove,
-- 
1.7.9.5
