Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtpo.poczta.interia.pl ([217.74.65.206]:43701 "EHLO
        smtpo.poczta.interia.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751674AbcK3MbM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 30 Nov 2016 07:31:12 -0500
Date: Wed, 30 Nov 2016 13:31:38 +0100
From: Slawomir Stepien <sst@poczta.fm>
To: Akshay Vijapur <akshayvijapur@gmail.com>
Cc: linux-iio@vger.kernel.org
Subject: Re: Ad5064 SPI probe not called
Message-ID: <20161130123138.GA28293@x220.localdomain>
References: <CAGQj8EDnMbsai9DwoQy+vMcuCv9es1f1+KKG3+h-W-AYjZtNhw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAGQj8EDnMbsai9DwoQy+vMcuCv9es1f1+KKG3+h-W-AYjZtNhw@mail.gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Nov 30, 2016 12:02, Akshay Vijapur wrote:
> Respected sir ,
> 
> I am using a DAC device with raspberry pi board connected via SPI , So
> i am using ad5064 driver in the kernel .
> 
>  I am seeing that spi probe is not being called . after days of
> researching i got to know that i need to add the device tree for this
> driver . since i am new to the driver development and usage i tried to
> create device tree like this

Yes, the overlay.

> 
> /dts-v1/;
> /plugin/;
> 
> / {
> 
>         compatible = "brcm,bcm2708";
> 
>         fragment@0 {
>                 target = <&spidev0>;
>                 __overlay__ {
>                          status = "okay";

I think this is not what you want. You should disable the spidev driver, so the
AD5064 will be able to use SPI lines.

>                 };
>         };
> 
> 
>         fragment@2 {
>                 target = <&spidev0>;

When adding new device on SPI line, you should add it to the spi target.

>                 (...)
> 
> since i am using raspberry 3 board i tried to add some info about spi
> in the dts file , But still spi probe is not happing . so Could you
> please help me by specifying how to use the device driver with
> raspberry pi 3 board with linux kernel 4.4 in it .

Guys on rpi forum are quite helpful with solving that kind of problems.
Nevertheless please analyze this (it is for different driver, but you should get
the idea):

/dts-v1/;
/plugin/;

/ {
        compatible = "brcm,bcm2835", "brcm,bcm2708", "brcm,bcm2709";

        fragment@0 {
                target = <&spi0>;
                __overlay__ {
                        status = "okay";
                };
        };

        fragment@1 {
                target = <&spidev0>;
                __overlay__ {
                        status = "disabled";
                };
        };

        fragment@2 {
                target = <&spidev1>;
                __overlay__ {
                        status = "disabled";
                };
        };

        fragment@3 {
                target = <&spi0>;
                __overlay__ {
                        #address-cells = <1>;
                        #size-cells = <0>;

                        mcp4131: mcp4131@0 {
                                compatible = "microchip,mcp4162-502";
                                reg = <0>;
                                spi-max-frequency = <10000>;
                        };
                };
        };
};

-- 
Slawomir Stepien
