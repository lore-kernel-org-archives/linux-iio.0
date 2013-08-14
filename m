Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pb0-f43.google.com ([209.85.160.43]:61098 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754696Ab3HNHZa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 14 Aug 2013 03:25:30 -0400
Received: by mail-pb0-f43.google.com with SMTP id md4so8940987pbc.30
        for <linux-iio@vger.kernel.org>; Wed, 14 Aug 2013 00:25:30 -0700 (PDT)
Received: from [10.0.1.6] (50-0-72-233.dsl.dynamic.fusionbroadband.com. [50.0.72.233])
        by mx.google.com with ESMTPSA id qh10sm48429104pbb.33.2013.08.14.00.25.28
        for <linux-iio@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 14 Aug 2013 00:25:29 -0700 (PDT)
From: Oliver King-Smith <oliverks@elementalsemi.com>
Content-Type: text/plain; charset=us-ascii
Subject: DTS Support for AD7192
Message-Id: <95643F3C-C453-45AE-87B6-0D7D0096EA89@elementalsemi.com>
Date: Wed, 14 Aug 2013 00:25:27 -0700
To: linux-iio@vger.kernel.org
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello,

I am trying to bring up an AD7192 under the new IIO standard in linux.  I am using the 3.8 version of the kernel on a BeagleBone black.  I am having trouble understand the devices tree structure for industrial IO.

In particular I define a new spi device that looks like

/*
 * Copyright (C) 2013 Elemental Semiconductor
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 2 as
 * published by the Free Software Foundation.
 *
 * This program has been developed to support the DAQ system being developed
 * by Elemental Semiconductor/
 */
/dts-v1/;
/plugin/;

/ {
	compatible = "ti,beaglebone-black", "ti,am335x-bone";

	/* identification */
	part-number = "es_daq";
	version = "0010";

	/* We need to use the SPI bus for the AD7192 */
	exclusive-use =
		/* the pin header uses */
		"P9.28",	/* spi1_cs0 */
		"P9.29",	/* spi1_d0 */
		"P9.30",	/* spi1_d1 */
		"P9.31",	/* spi1_sclk */
		"p9.27",	/* interrupt data ready */
		/* the hardware ip uses */
		"gpio3_19",
		"spi1";	

	fragment@0 {
		target = <&am33xx_pinmux>;
		__overlay__ {
			/* default state has all gpios released and mode set to uart1 */
			bb_spi1_pins: pinmux_bb_spi1_pins {
				pinctrl-single,pins = <
					0x190 0x33	/* mcasp0_aclkx.spi1_sclk, INPUT_PULLUP | MODE3 */
					0x194 0x33	/* mcasp0_fsx.spi1_d0, INPUT_PULLUP | MODE3 */
					0x198 0x13	/* mcasp0_axr0.spi1_d1, OUTPUT_PULLUP | MODE3 */
					0x19c 0x13	/* mcasp0_ahclkr.spi1_cs0, OUTPUT_PULLUP | MODE3 */
				>;
			};
			bb_adc0_pins: pinmux_bb_gpio3_pins {
				pinctrl-single,pins = <
					0x18c 0x2f	/* DRDY interrupt INPUT | PULLDIS | MODE7 */
				>;
			};
		};
	};


	fragment@1 {
		target = <&spi1>;	/* spi1 is numbered correctly */
		__overlay__ {
			status = "okay";
			pinctrl-names = "default";
			pinctrl-0 = <&bb_spi1_pins>;

			#address-cells = <1>;
			#size-cells = <0>;
			
			// We try to add in the adc
			adc@0{
				#address-cells = <1>;
				#size-cells = <0>;
				
				compatible = "ad,ad7192";
				reg = <0>;
				
				// The ad7192 can handle 5MHz, but our isolators are only good
				// to 1MHz.  So we back of to 500KHz
				spi-max-frequency = <500000>;
				// we want to invert the normal operation for the AD7192
				spi-cpol;
				spi-cpha;
	
				// Make sure the interrupt pin is mentioned here
				pinctrl-names = "default";
				pinctrl-0 = <&bb_adc0_pins>;

				interrupt-parent = <&gpio3>;
				interrupts = <19 0x0>;
				irq-gpio = <&gpio3 19 0>;
				
				// I think we need to identify this device as an iio device
				#io-channel-cells = <1>;
			};
		};
	};
};

This file works at some level, because I see the ad7192 kernel module being loaded, and the api bus show an ad7182 registered.  The problem is I don't see the iiodevices showing up in the /dev directory.  I thought adding the #io-channel-cells = <1>; was sufficient, but apparently it is not.

Does anyone have any advice on how I should define the DTS file to make the system understand that I want to use the AD7192 as an IIO device?

Oliver

