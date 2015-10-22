Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout01.posteo.de ([185.67.36.65]:47605 "EHLO mout01.posteo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755661AbbJVPYR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 22 Oct 2015 11:24:17 -0400
Received: from dovecot03.posteo.de (dovecot03.posteo.de [172.16.0.13])
	by mout01.posteo.de (Postfix) with ESMTPS id 2A8D620AAF
	for <linux-iio@vger.kernel.org>; Thu, 22 Oct 2015 17:24:14 +0200 (CEST)
Message-ID: <5628FF3F.9020609@posteo.de>
Date: Thu, 22 Oct 2015 17:22:39 +0200
From: Martin Kepplinger <martink@posteo.de>
MIME-Version: 1.0
To: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
	jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, mfuzzey@parkeon.com
CC: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
Subject: Re: [PATCH v4] iio: mma8452: support either of the available interrupt
 pins
References: <1444914632-4486-1-git-send-email-martink@posteo.de> <56261F6E.80807@posteo.de>
In-Reply-To: <56261F6E.80807@posteo.de>
Content-Type: text/plain; charset=iso-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Am 2015-10-20 um 13:03 schrieb Martin Kepplinger:
> Am 2015-10-15 um 15:10 schrieb Martin Kepplinger:
>> This change is important in order for everyone to be easily able to use the
>> driver for one of the supported accelerometer chips!
>>
>> Until now, the driver blindly assumed that the INT1 interrupt line is wired
>> on a user's board. But these devices have 2 interrupt lines and can route
>> their interrupt sources to one of them. Now, if "INT2" is found and matches
>> i2c_client->irq, INT2 will be used.
>>
>> The chip's default actually is INT2, which is why probably many boards will
>> have it wired and can make use of this.
>>
>> Of course, this also falls back to assuming INT1, so for existing users
>> nothing will break. The new functionality is described in the bindings doc.
>>
>> Signed-off-by: Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
>> ---
>> changelog:
>> v4: use irq that matches client->irq, backwards compatible
>> v3: correctly assign irq if both pins are described in DT
>> v2: don't warn but normally handle if both pins are described in dts
>>     thanks Mark Rutland
>> v1: initial post
>>
>>  .../devicetree/bindings/iio/accel/mma8452.txt       |  6 ++++++
>>  drivers/iio/accel/mma8452.c                         | 21 +++++++++++++++------
>>  2 files changed, 21 insertions(+), 6 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/iio/accel/mma8452.txt b/Documentation/devicetree/bindings/iio/accel/mma8452.txt
>> index e3c3746..3c10e85 100644
>> --- a/Documentation/devicetree/bindings/iio/accel/mma8452.txt
>> +++ b/Documentation/devicetree/bindings/iio/accel/mma8452.txt
>> @@ -7,13 +7,18 @@ Required properties:
>>      * "fsl,mma8453"
>>      * "fsl,mma8652"
>>      * "fsl,mma8653"
>> +
>>    - reg: the I2C address of the chip
>>  
>>  Optional properties:
>>  
>>    - interrupt-parent: should be the phandle for the interrupt controller
>> +
>>    - interrupts: interrupt mapping for GPIO IRQ
>>  
>> +  - interrupt-names: should contain "INT1" and/or "INT2", the accelerometer's
>> +		     interrupt line in use.
>> +
>>  Example:
>>  
>>  	mma8453fc@1d {
>> @@ -21,4 +26,5 @@ Example:
>>  		reg = <0x1d>;
>>  		interrupt-parent = <&gpio1>;
>>  		interrupts = <5 0>;
>> +		interrupt-names = "INT2";
>>  	};
>> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
>> index 1eccc2d..116a6e4 100644
>> --- a/drivers/iio/accel/mma8452.c
>> +++ b/drivers/iio/accel/mma8452.c
>> @@ -29,6 +29,7 @@
>>  #include <linux/iio/events.h>
>>  #include <linux/delay.h>
>>  #include <linux/of_device.h>
>> +#include <linux/of_irq.h>
>>  
>>  #define MMA8452_STATUS				0x00
>>  #define  MMA8452_STATUS_DRDY			(BIT(2) | BIT(1) | BIT(0))
>> @@ -1130,13 +1131,21 @@ static int mma8452_probe(struct i2c_client *client,
>>  					   MMA8452_INT_FF_MT;
>>  		int enabled_interrupts = MMA8452_INT_TRANS |
>>  					 MMA8452_INT_FF_MT;
>> +		int irq2;
>>  
>> -		/* Assume wired to INT1 pin */
>> -		ret = i2c_smbus_write_byte_data(client,
>> -						MMA8452_CTRL_REG5,
>> -						supported_interrupts);
>> -		if (ret < 0)
>> -			return ret;
>> +		irq2 = of_irq_get_byname(client->dev.of_node, "INT2");
>> +
>> +		if (irq2 == client->irq) {
>> +			dev_dbg(&client->dev, "using interrupt line INT2\n");
>> +		} else {
>> +			ret = i2c_smbus_write_byte_data(client,
>> +							MMA8452_CTRL_REG5,
>> +							supported_interrupts);
>> +			if (ret < 0)
>> +				return ret;
>> +
>> +			dev_dbg(&client->dev, "using interrupt line INT1\n");
>> +		}
>>  
>>  		ret = i2c_smbus_write_byte_data(client,
>>  						MMA8452_CTRL_REG4,
>>
> 
> This works fine and would be convenient to have. Any objections?
> 
> thanks
>                          martin

yes, no, maybe?

thanks
                           martin


