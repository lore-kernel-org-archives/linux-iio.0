Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:34809 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750956AbbHCE0j (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 3 Aug 2015 00:26:39 -0400
From: Matt Ranostay <mranostay@gmail.com>
To: marex@denx.de, jic23@kernel.org, lars@metafoo.de,
	vladimir.barinov@cogentembedded.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH v2 1/2] devicetree: add PulsedLight vendor prefix
Date: Sun,  2 Aug 2015 21:27:55 -0700
Message-Id: <1438576076-7890-2-git-send-email-mranostay@gmail.com>
In-Reply-To: <1438576076-7890-1-git-send-email-mranostay@gmail.com>
References: <1438576076-7890-1-git-send-email-mranostay@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Matt Ranostay <mranostay@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 6284568..0f318c3 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -164,6 +164,7 @@ phytec	PHYTEC Messtechnik GmbH
 picochip	Picochip Ltd
 plathome	Plat'Home Co., Ltd.
 pixcir  PIXCIR MICROELECTRONICS Co., Ltd
+pulsedlight	PulsedLight, Inc
 powervr	PowerVR (deprecated, use img)
 qca	Qualcomm Atheros, Inc.
 qcom	Qualcomm Technologies, Inc
-- 
1.9.1

