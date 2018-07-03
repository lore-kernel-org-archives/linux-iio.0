Return-Path: <SRS0=lHPj=JT=it-klinger.de=ak@kernel.org>
Date: Tue, 3 Jul 2018 14:49:22 +0200
From: Andreas Klinger <ak@it-klinger.de>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	robh+dt@kernel.org, mark.rutland@arm.com, mchehab@kernel.org,
	davem@davemloft.net, gregkh@linuxfoundation.org,
	akpm@linux-foundation.org, linus.walleij@linaro.org,
	rdunlap@infradead.org, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] iio: hx711: add avia,data-ready-delay-ns property in
 DT
Message-ID: <20180703124922.GA18022@arbeit>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

add avia,data-ready-delay-ns property for hx711 ADC
this is the delay after rising PD_SCK until DOUT is read and assumed to be
ready

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 Documentation/devicetree/bindings/iio/adc/avia-hx711.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt b/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt
index b3629405f568..669d213e2964 100644
--- a/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt
+++ b/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt
@@ -8,11 +8,18 @@ Required properties:
 		See Documentation/devicetree/bindings/gpio/gpio.txt
  - avdd-supply:	Definition of the regulator used as analog supply
 
+Optional properties:
+ - avia,data-ready-delay-ns:	additional delay in nanoseconds between
+				rising of PD_SCK until DOUT is ready
+				should be less then maximum PD_SCK high
+				time which is 50000 in the datasheet
+
 Example:
 weight@0 {
 	compatible = "avia,hx711";
 	sck-gpios = <&gpio3 10 GPIO_ACTIVE_HIGH>;
 	dout-gpios = <&gpio0 7 GPIO_ACTIVE_HIGH>;
 	avdd-suppy = <&avdd>;
+	avia,data-ready-delay-ns = <1000>;
 };
 
-- 
2.1.4
