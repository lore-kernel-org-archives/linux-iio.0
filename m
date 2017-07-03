Return-Path: <SRS0=qyiE=6G=topicproducts.com=prvs=03571e9363=mike.looijmans@kernel.org>
Subject: Re: [PATCH 2/3] iio: adc: mcp3422: Checking for error on probe
To: Maarten Brock <m.brock@vanmierlo.com>, <jic23@kernel.org>
CC: Angelo Compagnucci <angelo.compagnucci@gmail.com>,
	<linux-iio@vger.kernel.org>, <wsa@the-dreams.de>
References: <1498687088-28529-1-git-send-email-angelo.compagnucci@gmail.com>
 <1498687088-28529-2-git-send-email-angelo.compagnucci@gmail.com>
 <20170701110729.767ec879@kernel.org>
 <74402be2661eab70db7bbdce58723a18@vanmierlo.com>
 <d3fcf10b92ae50e1870f62b6c8c77b70@kernel.org>
 <ee3cc02ddcee31a154f6057ea466e1ed@vanmierlo.com>
From: Mike Looijmans <mike.looijmans@topic.nl>
Message-ID: <c37ac5a1-7f55-dd41-74e4-de8325077f4a@topic.nl>
Date: Mon, 3 Jul 2017 14:11:56 +0200
MIME-Version: 1.0
In-Reply-To: <ee3cc02ddcee31a154f6057ea466e1ed@vanmierlo.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
List-ID: <linux-iio@vger.kernel.org>

=EF=BB=BFOn 03-07-17 14:01, Maarten Brock wrote:
> On 2017-07-03 13:10, jic23@kernel.org wrote:
>> On 03.07.2017 09:42, Maarten Brock wrote:
>>> On 2017-07-01 12:07, Jonathan Cameron wrote:
>>>> On Wed, 28 Jun 2017 23:53:10 +0200
>>>> Angelo Compagnucci <angelo.compagnucci@gmail.com> wrote:
>>>>
>>>>> Some part of the configuration are not touched after the probe
>>>>> and if something goes wrong on writing the initial one,
>>>>> the chip will misbehave.
>>>>> Adding an error checking ensures that the inital configuration will
>>>>> be written correctly. Moreover ensures that a sensible configuration
>>>>> will be saved in driver data and used subsequently as intended.
>>>>
>>>> Jonathan
>>>
>>> Would this fix mean that loading the driver fails if the update_config
>>> fails? And thus if the driver is not a module, would require a reboot
>>> of the OS?
>> Hmm. This is difficult to handle.  If we were waiting on another resourc=
e
>> coming up that was reflected by the load of a later driver, we 'could'
>> use deferred probing. Is that true here?
>>
>> Wolfram, any thoughts - the issue here is that the i2c bus master is
>> implemented on an FPGA which hasn't necessarily started by the time this
>> driver fires up.
>=20
> In my case it wasn't the master that was implemented in the FPGA, but the
> channel from the master to the pins. I guess if the master was implemente=
d
> in the FPGA and not loaded yet, the master driver would fail to load.

I've been using two methods for that:

(1) Build the driver as a module. On my platform, the FPGA is guaranteed to=
 be=20
ready when modules start to load (it loads the FPGA firmware during init=20
before starting the hotplug manager)

(2) Make the driver depend on a power-supply (or clock) that is "supplied"=
=20
once the FPGA powers up. Once way to accomplish this is to load that power=
=20
supply module after programming the FPGA. Because of (1) this just means to=
=20
build the powersupply as a module. This will defer the probe until the FGPA=
 is=20
ready.

>=20
>> I'm a little loath to put in a rather mysterious deferral if we don't
>> need it.  The slave driver definitely feels like the wrong place to be d=
oing
>> this.
>>
>> What we should be looking at here I think is the i2c bus not being insta=
ntiated
>> until the fpga is ready.  That way these slave devices wouldn't come up
>> until somewhat later in the process and the driver probe will succeed.
>=20
> I can envision other use-cases, like the device not yet being powered up.
>=20
>> We would normally only retry i2c transactions if we had either:
>> * known flaky hardware - the sort of thing that fails once every 100 tim=
es.
>=20
> I would consider every I2C device in this category. Maybe not 1 in 100, b=
ut not 1
> in a million either. With open-drain instead of push-pull drivers and thu=
s a
> relatively high impedance when signals are rising I would expect some dis=
turbance
> every once in while. And this is most probably perfectly fine when taking
> samples. But this fix expects the initialization to always pass when it c=
ould
> easily retry again later on and report an error to the application if it =
still
> fails.
>=20
> One could even argue that at probe time this device needs no write to the=
 config
> register at all. The driver will select the channel and PGA as necessary =
anyway,
> which is a good moment to set the CONTINOUS conversion bit unconditionall=
y as
> well.
>=20
> Maarten
>=20
>> * a known reason the device isn't responding (and not able to use
>> clock stretching)
>> So device is busy doing a conversion and ignores the bus during that.
>>
>> Jonathan
>>
>>> Seems like a rather steep requirement for something that can be so
>>> easily fixed later on by e.g. caching an invalid config channel.
>>> There's not even a single retry. And I don't suppose the I2C driver
>>> will auto-retry either.
>>>
>>> Maarten
>>>
>>>>> ---
>>>>>  drivers/iio/adc/mcp3422.c | 4 +++-
>>>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/iio/adc/mcp3422.c b/drivers/iio/adc/mcp3422.c
>>>>> index 6737df8..63de705 100644
>>>>> --- a/drivers/iio/adc/mcp3422.c
>>>>> +++ b/drivers/iio/adc/mcp3422.c
>>>>> @@ -382,7 +382,9 @@ static int mcp3422_probe(struct i2c_client *clien=
t,
>>>>>          | MCP3422_CHANNEL_VALUE(0)
>>>>>          | MCP3422_PGA_VALUE(MCP3422_PGA_1)
>>>>>          | MCP3422_SAMPLE_RATE_VALUE(MCP3422_SRATE_240));
>>>>> -    mcp3422_update_config(adc, config);
>>>>> +    err =3D mcp3422_update_config(adc, config);
>>>>> +    if (err < 0)
>>>>> +        return err;
>>>>>
>>>>>      err =3D devm_iio_device_register(&client->dev, indio_dev);
>>>>>      if (err < 0)
>>>
>>> --=20
>>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
> --=20
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



Kind regards,

Mike Looijmans
System Expert

TOPIC Products
Materiaalweg 4, NL-5681 RJ Best
Postbus 440, NL-5680 AK Best
Telefoon: +31 (0) 499 33 69 79
E-mail: mike.looijmans@topicproducts.com
Website: www.topicproducts.com

Please consider the environment before printing this e-mail
