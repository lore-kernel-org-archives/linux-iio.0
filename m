Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:44440 "EHLO
	mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752751Ab3HPOru (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 16 Aug 2013 10:47:50 -0400
Message-id: <520E3B8F.9010800@samsung.com>
Date: Fri, 16 Aug 2013 16:47:43 +0200
From: Jacek Anaszewski <j.anaszewski@samsung.com>
MIME-version: 1.0
To: devicetree@vger.kernel.org
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	maxime.ripard@free-electrons.com, lars@metafoo.de,
	l.czerwinski@samsung.com, rob.herring@calxeda.com,
	pawel.moll@arm.com, mark.rutland@arm.com, swarren@wwwdotorg.org,
	ian.campbell@citrix.com, s.nawrocki@samsung.com
Subject: passing two interrupts two an I2C driver
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi all,

I'd like to consult the implementation of DT binding for the I2C device
that exposes two interrupt pins (INT1 and INT2). Both pins can be
configured to generate either data ready interrupts or event interrupts.
I want to implement DT binding that will handle also the situation
when only one of the interrupt sources is routed from the device
to the CPU.

Below is my implementation using interrupt-map:

+++ b/Documentation/devicetree/bindings/iio/pressure/lps331ap.txt
@@ -0,0 +1,41 @@
+* STMicroelectronics LPS331AP barometer sensor
+
+Required properties:
+
+  - compatible : should be "st,lps331ap"
+  - reg : the I2C address of the barometer
+
+Optional properties:
+
+  - st,data-ready-interrupt-pin : redirect DRDY on pin INT1 (1) or pin 
INT2 (2) (u8)
+  - interrupt-parent : phandle to the interrupt map subnode
+  - interrupts : interrupt mapping for LPS331AP interrupt sources:
+                2 sources: 0 - data ready, 1 - threshold event
+  - irq-map : irq sub-node defining interrupt map
+             (all properties listed below are required):
+      - #interrupt-cells : should be 1
+      - #address-cells : should be 0
+      - #size-cells : should be 0
+      - interrupt-map : table of entries consisting of three child 
elements:
+         - unit_interrupt_specifier - 0 : data ready, 1 : threshold event
+         - interrupt parent phandle
+         - parent unit interrupt specifier consisiting of two elements:
+             - index of the interrupt within the controller
+             - flags : should be 0
+
+Example:
+
+lps331ap@5d {
+       compatible = "st,lps331ap";
+       reg = <0x5d>;
+       drdy-int-pin = /bits/ 8 <2>;
+       interrupt-parent = <&irq_map>;
+       interrupts = <0>, <1>;
+
+       irq_map: irq-map {
+               #interrupt-cells = <1>;
+               #address-cells = <0>;
+               #size-cells = <0>;
+               interrupt-map = <0 &gpf0 5 0>;
+       };
+};

And here is how the driver uses this information:

  - if interrupt-map is empty then the driver configures
    itself to work without interrupt support
  - if only one interrupt source is available then the driver
    configures the device to generate data ready interrupts on
    the corresponding INTx pin (in this case the driver must know which
    of the device pins is routed to the cpu -
    st,data-ready-interrupt-pin property conveys this information)
  - if both interrupt sources are available then the driver configures
    the device to generate data ready interrupts on the interrupt pin
    corresponding to the interrupt source with index 0 and event
    interrupts to the interrupt source with index 1.

This solution seems to be a little awkward so I'd like to ask
if there is any neater way to handle presented requirements.
The solution must facilitate passing information about two
interrupt sources two the I2C driver. I have been unable to find
similar solution in the kernel so far.

Thanks,
Jacek Anaszewski
