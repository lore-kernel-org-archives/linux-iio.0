Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36410 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbeJZLNd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 26 Oct 2018 07:13:33 -0400
Received: by mail-pf1-f195.google.com with SMTP id l81-v6so5164043pfg.3
        for <linux-iio@vger.kernel.org>; Thu, 25 Oct 2018 19:38:25 -0700 (PDT)
From: Martin Kelly <martin@martingkelly.com>
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Denis Ciocca <denis.ciocca@st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Martin Kelly <martin@martingkelly.com>
Subject: [PATCH v2 4/4] dt-bindings: iio: magn: add LSM9DS1 bindings
Date: Thu, 25 Oct 2018 19:38:12 -0700
Message-Id: <20181026023812.29720-4-martin@martingkelly.com>
In-Reply-To: <20181026023812.29720-1-martin@martingkelly.com>
References: <20181026023812.29720-1-martin@martingkelly.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Martin Kelly <martin@martingkelly.com>

Add DT binding documentation for the LSM9DS1 magnetometer driver.

Signed-off-by: Martin Kelly <martin@martingkelly.com>
---
 Documentation/devicetree/bindings/iio/st-sensors.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/st-sensors.txt b/Documentation/devicetree/bindings/iio/st-sensors.txt
index 6f626f73417e..07f1767c7ee6 100644
--- a/Documentation/devicetree/bindings/iio/st-sensors.txt
+++ b/Documentation/devicetree/bindings/iio/st-sensors.txt
@@ -67,6 +67,7 @@ Magnetometers:
 - st,lsm303dlm-magn
 - st,lis3mdl-magn
 - st,lis2mdl
+- st,lsm9ds1-magn
 
 Pressure sensors:
 - st,lps001wp-press
-- 
2.11.0
