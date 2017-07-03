Return-Path: <SRS0=jetz=6G=gmail.com=angelo.compagnucci@kernel.org>
MIME-Version: 1.0
In-Reply-To: <75f6c20fc2ebd80ed104918ef8e1d179@kernel.org>
References: <1498687088-28529-1-git-send-email-angelo.compagnucci@gmail.com>
 <1498687088-28529-2-git-send-email-angelo.compagnucci@gmail.com>
 <20170701110729.767ec879@kernel.org> <74402be2661eab70db7bbdce58723a18@vanmierlo.com>
 <d3fcf10b92ae50e1870f62b6c8c77b70@kernel.org> <ee3cc02ddcee31a154f6057ea466e1ed@vanmierlo.com>
 <75f6c20fc2ebd80ed104918ef8e1d179@kernel.org>
From: Angelo Compagnucci <angelo.compagnucci@gmail.com>
Date: Mon, 3 Jul 2017 23:04:10 +0200
Message-ID: <CA+TH9Vmr7Z3ke2kaCjUwTx=6D=a=fGBo9zGz_QSNe2Xdrx6mBA@mail.gmail.com>
Subject: Re: [PATCH 2/3] iio: adc: mcp3422: Checking for error on probe
To: Jonathan Cameron <jic23@kernel.org>
Cc: Maarten Brock <m.brock@vanmierlo.com>, linux-iio <linux-iio@vger.kernel.org>,
	Wolfram Sang <wsa@the-dreams.de>, Peter Rosin <peda@axentia.se>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

2017-07-03 14:25 GMT+02:00  <jic23@kernel.org>:
> On 03.07.2017 13:01, Maarten Brock wrote:
>>
>> On 2017-07-03 13:10, jic23@kernel.org wrote:
>>>
>>> On 03.07.2017 09:42, Maarten Brock wrote:
>>>>
>>>> On 2017-07-01 12:07, Jonathan Cameron wrote:
>>>>>
>>>>> On Wed, 28 Jun 2017 23:53:10 +0200
>>>>> Angelo Compagnucci <angelo.compagnucci@gmail.com> wrote:
>>>>>
>>>>>> Some part of the configuration are not touched after the probe
>>>>>> and if something goes wrong on writing the initial one,
>>>>>> the chip will misbehave.
>>>>>> Adding an error checking ensures that the inital configuration will
>>>>>> be written correctly. Moreover ensures that a sensible configuration
>>>>>> will be saved in driver data and used subsequently as intended.
>>>>>
>>>>>
>>>>> Jonathan
>>>>
>>>>
>>>> Would this fix mean that loading the driver fails if the update_config
>>>> fails? And thus if the driver is not a module, would require a reboot
>>>> of the OS?
>>>
>>> Hmm. This is difficult to handle.  If we were waiting on another resource
>>> coming up that was reflected by the load of a later driver, we 'could'
>>> use deferred probing. Is that true here?
>>>
>>> Wolfram, any thoughts - the issue here is that the i2c bus master is
>>> implemented on an FPGA which hasn't necessarily started by the time this
>>> driver fires up.
>>
>>
>> In my case it wasn't the master that was implemented in the FPGA, but the
>> channel from the master to the pins. I guess if the master was implemented
>> in the FPGA and not loaded yet, the master driver would fail to load.
>
> Perhaps represent the FPGA explicitly as an i2c mux?  Kind of moves the
> problem
> without solving it, but at least represents the hardware architecture.
>>
>>
>>> I'm a little loath to put in a rather mysterious deferral if we don't
>>> need it.  The slave driver definitely feels like the wrong place to be
>>> doing
>>> this.
>>>
>>> What we should be looking at here I think is the i2c bus not being
>>> instantiated
>>> until the fpga is ready.  That way these slave devices wouldn't come up
>>> until somewhat later in the process and the driver probe will succeed.
>>
>>
>> I can envision other use-cases, like the device not yet being powered up.
>
> That should be explicitly represented as part of the devicetree or similar -
> i.e.
> the regulator state should be known or controlled.  Any initial power up
> time
> is usually handled by enforcing an appropriate sleep before talking to it in
> probe.
> Naturally there will always be weird special cases though where a small
> number of
> retries makes sense.
>>
>>
>>> We would normally only retry i2c transactions if we had either:
>>> * known flaky hardware - the sort of thing that fails once every 100
>>> times.
>>
>>
>> I would consider every I2C device in this category. Maybe not 1 in
>> 100, but not 1
>> in a million either. With open-drain instead of push-pull drivers and thus
>> a
>> relatively high impedance when signals are rising I would expect some
>> disturbance
>> every once in while. And this is most probably perfectly fine when taking
>> samples. But this fix expects the initialization to always pass when it
>> could
>> easily retry again later on and report an error to the application if it
>> still
>> fails.
>
> One for Wolfram rather than me.
>>
>>
>> One could even argue that at probe time this device needs no write to the
>> config
>> register at all. The driver will select the channel and PGA as necessary
>> anyway,
>> which is a good moment to set the CONTINOUS conversion bit unconditionally
>> as
>> well.
>
> That would work for me as an alternative solution.

I think that for this driver, the simplest solution to this problem
would be to set the adc->config during probe, cause this configuration
will be updated each time a channel is changed. Checking for error on
probe probably could be optional.

The only thing that bothers me is when a device is unconfigured cause
an error and a user tries to read a value without changing channel.

IMHO a driver should fail when loaded on a erratic hardware and the
probe should reflect the fact that the driver is loaded properly. I
had a look at other I2C device drivers (rtc, eeprom) and usually they
fails when not probed correctly.

In case a user needs a driver at a later time in booting, she should
use that driver as a module an load it at proper time.

Sincerely, Angelo.

>
>>
>> Maarten
>>
>>> * a known reason the device isn't responding (and not able to use
>>> clock stretching)
>>> So device is busy doing a conversion and ignores the bus during that.
>>>
>>> Jonathan
>>>
>>>> Seems like a rather steep requirement for something that can be so
>>>> easily fixed later on by e.g. caching an invalid config channel.
>>>> There's not even a single retry. And I don't suppose the I2C driver
>>>> will auto-retry either.
>>>>
>>>> Maarten
>>>>
>>>>>> ---
>>>>>>  drivers/iio/adc/mcp3422.c | 4 +++-
>>>>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/iio/adc/mcp3422.c b/drivers/iio/adc/mcp3422.c
>>>>>> index 6737df8..63de705 100644
>>>>>> --- a/drivers/iio/adc/mcp3422.c
>>>>>> +++ b/drivers/iio/adc/mcp3422.c
>>>>>> @@ -382,7 +382,9 @@ static int mcp3422_probe(struct i2c_client
>>>>>> *client,
>>>>>>                 | MCP3422_CHANNEL_VALUE(0)
>>>>>>                 | MCP3422_PGA_VALUE(MCP3422_PGA_1)
>>>>>>                 | MCP3422_SAMPLE_RATE_VALUE(MCP3422_SRATE_240));
>>>>>> -       mcp3422_update_config(adc, config);
>>>>>> +       err = mcp3422_update_config(adc, config);
>>>>>> +       if (err < 0)
>>>>>> +               return err;
>>>>>>
>>>>>>         err = devm_iio_device_register(&client->dev, indio_dev);
>>>>>>         if (err < 0)
>>>>
>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Profile: http://it.linkedin.com/in/compagnucciangelo
