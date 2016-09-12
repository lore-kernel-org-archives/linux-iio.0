Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60960 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754477AbcILHVz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 12 Sep 2016 03:21:55 -0400
Subject: Re: [PATCH] iio: accel: Add driver for the mCube MC3230 3-axis
 accelerometer
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <20160911162907.22449-1-hdegoede@redhat.com>
 <alpine.DEB.2.02.1609111942500.28464@pmeerw.net>
 <95a718cc-24c0-dfe9-6745-e3d933ba384b@redhat.com>
 <alpine.DEB.2.02.1609112319380.18800@pmeerw.net>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <8c44e06e-a0e4-5a4e-c7c0-3f3ce8b0602d@redhat.com>
Date: Mon, 12 Sep 2016 09:21:48 +0200
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.02.1609112319380.18800@pmeerw.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

On 12-09-16 07:32, Peter Meerwald-Stadler wrote:
>
>>>> +static const struct iio_chan_spec mc3230_channels[] = {
>>>> +	MC3230_CHANNEL(MC3230_REG_XOUT, X),
>>>> +	MC3230_CHANNEL(MC3230_REG_YOUT, Y),
>>>> +	MC3230_CHANNEL(MC3230_REG_ZOUT, Z),
>>>> +};
>>>> +
>>>> +struct mc3230_data {
>>>> +	struct i2c_client *client;
>>>> +};
>
> probably don't need mc3230_data (or the client pointer within), not worth
> changing as likely stuff will be added in the future

I was thinking the same, but since iio does not use
set / get private_data but instead allocs private data
as part of devm_iio_device_alloc, this seemed cleaner then doing:

devm_iio_device_alloc(&client->dev, sizeof(struct i2c_client *));

And then doing somewhat ugly casts to retrieve the client pointer again.

>>>> +static int mc3230_set_opcon(struct mc3230_data *data, int opcon)
>>>> +{
>>>> +	int ret;
>>>> +	struct i2c_client *client = data->client;
>>>> +
>>>
>>> guess we want locking here
>>
>> This register only gets touched by this function, and this
>> function only gets called:
>>
>> -pre iio_device_register
>> -post iio_device_unregister
>> -on suspend/resume
>
>> So I do not see what it could race with.
>
> I didn't check where set_opcon() is actually called, seems safe
>
> I think there is a theoretic race in _remove() as _unregister() retval is
> not checked, no need to change

OK, I'll do a v2 adding the missing static then.

Regards,

Hans
