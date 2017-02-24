Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from slow1-d.mail.gandi.net ([217.70.178.86]:34258 "EHLO
        slow1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751265AbdBXQA3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 24 Feb 2017 11:00:29 -0500
Subject: Re: [PATCH 1/4] Documentation: dt-bindings: iio: Add max961x
To: Lars-Peter Clausen <lars@metafoo.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>
References: <1487948756-25172-1-git-send-email-jacopo+renesas@jmondi.org>
 <1487948756-25172-2-git-send-email-jacopo+renesas@jmondi.org>
 <CAMuHMdU9UL9ZyiPJqtTTNS=KOScu6M3c7jQgD1vZ+gTiTCAYMA@mail.gmail.com>
 <64ed3cde-7627-eb60-c507-b68447012502@metafoo.de>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>, meerw@pmeerw.net,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
From: jacopo mondi <jacopo@jmondi.org>
Message-ID: <a67f7cf1-b676-5306-9e3d-4768a6e53357@jmondi.org>
Date: Fri, 24 Feb 2017 16:48:19 +0100
MIME-Version: 1.0
In-Reply-To: <64ed3cde-7627-eb60-c507-b68447012502@metafoo.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Lars-Peter,

On 24/02/2017 16:33, Lars-Peter Clausen wrote:
> On 02/24/2017 04:22 PM, Geert Uytterhoeven wrote:
>> On Fri, Feb 24, 2017 at 4:05 PM, Jacopo Mondi <jacopo+renesas@jmondi.org> wrote:
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/iio/adc/max961x.txt
>>> @@ -0,0 +1,27 @@
>>> +* Maxim max9611/max9612 current sense amplifier with 12-bits ADC interface
>>> +
>>> +Maxim max9611/max9612 is an high-side current sense amplifier with integrated
>>> +12-bits ADC communicating over I2c bus.
>>> +The device node for this driver shall be a child of a I2c controller.
>>> +
>>> +Required properties
>>> +  - compatible: Should be "maxim,max961x"
>>> +  - reg: The 7-bits long I2c address of the device
>>> +  - shunt-resistor: Resistor value, in uOhm, of the current sense shunt
>>> +                   resistor.
>>
>> shunt-resistor-micro-ohms?
>
> I'll take this one further:
>
> maxim,shunt-resistor-micro-ohms?
>
> Although there is precedence for just 'shunt-resistor' in the ina2xx bindings.
>

And that's where I took "inspiration" from :)
