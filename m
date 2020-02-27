Return-Path: <SRS0=eOSc=4P=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB672C35E1C
	for <linux-iio@archiver.kernel.org>; Thu, 27 Feb 2020 18:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F9482084E
	for <linux-iio@archiver.kernel.org>; Thu, 27 Feb 2020 18:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="B2454ayU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729344AbgB0ScH (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 27 Feb 2020 13:32:07 -0500
Received: from mail.andi.de1.cc ([85.214.55.253]:51260 "EHLO mail.andi.de1.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729306AbgB0Sbq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 27 Feb 2020 13:31:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=KJSvEB5GYx0NMRbbOsFK/DkUQp3KkBqyuRsPuE4sghw=; b=B2454ayUwtVcAML7cv6kjUugy2
        mVNTSfy0TVaDXnTMTYwHJUXkwMh/e8vbuAVyqJSu6/J7tq8GIXl66k80J66etY0kO5uZlR0QG1p3N
        wJlX8nxKDMg5ucxtvJV/db7zCYpuF0w72EXAVLfXuhAH/5gzLBq6bmsFZY907XA6vxfg=;
Received: from p200300ccff13fd00e2cec3fffe93fc31.dip0.t-ipconnect.de ([2003:cc:ff13:fd00:e2ce:c3ff:fe93:fc31] helo=eeepc)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1j7NwY-0006yH-F4; Thu, 27 Feb 2020 19:31:30 +0100
Received: from andi by eeepc with local (Exim 4.92)
        (envelope-from <andreas@kemnade.info>)
        id 1j7NwX-0003oR-QN; Thu, 27 Feb 2020 19:31:29 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org, stefan@agner.ch, b.galvani@gmail.com,
        phh@phh.me, letux-kernel@openphoenux.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        jic23@kernel.org
Cc:     Andreas Kemnade <andreas@kemnade.info>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v6 1/7] dt-bindings: mfd: rn5t618: Document optional property interrupts
Date:   Thu, 27 Feb 2020 19:31:06 +0100
Message-Id: <20200227183112.14512-2-andreas@kemnade.info>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200227183112.14512-1-andreas@kemnade.info>
References: <20200227183112.14512-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

These chips use interrupts for various things like RTC alarm.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
---
Changes in v4: add refernce to interrupt binding
documentation
 Documentation/devicetree/bindings/mfd/rn5t618.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/rn5t618.txt b/Documentation/devicetree/bindings/mfd/rn5t618.txt
index b74e5e94d1cb..16778ea00dbc 100644
--- a/Documentation/devicetree/bindings/mfd/rn5t618.txt
+++ b/Documentation/devicetree/bindings/mfd/rn5t618.txt
@@ -15,6 +15,8 @@ Required properties:
  - reg: the I2C slave address of the device
 
 Optional properties:
+ - interrupts: interrupt mapping for IRQ
+   See Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
  - system-power-controller:
    See Documentation/devicetree/bindings/power/power-controller.txt
 
@@ -32,6 +34,8 @@ Example:
 	pmic@32 {
 		compatible = "ricoh,rn5t618";
 		reg = <0x32>;
+		interrupt-parent = <&gpio5>;
+		interrupts = <11 IRQ_TYPE_EDGE_FALLING>;
 		system-power-controller;
 
 		regulators {
-- 
2.20.1

