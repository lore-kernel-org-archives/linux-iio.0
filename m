Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79508C433EF
	for <linux-iio@archiver.kernel.org>; Wed, 25 May 2022 18:15:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343657AbiEYSPt (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 25 May 2022 14:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343655AbiEYSPt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 25 May 2022 14:15:49 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BBA0A7769;
        Wed, 25 May 2022 11:15:48 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id B48BE5FD09;
        Wed, 25 May 2022 21:15:46 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1653502546;
        bh=QJQZVPJ4aP5jfs09YBrcBdIjdxIgOMJFwHuAKNgegbM=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=oQYXTB9KuDE2ldHOERAIoVo/k1JUX3CROy8ewGIH/AMYe5K8o5LJK0hTD4pHIrXiK
         7oTQshNHm1f0S/lN8+GOPAFe3A5mxq0ja9N0CSLl565tXiL/VZxBqgtzl/iXcMWBVS
         pf0htcUuW9bo3NZA5k7gznUTLCZm64iKOSTmiJ9X3ryxaLSmcSZZIVUyRqBlvHGeEQ
         eOdjaNMLrdxLPWcsTatU+uEsTt6ZN/dT+7DOCBGshwhRhxySNNg6U5npDgvE/AGUFT
         f6QHMcfsFfjqw98ozmYKCgWKfZXWOV8AHyqsj0cbu0mmNrW4aDm10XzzmRiGzWGjUm
         TGjZEw+/4VTMw==
Received: from S-MS-EXCH02.sberdevices.ru (S-MS-EXCH02.sberdevices.ru [172.16.1.5])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Wed, 25 May 2022 21:15:46 +0300 (MSK)
From:   Dmitry Rokosov <DDRokosov@sberdevices.ru>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "stano.jakubek@gmail.com" <stano.jakubek@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "stephan@gerhold.net" <stephan@gerhold.net>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>
Subject: [PATCH v2 1/3] dt-bindings: vendor-prefixes: add MEMSensing
 Microsystems Co., Ltd.
Thread-Topic: [PATCH v2 1/3] dt-bindings: vendor-prefixes: add MEMSensing
 Microsystems Co., Ltd.
Thread-Index: AQHYcGNrbZDA8bgo60ChNUgj/6S16A==
Date:   Wed, 25 May 2022 18:15:30 +0000
Message-ID: <20220525181532.6805-2-ddrokosov@sberdevices.ru>
References: <20220525181532.6805-1-ddrokosov@sberdevices.ru>
In-Reply-To: <20220525181532.6805-1-ddrokosov@sberdevices.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.12]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/05/25 08:39:00 #19569940
X-KSMG-AntiVirus-Status: Clean, skipped
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

MEMSensing Microsystems (Suzhou, China) Co., Ltd. operates as a micro
electromechanical system technology company which produces micro
electromechanical system microphones and sensors.
MEMSensing Microsystems (Suzhou, China) Co., Ltd. applies its products
in consumer electronics, industrial control, medical electronics
and automotive, and other fields.

Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Docum=
entation/devicetree/bindings/vendor-prefixes.yaml
index 294093d45a23..632afb05fcf7 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -735,6 +735,8 @@ patternProperties:
     description: MELFAS Inc.
   "^mellanox,.*":
     description: Mellanox Technologies
+  "^memsensing,.*":
+    description: MEMSensing Microsystems Co., Ltd.
   "^memsic,.*":
     description: MEMSIC Inc.
   "^menlo,.*":
--=20
2.36.0
