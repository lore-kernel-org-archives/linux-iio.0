Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66714C43462
	for <linux-iio@archiver.kernel.org>; Sun, 25 Apr 2021 14:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42CF4613AB
	for <linux-iio@archiver.kernel.org>; Sun, 25 Apr 2021 14:00:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbhDYOAl (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 25 Apr 2021 10:00:41 -0400
Received: from smtpout1.mo528.mail-out.ovh.net ([46.105.34.251]:51947 "EHLO
        smtpout1.mo528.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230311AbhDYOAk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 25 Apr 2021 10:00:40 -0400
Received: from pro2.mail.ovh.net (unknown [10.109.138.141])
        by mo528.mail-out.ovh.net (Postfix) with ESMTPS id 35422A236485;
        Sun, 25 Apr 2021 15:59:59 +0200 (CEST)
Received: from arch.lan (89.70.221.198) by DAG2EX1.emp2.local (172.16.2.11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Sun, 25 Apr
 2021 15:59:58 +0200
From:   Tomasz Duszynski <tomasz.duszynski@octakon.com>
To:     <linux-iio@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <jic23@kernel.org>, <lars@metafoo.de>, <robh+dt@kernel.org>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>
Subject: [PATCH 3/3] dt-bindings: iio: chemical: sps30: update binding with serial example
Date:   Sun, 25 Apr 2021 15:55:46 +0200
Message-ID: <20210425135546.57343-4-tomasz.duszynski@octakon.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210425135546.57343-1-tomasz.duszynski@octakon.com>
References: <20210425135546.57343-1-tomasz.duszynski@octakon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [89.70.221.198]
X-ClientProxiedBy: DAG3EX2.emp2.local (172.16.2.22) To DAG2EX1.emp2.local
 (172.16.2.11)
X-Ovh-Tracer-Id: 8493507424671718423
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrvdduiedgjeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpefhvffufffkofgjfhgggfgtihesthekredtredttdenucfhrhhomhepvfhomhgrshiiucffuhhsiiihnhhskhhiuceothhomhgrshiirdguuhhsiiihnhhskhhisehotghtrghkohhnrdgtohhmqeenucggtffrrghtthgvrhhnpeevjedvkeeuieehveeggeduuddvhfduhffhhedufeejudehkeeuhffgheduffduudenucfkpheptddrtddrtddrtddpkeelrdejtddrvddvuddrudelkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehprhhovddrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehtohhmrghsiidrughushiihihnshhkihesohgtthgrkhhonhdrtghomhdprhgtphhtthhopehrohgshhdoughtsehkvghrnhgvlhdrohhrgh
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

sps30 has gained support for serial communication so add example to the
binding file. While at it remove reg property from list of required
properties because it's no-op in case of serial communication.

Signed-off-by: Tomasz Duszynski <tomasz.duszynski@octakon.com>
---
 .../devicetree/bindings/iio/chemical/sensirion,sps30.yaml  | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/chemical/sensirion,sps30.yaml b/Documentation/devicetree/bindings/iio/chemical/sensirion,sps30.yaml
index a93d1972a5c2..967500b7e773 100644
--- a/Documentation/devicetree/bindings/iio/chemical/sensirion,sps30.yaml
+++ b/Documentation/devicetree/bindings/iio/chemical/sensirion,sps30.yaml
@@ -22,7 +22,6 @@ properties:
 
 required:
   - compatible
-  - reg
 
 additionalProperties: false
 
@@ -37,5 +36,11 @@ examples:
         reg = <0x69>;
       };
     };
+  - |
+    serial {
+      air-pollution-sensor {
+        compatible = "sensirion,sps30";
+      };
+    };
 
 ...
-- 
2.31.1

