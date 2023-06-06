Return-Path: <linux-iio-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66FC0C77B73
	for <linux-iio@archiver.kernel.org>; Tue,  6 Jun 2023 10:03:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjFFKDr (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 6 Jun 2023 06:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236165AbjFFKDo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 6 Jun 2023 06:03:44 -0400
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C9D121
        for <linux-iio@vger.kernel.org>; Tue,  6 Jun 2023 03:03:43 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed30:a3e8:6562:a823:d832])
        by xavier.telenet-ops.be with bizsmtp
        id 5m3h2A0011Tjf1k01m3hbX; Tue, 06 Jun 2023 12:03:41 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1q6TX6-005Jhm-3M;
        Tue, 06 Jun 2023 12:03:40 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1q6TXQ-00Bjv3-ST;
        Tue, 06 Jun 2023 12:03:40 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] dt-bindings: iio: afe: voltage-divider: Spelling s/curcuit/circuit/
Date:   Tue,  6 Jun 2023 12:03:39 +0200
Message-Id: <a8597e54b55dedc51025fe3073d25ef0d659d0dc.1686045793.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Fix a misspelling of "circuit".

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml b/Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml
index df2589f214e18b50..dddf97b50549f001 100644
--- a/Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml
+++ b/Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml
@@ -13,7 +13,7 @@ description: |
   When an io-channel measures the midpoint of a voltage divider, the
   interesting voltage is often the voltage over the full resistance
   of the divider. This binding describes the voltage divider in such
-  a curcuit.
+  a circuit.
 
     Vin ----.
             |
-- 
2.34.1

