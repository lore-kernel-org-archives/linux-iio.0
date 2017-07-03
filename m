Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42078 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752233AbdGCLKF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Jul 2017 07:10:05 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Mon, 03 Jul 2017 12:10:04 +0100
From: jic23@kernel.org
To: Maarten Brock <m.brock@vanmierlo.com>
Cc: Angelo Compagnucci <angelo.compagnucci@gmail.com>,
        linux-iio@vger.kernel.org, wsa@the-dreams.de
Subject: Re: [PATCH 2/3] iio: adc: mcp3422: Checking for error on probe
In-Reply-To: <74402be2661eab70db7bbdce58723a18@vanmierlo.com>
References: <1498687088-28529-1-git-send-email-angelo.compagnucci@gmail.com>
 <1498687088-28529-2-git-send-email-angelo.compagnucci@gmail.com>
 <20170701110729.767ec879@kernel.org>
 <74402be2661eab70db7bbdce58723a18@vanmierlo.com>
Message-ID: <d3fcf10b92ae50e1870f62b6c8c77b70@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03.07.2017 09:42, Maarten Brock wrote:
> On 2017-07-01 12:07, Jonathan Cameron wrote:
>> On Wed, 28 Jun 2017 23:53:10 +0200
>> Angelo Compagnucci <angelo.compagnucci@gmail.com> wrote:
>> 
>>> Some part of the configuration are not touched after the probe
>>> and if something goes wrong on writing the initial one,
>>> the chip will misbehave.
>>> Adding an error checking ensures that the inital configuration will
>>> be written correctly. Moreover ensures that a sensible configuration
>>> will be saved in driver data and used subsequently as intended.
>>> 
>>> Signed-off-by: Angelo Compagnucci <angelo.compagnucci@gmail.com>
>> Applied to the togreg branch of iio.git and pushed out as testing.
>> Added a reported by for Maarten.
> 
> Thanks. Also for the CC as I'm not (yet) subscribed to this list.
> 
>> 
>> Jonathan
> 
> Would this fix mean that loading the driver fails if the update_config
> fails? And thus if the driver is not a module, would require a reboot
> of the OS?
Hmm. This is difficult to handle.  If we were waiting on another 
resource
coming up that was reflected by the load of a later driver, we 'could'
use deferred probing. Is that true here?

Wolfram, any thoughts - the issue here is that the i2c bus master is
implemented on an FPGA which hasn't necessarily started by the time this
driver fires up.

I'm a little loath to put in a rather mysterious deferral if we don't
need it.  The slave driver definitely feels like the wrong place to be 
doing
this.

What we should be looking at here I think is the i2c bus not being 
instantiated
until the fpga is ready.  That way these slave devices wouldn't come up
until somewhat later in the process and the driver probe will succeed.

We would normally only retry i2c transactions if we had either:
* known flaky hardware - the sort of thing that fails once every 100 
times.
* a known reason the device isn't responding (and not able to use clock 
stretching)
So device is busy doing a conversion and ignores the bus during that.

Jonathan

> Seems like a rather steep requirement for something that can be so
> easily fixed later on by e.g. caching an invalid config channel.
> There's not even a single retry. And I don't suppose the I2C driver
> will auto-retry either.
> 
> Maarten
> 
>>> ---
>>>  drivers/iio/adc/mcp3422.c | 4 +++-
>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>> 
>>> diff --git a/drivers/iio/adc/mcp3422.c b/drivers/iio/adc/mcp3422.c
>>> index 6737df8..63de705 100644
>>> --- a/drivers/iio/adc/mcp3422.c
>>> +++ b/drivers/iio/adc/mcp3422.c
>>> @@ -382,7 +382,9 @@ static int mcp3422_probe(struct i2c_client 
>>> *client,
>>>  		| MCP3422_CHANNEL_VALUE(0)
>>>  		| MCP3422_PGA_VALUE(MCP3422_PGA_1)
>>>  		| MCP3422_SAMPLE_RATE_VALUE(MCP3422_SRATE_240));
>>> -	mcp3422_update_config(adc, config);
>>> +	err = mcp3422_update_config(adc, config);
>>> +	if (err < 0)
>>> +		return err;
>>> 
>>>  	err = devm_iio_device_register(&client->dev, indio_dev);
>>>  	if (err < 0)
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
