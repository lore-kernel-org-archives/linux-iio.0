Return-Path: <SRS0=CopR=BT=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A20C7C433E5
	for <linux-iio@archiver.kernel.org>; Sun,  9 Aug 2020 11:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D4FB2065D
	for <linux-iio@archiver.kernel.org>; Sun,  9 Aug 2020 11:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596972017;
	bh=L/L8b0c0+VMr+pcfZjJ7+HaZH8gjMMVUkQ2pMVpKKlA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KbLQmpfybG66elY5M3ClZIzpkgBjKl5PtpxqDc4yG1zc7MH7Dq+M0qBzgplcuuKyh
	 MvX0FRqKH1XObWoQpe0dkMzewa0JWZRDN4E9+eyNuUybfHWSBdSBRfykYqUcXrzTFc
	 ZJUygDdYLFLv5v65G7JGhH5vV3XCmPu3UUOlVaaM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbgHILUQ (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 9 Aug 2020 07:20:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:54272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726350AbgHILUQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 9 Aug 2020 07:20:16 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF88120729;
        Sun,  9 Aug 2020 11:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596972016;
        bh=L/L8b0c0+VMr+pcfZjJ7+HaZH8gjMMVUkQ2pMVpKKlA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LIkHi2EP8x4rqWT3MIfVK2bEozZx61608CZeHeLFKjf+qFaze4oEzAb/737/TSN0t
         ZQR5rIcSvqiUv3lm5XjaHtT3AVygtOY9BpaW33pfd1F51FovrtrfrqOiTAhp1mgdzp
         o5GRZm5tK4jIFFicU7XEPxOFMWQd46E2cACYQq7E=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Phil Reid <preid@electromag.com.au>,
        Rob Herring <robh@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 12/13] dt-bindings: iio: adc: tlc4541 - recover accidentally dropped binding doc
Date:   Sun,  9 Aug 2020 12:17:52 +0100
Message-Id: <20200809111753.156236-13-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200809111753.156236-1-jic23@kernel.org>
References: <20200809111753.156236-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Phil Reid <preid@electromag.com.au>

JC: Seems that I messed up applying the original driver patches, and
this file never actually made it into the tree.

I have picked up original Ack and Sign-off so as to record the
history.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Phil Reid <preid@electromag.com.au>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 .../devicetree/bindings/iio/adc/ti-tlc4541.txt  | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/ti-tlc4541.txt b/Documentation/devicetree/bindings/iio/adc/ti-tlc4541.txt
new file mode 100644
index 000000000000..6b2692723a04
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ti-tlc4541.txt
@@ -0,0 +1,17 @@
+* Texas Instruments' TLC4541
+
+Required properties:
+ - compatible: Should be one of
+	* "ti,tlc4541"
+	* "ti,tlc3541"
+	- reg: SPI chip select number for the device
+ - vref-supply: The regulator supply for ADC reference voltage
+ - spi-max-frequency: Max SPI frequency to use (<= 200000)
+
+Example:
+adc@0 {
+	compatible = "ti,tlc4541";
+	reg = <0>;
+	vref-supply = <&vdd_supply>;
+	spi-max-frequency = <200000>;
+};
-- 
2.28.0

