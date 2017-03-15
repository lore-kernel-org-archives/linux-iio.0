Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58115 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752871AbdCOVuS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Mar 2017 17:50:18 -0400
Subject: Re: [PATCH 4/4] iio: accel: adxl345: Add support for triggered buffer
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Eva Rachel Retuya <eraretuya@gmail.com>
References: <1489403497-27849-1-git-send-email-eraretuya@gmail.com>
 <1489403497-27849-5-git-send-email-eraretuya@gmail.com>
 <CAHp75VefS18nAH3HkQgNdmo5oUWoaQ7ctj=eXHx9XjwrJtZzuQ@mail.gmail.com>
Cc: linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Daniel Baluta <daniel.baluta@gmail.com>,
        Alison Schofield <amsfield22@gmail.com>,
        Florian Vaussard <florian.vaussard@heig-vd.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <8da981ed-6ce0-0be5-6b56-c3c1ec0d5dab@kernel.org>
Date: Wed, 15 Mar 2017 21:50:15 +0000
MIME-Version: 1.0
In-Reply-To: <CAHp75VefS18nAH3HkQgNdmo5oUWoaQ7ctj=eXHx9XjwrJtZzuQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 13/03/17 12:16, Andy Shevchenko wrote:
> On Mon, Mar 13, 2017 at 1:11 PM, Eva Rachel Retuya <eraretuya@gmail.com> wrote:
>> Provide an all-axes read for triggered buffering.
> 
> Better description is needed.
> 
>> -static int adxl345_get_triple(struct adxl345_data *data, void *buf)
>> +static int adxl345_get_triple(struct adxl345_data *data)
> 
> Ping-ponging again. This should be essentially a change in the patch
> where you introduce a helper.
> 
>> +err_buffer_cleanup:
>> +       iio_triggered_buffer_cleanup(indio_dev);
>>  err_trigger_unregister:
>>         if (data->drdy_trig)
>>                 iio_trigger_unregister(data->drdy_trig);
> 
> devm_iio_*() ?
> 
>> @@ -334,6 +435,7 @@ int adxl345_core_remove(struct device *dev)
>>         struct adxl345_data *data = iio_priv(indio_dev);
>>
>>         iio_device_unregister(indio_dev);
>> +       iio_triggered_buffer_cleanup(indio_dev);
>>         if (data->drdy_trig)
>>                 iio_trigger_unregister(data->drdy_trig);
> 
> Ditto.
> 
>> diff --git a/drivers/iio/accel/adxl345_i2c.c b/drivers/iio/accel/adxl345_i2c.c
>> index 8c791b8..1e0f071 100644
>> --- a/drivers/iio/accel/adxl345_i2c.c
>> +++ b/drivers/iio/accel/adxl345_i2c.c
>> @@ -30,6 +30,10 @@ static int adxl345_i2c_probe(struct i2c_client *client,
>>         bool use_int2 = false;
>>         int irq;
>>
>> +       if (!i2c_check_functionality(client->adapter,
>> +                                    I2C_FUNC_SMBUS_READ_I2C_BLOCK))
>> +               return -EOPNOTSUPP;
> 
> And if driver works before, you make a regression here.
Absolutely. Need a fallback if it's not supported...

Jonathan
> 

