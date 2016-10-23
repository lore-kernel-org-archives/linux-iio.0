Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-db5eur01on0103.outbound.protection.outlook.com ([104.47.2.103]:11184
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756769AbcJWWky (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 23 Oct 2016 18:40:54 -0400
From: Peter Rosin <peda@axentia.se>
To: <linux-kernel@vger.kernel.org>
CC: Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v3 4/8] dt-bindings: add axentia to vendor-prefixes
Date: Mon, 24 Oct 2016 00:39:37 +0200
Message-ID: <1477262381-7800-5-git-send-email-peda@axentia.se>
In-Reply-To: <1477262381-7800-1-git-send-email-peda@axentia.se>
References: <1477262381-7800-1-git-send-email-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index f0a48ea78659..a437120a7eee 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -39,6 +39,7 @@ auo	AU Optronics Corporation
 auvidea Auvidea GmbH
 avago	Avago Technologies
 avic	Shanghai AVIC Optoelectronics Co., Ltd.
+axentia	Axentia Technologies AB
 axis	Axis Communications AB
 boe	BOE Technology Group Co., Ltd.
 bosch	Bosch Sensortec GmbH
-- 
2.1.4

