Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f181.google.com ([209.85.192.181]:36413 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751158AbcL2FNZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 29 Dec 2016 00:13:25 -0500
Received: by mail-pf0-f181.google.com with SMTP id 189so61218604pfz.3
        for <linux-iio@vger.kernel.org>; Wed, 28 Dec 2016 21:13:24 -0800 (PST)
From: Matt Ranostay <matt@ranostay.consulting>
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc: jic23@kernel.org, Matt Ranostay <matt@ranostay.consulting>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 1/2] devicetree: add Garmin vendor prefix
Date: Wed, 28 Dec 2016 21:13:05 -0800
Message-Id: <20161229051306.28547-1-matt@ranostay.consulting>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
---
Changes from v1:
* switch to stock ticker for Garmin Limited

 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 16d3b5e7f5d1..5749bfc5fc5b 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -107,6 +107,7 @@ firefly	Firefly
 focaltech	FocalTech Systems Co.,Ltd
 friendlyarm	Guangzhou FriendlyARM Computer Tech Co., Ltd
 fsl	Freescale Semiconductor
+grmn	Garmin Limited
 ge	General Electric Company
 geekbuying	GeekBuying
 gef	GE Fanuc Intelligent Platforms Embedded Systems, Inc.
-- 
2.10.2

