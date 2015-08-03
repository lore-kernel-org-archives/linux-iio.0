Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-139.synserver.de ([212.40.185.139]:1120 "EHLO
	smtp-out-139.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751605AbbHCIAd (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 3 Aug 2015 04:00:33 -0400
Message-ID: <55BF1F9D.30207@metafoo.de>
Date: Mon, 03 Aug 2015 10:00:29 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Matt Ranostay <mranostay@gmail.com>
CC: =?UTF-8?B?TWFyZWsgVmHFoXV0?= <marex@denx.de>,
	Matt Porter <matt@ohporter.com>,
	Pantelis Antoniou <pantelis.antoniou@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: proximity: add support for PulsedLight LIDAR
References: <1438401484-22101-1-git-send-email-mranostay@gmail.com>	<1438401484-22101-3-git-send-email-mranostay@gmail.com>	<55BDE5F8.9090201@metafoo.de> <CAKzfze_ZNeSBo_hKn4ju1uNM4iyaFrvGo89Dv_80DK3Tfb24yg@mail.gmail.com>
In-Reply-To: <CAKzfze_ZNeSBo_hKn4ju1uNM4iyaFrvGo89Dv_80DK3Tfb24yg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/02/2015 11:28 PM, Matt Ranostay wrote:
> On Sun, Aug 2, 2015 at 2:42 AM, Lars-Peter Clausen <lars@metafoo.de> wrote:
>> On 08/01/2015 05:58 AM, Matt Ranostay wrote:
>> [...]
>>> +
>>> +struct lidar_data {
>>> +     struct mutex lock;
>>> +     struct iio_dev *indio_dev;
>>> +     struct i2c_client *client;
>>> +
>>> +     /* config */
>>> +     int calib_bias;
>>> +
>>> +     u16 buffer[5]; /* 2 byte distance + 8 byte timestamp */
>>
>> Needs to be in its own cacheline to avoid issues if the I2C controller is
>> using DMA.
> 
> Ah though this was only needed for SPI.

At least some I2C master drivers directly use the buffer for DMA. But I was
being stupid here anyway, you don't actually pass the buffer itself to the
I2C transfer functions so everything is fine as it was.

> 
>>
>>         u16 buffer[5] ____cacheline_aligned;
>>
>>> +};
>> [...]
>>> +static inline int lidar_read_byte(struct lidar_data *data, int reg)
>>
>> I'd drop the inline. The compiler is smart enough to figure out whether it
>> makes sense to inline it or not.
>>
> Got it.
> 
>>> +{
>>> +     struct i2c_client *client = data->client;
>>> +     int ret;
>>> +
>>> +     ret = i2c_smbus_write_byte(client, reg);
>>> +     if (ret < 0) {
>>> +             dev_err(&client->dev, "cannot write addr value");
>>> +             return ret;
>>> +     }
>>> +
>>> +     ret = i2c_smbus_read_byte(client);
>>> +     if (ret < 0) {
>>> +             dev_err(&client->dev, "cannot read data value");
>>> +             return ret;
>>> +     }
>>
>> Instead of using a write_byte/read_byte combination rather use
>> i2c_smbus_read_byte_data(). I think that will do the same, but in one atomic
>> operation.
> Yes I would normally do that but this device doesn't seem to support
> that functionally, always returns zeros.

That's an interesting device. Maybe add a comment explaining the oddity. I'm
sure I'm not the only one who'll wonder about this.

[...]
>>> +static struct i2c_driver lidar_driver = {
>>> +     .driver = {
>>> +             .name   = LIDAR_DRV_NAME,
>>> +             .owner  = THIS_MODULE,
>>
>> You added a DT vendor prefix, but there is no of match table for the driver.
> 
> So without of_match_table it isn't needed to have a vendor id?
> "pulsedlight,lidar" maps to the i2c_device_id

I thinking the other way around. If you intend to instantiate the device via
devicetree it is better to explicit add a of_device_id table rather than
relying on the implicit mechanism that uses i2c_device_id.

You should also add an entry for the device to
Documentation/devicetree/bindings/i2c/trivial-devices.txt

