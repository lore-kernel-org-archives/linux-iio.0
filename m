Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:37849 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750981AbeDRTZi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Apr 2018 15:25:38 -0400
Received: by mail-io0-f196.google.com with SMTP id y128-v6so3787849iod.4
        for <linux-iio@vger.kernel.org>; Wed, 18 Apr 2018 12:25:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180415163101.6ab15cbc@archlinux>
References: <1523637411-8531-1-git-send-email-hernan@vanguardiasur.com.ar>
 <1523637411-8531-10-git-send-email-hernan@vanguardiasur.com.ar> <20180415163101.6ab15cbc@archlinux>
From: =?UTF-8?Q?Hern=C3=A1n_Gonzalez?= <hernan@vanguardiasur.com.ar>
Date: Wed, 18 Apr 2018 16:25:17 -0300
Message-ID: <CALfa3vGd0SG60mi4MBhfAUJkpD8h1e6odgbJ750C31vNO90Zig@mail.gmail.com>
Subject: Re: [PATCH v2 09/14] staging: iio: ad7746: Add remove()
To: Jonathan Cameron <jic23@kernel.org>
Cc: knaack.h@gmx.de, lars@metafoo.de,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        gregkh@linuxfoundation.org, Michael.Hennerich@analog.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Apr 15, 2018 at 12:31 PM, Jonathan Cameron <jic23@kernel.org> wrote=
:
> On Fri, 13 Apr 2018 13:36:46 -0300
> Hern=C3=A1n Gonzalez <hernan@vanguardiasur.com.ar> wrote:
>
>> This allows the driver to be probed and removed as a module powering it
>> down on remove().
>>
>> Signed-off-by: Hern=C3=A1n Gonzalez <hernan@vanguardiasur.com.ar>
>> ---
>>  drivers/staging/iio/cdc/ad7746.c | 26 ++++++++++++++++++++++++++
>>  1 file changed, 26 insertions(+)
>>
>> diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/=
ad7746.c
>> index c29a221..05506bf9 100644
>> --- a/drivers/staging/iio/cdc/ad7746.c
>> +++ b/drivers/staging/iio/cdc/ad7746.c
>> @@ -775,6 +775,31 @@ static int ad7746_probe(struct i2c_client *client,
>>       return 0;
>>  }
>>
>> +static int ad7746_remove(struct i2c_client *client)
>> +{
>> +     struct iio_dev *indio_dev =3D i2c_get_clientdata(client);
>> +     struct ad7746_chip_info *chip =3D iio_priv(indio_dev);
>> +     unsigned char regval;
>> +     int ret;
>> +
>> +     mutex_lock(&chip->lock);
>> +
>> +     regval =3D chip->config | AD7746_CONF_MODE_PWRDN;
>> +     ret =3D i2c_smbus_write_byte_data(chip->client, AD7746_REG_CFG, re=
gval);
> As this is a one off operation, perhaps it would be better to factor
> it out to a utility function then use devm_add_action_or_reset in
> the probe?
>
> Also, I am nervous about this change as there doesn't seem to be
> path in probe by which this is deliberately reversed?
> It seems to be 'accidentally' handled by the read_raw write to the
> CFG register.
>
> The data sheet doesn't really mention much about this register
> at all.  It may have special requirements to exit from power down - I hav=
e
> no idea, but if it is costless, why do we bother with idle mode?
>
> Perhaps Michael can confirm if this is safe to do or not.
>
>

I guess it'll be better to just drop this until Michael answers. I've
been trying to get a hold of the hw but with no success (or I have to
pay 3 times its cost in shipping), will keep searching though.

>> +
>> +     mutex_unlock(&chip->lock);
>> +
>> +     if (ret < 0) {
>> +             dev_warn(&client->dev, "Could NOT Power Down!\n");
>> +             goto out;
>> +     }
>> +
>> +     iio_device_unregister(indio_dev);
> You can't safely do this against the devm_iio_device_register.
>
>> +
>> +out:
>> +     return ret;
>> +}
>> +
>>  static const struct i2c_device_id ad7746_id[] =3D {
>>       { "ad7745", 7745 },
>>       { "ad7746", 7746 },
>> @@ -799,6 +824,7 @@ static struct i2c_driver ad7746_driver =3D {
>>               .of_match_table =3D of_match_ptr(ad7746_of_match),
>>       },
>>       .probe =3D ad7746_probe,
>> +     .remove =3D ad7746_remove,
>>       .id_table =3D ad7746_id,
>>  };
>>  module_i2c_driver(ad7746_driver);
>
