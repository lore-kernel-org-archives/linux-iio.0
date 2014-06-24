Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:16450 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753338AbaFXMX3 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 24 Jun 2014 08:23:29 -0400
From: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
To: linux-samsung-soc@vger.kernel.org, linux-iio@vger.kernel.org
Cc: naveenkrishna.ch@gmail.com, kgene.kim@samsung.com,
	linux-arm-kernel@lists.infradead.org, cpgs@samsung.com,
	devicetree@vger.kernel.org, lars@metafoo.de,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 1/4] devicetree: bindings: Document murata vendor prefix
Date: Tue, 24 Jun 2014 17:49:13 +0530
Message-id: <1403612356-23685-2-git-send-email-ch.naveen@samsung.com>
In-reply-to: <1403612356-23685-1-git-send-email-ch.naveen@samsung.com>
References: <1403612356-23685-1-git-send-email-ch.naveen@samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add Murata Manufacturing Co., Ltd. to the list of device tree
vendor prefixes.

Murata manufactures NTC (Negative Temperature Coefficient) based
Thermistors for small scale applications like Mobiles and PDAs.

Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
Cc: Guenter Roeck <linux@roeck-us.net>
---
This changes is needed for the following reasons

1. The vendor prefix "ntc" is not defined in vendor-prefixes.txt
   Thus, giving an error when checked with scripts/checkpatch.pl
2. Murata Manufacturing Co., Ltd. Is the vendor for the
   NTC (Negative Temperature Coefficient) based thermistors.
   Hence, "murata" is the right vendor-prefix, Not "ntc".
3. NTC is a technology used, But the prefix "ntc" is wrongly
   and heavily used in the driver and the documentation.

 .../devicetree/bindings/vendor-prefixes.txt        |    1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 4d7f375..a39b7d7 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -84,6 +84,7 @@ moxa	Moxa
 mpl	MPL AG
 mundoreader	Mundo Reader S.L.
 mxicy	Macronix International Co., Ltd.
+murata	Murata Manufacturing Co., Ltd.
 national	National Semiconductor
 neonode		Neonode Inc.
 netgear	NETGEAR
-- 
1.7.9.5

