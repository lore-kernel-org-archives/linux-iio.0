Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailgw01.mediatek.com ([210.61.82.183]:25072 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751456AbdFZGMF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 26 Jun 2017 02:12:05 -0400
From: Zhiyong Tao <zhiyong.tao@mediatek.com>
To: <robh+dt@kernel.org>, <jic23@kernel.org>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>
CC: <srv_heupstream@mediatek.com>, <liguo.zhang@mediatek.com>,
        <yingjoe.chen@mediatek.com>, <sean.wang@mediatek.com>,
        <matthias.bgg@gmail.com>, <s.hauer@pengutronix.de>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-iio@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>
Subject: [PATCH v2 3/3] iio: adc: mt7622: Add compatible node for mt7622.
Date: Mon, 26 Jun 2017 14:11:42 +0800
Message-ID: <1498457502-3669-4-git-send-email-zhiyong.tao@mediatek.com>
In-Reply-To: <1498457502-3669-1-git-send-email-zhiyong.tao@mediatek.com>
References: <1498457502-3669-1-git-send-email-zhiyong.tao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This commit adds mt7622 compatible node.

Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
---
 drivers/iio/adc/mt6577_auxadc.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/mt6577_auxadc.c b/drivers/iio/adc/mt6577_auxadc.c
index c174b73..4224fc0 100644
--- a/drivers/iio/adc/mt6577_auxadc.c
+++ b/drivers/iio/adc/mt6577_auxadc.c
@@ -308,6 +308,7 @@ static SIMPLE_DEV_PM_OPS(mt6577_auxadc_pm_ops,
 
 static const struct of_device_id mt6577_auxadc_of_match[] = {
 	{ .compatible = "mediatek,mt2701-auxadc", },
+	{ .compatible = "mediatek,mt7622-auxadc", },
 	{ .compatible = "mediatek,mt8173-auxadc", },
 	{ }
 };
-- 
1.7.9.5

