Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.133]:57274 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752235AbdHBIxG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Aug 2017 04:53:06 -0400
From: Andy Yan <andy.yan@rock-chips.com>
To: heiko@sntech.de
Cc: linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, linux-iio@vger.kernel.org,
        Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH v2 19/23] dt-bindings: adc: add description for rv1108 saradc
Date: Wed,  2 Aug 2017 16:52:33 +0800
Message-Id: <1501663953-12768-1-git-send-email-andy.yan@rock-chips.com>
In-Reply-To: <1501662303-11687-1-git-send-email-andy.yan@rock-chips.com>
References: <1501662303-11687-1-git-send-email-andy.yan@rock-chips.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add device tree bindings document for saradc on
rockchip rv1108 soc.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
---

Changes in v2: None

 Documentation/devicetree/bindings/iio/adc/rockchip-saradc.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.txt b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.txt
index e0a9b9d..c2c50b5 100644
--- a/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.txt
+++ b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.txt
@@ -6,6 +6,7 @@ Required properties:
    - "rockchip,rk3066-tsadc": for rk3036
    - "rockchip,rk3328-saradc", "rockchip,rk3399-saradc": for rk3328
    - "rockchip,rk3399-saradc": for rk3399
+   - "rockchip,rv1108-saradc", "rockchip,rk3399-saradc": for rv1108
 
 - reg: physical base address of the controller and length of memory mapped
        region.
-- 
2.7.4


