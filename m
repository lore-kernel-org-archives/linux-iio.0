Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46477 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752090AbcEUQ1X (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 21 May 2016 12:27:23 -0400
Subject: Re: [PATCH] iio: humidity: hdc100x: add HDC1000 and HDC1008 product
 names
To: Matt Ranostay <mranostay@gmail.com>,
	Alison Schofield <amsfield22@gmail.com>
References: <20160520170500.GA2620@d830.WORKGROUP>
 <CAKzfze_7C-WWy0NUtgAEj5XYZ-qUmMWxEOVV8-F9haU=CW_tLQ@mail.gmail.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <446b3713-c613-34c9-4432-1bafa8cd0579@kernel.org>
Date: Sat, 21 May 2016 17:27:16 +0100
MIME-Version: 1.0
In-Reply-To: <CAKzfze_7C-WWy0NUtgAEj5XYZ-qUmMWxEOVV8-F9haU=CW_tLQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 20/05/16 18:34, Matt Ranostay wrote:
> On Fri, May 20, 2016 at 10:05 AM, Alison Schofield <amsfield22@gmail.com> wrote:
>> hdc100x supports Texas Instruments HDC1000 and HDC1008 relative
>> humidity and temperature sensors. Add these product names to
>> Kconfig and to the drivers device id structure to enable finding
>> the product by name and using it to add a device.
>>
>> Signed-off-by: Alison Schofield <amsfield22@gmail.com>
>> Cc: Daniel Baluta <daniel.baluta@gmail.com>
>> ---
>>  drivers/iio/humidity/Kconfig   | 8 ++++----
>>  drivers/iio/humidity/hdc100x.c | 2 ++
>>  2 files changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/iio/humidity/Kconfig b/drivers/iio/humidity/Kconfig
>> index 738a86d..f155386 100644
>> --- a/drivers/iio/humidity/Kconfig
>> +++ b/drivers/iio/humidity/Kconfig
>> @@ -26,11 +26,11 @@ config HDC100X
>>         tristate "TI HDC100x relative humidity and temperature sensor"
>>         depends on I2C
>>         help
>> -        Say yes here to build support for the TI HDC100x series of
>> -        relative humidity and temperature sensors.
>> +         Say yes here to build support for the Texas Instruments
>> +         HDC1000 and HDC1008 relative humidity and temperature sensors.
>>
>> -        To compile this driver as a module, choose M here: the module
>> -        will be called hdc100x.
>> +         To compile this driver as a module, choose M here: the module
>> +         will be called hdc100x.
>>
>>  config HTU21
>>         tristate "Measurement Specialties HTU21 humidity & temperature sensor"
>> diff --git a/drivers/iio/humidity/hdc100x.c b/drivers/iio/humidity/hdc100x.c
>> index fa47676..0deb874 100644
>> --- a/drivers/iio/humidity/hdc100x.c
>> +++ b/drivers/iio/humidity/hdc100x.c
>> @@ -302,6 +302,8 @@ static int hdc100x_probe(struct i2c_client *client,
>>
>>  static const struct i2c_device_id hdc100x_id[] = {
>>         { "hdc100x", 0 },
>> +       { "hdc1000", 0 },
>> +       { "hdc1008", 0 },
> 
> Personally I think adding more device ids that don't add any per chip
> configuration is just adding clutter.
> There is a reason I used "hdc100x" when I wrote the driver :)
Hmm. I should have picked up on this in the first place. It's much preferred to
go with complete part names.  Avoids any possible issues with devicetrees / ACPI
bindings where it's kind of assumed a whole part name will be used.

I'd prefer to have them explicitly listed.  We will have to keep the wild card
form as well as by now there will be boards using that out there.
If it was just internal to the kernel I'd agree with the clutter argument, but
it isn't so let us be as explicit in the naming as possible.

Jonathan
> 
> 
>>         { }
>>  };
>>  MODULE_DEVICE_TABLE(i2c, hdc100x_id);
>> --
>> 2.1.4
>>

