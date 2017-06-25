Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36732 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751017AbdFYPux (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 25 Jun 2017 11:50:53 -0400
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        lorenzo.bianconi@st.com
Subject: [PATCH] dt-bindings: iio: accel: add LIS3L02DQ sensor device binding
Date: Sun, 25 Jun 2017 17:50:50 +0200
Message-Id: <20170625155050.23074-1-lorenzo.bianconi@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
---
 Documentation/devicetree/bindings/iio/st-sensors.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/st-sensors.txt b/Documentation/devicetree/bindings/iio/st-sensors.txt
index e31457ae6f50..1e305f61f3df 100644
--- a/Documentation/devicetree/bindings/iio/st-sensors.txt
+++ b/Documentation/devicetree/bindings/iio/st-sensors.txt
@@ -45,6 +45,7 @@ Accelerometers:
 - st,lis2dh12-accel
 - st,h3lis331dl-accel
 - st,lng2dm-accel
+- st,lis3l02dq
 
 Gyroscopes:
 - st,l3g4200d-gyro
-- 
2.13.1

