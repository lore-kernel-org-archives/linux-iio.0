Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34891 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbeJBVWI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 2 Oct 2018 17:22:08 -0400
From: Song Qiang <songqiang1304521@gmail.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        himanshujha199640@gmail.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Song Qiang <songqiang1304521@gmail.com>
Subject: [PATCH v3 1/3] dt-bindings: Add PNI to the vendor prefixes.
Date: Tue,  2 Oct 2018 22:38:10 +0800
Message-Id: <20181002143812.3661-2-songqiang1304521@gmail.com>
In-Reply-To: <20181002143812.3661-1-songqiang1304521@gmail.com>
References: <20180925031724.21399-1-songqiang1304521@gmail.com>
 <20181002143812.3661-1-songqiang1304521@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Song Qiang <songqiang1304521@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 41f0b97eb933..5b935f01e15b 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -288,6 +288,7 @@ pine64	Pine64
 pixcir  PIXCIR MICROELECTRONICS Co., Ltd
 plathome	Plat'Home Co., Ltd.
 plda	PLDA
+pni     PNI Sensor Corporation
 portwell	Portwell Inc.
 poslab	Poslab Technology Co., Ltd.
 powervr	PowerVR (deprecated, use img)
-- 
2.17.1
