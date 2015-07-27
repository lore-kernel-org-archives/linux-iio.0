Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx02.posteo.de ([89.146.194.165]:48111 "EHLO mx02.posteo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751668AbbG0OjK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 27 Jul 2015 10:39:10 -0400
Message-ID: <55B6423C.7030301@posteo.de>
Date: Mon, 27 Jul 2015 16:37:48 +0200
From: Martin Kepplinger <martink@posteo.de>
MIME-Version: 1.0
To: Mark Rutland <mark.rutland@arm.com>
CC: "jic23@kernel.org" <jic23@kernel.org>,
	"knaack.h@gmx.de" <knaack.h@gmx.de>,
	"lars@metafoo.de" <lars@metafoo.de>,
	"pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
	"mfuzzey@parkeon.com" <mfuzzey@parkeon.com>,
	"roberta.dobrescu@gmail.com" <roberta.dobrescu@gmail.com>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	Pawel Moll <Pawel.Moll@arm.com>,
	"ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>,
	"galak@codeaurora.org" <galak@codeaurora.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"christoph.muellner@theobroma-systems.com"
	<christoph.muellner@theobroma-systems.com>,
	Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
Subject: Re: [PATCH 8/8] iio: mma8452: add devicetree property to allow all
 pin wirings
References: <1438006095-26920-1-git-send-email-martink@posteo.de> <1438006095-26920-9-git-send-email-martink@posteo.de> <20150727142336.GB10821@leverpostej>
In-Reply-To: <20150727142336.GB10821@leverpostej>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Am 2015-07-27 um 16:23 schrieb Mark Rutland:
> On Mon, Jul 27, 2015 at 03:08:15PM +0100, Martin Kepplinger wrote:
>> For the devices supported by the mma8452 driver, two interrupt pins are
>> available to route the interrupt signals to. By default INT1 is assumed.
>>
>> This adds a bitmask DT property for users to configure interrupt sources
>> for INT2, if that is the wired interrupt pin for them.
> 
> This sounds like configureation rather than a HW property. Why does this
> need to be in the DT?

It's a hardware property of the board that uses the device. There might
be boards that connect just one of them at random, which is the reason
for this DT property. There also might be exotic users who will want
to use both pins to route different interrupt sources to (not yet
supported, but no problem with such a bitmask).

> 
>> This is important for everyone to be able to use this driver, no matter
>> how their chip is wired. At the moment, only 0xff for using INT2 for all
>> available interrupt sources is supported. See the devicetree documentation
>> file for more details.
>>
>> Since this doesn't change the default behaviour, it doesn't break anything
>> for existing users.
>>
>> Signed-off-by: Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
>> Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
>> ---
>>  .../devicetree/bindings/iio/accel/mma8452.txt        |  4 ++++
>>  drivers/iio/accel/mma8452.c                          | 20 +++++++++++++-------
>>  2 files changed, 17 insertions(+), 7 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/iio/accel/mma8452.txt b/Documentation/devicetree/bindings/iio/accel/mma8452.txt
>> index 8d98e05..738a430 100644
>> --- a/Documentation/devicetree/bindings/iio/accel/mma8452.txt
>> +++ b/Documentation/devicetree/bindings/iio/accel/mma8452.txt
>> @@ -10,6 +10,9 @@ Optional properties:
>>  
>>    - interrupt-parent: should be the phandle for the interrupt controller
>>    - interrupts: interrupt mapping for GPIO IRQ
>> +  - use_int2: bitmask to choose interrupt sources assumed to be wired to
>> +    interrupt pin INT2 instead of INT1. Only 0xff (INT2 for every interrupt
>> +    source) is supported at the moment.
> 
> s/_/-/ in property names, please.

ok. If I don't do a version 6 really soon, I'll reply with this patch
corrected here.

> 
> We generally avoid bitmasks in properties, and we also usually exepct a
> full cell even if data is smaller. The fact that you expect /bits/ 8 
> must be documented here if that's truly necessary.

It's not truly necessary. It's just a nice fit. There is one 8 bit
(device memory) register that basically could (in the future) be
exposed through this DT property.

For now it's just 0xff or nothing. We only don't want to create an
interface that could restrict us from implementing more in the future
without breaking anything.

> 
> Thanks,
> Mark
> 
>>  
>>  Example:
>>  
>> @@ -18,4 +21,5 @@ Example:
>>  		reg = <0x1d>;
>>  		interrupt-parent = <&gpio1>;
>>  		interrupts = <5 0>;
>> +		use_int2 = /bits/ 8 <0xff>;
>>  	};
>> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
>> index 918ab59..a03836b1 100644
>> --- a/drivers/iio/accel/mma8452.c
>> +++ b/drivers/iio/accel/mma8452.c
>> @@ -1028,8 +1028,9 @@ static int mma8452_probe(struct i2c_client *client,
>>  {
>>  	struct mma8452_data *data;
>>  	struct iio_dev *indio_dev;
>> -	int ret;
>>  	const struct of_device_id *match;
>> +	int ret;
>> +	u8 int2;
>>  
>>  	match = of_match_device(mma8452_dt_ids, &client->dev);
>>  	if (!match) {
>> @@ -1104,12 +1105,17 @@ static int mma8452_probe(struct i2c_client *client,
>>  		int enabled_interrupts = MMA8452_INT_TRANS |
>>  					 MMA8452_INT_FF_MT;
>>  
>> -		/* Assume wired to INT1 pin */
>> -		ret = i2c_smbus_write_byte_data(client,
>> -						MMA8452_CTRL_REG5,
>> -						supported_interrupts);
>> -		if (ret < 0)
>> -			return ret;
>> +		of_property_read_u8(client->dev.of_node, "use_int2", &int2);
>> +		if (int2 == 0xff) {
>> +			dev_dbg(&client->dev, "use interrupt line INT2\n");
>> +		} else {
>> +			dev_dbg(&client->dev, "use interrupt line INT1\n");
>> +			ret = i2c_smbus_write_byte_data(client,
>> +							MMA8452_CTRL_REG5,
>> +							supported_interrupts);
>> +			if (ret < 0)
>> +				return ret;
>> +		}
>>  
>>  		ret = i2c_smbus_write_byte_data(client,
>>  						MMA8452_CTRL_REG4,
>> -- 
>> 2.1.4
>>

