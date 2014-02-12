Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from co9ehsobe002.messaging.microsoft.com ([207.46.163.25]:36916
	"EHLO co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750963AbaBLMJt (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 12 Feb 2014 07:09:49 -0500
From: Paul Cercueil <paul.cercueil@analog.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
	Rob Herring <rob.herring@calxeda.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Rob Landley <rob@landley.net>, <devicetree@vger.kernel.org>,
	Paul Cercueil <paul.cercueil@analog.com>
Subject: [PATCH] devicetree: ad7303: Updated documentation
Date: Wed, 12 Feb 2014 13:08:23 +0100
Message-ID: <1392206903-1662-1-git-send-email-paul.cercueil@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Added documentation about the "adi,use-external-reference"
property.

Signed-off-by: Paul Cercueil <paul.cercueil@analog.com>
---
 Documentation/devicetree/bindings/iio/dac/ad7303.txt |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/dac/ad7303.txt b/Documentation/devicetree/bindings/iio/dac/ad7303.txt
index 914610f..de6b32f 100644
--- a/Documentation/devicetree/bindings/iio/dac/ad7303.txt
+++ b/Documentation/devicetree/bindings/iio/dac/ad7303.txt
@@ -7,6 +7,9 @@ Required properties:
 	- Vdd-supply: Phandle to the Vdd power supply
 
 Optional properties:
+	- adi,use-external-reference: If set, the external reference voltage
+	  supply is used. Otherwise, the internal reference voltage supply is
+	  used.
 	- REF-supply: Phandle to the external reference voltage supply. This should
 	  only be set if there is an external reference voltage connected to the REF
 	  pin. If the property is not set Vdd/2 is used as the reference voltage.
-- 
1.7.10.4


