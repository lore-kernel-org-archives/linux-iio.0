Return-Path: <SRS0=oV0N=HI=analog.com=Michael.Hennerich@kernel.org>
Reply-To: <michael.hennerich@analog.com>
Subject: Re: [PATCH v2 09/14] staging: iio: ad7746: Add remove()
To: =?UTF-8?Q?Hern=c3=a1n_Gonzalez?= <hernan@vanguardiasur.com.ar>, "Jonathan
 Cameron" <jic23@kernel.org>
CC: <knaack.h@gmx.de>, <lars@metafoo.de>, Peter Meerwald-Stadler
	<pmeerw@pmeerw.net>, <gregkh@linuxfoundation.org>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1523637411-8531-1-git-send-email-hernan@vanguardiasur.com.ar>
 <1523637411-8531-10-git-send-email-hernan@vanguardiasur.com.ar>
 <20180415163101.6ab15cbc@archlinux>
 <CALfa3vGd0SG60mi4MBhfAUJkpD8h1e6odgbJ750C31vNO90Zig@mail.gmail.com>
From: Michael Hennerich <michael.hennerich@analog.com>
Message-ID: <636ebba6-8597-eb84-6321-11a01cc2862b@analog.com>
Date: Thu, 19 Apr 2018 11:14:47 +0200
MIME-Version: 1.0
In-Reply-To: <CALfa3vGd0SG60mi4MBhfAUJkpD8h1e6odgbJ750C31vNO90Zig@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 18.04.2018 21:25, Hernán Gonzalez wrote:
> On Sun, Apr 15, 2018 at 12:31 PM, Jonathan Cameron <jic23@kernel.org> wrote:
>> On Fri, 13 Apr 2018 13:36:46 -0300
>> Hernán Gonzalez <hernan@vanguardiasur.com.ar> wrote:
>>
>>> This allows the driver to be probed and removed as a module powering it
>>> down on remove().
>>>
>>> Signed-off-by: Hernán Gonzalez <hernan@vanguardiasur.com.ar>
>>> ---
>>>   drivers/staging/iio/cdc/ad7746.c | 26 ++++++++++++++++++++++++++
>>>   1 file changed, 26 insertions(+)
>>>
>>> diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
>>> index c29a221..05506bf9 100644
>>> --- a/drivers/staging/iio/cdc/ad7746.c
>>> +++ b/drivers/staging/iio/cdc/ad7746.c
>>> @@ -775,6 +775,31 @@ static int ad7746_probe(struct i2c_client *client,
>>>        return 0;
>>>   }
>>>
>>> +static int ad7746_remove(struct i2c_client *client)
>>> +{
>>> +     struct iio_dev *indio_dev = i2c_get_clientdata(client);
>>> +     struct ad7746_chip_info *chip = iio_priv(indio_dev);
>>> +     unsigned char regval;
>>> +     int ret;
>>> +
>>> +     mutex_lock(&chip->lock);
>>> +
>>> +     regval = chip->config | AD7746_CONF_MODE_PWRDN;
>>> +     ret = i2c_smbus_write_byte_data(chip->client, AD7746_REG_CFG, regval);
>> As this is a one off operation, perhaps it would be better to factor
>> it out to a utility function then use devm_add_action_or_reset in
>> the probe?
>>
>> Also, I am nervous about this change as there doesn't seem to be
>> path in probe by which this is deliberately reversed?
>> It seems to be 'accidentally' handled by the read_raw write to the
>> CFG register.
>>
>> The data sheet doesn't really mention much about this register
>> at all.  It may have special requirements to exit from power down - I have
>> no idea, but if it is costless, why do we bother with idle mode?
>>
>> Perhaps Michael can confirm if this is safe to do or not.
>>
>>
> 
> I guess it'll be better to just drop this until Michael answers. I've
> been trying to get a hold of the hw but with no success (or I have to
> pay 3 times its cost in shipping), will keep searching though.


It's some time since I last worked with the device. I think it would be 
safe to restore the power on default in the configuration register upon 
probe. Which would be idle state. Besides a unspecified delay, I don't 
think there is anything else to handle here. Due to fact it's not 
specified it might not be required at all.
If your planning to do further cleanup on this driver, I ship you an 
eval board free of charge. Feel free to contact me off-list.


> 
>>> +
>>> +     mutex_unlock(&chip->lock);
>>> +
>>> +     if (ret < 0) {
>>> +             dev_warn(&client->dev, "Could NOT Power Down!\n");
>>> +             goto out;
>>> +     }
>>> +
>>> +     iio_device_unregister(indio_dev);
>> You can't safely do this against the devm_iio_device_register.
>>
>>> +
>>> +out:
>>> +     return ret;
>>> +}
>>> +
>>>   static const struct i2c_device_id ad7746_id[] = {
>>>        { "ad7745", 7745 },
>>>        { "ad7746", 7746 },
>>> @@ -799,6 +824,7 @@ static struct i2c_driver ad7746_driver = {
>>>                .of_match_table = of_match_ptr(ad7746_of_match),
>>>        },
>>>        .probe = ad7746_probe,
>>> +     .remove = ad7746_remove,
>>>        .id_table = ad7746_id,
>>>   };
>>>   module_i2c_driver(ad7746_driver);
>>
> 


-- 
Greetings,
Michael

--
Analog Devices GmbH      Otl-Aicher Strasse 60-64      80807 München
Sitz der Gesellschaft München, Registergericht München HRB 40368,
Geschäftsführer: Peter Kolberg, Ali Raza Husain, Eileen Wynne
