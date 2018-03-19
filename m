Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:44830 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755448AbeCSKhT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 19 Mar 2018 06:37:19 -0400
Date: Mon, 19 Mar 2018 06:37:17 -0400
From: Brian Masney <masneyb@onstation.org>
To: linux-iio@vger.kernel.org
Cc: Jon.Brenner@ams.com
Subject: tsl2x7x: IRQ event handler only being called when polling sysfs
 attributes
Message-ID: <20180319103717.tqxbbgo5ylmjcajc@b74fbbdcbeeb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

I am working on getting interrupts to work properly for the tsl2x7x
staging cleanup but I've run into an odd issue where
tsl2x7x_event_handler() is only called if I poll the corresponding
sysfs attribute. So for example, when I run this in the background:

	watch -n .1 cat in_illuminance0_input

tsl2x7x_get_lux() shows that the relevant bit in the device register is
asserting an interrupt and tsl2x7x_event_handler() is called. As soon
as I stop that watch process, tsl2x7x_event_handler() is no longer
called.

tsl2x7x_event_handler() is not called for any proximity interrupts
while I only poll the ALS. However, when I start polling
in_proximity0_raw, then tsl2x7x_event_handler() is called as expected
when the sensor is asserting an interrupt.

Note: tsl2x7x_get_prox() in IIO testing is missing a call to clear the
interrupt bit, but tsl2x7x_get_lux() clears it. I added code to clear
the interrupt bit in tsl2x7x_get_prox() to my local tree.

Here is my relevant device tree binding for the Raspberry Pi 2:

&i2c1 {
       tsl2772@39 {
               compatible = "amstaos,tsl2772";
               reg = <0x39>;
               interrupt-parent = <&gpio>;
               interrupts = <22 0x1>;
       };
};

I have a 10K pull-up resistor on the interrupt pin.

Any ideas?

Brian
