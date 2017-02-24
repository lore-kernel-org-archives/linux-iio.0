Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:55728 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751249AbdBXPd3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 24 Feb 2017 10:33:29 -0500
Subject: Re: [PATCH 1/4] Documentation: dt-bindings: iio: Add max961x
To: Geert Uytterhoeven <geert@linux-m68k.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>
References: <1487948756-25172-1-git-send-email-jacopo+renesas@jmondi.org>
 <1487948756-25172-2-git-send-email-jacopo+renesas@jmondi.org>
 <CAMuHMdU9UL9ZyiPJqtTTNS=KOScu6M3c7jQgD1vZ+gTiTCAYMA@mail.gmail.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>, meerw@pmeerw.net,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <64ed3cde-7627-eb60-c507-b68447012502@metafoo.de>
Date: Fri, 24 Feb 2017 16:33:16 +0100
MIME-Version: 1.0
In-Reply-To: <CAMuHMdU9UL9ZyiPJqtTTNS=KOScu6M3c7jQgD1vZ+gTiTCAYMA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/24/2017 04:22 PM, Geert Uytterhoeven wrote:
> On Fri, Feb 24, 2017 at 4:05 PM, Jacopo Mondi <jacopo+renesas@jmondi.org> wrote:
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/adc/max961x.txt
>> @@ -0,0 +1,27 @@
>> +* Maxim max9611/max9612 current sense amplifier with 12-bits ADC interface
>> +
>> +Maxim max9611/max9612 is an high-side current sense amplifier with integrated
>> +12-bits ADC communicating over I2c bus.
>> +The device node for this driver shall be a child of a I2c controller.
>> +
>> +Required properties
>> +  - compatible: Should be "maxim,max961x"
>> +  - reg: The 7-bits long I2c address of the device
>> +  - shunt-resistor: Resistor value, in uOhm, of the current sense shunt
>> +                   resistor.
> 
> shunt-resistor-micro-ohms?

I'll take this one further:

maxim,shunt-resistor-micro-ohms?

Although there is precedence for just 'shunt-resistor' in the ina2xx bindings.

