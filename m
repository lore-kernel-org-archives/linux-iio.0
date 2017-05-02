Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:33828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750831AbdEBDCQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 1 May 2017 23:02:16 -0400
MIME-Version: 1.0
In-Reply-To: <977684c1-8c87-80ae-fc13-576e30e88384@kernel.org>
References: <cover.1493450577.git.eraretuya@gmail.com> <d5c737cf4e5a2d639d09ad95f58ab32e01d0c338.1493450577.git.eraretuya@gmail.com>
 <977684c1-8c87-80ae-fc13-576e30e88384@kernel.org>
From: Rob Herring <robh+dt@kernel.org>
Date: Mon, 1 May 2017 22:01:50 -0500
Message-ID: <CAL_JsqJmF7YhVTqC0daEd50DFAJLyfq-rnUv6sZhabTmm56wQw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] iio: accel: adxl345: Setup DATA_READY trigger
To: Jonathan Cameron <jic23@kernel.org>
Cc: Eva Rachel Retuya <eraretuya@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Daniel Baluta <daniel.baluta@gmail.com>,
        Alison Schofield <amsfield22@gmail.com>,
        Florian Vaussard <florian.vaussard@heig-vd.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Apr 30, 2017 at 7:32 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 29/04/17 08:49, Eva Rachel Retuya wrote:
>> The ADXL345 provides a DATA_READY interrupt function to signal
>> availability of new data. This interrupt function is latched and can be
>> cleared by reading the data registers. The polarity is set to active
>> high by default.
>>
>> Support this functionality by setting it up as an IIO trigger.
>>
>> In addition, two output pins INT1 and INT2 are available for driving
>> interrupts. Allow mapping to either pins by specifying the
>> interrupt-names property in device tree.
>>
>> Signed-off-by: Eva Rachel Retuya <eraretuya@gmail.com>
> Coming together nicely, but a few more bits and pieces inline...
>
> One slight worry is that the irq names stuff is to restrictive
> as we want to direct different interrupts to different pins if
> both are supported!

[...]

>> @@ -199,6 +253,22 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
>>               dev_err(dev, "Failed to set data range: %d\n", ret);
>>               return ret;
>>       }
>> +     /*
>> +      * Any bits set to 0 send their respective interrupts to the INT1 pin,
>> +      * whereas bits set to 1 send their respective interrupts to the INT2
>> +      * pin. Map all interrupts to the specified pin.
> This is an interesting comment.  The usual reason for dual interrupt
> pins is precisely to not map all functions to the same one.  That allows
> for a saving in querying which interrupt it is by having just the data ready
> on one pin and just the events on the other...
>
> Perhaps the current approach won't support that mode of operation?
> Clearly we can't merge a binding that enforces them all being the same
> and then change it later as it'll be incompatible.
>
> I'm not quite sure how one should do this sort of stuff in DT though.
>
> Rob?

DT should just describe what is connected which I gather here could be
either one or both IRQs. We generally distinguish the IRQs with the
interrupt-names property and then retrieve it as below.

>> +      */
>> +     of_irq = of_irq_get_byname(dev->of_node, "INT2");
>> +     if (of_irq == irq)
>> +             regval = 0xFF;
>> +     else
>> +             regval = 0x00;
