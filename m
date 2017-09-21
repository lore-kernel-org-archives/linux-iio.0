Return-Path: <SRS0=h6fG=AW=mediatek.com=zhiyong.tao@kernel.org>
From: Zhiyong Tao <zhiyong.tao@mediatek.com>
To: <robh+dt@kernel.org>, <jic23@kernel.org>, <knaack.h@gmx.de>,
	<lars@metafoo.de>, <pmeerw@pmeerw.net>
CC: <srv_heupstream@mediatek.com>, <liguo.zhang@mediatek.com>,
	<yingjoe.chen@mediatek.com>, <sean.wang@mediatek.com>,
	<yt.shen@mediatek.com>, <matthias.bgg@gmail.com>, <s.hauer@pengutronix.de>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-iio@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, Zhiyong Tao <zhiyong.tao@mediatek.com>
Subject: [PATCH 2/3] iio: adc: mt2712: Add compatible node for mt2712.
Date: Thu, 21 Sep 2017 09:26:51 +0800
Message-ID: <1505957212-13402-3-git-send-email-zhiyong.tao@mediatek.com>
In-Reply-To: <1505957212-13402-1-git-send-email-zhiyong.tao@mediatek.com>
References: <1505957212-13402-1-git-send-email-zhiyong.tao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

This commit adds mt2712 compatible node.

Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
---
 drivers/iio/adc/mt6577_auxadc.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/mt6577_auxadc.c b/drivers/iio/adc/mt6577_auxadc.c
index 414cf44..70bfa1e 100644
--- a/drivers/iio/adc/mt6577_auxadc.c
+++ b/drivers/iio/adc/mt6577_auxadc.c
@@ -306,6 +306,7 @@ static SIMPLE_DEV_PM_OPS(mt6577_auxadc_pm_ops,
 
 static const struct of_device_id mt6577_auxadc_of_match[] = {
 	{ .compatible = "mediatek,mt2701-auxadc", },
+	{ .compatible = "mediatek,mt2712-auxadc", },
 	{ .compatible = "mediatek,mt7622-auxadc", },
 	{ .compatible = "mediatek,mt8173-auxadc", },
 	{ }
-- 
1.7.9.5
