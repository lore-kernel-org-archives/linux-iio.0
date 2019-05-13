Return-Path: <SRS0=aqst=TN=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62DB9C04AA7
	for <linux-iio@archiver.kernel.org>; Mon, 13 May 2019 14:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3500221537
	for <linux-iio@archiver.kernel.org>; Mon, 13 May 2019 14:53:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730954AbfEMOxx (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 13 May 2019 10:53:53 -0400
Received: from ch3vs01.rockwellcollins.com ([205.175.226.27]:63586 "EHLO
        ch3vs01.rockwellcollins.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730955AbfEMOxx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 May 2019 10:53:53 -0400
Received: from ofwch3n02.rockwellcollins.com (HELO ciulimr01.rockwellcollins.com) ([205.175.226.14])
  by ch3vs01.rockwellcollins.com with ESMTP; 13 May 2019 09:53:51 -0500
X-Received: from righttwix.rockwellcollins.com (righttwix.rockwellcollins.com [192.168.141.218])
        by ciulimr01.rockwellcollins.com (Postfix) with ESMTP id A980160185;
        Mon, 13 May 2019 09:53:51 -0500 (CDT)
From:   Adam Michaelis <adam.michaelis@rockwellcollins.com>
To:     linux-iio@vger.kernel.org
Cc:     lars@metafoo.de, michael.hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, robh+dt@kernel.org,
        mark.rutland@arm.com, charles-antoine.couret@essensium.com,
        devicetree@vger.kernel.org, brandon.maier@rockwellcollins.com,
        clayton.shotwell@rockwellcollins.com,
        Adam Michaelis <adam.michaelis@rockwellcollins.com>
Subject: [PATCH v3 3/5] dt-bindings: iio: ad7949: Add adi,reference-select
Date:   Mon, 13 May 2019 09:53:03 -0500
Message-Id: <1557759185-167857-3-git-send-email-adam.michaelis@rockwellcollins.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1557759185-167857-1-git-send-email-adam.michaelis@rockwellcollins.com>
References: <1557759185-167857-1-git-send-email-adam.michaelis@rockwellcollins.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Adding optional parameter to AD7949 to specify the source for the
reference voltage signal. Default value is maintained with option '3' to
match previous version of driver.

Signed-off-by: Adam Michaelis <adam.michaelis@rockwellcollins.com>
---
	V2:
	- Add some defines to reduce use of magic numbers.
	V3:
	- Re-think usage of device tree parameter to focus on the
	actual reference sources instead of the raw hardware
	configuration.
---
 .../devicetree/bindings/iio/adc/ad7949.txt          | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/ad7949.txt b/Documentation/devicetree/bindings/iio/adc/ad7949.txt
index c7f5057356b1..e5152335c761 100644
--- a/Documentation/devicetree/bindings/iio/adc/ad7949.txt
+++ b/Documentation/devicetree/bindings/iio/adc/ad7949.txt
@@ -6,11 +6,28 @@ Required properties:
 	* "adi,ad7682"
 	* "adi,ad7689"
  - reg: spi chip select number for the device
- - vref-supply: The regulator supply for ADC reference voltage
 
-Example:
+Optional properties:
+ - adi,reference-select: Select the reference voltage source to use
+ when converting the input voltages. Valid values are:
+   0: Internal 2.5V reference;
+   1: Internal 4.096V reference;
+   2: External REF reference;
+   3: External REFIN reference (default);
+ - vref-supply: The regulator supply for external ADC reference voltage.
+ Required if one of the external references is selected by
+ 'adi,reference-select'.
+
+Examples:
 adc@0 {
 	compatible = "adi,ad7949";
 	reg = <0>;
+	adi,reference-select = <2>;
 	vref-supply = <&vdd_supply>;
 };
+
+adc@0 {
+	compatible = "adi,ad7949";
+	reg = <0>;
+	adi,reference-select = <0>;
+};
-- 
1.9.1

