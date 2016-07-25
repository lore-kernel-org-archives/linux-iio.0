Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:33307 "EHLO
	mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752805AbcGYPV3 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 25 Jul 2016 11:21:29 -0400
From: Aleksei Mamlin <mamlinav@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	Aleksei Mamlin <mamlinav@gmail.com>
Subject: [PATCH v2 1/2] devicetree: bindings: Add vendor prefix for Domintech Co., Ltd.
Date: Mon, 25 Jul 2016 18:21:17 +0300
Message-Id: <1469460078-6460-2-git-send-email-mamlinav@gmail.com>
In-Reply-To: <1469460078-6460-1-git-send-email-mamlinav@gmail.com>
References: <1469460078-6460-1-git-send-email-mamlinav@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add vendor-prefix for Domintech Co., Ltd.

Signed-off-by: Aleksei Mamlin <mamlinav@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 2c2500d..7363916 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -75,6 +75,7 @@ digilent	Diglent, Inc.
 dlg	Dialog Semiconductor
 dlink	D-Link Corporation
 dmo	Data Modul AG
+domintech	Domintech Co., Ltd.
 dptechnics	DPTechnics
 dragino	Dragino Technology Co., Limited
 ea	Embedded Artists AB
-- 
2.7.3

