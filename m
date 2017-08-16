Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:37306 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752551AbdHPRDB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 16 Aug 2017 13:03:01 -0400
Received: by mail-wr0-f193.google.com with SMTP id z91so1034570wrc.4
        for <linux-iio@vger.kernel.org>; Wed, 16 Aug 2017 10:03:01 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, linus.walleij@linaro.org,
        lorenzo.bianconi@st.com
Subject: [PATCH 4/4] dt-bindings: iio: magn: add LIS2MDL sensor device binding
Date: Wed, 16 Aug 2017 19:02:53 +0200
Message-Id: <20170816170253.8382-5-lorenzo.bianconi@st.com>
In-Reply-To: <20170816170253.8382-1-lorenzo.bianconi@st.com>
References: <20170816170253.8382-1-lorenzo.bianconi@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
---
 Documentation/devicetree/bindings/iio/st-sensors.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/st-sensors.txt b/Documentation/devicetree/bindings/iio/st-sensors.txt
index 1e305f61f3df..9ec6f5ce54fc 100644
--- a/Documentation/devicetree/bindings/iio/st-sensors.txt
+++ b/Documentation/devicetree/bindings/iio/st-sensors.txt
@@ -64,6 +64,7 @@ Magnetometers:
 - st,lsm303dlhc-magn
 - st,lsm303dlm-magn
 - st,lis3mdl-magn
+- st,lis2mdl
 
 Pressure sensors:
 - st,lps001wp-press
-- 
2.14.0

