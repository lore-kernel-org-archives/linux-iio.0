Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f44.google.com ([74.125.83.44]:33095 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752073AbdEQCDZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 16 May 2017 22:03:25 -0400
Received: by mail-pg0-f44.google.com with SMTP id u187so84790907pgb.0
        for <linux-iio@vger.kernel.org>; Tue, 16 May 2017 19:03:25 -0700 (PDT)
From: Matt Ranostay <matt.ranostay@konsulko.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        devicetree@vger.kernel.org
Subject: [PATCH] iio: proximity: as3935: add missing required spi-max-frequency
Date: Tue, 16 May 2017 19:03:10 -0700
Message-Id: <20170517020310.21355-1-matt.ranostay@konsulko.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

spi-max-frequency is required to be set for the as3935 part, and
document such usage.

Cc: devicetree@vger.kernel.org
Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
---
 Documentation/devicetree/bindings/iio/proximity/as3935.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/proximity/as3935.txt b/Documentation/devicetree/bindings/iio/proximity/as3935.txt
index ae23dd8da736..96dad93fccca 100644
--- a/Documentation/devicetree/bindings/iio/proximity/as3935.txt
+++ b/Documentation/devicetree/bindings/iio/proximity/as3935.txt
@@ -3,6 +3,7 @@ Austrian Microsystems AS3935 Franklin lightning sensor device driver
 Required properties:
 	- compatible: must be "ams,as3935"
 	- reg: SPI chip select number for the device
+	- spi-max-frequency: specifies maximum SPI clock frequency
 	- spi-cpha: SPI Mode 1. Refer to spi/spi-bus.txt for generic SPI
 	slave node bindings.
 	- interrupt-parent : should be the phandle for the interrupt controller
@@ -21,6 +22,7 @@ Example:
 as3935@0 {
 	compatible = "ams,as3935";
 	reg = <0>;
+	spi-max-frequency = <400000>;
 	spi-cpha;
 	interrupt-parent = <&gpio1>;
 	interrupts = <16 1>;
-- 
2.11.0

