Return-Path: <denis@eukrea.com>
From: Denis Carikli <denis@eukrea.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>
Cc: =?UTF-8?q?Eric=20B=C3=A9nard?= <eric@eukrea.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	Denis Carikli <denis@eukrea.com>
Subject: [PATCH 3/4] iio: ti-adc128s052: Documentation: Add adc108s022 ID
Date: Wed, 22 Jul 2015 18:04:23 +0200
Message-Id: <1437581064-9733-3-git-send-email-denis@eukrea.com>
In-Reply-To: <1437581064-9733-1-git-send-email-denis@eukrea.com>
References: <1437581064-9733-1-git-send-email-denis@eukrea.com>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Denis Carikli <denis@eukrea.com>
---
 Documentation/devicetree/bindings/iio/adc/ti-adc128s052.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/ti-adc128s052.txt b/Documentation/devicetree/bindings/iio/adc/ti-adc128s052.txt
index 15ca6b4..c8a958d 100644
--- a/Documentation/devicetree/bindings/iio/adc/ti-adc128s052.txt
+++ b/Documentation/devicetree/bindings/iio/adc/ti-adc128s052.txt
@@ -1,7 +1,7 @@
-* Texas Instruments' ADC128S052 and ADC122S021 ADC chip
+* Texas Instruments' ADC128S052, ADC122S021 and ADC108S022 ADC chips
 
 Required properties:
- - compatible: Should be "ti,adc128s052" or "ti,adc122s021"
+ - compatible: Should be "ti,adc128s052", "ti,adc122s021" or "ti,adc108s022"
  - reg: spi chip select number for the device
  - vref-supply: The regulator supply for ADC reference voltage
 
-- 
2.4.5
