Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47369 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751768AbbILKwz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 12 Sep 2015 06:52:55 -0400
From: Hans de Goede <hdegoede@redhat.com>
To: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Peter Meerwald <pmeerw@pmeerw.net>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, plaes@plaes.org,
	linux-iio@vger.kernel.org, devicetree <devicetree@vger.kernel.org>,
	Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] devicetree: bindings: Extend the bma180 bindings with bma250 info
Date: Sat, 12 Sep 2015 12:52:49 +0200
Message-Id: <1442055169-16966-1-git-send-email-hdegoede@redhat.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The bma180 / bma250 accelerometers share a driver (at least under Linux),
so it makes sense to also have their bindings info in a single .txt.

This commit extends the bma180 bindings with bma250 bindings, specifically
it specifies how the 2 seperate interrupts the bma250 has must be listed
in devicetree. The existing bma180 driver is already fully compatible
with the specified bindings.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 Documentation/devicetree/bindings/iio/accel/bma180.txt | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/accel/bma180.txt b/Documentation/devicetree/bindings/iio/accel/bma180.txt
index c593357..4a3679d 100644
--- a/Documentation/devicetree/bindings/iio/accel/bma180.txt
+++ b/Documentation/devicetree/bindings/iio/accel/bma180.txt
@@ -1,10 +1,11 @@
-* Bosch BMA180 triaxial acceleration sensor
+* Bosch BMA180 / BMA250 triaxial acceleration sensor
 
 http://omapworld.com/BMA180_111_1002839.pdf
+http://ae-bst.resource.bosch.com/media/products/dokumente/bma250/bst-bma250-ds002-05.pdf
 
 Required properties:
 
-  - compatible : should be "bosch,bma180"
+  - compatible : should be "bosch,bma180" or "bosch,bma250"
   - reg : the I2C address of the sensor
 
 Optional properties:
@@ -13,6 +14,9 @@ Optional properties:
 
   - interrupts : interrupt mapping for GPIO IRQ, it should by configured with
 		flags IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE_EDGE_RISING
+		For the bma250 the first interrupt listed must be the one
+		connected to the INT1 pin, the second (optional) interrupt
+		listed must be the one connected to the INT2 pin.
 
 Example:
 
-- 
2.4.3

