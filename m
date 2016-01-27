Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:34338 "EHLO
	mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751670AbcA0Ceh (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 26 Jan 2016 21:34:37 -0500
Received: by mail-pf0-f175.google.com with SMTP id q63so111993935pfb.1
        for <linux-iio@vger.kernel.org>; Tue, 26 Jan 2016 18:34:36 -0800 (PST)
From: Matt Ranostay <mranostay@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH v5 1/3] devicetree: add Atlas Scientific LLC vendor prefix
Date: Tue, 26 Jan 2016 18:34:29 -0800
Message-Id: <1453862071-1610-2-git-send-email-mranostay@gmail.com>
In-Reply-To: <1453862071-1610-1-git-send-email-mranostay@gmail.com>
References: <1453862071-1610-1-git-send-email-mranostay@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add the "atlas" vendor prefix for Atlas Scientific LLC

Signed-off-by: Matt Ranostay <mranostay@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 72e2c5a..44ddc98 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -28,6 +28,7 @@ arm	ARM Ltd.
 armadeus	ARMadeus Systems SARL
 artesyn	Artesyn Embedded Technologies Inc.
 asahi-kasei	Asahi Kasei Corp.
+atlas	Atlas Scientific LLC
 atmel	Atmel Corporation
 auo	AU Optronics Corporation
 avago	Avago Technologies
-- 
2.7.0.rc3

