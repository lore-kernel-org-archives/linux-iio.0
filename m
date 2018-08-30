Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53443 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727340AbeHaA5b (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Aug 2018 20:57:31 -0400
Received: by mail-wm0-f68.google.com with SMTP id b19-v6so3238710wme.3
        for <linux-iio@vger.kernel.org>; Thu, 30 Aug 2018 13:53:30 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 5/5] dt-bindings: iio: imu: st_lsm6dsx: add LSM6DSO device bindings
Date: Thu, 30 Aug 2018 22:52:59 +0200
Message-Id: <20180830205259.7029-6-lorenzo.bianconi@redhat.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
---
 Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt b/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
index ef8a8566c63f..858a2898908a 100644
--- a/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
+++ b/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
@@ -7,6 +7,7 @@ Required properties:
   "st,lsm6dsl"
   "st,lsm6dsm"
   "st,ism330dlc"
+  "st,lsm6dso"
 - reg: i2c address of the sensor / spi cs line
 
 Optional properties:
-- 
2.18.0
