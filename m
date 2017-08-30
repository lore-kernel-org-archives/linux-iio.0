Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34712 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751618AbdH3Lu4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 30 Aug 2017 07:50:56 -0400
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, linus.walleij@linaro.org,
        lorenzo.bianconi@st.com, devicetree@vger.kernel.org
Subject: [PATCH v3 5/5] dt-bindings: iio: accel: add LIS2DW12 sensor device binding
Date: Wed, 30 Aug 2017 13:50:43 +0200
Message-Id: <20170830115043.3738-6-lorenzo.bianconi@st.com>
In-Reply-To: <20170830115043.3738-1-lorenzo.bianconi@st.com>
References: <20170830115043.3738-1-lorenzo.bianconi@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
---
 Documentation/devicetree/bindings/iio/st-sensors.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/st-sensors.txt b/Documentation/devicetree/bindings/iio/st-sensors.txt
index 9ec6f5ce54fc..be64357808d0 100644
--- a/Documentation/devicetree/bindings/iio/st-sensors.txt
+++ b/Documentation/devicetree/bindings/iio/st-sensors.txt
@@ -46,6 +46,7 @@ Accelerometers:
 - st,h3lis331dl-accel
 - st,lng2dm-accel
 - st,lis3l02dq
+- st,lis2dw12
 
 Gyroscopes:
 - st,l3g4200d-gyro
-- 
2.14.1

