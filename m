Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yw0-f171.google.com ([209.85.161.171]:35765 "EHLO
        mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750877AbcK3GdE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 30 Nov 2016 01:33:04 -0500
Received: by mail-yw0-f171.google.com with SMTP id i145so152522208ywg.2
        for <linux-iio@vger.kernel.org>; Tue, 29 Nov 2016 22:32:27 -0800 (PST)
MIME-Version: 1.0
From: Akshay Vijapur <akshayvijapur@gmail.com>
Date: Wed, 30 Nov 2016 12:02:26 +0530
Message-ID: <CAGQj8EDnMbsai9DwoQy+vMcuCv9es1f1+KKG3+h-W-AYjZtNhw@mail.gmail.com>
Subject: Ad5064 SPI probe not called
To: linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Respected sir ,

I am using a DAC device with raspberry pi board connected via SPI , So
i am using ad5064 driver in the kernel .

 I am seeing that spi probe is not being called . after days of
researching i got to know that i need to add the device tree for this
driver . since i am new to the driver development and usage i tried to
create device tree like this


/dts-v1/;
/plugin/;

/ {

        compatible = "brcm,bcm2708";

        fragment@0 {
                target = <&spidev0>;
                __overlay__ {
                         status = "okay";
                };
        };


        fragment@2 {
                target = <&spidev0>;
                __overlay__ {
                 #address-cells = <1>;
                 #size-cells = <0>;

                compatible = "spidev";
        ad5064@0 {
                     compatible = "adi,ad5064";
                     reg = <1>;
                     spi-max-frequency = <1000000>;
                     spi-cpha=<1>;
                     spi-cpol=<1>;
                     vcc-supply = <&vcc_io>;
              };
        regulators {
        vcc_io: regulator@0 {
               regulator-name = "vcc_io";
          regulator-min-microvolt = <2500000>;
        regulator-max-microvolt = <2500000>;
        regulator-boot-on;
                        };


since i am using raspberry 3 board i tried to add some info about spi
in the dts file , But still spi probe is not happing . so Could you
please help me by specifying how to use the device driver with
raspberry pi 3 board with linux kernel 4.4 in it .
