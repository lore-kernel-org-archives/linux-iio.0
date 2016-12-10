Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:36337 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750939AbcLJGen (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 10 Dec 2016 01:34:43 -0500
Received: by mail-pf0-f179.google.com with SMTP id 189so6373426pfz.3
        for <linux-iio@vger.kernel.org>; Fri, 09 Dec 2016 22:34:42 -0800 (PST)
From: Matt Ranostay <matt@ranostay.consulting>
To: linux-iio@vger.kernel.org
Cc: Matt Ranostay <matt@ranostay.consulting>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 1/2] devicetree: add Garmin vendor prefix
Date: Fri,  9 Dec 2016 22:34:38 -0800
Message-Id: <1481351679-23400-1-git-send-email-matt@ranostay.consulting>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 64fdc8c1503b..aedd9979d1e9 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -106,6 +106,7 @@ firefly	Firefly
 focaltech	FocalTech Systems Co.,Ltd
 friendlyarm	Guangzhou FriendlyARM Computer Tech Co., Ltd
 fsl	Freescale Semiconductor
+garmin	Garmin Limited
 ge	General Electric Company
 geekbuying	GeekBuying
 gef	GE Fanuc Intelligent Platforms Embedded Systems, Inc.
-- 
2.7.4

