Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:35695 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932618AbcCPS2Q (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 16 Mar 2016 14:28:16 -0400
MIME-Version: 1.0
In-Reply-To: <20160316162544.GA6212@x220>
References: <20160316113738.GB2445@x220>
	<alpine.DEB.2.02.1603161238590.30358@pmeerw.net>
	<20160316162544.GA6212@x220>
Date: Wed, 16 Mar 2016 20:28:14 +0200
Message-ID: <CAEnQRZAtpANGBsuYFuMD+tstrYc7YfeO117BYP-990vB144UbQ@mail.gmail.com>
Subject: Re: [PATCH] iio: add driver for Microchip MCP414X/416X/424X/426X
From: Daniel Baluta <daniel.baluta@gmail.com>
To: Slawomir Stepien <sst@poczta.fm>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Mar 16, 2016 at 6:25 PM, Slawomir Stepien <sst@poczta.fm> wrote:
> On Mar 16, 2016 13:30, Peter Meerwald-Stadler wrote:
>> On Wed, 16 Mar 2016, Slawomir Stepien wrote:
>>
>> > The following functionalities are supported:
>> >  - write, read from volatile and non volatile memory
>> >  - increase and decrease commands
>> >  - read from status register
>> >  - write and read to tcon register
>> >
>> > Datasheet: http://ww1.microchip.com/downloads/en/DeviceDoc/22059b.pdf
>
> Thank you for all your comments.
>
>> the driver naming is a mess: the subject says MCP414X, the file name is
>> mcp41xx, the DT compatible string says mcp4113x -- this does not match
>
> OK. I will change that to mcp414x in version 2.

Filename shouldn't be generic (e.g ending with xx). It should be a
specific chip name
(a good candidate is the first in alphabetical order), because there
could be chips falling
in the same name category but with a different driver.

>
>> plenty of the private API, some of which seems to be debug only?
>> what is really needed to interact with a poti?
>
> I wanted to export both the non volatile and volatile memory addresses for wiper
> position access. That is bare minimum for the poti to operate.
>
> But I also wanted to export additional features of this chip. That is way there
> is increase and decrease API, and STATUS and TCON register access.
>
> The memory_map API is a way to access all the not used by chip memory addresses.
> This API I think could be deleted. But I still think that some people might find
> it useful.
>
>> comments below
>>
>> > +File:      /sys/bus/iio/devices/../out_resistanceN_raw
>>
>> this is already described in sysfs-bus-iio
>
> Should I leave it and add reference to sysfs-bus-iio or delete it completely?
>
>> > +struct mcp41xx_cfg {
>> > +   unsigned long int devid;
>>
>> devid is not set/used
>
> That's true. Will fix it in v2.
>
>> > +static int mcp41xx_exec(struct mcp41xx_data *data,
>> > +           u8 addr, u8 cmd,
>> > +           int *trans, size_t n)
>>
>> should trans really be int, not u8?
>
> There is a need for 9 bit value write/read. I used int just for my convenience.
> However there is one piece of code missing now I see. I should check the value
> of tans[0] to see if it's > 256 or lower then 0. Will add it in v2.
>
> Using u8 will force additional bit operations. I could try using u16 to still
> have the option of parsing user input as 9 bit value (eg. 256 position).
>
>> > +{
>> > +   int err;
>> > +   struct spi_device *spi = data->spi;
>> > +
>> > +   /* Two bytes are needed for the response */
>> > +   if (n != 2)
>> > +           return -EINVAL;
>>
>> why pass n if it is always 2?
>
> Will fix in v2.
>
>> > +   err = devm_iio_device_register(&spi->dev, indio_dev);
>> > +   if (err) {
>> > +           dev_info(&spi->dev, "Unable to register %s", indio_dev->name);
>>
>> \n missing
>>
>> > +           return err;
>> > +   }
>> > +
>> > +   dev_info(&spi->dev, "Registered %s", indio_dev->name);
>>
>> \n
>>
>> > +
>> > +   return 0;
>> > +}
>> > +
>> > +static int mcp41xx_remove(struct spi_device *spi)
>> > +{
>> > +   struct iio_dev *indio_dev = spi_get_drvdata(spi);
>> > +   struct mcp41xx_data *data = iio_priv(indio_dev);
>> > +
>> > +   mutex_destroy(&data->lock);
>> > +   devm_iio_device_unregister(&spi->dev, indio_dev);
>> > +   kfree(mcp41xx_attributes);
>> > +
>> > +   dev_info(&spi->dev, "Unregistered %s", indio_dev->name);
>
> Also \n is missing here. Will fix in v2.
>
> --
> Slawomir Stepien
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
