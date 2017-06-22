Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailgw01.mediatek.com ([210.61.82.183]:60284 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752574AbdFVFpB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 22 Jun 2017 01:45:01 -0400
From: Zhiyong Tao <zhiyong.tao@mediatek.com>
To: <robh+dt@kernel.org>, <jic23@kernel.org>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>
CC: <srv_heupstream@mediatek.com>, <liguo.zhang@mediatek.com>,
        <yingjoe.chen@mediatek.com>, <sean.wang@mediatek.com>,
        <matthias.bgg@gmail.com>, <s.hauer@pengutronix.de>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-iio@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
Subject: [PATCH 0/3] ADC: Mediatek auxadc driver for mt7622 
Date: Thu, 22 Jun 2017 13:44:31 +0800
Message-ID: <1498110274-18678-1-git-send-email-zhiyong.tao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

These patches are first version of Mediatek auxadc driver for mt7622.
These patches include three patches.
The First patch adds mt7622 compatible node in binding document.
The second patch adds support for suspend/resume.
The last patch adds mt7622 compatible node in auxadc driver.

Zhiyong Tao (3):
  dt-bindings: adc: mt7622: add binding document
  iio: adc: mt7622: add support for suspend/resume.
  iio: adc: mt7622: Add compatible node for mt7622.

 .../devicetree/bindings/iio/adc/mt6577_auxadc.txt  |    1 +
 drivers/iio/adc/mt6577_auxadc.c                    |   38 ++++++++++++++++++++
 2 files changed, 39 insertions(+)

--
1.7.9.5

