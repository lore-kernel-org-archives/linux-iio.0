Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout01.posteo.de ([185.67.36.65]:40174 "EHLO mout01.posteo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751077AbbJYNEi (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 25 Oct 2015 09:04:38 -0400
Received: from dovecot03.posteo.de (dovecot03.posteo.de [172.16.0.13])
	by mout01.posteo.de (Postfix) with ESMTPS id AD2BA208ED
	for <linux-iio@vger.kernel.org>; Sun, 25 Oct 2015 14:04:34 +0100 (CET)
In-Reply-To: <562CB761.9050905@kernel.org>
References: <1444914632-4486-1-git-send-email-martink@posteo.de> <CAL_Jsq+cd0A7wczT-KC3TT_2UmZDqjr799uRMR_WA_JFfTw6dA@mail.gmail.com> <562CB761.9050905@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH v4] iio: mma8452: support either of the available interrupt pins
From: Martin Kepplinger <martink@posteo.de>
Date: Sun, 25 Oct 2015 14:04:27 +0100
To: Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Martin Kepplinger <martink@posteo.de>
CC: Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Martin Fuzzey <mfuzzey@parkeon.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Message-ID: <591E5883-8D38-47C2-8679-EDC3D7C01A5C@posteo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



Am 25. Oktober 2015 12:05:05 MEZ, schrieb Jonathan Cameron <jic23@kernel.org>:
>On 22/10/15 19:22, Rob Herring wrote:
>> On Thu, Oct 15, 2015 at 8:10 AM, Martin Kepplinger
><martink@posteo.de> wrote:
>>> This change is important in order for everyone to be easily able to
>use the
>>> driver for one of the supported accelerometer chips!
>>>
>>> Until now, the driver blindly assumed that the INT1 interrupt line
>is wired
>>> on a user's board. But these devices have 2 interrupt lines and can
>route
>>> their interrupt sources to one of them. Now, if "INT2" is found and
>matches
>>> i2c_client->irq, INT2 will be used.
>>>
>>> The chip's default actually is INT2, which is why probably many
>boards will
>>> have it wired and can make use of this.
>>>
>>> Of course, this also falls back to assuming INT1, so for existing
>users
>>> nothing will break. The new functionality is described in the
>bindings doc.
>>>
>>> Signed-off-by: Martin Kepplinger
><martin.kepplinger@theobroma-systems.com>
>>> ---
>>> changelog:
>>> v4: use irq that matches client->irq, backwards compatible
>>> v3: correctly assign irq if both pins are described in DT
>>> v2: don't warn but normally handle if both pins are described in dts
>>>     thanks Mark Rutland
>>> v1: initial post
>>>
>>>  .../devicetree/bindings/iio/accel/mma8452.txt       |  6 ++++++
>> 
>> For the binding:
>> 
>> Rob Herring <robh@kernel.org>
>I've guessed that was an Acked-by :)
>
>Anyhow, applied to the togreg branch of iio.git.
>
>I'm afraid after my hiatus for a couple of weeks (day job work crisis
>now
>over) this has missed going in for the current cycle.
>
>IIO merge closes more than a week before the merge window opens and
>Linus
>just announced probably release a week today.
>
>Sorry about that, will be queued up for an early entry into linux next
>after the merge window closes.
>
>Jonathan

That's fine. Thanks

>> 
>>>  drivers/iio/accel/mma8452.c                         | 21
>+++++++++++++++------
>>>  2 files changed, 21 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/iio/accel/mma8452.txt
>b/Documentation/devicetree/bindings/iio/accel/mma8452.txt
>>> index e3c3746..3c10e85 100644
>>> --- a/Documentation/devicetree/bindings/iio/accel/mma8452.txt
>>> +++ b/Documentation/devicetree/bindings/iio/accel/mma8452.txt
>>> @@ -7,13 +7,18 @@ Required properties:
>>>      * "fsl,mma8453"
>>>      * "fsl,mma8652"
>>>      * "fsl,mma8653"
>>> +
>>>    - reg: the I2C address of the chip
>>>
>>>  Optional properties:
>>>
>>>    - interrupt-parent: should be the phandle for the interrupt
>controller
>>> +
>>>    - interrupts: interrupt mapping for GPIO IRQ
>>>
>>> +  - interrupt-names: should contain "INT1" and/or "INT2", the
>accelerometer's
>>> +                    interrupt line in use.
>>> +
>>>  Example:
>>>
>>>         mma8453fc@1d {
>>> @@ -21,4 +26,5 @@ Example:
>>>                 reg = <0x1d>;
>>>                 interrupt-parent = <&gpio1>;
>>>                 interrupts = <5 0>;
>>> +               interrupt-names = "INT2";
>>>         };
>>> diff --git a/drivers/iio/accel/mma8452.c
>b/drivers/iio/accel/mma8452.c
>>> index 1eccc2d..116a6e4 100644
>>> --- a/drivers/iio/accel/mma8452.c
>>> +++ b/drivers/iio/accel/mma8452.c
>>> @@ -29,6 +29,7 @@
>>>  #include <linux/iio/events.h>
>>>  #include <linux/delay.h>
>>>  #include <linux/of_device.h>
>>> +#include <linux/of_irq.h>
>>>
>>>  #define MMA8452_STATUS                         0x00
>>>  #define  MMA8452_STATUS_DRDY                   (BIT(2) | BIT(1) |
>BIT(0))
>>> @@ -1130,13 +1131,21 @@ static int mma8452_probe(struct i2c_client
>*client,
>>>                                            MMA8452_INT_FF_MT;
>>>                 int enabled_interrupts = MMA8452_INT_TRANS |
>>>                                          MMA8452_INT_FF_MT;
>>> +               int irq2;
>>>
>>> -               /* Assume wired to INT1 pin */
>>> -               ret = i2c_smbus_write_byte_data(client,
>>> -                                               MMA8452_CTRL_REG5,
>>> -                                              
>supported_interrupts);
>>> -               if (ret < 0)
>>> -                       return ret;
>>> +               irq2 = of_irq_get_byname(client->dev.of_node,
>"INT2");
>>> +
>>> +               if (irq2 == client->irq) {
>>> +                       dev_dbg(&client->dev, "using interrupt line
>INT2\n");
>>> +               } else {
>>> +                       ret = i2c_smbus_write_byte_data(client,
>>> +                                                      
>MMA8452_CTRL_REG5,
>>> +                                                      
>supported_interrupts);
>>> +                       if (ret < 0)
>>> +                               return ret;
>>> +
>>> +                       dev_dbg(&client->dev, "using interrupt line
>INT1\n");
>>> +               }
>>>
>>>                 ret = i2c_smbus_write_byte_data(client,
>>>                                                 MMA8452_CTRL_REG4,
>>> --
>>> 2.1.4
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio"
>in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> 

